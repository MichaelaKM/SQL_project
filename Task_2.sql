-- Q2.How many liters of milk and kilograms of bread can be bought for the first and last comparable period in the available price and wage data?

SELECT
	min(`date`) AS min_date,
	max(`date`) AS max_date
FROM t_michaela_kendikova_project_sql_primary_final tmkpspf 
;

CREATE OR REPLACE VIEW v_compare_price AS
WITH selected_data as(
SELECT
	`date`,
	product_id,
	product,
	quantity,
	unit ,
	price,
	round(avg(payroll),0) AS payroll
FROM t_michaela_kendikova_project_sql_primary_final tmkpspf
WHERE product LIKE '%mléko%' 
OR product LIKE '%chléb%'
GROUP BY industry, `date`, product_id, product,	quantity, unit ,price
)
SELECT
	`date`,
	product,
	round(avg(price),2) AS avg_price,
	round ((payroll/round(avg(price),2)),0) AS quantity,
	concat ('V roce ', `date`, ' bylo možné koupit ', round ((payroll/round(avg(price),2)),0),' ', unit , ' daného produktu.') AS anser
FROM selected_data
WHERE `date` IN ('2006' , '2018')
GROUP BY `date`,product
;

SELECT *
FROM v_compare_price;
