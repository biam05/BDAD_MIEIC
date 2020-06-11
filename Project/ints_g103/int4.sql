--Interrogação 4: Quais os filmes que ainda não venderam bilhetes?

.mode columns
.headers on
.nullvalue NULL

SELECT DISTINCT nome
FROM Filme
WHERE idFilme NOT IN
              (SELECT idFilme
               FROM Bilhete, Sessao
               WHERE Bilhete.idSessao = Sessao.idSessao);
