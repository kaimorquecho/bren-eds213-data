-- Continuing with SQL
-- Somewhat arbitrary but illustrative query
SELECT Scientific_name, Nest_count FROM
   (SELECT Species, Count(*) AS Nest_count FROM Bird_nests 
        WHERE Site = 'nome' 
        GROUP BY Species 
        HAVING Nest_count > 10 
        ORDER BY Species 
        LIMIT 2) JOIN Species
    ON Species = Code;

-- Outer joins
CREATE TEMP TABLE a (cola INTEGER, common INTEGER);

INSERT INTO a VALUES (1,1), (2,3), (3,3);
SELECT * FROM a;
CREATE TEMP TABLE b (common INTEGER, colb INTEGER);
INSERT into b values (2,2), (3,3), (4,4), (5,5);
SELECT * from b;

-- the joins we've been doing so far have been 'inner' joins
SELECT * from a join b using (common);
-- when we do this, we only get 2 results
select * from a join b on a.common = b.common; -- this code is the same thing as above

-- by doing an outer jooin, either a left or right join, we'll add certain missing rows
select * from a left join b on a.common = b.common;

-- A running example: which species does *not* have any nest data?
SELECT COUNT(*) FROM Species;
select COUNT(DISTINCT Species) FROM Bird_nests;

-- here is our list of species that do not have nest data, mehod 1
select code FROM Species 
    where code not in (select DISTINCT Species from Bird_nests);

-- what about removing distinct?
SELECT Code from species
    WHERE Code not in (select Species FROM Bird_nests);
-- in this case, they both work to produce the same result

-- method 2, many ways to do the same thing
SELECT Code FROM Species LEFT JOIN Bird_nests  
    ON Code = Species
    WHERE Species IS NULL;

-- it's also possible to join a table with itself, a co-called 'self join'

-- understanding a limitation of Duckdb
-- grouped both tables by nest with only the ones that start with 13B
SELECt Nest_ID, COUNT(*) AS Num_eggs
    FROm Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

-- Let's add in Observer
SELECt Nest_ID, COUNT(*) AS Num_eggs
    FROm Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

SELECT * FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%';

-- Duckdb solution 1
SELECT Nest_ID, Observer, Count (*) As Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    where Nest_ID LIKE '13B%'
    Group by Nest_ID, Observer;

-- duckdb solution 2, reference this code for the homework
SELECT Nest_ID, ANY_VALUE(Observer) AS Observer, Count (*) As Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    where Nest_ID LIKE '13B%'
    Group by Nest_ID, Observer;

-- Views: a virtual table
CREATE VIEW my_nests AS 
    SELECT Nest_ID, ANY_VALUE(Observer) AS Observer, Count (*) As Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    where Nest_ID LIKE '13B%'
    Group by Nest_ID, Observer;
.tables
select * from my_nests;
select NEST_ID, Name, Num_eggs 
    from my_nests JOIN Personnel
    ON Observer = Abbreviation;

-- view
-- temp table
-- what's the difference? if you create a temp table, the database is going through the work of actually constructing that table
-- a view is always virtual, executed dynamically once it gets the source tables. 
-- if something is computationally expensive, maybe do a temp table
-- if just for convenience and reflect the current data, then use a view

-- Set operations
-- UNION, UNION ALL, INTERSECT, EXCEPT
-- mathematically, a table is a set of tuples
SELECT * FROM Bird_eggs LIMIT 5;

SELECT Book_page, Year, Site, Nest_ID, Egg_num, Length*25.4 AS Length, Width*25.4 AS Width 
    FROM Bird_eggs
    WHERE Book_page LIKE 'b14%'
UNION
SELECT Book_page, Year, Site, Nest_ID, Egg_num, Length, Width 
    FROM Bird_eggs
    WHERE Book_page LIKE 'b14%';

-- method 3 for running example for what species are not in the bird_nests table
SELECT Code FROM Species
EXCEPT
SELECT DISTINCT Species From Bird_nests;