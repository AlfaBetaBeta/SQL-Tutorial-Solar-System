# Sample queries on a simplified Solar System database

The database used for this tutorial reflects a simplified version of the Solar System, focusing solely on its main constituents in terms of mass, as per the schematics below:

<img src="https://github.com/AlfaBetaBeta/SQL-Tutorial-Solar-System/blob/master/img/schematics.png" width=80% height=80%>

The database comprises the following tables, in correspondence with the entities described by their name:
* `StarPlanets`: physical properties of the Sun and all planets
* `Satellites`: for each planet, name and mass of each of its satellites
* `Elements`: name of each chemical element present in the current simplified Solar System

In addition to the tables above, there is a fourth one (`PlanetElements`) relating `StarPlanets` to `Elements` arising from the fact that various planets may share more than one element (many-to-many relation). Illustratively, the physical model of the simplified Solar System is shown below:

<img src="https://github.com/AlfaBetaBeta/SQL-Tutorial-Solar-System/blob/master/img/ERD.png" width=80% height=80%>

Caveats to the queries, function `QUANTIZE`, logical execution order allowing for double alliasing before `ORDER BY`

<img src="https://github.com/AlfaBetaBeta/SQL-Tutorial-Solar-System/blob/master/img/db2-image.png" width=100% height=100%>