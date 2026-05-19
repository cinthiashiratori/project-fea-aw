with
    fonte_stateprovinces as (
        select * from {{ source('adventure_works', 'person_stateprovince') }}
    )

    , renomeado as (
        select
              cast(stateprovinceid as int) as pk_state_province
            , cast(territoryid as int) as fk_territory
            , cast(countryregioncode as string) as fk_country_region
            , cast(stateprovincecode as string) as sigla_estado
            , cast(name as string) as nome_estado
            , cast(modifieddate as timestamp) as dt_modificacao_estado
        from fonte_stateprovinces
    )

select *
from renomeado