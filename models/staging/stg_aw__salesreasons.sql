with
    fonte_salesreasons as (
        select * from {{ source('adventure_works', 'sales_salesreason') }}
    )

    , renomeado as (
        select
              cast(salesreasonid as int) as pk_sales_reason
            , cast(name as string) as nome_motivo_venda
            , cast(reasontype as string) as tipo_motivo_venda
            , cast(modifieddate as timestamp) as dt_modificacao_motivo
        from fonte_salesreasons
    )

select *
from renomeado