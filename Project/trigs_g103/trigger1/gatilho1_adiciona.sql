--Gatilho 1 : Controla número de vagas das sessões (elimina uma vaga por cada bilhete e controla a capacidade das sessões)

PRAGMA foreign_keys = ON;

CREATE TRIGGER AtualizaVagas
AFTER INSERT ON Bilhete
FOR EACH ROW
BEGIN
  UPDATE Sessao
  SET vagas = vagas - 1
  WHERE Sessao.idSessao = New.idSessao;
END;

CREATE TRIGGER VerificaVagas
BEFORE INSERT ON Bilhete
FOR EACH ROW
WHEN (EXISTS (SELECT * FROM Sessao WHERE  Sessao.idSessao = New.idSessao AND vagas <= 0))
BEGIN
  SELECT raise(rollback, 'Sessao Lotada!');
END;
