--select * 
--from covid_19

--looking at total cases vs death

--select continent,country,MAX(Cases) as CASES,MAX(Deaths) as DEATHS
--from covid_19
--where country not IN ('All','Europe','North-America','Asia','South-America')
--group by country,continent
--order by DEATHS DESC;

--Death percentage according when looking at Cases

--SELECT continent,country,MAX(Cases) as CASES,MAX(Deaths) as DEATHS,(Deaths/Cases)*100 AS DEATH_PERCENTAGE
--from covid_19
--where country not IN ('All','Europe','North-America','Asia','South-America')
--group by country,continent,Cases,Deaths
--order by DEATHS DESC;

DROP TABLE IF EXISTS CovidData --This will prevent error without commenting out creat table statement
Create table CovidData
(continent varchar(50),
country varchar(50),
Cases int,
Deaths int,
Death_percentage decimal)

insert into CovidData
SELECT continent,country,MAX(Cases) as CASES,MAX(Deaths) as DEATHS,(Deaths/Cases)*100 AS DEATH_PERCENTAGE
from [covid_data].[dbo].[covid_19]
where country not IN ('All','Europe','North-America','Asia','South-America')
group by country,continent,Cases,Deaths
order by DEATHS DESC;

-- TOP 5 countries with highest deaths,cases and death_percentage

--select top 5 continent,country,Cases,Deaths,Death_percentage 
--from CovidData
--where continent is not null AND
--country  is not null AND
--Cases is not null AND
--Deaths is not null AND
--Death_percentage is not null 
--group by continent,country,Cases,Deaths,Death_percentage
--order by Deaths desc;

--Syntax for looking at a specific country

--select *
--from CovidData
--where country like '%INDIA%'

--Countries with highest infection rate as compared to Population (CTE)
--with inf_per (continent,country,population,Infection_rate,Infection_percent)
--as
--(
--select continent,country,population,MAX(Cases) AS Infection_rate,(Cases/population)*100 AS Infection_percent 
--from [covid_data].[dbo].covid_19
--Where continent is not null AND
--country is not null AND
--population is not null AND
--Cases is not null AND
--(Cases/population)*100 is not null 
--group by continent,country,population,Cases)

--select *
--from inf_per

--Showing total death count as per country

--select country,Max(Deaths) as Death_count
--from Covid_19
--where country not IN ('All','Europe','North-America','Asia','South-America')
--group by country
--order by MAX(Deaths) desc;

--Showing total death count as per continent
--select continent,Max(Deaths) as Death_count
--from covid_19
--where country not in ('ALL')
--group by continent
--order by MAX(Deaths) desc;

--showing cases and deaths on dates
--select country,day,Cases,Deaths
--from covid_19

--Global numbers(total death percentage on specific date in the world with death by case)
--select date,SUM(total_cases) as totalcases,SUM(cast(total_deaths as int)) as totaldeaths,SUM(cast(total_deaths as int))/SUM(total_cases)*100 as GLOBALDEATHPERCENTAGE
--from [Covid_data1].[dbo].[CovidDeaths$]
--group by date
--order by GLOBALDEATHPERCENTAGE

--Checking percentage on a specific date
--select date,SUM(total_cases) as totalcases,SUM(cast(total_deaths as int)) as totaldeaths,SUM(cast(total_deaths as int))/SUM(total_cases)*100 as GLOBALDEATHPERCENTAGE
--from [Covid_data1].[dbo].[CovidDeaths$]
--where date = '2020-12-25'
--group by date
--order by GLOBALDEATHPERCENTAGE;

--LOOKING AT TOTAL population vs TOTAL Vaccinated (CTE)
--with popvsvac (continent,location,date,population,total_vaccinations)
--as
--(
--select continent,location,date,population,total_vaccinations
--from [Covid_data1].[dbo].[CovidDeaths$]
--where total_vaccinations is not null)
----Accessing cte
--select *,(total_vaccinations/population)*100 as vaccination_percentage
--from popvsvac

--Creating view for visualization
--CREATE VIEW  
--GLOBALDEATHPERC as 
--select date,SUM(total_cases) as totalcases,SUM(cast(total_deaths as int)) as totaldeaths,SUM(cast(total_deaths as int))/SUM(total_cases)*100 as GLOBALDEATHPERCENTAGE
--from [Covid_data1].[dbo].[CovidDeaths$]
--group by date;

select *
from [Covid_data].[dbo].[covid_19]



