USE SpotifyDW;

DECLARE @ID INT, @Device CHAR(100);

CLOSE junk_cursor;
DEALLOCATE junk_cursor;

DECLARE junk_cursor CURSOR FOR
SELECT
    ID,
    DEVICE
FROM
    Spotify.dbo.PLAYBACK ORDER BY ID;

OPEN junk_cursor;
FETCH NEXT FROM junk_cursor INTO @ID, @Device;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO Junk (
        Device
    )
    VALUES (
        @Device
    );

    FETCH NEXT FROM junk_cursor INTO @ID, @Device;
END;

CLOSE junk_cursor;
DEALLOCATE junk_cursor;
