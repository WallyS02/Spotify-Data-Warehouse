USE SpotifyDW;

DECLARE @ID INT, @Title CHAR(30), @Number_In_Album INT, @ID_a INT;

CLOSE song_cursor;
DEALLOCATE song_cursor;

DECLARE song_cursor CURSOR FOR
SELECT
    ID,
    TITLE,
    NUMBER_IN_ALBUM,
    ID_A
FROM
    Spotify.dbo.TRACK ORDER BY ID;

OPEN song_cursor;
FETCH NEXT FROM song_cursor INTO @ID, @Title, @Number_In_Album, @ID_a;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO Song (
        Title,
        NumberInAlbum,
        IDAlbum
    )
    VALUES (
        @Title,
        @Number_In_Album,
        @ID_a
    );

    FETCH NEXT FROM song_cursor INTO @ID, @Title, @Number_In_Album, @ID_a;
END;

CLOSE song_cursor;
DEALLOCATE song_cursor;
