// movies constraints

CREATE CONSTRAINT ON (n:Movie) ASSERT n.id IS UNIQUE;

CREATE CONSTRAINT ON (n:Person) ASSERT n.id IS UNIQUE;

CREATE CONSTRAINT ON (n:Keyword) ASSERT n.id IS UNIQUE;

CREATE CONSTRAINT ON (n:User) ASSERT n.id IS UNIQUE;

CREATE CONSTRAINT ON (n:User) ASSERT n.username IS UNIQUE;

CREATE CONSTRAINT ON (n:Genre) ASSERT n.id IS UNIQUE;


// Existence constraints can apply only on enterprise editions
// CREATE CONSTRAINT ON ()-[r:RATED]-() ASSERT exists(r.rating);
