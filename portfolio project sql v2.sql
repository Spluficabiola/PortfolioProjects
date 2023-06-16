SELECT *
FROM portfolio_project.coviddeaths
WHERE continent is not null
order by 3,4

SELECT *
FROM portfolio_project.covidvaccinations
order by 3,4

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM portfolio_project.newcoviddeaths
order by 1,2

TOTAL CASES VS TOTAL DEATHS

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM portfolio_project.newcoviddeaths
order by 1,2
 
 Total Cases VS Population
 
 SELECT Location, date, population, total_cases, (total_cases/population)*100 AS populationcasespercentage
FROM portfolio_project.newcoviddeaths
WHERE location like '%kingdom%'
order by 1,2

Countries with Highhest Infection rate compared to Population

SELECT Location, population, MAX(total_cases) AS Highestinfectioncount, MAX((total_cases/population))*100 AS percentagepopulationinfected
FROM portfolio_project.newcoviddeaths
WHERE location like '%states%'
GROUP BY Location, Population
order by percentagepopulationinfected desc


Percentage of cases by population
SELECT Location, date, population, total_cases, (total_cases/population)*100 AS populationcasespercentage
FROM portfolio_project.newcoviddeaths
WHERE location like '%kingdom%'
order by 1,2

COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION

SELECT Location, MAX(total_deaths) AS totaldeathcount
FROM portfolio_project.newcoviddeaths
 WHERE Location like '%states%'
WHERE continent is not null
GROUP BY Location
order by totaldeathcount desc

 
CONTINENTS WITH HIGHEST DEATH COUNT BY POPULATION

SELECT Continent, MAX(total_deaths) AS totaldeathcount
FROM portfolio_project.newcoviddeaths
WHERE continent is null
GROUP BY Continent
order by totaldeathcount desc


GLOBAL NUMBERS
SELECT date, SUM(new_cases) as totalcases, SUM(new_deaths)as totaldeaths, SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage
FROM portfolio_project.newcoviddeaths
WHERE continent is not null
GROUP BY date
order by 1,2

SELECT SUM(new_cases) as totalcases, SUM(new_deaths)as totaldeaths, SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage
FROM portfolio_project.newcoviddeaths
WHERE continent is not null
GROUP BY date
order by 1,2

 SELECT *
 FROM portfolio_project.newcoviddeaths dea
JOIN portfolio_project.newcovidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date

 covidt  SELECT *
 FROM portfolio_project.newcoviddeaths dea
JOIN portfolio_project.newcovidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date

Looking at total population vs vaccinations

WITH PopvsVac(continent,location,date,population,new_vaccinations,rollingpeoplevaccinated) as
(SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as rollingpeoplevaccinated
 FROM portfolio_project.newcoviddeaths dea
JOIN portfolio_project.newcovidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
order by 2,3)

SELECT *,(rollingpeoplevaccinated/population)*100
FROM PopvsVac

TEMP TABLE
 
PercentPopulationVaccinated
DROP table if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(continent,
location,
date,
population,
rollingpeoplevaccinated)

INSERT into #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as rollingpeoplevaccinated
FROM portfolio_project.newcoviddeaths dea
JOIN portfolio_project.newcovidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
order by 2,3

SELECT *,(rollingpeoplevaccinated/population)*100
FROM  PercentPopulationVaccinated

CREATING VIEW TO STORE DATA FOR LATER VISUALISATION

Create View PercenpercenttpopulationvaccinatedtPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as rollingpeoplevaccinated
FROM portfolio_project.newcoviddeaths dea
JOIN portfolio_project.newcovidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
order by 2,3











total_deaths
SELECT *
FROM portfolio_project.newcovidvaccinations
order by 3,4