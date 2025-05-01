-- exploring why grouping by scientific_name is not quite correct 
SELECT * FROM Species LIMIT 3;
-- are there duplicate scientific names? (yes)
SELECT COUNT(*) FROM Species;
SELECT COUNT(DISTINCT scientific_name) FROM Species;
SELECT scientific_name, COUNT(*) AS Num_name_occurrences
FROM Species
GROUP BY scientific_name
HAVING Num_name_occurrences > 1;

CREATE TEMP TABLE t AS (
    SELECT scientific_name, COUNT(*) AS Num_name_occurrences
    FROM Species
    GROUP BY scientific_name
    HAVING Num_name_occurrences > 1

);

SELECT * FROM t;
SELECT * FROM Species s JOIN t 
    ON s.scientific_name = t.scientific_name
    OR (s.scientific_name IS NULL AND t.scientific_name IS NULL);


-- INSERTING data like this
INSERT INTO Species VALUES ('abcd','thing', 'scientific_name', NULL);
SELECT * FROM Species;
-- OR like this, you can explicitly label columns 
INSERT INTO Species
    (Common_name, scientific_name, Code, Relevance)
VALUES ('abcd','thing', 'scientific_name', NULL);
SELECT * FROM Species;
-- Can take advantage of default values 
INSERT INTO Species
    (Common_name, Code)
    VALUES
    ('thing 3', 'ijkd');
SELECT * FROM Species;

-- UPDATEs and DELETEs will demolish the entire table unless limited by WHERE
DELETE FROM Bird_eggs 
-- If you were to execute this command, it would delete all the rows in the table. git.restore would save you. 
-- Strategies to avoid coming cllose to deleting everything? 
-- 1. Doing a SELECT first
SELECT * FROM Bird_eggs WHERE Nest_ID LIKE 'z%';
-- 2. Create a copy of the table first
CREATE TABLE Bird_eggs_copy AS SELECT * FROM Bird_eggs;