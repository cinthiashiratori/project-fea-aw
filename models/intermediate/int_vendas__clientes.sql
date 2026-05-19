with
    stg_customers as (
        select * from {{ ref('stg_aw__customers') }}
    )

    , stg_persons as (
        select * from {{ ref('stg_aw__persons') }}
    )

    , stg_stores as (
        select * from {{ ref('stg_aw__stores') }}
    )

    , transformacao as (
        select
              stg_customers.pk_customer
            , stg_customers.fk_territory
            
            , case 
                when stg_persons.pk_person is not null 
                then trim(coalesce(stg_persons.primeiro_nome, '') || ' ' || coalesce(stg_persons.segundo_nome, '') || ' ' || coalesce(stg_persons.ultimo_nome, ''))
                else trim(stg_stores.nome_loja)
              end as nome_cliente
              
            , case 
                when stg_persons.pk_person is not null then 'Pessoa Física'
                else 'Pessoa Jurídica'
              end as tipo_cliente
              
            , stg_customers.dt_modificacao_cliente

        from stg_customers
        left join stg_persons on stg_customers.fk_person = stg_persons.pk_person
        left join stg_stores on stg_customers.fk_store = stg_stores.pk_store
    )

select * from transformacao