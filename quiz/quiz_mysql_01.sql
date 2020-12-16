# 1. country 테이블에서 중복을 제거한 Continent를 조회하세요.
SELECT DISTINCT(Continent)
FROM country;

# 2. 한국 도시중에 인구가 100만이 넘는 도시를 조회하여 인구순으로 내림차순하세요.
SELECT NAME, Population
FROM city
WHERE (CountryCode = "KOR") AND (Population > 1000000)
ORDER BY Population DESC;

# 3. city 테이블에서 population이 800만 ~ 1000만 사이인 도시 데이터를 인구수순으로 내림차순하세요.
SELECT NAME, CountryCode, Population
FROM city
WHERE population BETWEEN 8000000 AND 10000000
ORDER BY population DESC;

# 4. country 테이블에서 1940 ~ 1950년도 사이에 독립한 국가들을 조회하고 독립한 년도 순으로 오름차순하세요.
SELECT CODE, concat(NAME, "(", IndepYear, ")") AS "NameIndep", Continent, Population
FROM country
WHERE IndepYear BETWEEN 1940 AND 1949
ORDER BY IndepYear ASC;

# 5. contrylanguage 테이블에서 스페인어, 한국어, 영어를 95% 이상 사용하는 국가 코드를 Percentage로 내림차순하여 아래와 같이 조회하세요. 
SELECT CountryCode, LANGUAGE, Percentage
FROM countrylanguage
WHERE Language IN ("Spanish", "Korean", "English") and Percentage >= 95
ORDER BY Percentage DESC;

# 6. country 테이블에서 Code가 A로 시작하고 GovernmentForm에  Republic이 포함되는 데이터를 아래와 같이 조회하세요.
SELECT Code, NAME, Continent, GovernmentForm, Population
FROM country
WHERE CODE LIKE "A%" AND GovernmentForm LIKE "%Republic%";

-------------------------------------------------------------------------------------------------------------
# city 테이블에서 나라별 도시의 갯수를 출력
SELECT CountryCode, COUNT(CountryCode) AS "Count"
FROM city
GROUP BY CountryCode;

# countrylanguage 테이블에서 전체 언어의 갯수를 출력
SELECT count(distinct(LANGUAGE))
FROM countrylanguage;

# 대륙별 인구수와 GNP의 최대값을 출력
SELECT Continent, sum(Population), sum(GNP), SUM(GNP)/SUM(population)
FROM country
GROUP BY Continent;

# 대륙별 전체인구를 구하고 5억 이상인 대륙만 출력
# Having : group by가 실행되고 난 결과에 조건을 추가
SELECT Continent, sum(Population)
FROM country
# WHERE comes before GROUP BY
GROUP BY Continent
# HAVING comes after GROUP BY
having sum(Population) > 500000000;