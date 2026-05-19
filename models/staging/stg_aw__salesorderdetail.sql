with
    fonte_salesorderdetail as (
        select * 
        from {{ source('adventure_works', 'sales_salesorderdetail') }}
    )

    , renomeado as (
        select
              cast(salesorderdetailid as int) as pk_sales_order_detail
            , cast(salesorderid as int) as fk_sales_order
            , cast(productid as int) as fk_product
            , cast(orderqty as int) as qtd_item_pedido
            , unitprice as preco_unitario_item
            , unitpricediscount as desconto_unitario_item
            , cast(modifieddate as timestamp) as dt_modificacao_item
        from fonte_salesorderdetail
    )

select *
from renomeado