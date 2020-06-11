--Gatilho 2: Verifica se cliente tem idade mínima para assistir ao filme do bilhete que pretende comprar

PRAGMA foreign_keys = ON;

CREATE TRIGGER CheckAge
BEFORE INSERT ON Bilhete
FOR EACH ROW
WHEN NOT EXISTS (SELECT * FROM Pessoa, Sessao, Filme
                          WHERE Pessoa.idPessoa = New.idPessoa AND
                                Sessao.idSessao = New.idSessao AND
                                Sessao.idFilme = Filme.idFilme AND
                                Pessoa.idade >= Filme.idadeMinima)
BEGIN
  SELECT raise(rollback, 'Nao tem idade minima!');
END;
