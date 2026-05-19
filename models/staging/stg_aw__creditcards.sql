with
    fonte_creditcards as (
        select * from {{ source('adventure_works', 'sales_creditcard') }}
    )

    , renomeado as (
        select
              cast(creditcardid as int) as pk_credit_card
            , cast(cardtype as string) as bandeira_cartao
            , cast(modifieddate as timestamp) as dt_modificacao_cartao
        from fonte_creditcards
    )

select *
from renomeado