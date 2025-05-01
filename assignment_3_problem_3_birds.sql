.open database/database.db

CREATE TEMP TABLE Averages AS
    SELECT Nest_ID, 
    AVG ((3.14 * Width * Width * Length) / 6.0) AS Avg_volume
    FROM Bird_eggs
    GROUP BY Nest_ID;

CREATE TEMP TABLE Species_volumes As
    SELECT Species, Max(Avg_volume) AS Max_avg_volume
    FROM Bird_nests
    JOIN Averages USING (Nest_ID)
    GROUP BY Species;

SELECT Species.Scientific_name, Species_volumes.Max_avg_volume
FROM Species_volumes
JOIN Species ON Species_volumes.Species = Species.Code
ORDER BY Species_volumes.Max_avg_volume DESC;