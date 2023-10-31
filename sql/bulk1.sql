BULK INSERT ARTIST
FROM 'C:\Users\Ja\Downloads\HD\Zad2\DataGenerator\Data\artists1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT CUSTOMER
FROM 'C:\Users\Ja\Downloads\HD\Zad2\DataGenerator\Data\customers1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT ALBUM
FROM 'C:\Users\Ja\Downloads\HD\Zad2\DataGenerator\Data\albums1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT TRACK
FROM 'C:\Users\Ja\Downloads\HD\Zad2\DataGenerator\Data\tracks1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT PLAYLIST
FROM 'C:\Users\Ja\Downloads\HD\Zad2\DataGenerator\Data\playlists1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT PLAYLIST_TRACK
FROM 'C:\Users\Ja\Downloads\HD\Zad2\DataGenerator\Data\playlistTracks1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ','
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );

BULK INSERT PLAYBACK
FROM 'C:\Users\Ja\Downloads\HD\Zad2\DataGenerator\Data\playbacks1.csv'
WITH (
    FIRSTROW = 2
    , FIELDTERMINATOR = ';'
    , ROWTERMINATOR = '\n'
    , KEEPNULLS
    );