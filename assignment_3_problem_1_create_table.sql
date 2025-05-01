-- Part 1

CREATE TEMP TABLE mysillytable (
    Experiment Real
);

INSERT INTO mysillytable (Experiment)
VALUES (1.0), (2.0), (3.0), (4.0), (5.0), (NULL), (NULL), (8.0), (9.0), (10.0), (NULL);

SELECT AVG(Experiment) FROM mysillytable;
-- result is 5.25
SELECT AVG(Experiment) FROM mysillytable WHERE Experiment IS NOT NULL;
-- result is 5.25   
SELECT AVG(Experiment) FROM mysillytable WHERE Experiment IS NULL;
-- result is NULL

-- My experiment showed that the column's average is 5.25 regardless of factoring in
-- NULL values. The average is 5.25  when NULL values are included or excluded from the
-- calculation. This means the NULL values are ignored in the calculation of the average. When 
-- Only NULL values are included in the calculation, the result is NULL. This means that the
-- average of NULL values will be NULL. SQL does not abort. 





-- Part 2


SELECT SUM(Experiment)/COUNT(*) FROM mysillytable;
-- Gives incorrect result
SELECT SUM(Experiment)/COUNT(Experiment) FROM mysillytable;
-- Gives correct result of 5.25

-- The right query is SELECT SUM(Experiment)/COUNT(Experiment) FROM mysillytable;
-- The first query gives an incorrect result because it counts all rows when dividing by COUNT(*), including those with NULL values.
-- The second query counts only the non-NULL values in the Experiment column, which gives the correct average.


