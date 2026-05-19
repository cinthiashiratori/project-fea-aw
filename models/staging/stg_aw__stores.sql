with
    fonte_stores as (
        select * from {{ source('adventure_works', 'sales_store') }}
    )

    , renomeado as (
        select
              cast(businessentityid as int) as pk_store
            , cast(name as string) as nome_loja
            , cast(modifieddate as timestamp) as dt_modificacao_loja
        from fonte_stores
    )

select *
from renomeado