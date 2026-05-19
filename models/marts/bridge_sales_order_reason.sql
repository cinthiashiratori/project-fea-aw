with
    int_sales_reasons as (
        select * from {{ ref('int_vendas__sales_reasons') }}
    )

    , bridge_motivos as (
        select
              fk_sales_order as sales_order_id      -- Chave que liga direto na Fato (fct_sales)
            , fk_sales_reason as sales_reason_id    -- Chave que liga na dim_sales_reasons
        from int_sales_reasons
    )

select * from bridge_motivos