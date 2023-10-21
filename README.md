# SQL_project

INTRODUCTION TO THE PROJECT:
In your analytical department of an independent company that deals with the standard of living of citizens, you have agreed to try to answer a few defined research questions that address the availability of staple foods to the general public. Colleagues have already defined the basic questions that they will try to answer and provide this information to the press department. This department will present the results at the next conference focused on this area.

Research questions:
1. Over the years, are wages rising in all industries, or falling in some?
2. How many liters of milk and kilograms of bread can be bought for the first and last comparable period in the available price and wage data?
3. Which food category is increasing in price the slowest (it has the lowest percentage year-on-year increase)?
4. Is there a year in which the year-on-year increase in food prices was significantly higher than wage growth (greater than 10%)?
5. Does the level of GDP affect changes in wages and food prices? Or, if the GDP increases more significantly in one year, will this be reflected in food prices or wages in the same or the following year by a more significant increase?

EXPEXTED OUTPUT:
Help colleagues with the given task. The output should be two tables in the database from which the required data can be obtained. Name the tables t_{name}_{surname}_project_SQL_primary_final (for wage and food price data for the Czech Republic unified for the same comparable period – common years) and t_{name}_{surname}_project_SQL_secondary_final (for additional data on other European countries).

PROJECT OUTPUT:
Firstly I went through the data I was given and I selected the data I needed to create a new table. Then I created two tables by adapting one of the tables and adding all the essential filtered data from other tables. One of the tables containing the required data is named t_michaela_kendikova_project_SQL_primary_final and the second is named t_michaela_kendikova_project_SQL_primary_final.

1.Q:Over the years, are wages rising in all industries, or falling in some?
By comparing the average payrool from one year with the previous one, we were able to identify the years where the wages were incresing/decreasing. In the file     Answer1, there is a SQL code creating a view where is the comparasition showen in detail for aech industry. By selecting only the data where the wages were         decreasing, we were able to come to a conclution: During the set timeframe, the wages were increasing in all of the monitored area except for: 
  - In year 2009, payroll in fields 'Těžba a dobývání; Ubytování, stravování a pohostinství; Zemědělství, lesnictví, rybářství' decreased in comperation with the previous year.
  - In year 2010, payroll in fields 'Vzdělávání; Veřejná správa a obrana; povinné sociální zabezpečení; Profesní, vědecké a technické činnosti' decreased in comperation with the previous year.
  - In year 2011, payroll in fields 'Veřejná správa a obrana; povinné sociální zabezpečení; Ubytování, stravování a pohostinství; Kulturní, zábavní a rekreační činnosti' decreased in comperation with the previous year.
  -In year 2013, payroll in fields 'Profesní, vědecké a technické činnosti; Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu; Kulturní, zábavní a rekreační činnosti; Činnosti v oblasti nemovitostí; Stavebnictví; Velkoobchod a maloobchod; opravy a údržba motorových vozidel; Těžba a dobývání; Zásobování vodou: činnosti související s odpady a sanacemi; Peněžnictví a pojišťovnictví; Informační a komunikační činnosti; Administrativní a podpůrné činnosti' decreased in comperation with the previous year.
 - In year 2014, payroll in field 'Těžba a dobývání' decreased in comperation with the previous year.
 - In year 2015, payroll in field 'Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu' decreased in comperation with the previous year.
 - In year 2016 , payroll in fields 'Těžba a dobývání' decreased in comperation with the previous year.
   
2.Q:How many liters of milk and kilograms of bread can be bought for the first and last comparable period in the available price and wage data?
Firstly, there was a need the find out the first and last comparable period. Then by using Common table expression, I sorted out the irrelevant data, then I created table cantaining information about average prices and average wages. By deviding the average payroll to the average price in each year, we were able to come to a conclusion:
- In 2006, people who had an average payroll were able to buy 1190 kg of bread and 1331 l of milk every month.
- In 2018, people who had an average payroll were able to buy 1300 kg of bread and 1590 l of milk every month.

3.Q:Which food category is increasing in price the slowest (it has the lowest percentage year-on-year increase)?
Again, I used a Common table expression to select only the needed data. I entered the average prices of the products for each year to the calculation. Then I joined the table on itself to compare the price with the previous year as I did in the previous tasks as well. By sorting the data in the newly created view called 'v_price_differences', we we able to datermine that:
- The largest decrease occured in product 'Papriky' in 2007. Other products which price has decreased are shown in the view.

4.Q: Is there a year in which the year-on-year increase in food prices was significantly higher than wage growth (greater than 10%)?
In this task, I made a new column for and average price and for an average payroll in each year. Then I compared the prices and wages with the numbers from previous years. So I was able to determine the percentage of the value change. I added one more culumn, where I compared the difference between price's and payrolls' change. We were able to compare the data between years 2007 to 20018:
- Only in year 2009 the was a 10% difference between the monitored values. That years average prices has increased by 7% meanwhile average payrolles decreased by 3%.
- In other years, the difference was not that significant.
  
5. Q: Does the level of GDP affect changes in wages and food prices? Or, if the GDP increases more significantly in one year, will this be reflected in food prices or wages in the same or the following year by a more significant increase?

