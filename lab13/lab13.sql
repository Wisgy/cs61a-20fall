.read data.sql


CREATE TABLE average_prices AS
  SELECT category as category, sum(MSRP)/count(*) as average_price from products group by category;

CREATE TABLE lowest_prices AS
  SELECT store as store, item as item, min(price) from inventory group by item;

CREATE TABLE helper AS
  SELECT name as name, min(MSRP/rating) from products group by category;

CREATE TABLE shopping_list AS
  SELECT name as name, store as store from helper, lowest_prices where name = item;

CREATE TABLE total_bandwidth AS
  SELECT sum(b.Mbs) from shopping_list as a, stores as b where a.store = b.store;

