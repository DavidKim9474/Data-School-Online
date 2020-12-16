# 1. 멕시코(Mexico)보다 인구가 많은 나라이름과 인구수를 조회하시고 인구수 순으로 내림차순하세요.
SELECT country.Name, SUM(population) AS Population
FROM country
GROUP BY country.Name
HAVING Population > 
	(SELECT population
	FROM country
	WHERE country.name = "Mexico")
ORDER BY Population DESC;

# 2. 국가별 몇개의 도시가 있는지 조회하고 도시수 순으로 10위까지 내림차순하세요.
SELECT
	(SELECT country.Name
	FROM country
	WHERE city.CountryCode = country.Code) AS Name,
	COUNT(*) AS count
FROM city
GROUP BY city.CountryCode
ORDER BY COUNT DESC
LIMIT 10;

# 3. 언어별 사용인구를 출력하고 언어 사용인구 순으로 10위까지 내림차순하세요.
# 언어별 사용인구 계산 : 언어별 사용 나라의 인구 (from country) * 사용률
SELECT LANGUAGE, round(sum(country.population * percentage)/100) AS count
FROM countrylanguage
JOIN country
ON countrylanguage.CountryCode = country.Code
GROUP BY LANGUAGE
ORDER BY COUNT DESC
LIMIT 10;

# 4. 나라 전체 인구의 10%이상인 도시에서 도시인구가 500만이 넘는 도시를 아래와 같이 조회 하세요.
SELECT city.Name, city.CountryCode, country.name, round(city.population/country.population*100, 2) AS percentage
FROM
	(SELECT *
	FROM city
	WHERE population > 5000000) AS city
JOIN country
ON city.CountryCode = country.Code
HAVING percentage >= 10
ORDER BY percentage DESC;

# 5. 면적이 10000km^2 이상인 국가의 인구밀도(1km^2 당 인구수)를 구하고 인구밀도가 200이상인 국가들의 사용하고 있는 언어수가 5가지 이상인 나라를 조회 하세요. 
# population density
SELECT code, name, round(population/surfacearea) AS density
FROM country
WHERE surfacearea >= 10000
HAVING density >= 200
ORDER BY density DESC;

# population density >= 200
SELECT code, name, round(population/surfacearea) AS density
FROM country
WHERE surfacearea >= 10000
HAVING density >= 200
ORDER BY density DESC;

# language count >= 5
SELECT countrycode, COUNT(LANGUAGE) AS language_count
FROM countrylanguage
GROUP BY countrycode
HAVING language_count >= 5
ORDER BY language_count DESC;

# inner join
SELECT name, language_count
FROM
	(SELECT code, name, round(population/surfacearea) AS density
	FROM country
	WHERE surfacearea >= 10000
	HAVING density >= 200
	ORDER BY density DESC) AS country
JOIN
	(SELECT countrycode, COUNT(LANGUAGE) AS language_count
	FROM countrylanguage
	GROUP BY countrycode
	HAVING language_count >= 5
	ORDER BY language_count DESC) AS countrylanguage
ON country.code = countrylanguage.countrycode
ORDER BY language_count DESC;

# 6. 사용하는 언어가 3가지 이하인 국가중 도시인구가 300만 이상인 도시를 아래와 같이 조회하세요.
# * GROUP_CONCAT(LANGUAGE) 을 사용하면 group by 할때 문자열을 합쳐서 볼수 있습니다.
# * VIEW를 이용해서 query를 깔끔하게 수정하세요.

# 도시인구 300만 이상
CREATE VIEW large_city as
SELECT countrycode, NAME AS city_name, population
FROM city
WHERE population >= 3000000
ORDER BY population DESC;

# 사용 언어 3가지 이하
CREATE VIEW few_languages as
SELECT countrycode, COUNT(LANGUAGE) AS language_count, GROUP_CONCAT(LANGUAGE) AS languages
FROM countrylanguage
GROUP BY countrycode
HAVING language_count <= 3;

# inner join x2
SELECT large_city.countrycode, large_city.city_name, large_city.population, country.name, few_languages.language_count, few_languages.languages
FROM large_city
JOIN few_languages ON large_city.countrycode = few_languages.countrycode
JOIN country ON large_city.countrycode = country.Code
ORDER BY large_city.population DESC;