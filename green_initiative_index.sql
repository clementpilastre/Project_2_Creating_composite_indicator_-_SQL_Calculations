/* Creation of the database */
create database if not exists week2_project;
use week2_project;

create table countries(
country_name varchar(25) primary key,
country_code varchar(3)
);

insert into countries (country_name, country_code)
values("Brazil", "BRA"), ("China", "CHN"), ("Spain", "ESP"), ("France", "FRA"), ("United Kingdom", "GBR"), 
("Germany", "DEU"), ("India", "IND"), ("Japan", "JPN"), ("United States", "USA"), ("South Korea", "KOR");

create table renewable_investment (
country_name varchar(25), 
foreign key(country_name) references countries(country_name),
renewable_invest bigint
);

insert into renewable_investment (country_name, renewable_investment)
values("Brazil", "12000000000"), ("China", "266000000000"), ("Spain", "11000000000"), ("France", "27000000000"), ("United Kingdom", "31000000000"), 
("Germany", "47000000000"), ("India", "14000000000"), ("Japan", "26000000000"), ("United States", "114000000000"), ("South Korea", "13000000000");

create table gdp (
country_name varchar(25), 
foreign key(country_name) references countries(country_name),
gdp bigint
);

insert into gdp (country_name, gdp)
values("Brazil", "1608981220812"), ("China", "17734062645371"), ("Spain", "1425276586282"), ("France", "2937472757953"), ("United Kingdom", "3186859739185"), 
("Germany", "4223116205968"), ("India", "3173397590816"), ("Japan", "4937421880461"), ("United States", "22996100000000"), ("South Korea", "1798533915091");

create table owid_energy_data (
country_name varchar(25), 
foreign key(country_name) references countries(country_name),
year year,
energy_cons_change_pct float, 
renewables_cons_change_pct float
);

create table renewable_energy_usage (
country_name varchar(25), 
foreign key(country_name) references countries(country_name),
renewable_energy_usage float
);

insert into owid_energy_data (country_name, year, energy_cons_change_pct, renewables_cons_change_pct)
values("Brazil", "2022", "-5.2", "19.83"), ("China", "2022", "-38", "196"), ("Spain", "2022", "8.5", "33"), ("France", "2022", "4.7", "63"), ("United Kingdom", "2022", "15", "154"), 
("Germany", "2022", "4.7", "75"), ("India", "2022", "-85", "85"), ("Japan", "2022", "12", "81"), ("United States", "2022", "-1.1", "52"), ("South Korea", "2022", "-7.9", "207");

select renewable_investment.country_name, renewable_investment.renewable_invest, gdp.gdp, renewable_investment.renewable_invest/gdp.gdp*100 as results 
from renewable_investment
left join countries
on renewable_investment.country_name = countries.country_name
left join gdp
on countries.country_name = gdp.country_name
order by renewable_investment.country_name ASC;

select renewable_investment.country_name, 
renewable_energy_usage.renewable_energy_usage*4 + (renewable_investment.renewable_invest/gdp.gdp*100)*10
+ owid_energy_data.renewables_cons_change_pct*0.75 + owid_energy_data.energy_cons_change_pct*1.25 as results 
from renewable_investment
left join countries
on renewable_investment.country_name = countries.country_name
left join gdp
on countries.country_name = gdp.country_name
left join owid_energy_data
on countries.country_name = owid_energy_data.country_name and owid_energy_data.year = 2022
left join renewable_energy_usage
on countries.country_name = renewable_energy_usage.country_name
order by results DESC;

