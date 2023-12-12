USE master;
DROP DATABASE auxiliary;
CREATE DATABASE auxiliary;
GO

USE auxiliary;

CREATE TABLE SpotifyArtistsCSV (
    ArtistID INT,
    Country VARCHAR(100),
    Followers INT,
    NumberOfTracks INT,
    Genre VARCHAR(100),
    DebutDate DATE,
    TotalListeningHours DECIMAL(10, 2),
    AverageTrackLength DECIMAL(10, 2)
);

BULK INSERT SpotifyArtistsCSV
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\TommyGenerator\Data\dane_artysta1.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    KEEPNULLS
);

CREATE TABLE SpotifyCustomersCSV (
    CustomerID INT,
    RegistrationDate Date,
    MostListenedGenre VARCHAR(100),
    SongsInPrivateLibrary INT,
    FollowersNumber INT,
    LastLoginDatetime Datetime,
    NumberOfDaysOfPremiumAccount INT,
    MostUsedDevice VARCHAR(100)
);

BULK INSERT SpotifyCustomersCSV
FROM 'C:\Users\Ja\Downloads\HD\Spotify-Data-Warehouse\DataGenerator\TommyGenerator\Data\dane_uzytkownik1.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    KEEPNULLS
);

CREATE TABLE holidays(date DATE, name VARCHAR(500), PRIMARY KEY(date, name));

DECLARE @EndYear INT = 2035;
DECLARE @CurrentYear INT = YEAR(GETDATE());

WHILE @CurrentYear <= @EndYear
BEGIN
    -- Nowy Rok
    INSERT INTO holidays (date, name) VALUES (CAST(@CurrentYear AS VARCHAR(4)) + '-01-01', 'New Years Eve');

    -- Święto Trzech Króli
    INSERT INTO holidays (date, name) VALUES (CAST(@CurrentYear AS VARCHAR(4)) + '-01-06', 'Epiphany');

    -- Wielkanoc
    DECLARE @Century INT, @G INT, @H INT, @I INT, @J INT;

    SET @Century = @CurrentYear / 100;
    SET @G = @CurrentYear % 19;
    SET @H = (19 * @G + @Century - @Century / 4 - ((8 * @Century + 13) / 25) + 15) % 30;
    SET @I = @H - @H / 28 * (1 - 29 / (@H + 1) * ((21 - @G) / 11));
    SET @J = (@CurrentYear + @CurrentYear / 4 + @I + 2 - @Century + @Century / 4) % 7;

    DECLARE @L INT, @Month INT, @Day INT;
    SET @L = @I - @J;
    SET @Month = 3 + (@L + 40) / 44;
    SET @Day = @L + 28 - 31 * (@Month / 4);

    DECLARE @EasterDate DATE = CAST(@CurrentYear AS VARCHAR(4)) + '-' + RIGHT('0' + CAST(@Month AS VARCHAR(2)), 2) + '-' + RIGHT('0' + CAST(@Day AS VARCHAR(2)), 2);

    INSERT INTO holidays (date, name) VALUES (@EasterDate, 'Easter');

    -- Wielkanocny Poniedziałek
    DECLARE @EasterMonday DATE;
    SELECT @EasterMonday = DATEADD(DAY, 1, @EasterDate);
    INSERT INTO holidays (date, name) VALUES (@EasterMonday, 'Easter monday');

    -- Święto Pracy
    INSERT INTO holidays (date, name) VALUES (CAST(@CurrentYear AS VARCHAR(4)) + '-05-01', 'Labour Day');

    -- Święto Konstytucji 3 Maja
    INSERT INTO holidays (date, name) VALUES (CAST(@CurrentYear AS VARCHAR(4)) + '-05-03', 'Constitution Day May 3');

    -- Zielone Świątki
    DECLARE @PentecostDate DATE;
    SELECT @PentecostDate = DATEADD(WEEK, 7, @EasterDate);
    INSERT INTO holidays (date, name) VALUES (@PentecostDate, 'Pentecost');

    -- Boże Ciało
    DECLARE @CorpusChristiDate DATE;
    SELECT @CorpusChristiDate = DATEADD(WEEK, 10, @EasterDate);
    INSERT INTO holidays (date, name) VALUES (@CorpusChristiDate, 'Corpus Christi');

    -- Wniebowzięcie Najświętszej Maryi Panny
    INSERT INTO holidays (date, name) VALUES (CAST(@CurrentYear AS VARCHAR(4)) + '-08-15', 'Assumption of the Blessed Virgin Mary');

    -- Wszystkich Świętych
    INSERT INTO holidays (date, name) VALUES (CAST(@CurrentYear AS VARCHAR(4)) + '-11-01', 'All the saints');

    -- Święto Niepodległości
    INSERT INTO holidays (date, name) VALUES (CAST(@CurrentYear AS VARCHAR(4)) + '-11-11', 'Independence Day');

    -- Boże Narodzenie
    INSERT INTO holidays (date, name) VALUES (CAST(@CurrentYear AS VARCHAR(4)) + '-12-25', 'Christmas first day');
    INSERT INTO holidays (date, name) VALUES (CAST(@CurrentYear AS VARCHAR(4)) + '-12-26', 'Christmas second day');

    SET @CurrentYear += 1;
END;
