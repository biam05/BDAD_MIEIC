--Interrogação 6 : Qual o género mais visto e respetivo número de bilhetes vendidos?

.mode columns
.headers on
.nullvalue NULL

drop view if exists GeneroNumBilhetes;
CREATE VIEW GeneroNumBilhetes AS
SELECT genero, count(*) numBilhetes
FROM Bilhete, Sessao, Filme
WHERE Bilhete.idSessao = Sessao.idSessao  AND
      Sessao.idFilme  = Filme.idFilme
GROUP BY genero;

SELECT genero, numBilhetes
FROM GeneroNumBilhetes G
WHERE NOT EXISTS
      (SELECT * FROM GeneroNumBilhetes G2 WHERE G2.numBilhetes > G.numBilhetes);
