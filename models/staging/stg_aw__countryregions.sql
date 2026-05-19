with
    fonte_countryregions as (
        select * from {{ source('adventure_works', 'person_countryregion') }}
    )

    , renomeado as (
        select
              cast(countryregioncode as string) as pk_country_region
            , cast(name as string) as nome_pais
            , cast(modifieddate as timestamp) as dt_modificacao_pais
        from fonte_countryregions
    )

select *
from renomeado