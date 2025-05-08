CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);

INSERT INTO Shipments (N, Num) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1),
(9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 4), (15, 4), 
(16, 4), (17, 4), (18, 4), (19, 4), (20, 4), (21, 4), (22, 4), 
(23, 4), (24, 4), (25, 4), (26, 5), (27, 5), (28, 5), (29, 5), 
(30, 5), (31, 5), (32, 6), (33, 7);
-- solution
;with cte as ( 
	select * from Shipments
	union all
	select 34, 0
	union all
	select 35, 0
	union all
	select 36, 0
	union all
	select 37, 0
	union all
	select 38, 0
	union all
	select 39, 0
	union all
	select 40, 0
), row_gen as (select *,  ROW_NUMBER() over(order by Num) as number from cte

), median_cte as (select avg(Num) as median from row_gen where number in (20,21)
) select * from median_cte


