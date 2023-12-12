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
DROP VIEW IF EXISTS standard_set;
DROP VIEW IF EXISTS standard_set_data_list;

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
WHERE mag1 <= 5.5
  AND mag2 <= 11
ORDER BY mag1, sep DESC, (mag2 - mag1)
;

CREATE VIEW tight_doubles AS
SELECT *
FROM doubles_subset
WHERE sep BETWEEN 1.8 and 5
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

CREATE VIEW standard_set AS
SELECT *
FROM doubles_subset
WHERE sep BETWEEN 1.8 AND 47
AND con in
(
  'And',
  'Aql',
  'Aqr',
  'Ari',
  'Aur',
  'Boo',
  'CMa',
  'CMi',
  'CVn',
  'Cam',
  'Cap',
  'Car',
  'Cas',
  'Cen',
  'Cep',
  'Cet',
  'Cnc',
  'Com',
  'Cyg',
  'Del',
  'Dra',
  'Eri',
  'Gem',
  'Her',
  'LMi',
  'Lac',
  'Leo',
  'Lep',
  'Lib',
  'Lyn',
  'Lyr',
  'Mon',
  'Oph',
  'Ori',
  'Peg',
  'Per',
  'Psc',
  'Sco',
  'Sct',
  'Ser',
  'Sex',
  'Sge',
  'Sgr',
  'Tau',
  'Tri',
  'UMa',
  'UMi',
  'Vir',
  'Vul'
);

CREATE VIEW standard_set_data_list AS
SELECT con || ': ' ||
       rtrim(
         name1 || ', ' || name2 || ', ' || name3 || ', ' || name4 || ', ',
         ', '
       )
       ||
       '; mags: ' || mag1 || ', ' || mag2 ||
       '; sep: ' || sep
       AS data
FROM standard_set
ORDER BY con, mag1, mag2, sep
;
