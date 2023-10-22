-- Q:5.Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

CREATE OR REPLACE VIEW v_comparison_GDP_price_payroll AS 
WITH temporary_table as(
SELECT
	`year` ,
	GDP 
FROM t_michaela_kendikova_project_sql_secondary_final tmkpssf2
WHERE country = 'czech republic'
)
SELECT
	tt2.`year`AS year_prev,
	tt.`year` AS `year`,
	tppd2.`year` AS year_next,
	round(avg(tppd.price_perct_growth),0) AS price_diff,
	round(avg(tppd2.price_perct_growth),0) AS price_diff_next,
	round(avg(tppd.payroll_perct_growth),0) AS payroll_diff,
	round(avg(tppd2.payroll_perct_growth),0) AS payroll_diff_next,
	round((((tt.GDP/tt2.GDP)-1)*100),0) AS GDP_dev,
	CASE WHEN round((((tt.GDP/tt2.GDP)-1)*100),0)>0 THEN 
		CASE WHEN  round(avg(tppd.price_perct_growth),0)>=5 THEN
			CASE WHEN round(avg(tppd2.price_perct_growth),0)>=5 THEN 'Icrease GDP and incease both current and next years price'
				ELSE 'Icrease GDP and incease current price but not next years price'
			END
		ELSE CASE WHEN round(avg(tppd2.price_perct_growth),0)>=5 THEN  'Incerase GDP and next years price but not current price'
			ELSE 'Increase of GDP but nor current or next years price'
			END 
		END 
	ELSE 'Not incearing GDP'
	END AS price_compare,
	CASE WHEN round((((tt.GDP/tt2.GDP)-1)*100),0)>0 THEN 
		CASE WHEN  round(avg(tppd.payroll_perct_growth),0)>=5 THEN
			CASE WHEN round(avg(tppd2.payroll_perct_growth),0)>=5 THEN 'Icrease GDP and incease both current and next years wages'
				ELSE 'Icrease GDP and incease current wages but not next years wages'
			END
		ELSE CASE WHEN round(avg(tppd2.payroll_perct_growth),0)>=5 THEN  'Incerase GDP and next years wages but not current wages'
			ELSE 'Increase of GDP but nor current or next years wages'
			END 
		END 
	ELSE 'Not incearing GDP'
	END AS payroll_compare
FROM temporary_table tt
LEFT JOIN temporary_table tt2
	ON tt.`year`=tt2.`year`+1
LEFT JOIN t_price_payroll_develop tppd
	ON tt.`year`=tppd.`year`
LEFT JOIN t_price_payroll_develop tppd2 
	ON tppd.`year`=tppd2.`year`-1
	AND tppd.product=tppd2.product
WHERE tppd.price_perct_growth IS NOT NULL
AND tppd2.price_perct_growth IS NOT NULL
AND tppd.payroll_perct_growth  IS NOT NULL
AND tppd2.payroll_perct_growth IS NOT NULL
GROUP BY tt.`year` 
;

SELECT *
FROM v_comparison_gdp_price_payroll vcgpp
;

