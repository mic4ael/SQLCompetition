CREATE DATABASE Homework2;
GO
use Homework2;
GO
-- Table which contains points which belong to one of the two classes
CREATE TABLE XY2 (
	x FLOAT NOT NULL,
	y FLOAT NOT NULL,
	class varchar(10)
);
GO
INSERT INTO XY2(x,y,class) VALUES(0.5,0.5,'cross'), (1,1,'cross'), (1.5,1.5,'cross'),
									(2,1.5,'cross'), (2,2,'cross'), (1,2,'cross'), 
									(3,2,'circle'), (2.5,2.5,'circle'), (3,2.5,'circle'),
									(4,3,'circle'), (4,2.5,'circle'), (4.5,3.5,'circle'),
									(3.5,3,'circle'),(1,2.5,'circle');
GO
-- Table which contains points of three classes
CREATE TABLE XY3 (
	x FLOAT NOT NULL,
	y FLOAT NOT NULL,
	class varchar(10)
);
GO
INSERT INTO XY3(x,y,class) VALUES(0.5,0.5,'cross'), (1,1,'cross'), (1.5,1.5,'cross'),
									(2,1.5,'cross'), (2,2,'cross'), (1,2,'cross'), 
									(3,2,'circle'), (2.5,2.5,'circle'), (3,2.5,'circle'),
									(4,3,'circle'), (4,2.5,'circle'), (4.5,3.5,'circle'),
									(3.5,3,'circle'), 
									(1,3.5,'triangle'), (1.5,3,'triangle'), (2,3.5,'triangle'), (1.5,4,'triangle');

-- Table which contains points of one mutual class (problem with groups of points of the same class)
GO
CREATE TABLE XY4 (
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	x FLOAT NOT NULL,
	y FLOAT NOT NULL,
);
GO
INSERT INTO XY4(x,y) VALUES(1,1),(1.5,1.5),(0.5,1.5),(2,1.5),(1,2),(1,2.5),(1.5,2),(3.5,1.5),(4,2),(3.5,2.5),(3.5,3),(3,3),
					(3,3.5),(4,3),(4,4);

-- Tables for graph task.
GO
CREATE TABLE Actors (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	firstName VARCHAR(20),
	lastName VARCHAR(40)
);
GO
INSERT INTO Actors VALUES('Andrzej','Marszalek'), ('Katarzyna','Pietruszka'), ('Patrycja','Pawiczyn'), ('Mariusz','Pawski'),
						 ('Damian','Kowalski'), ('Urszula','Polska'), ('Beata','Ber³aœ'), ('Krzysztof','Podubek'),
						 ('Ryszard','Darski'), ('Anna','Kawecka'), ('Karolina','Dêbowska'), ('Micha³','Kaliñski');
GO
CREATE TABLE Edges(
	fromNode INT FOREIGN KEY REFERENCES Actors(id),
	toNode INT FOREIGN KEY REFERENCES Actors(id),
	PRIMARY KEY CLUSTERED (fromNode ASC, toNode ASC)
);
GO
TRUNCATE TABLE Edges
INSERT INTO Edges VALUES (1,5),(1,3),(1,4),(1,2),(1,7),(1,12),(4,3),(4,2),(4,12),(4,6),(2,6),
						 (3,7),(3,5),(3,8),(3,6),(3,9),(5,7),(7,8),(6,7),(6,8),(6,11),
						 (9,12),(9,10),(2,12),(2,9),(2,10),(2,11),(6,10),(6,9),(10,11),(8,11);


 
 


