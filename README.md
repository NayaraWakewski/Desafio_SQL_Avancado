# Desafio Sala de Aula - SQL Avançado

Este repositório contém as soluções em SQL para o Desafio Sala de Aula - SQL Avançado. O desafio consiste em responder a uma série de questões utilizando consultas SQL avançadas em um banco de dados fictício de vendas.

## Pré-requisitos

- Banco de dados relacional com suporte a consultas SQL.

## Passo a passo

Siga os passos abaixo para obter as respostas para cada uma das questões do desafio.
Observação: As consultas SQL acima devem ser executadas em um ambiente adequado, como um cliente de banco de dados ou uma IDE SQL.

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

QUESTÃO 1- --Apresente uma Query para listar o código e o nome do vendedor com maior número de vendas (contagem), e que estas vendas estejam com status concluída. As colunas presentes no resultado devem ser, portanto codigo vendedor e nome vendedor.

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
O comando ##SELECT indica quais colunas queremos selecionar na consulta. Nesse caso, estamos selecionando as colunas "codigovendedor" 
da tabela de vendas e "nomevendedor" da tabela de vendedores.

A cláusula ##FROM especifica a tabela principal da consulta, que é "fato_vendas" neste caso.

A cláusula ##JOIN é usada para combinar os dados das duas tabelas com base em uma condição. 
Estamos combinando as tabelas "fato_vendas" e "dim_vendedor" usando a coluna "codigovendedor" como critério de correspondência.

A cláusula ##WHERE é usada para filtrar os resultados com base em uma condição. Neste caso, estamos filtrando apenas as vendas que têm um "statusvenda" igual a '1'.

A cláusula ##GROUP BY é usada para agrupar os resultados com base em uma ou mais colunas. Estamos agrupando os resultados pelo "codigovendedor" e "nomevendedor".

A cláusula ##ORDER BY é usada para classificar os resultados em ordem ascendente ou descendente. Estamos classificando os resultados com base na contagem (*) em ordem decrescente.

A cláusula ##LIMIT é usada para limitar o número de resultados retornados pela consulta. Neste caso, estamos limitando a consulta para retornar apenas o vendedor com a contagem mais alta (o primeiro resultado).

    
