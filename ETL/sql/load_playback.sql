USE SpotifyDW;

DECLARE @ID INT, @Date DATETIME, @Device CHAR(100), @Listening_Time TIME(0), @ID_c INT, @ID_t INT;

CLOSE playback_cursor;
DEALLOCATE playback_cursor;

DECLARE playback_cursor CURSOR FOR
SELECT
    ID,
    DATE,
    DEVICE,
    LISTENING_TIME,
    ID_C,
    ID_T
FROM
    Spotify.dbo.PLAYBACK ORDER BY ID;

OPEN playback_cursor;
FETCH NEXT FROM playback_cursor INTO @ID, @Date, @Device, @Listening_Time, @ID_c, @ID_t;

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @DateId INT, @TimeId INT, @JunkId INT, @NumberOfSongsInLibrary INT, @NumberOfDaysWithPremiumAccount INT, @NumberOfFollowedArtists INT, @NumberOfHoursSinceLastLogin INT, @ListenedSongDuration INT
    SELECT @DateId = ID FROM Date WHERE Year = YEAR(@Date) AND MonthNumber = MONTH(@Date) AND Day = DAY(@Date)
    SELECT @TimeId = ID FROM Time WHERE Hour = DATEPART(HOUR, @Date) AND Minute = DATEPART(MINUTE, @Date)  AND Second = DATEPART(SECOND, @Date)
    SELECT @JunkId = ID FROM Junk WHERE Device = @Device
    SELECT @NumberOfSongsInLibrary = SongsInPrivateLibrary, @NumberOfDaysWithPremiumAccount = NumberOfDaysOfPremiumAccount, @NumberOfFollowedArtists = FollowersNumber, @NumberOfHoursSinceLastLogin = DATEPART(HOUR, LastLoginDatetime) FROM auxiliary.dbo.SpotifyCustomersCSV WHERE CustomerID = @ID_c
    SELECT @ListenedSongDuration = DATEPART(SECOND, LENGTH) FROM Spotify.dbo.TRACK WHERE ID = @ID_t
    INSERT INTO Playback (
        IDDate,
        IDTime,
        IDSong,
        IDCustomer,
        IDJunk,
        NumberOfSongsInLibrary,
        NumberOfFollowedArtists,
        NumberOfDaysWithPremiumAccount,
        NumberOfHoursSinceLastLogin,
        ListenedSongDuration,
        CustomerListeningTimeDuration
    )
    VALUES (
        @DateId,
        @TimeId,
        @ID_t,
        @ID_c,
        @JunkId,
        @NumberOfSongsInLibrary,
        @NumberOfFollowedArtists,
        @NumberOfDaysWithPremiumAccount,
        @NumberOfHoursSinceLastLogin,
        @ListenedSongDuration,
        DATEDIFF(SECOND, CAST('00:00:00' AS TIME), @Listening_Time)
    );

    FETCH NEXT FROM playback_cursor INTO @ID, @Date, @Device, @Listening_Time, @ID_c, @ID_t;
END;

CLOSE playback_cursor;
DEALLOCATE playback_cursor;
