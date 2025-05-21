DECLARE @Year INT = 2025;
DECLARE @Month INT = 5;

-- Calculate the first day of the month and its weekday
DECLARE @StartDate DATE = DATEFROMPARTS(@Year, @Month, 1);
DECLARE @FirstWeekday INT = DATEPART(WEEKDAY, @StartDate); -- 1=Sunday, 7=Saturday
DECLARE @DaysInMonth INT = DAY(EOMONTH(@StartDate));

-- Adjust weekday to make Sunday=0, Monday=1, ..., Saturday=6
SET @FirstWeekday = (@FirstWeekday + 6) % 7;

-- Generate a table of days (1 to DaysInMonth)
WITH Days AS (
    SELECT n = ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) a(n)
    CROSS JOIN (VALUES (0),(1),(2),(3),(4)) b(n)
    WHERE n < @DaysInMonth
),
-- Calculate week and weekday for each day
DayAssignments AS (
    SELECT 
        n,
        WeekNum = (@FirstWeekday + n - 1) / 7 + 1,
        WeekDay = (@FirstWeekday + n - 1) % 7
    FROM Days
)
-- Pivot the days into columns for each weekday
SELECT 
    WeekNum AS Week,
    [Sunday],
    [Monday],
    [Tuesday],
    [Wednesday],
    [Thursday],
    [Friday],
    [Saturday]
FROM (
    SELECT 
        WeekNum,
        CASE WeekDay
            WHEN 0 THEN 'Sunday'
            WHEN 1 THEN 'Monday'
            WHEN 2 THEN 'Tuesday'
            WHEN 3 THEN 'Wednesday'
            WHEN 4 THEN 'Thursday'
            WHEN 5 THEN 'Friday'
            WHEN 6 THEN 'Saturday'
        END AS DayName,
        n AS DayNumber
    FROM DayAssignments
) AS SourceTable
PIVOT (
    MAX(DayNumber)
    FOR DayName IN (Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday)
) AS PivotTable
ORDER BY Week;