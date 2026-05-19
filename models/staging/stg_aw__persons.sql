with
    fonte_persons as (
        select * from {{ source('adventure_works', 'person_person') }}
    )

    , renomeado as (
        select
              cast(businessentityid as int) as pk_person
            , cast(firstname as string) as primeiro_nome
            , cast(middlename as string) as segundo_nome
            , cast(lastname as string) as ultimo_nome
            , cast(modifieddate as timestamp) as dt_modificacao_pessoa
        from fonte_persons
    )

select *
from renomeado