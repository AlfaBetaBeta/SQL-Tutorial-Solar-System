# Sample queries on a simplified Solar System database

The database used for this tutorial reflects a simplified version of the Solar System, focusing solely on its main constituents in terms of mass, as per the schematics below:

<img src="https://github.com/AlfaBetaBeta/SQL-Tutorial-Solar-System/blob/master/img/schematics.png" width=80% height=80%>

The database comprises the following tables, in correspondence with the entities described by their name:
* `StarPlanets`: physical properties of the Sun and all planets
* `Satellites`: for each planet, name and mass of each of its satellites
* `Elements`: name of each chemical element present in the current simplified Solar System

In addition to the tables above, there is a fourth one (`PlanetElements`) relating `StarPlanets` to `Elements` arising from the fact that various planets may share more than one element (many-to-many relation). Illustratively, the physical model of the simplified Solar System is shown below:

<img src="https://github.com/AlfaBetaBeta/SQL-Tutorial-Solar-System/blob/master/img/ERD.png" width=80% height=80%>

The tables above may be properly populated provided scraping from reliable data sources can be ensured. Otherwise, for simplicity and for the sake of facilitating execution, it can be resorted to sample non-rigurous values via:
```
$ db2 -tvmf exampleTables.sql
``` 

The following queries are addressed in `queries.sql`:
* What are the top 3 relevant elements of the Solar System?
* How much time does it take to make a round trip from Earth to each of the other planets?
* What is the total mass of the solar system?
* Which planet has the minimum number of rotation cycles per revolution?
* Which planet has the largest mass ratio of (aggregated) satellites to parent planet?

To execute the queries, just run:
```
$ db2 -tvmf queries.sql
``` 

Despite the simplicity of the database and the queries, there are a few caveats that may be useful as takeaways:
* Using quoted aliases allows for blanks, symbols (which is useful for displaying units) and column labelling including reserved keywords
* `QUANTIZE` is a handy function to control precision upon display
* The logical processing order dictating physical execution might vary depending on the query processor but roughly it is likely to follow the sequence structure below (top to bottom):
    * `FROM` (including `JOIN`...`ON`)
    * `WHERE`
    * `GROUP BY`
    * `HAVING`
    * `SELECT`
    * `ORDER BY`

This order is the reason why the last query works, note that alias `Y` from the subselect is visible in the main select and that it can be re-aliased before ordering by it. Illustratively, below is the output of such query when executing on db2:

<img src="https://github.com/AlfaBetaBeta/SQL-Tutorial-Solar-System/blob/master/img/db2-image.png" width=100% height=100%>