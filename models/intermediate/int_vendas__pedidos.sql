with
    stg_header as (
        select * from {{ ref('stg_aw__salesorderheader') }}
    )

    , stg_detail as (
        select * from {{ ref('stg_aw__salesorderdetail') }}
    )

    , consolidacao_metricas as (
        select
            -- Chaves Primárias e Estrangeiras
              stg_detail.pk_sales_order_detail
            , stg_detail.fk_sales_order
            , stg_detail.fk_product
            , stg_header.fk_customer
            , stg_header.fk_credit_card
            , stg_header.fk_ship_to_address
            , stg_header.fk_bill_to_address
            
            -- Datas e Status
            , stg_header.dt_pedido
            , stg_header.status_pedido
            , stg_header.flag_venda_online
            
            -- Quantidades e Preços Base
            , stg_detail.qtd_item_pedido
            , stg_detail.preco_unitario_item
            , stg_detail.desconto_unitario_item
            
            -- Cálculos Financeiros por Item (Regras de Negócio para o BI)
            , (stg_detail.qtd_item_pedido * stg_detail.preco_unitario_item) as vl_faturamento_bruto
            
            , (stg_detail.qtd_item_pedido * stg_detail.preco_unitario_item * (1 - stg_detail.desconto_unitario_item)) as vl_faturamento_liquido
            
            -- Trazendo os valores totais do cabeçalho para a lógica de rateio
            , stg_header.vl_subtotal as total_pedido_subtotal
            , stg_header.vl_imposto as total_pedido_imposto
            , stg_header.vl_freight as total_pedido_frete

        from stg_detail
        left join stg_header on stg_detail.fk_sales_order = stg_header.pk_sales_order
    )

    , rateio_valores as (
        select
            *
            -- Regra de Negócio: Evita divisão por zero caso o subtotal seja zero
            , case 
                when total_pedido_subtotal > 0 
                then (vl_faturamento_liquido / total_pedido_subtotal) 
                else 0 
              end as percentual_participacao_item
        from consolidacao_metricas
    )

    , resultado_final as (
        select
            -- Selecionando os campos finais estruturados
              pk_sales_order_detail
            , fk_sales_order
            , fk_product
            , fk_customer
            , fk_credit_card
            , fk_ship_to_address
            , fk_bill_to_address
            , dt_pedido
            , status_pedido
            , flag_venda_online
            , qtd_item_pedido
            , preco_unitario_item
            , desconto_unitario_item
            , vl_faturamento_bruto
            , vl_faturamento_liquido
            
            , (total_pedido_frete * percentual_participacao_item) as vl_frete_proporcional
            , (total_pedido_imposto * percentual_participacao_item) as vl_imposto_proporcional

        from rateio_valores
    )

select * from resultado_final