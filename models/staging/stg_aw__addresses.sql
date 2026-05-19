with
    fonte_addresses as (
        select * from {{ source('adventure_works', 'person_address') }}
    )

    , renomeado as (
        select
              cast(addressid as int) as pk_address
            , cast(stateprovinceid as int) as fk_state_province
            , cast(city as string) as nome_cidade
            , cast(postalcode as string) as cod_postal
            , cast(modifieddate as timestamp) as dt_modificacao_endereco
        from fonte_addresses
    )

select *
from renomeado