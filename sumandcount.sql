----#Total world population
----# 1. Show the total population of the world.

SELECT SUM(population)
FROM world;

-----#List of continents
-----# 2. List all the continents - just once each.
select distinct continent from world;

----#GDP of Africa
----#3.Give the total GDP of Africa
select sum(gdp) from world where continent='Africa'

-----#Count the big countries
-----#4.How many countries have an area of at least 1000000
select count(name) from world where area>=1000000

-----#Baltic states population
-----#5.What is the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT sum(population) from world where name IN('Estonia', 'Latvia', 'Lithuania')

-----#Counting the countries of each continent
-----#6.For each continent show the continent and number of countries.
select distinct continent, count(name) from world  group by continent

----#Counting big countries in each continent
----#7.For each continent show the continent and number of countries with populations of at least 10 million.
select distinct continent,count(name) from world where population>=10000000 group by continent


----#Counting big continents
----#8.List the continents that have a total population of at least 100 million.
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;
