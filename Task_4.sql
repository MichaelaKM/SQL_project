-- Q:4.Is there a year in which the year-on-year increase in food prices was significantly higher than wage growth (greater than 10%)?

CREATE OR REPLACE TABLE t_price_payroll_develop AS
WITH selected_data as(
SELECT 
	`date`,
	round(avg(price),2) AS price,
	round(avg(payroll),2) AS avg_payroll
FROM t_michaela_kendikova_project_sql_primary_final tmkpspf
GROUP BY `date`
ORDER BY date DESC
)
SELECT 
	sd.`date` AS `year`,
	round((((sd2.price/sd.price)-1)*100),0) AS price_perct_growth,
	round((((sd2.avg_payroll/sd.avg_payroll)-1)*100),0) AS payroll_perct_growth,
	round((((sd2.price/sd.price)-1)*100)-(((sd2.avg_payroll/sd.avg_payroll)-1)*100),0) AS difference,
	CASE WHEN round((((sd2.price/sd.price)-1)*100)-(((sd2.avg_payroll/sd.avg_payroll)-1)*100),0)>=10 THEN 1
		ELSE 0		
	END AS comparison
FROM selected_data sd
JOIN selected_data sd2
	ON sd.`date`=sd2.`date`+1
GROUP BY sd.`date`
ORDER BY difference DESC 
;

SELECT *
FROM t_price_payroll_develop tppd
;