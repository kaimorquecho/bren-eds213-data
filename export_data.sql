-- EXPORTING data from a database


-- The whole database 

EXPORT DATABASE 'export_adsn'; ALTER

-- One table
COPY Species TO 'species_test.csv' (HEADER, DELIMITER ',');

-- specific query
COPY (SELECT COUNT (*) FROM Species) TO 'species_count.csv' (HEADER, DELIMITER ',');
