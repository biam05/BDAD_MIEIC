PRAGMA foreign_keys = ON;
.mode columns
.headers on
.nullvalue NULL

--Verifica gatilho 3

SELECT B.idBilhete, TS.tipo AS 'Tipo Sala', E.tipo 'Estatuto', TS.precoSala, E.desconto
FROM Bilhete B, Sessao S, Sala SL, Cliente C, TipoSala TS, Estatuto E
WHERE B.idSessao = S.idSessao AND
      B.idPessoa = C.idPessoa AND
      S.idSala = SL.idSala AND
      SL.idTipoSala = TS.idTipoSala AND
      C.idEstatuto = E.idEstatuto;

SELECT * FROM Bilhete;
