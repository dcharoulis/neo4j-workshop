LOAD CSV WITH HEADERS FROM 'file:///ratings.csv' AS line
MATCH (m:Movie {id:line.movie_id})
MERGE (u:User {id: line.user_id, username: line.user_username}) // user ids are strings
MERGE (u)-[r:RATED]->(m)
SET r.rating = line.rating
RETURN m.title, r.rating, u.username;
