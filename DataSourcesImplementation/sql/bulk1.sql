BULK INSERT ARTIST
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\artists1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT CUSTOMER
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\customers1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT ALBUM
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\albums1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT TRACK
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\tracks1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT PLAYLIST
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\playlists1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT PLAYLIST_TRACK
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\playlistTracks1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT PLAYBACK
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\Data\playbacks1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ';'
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );