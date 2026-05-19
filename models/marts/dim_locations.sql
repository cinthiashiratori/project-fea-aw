with
    int_locations as (
        select * from {{ ref('int_vendas__locations') }}
    )

    , dimensao_locations as (
        select
              pk_address as sk_location  -- Chave substituta (Surrogate Key) para ligar na Fato
            , nome_cidade
            , nome_estado
            , sigla_estado
            , nome_pais
        from int_locations
    )

select * from dimensao_locations