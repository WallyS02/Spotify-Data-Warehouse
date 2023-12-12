USE SpotifyDW;

DECLARE @ID INT, @Name CHAR(15), @Surname CHAR(15), @Birth_date DATE, @Phone_Number CHAR(50), @Email CHAR(75), @Pseudonym CHAR(30);
DECLARE @ArtistID INT, @Country VARCHAR(100), @Followers INT, @NumberOfTracks INT, @Genre VARCHAR(100), @DebutDate DATE, @TotalListeningHours DECIMAL(10, 2), @AverageTrackLength DECIMAL(10, 2);

CLOSE artist_cursor;
DEALLOCATE artist_cursor;

CLOSE artist_csv_cursor;
DEALLOCATE artist_csv_cursor;

DECLARE artist_cursor CURSOR FOR
SELECT
    ID,
    Name,
    Surname,
    Birth_date,
    Phone_Number,
    Email,
    Pseudonym
FROM
    Spotify.dbo.ARTIST ORDER BY ID;

OPEN artist_cursor;
FETCH NEXT FROM artist_cursor INTO @ID, @Name, @Surname, @Birth_date, @Phone_Number, @Email, @Pseudonym;

DECLARE artist_csv_cursor CURSOR FOR
SELECT
    ArtistID,
    Country,
    Followers,
    NumberOfTracks,
    Genre,
    DebutDate,
    TotalListeningHours,
    AverageTrackLength
FROM
    auxiliary.dbo.SpotifyArtistsCSV ORDER BY ArtistID;

OPEN artist_csv_cursor;
FETCH NEXT FROM artist_csv_cursor INTO @ArtistID, @Country, @Followers, @NumberOfTracks, @Genre, @DebutDate, @TotalListeningHours, @AverageTrackLength

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @Age INT = YEAR(GETDATE()) - YEAR(@Birth_date)
    DECLARE @DateId INT
    SELECT @DateId = ID FROM Date WHERE Year = YEAR(@DebutDate) AND MonthNumber = MONTH(@DebutDate) AND Day = DAY(@DebutDate)
    DECLARE @ArtistExperience INT = DATEDIFF(DAY, @DebutDate, GETDATE())
    INSERT INTO Artist (
        Pseudonym,
        PseudonymID,
        NameAndSurname,
        AgeCategory,
        Email,
        PhoneNumber,
        OriginCountry,
        FollowerNumberCategory,
        SongQuantityCategory,
        MusicGenre,
        IDDate,
        TotalHoursOfSongsCategory,
        UpToDate,
        ArtistExperienceCategory
    )
    VALUES (
        @Pseudonym,
        @ID,
        @Name + ' ' + @Surname,
        CASE
            WHEN @Age BETWEEN 10 AND 20 THEN '10-20'
            WHEN @Age BETWEEN 20 AND 30 THEN '20-30'
            WHEN @Age BETWEEN 30 AND 40 THEN '30-40'
            WHEN @Age BETWEEN 40 AND 50 THEN '40-50'
            WHEN @Age BETWEEN 50 AND 60 THEN '50-60'
            WHEN @Age BETWEEN 60 AND 70 THEN '60-70'
            WHEN @Age BETWEEN 70 AND 80 THEN '70-80'
            WHEN @Age BETWEEN 80 AND 90 THEN '80-90'
            WHEN @Age BETWEEN 90 AND 100 THEN '90-100'
            ELSE '100-'
        END,
        @Email,
        @Phone_Number,
        @Country,
        CASE
            WHEN @Followers BETWEEN 0 AND 100 THEN '0-100'
            WHEN @Followers BETWEEN 100 AND 200 THEN '100-200'
            WHEN @Followers BETWEEN 200 AND 300 THEN '200-300'
            WHEN @Followers BETWEEN 300 AND 400 THEN '300-400'
            WHEN @Followers BETWEEN 400 AND 500 THEN '400-500'
            WHEN @Followers BETWEEN 500 AND 600 THEN '500-600'
            WHEN @Followers BETWEEN 600 AND 700 THEN '600-700'
            WHEN @Followers BETWEEN 700 AND 800 THEN '700-800'
            WHEN @Followers BETWEEN 800 AND 900 THEN '800-900'
            WHEN @Followers BETWEEN 900 AND 1000 THEN '900-1000'
            ELSE '1000-'
        END,
        CASE
            WHEN @NumberOfTracks BETWEEN 0 AND 10 THEN '0-10'
            WHEN @NumberOfTracks BETWEEN 10 AND 20 THEN '10-20'
            WHEN @NumberOfTracks BETWEEN 20 AND 30 THEN '20-30'
            WHEN @NumberOfTracks BETWEEN 30 AND 40 THEN '30-40'
            WHEN @NumberOfTracks BETWEEN 40 AND 50 THEN '40-50'
            WHEN @NumberOfTracks BETWEEN 50 AND 60 THEN '50-60'
            WHEN @NumberOfTracks BETWEEN 60 AND 70 THEN '60-70'
            WHEN @NumberOfTracks BETWEEN 70 AND 80 THEN '70-80'
            WHEN @NumberOfTracks BETWEEN 80 AND 90 THEN '80-90'
            WHEN @NumberOfTracks BETWEEN 90 AND 100 THEN '90-100'
            ELSE '100-'
        END,
        @Genre,
        @DateId,
        CASE
            WHEN @TotalListeningHours BETWEEN 0 AND 1 THEN '0-1'
            WHEN @TotalListeningHours BETWEEN 1 AND 2 THEN '1-2'
            WHEN @TotalListeningHours BETWEEN 2 AND 3 THEN '2-3'
            WHEN @TotalListeningHours BETWEEN 3 AND 4 THEN '3-4'
            WHEN @TotalListeningHours BETWEEN 4 AND 5 THEN '4-5'
            WHEN @TotalListeningHours BETWEEN 5 AND 6 THEN '5-6'
            WHEN @TotalListeningHours BETWEEN 6 AND 7 THEN '6-7'
            WHEN @TotalListeningHours BETWEEN 7 AND 8 THEN '7-8'
            WHEN @TotalListeningHours BETWEEN 8 AND 9 THEN '8-9'
            WHEN @TotalListeningHours BETWEEN 9 AND 10 THEN '9-10'
            ELSE '10-'
        END,
        1,
        CASE
            WHEN @ArtistExperience BETWEEN 0 AND 20 THEN '0-10'
            WHEN @ArtistExperience BETWEEN 20 AND 40 THEN '20-40'
            WHEN @ArtistExperience BETWEEN 40 AND 60 THEN '40-60'
            WHEN @ArtistExperience BETWEEN 60 AND 80 THEN '60-80'
            WHEN @ArtistExperience BETWEEN 80 AND 100 THEN '80-100'
            ELSE '100-'
        END
    );

    FETCH NEXT FROM artist_cursor INTO @ID, @Name, @Surname, @Birth_date, @Phone_Number, @Email, @Pseudonym;
    FETCH NEXT FROM artist_csv_cursor INTO @ArtistID, @Country, @Followers, @NumberOfTracks, @Genre, @DebutDate, @TotalListeningHours, @AverageTrackLength
END;

CLOSE artist_cursor;
DEALLOCATE artist_cursor;

CLOSE artist_csv_cursor;
DEALLOCATE artist_csv_cursor;
