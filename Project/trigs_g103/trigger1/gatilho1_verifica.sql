.mode columns
.headers on
.nullvalue NULL
PRAGMA foreign_keys = ON;

SELECT * FROM Sessao;

INSERT INTO Bilhete (idBilhete, idPessoa, preco, lugar, idSessao) VALUES (15, 1, '4,50', 'J15', 1);
INSERT INTO Bilhete (idBilhete, idPessoa, preco, lugar, idSessao) VALUES (16, 1, '4,50', 'J16', 1);
INSERT INTO Bilhete (idBilhete, idPessoa, preco, lugar, idSessao) VALUES (17, 1, '4,50', 'J17', 1);
INSERT INTO Bilhete (idBilhete, idPessoa, preco, lugar, idSessao) VALUES (18, 1, '4,50', 'J18', 1);
INSERT INTO Bilhete (idBilhete, idPessoa, preco, lugar, idSessao) VALUES (19, 1, '4,50', 'J19', 1);
INSERT INTO Bilhete (idBilhete, idPessoa, preco, lugar, idSessao) VALUES (20, 1, '4,50', 'J20', 1);
INSERT INTO Bilhete (idBilhete, idPessoa, preco, lugar, idSessao) VALUES (21, 1, '4,50', 'J20', 24);

SELECT * FROM Bilhete;
SELECT * FROM Sessao;
