with
    fonte_products as (
        select * 
        from {{ source('adventure_works', 'production_product') }}
    )

    , renomeado as (
        select
              cast(productid as int) as pk_product
            , cast(productsubcategoryid as int) as fk_product_subcategory
            , cast(name as string) as nome_produto
            , cast(productnumber as string) as codigo_produto
            , cast(standardcost as numeric) as custo_padrao
            , cast(listprice as numeric) as preco_listado
        from fonte_products
    )

select *
from renomeado