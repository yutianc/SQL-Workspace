--FSG基础表
--迁移FSG定义数据所用的linkdb
select * from RG_DATABASE_LINKS;
--财务分析功能
select * from RG_DSS_DIMENSIONS;
select * from RG_DSS_DIM_SEGMENTS;
select * from RG_DSS_HIERARCHIES;
select * from RG_DSS_HIERARCHY_DETAILS;
select * from RG_DSS_REQUESTS;
select * from RG_DSS_SEG_RANGES;
select * from RG_DSS_SEG_RANGE_SETS;
select * from RG_DSS_SYSTEMS;
select * from RG_DSS_SYSTEM_SEG_ORDER;
select * from RG_DSS_SYSTEM_VARIABLES;
select * from RG_DSS_VARIABLES;
select * from RG_DSS_VAR_DIMENSIONS;
select * from RG_DSS_VAR_SELECTIONS;
select * from RG_DSS_VAR_TEMPLATES;

--FSG report defintion
select * from RG_REPORT_SETS;
select * from RG_REPORTS;
--行列集
select * from RG_REPORT_AXIS_SETS;
select * from RG_REPORT_AXES;
select * from RG_REPORT_AXIS_CONTENTS;
select * from RG_REPORT_CALCULATIONS;
select * from RG_REPORT_CONTENT_OVERRIDES;
select * from RG_REPORT_CONTENT_SETS;
select * from RG_REPORT_DISPLAYS;
--RG_REPORT_DISPLAY_GROUPS
--RG_REPORT_DISPLAY_SETS
--RG_REPORT_EXCEPTIONS
--RG_REPORT_EXCEPTION_FLAGS
select * from RG_REPORT_PARAMETERS;
--Report request tracking and assignments of reports to report sets
--FSG 报表请求记录
select count(1) from RG_REPORT_REQUESTS;
select * from RG_REPORT_REQUESTS order by report_request_id;
select trunc(creation_date,'YYYY'),count(1) from RG_REPORT_REQUEST_LOBS group by trunc(creation_date,'YYYY');
select * from RG_REPORT_REQUEST_LOBS order by request_id asc;

select * from RG_REPORT_SET_REQUESTS;
select * from RG_REPORT_SET_REQ_DETAILS;

select * from RG_REPORT_STANDARD_AXES_B;
select * from RG_REPORT_STANDARD_AXES_TL;
select * from RG_REPORT_SUB_REQUEST_RUNS;
select * from RG_ROW_ORDERS;
--列属性
select * from RG_ROW_SEGMENT_SEQUENCES;
select * from RG_SIMPLE_WHERE_CLAUSES;
--RG_TABLE_SIZES stores the number of rows in various Oracle General Ledger tables. 
--Each row includes a table identifier and the number of rows in the table. Financial Statement Generator uses this information to optimize queries. 
select * from RG_TABLE_SIZES;

select * from RG_XBRL_ELEMENTS;
select * from RG_XBRL_MAP_ELEMENTS;
select * from RG_XBRL_TAXONOMIES;
--views
select * from RG_BUDGETS_V;
select * from RG_CONSTANT_PERIODS_V;
select * from RG_CURRENCIES_V;
select * from RG_ENCUMBRANCES_V;
--数据明细层
select * from RG_LEVEL_OF_DETAIL_V;
--单位
select * from RG_FACTOR_V;
select * from RG_LOOKUPS;
select * from RG_PERIOD_YEARS_V;
select * from RG_REPORTS_V;
select * from RG_REPORT_AXES_V;
select * from RG_REPORT_AXIS_SETS_LOV_V;
select * from RG_REPORT_NAME_V;
select * from RG_XBRL_MAP_V;



select     concatenated_segment_delimiter from FND_ID_FLEX_STRUCTURES;

--FSG报表行集定义
select rs.name     "行集名"
      ,axes.SEQUENCE "行序号"
      ,axes.description "行描述"
      ,axes.DISPLAY_FLAG
      ,axes.DISPLAY_ZERO_AMOUNT_FLAG
      ,axcntc.axis_seq "取值顺序"
      ,axcntc.SIGN
      ,axcntc.ledger_id
      ,decode(axcntc.range_mode,'Y','汇总', 'N',NULL, NULL) "汇总"
      ,decode(axcntc.dr_cr_net_code,'N','净',  'C','贷项',  'D','借项',NULL)  "活动"
      ,axcntc.segment1_low || '.' || axcntc.segment2_low || '.' || axcntc.segment3_low || '.' || axcntc.segment4_low || '.' || axcntc.segment5_low || '.' || axcntc.segment6_low || '.' || axcntc.segment7_low || '.' || axcntc.segment8_low || '.' || axcntc.segment9_low   account_from
      ,axcntc.segment1_high || '.' || axcntc.segment2_high || '.' || axcntc.segment3_high || '.' || axcntc.segment4_high || '.' || axcntc.segment5_high || '.' || axcntc.segment6_high || '.' || axcntc.segment7_high || '.' || axcntc.segment8_high || '.' || axcntc.segment9_high account_to
      ,axcntc.segment1_type || '.' || axcntc.segment2_type || '.' || axcntc.segment3_type || '.' || axcntc.segment4_type || '.' || axcntc.segment5_type || '.' || axcntc.segment6_type || '.' || axcntc.segment7_type || '.' || axcntc.segment8_type || '.' || axcntc.segment9_type account_type
      ,axclc.calculation_seq  "计算式序列"
      ,axclc.operator  "计算符号"
      ,axclc.axis_seq_low  "计算序列from"
      ,axclc.axis_seq_high  "计算序列to"
      ,axclc.constant  "常数"
from   RG_REPORT_AXIS_SETS RS
      ,RG_REPORT_AXES_V    axes
      ,rg_report_axis_contents axcntc
      ,rg_report_calculations  axclc
where  1=1
AND    RS.AXIS_SET_TYPE           = 'R'
AND    rs.application_id        = axes.application_id
AND    RS.AXIS_SET_ID         = axes.AXIS_SET_ID
--AND    CSET.AXIS_SET_TYPE       = axes.AXIS_SET_TYPE
AND    axes.application_id = axcntc.application_id(+)
AND    axes.axis_set_id = axcntc.AXIS_SET_ID(+)
AND    axes.SEQUENCE = axcntc.AXIS_SEQ(+)
AND    axes.application_id = axclc.application_id(+)
AND    axes.axis_set_id = axclc.AXIS_SET_ID(+)
AND    axes.SEQUENCE = axclc.AXIS_SEQ(+)
AND    (:p_report_name IS NULL OR rs.name like :p_report_name )
order by axes.SEQUENCE
        ,axcntc.axis_seq
        ,axcntc.axis_seq
        ,axclc.calculation_seq
;

select 

select * from RG_REPORT_AXIS_SETS order by creation_date desc;



SELECT  nvl(RGB.standard_axis_id,-1), 
 		nvl(RGT.standard_axis_name,''), 
 		nvl(class, ''),
 		upper(nvl(database_column,'')), 
 	        nvl(upper(simple_where_name),''), 
 		period_query, 
 		nvl(standard_axis1_id,-1), 
 	        nvl(axis1_operator,''), 
 		nvl(standard_axis2_id,-1), 
 		nvl(axis2_operator,''), 
 	        nvl(constant,0), 
 	        nvl(precedence_level,0), 
                 nvl(variance_flag,'N'), 
                 nvl(sign_flag,'N') 
         FROM RG_REPORT_STANDARD_AXES_B RGB, 
 	     RG_REPORT_STANDARD_AXES_TL RGT 
 	WHERE RGB.standard_axis_id = RGT.standard_axis_id 
 	AND   RGT.language         = USERENV('LANG') 
 	ORDER BY RGB.standard_axis_id DESC
;

--列集
SELECT nvl(name,''),
                    nvl(axis_set_type,''), 
                    column_set_header,
                    nvl(structure_id,-1),
		    nvl(segment_name,''),
                    nvl(description,'')
	FROM RG_REPORT_AXIS_SETS
WHERE axis_set_id = 28002
;

--行集
SELECT nvl(name,''),
                    nvl(axis_set_type,''), 
                    column_set_header,
                    nvl(structure_id,-1),
		    nvl(segment_name,''),
                    nvl(description,'')
	FROM RG_REPORT_AXIS_SETS
WHERE axis_set_id = 28001
;


SELECT period_set_name
FROM GL_ACCESS_SETS
WHERE access_set_id = 1083
;

SELECT upper(nvl(simple_where_name,'')),
upper(nvl(where_column,'')),
nvl(where_value,'')
FROM RG_SIMPLE_WHERE_CLAUSES
;


SELECT to_char(axis_seq,'999999999999999.9999999999999'),
nvl(axis_name,''),
nvl(description,''),
to_char(percentage_divisor_seq,'999999999999999.9999999999999'),
nvl(axis_type,'N'),
nvl(standard_axis_id,-1),
nvl(structure_id,-1),
nvl(transaction_flag,'N'),
nvl(segment_override_value,''),
nvl(override_alc_ledger_currency, ''),
nvl(amount_id,-1),
nvl(unit_of_measure_id,''),
nvl(parameter_num,-1),
nvl(period_offset,0),
nvl(display_flag,'Y'),
nvl(before_axis_string,''),
nvl(after_axis_string,''),
nvl(position,-1),
nvl(number_characters_indented,0),
nvl(page_break_before_flag,'N'),
nvl(page_break_after_flag,'N'),
nvl(number_lines_skipped_before,0),
nvl(number_lines_skipped_after,0),
nvl(display_level,0),
nvl(display_zero_amount_flag,'N'),
nvl(change_sign_flag,'N'),
nvl(change_variance_sign_flag,'N'),
nvl(display_units,-999),
nvl(display_format,''),
decode(nvl(calculation_precedence_flag,'N'),'N',-10,'Y',10),
nvl(format_before_text,''),
nvl(format_after_text,''),
nvl(format_mask_width, 10),
nvl(display_precision, 2)
FROM RG_REPORT_AXES
WHERE axis_set_id = 28001
ORDER BY axis_seq DESC
--rgrgax:get_axes
--Starting axis query
;

--报表中的计算集
SELECT to_char(axis_seq,'999999999999999.9999999999999'),
nvl(calculation_seq,-1),
nvl(operator,'ENTER'),
to_char(axis_seq_low,'999999999999999.9999999999999'),
to_char(axis_seq_high,'999999999999999.9999999999999'),
nvl(axis_name_low,''),
nvl(axis_name_low,''), constant
FROM RG_REPORT_CALCULATIONS
WHERE axis_set_id =28001
AND (
operator IS NOT NULL OR calculation_seq IS NOT NULL
OR (axis_seq_low IS NOT NULL AND axis_seq_high IS NOT NULL)
OR axis_name_low IS NOT NULL OR axis_name_high IS NOT NULL
OR constant IS NOT NULL)
ORDER BY axis_seq ASC,calculation_seq DESC
;




select
	to_char(axis_seq,'999999999999999.9999999999999') AXIS_SEQ,
	nvl(range_mode,'N') RANGE_MODE,
	nvl(sign,'+') SIGN,
	nvl(dr_cr_net_code,'N') DR_CR_NET_CODE,
	nvl(gl.short_name, '') SHORT_NAME,
	gl.short_name  LEDGER_SEGMENT_low,
	gl.short_name  LEDGER_SEGMENT_high,
	nvl(LEDGER_SEGMENT_type,'') LEDGER_SEGMENT_type,
	nvl(SEGMENT1_low,'') SEGMENT1_low,
	nvl(SEGMENT1_high,'') SEGMENT1_high,
	nvl(SEGMENT1_type,'') SEGMENT1_type,
	nvl(SEGMENT2_low,'') SEGMENT2_low,
	nvl(SEGMENT2_high,'') SEGMENT2_high,
	nvl(SEGMENT2_type,'') SEGMENT2_type,
	nvl(SEGMENT3_low,'') SEGMENT3_low,
	nvl(SEGMENT3_high,'') SEGMENT3_high,
	nvl(SEGMENT3_type,'') SEGMENT3_type,
	nvl(SEGMENT4_low,'') SEGMENT4_low,
	nvl(SEGMENT4_high,'') SEGMENT4_high,
	nvl(SEGMENT4_type,'') SEGMENT4_type,
	nvl(SEGMENT5_low,'') SEGMENT5_low,
	nvl(SEGMENT5_high,'') SEGMENT5_high,
	nvl(SEGMENT5_type,'') SEGMENT5_type,
	nvl(SEGMENT6_low,'') SEGMENT6_low,
	nvl(SEGMENT6_high,'') SEGMENT6_high,
	nvl(SEGMENT6_type,'') SEGMENT6_type,
	nvl(SEGMENT7_low,'') SEGMENT7_low,
	nvl(SEGMENT7_high,'') SEGMENT7_high,
	nvl(SEGMENT7_type,'') SEGMENT7_type,
	nvl(SEGMENT8_low,'') SEGMENT8_low,
	nvl(SEGMENT8_high,'') SEGMENT8_high,
	nvl(SEGMENT8_type,'') SEGMENT8_type,
	nvl(SEGMENT9_low,'') SEGMENT9_low,
	nvl(SEGMENT9_high,'') SEGMENT9_high,
	nvl(SEGMENT9_type,'') SEGMENT9_type,
	ac.ledger_id LEDGER_ID 
FROM RG_REPORT_AXIS_CONTENTS ac, GL_LEDGERS gl, GL_LEDGER_RELATIONSHIPS glr 
WHERE axis_set_id = 28001
 AND ac.ledger_id IS NOT NULL 
 AND glr.target_ledger_id = gl.ledger_id 
 AND ((glr.source_ledger_id = gl.ledger_id 
 AND glr.target_ledger_category_code IN ('PRIMARY')) OR  
 (glr.source_ledger_id != gl.ledger_id 
 AND glr.target_ledger_category_code IN ('ALC','SECONDARY'))) 
 AND glr.application_id = 101 
 AND gl.ledger_id = ac.ledger_id 
UNION
 select
	to_char(axis_seq,'999999999999999.9999999999999') AXIS_SEQ,
	nvl(range_mode,'N') RANGE_MODE,
	nvl(sign,'+') SIGN,
	nvl(dr_cr_net_code,'N') DR_CR_NET_CODE,
	nvl(gl.short_name, '') SHORT_NAME,
	gl.short_name  LEDGER_SEGMENT_low,
	gl.short_name  LEDGER_SEGMENT_high,
	nvl(LEDGER_SEGMENT_type,'') LEDGER_SEGMENT_type,
	nvl(SEGMENT1_low,'') SEGMENT1_low,
	nvl(SEGMENT1_high,'') SEGMENT1_high,
	nvl(SEGMENT1_type,'') SEGMENT1_type,
	nvl(SEGMENT2_low,'') SEGMENT2_low,
	nvl(SEGMENT2_high,'') SEGMENT2_high,
	nvl(SEGMENT2_type,'') SEGMENT2_type,
	nvl(SEGMENT3_low,'') SEGMENT3_low,
	nvl(SEGMENT3_high,'') SEGMENT3_high,
	nvl(SEGMENT3_type,'') SEGMENT3_type,
	nvl(SEGMENT4_low,'') SEGMENT4_low,
	nvl(SEGMENT4_high,'') SEGMENT4_high,
	nvl(SEGMENT4_type,'') SEGMENT4_type,
	nvl(SEGMENT5_low,'') SEGMENT5_low,
	nvl(SEGMENT5_high,'') SEGMENT5_high,
	nvl(SEGMENT5_type,'') SEGMENT5_type,
	nvl(SEGMENT6_low,'') SEGMENT6_low,
	nvl(SEGMENT6_high,'') SEGMENT6_high,
	nvl(SEGMENT6_type,'') SEGMENT6_type,
	nvl(SEGMENT7_low,'') SEGMENT7_low,
	nvl(SEGMENT7_high,'') SEGMENT7_high,
	nvl(SEGMENT7_type,'') SEGMENT7_type,
	nvl(SEGMENT8_low,'') SEGMENT8_low,
	nvl(SEGMENT8_high,'') SEGMENT8_high,
	nvl(SEGMENT8_type,'') SEGMENT8_type,
	nvl(SEGMENT9_low,'') SEGMENT9_low,
	nvl(SEGMENT9_high,'') SEGMENT9_high,
	nvl(SEGMENT9_type,'') SEGMENT9_type,
	gl.ledger_id LEDGER_ID 
FROM RG_REPORT_AXIS_CONTENTS ac, GL_LEDGERS gl 
WHERE axis_set_id = 28001
 AND ac.ledger_id IS NOT NULL 
 AND gl.ledger_id IN  
 (SELECT glb.ledger_id 
 FROM gl_ledger_set_assignments glb 
 WHERE glb.ledger_set_id = ac.ledger_id 
  AND glb.ledger_set_id = glb.ledger_id)
UNION 
(select
	to_char(axis_seq,'999999999999999.9999999999999') AXIS_SEQ,
	nvl(range_mode,'N') RANGE_MODE,
	nvl(sign,'+') SIGN,
	nvl(dr_cr_net_code,'N') DR_CR_NET_CODE,
	gl.short_name SHORT_NAME,
	gl.short_name LEDGER_SEGMENT_low,
	gl.short_name LEDGER_SEGMENT_high,
	'T' LEDGER_SEGMENT_type,
	nvl(SEGMENT1_low,'') SEGMENT1_low,
	nvl(SEGMENT1_high,'') SEGMENT1_high,
	nvl(SEGMENT1_type,'') SEGMENT1_type,
	nvl(SEGMENT2_low,'') SEGMENT2_low,
	nvl(SEGMENT2_high,'') SEGMENT2_high,
	nvl(SEGMENT2_type,'') SEGMENT2_type,
	nvl(SEGMENT3_low,'') SEGMENT3_low,
	nvl(SEGMENT3_high,'') SEGMENT3_high,
	nvl(SEGMENT3_type,'') SEGMENT3_type,
	nvl(SEGMENT4_low,'') SEGMENT4_low,
	nvl(SEGMENT4_high,'') SEGMENT4_high,
	nvl(SEGMENT4_type,'') SEGMENT4_type,
	nvl(SEGMENT5_low,'') SEGMENT5_low,
	nvl(SEGMENT5_high,'') SEGMENT5_high,
	nvl(SEGMENT5_type,'') SEGMENT5_type,
	nvl(SEGMENT6_low,'') SEGMENT6_low,
	nvl(SEGMENT6_high,'') SEGMENT6_high,
	nvl(SEGMENT6_type,'') SEGMENT6_type,
	nvl(SEGMENT7_low,'') SEGMENT7_low,
	nvl(SEGMENT7_high,'') SEGMENT7_high,
	nvl(SEGMENT7_type,'') SEGMENT7_type,
	nvl(SEGMENT8_low,'') SEGMENT8_low,
	nvl(SEGMENT8_high,'') SEGMENT8_high,
	nvl(SEGMENT8_type,'') SEGMENT8_type,
	nvl(SEGMENT9_low,'') SEGMENT9_low,
	nvl(SEGMENT9_high,'') SEGMENT9_high,
	nvl(SEGMENT9_type,'') SEGMENT9_type,
	gl.ledger_id LEDGER_ID 
FROM RG_REPORT_AXIS_CONTENTS ac, GL_LEDGERS gl, GL_LEDGER_RELATIONSHIPS glr 
WHERE axis_set_id = 28001
 AND ac.ledger_id IS NULL 
 AND glr.target_ledger_id = gl.ledger_id 
 AND ((glr.source_ledger_id = gl.ledger_id 
 AND glr.target_ledger_category_code IN ('PRIMARY')) OR  
 (glr.source_ledger_id != gl.ledger_id 
 AND glr.target_ledger_category_code IN ('ALC','SECONDARY'))) 
 AND glr.application_id = 101 
 AND gl.ledger_id IN (2023))
UNION 
(select
	to_char(axis_seq,'999999999999999.9999999999999') AXIS_SEQ,
	nvl(range_mode,'N') RANGE_MODE,
	nvl(sign,'+') SIGN,
	nvl(dr_cr_net_code,'N') DR_CR_NET_CODE,
	gl.short_name SHORT_NAME,
	gl.short_name LEDGER_SEGMENT_low,
	gl.short_name LEDGER_SEGMENT_high,
	'T' LEDGER_SEGMENT_type,
	nvl(SEGMENT1_low,'') SEGMENT1_low,
	nvl(SEGMENT1_high,'') SEGMENT1_high,
	nvl(SEGMENT1_type,'') SEGMENT1_type,
	nvl(SEGMENT2_low,'') SEGMENT2_low,
	nvl(SEGMENT2_high,'') SEGMENT2_high,
	nvl(SEGMENT2_type,'') SEGMENT2_type,
	nvl(SEGMENT3_low,'') SEGMENT3_low,
	nvl(SEGMENT3_high,'') SEGMENT3_high,
	nvl(SEGMENT3_type,'') SEGMENT3_type,
	nvl(SEGMENT4_low,'') SEGMENT4_low,
	nvl(SEGMENT4_high,'') SEGMENT4_high,
	nvl(SEGMENT4_type,'') SEGMENT4_type,
	nvl(SEGMENT5_low,'') SEGMENT5_low,
	nvl(SEGMENT5_high,'') SEGMENT5_high,
	nvl(SEGMENT5_type,'') SEGMENT5_type,
	nvl(SEGMENT6_low,'') SEGMENT6_low,
	nvl(SEGMENT6_high,'') SEGMENT6_high,
	nvl(SEGMENT6_type,'') SEGMENT6_type,
	nvl(SEGMENT7_low,'') SEGMENT7_low,
	nvl(SEGMENT7_high,'') SEGMENT7_high,
	nvl(SEGMENT7_type,'') SEGMENT7_type,
	nvl(SEGMENT8_low,'') SEGMENT8_low,
	nvl(SEGMENT8_high,'') SEGMENT8_high,
	nvl(SEGMENT8_type,'') SEGMENT8_type,
	nvl(SEGMENT9_low,'') SEGMENT9_low,
	nvl(SEGMENT9_high,'') SEGMENT9_high,
	nvl(SEGMENT9_type,'') SEGMENT9_type,
	gl.ledger_id LEDGER_ID 
FROM RG_REPORT_AXIS_CONTENTS ac, GL_LEDGERS gl 
WHERE axis_set_id = 28001
 AND ac.ledger_id IS NULL 
  AND gl.ledger_id IN 
 (SELECT glb.ledger_id 
 FROM gl_ledger_set_assignments glb 
 WHERE glb.ledger_set_id IN (2023)
  AND glb.ledger_set_id = glb.ledger_id))
 ORDER BY AXIS_SEQ ASC, LEDGER_ID DESC ,
	LEDGER_SEGMENT_low	DESC,
	LEDGER_SEGMENT_high	DESC,
	LEDGER_SEGMENT_type	DESC,
	SEGMENT1_low	DESC,
	SEGMENT1_high	DESC,
	SEGMENT1_type	DESC,
	SEGMENT2_low	DESC,
	SEGMENT2_high	DESC,
	SEGMENT2_type	DESC,
	SEGMENT3_low	DESC,
	SEGMENT3_high	DESC,
	SEGMENT3_type	DESC,
	SEGMENT4_low	DESC,
	SEGMENT4_high	DESC,
	SEGMENT4_type	DESC,
	SEGMENT5_low	DESC,
	SEGMENT5_high	DESC,
	SEGMENT5_type	DESC,
	SEGMENT6_low	DESC,
	SEGMENT6_high	DESC,
	SEGMENT6_type	DESC,
	SEGMENT7_low	DESC,
	SEGMENT7_high	DESC,
	SEGMENT7_type	DESC,
	SEGMENT8_low	DESC,
	SEGMENT8_high	DESC,
	SEGMENT8_type	DESC,
	SEGMENT9_low	DESC,
	SEGMENT9_high	DESC,
	SEGMENT9_type	DESC
;


select
nvl(co.override_seq,-1),
nvl(co.range_mode,'D'),
nvl(cs.name,''),
nvl(cs.structure_id,-1),
nvl(cs.report_run_type,'S'),
nvl(cs.description,''),
nvl(gl.short_name, ''),
nvl(glr.target_ledger_short_name, gl.short_name) LEDGER_SEGMENT_low,
nvl(glr.target_ledger_short_name, gl.short_name) LEDGER_SEGMENT_high,
nvl(substr(co.LEDGER_SEGMENT_type,1,1),''),
nvl(substr(co.LEDGER_SEGMENT_type,2,1),''),
nvl(SEGMENT1_low,''),
nvl(SEGMENT1_high,''),
nvl(substr(SEGMENT1_type,1,1),''),
nvl(substr(SEGMENT1_type,2,1),''),
nvl(SEGMENT2_low,''),
nvl(SEGMENT2_high,''),
nvl(substr(SEGMENT2_type,1,1),''),
nvl(substr(SEGMENT2_type,2,1),''),
nvl(SEGMENT3_low,''),
nvl(SEGMENT3_high,''),
nvl(substr(SEGMENT3_type,1,1),''),
nvl(substr(SEGMENT3_type,2,1),''),
nvl(SEGMENT4_low,''),
nvl(SEGMENT4_high,''),
nvl(substr(SEGMENT4_type,1,1),''),
nvl(substr(SEGMENT4_type,2,1),''),
nvl(SEGMENT5_low,''),
nvl(SEGMENT5_high,''),
nvl(substr(SEGMENT5_type,1,1),''),
nvl(substr(SEGMENT5_type,2,1),''),
nvl(SEGMENT6_low,''),
nvl(SEGMENT6_high,''),
nvl(substr(SEGMENT6_type,1,1),''),
nvl(substr(SEGMENT6_type,2,1),''),
nvl(SEGMENT7_low,''),
nvl(SEGMENT7_high,''),
nvl(substr(SEGMENT7_type,1,1),''),
nvl(substr(SEGMENT7_type,2,1),''),
nvl(SEGMENT8_low,''),
nvl(SEGMENT8_high,''),
nvl(substr(SEGMENT8_type,1,1),''),
nvl(substr(SEGMENT8_type,2,1),''),
nvl(SEGMENT9_low,''),
nvl(SEGMENT9_high,''),
nvl(substr(SEGMENT9_type,1,1),''),
nvl(substr(SEGMENT9_type,2,1),'')
FROM RG_REPORT_CONTENT_OVERRIDES co, RG_REPORT_CONTENT_SETS cs, GL_LEDGERS gl, GL_LEDGER_RELATIONSHIPS glr
WHERE cs.content_set_id = co.content_set_id
AND gl.ledger_id (+) = co.ledger_id
AND glr.source_ledger_id (+) = gl.ledger_id
AND glr.target_ledger_id (+) = gl.ledger_id
AND cs.content_set_id = 0
ORDER BY co.override_seq DESC
;




select
nvl(co.override_seq,-1),
nvl(co.range_mode,'D'),
nvl(cs.name,''),
nvl(cs.structure_id,-1),
nvl(cs.report_run_type,'S'),
nvl(cs.description,''),
nvl(gl.short_name, ''),
nvl(glr.target_ledger_short_name, gl.short_name) LEDGER_SEGMENT_low,
nvl(glr.target_ledger_short_name, gl.short_name) LEDGER_SEGMENT_high,
nvl(substr(co.LEDGER_SEGMENT_type,1,1),''),
nvl(substr(co.LEDGER_SEGMENT_type,2,1),''),
nvl(SEGMENT1_low,''),
nvl(SEGMENT1_high,''),
nvl(substr(SEGMENT1_type,1,1),''),
nvl(substr(SEGMENT1_type,2,1),''),
nvl(SEGMENT2_low,''),
nvl(SEGMENT2_high,''),
nvl(substr(SEGMENT2_type,1,1),''),
nvl(substr(SEGMENT2_type,2,1),''),
nvl(SEGMENT3_low,''),
nvl(SEGMENT3_high,''),
nvl(substr(SEGMENT3_type,1,1),''),
nvl(substr(SEGMENT3_type,2,1),''),
nvl(SEGMENT4_low,''),
nvl(SEGMENT4_high,''),
nvl(substr(SEGMENT4_type,1,1),''),
nvl(substr(SEGMENT4_type,2,1),''),
nvl(SEGMENT5_low,''),
nvl(SEGMENT5_high,''),
nvl(substr(SEGMENT5_type,1,1),''),
nvl(substr(SEGMENT5_type,2,1),''),
nvl(SEGMENT6_low,''),
nvl(SEGMENT6_high,''),
nvl(substr(SEGMENT6_type,1,1),''),
nvl(substr(SEGMENT6_type,2,1),''),
nvl(SEGMENT7_low,''),
nvl(SEGMENT7_high,''),
nvl(substr(SEGMENT7_type,1,1),''),
nvl(substr(SEGMENT7_type,2,1),''),
nvl(SEGMENT8_low,''),
nvl(SEGMENT8_high,''),
nvl(substr(SEGMENT8_type,1,1),''),
nvl(substr(SEGMENT8_type,2,1),''),
nvl(SEGMENT9_low,''),
nvl(SEGMENT9_high,''),
nvl(substr(SEGMENT9_type,1,1),''),
nvl(substr(SEGMENT9_type,2,1),'')
FROM RG_REPORT_CONTENT_OVERRIDES co, RG_REPORT_CONTENT_SETS cs, GL_LEDGERS gl, GL_LEDGER_RELATIONSHIPS glr
WHERE cs.content_set_id = co.content_set_id
AND gl.ledger_id (+) = co.ledger_id
AND glr.source_ledger_id (+) = gl.ledger_id
AND glr.target_ledger_id (+) = gl.ledger_id
AND cs.content_set_id = 0
ORDER BY co.override_seq DESC
;



SELECT DISTINCT l.short_name ledger_short_name,
nvl(sv.child_flex_value, acc.segment_value) seg_val,
nvl(to_number(to_char(acc.start_date, 'YYYYMMDD')), 0) start_date,
nvl(to_number(to_char(acc.end_date, 'YYYYMMDD')), 99999999) end_date
FROM gl_access_set_norm_assign acc,
gl_ledger_set_assignments ls,
gl_seg_val_hierarchies sv,
gl_ledgers l
WHERE acc.access_set_id = 1083
AND sv.flex_value_set_id (+) = 0
AND sv.parent_flex_value (+) = acc.segment_value
AND ls.ledger_set_id (+) = acc.ledger_id
AND l.ledger_id = nvl(ls.ledger_id, acc.ledger_id)
AND l.object_type_code = 'L'
AND l.LEDGER_ID = 2023
AND nvl(acc.status_code, 'X') <> 'I'
ORDER BY NLSSORT(l.short_name, 'NLS_SORT=BINARY'),
decode(seg_val, null, '1', '2'||seg_val),
start_date,
end_date
;



SELECT nvl(sum(rows_this_value),0)
FROM GL_SEGMENT_FREQUENCIES
WHERE SEGMENT_NAME = 'SEGMENT1'
AND (
(segment_value = '1460')
OR (segment_value >= '1660' AND segment_value <= '1661')
OR (segment_value = '2910')
OR (segment_value = '2920')
OR (segment_value = '2950')
);

select * from GL_SEGMENT_FREQUENCIES WHERE SEGMENT_NAME = 'SEGMENT3';
SELECT nvl(sum(rows_this_value),0)
FROM GL_SEGMENT_FREQUENCIES
WHERE SEGMENT_NAME = 'SEGMENT3'
AND (
(segment_value >= '600102' AND segment_value <= '600102zzzz')
OR (segment_value >= '600103' AND segment_value <= '60011zzzzz')
OR (segment_value >= '6051020000' AND segment_value <= '605102zzzz')
OR (segment_value >= '6301' AND segment_value <= '6301zzzzzz')
OR (segment_value >= '64010301' AND segment_value <= '64010301zz')
OR (segment_value >= '64010302' AND segment_value <= '64010302zz')
OR (segment_value >= '64010303' AND segment_value <= '64010303zz')
OR (segment_value >= '64010304' AND segment_value <= '64010304zz')
OR (segment_value >= '64010305' AND segment_value <= '64010305zz')
OR (segment_value >= '6401030601' AND segment_value <= '6401030606')
OR (segment_value = '6401030701')
OR (segment_value = '6401030801')
OR (segment_value >= '640105' AND segment_value <= '640105zzzz')
OR (segment_value >= '640205' AND segment_value <= '640205zzzz')
OR (segment_value >= '640206' AND segment_value <= '640206zzzz')
OR (segment_value >= '6405' AND segment_value <= '6405zzzzzz')
OR (segment_value >= '66020101' AND segment_value <= '66020101zz')
OR (segment_value >= '66020102' AND segment_value <= '66020102zz')
OR (segment_value >= '66020104' AND segment_value <= '66020104zz')
OR (segment_value >= '66020105' AND segment_value <= '66020105zz')
OR (segment_value >= '660202' AND segment_value <= '660202zzzz')
OR (segment_value >= '660203' AND segment_value <= '660203zzzz')
OR (segment_value >= '660204' AND segment_value <= '660204zzzz')
OR (segment_value = '6602050101')
OR (segment_value >= '660206' AND segment_value <= '660206zzzz')
OR (segment_value = '6602070601')
OR (segment_value = '6602080101')
OR (segment_value = '6602090101')
OR (segment_value = '6602100101')
OR (segment_value = '6602110101')
OR (segment_value >= '660212' AND segment_value <= '660212zzzz')
OR (segment_value >= '660213' AND segment_value <= '660213zzzz')
OR (segment_value >= '66021501' AND segment_value <= '66021501zz')
OR (segment_value >= '66021502' AND segment_value <= '66021502zz')
OR (segment_value >= '660216' AND segment_value <= '660216zzzz')
OR (segment_value >= '660217' AND segment_value <= '660217zzzz')
OR (segment_value = '6602180101')
OR (segment_value >= '660219' AND segment_value <= '660219zzzz')
OR (segment_value = '6602200101')
OR (segment_value >= '660224' AND segment_value <= '660224zzzz')
OR (segment_value >= '6603' AND segment_value <= '6603zzzzzz')
OR (segment_value = '6609010101')
OR (segment_value = '6609020101')
OR (segment_value >= '671101' AND segment_value <= '671101zzzz')
OR (segment_value >= '6801' AND segment_value <= '6801zzzzzz')
)
;
select * from fnd_flex_values;
select * from fnd_flex_value_sets;
select * from fnd_flex_value_hierarchies;
 SELECT child_flex_value_low,
        child_flex_value_high,
        nvl(structured_hierarchy_level,'-1')
 from   fnd_flex_value_hierarchies fvh, fnd_flex_values fv
 where  1=1
 --and fv.flex_value_set_id = :v_set_id
 and    fv.flex_value_set_id = fvh.flex_value_set_id
 and    fv.flex_value = '6401030801'
 and    fvh.parent_flex_value = fv.flex_value
 order  by nlssort(child_flex_value_low, 'NLS_SORT=BINARY') DESC,
        nlssort(child_flex_value_high, 'NLS_SORT=BINARY') DESC
;


SELECT to_char(axis_seq,'999999999999999.9999999999999'),
		nvl(calculation_seq,-1),
		nvl(operator,'ENTER'),
		to_char(axis_seq_low,'999999999999999.9999999999999'),
		to_char(axis_seq_high,'999999999999999.9999999999999'),
		nvl(axis_name_low,''),
		nvl(axis_name_low,''), constant
	FROM RG_REPORT_CALCULATIONS
	WHERE axis_set_id =28002
	AND (
	operator IS NOT NULL OR calculation_seq IS NOT NULL
	OR (axis_seq_low IS NOT NULL AND axis_seq_high IS NOT NULL)
	OR axis_name_low IS NOT NULL OR axis_name_high IS NOT NULL
	OR constant IS NOT NULL)
	ORDER BY axis_seq ASC,calculation_seq DESC
;


select * from RG_REPORT_STANDARD_AXES_B;

select
	to_char(axis_seq,'999999999999999.9999999999999') AXIS_SEQ,
	nvl(range_mode,'N') RANGE_MODE,
	nvl(sign,'+') SIGN,
	nvl(dr_cr_net_code,'N') DR_CR_NET_CODE,
	nvl(gl.short_name, '') SHORT_NAME,
	gl.short_name  LEDGER_SEGMENT_low,
	gl.short_name  LEDGER_SEGMENT_high,
	nvl(LEDGER_SEGMENT_type,'') LEDGER_SEGMENT_type,
	nvl(SEGMENT1_low,'') SEGMENT1_low,
	nvl(SEGMENT1_high,'') SEGMENT1_high,
	nvl(SEGMENT1_type,'') SEGMENT1_type,
	nvl(SEGMENT2_low,'') SEGMENT2_low,
	nvl(SEGMENT2_high,'') SEGMENT2_high,
	nvl(SEGMENT2_type,'') SEGMENT2_type,
	nvl(SEGMENT3_low,'') SEGMENT3_low,
	nvl(SEGMENT3_high,'') SEGMENT3_high,
	nvl(SEGMENT3_type,'') SEGMENT3_type,
	nvl(SEGMENT4_low,'') SEGMENT4_low,
	nvl(SEGMENT4_high,'') SEGMENT4_high,
	nvl(SEGMENT4_type,'') SEGMENT4_type,
	nvl(SEGMENT5_low,'') SEGMENT5_low,
	nvl(SEGMENT5_high,'') SEGMENT5_high,
	nvl(SEGMENT5_type,'') SEGMENT5_type,
	nvl(SEGMENT6_low,'') SEGMENT6_low,
	nvl(SEGMENT6_high,'') SEGMENT6_high,
	nvl(SEGMENT6_type,'') SEGMENT6_type,
	nvl(SEGMENT7_low,'') SEGMENT7_low,
	nvl(SEGMENT7_high,'') SEGMENT7_high,
	nvl(SEGMENT7_type,'') SEGMENT7_type,
	nvl(SEGMENT8_low,'') SEGMENT8_low,
	nvl(SEGMENT8_high,'') SEGMENT8_high,
	nvl(SEGMENT8_type,'') SEGMENT8_type,
	nvl(SEGMENT9_low,'') SEGMENT9_low,
	nvl(SEGMENT9_high,'') SEGMENT9_high,
	nvl(SEGMENT9_type,'') SEGMENT9_type,
	ac.ledger_id LEDGER_ID 
FROM RG_REPORT_AXIS_CONTENTS ac, GL_LEDGERS gl, GL_LEDGER_RELATIONSHIPS glr 
WHERE axis_set_id = 28002
 AND ac.ledger_id IS NOT NULL 
 AND glr.target_ledger_id = gl.ledger_id 
 AND ((glr.source_ledger_id = gl.ledger_id 
 AND glr.target_ledger_category_code IN ('PRIMARY')) OR  
 (glr.source_ledger_id != gl.ledger_id 
 AND glr.target_ledger_category_code IN ('ALC','SECONDARY'))) 
 AND glr.application_id = 101 
 AND gl.ledger_id = ac.ledger_id  
UNION
 select
	to_char(axis_seq,'999999999999999.9999999999999') AXIS_SEQ,
	nvl(range_mode,'N') RANGE_MODE,
	nvl(sign,'+') SIGN,
	nvl(dr_cr_net_code,'N') DR_CR_NET_CODE,
	nvl(gl.short_name, '') SHORT_NAME,
	gl.short_name  LEDGER_SEGMENT_low,
	gl.short_name  LEDGER_SEGMENT_high,
	nvl(LEDGER_SEGMENT_type,'') LEDGER_SEGMENT_type,
	nvl(SEGMENT1_low,'') SEGMENT1_low,
	nvl(SEGMENT1_high,'') SEGMENT1_high,
	nvl(SEGMENT1_type,'') SEGMENT1_type,
	nvl(SEGMENT2_low,'') SEGMENT2_low,
	nvl(SEGMENT2_high,'') SEGMENT2_high,
	nvl(SEGMENT2_type,'') SEGMENT2_type,
	nvl(SEGMENT3_low,'') SEGMENT3_low,
	nvl(SEGMENT3_high,'') SEGMENT3_high,
	nvl(SEGMENT3_type,'') SEGMENT3_type,
	nvl(SEGMENT4_low,'') SEGMENT4_low,
	nvl(SEGMENT4_high,'') SEGMENT4_high,
	nvl(SEGMENT4_type,'') SEGMENT4_type,
	nvl(SEGMENT5_low,'') SEGMENT5_low,
	nvl(SEGMENT5_high,'') SEGMENT5_high,
	nvl(SEGMENT5_type,'') SEGMENT5_type,
	nvl(SEGMENT6_low,'') SEGMENT6_low,
	nvl(SEGMENT6_high,'') SEGMENT6_high,
	nvl(SEGMENT6_type,'') SEGMENT6_type,
	nvl(SEGMENT7_low,'') SEGMENT7_low,
	nvl(SEGMENT7_high,'') SEGMENT7_high,
	nvl(SEGMENT7_type,'') SEGMENT7_type,
	nvl(SEGMENT8_low,'') SEGMENT8_low,
	nvl(SEGMENT8_high,'') SEGMENT8_high,
	nvl(SEGMENT8_type,'') SEGMENT8_type,
	nvl(SEGMENT9_low,'') SEGMENT9_low,
	nvl(SEGMENT9_high,'') SEGMENT9_high,
	nvl(SEGMENT9_type,'') SEGMENT9_type,
	gl.ledger_id LEDGER_ID 
FROM RG_REPORT_AXIS_CONTENTS ac, GL_LEDGERS gl 
WHERE axis_set_id = 28002
 AND ac.ledger_id IS NOT NULL 
 AND gl.ledger_id IN  
 (SELECT glb.ledger_id 
 FROM gl_ledger_set_assignments glb 
 WHERE glb.ledger_set_id = ac.ledger_id 
  AND glb.ledger_set_id = glb.ledger_id)
UNION 
(select
	to_char(axis_seq,'999999999999999.9999999999999') AXIS_SEQ,
	nvl(range_mode,'N') RANGE_MODE,
	nvl(sign,'+') SIGN,
	nvl(dr_cr_net_code,'N') DR_CR_NET_CODE,
	gl.short_name SHORT_NAME,
	gl.short_name LEDGER_SEGMENT_low,
	gl.short_name LEDGER_SEGMENT_high,
	'T' LEDGER_SEGMENT_type,
	nvl(SEGMENT1_low,'') SEGMENT1_low,
	nvl(SEGMENT1_high,'') SEGMENT1_high,
	nvl(SEGMENT1_type,'') SEGMENT1_type,
	nvl(SEGMENT2_low,'') SEGMENT2_low,
	nvl(SEGMENT2_high,'') SEGMENT2_high,
	nvl(SEGMENT2_type,'') SEGMENT2_type,
	nvl(SEGMENT3_low,'') SEGMENT3_low,
	nvl(SEGMENT3_high,'') SEGMENT3_high,
	nvl(SEGMENT3_type,'') SEGMENT3_type,
	nvl(SEGMENT4_low,'') SEGMENT4_low,
	nvl(SEGMENT4_high,'') SEGMENT4_high,
	nvl(SEGMENT4_type,'') SEGMENT4_type,
	nvl(SEGMENT5_low,'') SEGMENT5_low,
	nvl(SEGMENT5_high,'') SEGMENT5_high,
	nvl(SEGMENT5_type,'') SEGMENT5_type,
	nvl(SEGMENT6_low,'') SEGMENT6_low,
	nvl(SEGMENT6_high,'') SEGMENT6_high,
	nvl(SEGMENT6_type,'') SEGMENT6_type,
	nvl(SEGMENT7_low,'') SEGMENT7_low,
	nvl(SEGMENT7_high,'') SEGMENT7_high,
	nvl(SEGMENT7_type,'') SEGMENT7_type,
	nvl(SEGMENT8_low,'') SEGMENT8_low,
	nvl(SEGMENT8_high,'') SEGMENT8_high,
	nvl(SEGMENT8_type,'') SEGMENT8_type,
	nvl(SEGMENT9_low,'') SEGMENT9_low,
	nvl(SEGMENT9_high,'') SEGMENT9_high,
	nvl(SEGMENT9_type,'') SEGMENT9_type,
	gl.ledger_id LEDGER_ID 
FROM RG_REPORT_AXIS_CONTENTS ac, GL_LEDGERS gl, GL_LEDGER_RELATIONSHIPS glr 
WHERE axis_set_id = 28002
 AND ac.ledger_id IS NULL 
 AND glr.target_ledger_id = gl.ledger_id 
 AND ((glr.source_ledger_id = gl.ledger_id 
 AND glr.target_ledger_category_code IN ('PRIMARY')) OR  
 (glr.source_ledger_id != gl.ledger_id 
 AND glr.target_ledger_category_code IN ('ALC','SECONDARY'))) 
 AND glr.application_id = 101 
 AND gl.ledger_id IN (2023))
UNION 
(select
	to_char(axis_seq,'999999999999999.9999999999999') AXIS_SEQ,
	nvl(range_mode,'N') RANGE_MODE,
	nvl(sign,'+') SIGN,
	nvl(dr_cr_net_code,'N') DR_CR_NET_CODE,
	gl.short_name SHORT_NAME,
	gl.short_name LEDGER_SEGMENT_low,
	gl.short_name LEDGER_SEGMENT_high,
	'T' LEDGER_SEGMENT_type,
	nvl(SEGMENT1_low,'') SEGMENT1_low,
	nvl(SEGMENT1_high,'') SEGMENT1_high,
	nvl(SEGMENT1_type,'') SEGMENT1_type,
	nvl(SEGMENT2_low,'') SEGMENT2_low,
	nvl(SEGMENT2_high,'') SEGMENT2_high,
	nvl(SEGMENT2_type,'') SEGMENT2_type,
	nvl(SEGMENT3_low,'') SEGMENT3_low,
	nvl(SEGMENT3_high,'') SEGMENT3_high,
	nvl(SEGMENT3_type,'') SEGMENT3_type,
	nvl(SEGMENT4_low,'') SEGMENT4_low,
	nvl(SEGMENT4_high,'') SEGMENT4_high,
	nvl(SEGMENT4_type,'') SEGMENT4_type,
	nvl(SEGMENT5_low,'') SEGMENT5_low,
	nvl(SEGMENT5_high,'') SEGMENT5_high,
	nvl(SEGMENT5_type,'') SEGMENT5_type,
	nvl(SEGMENT6_low,'') SEGMENT6_low,
	nvl(SEGMENT6_high,'') SEGMENT6_high,
	nvl(SEGMENT6_type,'') SEGMENT6_type,
	nvl(SEGMENT7_low,'') SEGMENT7_low,
	nvl(SEGMENT7_high,'') SEGMENT7_high,
	nvl(SEGMENT7_type,'') SEGMENT7_type,
	nvl(SEGMENT8_low,'') SEGMENT8_low,
	nvl(SEGMENT8_high,'') SEGMENT8_high,
	nvl(SEGMENT8_type,'') SEGMENT8_type,
	nvl(SEGMENT9_low,'') SEGMENT9_low,
	nvl(SEGMENT9_high,'') SEGMENT9_high,
	nvl(SEGMENT9_type,'') SEGMENT9_type,
	gl.ledger_id LEDGER_ID 
FROM RG_REPORT_AXIS_CONTENTS ac, GL_LEDGERS gl 
WHERE axis_set_id = 28002
 AND ac.ledger_id IS NULL 
  AND gl.ledger_id IN 
 (SELECT glb.ledger_id 
 FROM gl_ledger_set_assignments glb 
 WHERE glb.ledger_set_id IN (2023)
  AND glb.ledger_set_id = glb.ledger_id))
 ORDER BY AXIS_SEQ ASC, LEDGER_ID DESC ,
	LEDGER_SEGMENT_low	DESC,
	LEDGER_SEGMENT_high	DESC,
	LEDGER_SEGMENT_type	DESC,
	SEGMENT1_low	DESC,
	SEGMENT1_high	DESC,
	SEGMENT1_type	DESC,
	SEGMENT2_low	DESC,
	SEGMENT2_high	DESC,
	SEGMENT2_type	DESC,
	SEGMENT3_low	DESC,
	SEGMENT3_high	DESC,
	SEGMENT3_type	DESC,
	SEGMENT4_low	DESC,
	SEGMENT4_high	DESC,
	SEGMENT4_type	DESC,
	SEGMENT5_low	DESC,
	SEGMENT5_high	DESC,
	SEGMENT5_type	DESC,
	SEGMENT6_low	DESC,
	SEGMENT6_high	DESC,
	SEGMENT6_type	DESC,
	SEGMENT7_low	DESC,
	SEGMENT7_high	DESC,
	SEGMENT7_type	DESC,
	SEGMENT8_low	DESC,
	SEGMENT8_high	DESC,
	SEGMENT8_type	DESC,
	SEGMENT9_low	DESC,
	SEGMENT9_high	DESC,
	SEGMENT9_type	DESC
;


SELECT * FROM xdo_lobs
WHERE lob_code = 'FSGXML_BASIC_EXCEL_W_DRILL';

SELECT * FROM RG_REPORT_REQUEST_LOBS order by creation_date desc;
SELECT * FROM RG_REPORT_REQUEST_LOBS where creation_date <= TO_DATE('20170101','YYYYMMDD');
--delete from RG_REPORT_REQUEST_LOBS where creation_date <= TO_DATE('20170101','YYYYMMDD')
select * from rg_report_requests;


select *
from   RG_REPORT_REQUEST_LOBS
where  1=1
and  exists (
        select 1
        from   rg_report_requests intbl
        where  request_id = intbl.report_request_id
)
;