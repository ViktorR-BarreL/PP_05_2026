import sys
import random
import psycopg2
from PyQt6.QtWidgets import *
from PyQt6.QtGui import *
from PyQt6.QtCore import *

def get_connection():
    return psycopg2.connect(
        dbname="PP_05_2026",
        user="postgres",
        password="admin",
        host="localhost",
        port="5432"
    )

# Работа с данными пользователей
class UserModel:

    @staticmethod
    def get_user(login):
        conn = get_connection()
        cur = conn.cursor()
        cur.execute('''
            SELECT u.id, u.login, u.password, r.name, u.is_blocked, u.attempts
            FROM users u
            JOIN roles r ON u.role_id = r.id
            WHERE u.login = %s
        ''', (login,))
        user = cur.fetchone()
        conn.close()
        return user

    @staticmethod
    def update_attempts(user_id, attempts):
        conn = get_connection()
        cur = conn.cursor()
        cur.execute("UPDATE users SET attempts=%s WHERE id=%s", (attempts, user_id))
        conn.commit()
        conn.close()

    @staticmethod
    def block_user(user_id):
        conn = get_connection()
        cur = conn.cursor()
        cur.execute("""
            SELECT r.name FROM users u
            JOIN roles r ON u.role_id = r.id
            WHERE u.id = %s
        """, (user_id,))
        role = cur.fetchone()
        
        if role and role[0] == 'admin': # Администратор не блокируется
            conn.close()
            return False
            
        cur.execute("UPDATE users SET is_blocked=TRUE WHERE id=%s", (user_id,))
        conn.commit()
        conn.close()
        return True

    @staticmethod
    def reset_attempts(user_id):
        conn = get_connection()
        cur = conn.cursor()
        cur.execute("UPDATE users SET attempts=0 WHERE id=%s", (user_id,))
        conn.commit()
        conn.close()

    @staticmethod
    def get_all_users():
        conn = get_connection()
        cur = conn.cursor()
        cur.execute("""
            SELECT users.id, users.login, roles.name, users.is_blocked
            FROM users
            JOIN roles ON users.role_id = roles.id
            ORDER BY users.id
        """)
        data = cur.fetchall()
        conn.close()
        return data

    @staticmethod
    def add_user(login, password, role_name):
        conn = get_connection()
        cur = conn.cursor()
        try:
            cur.execute("SELECT id FROM roles WHERE name = %s", (role_name,))
            role_id = cur.fetchone()
            if not role_id:
                return False
                
            cur.execute(
                "INSERT INTO users (login, password, role_id, attempts) VALUES (%s, %s, %s, 0)",
                (login, password, role_id[0])
            )
            conn.commit()
            return True
        except psycopg2.IntegrityError:
            conn.rollback()
            return False
        finally:
            conn.close()

    
    @staticmethod
    def get_roles():
        try:
            conn = get_connection()
            cursor = conn.cursor()
            
            cursor.execute("SELECT id, name FROM roles ORDER BY id")
            roles = cursor.fetchall()
            
            cursor.close()
            conn.close()
            
            return roles
        
        except Exception as e:
            print("Ошибка получения ролей:", e)
            return []

    @staticmethod
    def update_user(user_id, login, password, role_name):
        conn = get_connection()
        cur = conn.cursor()
        try:
            cur.execute("SELECT id FROM roles WHERE name = %s", (role_name,))
            role_id = cur.fetchone()[0]
            
            cur.execute(
                "UPDATE users SET login=%s, password=%s, role_id=%s WHERE id=%s",
                (login, password, role_id, user_id)
            )
            conn.commit()
            return True
        except:
            conn.rollback()
            return False
        finally:
            conn.close()

    @staticmethod
    def unblock_user(user_id):
        conn = get_connection()
        cur = conn.cursor()
        cur.execute("UPDATE users SET is_blocked=FALSE, attempts=0 WHERE id=%s", (user_id,))
        conn.commit()
        conn.close()
    
    @staticmethod
    def delete_user(user_id):
        conn = get_connection()
        cur = conn.cursor()
        cur.execute("""
            SELECT r.name FROM users u
            JOIN roles r ON u.role_id = r.id
            WHERE u.id = %s
        """, (user_id,))
        role = cur.fetchone()
        
        if role and role[0] == 'admin': # Администратора нельзя удалить
            conn.close()
            return False
            
        cur.execute("DELETE FROM users WHERE id=%s", (user_id,))
        conn.commit()
        conn.close()
        return True

# Капча в виде пазла
class CaptchaWidget(QWidget):
    def __init__(self, image_paths=None):
        super().__init__()
        
        self.piece_size = 100
        self.grid_size = 2
        
        if image_paths is None:
            self.image_paths = ["1.png", "2.png", "3.png", "4.png"]
        else:
            self.image_paths = image_paths
        
        self.original_images = []
        for path in self.image_paths:
            pixmap = QPixmap(path)
            if pixmap.isNull():
                raise FileNotFoundError(f"Image not found: {path}")
            self.original_images.append(pixmap)
        
        self.pieces = []
        for img in self.original_images:
            scaled_img = img.scaled(self.piece_size, self.piece_size, 
                                    Qt.AspectRatioMode.KeepAspectRatio,
                                    Qt.TransformationMode.SmoothTransformation)
            self.pieces.append(scaled_img)
        
        self.correct_order = list(range(len(self.pieces)))
        self.current_order = self.correct_order.copy()
        random.shuffle(self.current_order)
        
        self.selected_index = -1
        self.init_ui()
    
    def init_ui(self):
        layout = QVBoxLayout()
        
        self.grid_layout = QGridLayout()
        self.grid_layout.setSpacing(0)
        self.update_puzzle_grid()
        layout.addLayout(self.grid_layout)
        
        self.hint_label = QLabel("Кликните на фрагмент, затем на другой для обмена")
        self.hint_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        self.hint_label.setStyleSheet("color: gray; font-size: 9px;")
        self.hint_label.setWordWrap(True)
        layout.addWidget(self.hint_label)
        
        self.setLayout(layout)
        self.setFixedSize(self.piece_size * self.grid_size + 20, 
                         self.piece_size * self.grid_size + 80)
        
        btn_layout = QHBoxLayout()
        self.reset_btn = QPushButton("Перемешать")
        self.reset_btn.clicked.connect(self.reset_puzzle)
        btn_layout.addWidget(self.reset_btn)
        
        layout.addLayout(btn_layout)
    
    def update_puzzle_grid(self):
        for i in reversed(range(self.grid_layout.count())):
            item = self.grid_layout.itemAt(i)
            if item and item.widget():
                item.widget().setParent(None)
        
        for idx, piece_idx in enumerate(self.current_order):
            row = idx // self.grid_size
            col = idx % self.grid_size
            
            label = QLabel()
            pixmap = self.pieces[piece_idx].scaled(
                self.piece_size, self.piece_size,
                Qt.AspectRatioMode.KeepAspectRatio,
                Qt.TransformationMode.SmoothTransformation
            )
            label.setPixmap(pixmap)
            label.setFixedSize(self.piece_size, self.piece_size)
            label.setStyleSheet("border: 1px solid #ccc;")
            
            label.piece_index = idx
            label.mousePressEvent = self.create_click_handler(idx)
            
            self.grid_layout.addWidget(label, row, col)
    
    def create_click_handler(self, idx):
        def handler(event):
            if self.selected_index == -1:
                self.selected_index = idx
                self.highlight_piece(idx, True)
            else:
                if self.selected_index != idx:
                    self.swap_pieces(self.selected_index, idx)
                    self.highlight_piece(self.selected_index, False)
                    self.selected_index = -1
                else:
                    self.highlight_piece(self.selected_index, False)
                    self.selected_index = -1
        return handler
    
    def highlight_piece(self, idx, highlight):
        row = idx // self.grid_size
        col = idx % self.grid_size
        item = self.grid_layout.itemAtPosition(row, col)
        if item and item.widget():
            if highlight:
                item.widget().setStyleSheet("border: 3px solid red;")
            else:
                item.widget().setStyleSheet("border: 1px solid #ccc;")
    
    def swap_pieces(self, idx1, idx2):
        self.current_order[idx1], self.current_order[idx2] = \
            self.current_order[idx2], self.current_order[idx1]
        self.update_puzzle_grid()
    
    def reset_puzzle(self):
        random.shuffle(self.current_order)
        self.selected_index = -1
        self.update_puzzle_grid()
    
    def is_correct(self):
        return self.current_order == self.correct_order


# Окно для пользователя с таблицей заказов и фильтрами
class UserWindow(QWidget):
    def __init__(self, login):
        super().__init__()
        
        self.setWindowTitle(f"ООО Молочный комбинат \"Полесье\" - Пользователь: {login}")
        self.setMinimumSize(1000, 600)
        
        layout = QVBoxLayout()
        
        welcome_label = QLabel(f"Добро пожаловать, {login}!")
        welcome_label.setFont(QFont("Segoe UI", 14, QFont.Weight.Bold))
        layout.addWidget(welcome_label)
        
        # Filter layout
        filter_layout = QHBoxLayout()
        
        # Customer filter
        filter_layout.addWidget(QLabel("Покупатель:"))
        self.customer_filter = QComboBox()
        self.customer_filter.addItem("Все покупатели")
        self.customer_filter.currentTextChanged.connect(self.load_orders)
        filter_layout.addWidget(self.customer_filter)
        
        filter_layout.addSpacing(20)
        
        filter_layout.addWidget(QLabel("Дата с:"))
        self.date_from = QDateEdit()
        self.date_from.setCalendarPopup(True)
        self.date_from.setDate(QDate.currentDate().addMonths(-1))
        self.date_from.setDisplayFormat("dd.MM.yyyy")
        self.date_from.dateChanged.connect(self.validate_dates)
        filter_layout.addWidget(self.date_from)

        filter_layout.addWidget(QLabel("по:"))
        self.date_to = QDateEdit()
        self.date_to.setCalendarPopup(True)
        self.date_to.setDate(QDate.currentDate())
        self.date_to.setDisplayFormat("dd.MM.yyyy")
        self.date_to.dateChanged.connect(self.validate_dates)
        filter_layout.addWidget(self.date_to)
        
        filter_layout.addStretch()
        
        btn_refresh = QPushButton("Обновить")
        btn_refresh.clicked.connect(self.load_orders)
        filter_layout.addWidget(btn_refresh)
        
        layout.addLayout(filter_layout)
        
        self.orders_table = QTableWidget()
        self.orders_table.setColumnCount(7)
        self.orders_table.setHorizontalHeaderLabels([
            "№ заказа", "Дата", "Покупатель", "ИНН", "Телефон", "Кол-во позиций", "Сумма заказа (руб.)"
        ])
        self.orders_table.horizontalHeader().setStretchLastSection(True)
        self.orders_table.setAlternatingRowColors(True)
        self.orders_table.setSelectionBehavior(QAbstractItemView.SelectionBehavior.SelectRows)
        layout.addWidget(self.orders_table)
        
        self.setLayout(layout)
        
        self.load_customers()
        self.load_orders()
    
    def validate_dates(self):
        if self.date_from.date() > self.date_to.date():
            self.date_from.setDate(self.date_to.date())
        self.load_orders()

    def load_customers(self):
        try:
            conn = get_connection()
            cur = conn.cursor()
            
            cur.execute("""
                SELECT DISTINCT k.naimenovanie
                FROM kontragenty k
                JOIN kontragent_tipy kt ON k.id = kt.kontragent_id
                JOIN tipy_kontragentov tk ON kt.tip_kontragenta_id = tk.id
                WHERE tk.kod = 'buyer'
                ORDER BY k.naimenovanie
            """)
            
            customers = cur.fetchall()
            conn.close()
            
            for customer in customers:
                self.customer_filter.addItem(customer[0])
                
        except Exception as e:
            QMessageBox.warning(self, "Ошибка", f"Не удалось загрузить покупателей: {str(e)}")
    
    def load_orders(self):
        try:
            conn = get_connection()
            cur = conn.cursor()
            
            selected_customer = self.customer_filter.currentText()
            date_from = self.date_from.date().toString("yyyy-MM-dd")
            date_to = self.date_to.date().toString("yyyy-MM-dd")
            
            query = """
                SELECT 
                    co.nomer,
                    co.data,
                    k.naimenovanie as customer_name,
                    k.inn,
                    k.telefon,
                    COUNT(oi.id) as item_count,
                    COALESCE(SUM(oi.kolichestvo * oi.cena), 0) as total_sum
                FROM customer_orders co
                JOIN kontragenty k ON co.zakazchik_id = k.id
                LEFT JOIN order_items oi ON co.id = oi.zakaz_id
                WHERE co.data BETWEEN %s AND %s
            """
            
            params = [date_from, date_to]
            
            if selected_customer != "Все покупатели":
                query += " AND k.naimenovanie = %s"
                params.append(selected_customer)
            
            query += """
                GROUP BY co.id, co.nomer, co.data, k.naimenovanie, k.inn, k.telefon
                ORDER BY co.data DESC
            """
            
            cur.execute(query, params)
            orders = cur.fetchall()
            conn.close()
            
            self.orders_table.setRowCount(len(orders))
            
            for i, row in enumerate(orders):
                for j, val in enumerate(row):
                    if j == 1 and val:
                        item = QTableWidgetItem(val.strftime('%d.%m.%Y'))
                    elif j == 6:
                        total = float(val)
                        item = QTableWidgetItem(f"{total:.2f}")
                        item.setTextAlignment(Qt.AlignmentFlag.AlignRight)
                    else:
                        item = QTableWidgetItem(str(val) if val else "—")
                    self.orders_table.setItem(i, j, item)
            
            self.orders_table.resizeColumnsToContents()
            
        except Exception as e:
            QMessageBox.warning(self, "Ошибка", f"Не удалось загрузить заказы: {str(e)}")

# Окно для администратора 
class AdminWindow(QWidget):
    def __init__(self):
        super().__init__()
        
        self.setWindowTitle("ООО Молочный комбинат \"Полесье\" - Администрирование")
        self.setMinimumSize(800, 500)
        
        layout = QVBoxLayout()
        
        self.table = QTableWidget()
        self.table.setColumnCount(4)
        self.table.setHorizontalHeaderLabels(["ID", "Логин", "Роль", "Заблокирован"])
        self.table.horizontalHeader().setStretchLastSection(True)
        self.table.setSelectionBehavior(QAbstractItemView.SelectionBehavior.SelectRows)
        layout.addWidget(self.table)
        
        form_group = QGroupBox("Управление пользователем")
        form_layout = QGridLayout()
        
        form_layout.addWidget(QLabel("Логин:"), 0, 0)
        self.login_edit = QLineEdit()
        self.login_edit.setPlaceholderText("Введите логин")
        form_layout.addWidget(self.login_edit, 0, 1)
        
        form_layout.addWidget(QLabel("Пароль:"), 1, 0)
        self.pass_edit = QLineEdit()
        self.pass_edit.setEchoMode(QLineEdit.EchoMode.Password)
        self.pass_edit.setPlaceholderText("Введите пароль")
        form_layout.addWidget(self.pass_edit, 1, 1)
        
        form_layout.addWidget(QLabel("Роль:"), 2, 0)
        self.role_combo = QComboBox()
        roles = UserModel.get_roles()

        for role_id, role_name in roles:
            self.role_combo.addItem(role_name, role_id)

        form_layout.addWidget(self.role_combo, 2, 1)
        
        btn_layout = QHBoxLayout()
        btn_add = QPushButton("Добавить")
        btn_add.clicked.connect(self.add_user)
        btn_update = QPushButton("Обновить")
        btn_update.clicked.connect(self.update_user)
        btn_unblock = QPushButton("Разблокировать")
        btn_unblock.clicked.connect(self.unblock_user)
        btn_delete = QPushButton("Удалить")
        btn_delete.clicked.connect(self.delete_user)
        btn_refresh = QPushButton("Обновить список")
        btn_refresh.clicked.connect(self.load_users)
        
        btn_layout.addWidget(btn_add)
        btn_layout.addWidget(btn_update)
        btn_layout.addWidget(btn_unblock)
        btn_layout.addWidget(btn_delete)
        btn_layout.addWidget(btn_refresh)
        
        form_layout.addLayout(btn_layout, 3, 0, 1, 2)
        form_group.setLayout(form_layout)
        layout.addWidget(form_group)
        
        self.setLayout(layout)
        
        self.table.itemClicked.connect(self.on_item_clicked)
        self.load_users()
    
    def load_users(self):
        data = UserModel.get_all_users()
        self.table.setRowCount(len(data))
        
        for i, row in enumerate(data):
            for j, val in enumerate(row):
                item = QTableWidgetItem(str(val))
                self.table.setItem(i, j, item)

        is_blocked = row[3]
        if is_blocked:
            for col in range(self.table.columnCount()):
                item = self.table.item(i, col)
                if item:
                    item.setBackground(QColor(100, 35, 35))
                    item.setForeground(QColor(0, 0, 0))
        
        self.table.resizeColumnsToContents()
    
    def on_item_clicked(self, item):
        row = item.row()
        self.login_edit.setText(self.table.item(row, 1).text())
        self.role_combo.setCurrentText(self.table.item(row, 2).text())
        self.pass_edit.clear()
    
    def add_user(self):
        login = self.login_edit.text().strip()
        password = self.pass_edit.text()
        role = self.role_combo.currentText()
        
        if not login or not password:
            QMessageBox.warning(self, "Ошибка", "Заполните логин и пароль!")
            return
        
        if UserModel.add_user(login, password, role):
            QMessageBox.information(self, "Успех", f"Пользователь {login} добавлен!")
            self.load_users()
            self.login_edit.clear()
            self.pass_edit.clear()
        else:
            QMessageBox.warning(self, "Ошибка", "Пользователь с таким логином уже существует!")
    
    def update_user(self):
        row = self.table.currentRow()
        if row < 0:
            QMessageBox.warning(self, "Ошибка", "Выберите пользователя для редактирования!")
            return
        
        user_id = int(self.table.item(row, 0).text())
        current_role = self.table.item(row, 2).text()
        login = self.login_edit.text().strip()
        password = self.pass_edit.text()
        role = self.role_combo.currentText()
        
        if not login or not password:
            QMessageBox.warning(self, "Ошибка", "Заполните логин и пароль!")
            return
        
        if current_role == 'admin' and (login != 'admin' or role != 'admin'):
            reply = QMessageBox.question(self, "Подтверждение", 
                                         "Вы редактируете администратора. Продолжить?",
                                         QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No)
            if reply == QMessageBox.StandardButton.No:
                return
        
        if UserModel.update_user(user_id, login, password, role):
            QMessageBox.information(self, "Успех", "Данные пользователя обновлены!")
            self.load_users()
        else:
            QMessageBox.warning(self, "Ошибка", "Не удалось обновить данные!")
    
    def unblock_user(self):
        row = self.table.currentRow()
        if row < 0:
            QMessageBox.warning(self, "Ошибка", "Выберите пользователя для разблокировки!")
            return
        
        user_id = int(self.table.item(row, 0).text())
        role = self.table.item(row, 2).text()
        
        if role == 'admin':
            QMessageBox.warning(self, "Ошибка", "Администратор не может быть заблокирован!")
            return
        
        UserModel.unblock_user(user_id)
        QMessageBox.information(self, "Успех", "Пользователь разблокирован!")
        self.load_users()
    
    def delete_user(self):
        row = self.table.currentRow()
        if row < 0:
            QMessageBox.warning(self, "Ошибка", "Выберите пользователя для удаления!")
            return
        
        user_id = int(self.table.item(row, 0).text())
        login = self.table.item(row, 1).text()
        role = self.table.item(row, 2).text()
        
        if role == 'admin':
            QMessageBox.warning(self, "Ошибка", "Администратора нельзя удалить!")
            return
        
        reply = QMessageBox.question(self, "Подтверждение", 
                                     f"Удалить пользователя {login}?",
                                     QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No)
        
        if reply == QMessageBox.StandardButton.Yes:
            if UserModel.delete_user(user_id):
                QMessageBox.information(self, "Успех", "Пользователь удален!")
                self.load_users()
            else:
                QMessageBox.warning(self, "Ошибка", "Не удалось удалить пользователя!")


# Окно авторизации
class LoginWindow(QWidget):
    def __init__(self):
        super().__init__()
        
        self.setWindowTitle("ООО Молочный комбинат \"Полесье\" - Авторизация")
        self.setFixedSize(450, 700)
        
        layout = QVBoxLayout()
        layout.setSpacing(15)
        layout.setContentsMargins(30, 30, 30, 30)
        
        title = QLabel("Вход в систему")
        title.setFont(QFont("Segoe UI", 18, QFont.Weight.Bold))
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)
        layout.addWidget(title)
        
        layout.addSpacing(20)
        
        layout.addWidget(QLabel("Логин:"))
        self.login = QLineEdit()
        self.login.setPlaceholderText("Введите логин")
        self.login.setMinimumHeight(35)
        layout.addWidget(self.login)
        
        layout.addWidget(QLabel("Пароль:"))
        self.password = QLineEdit()
        self.password.setEchoMode(QLineEdit.EchoMode.Password)
        self.password.setPlaceholderText("Введите пароль")
        self.password.setMinimumHeight(35)
        layout.addWidget(self.password)
        
        layout.addSpacing(10)
        
        layout.addWidget(QLabel("Соберите пазл:"))
        self.captcha = CaptchaWidget(["1.png", "2.png", "3.png", "4.png"])
        layout.addWidget(self.captcha, alignment=Qt.AlignmentFlag.AlignCenter)
        
        layout.addSpacing(10)
        
        btn = QPushButton("Войти")
        btn.clicked.connect(self.auth)
        btn.setMinimumHeight(40)
        layout.addWidget(btn)
        
        layout.addStretch()
        self.setLayout(layout)
        
        self.setTabOrder(self.login, self.password)
        self.setTabOrder(self.password, self.captcha)

    def auth(self):
        login = self.login.text().strip()
        password = self.password.text()
        
        if not login or not password:
            QMessageBox.warning(self, "Ошибка", "Заполните логин и пароль!")
            return
        
        user = UserModel.get_user(login)
        
        if not user:
            QMessageBox.warning(self, "Ошибка",
                "Вы ввели неверный логин или пароль. Пожалуйста проверьте ещё раз введенные данные")
            self.captcha.reset_puzzle()
            return
        
        user_id, _, db_pass, role, blocked, attempts = user
        
        if blocked and role != 'admin': # Администратор не блокируется
            QMessageBox.warning(self, "Ошибка", "Вы заблокированы. Обратитесь к администратору")
            return
        
        if not self.captcha.is_correct():
            if role != 'admin':
                attempts += 1
                UserModel.update_attempts(user_id, attempts)
                
                if attempts >= 3:
                    UserModel.block_user(user_id)
                    QMessageBox.warning(self, "Ошибка", "Вы заблокированы. Обратитесь к администратору")
                    return
            
            QMessageBox.warning(self, "Ошибка", "Пазл собран неверно!")
            self.captcha.reset_puzzle()
            return
        
        if password == db_pass:
            if role != 'admin':
                UserModel.reset_attempts(user_id)
            QMessageBox.information(self, "Успех", "Вы успешно авторизовались!")
            
            if role == "admin":
                self.admin_window = AdminWindow()
                self.admin_window.show()
            else:
                self.user_window = UserWindow(login)
                self.user_window.show()
            
            self.close()
        else:
            if role != 'admin':
                attempts += 1
                UserModel.update_attempts(user_id, attempts)
                
                if attempts >= 3:
                    UserModel.block_user(user_id)
                    QMessageBox.warning(self, "Ошибка", "Вы заблокированы. Обратитесь к администратору")
                    return
            
            QMessageBox.warning(self, "Ошибка",
                "Вы ввели неверный логин или пароль. Пожалуйста проверьте ещё раз введенные данные")
            self.captcha.reset_puzzle()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    
    try:
        get_connection()
    except Exception as e:
        QMessageBox.critical(None, "Ошибка", f"Не удалось подключиться к БД!\n{str(e)}")
        sys.exit(1)
    
    window = LoginWindow()
    window.show()
    
    sys.exit(app.exec())
