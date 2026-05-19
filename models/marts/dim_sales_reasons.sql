with
    int_sales_reasons as (
        select * from {{ ref('int_vendas__sales_reasons') }}
    )

    , dimensao_sales_reasons as (
        select
              fk_sales_order                         -- Mantemos o ID do pedido para servir de elo com a Fato/Ponte
            , fk_sales_reason as sk_sales_reason     -- Chave substituta do motivo
            , nome_motivo_venda
            , tipo_motivo_venda
        from int_sales_reasons
    )

select * from dimensao_sales_reasons