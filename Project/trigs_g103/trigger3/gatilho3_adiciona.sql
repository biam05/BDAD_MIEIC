--Gatilho 3 : Ao inserir um bilhete, o preço deste é automaticamente atualizado consoante o estatuto do cliente e o tipo de sala

PRAGMA foreign_keys = ON;

CREATE TRIGGER AtualizaPrecoBilhete
AFTER INSERT ON Bilhete
FOR EACH ROW
BEGIN
  UPDATE Bilhete
  SET preco =	(SELECT TipoSala.precoSala
		FROM TipoSala, Sessao, Sala
              	WHERE New.idSessao = Sessao.idSessao AND Sessao.idSala = Sala.idSala AND Sala.idTipoSala = TipoSala.idTipoSala)
                - 
		(SELECT Estatuto.desconto
		FROM Cliente, Estatuto
              	WHERE New.idPessoa = Cliente.idPessoa AND Cliente.idEstatuto = Estatuto.idEstatuto)
  WHERE idBilhete = New.idBilhete;
END;
