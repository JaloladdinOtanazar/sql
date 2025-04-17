-- TASK 1
CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);
select * from [TestMultipleZero]
where (A != 0) OR (B!=0) OR (C!=0) OR (D != 0)

-- TASK 2
CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
GO
 
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

--1ST WAY
SELECT Year1,
Max_v = MAX(val)
FROM TestMax
CROSS APPLY (
VALUES (Max1), (Max2), (Max3)
) AS v(val)
GROUP BY Year1
--2ND WAY
SELECT Year1, 
    (SELECT MAX(MaxValue)
	FROM (SELECT Max1 AS MaxValue
	UNION ALL 
	SELECT Max2
	UNION ALL
	SELECT Max3) AS Value) AS MaxValue
FROM TestMax;

-- TASK 3
CREATE TABLE EmpBirth
(
    EmpId INT  IDENTITY(1,1) 
    ,EmpName VARCHAR(50) 
    ,BirthDate DATETIME 
);
 
INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983';

SELECT EmpName, BirthDate
FROM EmpBirth
WHERE month(BirthDate) = 05 AND day(BirthDate) BETWEEN 07 AND 15
ORDER BY EmpName
-- TASK 4

create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');
-- FIRST
SELECT letter FROM letters

ORDER  BY 
	CASE 
		WHEN letter = 'b' THEN 0 
		ELSE 1
	END,
	letter;
--LAST
SELECT letter FROM letters
SELECT letter FROM letters

ORDER  BY 
	CASE 
		WHEN letter = 'b' THEN 1 
		ELSE 0
	END,
	letter;






