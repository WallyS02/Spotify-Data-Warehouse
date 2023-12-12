USE SpotifyDW;

DECLARE @Hour INT = 0;
DECLARE @Minute INT = 0;
DECLARE @Second INT = 0;

WHILE @Hour < 24
BEGIN
    WHILE @Minute < 60
    BEGIN
        WHILE @Second < 60
        BEGIN
            INSERT INTO Time (Hour, Minute, Second)
            VALUES (@Hour, @Minute, @Second);
            SET @Second = @Second + 1;
        END
        SET @Minute = @Minute + 1;
        SET @Second = 0;
    END
    SET @Hour = @Hour + 1;
    SET @Minute = 0;
END
