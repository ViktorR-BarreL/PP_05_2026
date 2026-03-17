SELECT 
    co.nomer AS nomer_zakaza,
    SUM(
        oi.kolichestvo *
        sm.kolichestvo *
        c.cena
    ) AS polnaya_stoimost_zakaza
FROM customer_orders co
JOIN order_items oi ON oi.zakaz_id = co.id
JOIN specifikacii s ON s.produkt_id = oi.produkt_id
JOIN spec_materials sm ON sm.specifikaciya_id = s.id
JOIN (
    SELECT DISTINCT ON (nomenklatura_id) nomenklatura_id, cena
    FROM ceny
    ORDER BY nomenklatura_id, data_ustanovki DESC
) c ON c.nomenklatura_id = sm.material_id
GROUP BY co.id, co.nomer
ORDER BY co.nomer;