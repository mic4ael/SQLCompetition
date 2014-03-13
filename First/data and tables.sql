CREATE DATABASE Homework;

use Homework;

-- Tables

CREATE TABLE Firma( 
	IdFirmy int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Nazwa varchar(50) NOT NULL
);

CREATE TABLE Stanowisko( 
	IdStanowiska int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Stanowisko varchar(50) NOT NULL
);

CREATE TABLE Pracownicy( 
	IdPracownika int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Nazwisko varchar(50) NOT NULL
);

CREATE TABLE Umiejetnosci( 
	IdUmiejetnosci int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Nazwa varchar(50) NOT NULL
);

CREATE TABLE [Cechy Oczekiwane]( 
	IdCechyOczekiwanej int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	IdStanowiska int FOREIGN KEY REFERENCES Stanowisko(IdStanowiska) NOT NULL,
	IdFirmy int FOREIGN KEY REFERENCES Firma(IdFirmy) NOT NULL,
	IdUmiejetnosci int FOREIGN KEY REFERENCES Umiejetnosci(IdUmiejetnosci) NOT NULL,
	Waga float NOT NULL
);

CREATE TABLE [Cechy Posiadane]( 
	IdCechyPosiadanej int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	IdPracownika int FOREIGN KEY REFERENCES Pracownicy(IdPracownika) NOT NULL,
	IdUmiejetnosci int FOREIGN KEY REFERENCES Umiejetnosci(IdUmiejetnosci) NOT NULL,
);

CREATE TABLE XY (
	X float NOT NULL,
	Y float NOT NULL,
	Class varchar(10) NOT NULL
);


-- Insert DATA into tables

-- Firma Table
INSERT INTO Firma(Nazwa) VALUES('A');
INSERT INTO Firma(Nazwa) VALUES('BB');
INSERT INTO Firma(Nazwa) VALUES('CC');
INSERT INTO Firma(Nazwa) VALUES('DD');
INSERT INTO Firma(Nazwa) VALUES('EE');
INSERT INTO Firma(Nazwa) VALUES('FF');
INSERT INTO Firma(Nazwa) VALUES('GG');
INSERT INTO Firma(Nazwa) VALUES('HH');
INSERT INTO Firma(Nazwa) VALUES('II');
INSERT INTO Firma(Nazwa) VALUES('JJ');


-- Pracownicy Table
INSERT INTO Pracownicy(Nazwisko) Values('Kowalski');
INSERT INTO Pracownicy(Nazwisko) Values('Mowal');
INSERT INTO Pracownicy(Nazwisko) Values('Rawecki');
INSERT INTO Pracownicy(Nazwisko) Values('Polodziejski');
INSERT INTO Pracownicy(Nazwisko) Values('Kowalewski');
INSERT INTO Pracownicy(Nazwisko) Values('Glatnerz');
INSERT INTO Pracownicy(Nazwisko) Values('Pobiera');
INSERT INTO Pracownicy(Nazwisko) Values('Waleska');
INSERT INTO Pracownicy(Nazwisko) Values('Abraham');
INSERT INTO Pracownicy(Nazwisko) Values('Wasiera');
INSERT INTO Pracownicy(Nazwisko) Values('Wersiarska');
INSERT INTO Pracownicy(Nazwisko) Values('Jackowska');
INSERT INTO Pracownicy(Nazwisko) Values('Gajak');
INSERT INTO Pracownicy(Nazwisko) Values('Pawlak');
INSERT INTO Pracownicy(Nazwisko) Values('Walicka');
INSERT INTO Pracownicy(Nazwisko) Values('Piaskowa');
INSERT INTO Pracownicy(Nazwisko) Values('Kowaska');
INSERT INTO Pracownicy(Nazwisko) Values('Sekurska');
INSERT INTO Pracownicy(Nazwisko) Values('Pietruszczak');
INSERT INTO Pracownicy(Nazwisko) Values('Perkawska');

-- Umiejetnosci Table
INSERT INTO Umiejetnosci(Nazwa) Values('J. Niemiecki');
INSERT INTO Umiejetnosci(Nazwa) Values('J. Angielski');
INSERT INTO Umiejetnosci(Nazwa) Values('Pakiet Office');
INSERT INTO Umiejetnosci(Nazwa) Values('SQL Server');
INSERT INTO Umiejetnosci(Nazwa) Values('JAVA');
INSERT INTO Umiejetnosci(Nazwa) Values('C++');
INSERT INTO Umiejetnosci(Nazwa) Values('.NET');
INSERT INTO Umiejetnosci(Nazwa) Values('Programowanie Obiektowe');
INSERT INTO Umiejetnosci(Nazwa) Values('Kreatywnosc');
INSERT INTO Umiejetnosci(Nazwa) Values('Komunikatywnosc');
INSERT INTO Umiejetnosci(Nazwa) Values('Linux');
INSERT INTO Umiejetnosci(Nazwa) Values('Git');
INSERT INTO Umiejetnosci(Nazwa) Values('Wyksztalcenie Wyzsze Techniczne');
INSERT INTO Umiejetnosci(Nazwa) Values('Testowanie Aplikacji');

-- Stanowisko Table
INSERT INTO Stanowisko(Stanowisko) Values('Tester aplikacji');
INSERT INTO Stanowisko(Stanowisko) Values('Programista C++');
INSERT INTO Stanowisko(Stanowisko) Values('Programista JAVA');
INSERT INTO Stanowisko(Stanowisko) Values('Bazodanowiec');
INSERT INTO Stanowisko(Stanowisko) Values('Administrator Linux');
INSERT INTO Stanowisko(Stanowisko) Values('Mlodszy Programista');
INSERT INTO Stanowisko(Stanowisko) Values('Starszy Programista');
INSERT INTO Stanowisko(Stanowisko) Values('.NET Developer');
INSERT INTO Stanowisko(Stanowisko) Values('Senior Developer');
INSERT INTO Stanowisko(Stanowisko) Values('Administrator baz danych');


-- Cechy Oczekiwane Table
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (2,1,6,0.7);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (2,1,2,0.2);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (2,1,3,0.1);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (8,2,7,1);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (8,3,7,1);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (4,3,4,1);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (8,3,7,0.5);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (8,3,8,0.5);


INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (5,4,11,0.2);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (5,4,12,0.7);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (5,4,6,0.1);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (9,4,2,0.4);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (9,4,9,0.3);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (9,4,8,0.3);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (10,4,11,0.5);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (10,4,4,0.5);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (1,4,11,0.5);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (1,4,3,0.1);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (1,4,10,0.4);


INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (3,5,5,0.4);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (3,5,8,0.4);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (3,5,2,0.2);

INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (6,6,5,0.1);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (6,6,6,0.7);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (6,6,7,0.2);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (7,6,11,0.5);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (7,6,6,0.3);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (7,6,2,0.2);

INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (4,7,2,0.4);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (4,7,4,0.6);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (8,7,8,0.1);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (8,7,7,0.6);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (8,7,9,0.3);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (1,7,2,1);

INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (3,8,5,1);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (3,9,5,0.8);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (3,9,8,0.2);

INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (2,10,6,0.5);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (2,10,8,0.5);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (9,10,1,0.2);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (9,10,2,0.2);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (9,10,6,0.4);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (9,10,8,0.4);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (1,10,14,0.5);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (10,10,13,0.4);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (10,10,4,0.6);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (1,10,2,0.5);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (3,10,2,0.1);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (3,10,5,0.3);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (3,10,8,3);
INSERT INTO [Cechy Oczekiwane](IdStanowiska, IdFirmy, IdUmiejetnosci, Waga) VALUES (3,10,11,3);


-- Cechy Posiadane Table
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(1,3);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(1,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(1,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(1,5);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(1,8);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(2,3);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(2,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(2,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(3,14);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(3,5);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(3,8);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(3,3);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(3,10);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(4,3);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(4,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(4,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(4,8);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(5,13);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(5,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(5,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(5,11);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(5,14);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(6,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(6,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(6,12);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(6,13);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(7,13);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(7,9);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(7,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(7,6);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(8,3);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(8,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(8,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(8,9);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(8,11);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(8,14);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(9,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(9,5);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(9,6);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(9,7);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(10,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(10,5);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(10,9);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(11,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(11,3);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(11,10);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(11,11);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(12,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(12,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(12,3);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(12,6);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(12,7);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(12,11);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(12,13);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(13,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(13,8);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(13,9);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(13,4);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(14,3);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(14,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(14,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(14,13);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(14,11);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(15,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(15,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(15,3);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(15,7);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(15,8);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(15,12);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(16,13);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(16,11);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(16,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(17,3);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(17,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(17,4);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(17,8);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(17,13);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(18,13);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(18,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(18,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(18,5);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(18,8);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(18,9);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(18,10);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(19,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(19,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(20,1);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(20,2);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(20,3);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(20,6);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(20,7);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(20,10);
INSERT INTO [Cechy Posiadane](IdPracownika, IdUmiejetnosci) VALUES(20,13);


-- XY Table
INSERT INTO XY(X,Y,Class) VALUES(0.5,0.5,'krzyzyk');
INSERT INTO XY(X,Y,Class) VALUES(1,1,'krzyzyk');
INSERT INTO XY(X,Y,Class) VALUES(1.5,1.5,'krzyzyk');
INSERT INTO XY(X,Y,Class) VALUES(2,1.5,'krzyzyk');
INSERT INTO XY(X,Y,Class) VALUES(2,2,'krzyzyk');
INSERT INTO XY(X,Y,Class) VALUES(1,2,'krzyzyk');
INSERT INTO XY(X,Y,Class) VALUES(3,2,'kolko');
INSERT INTO XY(X,Y,Class) VALUES(3,2.5,'kolko');
INSERT INTO XY(X,Y,Class) VALUES(2.5,2.5,'kolko');
INSERT INTO XY(X,Y,Class) VALUES(4,3,'kolko');
INSERT INTO XY(X,Y,Class) VALUES(4,2.5,'kolko');
INSERT INTO XY(X,Y,Class) VALUES(4.5,3.5,'kolko');
INSERT INTO XY(X,Y,Class) VALUES(3.5,3,'kolko');