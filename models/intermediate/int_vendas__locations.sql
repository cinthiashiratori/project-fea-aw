with
    stg_addresses as (
        select * from {{ ref('stg_aw__addresses') }}
    )

    , stg_stateprovinces as (
        select * from {{ ref('stg_aw__stateprovinces') }}
    )

    , stg_countryregions as (
        select * from {{ ref('stg_aw__countryregions') }}
    )

    , cruzamento_locations as (
        select
              stg_addresses.pk_address
            , stg_stateprovinces.fk_territory
            , stg_addresses.nome_cidade
            , stg_stateprovinces.nome_estado
            , stg_stateprovinces.sigla_estado
            , stg_countryregions.nome_pais
            , stg_addresses.cod_postal as codigo_postal

        from stg_addresses
        left join stg_stateprovinces on stg_addresses.fk_state_province = stg_stateprovinces.pk_state_province
        left join stg_countryregions on stg_stateprovinces.fk_country_region = stg_countryregions.pk_country_region
    )

select * from cruzamento_locations