--Interrogação 3: Qual o intervalo de tempo médio (em dias) em que um cliente vê um filme na cadeia de cinemas?

.mode columns
.headers on
.nullvalue NULL

drop view if exists PessoaData;
CREATE VIEW PessoaData AS
SELECT idPessoa, julianday(data) AS day
FROM Bilhete, Sessao
WHERE Bilhete.idSessao = Sessao.idSessao;

SELECT idPessoa, (max(day) - min(day))/(count(*) - 1) AS IntervaloMedio
FROM PessoaData
GROUP BY idPessoa
HAVING count(*) > 1;
