with
    int_clientes as (
        select * from {{ ref('int_vendas__clientes') }}
    )

    , dimensao_clientes as (
        select
              pk_customer as sk_customer  -- Transformando a PK em Surrogate Key/Chave de Negócio da dimensão
            , nome_cliente
            , tipo_cliente
        from int_clientes
    )

select * from dimensao_clientes