--Interrogação 7 : Qual o intervalo de exibição mínimo e máximo dos filmes da cadeia de cinemas? 

.mode columns
.headers on
.nullvalue NULL

drop view if exists CinemaFilmeTempo;
CREATE VIEW CinemaFilmeTempo AS
SELECT Cinema.nome AS nomeCinema, Filme.nome AS nomeFilme, julianday(dataFim) - julianday(dataEstreia) AS tempoExibicao
FROM CinemaFilme, Cinema, Filme
WHERE CinemaFilme.idCinema = Cinema.idCinema AND
      CinemaFilme.idFilme = Filme.idFilme;

SELECT nomeCinema, nomeFilme, tempoExibicao AS numDias
FROM CinemaFilmeTempo CFT
WHERE NOT EXISTS
      (SELECT * FROM CinemaFilmeTempo CFT2 WHERE CFT2.tempoExibicao > CFT.tempoExibicao)
UNION
SELECT nomeCinema, nomeFilme, tempoExibicao
FROM CinemaFilmeTempo CFT
WHERE NOT EXISTS
      (SELECT * FROM CinemaFilmeTempo CFT2 WHERE CFT2.tempoExibicao < CFT.tempoExibicao)
ORDER BY tempoExibicao;
