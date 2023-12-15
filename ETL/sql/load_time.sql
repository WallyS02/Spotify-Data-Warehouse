USE SpotifyDW;

DECLARE @Hour INT = 0;
DECLARE @Minute INT = 0;
DECLARE @Second INT = 0;

CREATE TABLE #NewTime (
    Hour INT,
    Minute INT,
    Second INT
);

WHILE @Hour < 24
BEGIN
    SET @Minute = 0;
    WHILE @Minute < 60
    BEGIN
        SET @Second = 0;
        WHILE @Second < 60
        BEGIN
            INSERT INTO #NewTime (Hour, Minute, Second)
            VALUES (@Hour, @Minute, @Second);

            SET @Second = @Second + 1;
        END
        SET @Minute = @Minute + 1;
    END
    SET @Hour = @Hour + 1;
END

MERGE INTO Time AS Target
USING #NewTime AS Source
ON Target.Hour = Source.Hour AND Target.Minute = Source.Minute AND Target.Second = Source.Second
WHEN NOT MATCHED THEN
    INSERT (Hour, Minute, Second)
    VALUES (Source.Hour, Source.Minute, Source.Second);

DROP TABLE #NewTime;
