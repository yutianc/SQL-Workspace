/*
--
-- 参数：p_co_code   公司
        p_date  期间

--1. 获取辅助分类帐 (辅助分类帐为现金制会计准则）
--2. 删除cash_flow_temp 的数据  （本月）  清理删除 cash_flow_balances （次月）

*/


--1. 获取辅助分类帐 (辅助分类帐为现金制会计准则） 2024
  SELECT glr.target_ledger_id
--    INTO v_sub_ledger_id  --2024
    FROM gl.gl_ledger_relationships glr, gl.gl_ledgers gl
   WHERE glr.source_ledger_id = gl.ledger_id
     AND gl.ledger_id = :v_set_of_bks_id  --2023
     AND glr.target_ledger_category_code = 'SECONDARY'
     AND glr.relationship_type_code = 'SUBLEDGER'
        --AND target_ledger_id = v_sub_ledger_id
     --AND glr.target_currency_code = 'CNY'    --外币帐套也要使用现金流量表20130915
     AND glr.primary_ledger_id = :v_set_of_bks_id
     AND glr.relationship_enabled_flag = 'Y'
     AND glr.application_id = 101
;


    --删除cash_flow_temp 的本月数据
    DELETE FROM cux.cux_gl_cash_flow_temp
     WHERE period_name = :p_date  --当月数据清除
       AND segment1 = :v_org_code --公司
    ;
    --删除cash_flow_balances 的下月数据
    DELETE FROM cux.cux_gl_cash_flow_balances
     WHERE period_name = v_next_period
       AND segment1 = v_org_code;

SELECT fvl2.flex_value_meaning,
               fvl2.description,
               fvl2.attribute2,
               fvl2.attribute3,
               fvl2.attribute4,
               fvl2.attribute5,
               fvl2.attribute6,
               fvl2.compiled_value_attributes
          FROM fnd_flex_values_vl fvl2, fnd_flex_value_sets fvs2
         WHERE fvl2.flex_value_set_id = fvs2.flex_value_set_id
           AND fvs2.flex_value_set_name = 'SOHO_COA_AC'
           AND nvl(fvl2.enabled_flag, 'N') = 'Y'
           AND nvl(fvl2.summary_flag, 'N') = 'N'
        --AND fvl2.value_category = 'SOHO_COA_AC'
        order by fvl2.flex_value_meaning
;



      SELECT jb.name                  batch_name,
             jh.name                  header_name,
             jh.je_header_id,
             jl.je_line_num,
             jl.period_name,
             jh.currency_code,
             gcc.chart_of_accounts_id,
             jl.code_combination_id,
             gcc.segment1,
             gcc.segment3,
             jl.entered_dr,
             jl.entered_cr,
             jl.accounted_dr,
             jl.accounted_cr,
             (SELECT nvl(drv1.conversion_rate, 1)
                FROM gl_daily_rates_v drv1
               WHERE drv1.user_conversion_type(+) = 'SOHO_Daily Rate'
                 AND drv1.from_currency(+) = p_currency_code
                 AND drv1.to_currency(+) = 'CNY' --USD
                 AND drv1.conversion_date(+) = g_pre_last_day) to_cny,
             (SELECT nvl(drv2.conversion_rate, 1)
                FROM gl_daily_rates_v drv2
               WHERE drv2.user_conversion_type(+) = 'SOHO_Daily Rate'
                 AND drv2.from_currency(+) = p_currency_code --
                 AND drv2.to_currency(+) = 'USD' --USD-58
                 AND drv2.conversion_date(+) = g_pre_last_day) to_usd,
             nvl(ad.attribute2, 'N') attribute2,
             COUNT(*) over(PARTITION BY jh.je_header_id) jl_count,
             decode(instr(ad.attribute5, ad.attribute6),
                    1,
                    ad.attribute5,
                    0,
                    decode(nvl(jl.accounted_dr, 0)
                           /*sign(decode(jh.currency_code,
                                  'CNY',
                                  nvl(jl.accounted_dr, 0),
                                  nvl(jl.entered_dr, 0)) -
                           decode(jh.currency_code,
                                  'CNY',
                                  nvl(jl.accounted_cr, 0),
                                  nvl(jl.entered_cr, 0)))*/,
                           0,
                           ad.attribute6,
                           ad.attribute5)) bx
        FROM gl.gl_je_batches        jb,
             gl.gl_je_headers        jh,
             gl.gl_je_lines          jl,
             gl.gl_code_combinations gcc,
             (      SELECT fvl2.flex_value_meaning,
                           fvl2.description,
                           fvl2.attribute2,
                           fvl2.attribute3,
                           fvl2.attribute4,
                           fvl2.attribute5,
                           fvl2.attribute6,
                           fvl2.compiled_value_attributes
                      FROM fnd_flex_values_vl fvl2, fnd_flex_value_sets fvs2
                     WHERE fvl2.flex_value_set_id = fvs2.flex_value_set_id
                       AND fvs2.flex_value_set_name = 'SOHO_COA_AC'
                       AND nvl(fvl2.enabled_flag, 'N') = 'Y'
                       AND nvl(fvl2.summary_flag, 'N') = 'N'
             )            ad
       WHERE jb.je_batch_id = jh.je_batch_id
         AND jh.je_header_id = jl.je_header_id
         AND jh.ledger_id = :p_sub_ledger_id --2023 --v_sub_ledger_id 2024
         AND jh.period_name = :p_date --'2012-12'p_date --会计期间
         AND jl.code_combination_id = gcc.code_combination_id
         AND gcc.segment1 = :p_org_code -- '1090'
         AND ad.flex_value_meaning = gcc.segment3
       ORDER BY jh.je_header_id
       ;
       
       
       