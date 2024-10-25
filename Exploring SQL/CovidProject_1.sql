-- EXPLORE THE DATA AND ASK QUESTION --
--First Num Of Queries To Understand Data--
--NOTE:We Work On UNITED STATES To Help Us Understanding The Column Carefully--

--COVID DEATHS TABLE--
select location,date,population,total_cases,new_cases,new_cases_smoothed,total_cases_per_million,new_cases_per_million,new_cases_smoothed_per_million
from CovidDeaths
--where location='cambodia'
order by date

select location,date,population,total_deaths,new_deaths,new_deaths_smoothed,total_deaths_per_million,new_deaths_per_million,new_deaths_smoothed_per_million
from CovidDeaths
--where location='united states'
order by location,date

select location,date,reproduction_rate
from CovidDeaths
--where  location='United States'
order by date



--select location,date,population,weekly_icu_admissions,weekly_icu_admissions_per_million
--from CovidDeaths
--where  location='United States'
--where weekly_icu_admissions is not null and weekly_icu_admissions_per_million is not null 
--order by date,location

--select location,date,hosp_patients,hosp_patients_per_million
--from CovidDeaths
--where  location='United States'
--order by date

--select location,date,positive_rate,stringency_index 
--from CovidDeaths
--where  location='United States'
--order by date


--select population,population_density
--from CovidDeaths
--order by population_density desc
--where location='United States'


-------------------------------------------------------------------------------------------------------------------------------
--COVID VACCINATIONS TABLE--

select location,date,population,new_tests,new_tests_per_thousand,total_tests,total_tests_per_thousand,new_tests_smoothed
,new_tests_smoothed_per_thousand
from CovidVaccinations
where location ='united states'
order by date

select location,date,tests_per_case,tests_units
from CovidVaccinations
where location ='united states'
order by date

select *
from CovidVaccinations
where tests_units is null

select location,date,new_tests,new_tests_per_thousand,total_tests,total_tests_per_thousand,new_tests_smoothed
,new_tests_smoothed_per_thousand,tests_per_case,tests_units
from CovidVaccinations
where new_tests_smoothed is not null and
new_tests_smoothed_per_thousand is not null
order by date

select location,date,
total_vaccinations,total_vaccinations_per_hundred,
people_vaccinated,people_vaccinated_per_hundred,
people_fully_vaccinated,people_fully_vaccinated_per_hundred
from CovidVaccinations 
--where location='United States'


-------------------------------------------------------------------------------------------------------------------------------
--Created A New Table To Make The Data More Easy To Understand--
create table CovidInformation
(
iso_code nvarchar(255),
continent nvarchar(255),
location nvarchar(255),
date date,
population float,
median_age float,
aged_65_older float,
gdp_per_person float,
extreme_poverty float,
srtingency_index float,
cardiovasc_death_rate float,
diabets_prevalence float,
life_expectancy float
)

insert into CovidInformation(iso_code,continent,location,date,population,
median_age,aged_65_older,gdp_per_person,extreme_poverty,srtingency_index,cardiovasc_death_rate,
diabets_prevalence,life_expectancy)
select 
iso_code,continent,location,date,population,
median_age,aged_65_older,gdp_per_capita,extreme_poverty,stringency_index,cardiovasc_death_rate,
diabetes_prevalence,life_expectancy
from CovidDeaths

select distinct *from CovidInformation
where location ='United States'
order by location,date


-------------------------------------------------------------------------------------------------------------------------------
--After We Understand And Cleaned The Data And Column We Will Ask Sum Question To Understand Data More--

select *from CovidDeaths
order by location,date

select top(20) location,sum(total_deaths)as "Max Num Of Deaths"
from CovidDeaths
group by location
order by "Max Num Of Deaths"desc


--1-What Is Country That Has Max Total Cases And Total Deaths?--
select location,max(total_cases)as "Max Num Of Cases",max(total_deaths)as "Max Num Of Deaths"
from CovidDeaths
group by location
order by "Max Num Of Cases"desc ,"Max Num Of Deaths"desc



--What Is The Death Percentage If You Contract Covid In Your Country?--
select location,sum(total_cases)as"Total Cases",sum(total_deaths)as"Total Deaths",
(sum(total_deaths)/sum(total_cases))*100 as "Death Percentage"
from CovidDeaths
--where location='United States'
group by location
order by  "Total Cases" desc


--What Percentage Of Population Got Covid Throught The Daily History?--
select distinct location,date,population,total_cases,(total_cases/population)*100 as "Percent Of Population Infected "
from CovidDeaths
order by location,date


--select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as "Death Percentage"
--from CovidDeaths
--where location like '%states%'
--order by location,date

--select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as "Death Percentage"
--from CovidDeaths
--where location like '%egypt%'
--order by location,date

--What Is The Number Of New_Casec And New_Deaths Over Time?--
select year(date),MONTH(date),sum(new_cases) as Total_New_Cases,sum(new_deaths) as Total_New_Deaths
from CovidDeaths
--where date='4/27/2020'
group by year(date),MONTH(date)
order by year(date),MONTH(date)

select distinct date from CovidDeaths
order by date



--What Is The Daily Average Of New_C_Smoothed And New_D_Smoothed?--
select  date,avg(new_cases_smoothed_per_million)"Avg Of New Cases Smoothed Per M",avg(new_deaths_smoothed_per_million)"Avg Of New Deaths Smoothed Per M"
from CovidDeaths
group by date
order by date


--select location,date,total_vaccinations,total_vaccinations_per_hundred,people_vaccinated,people_vaccinated_per_hundred,
--people_fully_vaccinated,people_fully_vaccinated_per_hundred 
--from CovidVaccinations

--select location,total_vaccinations from CovidVaccinations
--order by total_vaccinations desc

--What Is The Most Country That Achieved The Heighst Percentage Of Fully Vaccinatated People?--
select location,MAX(people_fully_vaccinated_per_hundred) as Max_Vaccination_Percentage
from CovidVaccinations
where people_fully_vaccinated_per_hundred is not null
group by location
order by Max_Vaccination_Percentage desc


--What Is The Total Vaccination That Taken In Each Country?--
select location,sum(total_vaccinations) as "Sum Of Total Vaccination"
from CovidVaccinations
group by location
order by "Sum Of Total Vaccination" desc

select distinct location
from CovidDeaths




--What Is The Total Number Of Test Unit Is Used?--
select tests_units,count(tests_units)"Number Of Test Unit" 
from CovidVaccinations
where tests_units is not null
group by tests_units
order by "Number Of Test Unit"  desc



--Global Numbers--

--Total cases & New cases & New deaths & Total deaths Over Date--
select sum(total_cases)as"Sum of Total Cases",sum(new_cases)as"Sum Of New Cases"
from CovidDeaths
--group by date
--order by date desc


select sum(total_deaths)as"Sum of Total Deaths",sum(new_deaths)as"Sum Of New Deaths"
from CovidDeaths
--group by date
--order by date desc



--Different Diseases--
select distinct location,cardiovasc_death_rate,diabetes_prevalence
from CovidInformation
where cardiovasc_death_rate is not null and diabetes_prevalence is not null
order by location


--Some Age Information Related To Population In Each Country--
select distinct location,population,median_age,aged_65_older,life_expectancy
from CovidInformation
order by  population desc



--Some Economic Information Related To Population In Each Country--
select distinct location,population,gdp_per_person,extreme_poverty
from CovidInformation
where gdp_per_person is not null and extreme_poverty is not null
order by  population desc


--What Is The Most Country That Has Most TotalDeaths In Each Continent?--
with DeathsPerCountry as(
    select continent,location,SUM(total_deaths)as"Total Deaths"
    from CovidDeaths
    group by continent,location
)
select continent,location,"Total Deaths"
from DeathsPerCountry cte
where "Total Deaths" = (
    select MAX("Total Deaths")
    from DeathsPerCountry
    where continent = cte.continent
)
order by "Total Deaths" DESC;






















