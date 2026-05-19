with
    int_cartoes as (
        select * from {{ ref('int_vendas__cartoes') }}
    )

    , dimensao_cartoes as (
        select
              pk_credit_card as sk_credit_card  -- Chave substituta (Surrogate Key) para ligar na Fato
            , bandeira_cartao
        from int_cartoes
    )

select * from dimensao_cartoes