Queries on movies dataset
=========================

# Find 10 Persons whose name starts with "Pet" by descending birthdate


# Find movies which duration is more than one hour and less than two


# Find all the Persons related to the "The Godfather" movie along with the type of relation


# Find Tom Hank's co-actors


# Find the persons that have both directed and produced a single movie


# Find the persons that have only been acted in any of the movies they participated in


# Return friends of friends of Keanu Reeves who are not immediate friends with him


# Find the shortest KNOWS distance between any two persons


# Sherman wants to find the highest ratings on movies that other users that have rated similarly to the movies that he has rated

// find the movies that user Sherman has rated  
MATCH ....  
// find any other user that has given similar (0 or 1 stars difference) ratings to the movies that Sherman rated  
MATCH ....  
WHERE  .... // user is not Sherman  
AND abs(rating1 - rating2) < 2 // similar ratings  
WITH .... // pass the other users and the movies they have in common with Sherman  
// find the average rating on the other movies that other users made, then return by descending order the last 25  
MATCH ....  
WHERE .... // movies are the same as Sheramn's  
WITH avg(otherRating.rating) AS avgRating, movie // get average ratings of other users per movie  
RETURN movie  
ORDER BY avgRating desc  
LIMIT 25

# Find the movies with similar keywords as Elysium



# Find similar movies to the movies that user Sherman has already seen
