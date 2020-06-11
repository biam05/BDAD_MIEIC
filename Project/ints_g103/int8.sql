--Interrogação 8 : Qual é a classificação média dos 3 filmes mais vistos?

.mode columns
.headers on
.nullvalue NULL

drop view if exists CinemaFilmeNum;
CREATE VIEW CinemaFilmeNum AS
SELECT idCinema, idFilme, count(*) AS numBilhetes
FROM Bilhete, Sessao, Sala
WHERE Bilhete.idSessao = Sessao.idSessao AND Sessao.idSala = Sala.idSala
GROUP BY idCinema, idFilme;

SELECT avg(rating) as 'Classificacao Media'
FROM
(
	SELECT *
	FROM CinemaFilmeNum
	ORDER BY numBilhetes DESC
	limit 3
) as topFilmesVistos
JOIN
Filme on Filme.idFilme = topFilmesVistos.idFilme;
 
