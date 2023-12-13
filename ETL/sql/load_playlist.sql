USE SpotifyDW;

DECLARE @ID INT, @Name CHAR(30), @Privacy CHAR(30);

CLOSE playlist_cursor;
DEALLOCATE playlist_cursor;

DECLARE playlist_cursor CURSOR FOR
SELECT
    ID,
    NAME,
    PRIVACY
FROM
    Spotify.dbo.PLAYLIST ORDER BY ID;

OPEN playlist_cursor;
FETCH NEXT FROM playlist_cursor INTO @ID, @Name, @Privacy;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM Playlist
        WHERE Name = @Name
        AND Privacy = @Privacy
    )
    BEGIN
        INSERT INTO Playlist (
            Name,
            Privacy
        )
        VALUES (
            @Name,
            @Privacy
        );
    END

    FETCH NEXT FROM playlist_cursor INTO @ID, @Name, @Privacy;
END;

CLOSE playlist_cursor;
DEALLOCATE playlist_cursor;
