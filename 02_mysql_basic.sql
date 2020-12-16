# Server - Database - Table

# 1. Create (생성)
# 1-1. 데이터 베이스
SHOW DATABASES; # 현재 데이터 베이스 확인

# 생성
CREATE DATABASE test;

# 선택
USE test;

# 현재 데이터 베이스 확인
SELECT DATABASE();

# 1-2. Table
CREATE TABLE user1(
	user_id INT, 
	name VARCHAR(20),
	email VARCHAR(30),
	age INT(3),
	rdate DATE
)

CREATE TABLE user2(
	user_id INT PRIMARY KEY AUTO_INCREMENT, 
	name VARCHAR(20) NOT NULL,
	email VARCHAR(30) UNIQUE NOT NULL,
	age INT(3) DEFAULT 30,
	rdate TIMESTAMP
)


# 2. Alter (수정)
# 2-1. 데이터 베이스
SHOW VARIABLES LIKE "character_set_database";
ALTER DATABASE test CHARACTER SET = UTF8;

# 2-2. 테이블
ALTER TABLE user2 ADD tmp TEXT;
ALTER TABLE user2 MODIFY COLUMN tmp INT(3);
ALTER TABLE user2 DROP tmp;


# 3. Drop (삭제)
# 3-1. 데이터 베이스
CREATE DATABASE tmp;
DROP DATABASE tmp;
SHOW DATABASES;

# 3-2. 테이블
CREATE TABLE user3(
	user_id INT PRIMARY KEY AUTO_INCREMENT
);
DROP TABLE user3;


# 4. Insert (삽입)
INSERT INTO user1(user_id, name, email, age, rdate)
VALUE(2, "jin", "jin@gmail.com", 32, CURDATE()),
(3, "peter", "jin@gmail.com", 33, CURDATE()),
(4, "po", "jin@gmail.com", 23, CURDATE()),
(5, "andy", "jin@gmail.com", 43, CURDATE()),
(6, "jin", "jin@gmail.com", 17, CURDATE());


# 5. Select : 데이터 조회(선택)
SELECT user_id, name, age
FROM user1

SELECT *
FROM user1

SELECT user_id AS "아이디", NAME AS "이름", age AS "나이"
FROM user1


# Distinct : 중복 제거
SELECT distinct(NAME)
FROM user1;


# Where : 조건 검색
# 30세 이상인 사용자를 검색해서 이름의 종류갯수를 출력
SELECT count(distinct(NAME))
FROM user1
WHERE age >= 30;

SELECT *
FROM user1
WHERE age >= 20 and age < 40;


# Between A and B : 범위 선택
SELECT *
FROM user1
WHERE age between 20 AND 39;


# Order by : 정렬
SELECT *
FROM user1
ORDER BY NAME, age DESC;


# 나이가 20세에서 40세 사이에 있는 사용자를 이름순으로 정렬하고 중복데이터를 제거해서 출력
SELECT distinct(NAME)
FROM user1
WHERE age BETWEEN 20 AND 39
ORDER BY NAME;


# concat
SELECT NAME, age, CONCAT(NAME, "(", age, ")") AS "name_age"
FROM user1;


# like : where 절에서 특정 문자열이 들어간 데이터 조회
SELECT *
FROM user1
-- WHERE email LIKE "%@gmail.%"
WHERE email not LIKE "%net";


# in : 여러 개의 조건을 조회할 때 사용
SELECT *
FROM user1
# %/ WHERE NAME="andy" or NAME="peter" or NAME="po" /%   실제로는 문자열을 거의 안씀
# subquery
WHERE NAME IN (
	SELECT distinct(NAME)
	FROM user1
	WHERE age > 30
);


# limit
SELECT *
FROM user1
LIMIT 3;      # 상위 3개 출력

SELECT *
FROM user1
LIMIT 3, 5;   # 세번째부터 밑으로 5개 출력


# 6. Update
UPDATE user1
SET age=20, rdate="2019-12-12"
WHERE age BETWEEN 20 AND 29;

SELECT *
FROM user1
WHERE age BETWEEN 20 AND 29;


# 7. Delete
DELETE FROM user1
WHERE rdate < "2020-01-01";

SELECT *
FROM user1;

-------------------------------------------------------------------------------------------------------------
# summary
# select
SELECT CountryCode AS Code, NAME, Population, CONCAT(NAME, "(", population, ")") AS city_population
FROM city
WHERE population BETWEEN 5000000 AND 8000000
# AND CountryCode LIKE "%R%"
# AND (CountryCode = "BRA" OR CountryCode = "GBR")    # () 여부에 따라 우선 연산 순위가 변경됨
# AND CountryCode IN ("BRA", "GBR")
ORDER BY CountryCode asc, Population DESC
LIMIT 5, 3;

# group by
SELECT CountryCode, COUNT(CountryCode), avg(population) AS avg_population
FROM city
WHERE population >= 5000000
GROUP BY CountryCode
HAVING avg_population > 8000000;