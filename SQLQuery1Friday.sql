SELECT *
FROM PortfolioPROJECT..CovidDeaths
ORDER BY 3,4 

SElECT *
FROM PortfolioProject..CovidVaccinations
ORDER BY 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Order By 1,2


Select Location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DealthPecentage
From PortfolioProject..CovidDeaths
Where Location like '%Zambia%' 
Order By 1,2 


Select Location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DealthPecentage
From PortfolioProject..CovidDeaths
Where Location like '%Zambia%' 
Order By 1,2 

Select Location, date, total_cases, total_cases, (total_cases/population) * 100 as DealthPecentage
From PortfolioProject..CovidDeaths
Where Location like '%Zambia%' 
Order By 1,2 


SELECT Location, Max(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
Where continent is  null
Group By Location
Order By TotalDeathCount desc

SELECT Continent, Max(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
Where continent is not null
Group By Continent
Order By TotalDeathCount desc


Select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,  sum (cast(new_deaths as int))/ sum(new_cases) * 100 as DeathPecentage
From PortfolioProject..CovidDeaths
Where continent is not null
Group By date
Order By 1,2 

Select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,  sum (cast(new_deaths as int))/ sum(new_cases) * 100 as DeathPecentage
From PortfolioProject..CovidDeaths
Where continent is not null
Order By 1,2 

SELECT *
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
    ON dea.Location = vac.date
    and dea.date = vac.location

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
ON dea.Location = vac.date
and dea.date = vac.location
Where dea.continent is not null
order By 2,3
--LOOKING @TOTAL POPULATION vs VACCINations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, Sum(cast(vac.new_vaccinations as Int)) Over (Partition By dea.location Order by dea.location,dea.date ) 
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
ON dea.Location = vac.date
and dea.date = vac.location
Where dea.continent is not null
order By 2,3

CREATE TABLE #PercentPoplutionVaccinated
(
Continent nvarchar(255),
Location nvarchar (255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPoplutionVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, Sum(CONVERT(Int, vac.new_vaccinations)) Over (Partition By dea.location Order by dea.location,dea.date ) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
ON dea.Location = vac.date
and dea.date = vac.location
Where dea.continent is not null

Create view PercentPoplutionVaccinated As
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, Sum(CONVERT(Int, vac.new_vaccinations)) Over (Partition By dea.location Order by dea.location,dea.date ) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
ON dea.Location = vac.date
and dea.date = vac.location
Where dea.continent is not null

SELECT*
From PercentPoplutionVaccinated


