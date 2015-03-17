### - Adds a new contact
INSERT into contacts(firstname, lastname, email) 
VALUES('Cola','Spills','cola.spills@hotmail.com');
### Grabs all contacts in db
select * from contacts;
###
DELETE FROM contacts WHERE id = $1
###
SELECT id, firstname, lastname, email 
FROM contacts WHERE id = $1 LIMIT 1
###
