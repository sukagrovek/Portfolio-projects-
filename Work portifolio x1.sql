select *
from covid..CovidDeaths
order by location desc
 

 select location, date, total_cases, new_cases,total_deaths,Population
 from covid..CovidDeaths
 order by total_cases desc

 select continent, population, ((new_cases/population)*100) as percentagenewcasespopulation, date
 from covid..coviddeaths
 where continent is not null
 order by percentagenewcasespopulation desc



 
 select continent, population,(new_cases/population)*100 as percentagenewcasespopulation, date
 from covid..coviddeaths
 --where continent  like 'europe%'
 order by percentagenewcasespopulation desc


 select continent,population, cast (total_deaths as int ) as TC 
 from covid..CovidDeaths

 --BREAK DOWN BY CONTINENT
 select continent, max(cast(total_deaths as int)) as TotalDeathCount
 from covid..CovidDeaths
 where continent is  not null
 group by continent 
 order by TotalDeathCount desc

 select continent, avg(cast(total_deaths as int)) as avg_value
 from covid..CovidDeaths
 where continent is not null
 group by continent
 order by avg_value desc

 select location, avg(cast(total_deaths as int)),max(cast(total_deaths as int)),min(cast(total_deaths as int)),count(cast(total_deaths as int))
 from covid..CovidDeaths
 group by location
 
 
select location, avg(population) as avg_population
from covid..CovidDeaths
where continent is null
group by location

--Global Numbers
select date, max(new_cases) as new_cases_global, sum(cast(new_deaths as int)) as new_deaths 
from covid..CovidDeaths
where continent is not null
group by date
order by 2,3 desc


select* from covid..CovidDeaths where new_cases= null


 select date, max(new_cases) as new_cases_global, sum(cast(new_deaths as int)) as new_deaths, 
 sum(cast(new_cases as int))/sum(cast(new_deaths as int))*100 as percenatgenewcases 
from covid..CovidDeaths
where continent is not null
group by date
order by 2,3 desc


select *
from covid..Coviddeaths dea
join covid..covidvaccinations vac
on vac.location=dea.location
and vac.date=dea.date

--TOTAL POPULATION VS VACCINATION
create view  My_perception as
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) OVER (partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated 
from covid..Coviddeaths dea
join covid..covidvaccinations vac
on vac.location=dea.location
and vac.date=dea.date
where dea.continent is not null
--order by 1,2,3 desc