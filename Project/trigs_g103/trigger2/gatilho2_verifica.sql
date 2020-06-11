PRAGMA foreign_keys = ON;
.mode columns
.headers on
.nullvalue NULL

--Verificação do gatilho 2

SELECT * FROM Bilhete;

INSERT INTO Bilhete VALUES (15, 19, 4.50, 'H11', 1);

SELECT * FROM Bilhete;
