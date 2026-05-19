with
    int_pedidos as (
        select * from {{ ref('int_vendas__pedidos') }}
    )

    , fato_vendas as (
        select
            -- Chave Primária da Fato (Identificador único da linha do item)
              pk_sales_order_detail as id_fato_venda
            
            -- Chaves Estrangeiras (Ligação direta com o seu Diagrama/Star Schema)
            , fk_sales_order as id_pedido
            , fk_product as sk_product
            , fk_customer as sk_customer
            , coalesce(fk_credit_card, 0) as sk_credit_card   -- Trata nulos caso a venda não tenha cartão
            , fk_ship_to_address as sk_location
            
            -- Ligação com a dim_dates (Convertendo o timestamp do pedido em data pura)
            , cast(dt_pedido as date) as sk_date
            
            -- Atributos de Contexto (Dimensões Degeneradas)
            , status_pedido
            , flag_venda_online
            , dt_pedido as dt_pedido_timestamp
            
            -- Métricas Quantitativas e Financeiras (Atenção Máxima aos Detalhes)
            , qtd_item_pedido as quantidade_itens
            , preco_unitario_item as preco_unitario
            , desconto_unitario_item as percentual_desconto
            
            -- Valores financeiros que calculamos e rateamos na Intermediate
            , vl_faturamento_bruto
            , vl_faturamento_liquido
            , vl_frete_proporcional
            , vl_imposto_proporcional

        from int_pedidos
    )

select * from fato_vendas