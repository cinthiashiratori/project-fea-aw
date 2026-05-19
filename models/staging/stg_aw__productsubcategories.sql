with
    fonte_productsubcategories as (
        select * from {{ source('adventure_works', 'production_productsubcategory') }}
    )

    , renomeado as (
        select
              cast(productsubcategoryid as int) as pk_product_subcategory
            , cast(productcategoryid as int) as fk_product_category
            , cast(name as string) as nome_subcategoria_produto
            , cast(modifieddate as timestamp) as dt_modificacao_subcategoria
        from fonte_productsubcategories
    )

select *
from renomeado