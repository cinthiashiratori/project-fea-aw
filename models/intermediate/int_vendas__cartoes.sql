with
    stg_creditcards as (
        select * from {{ ref('stg_aw__creditcards') }}
    )

    , transformacao as (
        select
              stg_creditcards.pk_credit_card
            
            -- Tratamento de nulos para a bandeira do cartão
            , coalesce(stg_creditcards.bandeira_cartao, 'Não Identificado') as bandeira_cartao

        from stg_creditcards
    )

select * from transformacao