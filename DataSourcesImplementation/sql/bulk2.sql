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

BULK INSERT PLAYLIST_TRACK
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\playlistTracks2.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT PLAYBACK
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\playbacks2.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );
