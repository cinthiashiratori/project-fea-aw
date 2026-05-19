with
    int_produtos as (
        select * from {{ ref('int_vendas__produtos') }}
    )

    , dimensao_produtos as (
        select
              pk_product as sk_product  -- Chave substituta (Surrogate Key) para a Fato
            , nome_produto
            , codigo_produto
            , nome_subcategoria
            , nome_categoria
            , custo_padrao
            , preco_listado
        from int_produtos
    )

select * from dimensao_produtos