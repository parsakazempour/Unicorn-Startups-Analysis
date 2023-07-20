-- Years with more Births of Startups --
select founded,count(distinct(company)) as 'Number of fouded Startups'
from dbo.Unicorn_companies
where founded is not null
group by founded
order by count(distinct(company))  desc


-- World Biggest Unicorns based on valuation --
select top (20) company,valuation
from dbo.Unicorn_companies
order by valuation desc


-- Countries with more Unicorn Companies --
select country,count(distinct(company)) as total_unicorn_numbers
from dbo.Unicorn_companies
group by country
order by total_unicorn_numbers desc

--  industries with more numbers of unicorn Companies --
select count(distinct(company)) as total_unicorn_numbers,industry
from dbo.Unicorn_companies
group by industry
order by total_unicorn_numbers desc


--  Total Number of Startups became Unicorn Each Year --
select count(Company) as unicorn_nums,year(joined) as joined_year
from dbo.Unicorn_companies
group by year(joined)
order by year(joined) desc,count(Company)desc


--  Top 10 Capital Increases --
select top(20)total_raised ,Company,industry,country
from dbo.Unicorn_companies
where total_raised <> 'None'
order by total_raised desc


----  In which industry it took shorter for startups to become unicorn? --
select Industry,round(avg(year(joined)-(founded)),1) as From_Zero_to_Hero_Years
from dbo.Unicorn_companies
group by industry
having avg(year(joined)-(founded))  is not null
order by avg(year(joined)-(founded)) ASC



-- Countries total unicorn numbers VS university ranking --
select top 10(u.country),count(distinct(u.Company)) as total_unicorns, round(avg(r.rank),0) as 'average university ranking'
from  dbo.Unicorn_Companies u
join dbo.ranking r
on u.country=r.country
group by u.country
order by total_unicorns desc


-- top Countries By unicorn numbers VS internet_penetration_rate --
select round(avg(o.internet_users_percentage),2) as 'internet_penetration_rate(%)'
from
(
select top(20)u.country as top_countries,count(distinct(U.company)) as total_unicorn_numbers,i.internet_users_percentage
from dbo.Unicorn_companies U
join dbo.internet_users  i
on u.country=i.country
group by u.country,i.internet_users_percentage
order by i.internet_users_percentage desc) o


-- Countries unicorn numbers VS Private_Equity_attractiveness --
select count(a.ranking)*100/20 as 'percentage of top 20 countries with more unicorns with PEA <20'
from
(
select top(20)u.country,count(distinct(U.company)) as total_unicorn_numbers,P.Rank as ranking
from dbo.Unicorn_companies U
join Private_Equity_attractiveness  P
on u.country=p.country
group by u.country,p.rank
having p.rank<=20
order by total_unicorn_numbers desc) a


-- Countries total unicorn numbers VS GDP_Rank --
select avg(b.GDP_rank) as 'average GDP  ranking of TOP 20 countries'
from
(select top(20)u.country,count(distinct(U.company)) as total_unicorn_numbers,
(RANK()OVER (ORDER BY GDP DESC ) )as GDP_Rank
from dbo.Unicorn_companies U
join dbo.GDP  G
on u.country=g.country
group by u.country,G.GDP
order by total_unicorn_numbers desc) b







    
