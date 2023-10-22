-- Q3. Which food category is increasing in price the slowest (it has the lowest percentage year-on-year increase)?

CREATE OR REPLACE VIEW v_price_differences AS 
WITH selected_data as(
SELECT
	`date`,
	product,
	round(avg(price),2) AS price
FROM t_michaela_kendikova_project_sql_primary_final tmkpspf
GROUP BY `date`,product
ORDER BY date DESC
)
SELECT
	sd.`date` AS `date`,
	sd2.`date` AS prev_date,
	sd.product,
	round((((sd.price/sd2.price)-1)*100),2) AS percent_diff
FROM selected_data sd
JOIN selected_data sd2
	ON sd.`date`=sd2.`date`+1
	AND sd.product=sd2.product
GROUP BY sd.product, sd.`date`, sd2.`date`
ORDER BY percent_diff, `date`
;

SELECT *
FROM v_price_differences vpd
;

SELECT
	product,
	round(avg(percent_diff),0)
FROM v_price_differences
GROUP BY product
ORDER BY percent_diff 
;
