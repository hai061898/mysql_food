CALL SP_ADD_CATEGORY('Drinks', 'Description Drinks');
CALL SP_ADD_CATEGORY('Fast Food', 'Fast Food Description');
CALL SP_ADD_CATEGORY('Soda', 'Soda Description');
CALL SP_ADD_CATEGORY('Juices', 'Jucies description');
CALL SP_ADD_CATEGORY('Pizza', 'pizza description');
CALL SP_ADD_CATEGORY('Snacks', 'Snacks Description');
CALL SP_ADD_CATEGORY('Salad', 'Salad Description');
CALL SP_ADD_CATEGORY('Ice Cream', 'Ice Cream description');

/*---------------------------------------------------------------------------------------------------------------------------------------*/
INSERT INTO
  products (nameProduct, description, price, category_id)
VALUES
  ('Heineken','heineken Beer',15,1),
  ('Corona', 'Corona description', 16, 1),
  ('Coca Cola', 'Coca Cola description', 5, 3),
  ('Pepsi', 'Pepsi description', 7, 3),
  ('Sprite', 'Sprite Description', 7, 3),
  ('Fanta', 'Fanta Description', 6, 3),
  ('Inka cola', 'Inka Cola ', 9, 3),
  ('Hamburguesas','Hamburguesas ',23,2),
  ('Pizza', 'Pizza description', 8.5, 2),
  ('Fast food', 'Fast food description', 35, 2),
  ('Salad 1', 'Salad 1 description', 45, 7),
  ('Salad 2', 'Salad 2 description', 38, 7),
  ('Salad 3', 'Salad 3 description', 28, 7),
  ('Salad 4', 'Salad 4 description', 39, 7),
  ('Salad 5', 'Salad 5 description', 59, 7),
  ('Pizza two', 'Pizza two description', 59, 2);