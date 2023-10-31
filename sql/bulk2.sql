BULK INSERT ARTIST
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\artists2.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT CUSTOMER
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\customers2.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT ALBUM
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\albums2.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT TRACK
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\tracks2.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT PLAYLIST
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\playlists2.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT TempPlaylistTrack
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\playlistTracks2.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

INSERT INTO PLAYLIST_TRACK (ID_P, ID_T)
SELECT ID_P, ID_T
FROM TempPlaylistTrack AS src
WHERE NOT EXISTS (
    SELECT 1
    FROM PLAYLIST_TRACK AS dest
    WHERE dest.ID_P = src.ID_P AND dest.ID_T = src.ID_T
);

TRUNCATE TABLE TempPlaylistTrack;

BULK INSERT PLAYBACK
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\playbacks2.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ';'
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );