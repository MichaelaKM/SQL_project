-- Q:4.Is there a year in which the year-on-year increase in food prices was significantly higher than wage growth (greater than 10%)?

CREATE OR REPLACE TABLE t_price_payroll_develop1 AS
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
	round((((sd.price/sd2.price)-1)*100),0) AS price_perct_growth,
	round((((sd.avg_payroll/sd2.avg_payroll)-1)*100),0) AS payroll_perct_growth,
	round((((sd.price/sd2.price)-1)*100)-(((sd.avg_payroll/sd2.avg_payroll)-1)*100),0) AS difference,
	CASE WHEN round((((sd.price/sd2.price)-1)*100)-(((sd.avg_payroll/sd2.avg_payroll)-1)*100),0)>=10 THEN 1
		ELSE 0		
	END AS comparison
FROM selected_data sd
JOIN selected_data sd2
	ON sd.`date`=sd2.`date`+1
GROUP BY  sd.`date`
ORDER BY comparison DESC;
;

SELECT *
FROM t_price_payroll_develop1
ORDER BY comparison DESC 
;

-- detailed info:
CREATE OR REPLACE TABLE t_price_payroll_develop AS
WITH selected_data as(
SELECT 
	`date`,
	product,
	round(avg(price),2) AS price,
	round(avg(payroll),2) AS avg_payroll
FROM t_michaela_kendikova_project_sql_primary_final tmkpspf
GROUP BY `date`, product
ORDER BY date DESC
)
SELECT 
	sd.`date` AS `year`,
	sd.product,
	round((((sd.price/sd2.price)-1)*100),0) AS price_perct_growth,
	round((((sd.avg_payroll/sd2.avg_payroll)-1)*100),0) AS payroll_perct_growth,
	round((((sd.price/sd2.price)-1)*100)-(((sd.avg_payroll/sd2.avg_payroll)-1)*100),0) AS difference,
	CASE WHEN round((((sd.price/sd2.price)-1)*100)-(((sd.avg_payroll/sd2.avg_payroll)-1)*100),0)>=10 THEN 1
		ELSE 0		
	END AS comparison
FROM selected_data sd
JOIN selected_data sd2
	ON sd.`date`=sd2.`date`+1
	AND sd.product=sd2.product
GROUP BY sd.`date`, sd.product
ORDER BY difference DESC 
;

SELECT *
FROM t_price_payroll_develop tppd
ORDER BY comparison DESC , `year` 
;

