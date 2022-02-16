#Queries:
#1. Find the products of a brand located in Switzerland
SELECT 
    p.name, b.brand_name
FROM
    products AS p,
    brand AS b
WHERE
    b.brand_name = p.brandname
        AND b.address LIKE '%Switzerland%';
#2. Find the number of products whose quantity is more than 20.
SELECT 
    COUNT(quantity)
FROM
    products
WHERE
    products.quantity > 20;
#3.Find the id and the name of products sold on certain date
SELECT 
    p.product_id, p.name
FROM
    products AS p,
    invoice
WHERE
    invoice.product_id = p.product_id
        AND invoice.date = '2020-05-20';
#4.find all the names of employees who work as cashiers and the products they have sold
SELECT 
    e.employee_name, e.position, p.product_id, p.name
FROM
    employee AS e
join invoice i on e.employee_id=i.employee_id
join products p on p.product_id=i.product_id;
#5.Find the client with the highest points in that has bought a product from 'Hair Care' department from brand 'Pantene'
SELECT 
    mc.client_name, mc.points, d.name, p.name, b.brand_name
FROM
    membership_clients AS mc
join invoice as i on mc.client_id=i.client_id
join products as p on p.product_id=i.product_id
join department as d on p.department_id=d.department_id and d.name = 'Hair care'
join brand as b on b.brand_name= p.brandname and p.brandname='Pantene'
order by mc.points limit 1;
#6. Find number of clients who live in Mill Road
SELECT 
    COUNT(*), mc.client_name, mc.address
FROM
    membership_clients mc
WHERE
    mc.address LIKE '%Mill Road%';
#7.Find all products which expire in 2023 and their quantity is higher than 50 
SELECT 
    products.name, products.quantity
FROM
    products
WHERE
    expire_date LIKE '2023______'
        AND products.quantity > 30;
#9. Find the total number of products for each department
SELECT 
    COUNT(*) AS Number, 'First Department'
FROM
    products AS p
WHERE
    p.department_id = '01' 
UNION SELECT 
    COUNT(*), 'Second Department'
FROM
    products AS p
WHERE
    p.department_id = '02' 
UNION SELECT 
    COUNT(*), 'Third Department'
FROM
    products AS p
WHERE
    p.department_id = '03' 
UNION SELECT 
    COUNT(*), 'Forth Department'
FROM
    products AS p
WHERE
    p.department_id = '04' 
UNION SELECT 
    COUNT(*), 'Fifth Department'
FROM
    products AS p
WHERE
    p.department_id = '05';
#10. Display the employees and their managers and the department where they work 
SELECT 
    e.employee_name,
    d.name,
    d.manager_id,
    em.employee_name AS 'manager name'
FROM
    employee e
        JOIN
    department d ON d.department_id = e.department_id
        JOIN
    employee em ON em.employee_id = d.manager_id
WHERE
    em.position = 'manager';
#11.Display all products not included in an invoice
SELECT 
    products.name, price, product_id, quantity
FROM
    products
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            invoice
        WHERE
            products.product_id = invoice.product_id);
#12.Display average salary in the skin care department
SELECT 
    AVG(salary)
FROM
    employee AS e
        JOIN
    department d ON d.department_id = e.department_id
WHERE
    d.name = 'Skin care';
#14.Display all discounts on products of hair department
SELECT 
    p.name,
    CEILING(p.price - p.price * d.percentage) AS 'New price',
    duration AS 'End date',
    product_description,
    dep.name
FROM
    discounts d
        JOIN
    products p ON d.product_id = p.product_id
        JOIN
    department dep ON dep.department_id = p.department_id
WHERE
    dep.name = 'Hair care';
#15.Display all invoices paid in cash by client who is registered later than 2018
SELECT 
    *
FROM
    invoice i
        JOIN
    membership_clients mc ON mc.client_id = i.client_id
WHERE
    payment = 'cash'
        AND registration_date > '2018';
#17.Get total cost and total reach from marketing in the make up and skincare department
SELECT 
    SUM(cost) AS Totalcost, SUM(reach) AS Totalreach
FROM
    marketing m
        JOIN
    department d ON m.department_id = d.department_id
WHERE
    d.name = 'make up'
        OR d.name = 'skin care';
#18.Get the most useful marketing campaign related to less cost, biggest reach
SELECT 
    platform
FROM
    marketing
ORDER BY cost ASC , reach DESC
LIMIT 1;
#19.Get all brands and their products and the clients who have bought these products
SELECT 
    brand_name, p.name, mc.client_name
FROM
    brand b
        RIGHT JOIN
    products p ON p.brandname = b.brand_name
        LEFT JOIN
    invoice i ON i.product_id = p.product_id
        LEFT JOIN
    membership_clients mc ON mc.client_id = i.client_id;