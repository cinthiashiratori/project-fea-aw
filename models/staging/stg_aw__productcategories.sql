with
    fonte_productcategories as (
        select * from {{ source('adventure_works', 'production_productcategory') }}
    )

    , renomeado as (
        select
              cast(productcategoryid as int) as pk_product_category
            , cast(name as string) as nm_product_category
            , cast(modifieddate as timestamp) as dt_modificacao_categoria
        from fonte_productcategories
    )

select *
from renomeado