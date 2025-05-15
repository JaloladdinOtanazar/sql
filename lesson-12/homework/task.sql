--1st task

DECLARE @SQL NVARCHAR(MAX) = '';

SELECT @SQL = @SQL + '
SELECT 
    DB_NAME() AS DatabaseName,
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    TYPE_NAME(c.user_type_id) AS DataType
FROM ' + QUOTENAME(name) + '.sys.tables t
INNER JOIN ' + QUOTENAME(name) + '.sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN ' + QUOTENAME(name) + '.sys.columns c ON t.object_id = c.object_id
UNION ALL'
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
AND state = 0; -- Online databases only

-- Remove the last 'UNION ALL'
SET @SQL = LEFT(@SQL, LEN(@SQL) - 10);

-- Execute the dynamic SQL
EXEC sp_executesql @SQL;

--2nd task


CREATE PROCEDURE usp_GetProcedureAndFunctionDetails
    @DatabaseName NVARCHAR(128) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQL NVARCHAR(MAX) = '';
    DECLARE @TempTable TABLE (
        DatabaseName NVARCHAR(128),
        SchemaName NVARCHAR(128),
        ObjectName NVARCHAR(128),
        ObjectType NVARCHAR(60),
        ParameterName NVARCHAR(128),
        DataType NVARCHAR(128),
        MaxLength INT
    );

    -- If specific database is provided, query only that database
    IF @DatabaseName IS NOT NULL
    BEGIN
        SET @SQL = '
        USE ' + QUOTENAME(@DatabaseName) + ';
        INSERT INTO @TempTable
        SELECT 
            DB_NAME() AS DatabaseName,
            s.name AS SchemaName,
            o.name AS ObjectName,
            o.type_desc AS ObjectType,
            p.name AS ParameterName,
            TYPE_NAME(p.user_type_id) AS DataType,
            p.max_length AS MaxLength
        FROM sys.objects o
        INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
        LEFT JOIN sys.parameters p ON o.object_id = p.object_id
        WHERE o.type IN (''P'', ''FN'', ''IF'', ''TF'') -- Stored Procedures, Scalar Functions, Inline Table-Valued Functions, Table-Valued Functions
        AND o.is_ms_shipped = 0; -- Exclude system objects';
    END
    ELSE
    -- Otherwise, query all user databases
    BEGIN
        SELECT @SQL = @SQL + '
        USE ' + QUOTENAME(name) + ';
        INSERT INTO @TempTable
        SELECT 
            DB_NAME() AS DatabaseName,
            s.name AS SchemaName,
            o.name AS ObjectName,
            o.type_desc AS ObjectType,
            p.name AS ParameterName,
            TYPE_NAME(p.user_type_id) AS DataType,
            p.max_length AS MaxLength
        FROM sys.objects o
        INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
        LEFT JOIN sys.parameters p ON o.object_id = p.object_id
        WHERE o.type IN (''P'', ''FN'', ''IF'', ''TF'')
        AND o.is_ms_shipped = 0
        UNION ALL'
        FROM sys.databases
        WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
        AND state = 0; -- Online databases only

        -- Remove the last 'UNION ALL'
        SET @SQL = LEFT(@SQL, LEN(@SQL) - 10);
    END

    -- Execute the dynamic SQL
    INSERT INTO @TempTable
    EXEC sp_executesql @SQL;

    -- Return the results
    SELECT 
        DatabaseName,
        SchemaName,
        ObjectName,
        ObjectType,
        ParameterName,
        DataType,
        MaxLength
    FROM @TempTable
    ORDER BY DatabaseName, SchemaName, ObjectName, ParameterName;
END;