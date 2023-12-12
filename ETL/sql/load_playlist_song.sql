USE SpotifyDW;

DECLARE @ID_P INT, @ID_T INT;

CLOSE playlist_song_cursor;
DEALLOCATE playlist_song_cursor;

DECLARE playlist_song_cursor CURSOR FOR
SELECT
    ID_P,
    ID_T
FROM
    Spotify.dbo.PLAYLIST_TRACK ORDER BY ID_P, ID_T;

OPEN playlist_song_cursor;
FETCH NEXT FROM playlist_song_cursor INTO @ID_P, @ID_T;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO PlaylistSong (
        IDPlaylist,
        IDSong
    )
    VALUES (
        @ID_P,
        @ID_T
    );

    FETCH NEXT FROM playlist_song_cursor INTO @ID_P, @ID_T;
END;

CLOSE playlist_song_cursor;
DEALLOCATE playlist_song_cursor;
