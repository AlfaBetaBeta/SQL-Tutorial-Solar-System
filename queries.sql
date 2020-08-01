-- What are the top 3 relevant elements of the Solar System?
-- Note: The elements are weighted by units of Earth mass[M⊕]
SELECT e.NAME AS ELEMENT,
       QUANTIZE(SUM(pe.ELEMENTRATIO * sp.MASS), 0.01) AS "WEIGHT [M+]"
FROM Elements AS e
INNER JOIN PlanetElements AS pe ON (e.ID = pe.IDELEMENTS)
INNER JOIN StarPlanets AS sp ON (pe.SPName = sp.Name)
GROUP BY e.NAME
ORDER BY "WEIGHT [M+]" DESC
LIMIT 3;


-- How much time does it take to make a round trip from Earth to each of the other planets?
/*
Note: - It is assumed that all planet orbits are coplanar
      - The journey to each planet is calculated assuming that the planet, Earth and the sun are aligned
      - The distance of each planet to the sun is an average over the elliptical orbit
*/
SELECT NAME AS PLANET,
       QUANTIZE((ABS(DISTTOSUN * 150000000 - (SELECT DISTTOSUN * 150000000
       	                                      FROM StarPlanets
                                              WHERE UPPER(NAME) = 'EARTH')) * 2 / 40000 / 24), 1) AS "TRAVEL TIME [days]"
FROM StarPlanets
WHERE UPPER(NAME) <> 'SUN' AND UPPER(NAME) <> 'EARTH'
ORDER BY "TRAVEL TIME [days]" DESC;


-- What is the total mass of the solar system?
/*
Note: - To transform the mass to kilograms, the result should be multiplied by 5972E+21
      - The total mass only contains that of the star and the 8 planets
*/
SELECT QUANTIZE((SUM(MASS) + (SELECT SUM(MASS) FROM Satellites)), 1) AS "TOTAL MASS [M+]"
FROM StarPlanets;


-- Which planet has the minimum number of rotation cycles per revolution?
/*
Note: - The result is expressed in days/year locally to each planet, so the query is essentially providing
        which planet has the shortest year measured in its own time scale
      - The Earth sidereal year is rounded to 365 for simplicity (from 365.25636 solar days)
*/
SELECT NAME AS "PLANET WITH SHORTEST YEAR",
       QUANTIZE(ABS(SIDEREALP * 365 / ROTATIONP), 0.01) AS "DAYS/REVOLUTION"
FROM StarPlanets
WHERE ABS(SIDEREALP * 365 / ROTATIONP) = (SELECT MIN(ABS(SIDEREALP * 365 / ROTATIONP))
                                          FROM StarPlanets
                                          WHERE UPPER(NAME) <> 'SUN');


-- Which planet has the largest mass ratio of satellites to parent planet?
SELECT sp.NAME AS Planet,
       QUANTIZE(sp.MASS * 5972, 1) AS "PLANET MASS [E21 kg]",
       QUANTIZE(Y, 1) AS "SATELLITES MASS [E21 kg]",
       QUANTIZE((QUANTIZE(Y * 100, 0.01) / QUANTIZE(sp.MASS * 5972, 0.01)), 0.01) AS "MASS RATIO [%]"
FROM STARPLANETS AS sp
INNER JOIN (SELECT s.PLANETNAME, SUM(s.MASS) AS Y
            FROM SATELLITES AS s
            GROUP BY s.PLANETNAME) AS x
ON (sp.NAME = x.PLANETNAME)
ORDER BY "MASS RATIO [%]" DESC
LIMIT 1;

