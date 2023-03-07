USE smart_factory;

SELECT * FROM user;

-- 모든 회원 목록을 가져오는데 birthday컬럼 값을 기준으로 오름차순으로 정렬하여 가져오기
SELECT * FROM user ORDER BY birthday ASC;

-- 회원 목록중 gender컬럼의 값이 'M'인 회원목록을 가져오는데 이때 name 컬럼 기준으로 내림차순 
SELECT * FROM user 
WHERE gender='M'
ORDER BY name DESC;

-- 1990년대에 태어난 회원의 id, name 컬럼을 가져와 목록으로 보여주시오
SELECT Id, Name FROM user WHERE birthday LIKE '199%'; 

-- 6월생 회원의 목록을 birthday기준으로 오름차순 정렬하여 가지고 오시오 
SELECT * FROM user WHERE birthday LIKE '_____06%' ORDER BY birthday ;

-- gender 컬럼의 값이 'M'이고 1970년대에 태어난 회원의 목록을 가져오세요
SELECT * FROM user WHERE gender = 'M' and birthday LIKE '197%';
-- 모든 회원의 목록중 age를 기준으로 내림차순하여 정렬하여 가져오는데 그때 처음 3개의 레코드만 가져오세요
SELECT * FROM user ORDER BY age DESC LIMIT 3;
-- 모든 회원 목록 중 나이가 25이상 50이하인 회원의 목록을 출력하세요->
SELECT * FROM user WHERE age>=25 and age<=50;