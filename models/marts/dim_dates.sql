with
    -- Gera uma sequência de datas de 01/01/2010 até 31/12/2020
    serie_datas as (
        select explode(sequence(to_date('2010-01-01'), to_date('2020-12-31'), interval 1 day)) as data_dia
    )

    , transformacao as (
        select
              cast(data_day as date) as sk_date  -- A própria data serve como chave substituta natural
            , year(data_day) as ano
            , month(data_day) as mes
            , date_format(data_day, 'MMMM') as nome_mes_longo
            , date_format(data_day, 'MMM') as nome_mes_curto
            , quarter(data_day) as trimestre
            , dayofmonth(data_day) as dia_do_mes
            , dayofweek(data_day) as dia_da_semana
            , date_format(data_day, 'EEEE') as nome_dia_semana
            
            -- Cria chaves de texto amigáveis como '2011-05' para ajudar na ordenação e filtros no BI
            , date_format(data_day, 'yyyy-MM') as ano_mes
        from (
            select data_dia as data_day from serie_datas
        )
    )

select * from transformacao