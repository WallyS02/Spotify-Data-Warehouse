USE SpotifyDW;

DECLARE @ID INT, @Creation_Time DATE, @Length TIME(0), @ID_c INT;

CLOSE playlist_creation_cursor;
DEALLOCATE playlist_creation_cursor;

DECLARE playlist_creation_cursor CURSOR FOR
SELECT
    ID,
    CREATION_DATE,
    LENGTH,
    ID_C
FROM
    Spotify.dbo.PLAYLIST ORDER BY ID;

OPEN playlist_creation_cursor;
FETCH NEXT FROM playlist_creation_cursor INTO @ID, @Creation_Time, @Length, @ID_c;

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @CustomerId INT, @DateId INT
    SELECT @CustomerId = ID FROM Customer WHERE LoginID = @ID_c AND UpToDate = 1
    SELECT @DateId = ID FROM Date WHERE Year = YEAR(@Creation_Time) AND MonthNumber = MONTH(@Creation_Time) AND Day = DAY(@Creation_Time)
    DECLARE @SecondsLength INT = DATEDIFF(SECOND, CAST('00:00:00' AS TIME), @Length)

    IF NOT EXISTS (
        SELECT 1
        FROM PlaylistCreation
        WHERE IDCustomer = @CustomerId
        AND IDPlaylist = @ID
        AND IDDate = @DateId
        AND PlaylistDuration = @SecondsLength
    )
    BEGIN
        INSERT INTO PlaylistCreation (
            IDCustomer,
            IDPlaylist,
            IDDate,
            PlaylistDuration
        )
        VALUES (
            @CustomerId,
            @ID,
            @DateId,
            @SecondsLength
        );
    END

    FETCH NEXT FROM playlist_creation_cursor INTO @ID, @Creation_Time, @Length, @ID_c;
END;

CLOSE playlist_creation_cursor;
DEALLOCATE playlist_creation_cursor;
