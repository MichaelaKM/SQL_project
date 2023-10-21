				
SELECT 
	min(payroll_year),
	max (payroll_year)
FROM czechia_payroll cp
;

SELECT 
	min(date_from),
	max (date_from)
FROM czechia_price cp
;

CREATE TABLE IF NOT EXISTS t_michaela_kendikova_project_SQL_primary_final
WITH czechia_payroll_selection as(
	SELECT *
	FROM czechia_payroll 
	WHERE value_type_code = '5958' 
) 
SELECT
	date_format(cpr.date_from,'%X') AS `date`,
	cpib.name AS industry,
	cps.value AS payroll,
	cpr.id AS product_id,
	cpc.name AS product,
	cpr.value AS price,
	cpc.price_value AS quantity,
	cpc.price_unit AS unit
FROM czechia_payroll_selection cps 
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cps.industry_branch_code = cpib.code
LEFT JOIN czechia_price cpr
	ON date_format(cpr.date_from,'%X') = date_format(makedate(cps.payroll_year,365), '%X')
LEFT JOIN czechia_price_category cpc
	ON cpr.category_code = cpc.code
;





