# 소수점 올림, 반올림, 버림 함수
SELECT ceil(12.345);
SELECT ROUND(12.345, 2);
SELECT TRUNCATE(12.345, 2);

# example
SELECT CODE, round(gnp / population * 1000, 2)
FROM country;

# 조건문

# IF : IF(조건, 참, 거짓)
# 도시의 인구가 100만 이상 big city, 100만 미만 small city 출력
# column : city_scale
SELECT NAME, population
, if(population >= 1000000, "big city", "small city") AS city_scale
FROM city;

# IFNULL : IFNULL(참, 거짓)
# country 테이블에서 독립년도(IndepYear)가 없으면 0으로 출력
SELECT NAME, ifnull(IndepYear, 0) AS IndepYear
FROM country;

# CASE
# CASE
# 		WHEN(조건1) THEN(출력1)
# 		WHEN(조건2) THEN(출력2)
# END AS (컬럼명)

# 나라별 10억 이상, 1억 이상, 1억 이하 조건을 출력
SELECT name, population,
case
	when population > 1000000000 then "upper 1 billion"
	when population > 100000000 then "upper 100 million"
	ELSE "below 100 million"
END AS result
FROM country
ORDER BY population DESC;

# DATE_FORMAT : 날짜 데이터의 포맷을 변경해주는 함수
# sakila
USE sakila;

# payment에서 월별 총 매출 출력
SELECT date_format(payment_date, "%W") AS daily
, count(amount), SUM(amount), AVG(amount)
FROM payment
GROUP BY daily;

# JOIN : merge()와 비슷
USE world;

# create table and data
CREATE TABLE user(
	user_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(30) DEFAULT NULL,
	PRIMARY KEY (user_id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

CREATE TABLE addr(
	id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	addr VARCHAR(30) DEFAULT NULL,
	user_id INT(11) DEFAULT NULL,
	PRIMARY KEY (id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

INSERT INTO user(NAME)
VALUES("jin"),
("po"),
("alice"),
("petter");

INSERT INTO addr(addr, user_id)
VALUES("seoul",1),
("pusan",2),
("daejeon",3),
("daegu",5),
("seoul",6);

# inner join
SELECT addr.addr, addr.user_id, user.name
FROM addr
JOIN user
ON addr.user_id=user.user_id;

# world 도시이름, 국가이름 출력
SELECT city.Countrycode, city.Name, country.name
FROM city
JOIN country
ON city.CountryCode = country.Code;

# left join
SELECT id, addr.addr, addr.user_id, ifnull(user.name, "-")
FROM addr
left JOIN user
ON addr.user_id=user.user_id;

# right join
SELECT id, addr.addr, user.user_id, user.name
FROM addr
RIGHT JOIN user
ON addr.user_id=user.user_id;

# union : select 문의 결과를 합쳐서 출력
# 자동으로 중복을 제거 (중복 제거 후 column의 갯수가 맞아야 함)
SELECT name
FROM user
UNION
SELECT addr
FROM addr;

# union all : 중복 제거 X
SELECT name
FROM user
UNION ALL
SELECT addr
FROM addr;

# outer join : (left join) union (right join)
SELECT user.name, addr.addr, addr.user_id
FROM user
LEFT JOIN addr
ON user.user_id = addr.user_id
UNION 
SELECT user.name, addr.addr, addr.user_id
FROM user
RIGHT JOIN addr
ON user.user_id = addr.user_id;

# sub-query : 쿼리문 안에 쿼리가 있는 문법
# select, from, where 등에서 사용 가능

# 전체 나라 수, 전체 도시 수, 전체 언어 수를 출력
SELECT
(SELECT COUNT(*)
FROM country) AS total_country,

(SELECT COUNT(*)
FROM city) AS total_city,

(SELECT COUNT(DISTINCT(LANGUAGE))
FROM countrylanguage) AS total_language;

# 800만 이상이 되는 도시의 국가코드, 도시이름, 국가이름, 도시인구 수를 출력
SELECT *
FROM
	(SELECT countrycode, NAME, population
	FROM city
	WHERE population >= 8000000) AS city
JOIN
	(SELECT CODE, NAME
	FROM country) AS country
ON city.countrycode = country.code;

# 800만 이상 도시의 국가코드, 국가이름, 대통령 이름 출력
SELECT CODE, NAME, HeadOfState
FROM country
WHERE CODE IN(
	SELECT distinct(countrycode)
	FROM city
	WHERE population >= 8000000);
	
# index : 데이터를 검색할 때 빠르게 찾을 수 있도록 해주는 기능
USE employees;

EXPLAIN 
SELECT COUNT(*)
FROM salaries
WHERE to_date > "2000-01-01";

CREATE INDEX tdate
ON salaries (to_date)

DROP INDEX tdate
ON salaries;

# View : 특정 쿼리에 대한 결과를 저장하는 개념
USE world;

CREATE VIEW code_name AS
SELECT CODE, NAME
FROM country;

SELECT *
FROM city
JOIN code_name
# (select code, name
# from country) as code_name
ON city.CountryCode = code_name.CODE;