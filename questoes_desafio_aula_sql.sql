---DESAFIO SALA DE AULA---
---SQL AVANÇADO-----

--OBS- todas as consultas devem trazer apenas as vendas com status de concluído.

---QUESTÃO 01---
--Apresente uma Query para listar o código e o nome do vendedor com maior número de vendas (contagem), e que estas vendas estejam
--com status concluída. As colunas presentes no resultado devem ser, portanto codigo vendedor e nome vendedor.

---Consultando as colunas das tabelas---

SELECT * FROM dw.fato_vendas;
SELECT * FROM dw.dim_vendedor;

---Criando medidas-----

SELECT fv.codigovendedor , dv.nomevendedor
    FROM dw.fato_vendas fv
    JOIN dw.dim_vendedor dv ON fv.codigovendedor = dv.codigovendedor
    WHERE fv.statusvenda = '1'
GROUP BY fv.codigovendedor , dv.nomevendedor
ORDER BY COUNT (*) DESC
LIMIT 1; ----limita o resultado a apenas 1 vendedor-----

---QUESTÃO 02---
--Apresente a query para lista o código e nome do produto mais vendid entre as datas de 2014-02-03 até 2018-02-02. As colunas presentes
--no resultado devem ser codigo do produto e nome do produto.

---Consultando as colunas das tabelas---

SELECT * FROM dw.fato_vendas;
SELECT * FROM dw.dim_produto;

---Criando medidas-----
SELECT dp.codigoproduto, dp.nomeproduto
	FROM dw.dim_produto dp
	JOIN dw.fato_vendas fv ON dp.codigoproduto = fv.codigoproduto
	WHERE fv.datavenda BETWEEN '2014-02-03' AND '2018-02-02' AND fv.statusvenda = '1'
GROUP BY dp.codigoproduto, dp.nomeproduto
ORDER BY COUNT(*) DESC
LIMIT 1;

---QUESTÃO 03---
--Apresente uma query para lista o código e nome cliente co maior gasto na loja. As colunas presentes  no resultado devem ser codigo cliente,
--nome cliente, e gasto, está ultima representando o somatório das vendas atribuídas ao cliente.

---Consultando as colunas das tabelas---

SELECT * FROM dw.fato_vendas;
SELECT * FROM dw.dim_cliente;

---Criando medidas-----

SELECT dc.codigocliente, dc.nomecliente, SUM(fv.quantidadevendas * fv.valorunitariovendido) AS gasto
	FROM dw.fato_vendas fv
	JOIN dw.dim_cliente dc ON fv.codigocliente = dc.codigocliente
	WHERE fv.statusvenda = '1'
GROUP BY dc.codigocliente, dc.nomecliente
ORDER BY gasto DESC
LIMIT 1;


---QUESTÃO 04---
--Apresente uma query para lista código, nome e data de nascimento dos dependentes do vendedor com menor valor total bruto em vendas (não sendo zero).
--As colunas presentes no resultado devem ser código do dependente, nome dependente e data de nascimento.

---Consultando as colunas das tabelas---

SELECT * FROM dw.fato_vendas;
SELECT * FROM dw.dim_dependente;
SELECT * FROM dw.dim_vendedor;

---Criando medidas-----

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


-------QUESTAO 05------
--- Apresente uma query para listar os 3 produtos menos vendidos pelos canais de E-comerce ou Matriz. As colunas presentes no resultado devem ser 
----canal vendas, codigo produto, nome produto e quantidade vendas.

---Consultando as colunas das tabelas---

SELECT * FROM dw.fato_vendas;
SELECT * FROM dw.dim_produto;
SELECT * FROM dw.dim_canal;

---Criando medidas-----

SELECT dc.nomecanal, dp.codigoproduto, dp.nomeproduto, COUNT(*) AS quantidade_vendas
	FROM dw.fato_vendas fv
	JOIN dw.dim_produto dp ON fv.codigoproduto = dp.codigoproduto
	JOIN dw.dim_canal dc ON fv.codigocanal = dc.codigocanal
	WHERE fv.statusvenda = '1' AND (dc.nomecanal = 'Loja Virtual' OR dc.nomecanal = 'Loja Própria')
GROUP BY dc.nomecanal, dp.codigoproduto, dp.nomeproduto
ORDER BY quantidade_vendas ASC
LIMIT 3;



------QUESTÃO 06-------
---- Apresente a query para lista o gasto médio por estado da federação. As colunas presentes no resultado devem ser estado e gasto medio.
----Considere apresentar a coluna gasto médio arredondada na segunda casa decimal.

---Consultando as colunas das tabelas---

SELECT * FROM dw.fato_vendas;
SELECT * FROM dw.dim_cliente;

---Criando medidas-----

SELECT c.estadocliente, ROUND(SUM(fv.quantidadevendas * fv.valorunitariovendido), 2) AS gasto_medio
	FROM dw.fato_vendas fv
	JOIN dw.dim_cliente c ON fv.codigocliente = c.codigocliente
	WHERE fv.statusvenda = '1'
GROUP BY c.estadocliente;


------QUESTÃO 07-------
----Apresente a query para lista o código das vendas identificadas como deletadas. Apresente o resultado em ordem crescente.

---Consultando as colunas das tabelas---

SELECT * FROM dw.fato_vendas;

-----Criando as medidas-----

SELECT codigovenda
	FROM dw.fato_vendas
	WHERE deletado = '1'
ORDER BY codigovenda ASC



------QUESTÃO 08-------
-----Apresente a query para lista a quantidade média vendida de cada proudto agrupado por estado da federeação. As colunas presentes no resultado
-----devem ser estado e nome produto e quantidade media. Considere arredondar o valor da coluna quantidade media na quarta casa decimal. Ordene
-----os resultados pelo Estado (1°) e nome do produto (2°)

---Consultando as colunas das tabelas---

SELECT * FROM dw.fato_vendas;
SELECT * FROM dw.dim_cliente;
SELECT * FROM dw.dim_produto;

-----Criando as medidas-----


SELECT c.estadocliente, dp.nomeproduto, ROUND(AVG(fv.quantidadevendas), 4) AS quantidade_media
	FROM dw.fato_vendas fv
	JOIN dw.dim_produto dp ON fv.codigoproduto = dp.codigoproduto
	JOIN dw.dim_cliente c ON fv.codigocliente = c.codigocliente
	WHERE fv.statusvenda = '1'
GROUP BY c.estadocliente, dp.nomeproduto
ORDER BY 1, 2;


------QUESTÃO 09-------
-----Calcule a receita bruta por ano.

---Consultando as colunas das tabelas---

SELECT * FROM dw.fato_vendas;

-----Criando as medidas-----

SELECT SUM(fv.quantidadevendas * fv.valorunitariovendido) AS receita_bruta
	FROM dw.fato_vendas fv
	WHERE EXTRACT(YEAR FROM fv.datavenda) = EXTRACT(YEAR FROM CURRENT_DATE)



------QUESTÃO 10-------
-----Calcule a receita bruta por ano e estado

---Consultando as colunas das tabelas---

SELECT * FROM dw.fato_vendas;
SELECT * FROM dw.dim_dependente;
SELECT * FROM dw.dim_vendedor;

-----Criando as medidas-----

SELECT c.estadocliente, EXTRACT(YEAR FROM fv.datavenda) AS ano, SUM(fv.quantidadevendas * fv.valorunitariovendido) AS receita_bruta
	FROM dw.fato_vendas fv
	JOIN dw.dim_cliente c ON fv.codigocliente = c.codigocliente
GROUP BY c.estadocliente, EXTRACT(YEAR FROM fv.datavenda);


------QUESTÃO 11-------
----Proponha um indicador---

---Consultando as colunas das tabelas---

SELECT * FROM dw.fato_vendas;

-----Criando as medidas-----
-------Foi criado um indicador para calcular o TICKET MEDIO-----

SELECT SUM(fv.quantidadevendas * fv.valorunitariovendido) / COUNT(DISTINCT fv.codigovenda) AS ticket_medio
FROM dw.fato_vendas fv;


------QUESTÃO 12-------
-----Monte uma view para a query da questão 5.

---Consultando as colunas das tabelas---

SELECT * FROM dw.fato_vendas;
SELECT * FROM dw.dim_produto;
SELECT * FROM dw.dim_canal;

-----Criando as medidas-----

CREATE VIEW produtos_menos_vendidos AS
SELECT dc.nomecanal,dp.codigoproduto,dp.nomeproduto,COUNT(*) AS quantidade_vendas
	FROM dw.fato_vendas fv
	JOIN dw.dim_produto dp ON fv.codigoproduto = dp.codigoproduto
	JOIN dw.dim_canal dc ON fv.codigocanal = dc.codigocanal
	WHERE fv.statusvenda = '1' AND (dc.nomecanal = 'Loja Virtual' OR dc.nomecanal = 'Loja Própria')
GROUP BY dc.nomecanal, dp.codigoproduto, dp.nomeproduto
ORDER BY quantidade_vendas ASC
LIMIT 3;


------QUESTÃO 13-------
----Mostre o nome do vendedor, sem espaço na frente e a quantidade de dependentes (usando subselect)

---Consultando as colunas das tabelas---

SELECT * FROM dw.dim_dependente;
SELECT * FROM dw.dim_vendedor;

-----Criando as medidas-----

SELECT TRIM(v.nomevendedor) AS nome_vendedor,
       (SELECT COUNT(*) FROM dw.dim_dependente d WHERE d.codigovendedor = v.codigovendedor) AS quantidade_dependentes
FROM dw.dim_vendedor v;


-------DESAFIO EXTRA-----

----Elabore consultas para os indicadore e solicitações abaixo:------

---A comissão de um vendedor é definida a partir de um percentual sobre o total de vendas (quantidade*valor unitário) por ele realizado.
---O percentual de comissão de cada vendedor está armazenado na coluna percomissão, tabela dim_vendedor.
---Com base em tais informações, calcule a comissão de todos os vendedores, considerando todas as vendas armazenadas na base de dados fato_vendas.
---As colunas  presentes no resultado devem ser nomevendedor, valor total vendas, percentual de comissão e comissão.
----O valor de comissão deve ser apresentado em ordem decrescente arredondando na segunda casa decimal.


SELECT dv.nomevendedor, 
       SUM(fv.quantidadevendas * fv.valorunitariovendido) AS valor_total_vendas,
       dv.percentualcomissao,
       ROUND(SUM(fv.quantidadevendas * fv.valorunitariovendido) * dv.percentualcomissao, 2) AS comissao
	FROM dw.fato_vendas fv
	JOIN dw.dim_vendedor dv ON fv.codigovendedor = dv.codigovendedor
GROUP BY dv.nomevendedor, dv.percentualcomissao
ORDER BY comissao DESC;
