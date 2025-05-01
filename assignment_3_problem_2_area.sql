
.open database/database.db

-- Part 1

SELECT Site_name, MAX(Area) FROM Site;
SELECT Site_name, AVG(Area) FROM Site;
SELECT Site_name, COUNT(*) FROM Site;
SELECT Site_name, SUM(Area) FROM Site;
-- The problem with the above queries is that they do not group the results by Site_name. 
-- Instead, they combine a non-aggregated column (Site_name) with aggregated columns (MAX(Area), AVG(Area), COUNT(*), SUM(Area))
-- without telling SQL how to relate the two. By not specifying a Site_name for each aggregated value, SQL cannot determine how to group the results. 


-- Part 2
SELECT Site_name, Area FROM Site 
ORDER BY Area DESC
LIMIT 1;

-- Part 3
SELECT Site_name, Area FROM Site WHERE Area = (SELECT MAX(Area) FROM Site);
