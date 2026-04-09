import sys, random, psycopg2
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *
from PyQt5.QtGui import *

def db(q, p=(), one=False, many=False):
    with psycopg2.connect(
        dbname="PP_05_2026", user="postgres",
        password="admin", host="localhost"
    ) as conn:
        with conn.cursor() as cur:
            cur.execute(q, p)
            if one: return cur.fetchone()
            if many: return cur.fetchall()

class User:
    @staticmethod
    def get(login):
        return db("""SELECT u.id,u.password,r.name,u.is_blocked,u.attempts
                     FROM users u JOIN roles r ON u.role_id=r.id
                     WHERE login=%s""", (login,), one=True)

    @staticmethod
    def exists(login):
        return db("SELECT 1 FROM users WHERE login=%s", (login,), one=True)

    @staticmethod
    def add(login, password, role):
        if User.exists(login): return False
        role_id = db("SELECT id FROM roles WHERE name=%s", (role,), one=True)[0]
        db("INSERT INTO users(login,password,role_id,attempts) VALUES(%s,%s,%s,0)",
           (login,password,role_id))
        return True

    @staticmethod
    def update(uid, login, password, role, blocked):
        role_id = db("SELECT id FROM roles WHERE name=%s", (role,), one=True)[0]

        if password:  # если НЕ пустой
            db("""UPDATE users 
                SET login=%s, password=%s, role_id=%s, is_blocked=%s
                WHERE id=%s""",
            (login, password, role_id, blocked, uid))
        else:  # если пустой → не трогаем пароль
            db("""UPDATE users 
                SET login=%s, role_id=%s, is_blocked=%s
                WHERE id=%s""",
            (login, role_id, blocked, uid))

    @staticmethod
    def unblock(uid):
        db("UPDATE users SET is_blocked=FALSE, attempts=0 WHERE id=%s", (uid,))

    @staticmethod
    def attempts(uid, val):
        db("UPDATE users SET attempts=%s WHERE id=%s", (val,uid))

    @staticmethod
    def block(uid):
        db("UPDATE users SET is_blocked=TRUE WHERE id=%s", (uid,))

    @staticmethod
    def reset(uid):
        db("UPDATE users SET attempts=0 WHERE id=%s", (uid,))

    @staticmethod
    def all():
        return db("""SELECT u.id,u.login,r.name,u.is_blocked
                     FROM users u JOIN roles r ON u.role_id=r.id""", many=True)

class CaptchaWidget(QWidget):
    def __init__(self, image_paths=None):
        super().__init__()
        self.piece_size = 150
        self.grid_size = 2
        paths = image_paths or ["1.png", "2.png", "3.png", "4.png"]

        self.pieces = []
        for path in paths:
            pix = QPixmap(path)
            if pix.isNull():
                raise FileNotFoundError(f"Image not found: {path}")
            self.pieces.append(
                pix.scaled(self.piece_size, self.piece_size,
                           Qt.KeepAspectRatio, Qt.SmoothTransformation)
            )

        self.rotations = [random.choice([0, 90, 180, 270]) for _ in self.pieces]
        self.init_ui()

    def init_ui(self):
        layout = QVBoxLayout()

        center = QHBoxLayout()
        center.addStretch()

        self.grid = QGridLayout()
        self.grid.setSpacing(0)
        self.grid.setContentsMargins(0, 0, 0, 0)

        center.addLayout(self.grid)
        center.addStretch()
        layout.addLayout(center)

        self.update_grid()

        hint = QLabel("Кликните по фрагменту,\nчтобы повернуть")
        hint.setAlignment(Qt.AlignCenter)
        hint.setWordWrap(True)
        hint.setStyleSheet("color: gray; font-size: 9pt;")
        layout.addWidget(hint)

        btn_layout = QHBoxLayout()
        btn_layout.addStretch()

        btn = QPushButton("Перемешать")
        btn.clicked.connect(self.reset_puzzle)
        btn_layout.addWidget(btn)

        btn_layout.addStretch()
        layout.addLayout(btn_layout)

        self.setLayout(layout)
        self.setFixedSize(self.piece_size * self.grid_size + 40,
                          self.piece_size * self.grid_size + 120)

    def update_grid(self):
        while self.grid.count():
            w = self.grid.takeAt(0).widget()
            if w:
                w.deleteLater()

        for i, pix in enumerate(self.pieces):
            label = QLabel()
            label.setPixmap(pix.transformed(QTransform().rotate(self.rotations[i])))
            label.setFixedSize(self.piece_size, self.piece_size)
            label.setStyleSheet("border: 1px solid #ccc;")
            label.mousePressEvent = self.create_click_handler(i)

            self.grid.addWidget(label, i // self.grid_size, i % self.grid_size)

    def create_click_handler(self, i):
        def handler(event):
            self.rotations[i] = (self.rotations[i] + 90) % 360
            self.update_grid()
        return handler

    def reset_puzzle(self):
        self.rotations = [random.choice([0, 90, 180, 270]) for _ in self.pieces]
        self.update_grid()

    def is_correct(self):
        return all(r == 0 for r in self.rotations)

class UserWindow(QWidget):
    def __init__(self, login, back):
        super().__init__()
        self.setWindowTitle("ООО Полесье - Пользователь")
        self.setMinimumSize(400,300)

        layout = QVBoxLayout(self)
        layout.addWidget(QLabel(f"Вы вошли как: {login}"))

        btn = QPushButton("Выход")
        btn.clicked.connect(lambda: self.logout(back))
        layout.addWidget(btn)

    def logout(self, back):
        self.close()
        back.reset_form()
        back.show()

class Admin(QWidget):
    def __init__(self, back):
        super().__init__()
        self.back = back
        self.setWindowTitle("ООО Полесье - Администрирование")
        self.setMinimumSize(800,600)

        layout = QVBoxLayout(self)

        self.table = QTableWidget(0,4)
        self.table.setHorizontalHeaderLabels(["ID","Логин","Роль","Блок"])
        layout.addWidget(self.table)

        btns = QHBoxLayout()

        add = QPushButton("Добавить")
        add.clicked.connect(self.add)

        edit = QPushButton("Редактировать")
        edit.clicked.connect(self.edit)

        unblock = QPushButton("Снять блокировку")
        unblock.clicked.connect(self.unblock)

        logout = QPushButton("Выход")
        logout.clicked.connect(self.logout)

        for b in (add, edit, unblock, logout):
            btns.addWidget(b)

        layout.addLayout(btns)
        self.load()

    def load(self):
        data = User.all()
        self.table.setRowCount(len(data))
        for i,row in enumerate(data):
            for j,val in enumerate(row):
                self.table.setItem(i,j,QTableWidgetItem(str(val)))

    def add(self):
        login, ok = QInputDialog.getText(self,"Логин","Введите логин")
        if not ok: return
        password, ok = QInputDialog.getText(self,"Пароль","Введите пароль")
        if not ok: return
        role, ok = QInputDialog.getItem(self,"Роль","Роль",["admin","user"],0,False)
        if not ok: return

        if User.add(login,password,role):
            QMessageBox.information(self,"Ок","Добавлен")
            self.load()
        else:
            QMessageBox.warning(self,"Ошибка","Пользователь уже существует")

    def edit(self):
        row = self.table.currentRow()
        if row < 0: return

        uid = int(self.table.item(row,0).text())
        login = self.table.item(row,1).text()
        role = self.table.item(row,2).text()
        blocked = self.table.item(row,3).text() == 'True'

        new_login, ok = QInputDialog.getText(self,"Логин","Логин", text=login)
        if not ok: return
        new_pass, ok = QInputDialog.getText(self,"Пароль","Пароль (оставить пустым, чтобы не менять)")
        if not ok: return
        new_role, ok = QInputDialog.getItem(self,"Роль","Роль",["admin","user"],0,False)
        if not ok: return

        User.update(uid, new_login, new_pass, new_role, blocked)
        self.load()

    def unblock(self):
        row = self.table.currentRow()
        if row < 0: return
        uid = int(self.table.item(row,0).text())
        User.unblock(uid)
        self.load()

    def logout(self):
        self.close()
        self.back.reset_form()
        self.back.show()

class Login(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("ООО Полесье - Авторизация")
        self.setMinimumSize(600,700)

        layout = QVBoxLayout(self)

        self.login = QLineEdit()
        self.login.setPlaceholderText("Логин")
        self.password = QLineEdit()
        self.password.setPlaceholderText("Пароль")
        self.password.setEchoMode(QLineEdit.Password)

        self.cap = CaptchaWidget(["1.png", "2.png", "3.png", "4.png"])

        btn = QPushButton("Войти")
        btn.clicked.connect(self.auth)

        layout.addWidget(self.login)
        layout.addWidget(self.password)
        layout.addWidget(self.cap)
        layout.addWidget(btn)

    def fail(self, uid, att, role, msg):
        att += 1
        User.attempts(uid, att)

        if att >= 3:
            if role != "admin":  # не блокируем админа, а то потом не разблокировать
                User.block(uid)
                QMessageBox.warning(self,"Ошибка","Вы заблокированы. Обратитесь к администратору")
            else:
                User.reset(uid)
                QMessageBox.warning(self,"Ошибка","Неверные данные")
            return True

        QMessageBox.warning(self,"Ошибка",msg)
        return False

    def auth(self):
        login = self.login.text().strip()
        password = self.password.text()

        if not login or not password:
            QMessageBox.warning(self,"Ошибка","Заполните поля")
            return

        user = User.get(login)
        if not user:
            QMessageBox.warning(self,"Ошибка",
                "Вы ввели неверный логин или пароль. Пожалуйста проверьте ещё раз введенные данные")
            return

        uid, db_pass, role, blocked, att = user

        if blocked:
            QMessageBox.warning(self,"Ошибка","Вы заблокированы. Обратитесь к администратору")
            return

        if not self.cap.is_correct():
            if self.fail(uid, att, role, "Капча неверна"): return
            self.cap.reset_puzzle()
            return

        if password != db_pass:
            if self.fail(uid, att, role,
                "Вы ввели неверный логин или пароль. Пожалуйста проверьте ещё раз введенные данные"):
                return
            self.cap.reset_puzzle()
            return

        User.reset(uid)
        QMessageBox.information(self,"Успех","Вы успешно авторизовались")

        if role == "admin":
            self.next = Admin(self)
        else:
            self.next = UserWindow(login, self)
            
        self.next.show()
        self.hide()

    def reset_form(self):
        self.login.clear()
        self.password.clear()
        self.cap.reset_puzzle()

app = QApplication(sys.argv)

try:
    db("SELECT 1")
except Exception as e:
    QMessageBox.critical(None,"Ошибка",str(e))
    sys.exit()

w = Login()
w.show()

sys.exit(app.exec())
