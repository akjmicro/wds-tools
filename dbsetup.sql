DROP TABLE IF EXISTS doubles;
CREATE TABLE doubles (
  wds_num text,
  update_year text,
  pos_angle numeric,
  sep numeric,
  mag1 numeric,
  mag2 numeric,
  spectrum text,
  ra_dec text,
  con text
);

.import raw_data/doubles.csv doubles

DROP TABLE IF EXISTS doubles_xref;
CREATE TABLE doubles_xref (
  wds_num text,
  catalog text,
  name1 text,
  name2 text,
  name3 text,
  name4 text
);

.import raw_data/doubles_xref.csv doubles_xref

DROP VIEW IF EXISTS doubles_subset;
DROP VIEW IF EXISTS tight_doubles;
DROP VIEW IF EXISTS medium_doubles;
DROP VIEW IF EXISTS wide_doubles;

CREATE VIEW doubles_subset AS
SELECT doubles.*,
       doubles_xref.catalog,
       doubles_xref.name1,
       doubles_xref.name2,
       doubles_xref.name3,
       doubles_xref.name4
FROM doubles
  JOIN doubles_xref
  ON doubles.wds_num = doubles_xref.wds_num
WHERE mag1 <= 7
  AND mag2 <= 12
ORDER BY mag1, sep DESC, (mag2 - mag1)
;

CREATE VIEW tight_doubles AS
SELECT *
FROM doubles_subset
WHERE sep < 5
;

CREATE VIEW medium_doubles AS
SELECT *
FROM doubles_subset
WHERE sep BETWEEN 5 AND 60
;

CREATE VIEW wide_doubles AS
SELECT *
FROM doubles_subset
WHERE sep >= 60
;
