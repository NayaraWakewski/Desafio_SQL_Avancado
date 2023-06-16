# Desafio Sala de Aula - SQL Avançado

Este repositório contém as soluções em SQL para o Desafio Sala de Aula - SQL Avançado. O desafio consiste em responder a uma série de questões utilizando consultas SQL avançadas em um banco de dados fictício de vendas.

## Pré-requisitos

- Banco de dados relacional e dimensional com suporte a consultas SQL.

## Passo a passo

Siga os passos abaixo para obter as respostas para cada uma das questões do desafio.
*Observação: As consultas SQL acima devem ser executadas em um ambiente adequado, como um cliente de banco de dados ou uma IDE SQL.*

### Consultando as colunas das tabelas

Execute as seguintes consultas para verificar a estrutura e as colunas das tabelas envolvidas nas questões:

```sql
SELECT * FROM dw.fato_vendas;
SELECT * FROM dw.dim_vendedor;
SELECT * FROM dw.dim_produto;
SELECT * FROM dw.dim_cliente;
SELECT * FROM dw.dim_dependente;
SELECT * FROM dw.dim_canal;

```

### Passo a passo na resolução das questões.

## QUESTÃO 1

Apresente uma Query para listar o código e o nome do vendedor com maior número de vendas (contagem), e que estas vendas estejam com status concluída. As colunas presentes no resultado devem ser, portanto codigo vendedor e nome vendedor.

Execute a seguinte consulta para obter o resultado:

```sql
SELECT fv.codigovendedor , dv.nomevendedor
    FROM dw.fato_vendas fv
    JOIN dw.dim_vendedor dv ON fv.codigovendedor = dv.codigovendedor
    WHERE fv.statusvenda = '1'
GROUP BY fv.codigovendedor , dv.nomevendedor
ORDER BY COUNT (*) DESC
LIMIT 1; ----limita o resultado a apenas 1 vendedor-----

```

O comando **SELECT** indica quais colunas queremos selecionar na consulta. Nesse caso, estamos selecionando as colunas "codigovendedor" 
da tabela de vendas e "nomevendedor" da tabela de vendedores.

A cláusula **FROM** especifica a tabela principal da consulta, que é "fato_vendas" neste caso.

A cláusula **JOIN** é usada para combinar os dados das duas tabelas com base em uma condição. 
Estamos combinando as tabelas "fato_vendas" e "dim_vendedor" usando a coluna "codigovendedor" como critério de correspondência.

A cláusula **WHERE** é usada para filtrar os resultados com base em uma condição. Neste caso, estamos filtrando apenas as vendas que têm um "statusvenda" igual a '1'.

A cláusula **GROUP BY** é usada para agrupar os resultados com base em uma ou mais colunas. Estamos agrupando os resultados pelo "codigovendedor" e "nomevendedor".

A cláusula **ORDER BY** é usada para classificar os resultados em ordem ascendente ou descendente. Estamos classificando os resultados com base na contagem (*) em ordem decrescente.

A cláusula **LIMIT** é usada para limitar o número de resultados retornados pela consulta. Neste caso, estamos limitando a consulta para retornar apenas o vendedor com a contagem mais alta (o primeiro resultado).


## QUESTÃO 2

Apresente a query para lista o código e nome do produto mais vendid entre as datas de 2014-02-03 até 2018-02-02. As colunas presentes no resultado devem ser codigo do produto e nome do produto.

Execute a seguinte consulta para obter o resultado:

```sql
SELECT dp.codigoproduto, dp.nomeproduto
	FROM dw.dim_produto dp
	JOIN dw.fato_vendas fv ON dp.codigoproduto = fv.codigoproduto
	WHERE fv.datavenda BETWEEN '2014-02-03' AND '2018-02-02' AND fv.statusvenda = '1'
GROUP BY dp.codigoproduto, dp.nomeproduto
ORDER BY COUNT(*) DESC
LIMIT 1;
```

O comando **SELECT** indica quais colunas queremos selecionar na consulta. Neste caso, estamos selecionando as colunas "dp.codigoproduto" e "dp.nomeproduto".

A cláusula **FROM** especifica a tabela principal da consulta, que é "dw.dim_produto" e a referenciamos como "dp".

A cláusula **JOIN** é usada para combinar os dados das duas tabelas com base em uma condição. Estamos combinando a tabela "dw.dim_produto" com a tabela "dw.fato_vendas". A condição de combinação é que o "codigoproduto" seja o mesmo em ambas as tabelas.

A cláusula **WHERE** é usada para filtrar os resultados com base em uma condição. Estamos filtrando as vendas da tabela "dw.fato_vendas" para incluir apenas aquelas que ocorreram entre '2014-02-03' e '2018-02-02' e possuem um "statusvenda" igual a '1'.

A cláusula **GROUP BY** é usada para agrupar os resultados com base em uma ou mais colunas. Estamos agrupando os resultados pelo "dp.codigoproduto" e "dp.nomeproduto", ou seja, agrupando as vendas por cada produto específico.

A cláusula **ORDER BY** é usada para classificar os resultados em ordem ascendente ou descendente. Estamos classificando os resultados com base na contagem (*) em ordem decrescente, ou seja, o produto com o maior número de vendas será listado primeiro.

A cláusula **LIMIT** é usada para limitar o número de resultados retornados pela consulta. Neste caso, estamos limitando a consulta para retornar apenas um resultado, o produto com o maior número de vendas.


## QUESTÃO 3

Apresente uma query para lista o código e nome cliente co maior gasto na loja. As colunas presentes  no resultado devem ser codigo cliente, nome cliente, e gasto, está ultima representando o somatório das vendas atribuídas ao cliente.

Execute a seguinte consulta para obter o resultado:

```sql
SELECT dc.codigocliente, dc.nomecliente, SUM(fv.quantidadevendas * fv.valorunitariovendido) AS gasto
	FROM dw.fato_vendas fv
	JOIN dw.dim_cliente dc ON fv.codigocliente = dc.codigocliente
	WHERE fv.statusvenda = '1'
GROUP BY dc.codigocliente, dc.nomecliente
ORDER BY gasto DESC
LIMIT 1;
```

O comando **SELECT** indica quais colunas queremos selecionar na consulta. Neste caso, estamos selecionando as colunas "dc.codigocliente" e "dc.nomecliente", além de calcular uma coluna adicional chamada "gasto" usando a função **SUM**.

A cláusula **FROM** especifica a tabela principal da consulta, que é "dw.fato_vendas" e a referenciamos como "fv".

A cláusula **JOIN** é usada para combinar os dados das duas tabelas com base em uma condição. Estamos combinando a tabela "dw.fato_vendas" com a tabela "dw.dim_cliente". A condição de combinação é que o "codigocliente" seja o mesmo em ambas as tabelas.

A cláusula **WHERE** é usada para filtrar os resultados com base em uma condição. Estamos filtrando as vendas da tabela "dw.fato_vendas" para incluir apenas aquelas que possuem um "statusvenda" igual a '1'.

A cláusula **GROUP BY** é usada para agrupar os resultados com base em uma ou mais colunas. Estamos agrupando os resultados pelo "dc.codigocliente" e "dc.nomecliente", ou seja, agrupando as vendas por cada cliente específico.

A função **SUM** é usada para calcular a soma dos valores de vendas para cada cliente. Estamos multiplicando a coluna "quantidadevendas" pela coluna "valorunitariovendido" em cada venda e somando os valores.

A cláusula **ORDER BY** é usada para classificar os resultados em ordem ascendente ou descendente. Estamos classificando os resultados com base na coluna "gasto" (soma dos gastos) em ordem decrescente, ou seja, o cliente com o maior gasto será listado primeiro.

A cláusula **LIMIT** é usada para limitar o número de resultados retornados pela consulta. Neste caso, estamos limitando a consulta para retornar apenas um resultado, o cliente com o maior gasto.



## QUESTÃO 4

Apresente uma query para lista código, nome e data de nascimento dos dependentes do vendedor com menor valor total bruto em vendas (não sendo zero). As colunas presentes no resultado devem ser código do dependente, nome dependente e data de nascimento.

Execute a seguinte consulta para obter o resultado:

```sql
SELECT d.codigodependente, d.nomedependente, d.datanascimento
FROM dw.dim_dependente d
JOIN dw.dim_vendedor v ON d.codigovendedor = v.codigovendedor
JOIN (
  SELECT fv.codigovendedor, SUM(fv.quantidadevendas * fv.valorunitariovendido) AS valortotalvendas
  FROM dw.fato_vendas fv
  GROUP BY fv.codigovendedor
  HAVING SUM(fv.quantidadevendas * fv.valorunitariovendido) > 0
  ORDER BY valortotalvendas ASC
  LIMIT 1
) sub ON v.codigovendedor = sub.codigovendedor
JOIN dw.fato_vendas fv ON v.codigovendedor = fv.codigovendedor
WHERE fv.statusvenda = '1';
```

O comando **SELECT** indica quais colunas queremos selecionar na consulta. Neste caso, estamos selecionando as colunas "d.codigodependente", "d.nomedependente" e "d.datanascimento" da tabela "dw.dim_dependente".

A cláusula **FROM** especifica a tabela principal da consulta, que é "dw.dim_dependente" e a referenciamos como "d".

As cláusulas **JOIN** são usadas para combinar os dados de várias tabelas. Estamos unindo a tabela "dw.dim_dependente" com a tabela "dw.dim_vendedor" usando a coluna "codigovendedor" como critério de correspondência. Em seguida, estamos unindo o resultado anterior com uma subconsulta (sub) e a tabela "dw.fato_vendas" novamente, ambas usando a coluna "codigovendedor" como critério de correspondência.

A **subconsulta** dentro dos parênteses é usada para calcular o valor total de vendas para cada vendedor, agrupando as vendas pelo "codigovendedor". Estamos usando a função SUM para somar o resultado da multiplicação da coluna "quantidadevendas" pela coluna "valorunitariovendido" em cada venda. Em seguida, estamos filtrando apenas os resultados com um valor total de vendas maior que zero (HAVING) e classificando-os em ordem ascendente de acordo com o valor total de vendas (ORDER BY). Por fim, estamos limitando o resultado a apenas um registro usando LIMIT 1.

A cláusula **WHERE** é usada para filtrar os resultados com base em uma condição. Estamos filtrando as vendas da tabela "dw.fato_vendas" para incluir apenas aquelas que possuem um "statusvenda" igual a '1'.



## QUESTÃO 5

Apresente uma query para listar os 3 produtos menos vendidos pelos canais de E-comerce ou Matriz. As colunas presentes no resultado devem ser canal vendas, codigo produto, nome produto e quantidade vendas.

Execute a seguinte consulta para obter o resultado:

```sql
SELECT dc.nomecanal, dp.codigoproduto, dp.nomeproduto, COUNT(*) AS quantidade_vendas
	FROM dw.fato_vendas fv
	JOIN dw.dim_produto dp ON fv.codigoproduto = dp.codigoproduto
	JOIN dw.dim_canal dc ON fv.codigocanal = dc.codigocanal
	WHERE fv.statusvenda = '1' AND (dc.nomecanal = 'Loja Virtual' OR dc.nomecanal = 'Loja Própria')
GROUP BY dc.nomecanal, dp.codigoproduto, dp.nomeproduto
ORDER BY quantidade_vendas ASC
LIMIT 3;
```

O comando **SELECT** indica quais colunas queremos selecionar na consulta. Neste caso, estamos selecionando as colunas "dc.nomecanal", "dp.codigoproduto", "dp.nomeproduto" e contando o número de ocorrências (*) como "quantidade_vendas".

A cláusula **FROM** especifica a tabela principal da consulta, que é "dw.fato_vendas" e a referenciamos como "fv".

As cláusulas **JOIN** são usadas para combinar os dados de várias tabelas. Estamos unindo a tabela "dw.fato_vendas" com a tabela "dw.dim_produto" usando a coluna "codigoproduto" como critério de correspondência. Em seguida, estamos unindo o resultado anterior com a tabela "dw.dim_canal" usando a coluna "codigocanal" como critério de correspondência.

A cláusula **WHERE** é usada para filtrar os resultados com base em uma condição. Estamos filtrando as vendas da tabela "dw.fato_vendas" para incluir apenas aquelas que possuem um "statusvenda" igual a '1'. Além disso, estamos filtrando os resultados para incluir apenas os canais com o nome "Loja Virtual" ou "Loja Própria" (dc.nomecanal = 'Loja Virtual' OR dc.nomecanal = 'Loja Própria').

A cláusula **GROUP BY** é usada para agrupar os resultados com base em uma ou mais colunas. Estamos agrupando os resultados pelo "dc.nomecanal", "dp.codigoproduto" e "dp.nomeproduto", ou seja, agrupando as vendas por canal e produto específico.

A cláusula **ORDER BY** é usada para classificar os resultados em ordem ascendente ou descendente. Estamos classificando os resultados com base na coluna "quantidade_vendas" (contagem de vendas) em ordem crescente, ou seja, as vendas menos frequentes serão listadas primeiro.

A cláusula **LIMIT** é usada para limitar o número de resultados retornados pela consulta. Neste caso, estamos limitando a consulta para retornar apenas 3 registros, ou seja, as 3 vendas com menor quantidade de vendas.



## QUESTÃO 6

Apresente a query para lista o gasto médio por estado da federação. As colunas presentes no resultado devem ser estado e gasto medio. Considere apresentar a coluna gasto médio arredondada na segunda casa decimal.
    
Execute a seguinte consulta para obter o resultado:

```sql
SELECT c.estadocliente, ROUND(SUM(fv.quantidadevendas * fv.valorunitariovendido), 2) AS gasto_medio
	FROM dw.fato_vendas fv
	JOIN dw.dim_cliente c ON fv.codigocliente = c.codigocliente
	WHERE fv.statusvenda = '1'
GROUP BY c.estadocliente;
```

O comando **SELECT** indica quais colunas queremos selecionar na consulta. Neste caso, estamos selecionando a coluna "c.estadocliente" (estado do cliente) e calculando uma coluna adicional chamada "gasto_medio". Usamos a função SUM para somar o resultado da multiplicação da coluna "quantidadevendas" pela coluna "valorunitariovendido" em cada venda. Em seguida, usamos a função ROUND para arredondar o resultado para duas casas decimais.

A cláusula **FROM** especifica a tabela principal da consulta, que é "dw.fato_vendas" e a referenciamos como "fv".

A cláusula **JOIN** é usada para combinar os dados de duas tabelas. Estamos unindo a tabela "dw.fato_vendas" com a tabela "dw.dim_cliente" usando a coluna "codigocliente" como critério de correspondência.

A cláusula **WHERE** é usada para filtrar os resultados com base em uma condição. Estamos filtrando as vendas da tabela "dw.fato_vendas" para incluir apenas aquelas que possuem um "statusvenda" igual a '1'.

A cláusula **GROUP BY** é usada para agrupar os resultados com base em uma ou mais colunas. Estamos agrupando os resultados pelo "c.estadocliente", ou seja, agrupando as vendas por estado do cliente.



## QUESTÃO 7

Apresente a query para lista o código das vendas identificadas como deletadas. Apresente o resultado em ordem crescente.

Execute a seguinte consulta para obter o resultado:

```sql
SELECT codigovenda
	FROM dw.fato_vendas
	WHERE deletado = '1'
ORDER BY codigovenda ASC
```

O comando **SELECT** indica que queremos selecionar a coluna "codigovenda" na consulta.

A cláusula **FROM** especifica a tabela principal da consulta, que é "dw.fato_vendas".

A cláusula **WHERE** é usada para filtrar os resultados com base em uma condição. Estamos filtrando as vendas da tabela "dw.fato_vendas" para incluir apenas aquelas que possuem o valor "1" na coluna "deletado", ou seja, as vendas marcadas como deletadas.

A cláusula **ORDER BY** é usada para classificar os resultados em ordem ascendente ou descendente. Estamos classificando os resultados com base na coluna "codigovenda" em ordem crescente, ou seja, os códigos das vendas serão listados em ordem crescente.



## QUESTÃO 8

Apresente a query para lista a quantidade média vendida de cada proudto agrupado por estado da federeação. As colunas presentes no resultado devem ser estado e nome produto e quantidade media. Considere arredondar o valor da coluna quantidade media na quarta casa decimal. Ordene os resultados pelo Estado (1°) e nome do produto (2°).

Execute a seguinte consulta para obter o resultado:

```sql
SELECT c.estadocliente, dp.nomeproduto, ROUND(AVG(fv.quantidadevendas), 4) AS quantidade_media
	FROM dw.fato_vendas fv
	JOIN dw.dim_produto dp ON fv.codigoproduto = dp.codigoproduto
	JOIN dw.dim_cliente c ON fv.codigocliente = c.codigocliente
	WHERE fv.statusvenda = '1'
GROUP BY c.estadocliente, dp.nomeproduto
ORDER BY 1, 2;
```

O comando **SELECT** indica quais colunas queremos selecionar na consulta. Neste caso, estamos selecionando as colunas "c.estadocliente" (estado do cliente), "dp.nomeproduto" (nome do produto) e calculando uma coluna adicional chamada "quantidade_media". Usamos a função AVG para calcular a média da coluna "quantidadevendas" em cada venda. Em seguida, usamos a função ROUND para arredondar o resultado para quatro casas decimais.

As cláusulas **FROM** especificam as tabelas principais da consulta, que são "dw.fato_vendas" (referenciada como "fv"), "dw.dim_produto" (referenciada como "dp") e "dw.dim_cliente" (referenciada como "c").

As cláusulas **JOIN** são usadas para combinar os dados de várias tabelas. Estamos unindo a tabela "dw.fato_vendas" com a tabela "dw.dim_produto" usando a coluna "codigoproduto" como critério de correspondência. Em seguida, estamos unindo o resultado anterior com a tabela "dw.dim_cliente" usando a coluna "codigocliente" como critério de correspondência.

A cláusula **WHERE** é usada para filtrar os resultados com base em uma condição. Estamos filtrando as vendas da tabela "dw.fato_vendas" para incluir apenas aquelas que possuem um "statusvenda" igual a '1', ou seja, vendas com status de venda igual a '1'.

A cláusula **GROUP BY** é usada para agrupar os resultados com base em uma ou mais colunas. Estamos agrupando os resultados pelo "c.estadocliente" (estado do cliente) e pelo "dp.nomeproduto" (nome do produto), ou seja, agrupando as vendas por estado do cliente e produto.

A cláusula **ORDER BY** é usada para classificar os resultados em ordem ascendente ou descendente. Estamos classificando os resultados pelo "c.estadocliente" em ordem crescente (1º critério de classificação) e pelo "dp.nomeproduto" em ordem crescente (2º critério de classificação).


## QUESTÃO 9

Calcule a receita bruta por ano.

Execute a seguinte consulta para obter o resultado:

```sql
SELECT SUM(fv.quantidadevendas * fv.valorunitariovendido) AS receita_bruta
	FROM dw.fato_vendas fv
	WHERE EXTRACT(YEAR FROM fv.datavenda) = EXTRACT(YEAR FROM CURRENT_DATE)
```

O comando **SELECT** indica que queremos calcular a soma da coluna "quantidadevendas" multiplicada pela coluna "valorunitariovendido" e chamamos essa coluna calculada de "receita_bruta".

A cláusula **FROM** especifica a tabela principal da consulta, que é "dw.fato_vendas" e a referenciamos como "fv".

A cláusula **WHERE** é usada para filtrar os resultados com base em uma condição. Estamos filtrando as vendas da tabela "dw.fato_vendas" para incluir apenas aquelas que ocorreram no mesmo ano do ano atual. Para fazer isso, usamos a função *EXTRACT* para extrair o ano da coluna "datavenda" e comparamos com o ano atual usando a função *EXTRACT com CURRENT_DATE* para obter o ano atual.


## QUESTÃO 10

Calcule a receita bruta por ano e estado.

Execute a seguinte consulta para obter o resultado:

```sql
SELECT c.estadocliente, EXTRACT(YEAR FROM fv.datavenda) AS ano, SUM(fv.quantidadevendas * fv.valorunitariovendido) AS receita_bruta
	FROM dw.fato_vendas fv
	JOIN dw.dim_cliente c ON fv.codigocliente = c.codigocliente
GROUP BY c.estadocliente, EXTRACT(YEAR FROM fv.datavenda);
```

O comando **SELECT** indica quais colunas queremos selecionar na consulta. Neste caso, estamos selecionando as colunas "c.estadocliente" (estado do cliente), "EXTRACT(YEAR FROM fv.datavenda)" (ano da venda) e calculando uma coluna adicional chamada "receita_bruta". Usamos a função SUM para somar o resultado da multiplicação da coluna "quantidadevendas" pela coluna "valorunitariovendido" em cada venda.

As cláusulas **FROM** especificam as tabelas principais da consulta, que são "dw.fato_vendas" (referenciada como "fv") e "dw.dim_cliente" (referenciada como "c").

As cláusulas **JOIN** são usadas para combinar os dados de várias tabelas. Estamos unindo a tabela "dw.fato_vendas" com a tabela "dw.dim_cliente" usando a coluna "codigocliente" como critério de correspondência.

A cláusula **GROUP BY** é usada para agrupar os resultados com base em uma ou mais colunas. Estamos agrupando os resultados pelo "c.estadocliente" (estado do cliente) e pelo *"EXTRACT(YEAR FROM fv.datavenda)* " (ano da venda), ou seja, agrupando as vendas por estado do cliente e ano.


## QUESTÃO 11

Proponha um indicador. Foi criado um indicador para calcular o TICKET MEDIO.

Execute a seguinte consulta para obter o resultado:

```sql
SELECT SUM(fv.quantidadevendas * fv.valorunitariovendido) / COUNT(DISTINCT fv.codigovenda) AS ticket_medio
FROM dw.fato_vendas fv;
```

O comando **SELECT** indica que queremos calcular a soma da coluna "quantidadevendas" multiplicada pela coluna "valorunitariovendido" e dividir pelo número de vendas distintas *(COUNT(DISTINCT fv.codigovenda))*. Chamamos essa coluna calculada de "ticket_medio".

A cláusula **FROM** especifica a tabela principal da consulta, que é "dw.fato_vendas" e a referenciamos como "fv".

A query não possui cláusula **WHERE**, o que significa que não estamos aplicando nenhum filtro nas vendas. Estamos considerando todas as vendas da tabela "dw.fato_vendas".



## QUESTÃO 12

Monte uma view para a query da questão 5.

Execute a seguinte consulta para obter o resultado:

```sql
CREATE VIEW produtos_menos_vendidos AS
SELECT dc.nomecanal,dp.codigoproduto,dp.nomeproduto,COUNT(*) AS quantidade_vendas
	FROM dw.fato_vendas fv
	JOIN dw.dim_produto dp ON fv.codigoproduto = dp.codigoproduto
	JOIN dw.dim_canal dc ON fv.codigocanal = dc.codigocanal
	WHERE fv.statusvenda = '1' AND (dc.nomecanal = 'Loja Virtual' OR dc.nomecanal = 'Loja Própria')
GROUP BY dc.nomecanal, dp.codigoproduto, dp.nomeproduto
ORDER BY quantidade_vendas ASC
LIMIT 3;
```

A cláusula **SELECT** indica as colunas que queremos selecionar na consulta. Neste caso, estamos selecionando as colunas "dc.nomecanal" (nome do canal), "dp.codigoproduto" (código do produto), "dp.nomeproduto" (nome do produto) e calculando uma coluna adicional chamada "quantidade_vendas". A coluna "quantidade_vendas" é o resultado da função COUNT(*), que conta o número de ocorrências de cada combinação de canal, produto e nome do produto.

A cláusula **FROM** especifica as tabelas principais da consulta, que são "dw.fato_vendas" (referenciada como "fv"), "dw.dim_produto" (referenciada como "dp") e "dw.dim_canal" (referenciada como "dc"). Essas tabelas estão sendo unidas usando as cláusulas JOIN.

As cláusulas **JOIN** são usadas para combinar os dados de várias tabelas com base em condições específicas. Estamos unindo a tabela "dw.fato_vendas" com a tabela "dw.dim_produto" usando a coluna "codigoproduto" como critério de correspondência, e também unindo a tabela "dw.fato_vendas" com a tabela "dw.dim_canal" usando a coluna "codigocanal" como critério de correspondência.

A cláusula **WHERE** é usada para aplicar condições de filtragem aos dados. Neste caso, estamos filtrando apenas as vendas com "statusvenda" igual a '1' e o "nomecanal" igual a 'Loja Virtual' ou 'Loja Própria'.

A cláusula **GROUP BY** é usada para agrupar os resultados com base em uma ou mais colunas. Estamos agrupando os resultados pelo "nomecanal", "codigoproduto" e "nomeproduto". Isso nos permite obter a contagem de vendas para cada combinação única de canal, produto e nome do produto.

A cláusula **ORDER BY** é usada para ordenar os resultados em ordem crescente. Estamos ordenando os resultados pela coluna "quantidade_vendas" em ordem ascendente.

A cláusula **LIMIT** é usada para limitar o número de resultados retornados pela consulta. Neste caso, estamos limitando a consulta a retornar apenas os 3 produtos com menor quantidade de vendas.


## QUESTÃO 13

Mostre o nome do vendedor, sem espaço na frente e a quantidade de dependentes (usando subselect).

Execute a seguinte consulta para obter o resultado:

```sql
SELECT TRIM(v.nomevendedor) AS nome_vendedor,
       (SELECT COUNT(*) FROM dw.dim_dependente d WHERE d.codigovendedor = v.codigovendedor) AS quantidade_dependentes
FROM dw.dim_vendedor v;
```

A cláusula **SELECT** indica as colunas que queremos selecionar na consulta. Neste caso, estamos selecionando a coluna *"TRIM(v.nomevendedor) AS nome_vendedor"*, que retorna o nome do vendedor sem espaços em branco no início ou no final. Também estamos selecionando uma subconsulta dentro do SELECT, que conta o número de dependentes para cada vendedor usando a cláusula **"(SELECT COUNT(*)** FROM dw.dim_dependente d WHERE d.codigovendedor = v.codigovendedor) AS quantidade_dependentes".

A cláusula **FROM** especifica a tabela principal da consulta, que é "dw.dim_vendedor" (referenciada como "v"). Estamos consultando a tabela de vendedores para obter informações sobre cada vendedor.

A subconsulta **"(SELECT COUNT(*) FROM** dw.dim_dependente d WHERE d.codigovendedor = v.codigovendedor)" é usada para contar o número de dependentes para cada vendedor. A subconsulta está relacionando a tabela de dependentes (dw.dim_dependente) com a tabela de vendedores (dw.dim_vendedor) usando a coluna "codigovendedor" como critério de correspondência.

O resultado da subconsulta é retornado como a coluna "quantidade_dependentes" na consulta principal. Essa coluna mostra a quantidade de dependentes para cada vendedor.



## DESAFIO

Elabore consultas para os indicadore e solicitações abaixo:
A comissão de um vendedor é definida a partir de um percentual sobre o total de vendas (quantidade*valor unitário) por ele realizado.
O percentual de comissão de cada vendedor está armazenado na coluna percomissão, tabela dim_vendedor.
Com base em tais informações, calcule a comissão de todos os vendedores, considerando todas as vendas armazenadas na base de dados fato_vendas.
As colunas  presentes no resultado devem ser nomevendedor, valor total vendas, percentual de comissão e comissão.
O valor de comissão deve ser apresentado em ordem decrescente arredondando na segunda casa decimal.

Execute a seguinte consulta para obter o resultado:

```sql
SELECT dv.nomevendedor, 
       SUM(fv.quantidadevendas * fv.valorunitariovendido) AS valor_total_vendas,
       dv.percentualcomissao,
       ROUND(SUM(fv.quantidadevendas * fv.valorunitariovendido) * dv.percentualcomissao, 2) AS comissao
	FROM dw.fato_vendas fv
	JOIN dw.dim_vendedor dv ON fv.codigovendedor = dv.codigovendedor
GROUP BY dv.nomevendedor, dv.percentualcomissao
ORDER BY comissao DESC;
```

A cláusula **SELECT** indica as colunas que queremos selecionar na consulta. Neste caso, estamos selecionando as colunas "dv.nomevendedor" (nome do vendedor), "SUM(fv.quantidadevendas * fv.valorunitariovendido) AS valor_total_vendas" (o valor total das vendas para cada vendedor), "dv.percentualcomissao" (o percentual de comissão do vendedor) e "ROUND(SUM(fv.quantidadevendas * fv.valorunitariovendido) * dv.percentualcomissao, 2) AS comissao" (o valor da comissão correspondente ao valor total das vendas multiplicado pelo percentual de comissão).

A cláusula **FROM** especifica as tabelas principais da consulta, que são "dw.fato_vendas" (referenciada como "fv") e "dw.dim_vendedor" (referenciada como "dv"). Estamos unindo as tabelas de vendas e vendedores usando a cláusula **JOIN**.

As cláusulas **JOIN** são usadas para combinar os dados de várias tabelas com base em condições específicas. Estamos unindo a tabela "dw.fato_vendas" com a tabela "dw.dim_vendedor" usando a coluna "codigovendedor" como critério de correspondência.

A cláusula **GROUP BY** é usada para agrupar os resultados com base em uma ou mais colunas. Estamos agrupando os resultados pelo "dv.nomevendedor" (nome do vendedor) e "dv.percentualcomissao" (percentual de comissão). Isso nos permite calcular o valor total de vendas e a comissão para cada vendedor.

A cláusula **ORDER BY** é usada para ordenar os resultados em ordem decrescente com base na coluna "comissao" (valor da comissão). Os vendedores serão listados em ordem decrescente de acordo com o valor da comissão.


## Autora

### Nayara Valevskii
- [Linkedin](https://www.linkedin.com/in/nayaraba)
- [Github](https://github.com/NayaraWakewski)


