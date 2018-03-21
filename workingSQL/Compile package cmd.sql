CALL DBMS_DDL.ALTER_COMPILE('PACKAGE BODY','APPS','FV_FACTS_TRANSACTIONS');
CALL DBMS_DDL.ALTER_COMPILE('PACKAGE BODY','APPS','FV_FACTS_TBAL_TRANSACTIONS');
CALL DBMS_DDL.ALTER_COMPILE('PACKAGE BODY','APPS','FV_SF133_NOYEAR');
CALL DBMS_DDL.ALTER_COMPILE('PACKAGE BODY','APPS','FV_SF133_ONEYEAR');
CALL DBMS_DDL.ALTER_COMPILE('PACKAGE BODY','APPS','FV_FACTS_TBAL_TRX');
CALL DBMS_DDL.ALTER_COMPILE('PACKAGE BODY','APPS','FV_FACTS_TRX_REGISTER');
CALL DBMS_DDL.ALTER_COMPILE('PACKAGE BODY','APPS','ITG_SYNCSUPPLIERINBOUND_PVT');
CALL DBMS_DDL.ALTER_COMPILE('MATERIALIZED VIEW','APPS','GL_ACCESS_SET_LEDGERS');



CALL DBMS_DDL.ALTER_COMPILE('PACKAGE BODY','APPS','AP_WEB_CREDIT_CARD_WF');
CALL DBMS_DDL.ALTER_COMPILE('TRIGGER','APPS','JAIN_TDSTEMP_AFTERINSERT_TRG');

SELECT * FROM DBA_POLICIES where object_name like 'JA%';

SELECT * FROM per_security_profiles WHERE security_profile_name = 'PTIAN_SECURITY_PROFILE';

select * from JAI_REPORTING_TYPES;

select * from dba_objects where object_name like 'JAIN_TDSTEMP_AFTERINSERT%';
select to_char(sysdate,'YYYYMMDDHHMMSS') from dual;  --20120307050330

select * from dba_objects where status = 'INVALID' and (object_name like 'JA%' OR object_name like 'AP%' OR object_name like 'AR%' or  object_name like 'ZX%') ;
select * from dba_objects where status = 'INVALID' and (object_name like 'JA%');

select * from dba_errors;

select ad_zd.get_edition_type from dual;

 select * from ad_adop_session_patches  
        where applied_file_system_base='/u01/R122_EBS/fs2' and
        patch_file_system_base='/u01/R122_EBS/fs1' and 
        bug_number IN ('CLONE','CONFIG_CLONE') and
        status IN ('N','F');

select * from dba_objects where status = 'INVALID' and object_name like 'ZX%';
select * from dba_objects where object_name like 'JAI_AP_TDS_INV_TAXES%';
select * from DBA_TAB_COLUMNS where table_name = 'JAI_AP_TDS_INV_TAXES';
select * from ja.JAI_AP_TDS_INV_TAXES#;


select * from dba_objects where object_name like 'JAI_AP_TDS_INV_TAXES%';
select * from dba_objects where object_name like 'AR_CUST%';

select * from DBA_TAB_COLUMNS where table_name = upper('jai_cmn_taxes_all');
select * from DBA_TAB_COLUMNS where table_name = upper('JAI_ST_INVOICE_REVERSAL');

select * from ja.jai_cmn_taxes_all#;


select * from dba_objects where object_name like upper('JAI_AP_tds_thhold_trxs%');
select * from DBA_TAB_COLUMNS where table_name = 'JAI_AP_TDS_THHOLD_TRXS';
select * from ja.JAI_AP_TDS_THHOLD_TRXS#;

select * from dba_objects where owner = 'SYS' and object_type = 'PACKAGE';

select * from jai_ap_tds_thhold_taxes where 1=2;

select * from dba_objects where object_name like upper('JAI_AP_TDS_INV_TAXES%');
select * from dba_objects where object_name like upper('JA_IN_AP_TDS_INV%') and object_type = 'SEQUENCE' and owner= 'APPS';

drop sequence apps.JAI_AP_TDS_THHOLD_ACCOUNT_S;

drop sequence apps.JAI_DTC_ROUNDING_SETUPS_S;
drop sequence apps.JAI_DTC_SCTN_ACCOUNT_MAPPING_S;
drop sequence apps.JAI_REPORTING_CODES_S;
drop sequence apps.JAI_REPORTING_TYPES_S;
drop sequence apps.JAI_TAX_ACCOUNTS_S;
drop sequence apps.JAI_TAX_TYPES_S;
drop sequence apps.JAI_TDS_SECTION_MAPPING_S  

select meaning from fnd_lookups where lookup_type = 'YES_NO' and lookup_code = 'N';

select * from dba_errors where name like 'CUX%' or name like 'ZX%';

select * from dba_objects where object_name like 'JAI_AP_DTC%';

select * from dba_objects where object_name like 'JAI_AP_TDS_PROCESSING_PKG';

select * from dba_packages where 1=2;

select * from dba_tables where table_name like 'JAI%';

select * from dba_triggers where trigger_name like 'CUX_%';    --JAI_OE_OLA_ARIUD_TRG
alter trigger JAI_AP_IDA_BRIUD_T1 disable;
alter trigger JAI_AP_IDA_BRIUD_DTC_T1 enable;
alter trigger JAI_AP_IA_BRIUD_T1 disable;
alter trigger JAI_AP_IA_DTC_BRIUD_T1 enable;
select * from dba_triggers where trigger_name like 'JAI_OM_WDD_%';


select * from Fnd_Currencies where currency_code in ('INR');

	  SELECT Conversion_Rate
         FROM Gl_Daily_Rates
        WHERE To_Currency = v_func_curr
	  and From_Currency = v_frm_curr
	  and trunc(Conversion_Date) = trunc(nvl(c_conversion_date,sysdate))
	  and Conversion_Type = c_conversion_type;



SELECT *
FROM   dba_source
WHERE  TYPE IN ( 'PACKAGE BODY')
AND    NAME LIKE 'JAI_AP_MATCH_TAX%' 
AND    LINE <=10;
SELECT *
FROM   dba_source
WHERE   NAME LIKE --UPPER('jai_cmn_reverse_charge_pkg')
  --'JA_IN_AP_AIDA_AFTER_TRG%' 
  --'JA_IN_DISTRIBUTION_MATCHING'
 -- UPPER('Ja_In_St_Rvrs_Dist_Matching')
 -- 'JAI_RGM_TRX_PROCESSING_PKG'
 --UPPER('ja_in_apps_ar_lines_insert_trg')
 UPPER('ja_in_receive_rtv_pkg')
  and UPPER(text) like '%$HEADER%'
  ;
  
  SELECT *
FROM   dba_source
WHERE  1=1
  and NAME LIKE 'JA%%' 
  and TYPE IN ( 'PACKAGE BODY')
  and UPPER(text) like '%JAI_AP_TDS_PAYMENTS%'
  ;
  
  
  
SELECT *
FROM   dba_source    --JAI_AP_DTC_DEFAULTATION_PKG
WHERE  NAME in (UPPER('JAI_PO_HA_ARIUD_T1'), UPPER('JAI_PO_LA_ARIUD_T1') , UPPER('JAI_PO_LLA_ARIUD_T1') ) 
and upper(text) like '%AP_PAY_INVOICE%'
ORDER BY NAME DESC,LINE ASC;

select * from AP_INTERFACE_CONTROLS;
select * from mo_glob_org_access_tmp;


  
SELECT *
FROM   dba_source    --JAI_AP_DTC_DEFAULTATION_PKG
WHERE  NAME LIKE 'AP_PAY%'
and upper(text) like '%AP_PAY_INVOICE%'
ORDER BY NAME DESC,LINE ASC;

jai_po_ha_t.sql
jai_po_la_t.sql
jai_po_lla_t.sql

select * from jai_ap_tds_org_tan_v  


SELECT *
FROM   dba_source
WHERE  NAME in (UPPER('jai_cmn_utils_pkg') , UPPER('jai_om_tax_processing_pkg'), UPPER('JAI_OM_WDD_ARIUD_TRG')  , UPPER('JAI_OM_WDD_PROCESSING_PKG')) 
and upper(text) like '%Apply_Prepay_FR_Prepay%'
ORDER BY NAME DESC,LINE ASC;


SELECT *
FROM   dba_source
WHERE  (NAME like 'AP%' or name like 'ZX%') 
and upper(text) like '%Apply_Prepay_FR_Prepay%'
ORDER BY NAME DESC,LINE ASC;

SELECT *
FROM   dba_source
WHERE  NAME LIKE upper('JAI_PO_HA_ARIUD_T1%')
ORDER BY TYPE DESC,LINE ASC
;
SELECT *
FROM   dba_source
WHERE  NAME LIKE upper('JAI_AP_OI_PROCESSING_PKG%')
ORDER BY TYPE DESC,LINE ASC
;


SELECT *
FROM   dba_source
WHERE  NAME LIKE upper('JAI_TAX_PROCESSING%')
--and text like '%$Header%'
ORDER BY TYPE DESC,LINE ASC
;

SELECT *
FROM   dba_tables
WHERE  table_NAME LIKE 'AD%'
and rownum <=1
;

SELECT *
FROM   dba_columns
WHERE  runnum <=1
;

select * from AD_APPLIED_PATCHES order by applied_patch_id desc;

  SELECT JATTTY.THRESHOLD_TYPE_ID,
         JATTTY.FROM_DATE,
         JATTTY.TO_DATE,
         JATTTY.THRESHOLD_TYPE,
         JATTTA.THRESHOLD_SLAB_ID,
         JATTS.FROM_AMOUNT,
         JATTS.TO_AMOUNT,
         JATTTA.TAX_CATEGORY_ID,
         JATTTA.OPERATING_UNIT_ID
  FROM   JAI_AP_TDS_THHOLD_HDRS JATTH,
         JAI_AP_TDS_THHOLD_TYPES JATTTY,
         JAI_AP_TDS_THHOLD_SLABS JATTS,
         JAI_AP_TDS_THHOLD_TAXES JATTTA
  WHERE  JATTH.THRESHOLD_HDR_ID = :cp_thrd_header_id
  AND    JATTH.THRESHOLD_HDR_ID = JATTTY.THRESHOLD_HDR_ID
  AND    JATTTY.THRESHOLD_TYPE_ID = JATTS.THRESHOLD_TYPE_ID
  AND    JATTS.THRESHOLD_SLAB_ID = JATTTA.THRESHOLD_SLAB_ID
  AND    JATTTA.OPERATING_UNIT_ID = :cp_org_id
  ORDER BY JATTTY.THRESHOLD_TYPE DESC;

SELECT *
FROM   dba_source
WHERE  NAME LIKE upper('JAI_TAX_PROCESSING%')
AND    TEXT LIKE '%$Header:%'
;

SELECT *
FROM   dba_source
WHERE  NAME LIKE upper('Ja_In_Po_Tax_Insert_Trg%')
AND    upper(TEXT) LIKE '%JA_IN_PO_DEF%'
;
alter system kill session ##;




select * from dba_source where owner = 'APPS' and text like '%ap_accounting_events_pkg.create_events%';

select * from ap_invoice_distributions_all;
select * from ja_in_tax_codes;

select * from JA_IN_AP_FA_INV_DIST_ALL;

select * from JA_IN_PO_LINE_LOCATION_TAXES;
select * from po_line_locations_all;
select * from po_lines_all;


    
    FROM jai_tax_category_lines cat
        ,jai_tax_rates          rate
        ,jai_tax_rate_details   rate_dtl
    WHERE cat.tax_rate_id = rate.tax_rate_id
    AND   rate.tax_rate_id = rate_dtl.tax_rate_id
    AND   cat.tax_category_id =  10181   
    AND   rate.regime_id = 10040            
    AND NOT EXISTS (        SELECT 1
        FROM   jai_tax_category_lines cat_in
        WHERE  cat_in.tax_category_id = 10100
        AND    cat_in.tax_rate_id = cat.tax_rate_id  
    )
    ;

SELECT 'ODMR$'||TO_CHAR(SYSTIMESTAMP,'HH24_MI_SS_FF')|| dbms_random.string(NULL, 7)  FROM dual;


select to_date(123123232323, 'YYYYMMDD') from dual;
select replace('asdfaf sdfsdf', ' ', NULL) from dual;
select zryh.yutianc_utl_rpl_space('asdfadf asdfasdf') from dual;