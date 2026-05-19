with
    fonte_salesorderheader as (
        select *
        from {{ source('adventure_works', 'sales_salesorderheader') }}
    )

    , renomeado as (
        select
            cast(salesorderid as int) as pk_sales_order
            , cast(customerid as int) as fk_customer
            , cast(billtoaddressid as int) as fk_bill_to_address
            , cast(shiptoaddressid as int) as fk_ship_to_address
            , cast(creditcardid as int) as fk_credit_card
            , cast(status as int) as status_pedido
            , cast(onlineorderflag as boolean) as flag_venda_online
            , cast(orderdate as timestamp) as dt_pedido
            , cast(duedate as timestamp) as dt_vencimento
            , cast(shipdate as timestamp) as dt_envio
            , cast(subtotal as numeric(18,2)) as vl_subtotal
            , cast(taxamt as numeric(18,2)) as vl_imposto
            , cast(freight as numeric(18,2)) as vl_freight
            , cast(totaldue as numeric(18,2)) as vl_total_devido
            , cast(modifieddate as timestamp) as dt_modificacao
        from fonte_salesorderheader
    )

select *
from renomeado