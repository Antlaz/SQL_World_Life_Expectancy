# World LIfe Expactancy EDA
Select *
From world_life_expectancy;

#select and order countries that have the greatest improvement in life expectancy
Select country,
	min(`Life Expectancy`), 
	max(`Life Expectancy`),
    round(max(`Life Expectancy`) - min(`Life Expectancy`),1) as increase_in_life_expectancy_15_years
from world_life_expectancy
group by country
having min(`Life Expectancy`)  <> 0
and max(`Life Expectancy`) <> 0
order by increase_in_life_expectancy_15_years desc;

#select and order countries that have the smallest improvement in life expectancy
Select country,
	min(`Life Expectancy`), 
	max(`Life Expectancy`),
    round(max(`Life Expectancy`) - min(`Life Expectancy`),1) as increase_in_life_expectancy_15_years
from world_life_expectancy
group by country
having min(`Life Expectancy`)  <> 0
and max(`Life Expectancy`) <> 0
order by increase_in_life_expectancy_15_years asc;

#Find avg life expextancy by year for the total population
Select
	year, 
	round(avg(`Life Expectancy`),1)
from
	world_life_expectancy
where
	`Life Expectancy`  <> 0
	and `Life Expectancy` <> 0
group by
	year
order by
	year;
    
    
#Select avg life expectancy correlated with GDP
Select 
	country,
    Round(avg(`Life expectancy`),1) as Life_exp,
    round(avg(GDP),1) as GDP
From world_life_expectancy
group by country
having Life_exp > 0
and GDP > 0
order by GDP Desc;

#Find avg life exp for High and low GDP countries (countries with GDP over/under ~average GDP of 1500)
Select 
Sum(Case when GDP >= 1500 then 1  else 0 End) as High_GDP_Count,
Round(AVG(Case when GDP >= 1500 then `Life expectancy` else Null End),1) as High_GDP_Life_exp,
Sum(Case when GDP <= 1500 then 1  else 0 End) as Low_GDP_Count,
Round(AVG(Case when GDP <= 1500 then `Life expectancy` else Null End),1) as low_GDP_Life_exp
From
	world_life_expectancy;
    
#Find avg developed life exp vs developing life exp
Select status, round(avg(`Life expectancy`),1),count(distinct country)
From world_life_expectancy
group by status;

#Correlation between BMI and life expectancy
Select 
	country,
    Round(avg(`Life expectancy`),1) as Life_exp,
    round(avg(BMI),1) as BMI
From world_life_expectancy
group by country
having Life_exp > 0
and BMI > 0
order by BMI Desc;

#rolling total of adult mortality 
Select country, year, `Life expectancy`, `Adult Mortality`,
sUM(`Adult Mortality`) Over(PARTITION BY country order by year) as Rolling_Total_Adult_Mortality
from world_life_expectancy;


