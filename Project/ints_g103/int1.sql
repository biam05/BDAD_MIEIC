-- Interrogação 1: Qual o preço final que cada cliente pagou pelo bilhete? 

.mode columns
.headers on
.nullvalue NULL

SELECT noCC, (precoSala - desconto)  as 'Preco Final'
FROM ((((((Bilhete join Sessao using (idSessao)) 
	join Sala using (idSala)) 
	join TipoSala using (idTipoSala)) 
	join Cliente using(idPessoa)) 
	join Pessoa using(idPessoa)) 
	join Estatuto using (idEstatuto))

         
