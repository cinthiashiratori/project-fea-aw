with
    stg_order_reasons as (
        select * from {{ ref('stg_aw__salesorderheadersalesreasons') }}
    )

    , stg_reasons as (
        select * from {{ ref('stg_aw__salesreasons') }}
    )

    , cruzamento_motivos as (
        select
              stg_order_reasons.fk_sales_order
            , stg_order_reasons.fk_sales_reason
            , stg_reasons.nome_motivo_venda
            , stg_reasons.tipo_motivo_venda

        from stg_order_reasons
        left join stg_reasons on stg_order_reasons.fk_sales_reason = stg_reasons.pk_sales_reason
    )

select * from cruzamento_motivos