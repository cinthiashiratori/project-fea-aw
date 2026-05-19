with
    fonte_salesorderheadersalesreasons as (
        select * from {{ source('adventure_works', 'sales_salesorderheadersalesreason') }}
    )

    , renomeado as (
        select
              cast(salesorderid as int) as fk_sales_order
            , cast(salesreasonid as int) as fk_sales_reason
            , cast(modifieddate as timestamp) as dt_modificacao_pedido_motivo
        from fonte_salesorderheadersalesreasons
    )

select *
from renomeado