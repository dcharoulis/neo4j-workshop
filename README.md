Neo4j workshop
==============


# Import movies dataset in neo4j  

```
neo4j-import \
--into $NEO4J_HOME/data/databases/graph.db \
--nodes:Genre genre_node.csv \
--nodes:Keyword keyword_node.csv \
--nodes:Movie movie_node.csv \
--nodes:Person person_node.csv \
--relationships:ACTED_IN acted_in_rels.csv \
--relationships:DIRECTED directed_rels.csv \
--relationships:HAS_GENRE has_genre_rels.csv \
--relationships:HAS_KEYWORD has_keyword_rels.csv \
--relationships:PRODUCED produced_rels.csv \
--relationships:WRITER_OF writer_of_rels.csv \
--delimiter ";" \
--array-delimiter "|"
```

# Add constraints/indexes in neo4j database

`
neo4j-shell -v -path $NEO4J_HOME/data/databases/graph.db  -file constraints.cql
`

# Add ratings with  load csv command from the neo4j browser


Add ratings.csv file in $NEO4j_HOME/import folder first and the run from neo4j browser:  
```
// path is relative to $NEO4J_HOME/import folder when running it from neo4j browser
LOAD CSV WITH HEADERS FROM 'file:///ratings.csv' AS line
MATCH (m:Movie {id: line.movie_id})
MERGE (u:User {id: line.user_id, username: line.user_username}) // user ids are strings
MERGE (u)-[r:RATED]->(m)
SET r.rating = line.rating
RETURN m.title, r.rating, u.username
```

or by using the shell (neo4j needs to be stopped)  
`
neo4j-shell -v -path $NEO4J_HOME/data/databases/graph.db  -file ratings.cql
`

In this case though the path to .csv file should be an absolute path:  
```
// path to ratings.csv file should be an absolute one when using neo4j-shell
LOAD CSV WITH HEADERS FROM 'file:///<absolute_path_to>/ratings.csv' AS line
MATCH (m:Movie {id: line.movie_id})
MERGE (u:User {id: line.user_id, username: line.user_username}) // user ids are strings
MERGE (u)-[r:RATED]->(m)
SET r.rating = line.rating
RETURN m.title, r.rating, u.username
```
