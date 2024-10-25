--What Is The Heighst And Lowest Reproduction In Each Country For The Total Vaccination?--
select d.location,max(reproduction_rate) AS "Max Reproduction Rate" ,min(reproduction_rate) AS"Min Reproduction Rate",total_vaccinations
from CovidDeaths d join CovidVaccinations v
    on d.location=v.location and d.date=v.date
group by d.location,total_vaccinations
order by "Max Reproduction Rate" desc



--What Is The Relation Between Total Cases And Total Tests In Each Country?--
select d.location,sum(total_cases)as"Total Cases",sum(total_tests)as"Total Tests",
(sum(total_cases)/sum(total_tests))*100 as"Cases Percentage Tests"
from CovidDeaths d join CovidVaccinations v
    on d.location=v.location and d.date=v.date
	where total_tests is not null
group by d.location 
order by "Total Tests"  desc


--What Is Relation Between GDP And Total Deaths?--
--And What Is The Total GDP In Each Country?--
select d.location,avg(gdp_per_person)as"Average GDP",sum(total_deaths)"Sum Of Deaths"
from CovidInformation i join CovidDeaths d
    on i.location=d.location and i.date=d.date
where d.location is not null and gdp_per_person is not null and total_deaths is not null
group by d.location
order by "Sum Of Deaths" desc



select d.location,avg(gdp_per_person)as"Average GDP",sum(total_deaths)"Sum Of Deaths"
from CovidInformation i join CovidDeaths d
    on i.location=d.location and i.date=d.date
where d.location is not null and gdp_per_person is not null and total_deaths is not null
group by d.location
order by "Average GDP" desc


--What Is Relation Between Srtingency Index And New Cases?--
select d.location,avg(srtingency_index)as"Average Srtingency",sum(new_cases)"Sum Of New Cases"
from CovidInformation i join CovidDeaths d
    on i.location=d.location and i.date=d.date
where srtingency_index is not null and new_cases is not null
group by d.location
order by "Average Srtingency" desc



--What Is Relation Between Different Diseases And Total Death?--
select d.location ,avg(i.diabetes_prevalence) a,avg(i.cardiovasc_death_rate)b ,sum(d.total_deaths)as"Sum Of Total Deaths"
from CovidInformation i join CovidDeaths d
    on d.location=i.location and i.date=d.date
where i.diabetes_prevalence is not null and i.cardiovasc_death_rate is not null and d.total_deaths is not null
group by d.location
order by "Sum Of Total Deaths" desc


/*What Is Relation Between Population And Total Cases And The Impact Of This 
On Total Tests And Total Vaccinations In Each Country?*/
select d.location,d.population,sum(d.total_cases)as"Total Cases",sum(v.total_tests)as"Total Tests",sum(v.total_vaccinations)as"Total Vaccinations"
from CovidVaccinations v join CovidDeaths d
   on d.location=v.location and d.date=v.date
group by d.location,d.population
order by d.population desc


--What Is The Relation Between Total Vaccinations And Total Deaths In Each Country?--
select d.location,sum(v.total_vaccinations)as"Total Vaccinations",sum(d.total_deaths)as"Total Deaths"
from CovidVaccinations v join CovidDeaths d
   on d.location=v.location and d.date=v.date
group by d.location
order by "Total Vaccinations" desc

--Query That Show Order Of Country By Total cases,deaths,vaccination--

WITH deaths_rank AS (
    select location, sum(total_deaths)as "Total Deaths", 
           RANK() OVER (order by sum(total_deaths) desc) as rank_deaths
     from CovidDeaths
     group by location
    
),
cases_rank AS (
    select location, sum(total_cases)as"Total Cases", 
           RANK() OVER (order by sum(total_cases) desc) as rank_cases
   from CovidDeaths
   group by location
),
vaccinations_rank AS (
    select location, sum(total_vaccinations)as"Total Vacccinations", 
           RANK() OVER (order by sum(total_vaccinations) desc) AS rank_vaccinations
    from CovidVaccinations
	group by location
)
select d.location,"Total Cases", c.rank_cases,"Total Deaths",d.rank_deaths,
      "Total Vacccinations", v.rank_vaccinations
from deaths_rank d JOIN cases_rank c 
   ON d.location = c.location
JOIN vaccinations_rank v
   ON d.location = v.location
where d.location = 'Egypt';
   --order by d.rank_deaths
   --group by d.location

