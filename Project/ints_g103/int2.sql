--Interrogação 2: Qual o filme mais visto (e respetiva quantidade de bilhetes vendidos) em cada cinema?

.mode columns
.headers on
.nullvalue NULL

drop view if exists CinemaFilmeNum;
CREATE VIEW CinemaFilmeNum AS
SELECT idCinema, idFilme, count(*) AS numBilhetes
FROM Bilhete, Sessao, Sala
WHERE Bilhete.idSessao = Sessao.idSessao AND Sessao.idSala = Sala.idSala
GROUP BY idCinema, idFilme;

SELECT C.nome, F.nome, max(CFN.numBilhetes) AS numBilhetes
FROM Cinema C, Filme F, CinemaFilmeNum CFN
WHERE C.idCinema = CFN.idCinema AND
      F.idFilme = CFN.idFilme
GROUP BY C.idCinema
UNION
SELECT nome, NULL, NULL
FROM Cinema
WHERE idCinema NOT IN (SELECT idCinema FROM CinemaFilmeNum);
