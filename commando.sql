with
    aux_mes_referencia as (
        select
            trunc (date_trunc ('month', dat_previous_du)) as mes_ref, --- mes atual considerando sempre D-1
            dat_previous_du
        from
            dax_share_pagamentos.dim_calendar
        where
            dat_ref = current_date
    ),
    referencias as (
        select
            to_char (mes_ref, 'yyyy-mm') as mes_ref
        from
            aux_mes_referencia -- M0
        union
        select
            To_char (
                DATE_TRUNC ('month', DATEADD (month, -1, mes_ref)),
                'yyyy-mm'
            ) as mes_ref
        from
            aux_mes_referencia --- m-1 
        union
        select
            To_char (
                DATE_TRUNC ('month', DATEADD (month, -12, mes_ref)),
                'yyyy-mm'
            ) as mes_ref
        from
            aux_mes_referencia --- m-12
    ),
    carteiras as (
        select
            idt_safepay_user,
            des_portfolio
        from
            dax_share_dax.ent_customer_portfolio_psp
        where
            flg_active = 'A'
    ),
    datas as (
        select
            to_char (dat_ref, 'yyyy-mm') mes_ref,
            TRUNC (dat_ref) dat_ref,
            case
                when num_day <= DATEPART (day, CURRENT_DATE) then 1
                else 0
            end fl_mtd,
            case
                when des_year_month = to_char (current_date, 'yyyy-mm') then 1
                else 0
            end fl_mes_atual
        from
            dax_share_pagamentos.dim_calendar
        where
            des_year_month in (
                select distinct
                    *
                from
                    referencias
            )
    ),
    menor_dt as (
        select
            to_char (dat_contrib_margin, 'yyyy-mm') as mes_ref,
            idt_safepay_creditor,
            c.des_portfolio,
            min(trunc (dat_contrib_margin)) menor_dt_no_mes
        from
            dax_share_dax.ent_contribution_margin_kpi_values_psp kpi
            inner join carteiras c on c.idt_safepay_user = kpi.idt_safepay_creditor
        where
            to_char (dat_contrib_margin, 'yyyy-mm') in (
                select distinct
                    *
                from
                    referencias
            )
            and num_tpv_value > 0
        group by
            to_char (dat_contrib_margin, 'yyyy-mm'),
            idt_safepay_creditor,
            c.des_portfolio
    )
select
    a.mes_ref,
    a.dat_ref,
    a.fl_mtd,
    a.fl_mes_atual,
    coalesce(b.des_portfolio, 'Longtail') as des_portfolio,
    count(distinct idt_safepay_creditor) as qtde_id
from
    datas a
    left join menor_dt b on a.mes_ref = b.mes_ref
    and a.dat_ref >= b.menor_dt_no_mes
    ----where idt_safepay_creditor = 10536126
group by
    a.mes_ref,
    a.dat_ref,
    a.fl_mtd,
    a.fl_mes_atual,
    b.des_portfolio