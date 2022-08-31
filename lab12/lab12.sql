.read data.sql


CREATE TABLE bluedog AS
  SELECT color,pet FROM students where color="blue" and pet="dog";

CREATE TABLE bluedog_songs AS
  SELECT color,pet,song FROM students where color="blue" and pet="dog";


CREATE TABLE smallest_int AS
  SELECT time, smallest FROM students where smallest>2 ORDER BY smallest LIMIT 20;

CREATE TABLE matchmaker AS
  SELECT A.pet, A.song, A.color, B.color FROM students as A, students as B where A.pet = B.pet and A.song = B.song and A.time<B.time;


CREATE TABLE sevens AS
  SELECT a.seven from students as a, numbers as b where a.number = 7 and b."7" = "True" and a.time = b.time;

