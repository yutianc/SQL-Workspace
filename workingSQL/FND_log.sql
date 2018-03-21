select * from jai_debug_log_chong order by NVL(num,0) asc;

select * from ad_applied_patches where patch_name = '16414088';

truncate table "APPLSYS"."FND_LOG_MESSAGES";

SELECT /*+ rule*/ 
a.sid, b.owner, object_name, object_type , TYPE
FROM v$lock a, all_objects b 
WHERE 1=1
and TYPE = 'TM' 
and a.id1 = b.object_id; 

SELECT sid,serial# FROM v$session WHERE sid = 347; 
alter system kill session '58713';


        SELECT *
          FROM FND_PROFILE_OPTIONS_VL TT
         WHERE TT.PROFILE_OPTION_NAME LIKE 'AR_DEL_FRM_GT_CNT';


SELECT max(log_sequence)
FROM apps.fnd_log_messages
WHERE 1=1;   ---organization_id : 12087 location_id : 39413

select NVL(FND_PROFILE.value('AR_DEL_FRM_GT_CNT'), 1000) from dual;

select *
from apps.fnd_log_messages
where  1=1
and log_sequence > 4486976 -- 4319128  --494937 --14040280--52590890  --67870333 --67742332 --61632500 --12386089  --
--and log_sequence < 14051234
--and    log_sequence <= 67873800--67998458
--and (module like 'CUX%'    or module like 'PO%'   or module like 'AP%'  /* or module like 'fnd.src.process.%'*/  or module like 'ZX%'   ) 
--and (module like 'CUX%')
--and module like 'ZX.PLSQL.ZX_TDS_RULE_BASE_DETM_PVT%'
--and log_level >= 3
--and (module like 'ar.%' or module like  'fnd%')
--and module not like 'fnd%'
--and process_id = 5100
--and module like 'ar.plsql.arp_cr_batches_pkg%'
--and module not like 'ZX%'
order by log_sequence asc
;


select source_id check_id, count(*)
from ap_accounting_events_all
where event_type_code = 'PAYMENT CANCELLATION'
group by source_id
having count(*) > 1;

select * from gl_code_combinations_kfv where code_combination_id = 2239;


select * from dba_errors where name like 'ZX%';
select * from dba_objects where object_name like 'ZX_TDS_RULE_BASE%';

select *
from xla_events
where application_id = 275
and   event_status_code <> 'P'
order by creation_date desc;


select h.*
from   xla.xla_ae_headers   h
      ,xla.xla_ae_lines     l
where h.ae_header_id = l.ae_header_id
and   h.event_type_code = 'MISC_COST_DIST_ADJ'
/*
and   h.event_id in (76655
,76674
,76657
,76658
,76659
,76660
,76661
,76662
,76663
,76664
,76665
,76666
,76667
,76668
,76669
,76670
,76671
,76672
,76673
,76656
)
*/
order by h.accounting_date desc
;

select * from fnd_application where application_short_name = 'PA';




--duplicate resource ID check 
     SELECT 1
     FROM jtf_rs_resource_extns
     WHERE source_id = p_source_id
       AND category = 'EMPLOYEE';
       ;


select * from dba_users;

select count(1) from AR_DOC_SEQUENCE_AUDIT;


    SELECT COUNT(1)
      INTO lv_count
      FROM ra_customer_trx_all      rct,
           ar_payment_schedules_all apsa,
           ar_adjustments_all       aaa
     WHERE rct.customer_trx_id = apsa.customer_trx_id
       AND apsa.payment_schedule_id = aaa.payment_schedule_id
       AND rct.trx_number = pTrx_number
       AND rct.org_id = porg_id;

select *
from fnd_log_messages
where  1=1
and log_sequence > 20969118 --61632500 --12386089  --
--and    log_sequence <= 62759532
--and (module like 'CUX%'    or module like 'PO%'   or module like 'AP%'  /* or module like 'fnd.src.process.%'*/  or module like 'ZX%'   ) 
--and module like 'ZX.PLSQL.ZX_TDS_RULE_BASE_DETM_PVT%'
--and log_level >3
--and (module like 'ar.%' or module like  'fnd%')
--and message_text like '%1:已阻止此操作，以避免生成不准确的会计分录。请联系 Oracle 支持服务�?%'
--and process_id = 15246
order by process_id,log_sequence desc
;


/*
create table cux.fnd_log_for_chong_test
as
select * 
from fnd_log_messages
where  1=1
and log_sequence > 61632500 --12386089  --
and    log_sequence <= 62759532
--and (module like 'CUX%'    or module like 'PO%'   or module like 'AP%'  /* or module like 'fnd.src.process.%'*/  or module like 'ZX%'   ) 
--and module like 'ZX.PLSQL.ZX_TDS_RULE_BASE_DETM_PVT%'
--and log_level >3
--and (module like 'ar.%' or module like  'fnd%')
--and message_text like '%1:已阻止此操作，以避免生成不准确的会计分录。请联系 Oracle 支持服务�?%'
order by log_sequence asc
;
*/
select * from cux.fnd_log_for_chong_test order by process_id, log_sequence asc;

select * from FND_FORM_CUSTOM_ACTIONS;



create database link to_test
�?�?connect to apps identified by apps
�?�?using '(DESCRIPTION=
                (ADDRESS=(PROTOCOL=tcp)(HOST=192.168.100.24)(PORT=1527))
            (CONNECT_DATA=
                (SERVICE_NAME=TEST06)
                (INSTANCE_NAME=TEST06)
            )
        )';



select * from ap_invoice_distributions_all where invoice_id = 155942;

(SELECT meaning
                FROM fnd_lookup_values lv
               WHERE LANGUAGE = 'ZHS'
                 AND view_application_id = 660
                 AND security_group_id = 0
                 AND lookup_type = 'FLOW_STATUS'
                 AND lookup_code = b.flow_status_code);



and ( upper(MODULE) like 'JAI%' 
   --   or upper(MODULE) like 'ZX%' 
    )  --390817
and module not like 'JAI.PLSQL.JAI_TAX_DETERMINATION_PKG%'
--and module like 'JAI.PLSQL.JAI_INTERORG_PKG%'
--and module like 'JAI.PLSQL.JAI_INV_NUM_GEN_PKG%'
--and log_level = 6
--and module not like 'JAI.PLSQL.JAI_AP_IDA_PROC_PKG%'
--and (module like 'JAI.PLSQL.JAI_AP_DTC_GENERATION_PKG.populate_tds_invoice_id%' or module like 'JAI.PLSQL.JAI_AP_TDS_POP_RPS%')
order by log_sequence asc
;


select *
from   fnd_log_messages
where 1 = 1
and log_sequence > 96832586 
and module = 'fnd.plsql.fnd_file.PUT_LINE'
ORDER BY process_id, log_sequence asc
;





select * from jai_tax_defaulting_basis;

select * from JAI_AP_WTHLD_THHOLD_EXCP_V;

      SELECT *
        FROM jai_tax_lines jtl
       WHERE jtl.trx_loc_line_id = 3744301
         AND jtl.trx_number = 2078
         AND entity_code = 'RCV_TRANSACTION'
         AND EXISTS
       (SELECT 'X'
                FROM JAI_EXTENSION_SETUPS jts
               WHERE jts.setup_for = 'TRADING'
                 /*AND trunc(SYSDATE) BETWEEN trunc(jts.header_effective_from) AND
                     trunc(nvl(jts.header_effective_to, SYSDATE))*/
                 AND trunc(SYSDATE) BETWEEN trunc(jts.line_effective_from) AND
                     trunc(nvl(jts.line_effective_to, SYSDATE))
                 AND jts.tax_type_id = jtl.tax_type_id);
                 

select * from ap_interfaces;

select * from ra_interface_lines;

--and log_level >3
order by process_id desc, log_sequence asc;


select * from jai_ap_tds_repository;


select * 
from fnd_log_messages
where  log_sequence > 97447429-- 129041888 --108941031    129030163   --134123520
and ( upper(MODULE) like 'JAI%' 
   --   or upper(MODULE) like 'ZX%' 
    )  --390817
and module not like 'JAI.PLSQL.JAI_TAX_DETERMINATION_PKG%'
--and module like 'JAI.PLSQL.JAI_INV_NUM_GEN_PKG%'
--and log_level >3
order by  log_sequence asc;

select INSTR(rcta.ct_reference, 'Prefix1115'), rcta.ct_reference || 'Prefix1115'
from ra_customer_trx_all  rcta
          WHERE  rcta.CUSTOMER_TRX_ID = 759622
          ;
          
          


select * from ra_customer_trx_all order by customer_trx_id desc;

    SELECT COUNT(1)
    FROM   jai_tax_det_factors jtdf
          ,jai_tax_lines       jtl
          ,mtl_system_items_b  item
    WHERE  jtdf.item_id = item.inventory_item_id
    AND    jtdf.organization_id = item.organization_id
    AND    jtdf.det_factor_id = jtl.det_factor_id
    AND    jtdf.trx_id = 391432                   -- in the same order
--  AND    NVL(item.shippable_item_flag,'N') = 'N'   -- non-shippable item line
    AND    jtdf.application_id = 660
    AND    jtl.tax_invoice_num IS NOT NULL
    ;

select * from jai_jrnal_srcs_ctgrs;
select * from gl_interface order by date_created desc;


select * 
from fnd_log_messages
where log_sequence > 151208859 --100579676
and ( upper(MODULE) like 'JA%')  --390817
and module not like 'JAI.PLSQL.JAI_TAX_DETERMINATION_PKG%'
--and log_level >3
order by log_sequence asc;


  SELECT *
  FROM   jai_jrnal_srcs_ctgrs  jjsc
  WHERE  jjsc.application_id = 707
  AND    jjsc.entity_code = 'RCV_TRANSACTION'
  AND    jjsc.event_class_code = 'RECEIVING'
  AND    jjsc.event_type_code = :pv_event_type_code
  AND    jjsc.tax_event_class_code = 'PURCHASE_TRANSACTION'
  AND    jjsc.tax_event_type_code = :pv_tax_event_class_code
  AND    ( jjsc.trx_type = 'RECEIVE')
  
  ;
  --Input parameters: pn_application_id = 707,pv_entity_code = RCV_TRANSACTION,pv_event_class_code = RECEIVING,pv_event_type_code = ,pv_tax_event_class = PURCHASE_TRANSACTION,pv_tax_event_type = ,pv_trx_type = RECEIVE


select * 
from fnd_log_messages
where log_sequence > 96558142
and ( upper(MODULE) like 'JA%')  --ST
--and log_level >3
order by log_sequence asc;

select * 
from fnd_log_messages
where log_sequence > 100109593
and ( upper(MODULE) like 'JA%')  --ST
--and log_level >3
order by log_sequence asc;

select * 
from fnd_log_messages
where log_sequence > 96566061
and ( upper(MODULE) like 'JA%')  --ST
--and log_level >3
order by log_sequence asc;

select * from OBJECT_LIST where application_id = '7000';

select * from dba_objects where object_name like 'OBJECT_LIST%';




select * 
from fnd_log_messages
where log_sequence > 103991215
and ( upper(MODULE) like 'JA%')  --PT
--and log_level >3
order by log_sequence asc;

select * 
from fnd_log_messages
where log_sequence > 96558142
--and ( upper(MODULE) like 'JA%')  --390817
--and log_level >3
order by log_sequence asc;


select * 
from fnd_log_messages
where log_sequence > 186632946
and ( upper(MODULE) like 'JA%')  --390817
--and log_level >3
order by log_sequence asc;


select * 
from fnd_log_messages
where log_sequence > 96127910
--and log_sequence < 85274329
--and not (  ( upper(MODULE) like 'AP%')) --390817
--and log_level >3
order by log_sequence asc;

select * 
from fnd_log_messages
where log_sequence > 82257331
and ( upper(MODULE) like 'JA%' )    --412830  JAI.PLSQL.JAI_AP_DTC_GENERATION_PKG.process_dtc_at_inv_validate().Parameters
order by log_sequence asc;


select * 
from fnd_log_messages
where log_sequence > 82257331
and ( MODULE like 'JAI.PLSQL.JAI_AP_DTC_GENERATION_PKG.process_dtc_at_inv_validate().Parameters' ) 
order by log_sequence asc;

select * 
from fnd_log_messages
where log_sequence > 96519228 --198444099 
and ( upper(MODULE) like 'JA%' or upper(MODULE) like 'ZX%' or upper(MODULE) like 'AP%')  
order by log_sequence asc;




SELECT *
FROM fnd_log_messages
WHERE 1=2
--and module like 'ZX.PLSQL.ZX_API_PUB.GLOBAL_DOCUMENT_UPDATE%'
--AND TIMESTAMP > SYSDATE - .1
AND (
    ( upper(MODULE) like 'JA%' )
OR ( upper(MODULE) like 'JAI%populate_repository()'  )
)
--and (upper(module) like 'JAI_AP_DTC_GENERATION_PKG.%')
--and log_sequence > 806438585
--and log_sequence > 806444996
and log_sequence > 151259644
and log_sequence < 151261106
ORDER BY log_sequence asc;

select * from fnd_log_messages
where module = 'JAI.PLSQL.JAI_TDS_GDF_TAX_UI_UPG'
order by log_sequence asc;


select * from r_inv_dist;


--Get FND_log for concurrent program.--
SELECT substr(module,1,70), MESSAGE_TEXT, timestamp, log_sequence
FROM fnd_log_messages msg, fnd_log_transaction_context tcon
WHERE msg.TRANSACTION_CONTEXT_ID = tcon.TRANSACTION_CONTEXT_ID
AND tcon.TRANSACTION_ID = &child_request_ID_with_problem
ORDER BY LOG_SEQUENCE;

select * from fnd_log_transaction_context ;


select *
from fnd_log_messages
where 1=1
and log_sequence > 631498
order by log_sequence;


SELECT *
FROM fnd_log_messages
WHERE 1=1 
--and module like 'ZX.PLSQL.ZX_API_PUB.GLOBAL_DOCUMENT_UPDATE%'
--AND TIMESTAMP > SYSDATE - .1
--AND ( upper(MODULE) like 'JA%' )
AND ( upper(MODULE) like 'AP%' )
and rownum < 1000
ORDER BY log_sequence DESC;


SELECT *
FROM fnd_log_messages
WHERE 1=1 
--and module like 'ZX.PLSQL.ZX_API_PUB.GLOBAL_DOCUMENT_UPDATE%'
--AND TIMESTAMP > SYSDATE - .1
--AND ( upper(MODULE) like 'JA%' )
AND (
( upper(MODULE) like 'JAI%' )
OR ( MODULE like 'trigger_on_lines_all%' )
or (module like 'After%trigger%')
)
AND log_sequence > 631498      --AND log_sequence <= 88983667
ORDER BY log_sequence DESC;

SELECT *
FROM fnd_log_messages
WHERE 1=1 
--and module like 'ZX.PLSQL.ZX_API_PUB.GLOBAL_DOCUMENT_UPDATE%'
--AND TIMESTAMP > SYSDATE - .1
--AND ( upper(MODULE) like 'JA%' )
AND ( upper(MODULE) like 'AP%' )
AND log_sequence > 122694995      --AND log_sequence <= 88983667
ORDER BY log_sequence DESC;

SELECT *
FROM fnd_log_messages
WHERE 1=1 
--and module like 'ZX.PLSQL.ZX_API_PUB.GLOBAL_DOCUMENT_UPDATE%'
--AND TIMESTAMP > SYSDATE - .1
AND ( MODULE like 'trigger_on_lines_all%' )
--AND log_sequence > 96641328      --AND log_sequence <= 88983667
ORDER BY log_sequence DESC;


SELECT *
FROM fnd_log_messages
WHERE 1=1 
--and module like 'ZX.PLSQL.ZX_API_PUB.GLOBAL_DOCUMENT_UPDATE%'
--AND TIMESTAMP > SYSDATE - .1
--AND ( upper(MODULE) like 'JA%' )
AND ( upper(MODULE) like 'JAI%' )
and log_sequence > 732131800
ORDER BY log_sequence asc;




SELECT *
FROM fnd_log_messages
WHERE 1=1 
--and module like 'ZX.PLSQL.ZX_API_PUB.GLOBAL_DOCUMENT_UPDATE%'
--AND TIMESTAMP > SYSDATE - .1
--AND ( upper(MODULE) like 'JA%' )
--AND log_sequence > 76368660 --  and log_sequence < 121834841  --96680085
and log_sequence > 96557336 
--and log_sequence < 85274329
--and log_sequence < 151375808
and module not like 'IEMDOWNLOAD%'
and module not like 'XDP_%'
and module not like 'jtf.cache%'
and module not like 'fnd.security.%'  and module not like 'PLSQL.FND.SECURITY.%'
and module not like 'fnd.common.%'
and module not like 'per.resource.%'
and module not like 'IEMDPM#EMTA.%'
and module not like 'fnd.profiles.%'
and module not like 'fnd.sso.%'
and module not like 'fnd.framework.%'
--and module not like 'AP.%'
and module not like 'PO.%'
and module not like 'xla.%'
and module not like 'iby.%'
and module not like 'po.%'
and module not like 'wf.plsql.%'
and module not like 'fnd.src.process.afplog.%'
ORDER BY log_sequence asc;


select *
from   fnd_log_messages
where 1 = 1
and log_sequence > 96557336 
and module = 'fnd.plsql.fnd_file.PUT_LINE'
ORDER BY log_sequence asc
;


SELECT *
FROM fnd_log_messages
WHERE 1=1 
--and module like 'ZX.PLSQL.ZX_API_PUB.GLOBAL_DOCUMENT_UPDATE%'
--AND TIMESTAMP > SYSDATE - .1
--AND ( upper(MODULE) like 'JA%' )
--AND log_sequence > 76368660 --  and log_sequence < 121834841  --96680085
and log_sequence > 185438872 
and log_sequence < 185442299
--and log_sequence < 151375808
and module not like 'IEMDOWNLOAD%'
and module not like 'XDP_%'
and module not like 'jtf.cache%'
and module not like 'fnd.security.%'  and module not like 'PLSQL.FND.SECURITY.%'
and module not like 'fnd.common.%'
and module not like 'per.resource.%'
and module not like 'IEMDPM#EMTA.%'
and module not like 'fnd.profiles.%'
and module not like 'fnd.sso.%'
and module not like 'fnd.framework.%'
--and module not like 'AP.%'
and module not like 'PO.%'
and module not like 'xla.%'
and module not like 'iby.%'
and module not like 'po.%'
and module not like 'wf.plsql.%'
and module not like 'fnd.src.process.afplog.%'
ORDER BY log_sequence asc;


SELECT *
FROM fnd_log_messages
WHERE 1=1 
--and module like 'ZX.PLSQL.ZX_API_PUB.GLOBAL_DOCUMENT_UPDATE%'
--AND TIMESTAMP > SYSDATE - .1
--AND ( upper(MODULE) like 'JA%' )
AND log_sequence > 96492186   
and module not like 'IEMDOWNLOAD%'
and module not like 'XDP_%'
and module not like 'jtf.cache%'
and module not like 'fnd.security.%'  and module not like 'PLSQL.FND.SECURITY.%'
and module not like 'fnd.common.%'
and module not like 'per.resource.%'
and module not like 'ZX.%'
and module not like 'PO.%'
and module not like 'po.%'
and module not like 'wf.plsql.%'
and module not like 'fnd.src.process.afplog.%'
ORDER BY log_sequence desc;



SELECT *
FROM fnd_log_messages
WHERE 1=1 
--and module like 'ZX.PLSQL.ZX_API_PUB.GLOBAL_DOCUMENT_UPDATE%'
--AND TIMESTAMP > SYSDATE - .1
AND ( upper(MODULE) like 'JA%' or upper(MODULE) like 'ZX%')
AND log_sequence > 88975970
RDER BY log_sequence DESC;


SELECT *
FROM fnd_log_messages
WHERE 1=1 
--and module like 'ZX.PLSQL.ZX_API_PUB.GLOBAL_DOCUMENT_UPDATE%'
--AND TIMESTAMP > SYSDATE - .1
AND (upper(MODULE) LIKE 'ZX%' OR upper(MODULE) like 'AP%'  OR upper(MODULE) like 'JA%')
AND log_sequence > 88975970
ORDER BY log_sequence DESC;


556412838


select * from dba_objects where object_name like 'JAI_C%' and object_type = 'PACKAGE';


select * from v$pwfile_users;






select tbl.seg1||'.'|| seg2||'.'|| seg3||'.'|| seg4||'.'||seg5  Account_Desc
      ,xla_ae_lines.* 
from apps.xla_ae_lines 
    ,(SELECT gl_flexfields_pkg.get_description_sql(101,1,gcc.segment1) seg1,
       gl_flexfields_pkg.get_description_sql(101,2,gcc.segment2) seg2,
       gl_flexfields_pkg.get_description_sql(101,3,gcc.segment3) seg3,
      gl_flexfields_pkg.get_description_sql(101,4,gcc.segment4) seg4,
       gl_flexfields_pkg.get_description_sql(101,5,gcc.segment5) seg5,
       gcc.code_combination_id
      FROM gl_code_combinations gcc
      where chart_of_accounts_id = 101
      )  tbl
where xla_ae_lines.code_combination_id = tbl.code_combination_id
and   xla_ae_lines.creation_date > to_date('20150304','YYYYMMDD')
order by creation_date desc, ae_header_id desc
;

create or replace FUNCTION get_flex_by_ccid( p_ccid     NUMBER )
RETURN VARCHAR2 IS
CURSOR get_flex_by_ccid
  IS
  Select segment1||'.'|| segment2||'.'|| segment3||'.'|| segment4||'.'||segment5  Account_Desc
  FROM apps.gl_code_combinations gcc
  WHERE gcc.code_combination_id = p_ccid
  ;
  
  lv_return  VARCHAR2(1000);
BEGIN

  OPEN get_flex_by_ccid;
  FETCH get_flex_by_ccid INTO lv_return;
  CLOSE get_flex_by_ccid;
  
  RETURN lv_return;
END ;




select *  from  apps.gl_code_combinations where code_combination_id=131219;

select get_ccid_desc(101,131219) from dual;