--Interrogação 5 : Qual a média do número de clientes mensais por cinema?

.mode columns
.headers on
.nullvalue NULL

drop view if exists numCinemas;
CREATE VIEW numCinemas AS
SELECT count(*) AS numCinemas
FROM Cinema;

SELECT strftime("%Y", data) as ano, strftime("%m", data) AS mes, count(DISTINCT idPessoa)*1.0/numCinemas AS mediaClientesPerCinema
FROM Bilhete, Sessao, numCinemas
WHERE Bilhete.idSessao = Sessao.idSessao
GROUP BY ano, mes
ORDER BY ano, mes;
