USE food;
DELIMITER / / CREATE PROCEDURE SP_REGISTER(
  IN firstName VARCHAR(50),
  IN lastName VARCHAR(50),
  IN phone VARCHAR(11),
  IN image VARCHAR(250),
  IN email VARCHAR(100),
  IN pass VARCHAR(100),
  IN rol INT,
  IN nToken VARCHAR(255)
) BEGIN
INSERT INTO
  Person (firstName, lastName, phone, image) VALUE (firstName, lastName, phone, image);
INSERT INTO
  users (
    users,
    email,
    passwordd,
    persona_id,
    rol_id,
    notification_token
  ) VALUE (
    firstName,
    email,
    pass,
    LAST_INSERT_ID(),
    rol,
    nToken
  );
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_LOGIN(IN email VARCHAR(100)) BEGIN
SELECT
  p.uid,
  p.firstName,
  p.lastName,
  p.image,
  u.email,
  u.passwordd,
  u.rol_id,
  u.notification_token
FROM
  person p
  INNER JOIN users u ON p.uid = u.persona_id
WHERE
  u.email = email
  AND p.state = TRUE;
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_RENEWTOKENLOGIN(IN uid INT) BEGIN
SELECT
  p.uid,
  p.firstName,
  p.lastName,
  p.image,
  p.phone,
  u.email,
  u.rol_id,
  u.notification_token
FROM
  person p
  INNER JOIN users u ON p.uid = u.persona_id
WHERE
  p.uid = uid
  AND p.state = TRUE;
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_ADD_CATEGORY(
  IN category VARCHAR(50),
  IN description VARCHAR(100)
) BEGIN
INSERT INTO
  categories (category, description) VALUE (category, description);
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_USER_BY_ID(IN ID INT) BEGIN
SELECT
  p.uid,
  p.firstName,
  p.lastName,
  p.phone,
  p.image,
  u.email,
  u.rol_id,
  u.notification_token
FROM
  person p
  INNER JOIN users u ON p.uid = u.persona_id
WHERE
  p.uid = 1
  AND p.state = TRUE;
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_UPDATE_PROFILE(
  IN ID INT,
  IN firstName VARCHAR(50),
  IN lastName VARCHAR(50),
  IN phone VARCHAR(11)
) BEGIN
UPDATE
  person
SET
  firstName = firstName,
  lastName = lastName,
  phone = phone
WHERE
  person.uid = ID;
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_USER_UPDATED(IN ID INT) BEGIN
SELECT
  p.firstName,
  p.lastName,
  p.image,
  u.email,
  u.rol_id
FROM
  person p
  INNER JOIN users u ON p.uid = u.persona_id
WHERE
  p.uid = 1
  AND p.state = TRUE;
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_GET_PRODUCTS_TOP() BEGIN
SELECT
  pro.id,
  pro.nameProduct,
  pro.description,
  pro.price,
  pro.status,
  ip.picture,
  c.category,
  c.id AS category_id
FROM
  products pro
  INNER JOIN categories c ON pro.category_id = c.id
  INNER JOIN imageProduct ip ON pro.id = ip.product_id
  INNER JOIN (
    SELECT
      product_id,
      MIN(id) AS id_image
    FROM
      imageProduct
    GROUP BY
      product_id
  ) p3 ON ip.product_id = p3.product_id
  AND ip.id = p3.id_image
LIMIT
  10;
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_SEARCH_PRODUCT(IN nameProduct VARCHAR(100)) BEGIN
SELECT
  pro.id,
  pro.nameProduct,
  pro.description,
  pro.price,
  pro.status,
  ip.picture,
  c.category,
  c.id AS category_id
FROM
  products pro
  INNER JOIN categories c ON pro.category_id = c.id
  INNER JOIN imageProduct ip ON pro.id = ip.product_id
  INNER JOIN (
    SELECT
      product_id,
      MIN(id) AS id_image
    FROM
      imageProduct
    GROUP BY
      product_id
  ) p3 ON ip.product_id = p3.product_id
  AND ip.id = p3.id_image
WHERE
  pro.nameProduct LIKE CONCAT('%', nameProduct, '%');
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_SEARCH_FOR_CATEGORY(IN IDCATEGORY INT) BEGIN
SELECT
  pro.id,
  pro.nameProduct,
  pro.description,
  pro.price,
  pro.status,
  ip.picture,
  c.category,
  c.id AS category_id
FROM
  products pro
  INNER JOIN categories c ON pro.category_id = c.id
  INNER JOIN imageProduct ip ON pro.id = ip.product_id
  INNER JOIN (
    SELECT
      product_id,
      MIN(id) AS id_image
    FROM
      imageProduct
    GROUP BY
      product_id
  ) p3 ON ip.product_id = p3.product_id
  AND ip.id = p3.id_image
WHERE
  pro.category_id = IDCATEGORY;
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_LIST_PRODUCTS_ADMIN() BEGIN
SELECT
  pro.id,
  pro.nameProduct,
  pro.description,
  pro.price,
  pro.status,
  ip.picture,
  c.category,
  c.id AS category_id
FROM
  products pro
  INNER JOIN categories c ON pro.category_id = c.id
  INNER JOIN imageProduct ip ON pro.id = ip.product_id
  INNER JOIN (
    SELECT
      product_id,
      MIN(id) AS id_image
    FROM
      imageProduct
    GROUP BY
      product_id
  ) p3 ON ip.product_id = p3.product_id
  AND ip.id = p3.id_image;
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_ALL_ORDERS_STATUS(IN statuss VARCHAR(30)) BEGIN
SELECT
  o.id AS order_id,
  o.delivery_id,
  CONCAT(pe.firstName, " ", pe.lastName) AS delivery,
  pe.image AS deliveryImage,
  o.client_id,
  CONCAT(p.firstName, " ", p.lastName) AS cliente,
  p.image AS clientImage,
  p.phone AS clientPhone,
  o.address_id,
  a.street,
  a.reference,
  a.Latitude,
  a.Longitude,
  o.status,
  o.pay_type,
  o.amount,
  o.currentDate
FROM
  orders o
  INNER JOIN person p ON o.client_id = p.uid
  INNER JOIN addresses a ON o.address_id = a.id
  LEFT JOIN person pe ON o.delivery_id = pe.uid
WHERE
  o.`status` = statuss;
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_ORDER_DETAILS(IN IDORDER INT) BEGIN
SELECT
  od.id,
  od.order_id,
  od.product_id,
  p.nameProduct,
  ip.picture,
  od.quantity,
  od.price AS total
FROM
  orderdetails od
  INNER JOIN products p ON od.product_id = p.id
  INNER JOIN imageProduct ip ON p.id = ip.product_id
  INNER JOIN (
    SELECT
      product_id,
      MIN(id) AS id_image
    FROM
      imageProduct
    GROUP BY
      product_id
  ) p3 ON ip.product_id = p3.product_id
  AND ip.id = p3.id_image
WHERE
  od.order_id = IDORDER;
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_ALL_DELIVERYS() BEGIN
SELECT
  p.uid AS person_id,
  CONCAT(p.firstName, ' ', p.lastName) AS nameDelivery,
  p.phone,
  p.image,
  u.notification_token
FROM
  person p
  INNER JOIN users u ON p.uid = u.persona_id
WHERE
  u.rol_id = 3
  AND p.state = 1;
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_ORDERS_BY_DELIVERY(IN ID INT, IN statuss VARCHAR(30)) BEGIN
SELECT
  o.id AS order_id,
  o.delivery_id,
  o.client_id,
  CONCAT(p.firstName, " ", p.lastName) AS cliente,
  p.image AS clientImage,
  p.phone AS clientPhone,
  o.address_id,
  a.street,
  a.reference,
  a.Latitude,
  a.Longitude,
  o.status,
  o.pay_type,
  o.amount,
  o.currentDate
FROM
  orders o
  INNER JOIN person p ON o.client_id = p.uid
  INNER JOIN addresses a ON o.address_id = a.id
WHERE
  o.status = statuss
  AND o.delivery_id = ID;
END / /
/*---------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER / / CREATE PROCEDURE SP_ORDERS_FOR_CLIENT(IN ID INT) BEGIN
SELECT
  o.id,
  o.client_id,
  o.delivery_id,
  ad.reference,
  ad.Latitude AS latClient,
  ad.Longitude AS lngClient,
  CONCAT(p.firstName, ' ', p.lastName) AS delivery,
  p.phone AS deliveryPhone,
  p.image AS imageDelivery,
  o.address_id,
  o.latitude,
  o.longitude,
  o.`status`,
  o.amount,
  o.pay_type,
  o.currentDate
FROM
  orders o
  LEFT JOIN person p ON p.uid = o.delivery_id
  INNER JOIN addresses ad ON o.address_id = ad.id
WHERE
  o.client_id = ID
ORDER BY
  o.id DESC;
END / /