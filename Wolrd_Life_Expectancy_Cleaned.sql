SELECT * FROM world_life_expectancy.world_life_expectancy;

INSERT INTO world_life_expectancy
SELECT * FROM world_life_expectancy_backup;

Select 
	country, 
	year,
	concat(country,year),
    count(concat(country,year))
from
	world_life_expectancy
group by 
	country, 
	year,
	concat(country,year)
Having
	count(concat(country,year)) > 1;
 
 select *
from (Select 
	row_id,
    concat(country,year),
    row_number() over(partition by concat(country,year) order by concat(country,year)) as row_num
	from world_life_expectancy
    ) as row_table
where row_num  > 1
    ;

Delete from world_life_expectancy
where 
	row_id in (
     select row_id
from (Select 
	row_id,
    concat(country,year),
    row_number() over(partition by concat(country,year) order by concat(country,year)) as row_num
	from world_life_expectancy
    ) as row_table
where row_num  > 1
)
    ;
    
Select * 
from world_life_expectancy;

Select 
distinct(status)
from world_life_expectancy
where status = ''
;


Select * 
from world_life_expectancy
where status = ''
;

Select Distinct(country)
from world_life_expectancy
where status = 'Developing'
;

Update world_life_expectancy
set status = 'Developing'
where country in
	(Select Distinct(country)
	from world_life_expectancy
	where status = 'Developing');
#cant use from clause here ^

Update world_life_expectancy as t1
join world_life_expectancy as t2
	on t1.country = t2.country
set  t1.status = 'Developing'
where t1.status = ''
and t2.status <>  ''
and t2.status  = 'Developing'
;


Select * 
from world_life_expectancy
where status = '';



Update world_life_expectancy as t1
join world_life_expectancy as t2
	on t1.country = t2.country
set  t1.status = 'Developed'
where t1.status = ''
and t2.status <>  ''
and t2.status  = 'Developed'
;

Select *
from world_life_expectancy
where `Life expectancy` = '';customer_orders

Select country,
	year,
    `life expectancy`
from
	world_life_expectancy;


Select 
t1.country,
t1.year,
t1.`Life expectancy`,
t2.country,
t2.year,
t2.`Life expectancy`,
t3.country,
t3.year,
t3.`Life expectancy`,
round((t2.`Life expectancy` + t3. `Life expectancy` )/2,1)
from world_life_expectancy as t1
join world_life_expectancy as t2
	on t1.country = t2.country
    and t1.year = t2.year - 1
join world_life_expectancy as t3
	on t1.country = t3.country
    and t1.year = t3.year + 1
where t1.`Life expectancy` = '';


update world_life_expectancy t1
join world_life_expectancy as t2
	on t1.country = t2.country
    and t1.year = t2.year - 1
join world_life_expectancy as t3
	on t1.country = t3.country
    and t1.year = t3.year + 1
set t1.`Life expectancy` = round((t2.`Life expectancy` + t3. `Life expectancy` )/2,1)
where t1.`Life expectancy` = '';

