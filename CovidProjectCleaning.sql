-- CLEANING DATA --

alter table CovidDeaths
drop column weekly_icu_admissions,weekly_icu_admissions_per_million

alter table CovidDeaths
drop column weekly_hosp_admissions,weekly_hosp_admissions_per_million

alter table CovidDeaths
drop column new_tests,total_tests,total_tests_per_thousand,new_tests_per_thousand,new_tests_smoothed,new_tests_smoothed_per_thousand

alter table CovidDeaths
drop column new_tests,total_tests,total_tests_per_thousand,new_te


alter table coviddeaths
alter column date date

alter table coviddeaths
alter column new_deaths_smoothed float



alter table coviddeaths
alter column new_deaths_per_million float

alter table coviddeaths
alter column reproduction_rate float

alter table coviddeaths
alter column icu_patients float

alter table coviddeaths
alter column hosp_patients float


alter table CovidVaccinations
alter column people_fully_vaccinated_per_hundred float

alter table CovidVaccinations
alter column new_tests_smoothed float


alter table CovidVaccinations
alter column new_tests_smoothed_per_thousand float

alter table CovidVaccinations
alter column tests_per_case float

alter table CovidVaccinations
alter column total_vaccinations_per_hundred float

alter table covidvaccinations
alter column date date

select continent,location from CovidVaccinations
where continent is null


select continent,location from coviddeaths
where location = 'european union'
order by continent desc

select continent,location from coviddeaths
where continent = 'world'
order by continent desc

select *from CovidDeaths
where location= 'European Union'
order by 2,4


update CovidVaccinations
set continent=Location,Location=null
where continent is null and
Location in ('Africa','Asia','Europe','Oceania','South America','World','North America','International')

select *from CovidVaccinations
where location='European Union'

update CovidVaccinations
set continent='Europe'
where Location='European Union'

update CovidVaccinations
set Location='Unknown'
where Location is null

delete from coviddeaths
where location ='Unknown'

delete from covidvaccinations
where location ='Unknown'

alter table CovidVaccinations
add population float

UPDATE CovidVaccinations
SET CovidVaccinations.population= CovidDeaths.population
FROM CovidDeaths
JOIN CovidVaccinations
ON CovidDeaths.location = CovidVaccinations.location;


select d.continent,d.location,v.continent,v.location,i.continent,i.location,d.population,v.population,i.population
from CovidDeaths d join CovidVaccinations v on d.iso_code=v.iso_code join CovidInformation i on v.iso_code=i.iso_code
where d.population is null and v.population is null and i.population is null

select *from CovidDeaths
where population is null

delete from CovidInformation
where population is null

delete from CovidVaccinations
where population is null


select reproduction_rate from CovidDeaths
where reproduction_rate is null
order by location,date 



select continent,location,date
from CovidVaccinations
order by location,date 

select continent,location,date
from CovidDeaths
order by location,date 

select continent,location,date
from CovidInformation
order by location,date 


--Check If There Is Any Duplicate Values--
select location, date, COUNT(*)
FROM CovidInformation
group by  location, date
having COUNT(*) > 1

select location, date, COUNT(*)
FROM CovidDeaths
group by  location, date
having COUNT(*) > 1

select location, date, COUNT(*)
FROM CovidVaccinations
group by  location, date
having COUNT(*) > 1



select * from CovidInformation
--where extreme_poverty is not null
where median_age is null and aged_65_older is null and gdp_per_person is null and extreme_poverty is null
and srtingency_index is null and cardiovasc_death_rate is null and diabetes_prevalence is null and life_expectancy is null
order by location,date


select * from CovidDeaths d join CovidVaccinations v
on d.iso_code=v.iso_code
where d.location in ('European Union','Guernsey','Jersey')
and
v.location in ('European Union','Guernsey','Jersey') 
order by d.location,d.date

select *from CovidDeaths 
where location in ('European Union','Guernsey','Jersey')
order by location,date


select * from CovidDeaths
--where location in ('European Union','Guernsey','Jersey')
--where location='Afghanistan'
order by location,date

select distinct location from CovidVaccinations
--where location in ('European Union','Guernsey','Jersey')
--where location='Afghanistan'
where total_tests is not null and total_vaccinations is not null
order by location



select *from CovidInformation
--where location in ('European Union','Guernsey','Jersey')
--where location='Afghanistan'
order by location,date



select * 
from CovidVaccinations
where new_tests is null and total_tests is null and new_tests_smoothed is null and tests_per_case is null 
and total_vaccinations is null and people_fully_vaccinated is null and people_vaccinated is null
order by location,date


select * 
from CovidDeaths
where total_cases is null and new_cases is null and new_cases_smoothed is null 
and total_deaths is null and new_deaths is null and new_deaths_smoothed is null and reproduction_rate is null
order by location,date


select v.*,d.new_cases,d.total_cases,d.total_deaths,d.new_deaths,d.new_cases_smoothed,d.new_deaths_smoothed
from CovidVaccinations v join CovidDeaths d 
on v.location=d.location and v.date=d.date
where
new_tests is null and total_tests is null and new_tests_smoothed is null and tests_per_case is null 
and total_vaccinations is null and people_fully_vaccinated is null and people_vaccinated is null
and total_cases is null and new_cases is null and new_cases_smoothed is null 
and total_deaths is null and new_deaths is null and new_deaths_smoothed is null and reproduction_rate is null
order by location,date



DELETE v
FROM CovidVaccinations v
JOIN CovidDeaths d 
ON v.location = d.location
WHERE new_tests IS NULL 
  AND total_tests IS NULL 
  AND new_tests_smoothed IS NULL 
  AND tests_per_case IS NULL
  AND total_vaccinations IS NULL 
  AND people_fully_vaccinated IS NULL 
  AND people_vaccinated IS NULL
  AND total_cases IS NULL 
  AND new_cases IS NULL 
  AND new_cases_smoothed IS NULL
  AND total_deaths IS NULL 
  AND new_deaths IS NULL 
  AND new_deaths_smoothed IS NULL
  AND reproduction_rate IS NULL;



DELETE FROM CovidDeaths
WHERE 
  total_cases IS NULL 
  AND new_cases IS NULL 
  AND new_cases_smoothed IS NULL
  AND total_deaths IS NULL 
  AND new_deaths IS NULL 
  AND new_deaths_smoothed IS NULL
  AND reproduction_rate IS NULL;



select date from CovidVaccinations
WHERE date NOT IN (SELECT date FROM CovidDeaths);

delete from CovidVaccinations
where date not in (select date from CovidDeaths)

select population from CovidVaccinations
WHERE population NOT IN (SELECT population FROM CovidDeaths);

select location from CovidVaccinations
WHERE location NOT IN (SELECT location FROM CovidDeaths);


delete from CovidInformation
where location in ('European Union','Guernsey','Jersey') 

delete from CovidDeaths
where location in ('European Union','Guernsey','Jersey') 

delete from CovidVaccinations
where location in ('European Union','Guernsey','Jersey') 


alter table CovidDeaths
drop column icu_patients,icu_patients_per_million,hosp_patients,hosp_patients_per_million


