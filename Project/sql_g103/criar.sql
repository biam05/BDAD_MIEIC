DROP TABLE IF EXISTS Bilhete;
DROP TABLE IF EXISTS Bilheteira;
DROP TABLE IF EXISTS BilheteiraBilhete;
DROP TABLE IF EXISTS BilheteiraMenu;
DROP TABLE IF EXISTS BilheteiraSnack;
DROP TABLE IF EXISTS Cinema;
DROP TABLE IF EXISTS CinemaFilme;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Filme;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Pessoa;
DROP TABLE IF EXISTS Sala;
DROP TABLE IF EXISTS Sessao;
DROP TABLE IF EXISTS Snack;
DROP TABLE IF EXISTS Estatuto;
DROP TABLE IF EXISTS TipoSala;
DROP TABLE IF EXISTS LinhaFatura;
DROP TABLE IF EXISTS Fatura;

CREATE TABLE Fatura (
	idFatura INTEGER PRIMARY KEY NOT NULL,
	data DATE NOT NULL, 
	total REAL NOT NULL CHECK (total > 0),
	idBilheteira INTEGER REFERENCES Bilheteira (idBilheteira) NOT NULL,
	idPessoa INTEGER REFERENCES Cliente (idPessoa) NOT NULL 
);

CREATE TABLE LinhaFatura (
	idLinhaFatura INTEGER PRIMARY KEY NOT NULL, 
	quantidade INTEGER NOT NULL CHECK (quantidade > 0),
	idMenu INTEGER REFERENCES Menu (idMenu),
	idSnack INTEGER REFERENCES Snack (idSnack),
	idFatura INTEGER REFERENCES Fatura (idFatura) NOT NULL,
	CHECK ((idMenu IS NULL AND idSnack IS NOT NULL) OR (idMenu IS NOT NULL AND idSnack IS NULL))
);

CREATE TABLE Bilhete (
    	idBilhete INTEGER PRIMARY KEY NOT NULL, 
    	idPessoa INTEGER REFERENCES Cliente (idPessoa) NOT NULL, 
    	preco REAL NOT NULL CHECK (preco > 0), 
    	lugar CHAR(3) NOT NULL, 
    	idSessao INTEGER REFERENCES Sessao (idSessao) NOT NULL    
);

CREATE TABLE Bilheteira (
	idBilheteira INTEGER PRIMARY KEY NOT NULL, 
    	montante REAL NOT NULL CHECK (montante >= 0), 
    	idCinema INTEGER REFERENCES Cinema (idCinema) NOT NULL
);

CREATE TABLE BilheteiraBilhete (
    	idBilheteira INTEGER REFERENCES Bilheteira (idBilheteira) NOT NULL, 
    	idBilhete INTEGER REFERENCES Bilhete (idBilhete) NOT NULL, 
    	PRIMARY KEY (idBilheteira, idBilhete)
);

CREATE TABLE BilheteiraSnack (
    	idBilheteira INTEGER REFERENCES Bilheteira (idBilheteira) NOT NULL, 
    	idSnack INTEGER REFERENCES Snack (idSnack) NOT NULL, 
    	PRIMARY KEY (idBilheteira, idSnack)
);

CREATE TABLE BilheteiraMenu (
    	idBilheteira INTEGER REFERENCES Bilheteira (idBilheteira) NOT NULL, 
    	idMenu INTEGER REFERENCES Menu (idMenu) NOT NULL, 
    	PRIMARY KEY (idBilheteira, idMenu)
);

CREATE TABLE Cinema (
	idCinema INTEGER PRIMARY KEY NOT NULL, 
	nome VARCHAR(64) NOT NULL, 
	localidade VARCHAR(64) NOT NULL, 
	horaAbertura DATETIME (10) NOT NULL CHECK (horaAbertura >= "10:00"), 
	horaFecho DATETIME (10) CHECK ("00:00" <= horaFecho and horaFecho <= "03:00") NOT NULL, 
	idPessoa INTEGER REFERENCES Pessoa (idPessoa) NOT NULL
);

CREATE TABLE CinemaFilme (
    	idCinema INTEGER NOT NULL REFERENCES Cinema (idCinema), 
    	idFilme INTEGER NOT NULL REFERENCES Filme (idFilme), 
    	dataEstreia DATE NOT NULL,
    	dataFim DATE NOT NULL CHECK (dataFim > dataEstreia), 
    	PRIMARY KEY (idCinema, idFilme)
);

CREATE TABLE Cliente (
    	idPessoa INTEGER REFERENCES Pessoa (idPessoa) NOT NULL PRIMARY KEY, 
    	idEstatuto INTEGER NOT NULL REFERENCES Estatuto (idEstatuto)
);

CREATE TABLE Filme (
    	idFilme INTEGER PRIMARY KEY NOT NULL, 
    	nome VARCHAR(32) NOT NULL, 
	duracao INTEGER NOT NULL CHECK (duracao > 0), 
    	genero STRING NOT NULL CHECK (genero = "Action" or 
				genero = "Adventure" or 
                                genero = "Animation" or 
                                genero = "Biography" or 
                                genero = "Comedy" or 
                                genero = "Crime" or 
                                genero = "Sport" or 
                                genero = "Documentary" or 
                                genero = "Drama" or 
                                genero = "Fantasy" or 
                                genero = "Fiction" or 
                                genero = "War" or 
                                genero = "History" or 
                                genero = "Mistery" or 
                                genero = "Music" or 
                                genero = "Romance" or 
                                genero = "Thriller" or 
                                genero = "Horror" or 
                                genero = "Western"), 
    idadeMinima INTEGER NOT NULL CHECK (idadeMinima > 3 and idadeMinima < 18), 
    rating REAL NOT NULL CHECK (rating > 0 and rating < 10), 
    sinopse VARCHAR(64) NOT NULL
);

CREATE TABLE Funcionario (
    	idPessoa INTEGER NOT NULL REFERENCES Pessoa (idPessoa) PRIMARY KEY,
    	ID INTEGER UNIQUE NOT NULL, 
	salario INTEGER NOT NULL CHECK (salario > 0), 
    	horasSemanais INTEGER NOT NULL CHECK (horasSemanais > 0), 
    	idCinema INTEGER REFERENCES Cinema (idCinema) NOT NULL, 
    	idBilheteira INTEGER REFERENCES Bilheteira (idBilheteira) NOT NULL
);

CREATE TABLE Menu (
    	idMenu INTEGER PRIMARY KEY NOT NULL,
    	tamanho STRING NOT NULL CHECK (tamanho = "Pequeno" or tamanho = "Medio" or tamanho = "Grande"), 
    	preco REAL NOT NULL CHECK (preco > 0)
);

CREATE TABLE Pessoa (
    	idPessoa INTEGER PRIMARY KEY NOT NULL, 
    	noCC INTEGER (8, 8) NOT NULL UNIQUE, 
    	nome VARCHAR(64) NOT NULL, 
    	idade INTEGER NOT NULL CHECK (3 < idade AND idade < 120)
);

CREATE TABLE Sala (
    	idSala INTEGER PRIMARY KEY NOT NULL, 
    	numero INTEGER NOT NULL, 
    	capacidade INTEGER NOT NULL CHECK (capacidade > 0), 
    	idTipoSala INTEGER NOT NULL REFERENCES TipoSala (idTipoSala), 
    	idCinema INTEGER NOT NULL REFERENCES Cinema (idCinema)
);

CREATE TABLE Sessao (
    	idSessao INTEGER PRIMARY KEY NOT NULL, 
    	horaInicio DATETIME NOT NULL, 
    	horaFim DATETIME NOT NULL, 
    	vagas INTEGER NOT NULL CHECK (vagas >= 0), 
    	idSala INTEGER REFERENCES Sala (idSala) NOT NULL, 
    	data DATE NOT NULL, 
    	idFilme INTEGER NOT NULL REFERENCES Filme (idFilme)
);

CREATE TABLE Snack (
    	idSnack INTEGER NOT NULL PRIMARY KEY, 
    	nome STRING NOT NULL, 
    	preco REAL CHECK (preco > 0), 
    	tamanho STRING CHECK (tamanho = "Nao Definido" or tamanho = "Pequeno" or tamanho = "Medio" or tamanho = "Grande"), 
    	idMenu INTEGER REFERENCES Menu (idMenu), 
	CHECK ((preco IS NULL AND tamanho IS NULL AND idMenu IS NOT NULL) OR (preco IS NOT NULL AND tamanho IS NOT NULL AND idMenu IS NULL))
);


CREATE TABLE Estatuto (
    	idEstatuto INTEGER PRIMARY KEY NOT NULL, 
    	tipo STRING NOT NULL CHECK (tipo = "Senior" or 
                                	tipo = "Regular" or 
                                	tipo = "Estudante" or 
                                	tipo = "Juvenil"), 
    	desconto REAL NOT NULL CHECK (desconto >= 0)
);

CREATE TABLE TipoSala (
    	idTipoSala INTEGER PRIMARY KEY NOT NULL, 
    	precoSala REAL NOT NULL CHECK (precoSala > 0), 
    	tipo VARCHAR(32) CHECK (tipo = "XVision" or tipo = "IMAX" or tipo = "Regular" or tipo = "3D") NOT NULL
);
