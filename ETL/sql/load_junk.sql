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
    IF NOT EXISTS (
        SELECT 1
        FROM Junk
        WHERE Device = @Device
    )
    BEGIN
        INSERT INTO Junk (
            Device
        )
        VALUES (
            @Device
        );
    END

    FETCH NEXT FROM junk_cursor INTO @ID, @Device;
END;

CLOSE junk_cursor;
DEALLOCATE junk_cursor;
