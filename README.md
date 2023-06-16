# Desafio_SQL_Avancado

```sql
    SELECT * FROM dw.fato_vendas;
    SELECT * FROM dw.dim_vendedor;
    SELECT * FROM dw.dim_produto;
    SELECT * FROM dw.dim_cliente;
    SELECT * FROM dw.dim_dependente;
    SELECT * FROM dw.dim_canal;
    
 Nesse código SQL, temos uma consulta que busca informações sobre o vendedor com o maior número de vendas em uma tabela chamada "dw.fato_vendas" e sua correspondente tabela de dimensão "dw.dim_vendedor". Vamos analisar cada função presente no código:

1. **SELECT**: É a cláusula que especifica quais colunas serão retornadas na consulta. Nesse caso, seleciona-se as colunas "fv.codigovendedor" e "dv.nomevendedor".

2. **FROM**: Indica a tabela principal da consulta. Aqui, a tabela principal é "dw.fato_vendas" e é representada pela abreviação "fv".

3. **JOIN**: É a cláusula utilizada para combinar linhas de duas ou mais tabelas com base em uma coluna relacionada. Nesse caso, está sendo feito um join entre as tabelas "dw.fato_vendas" e "dw.dim_vendedor" usando a coluna "codigovendedor" como critério de junção.

4. **ON**: Define a condição de junção entre as tabelas. Aqui, especifica-se que a coluna "codigovendedor" das duas tabelas deve ser igual para que as linhas sejam combinadas.

5. **WHERE**: É uma cláusula opcional que permite filtrar as linhas retornadas pela consulta com base em uma ou mais condições. Nesse caso, a condição é que o campo "statusvenda" na tabela "dw.fato_vendas" seja igual a '1'.

6. **GROUP BY**: É utilizado para agrupar as linhas resultantes da consulta com base em uma ou mais colunas. Aqui, agrupa-se as linhas pelo "codigovendedor" e "nomevendedor".

7. **ORDER BY**: Ordena as linhas resultantes da consulta com base em uma ou mais colunas. Neste caso, as linhas são ordenadas em ordem decrescente com base na contagem de registros (*COUNT(*)*) de cada grupo.

8. **DESC**: Indica que a ordenação é feita em ordem decrescente. O padrão é a ordenação em ordem crescente.

9. **LIMIT**: Limita o número de linhas retornadas pela consulta. Nesse caso, limita-se a apenas uma linha, ou seja, o registro com o maior número de vendas.

Portanto, o resultado dessa consulta será uma única linha contendo o código e o nome do vendedor que possui o maior número de vendas (com status '1') na tabela "dw.fato_vendas".

    
