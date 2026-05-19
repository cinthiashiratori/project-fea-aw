with
    stg_products as (
        select * from {{ ref('stg_aw__products') }}
    )

    , stg_subcategories as (
        select * from {{ ref('stg_aw__productsubcategories') }}
    )

    , stg_categories as (
        select * from {{ ref('stg_aw__productcategories') }}
    )

    , cruzamento_produtos as (
        select
              stg_products.pk_product
            , stg_products.nome_produto
            , stg_products.codigo_produto
            
            , coalesce(stg_subcategories.nome_subcategoria_produto, 'Sem Subcategoria') as nome_subcategoria
            , coalesce(stg_categories.nm_product_category, 'Sem Categoria') as nome_categoria
            
            , stg_products.custo_padrao
            , stg_products.preco_listado

        from stg_products
        left join stg_subcategories on stg_products.fk_product_subcategory = stg_subcategories.pk_product_subcategory
        left join stg_categories on stg_subcategories.fk_product_category = stg_categories.pk_product_category
    )

select * from cruzamento_produtos