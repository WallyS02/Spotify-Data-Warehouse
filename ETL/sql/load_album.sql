USE SpotifyDW;

DECLARE @ID INT, @Title CHAR(30), @Length TIME(0), @Release_date DATE, @ID_a INT;

CLOSE album_cursor;
DEALLOCATE album_cursor;

DECLARE album_cursor CURSOR FOR
SELECT
    ID,
    TITLE,
    LENGTH,
    RELEASE_DATE,
    ID_A
FROM
    Spotify.dbo.ALBUM ORDER BY ID;

OPEN album_cursor;
FETCH NEXT FROM album_cursor INTO @ID, @Title, @Length, @Release_date, @ID_a;

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @SecondsLength INT = DATEDIFF(SECOND, CAST('00:00:00' AS TIME), @Length)
    DECLARE @ArtistId INT
    SELECT @ArtistId = ID FROM Artist WHERE PseudonymID = @ID_a AND UpToDate = 1
    IF NOT EXISTS (
        SELECT 1
        FROM Album
        WHERE Title = @Title
        AND DurationCategory =
            CASE
                WHEN @SecondsLength BETWEEN 0 AND 60 THEN '0-60'
                WHEN @SecondsLength BETWEEN 60 AND 120 THEN '60-120'
                WHEN @SecondsLength BETWEEN 120 AND 180 THEN '120-180'
                WHEN @SecondsLength BETWEEN 180 AND 240 THEN '180-240'
                WHEN @SecondsLength BETWEEN 240 AND 300 THEN '240-300'
                WHEN @SecondsLength BETWEEN 300 AND 360 THEN '300-360'
                WHEN @SecondsLength BETWEEN 360 AND 420 THEN '360-420'
                ELSE '420-'
            END
        AND Year = YEAR(@Release_date)
        AND MonthNumber = MONTH(@Release_date)
        AND Day = DAY(@Release_date)
        AND IDArtist = @ArtistId
    )
    BEGIN
        INSERT INTO Album (
            Title,
            DurationCategory,
            Year,
            MonthNumber,
            Day,
            IDArtist
        )
        VALUES (
            @Title,
            CASE
                WHEN @SecondsLength BETWEEN 0 AND 60 THEN '0-60'
                WHEN @SecondsLength BETWEEN 60 AND 120 THEN '60-120'
                WHEN @SecondsLength BETWEEN 120 AND 180 THEN '120-180'
                WHEN @SecondsLength BETWEEN 180 AND 240 THEN '180-240'
                WHEN @SecondsLength BETWEEN 240 AND 300 THEN '240-300'
                WHEN @SecondsLength BETWEEN 300 AND 360 THEN '300-360'
                WHEN @SecondsLength BETWEEN 360 AND 420 THEN '360-420'
                ELSE '420-'
            END,
            YEAR(@Release_date),
            MONTH(@Release_date),
            DAY(@Release_date),
            @ArtistId
        );
    END

    FETCH NEXT FROM album_cursor INTO @ID, @Title, @Length, @Release_date, @ID_a;
END;

CLOSE album_cursor;
DEALLOCATE album_cursor;
