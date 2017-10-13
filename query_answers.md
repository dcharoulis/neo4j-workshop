Queries on movies dataset
=========================

# Find 10 Persons whose name starts with "Pet" by descending birthdate

MATCH (p :Person)
WHERE p.name STARTS WITH "Pet"
RETURN p.name as full_name, p.born as birthdate
ORDER BY birthdate DESC

# Find movies which duration is more than one hour and less than two

MATCH (m :Movie)
WHERE m.duration > 60 AND m.duration < 120
RETURN m

# Find all the Persons related to the "The Godfather" movie along with the type of relation

MATCH (p :Person)-[rel]->(m :Movie {title: "The Godfather"})
RETURN p.name, type(rel)

# Find Tom Hank's co-actors

MATCH (tom:Person {name:"Tom Hanks"})-[:ACTED_IN]->(m)<-[:ACTED_IN]-(coActors)
RETURN coActors.name

# Find the persons that have both directed and produced a single movie

MATCH (p :Person)-[:DIRECTED]-(m :Movie)
MATCH (p)-[:PRODUCED]-(m)
RETURN DISTINCT p

# Find the persons that have only been acted in any of the movies they participated in

MATCH (p :Person)-[rel]-(m :Movie)
WITH DISTINCT type(rel) as relationship, p
WHERE relationship = "ACTED_IN"
RETURN p.name as actor_name, relationship

# Return friends of friends of Keanu Reeves who are not immediate friends with him

MATCH (keanu: Person {name: “Keanu Reeves”})-[:KNOWS*2]->(for)
WHERE keanu <> off AND NOT (keanu)-[:KNOWS]-(for)
RETURN DISTINCT for.name

# Find the shortest KNOWS distance between any two persons

MATCH pat = shortestPath( (a)-[:KNOWS*]-(b) )
WHERE  a.name =  AND b.name = …
RETURN length(rels(p))

# Sherman wants to find the highest ratings on movies that other users that have rated similarly to the movies that he has rated

// find the movies that user Sherman has rated
MATCH (me:User {username:'Sherman'})-[my:RATED]->(m:Movie)
// find any other user that has given similar (0 or 1 stars difference) ratings to the movies that Sherman rated
MATCH (other:User)-[their:RATED]->(m)
WHERE me <> other // other is not Sherman
AND abs(my.rating - their.rating) < 2 // similar ratings
WITH other,m // pass the other users and the movies they have in common with Sherman
// find the average rating on the other movies that other users made, then return by descending order the last 25
MATCH (other)-[otherRating:RATED]->(movie:Movie)
WHERE movie <> m
WITH avg(otherRating.rating) AS avgRating, movie
RETURN movie
ORDER BY avgRating desc
LIMIT 25

# Find the movies with similar keywords as Elysium

MATCH (m:Movie {title:'Elysium'})
MATCH (m)-[:HAS_KEYWORD]->(k:Keyword)
MATCH (movie:Movie)-[r:HAS_KEYWORD]->(k)
WHERE m <> movie
WITH movie, count(DISTINCT r) AS commonKeywords
RETURN movie
ORDER BY commonKeywords DESC
LIMIT 25


# Find similar movies to the movies that user Sherman has already seen

MATCH (u:User {username:'Sherman'})-[:RATED]->(m:Movie)
MATCH (m)-[:HAS_KEYWORD]->(k:Keyword)
MATCH (movie:Movie)-[r:HAS_KEYWORD]->(k)
WHERE m <> movie
WITH movie, count(DISTINCT r) AS commonKeywords
RETURN movie
ORDER BY commonKeywords DESC
LIMIT 25
