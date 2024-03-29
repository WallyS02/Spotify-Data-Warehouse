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
    DECLARE @JunkId INT, @NumberOfSongsInLibrary INT, @NumberOfDaysWithPremiumAccount INT, @NumberOfFollowedArtists INT, @NumberOfHoursSinceLastLogin INT, @ListenedSongDuration INT, @CustomerId INT, @DateId INT, @TimeId INT
    SELECT @JunkId = ID FROM Junk WHERE Device = @Device
    SELECT @NumberOfSongsInLibrary = SongsInPrivateLibrary, @NumberOfDaysWithPremiumAccount = NumberOfDaysOfPremiumAccount, @NumberOfFollowedArtists = FollowersNumber, @NumberOfHoursSinceLastLogin = DATEPART(HOUR, LastLoginDatetime) FROM auxiliary.dbo.SpotifyCustomersCSV WHERE CustomerID = @ID_c
    SELECT @CustomerId = ID FROM Customer WHERE LoginID = @ID_c AND UpToDate = 1
    SELECT @ListenedSongDuration = DATEPART(SECOND, LENGTH) FROM Spotify.dbo.TRACK WHERE ID = @ID_t
    SELECT @DateId = ID FROM Date WHERE Year = YEAR(@Date) AND MonthNumber = MONTH(@Date) AND Day = DAY(@Date)
    SELECT @TimeId = ID FROM Time WHERE Hour = DATEPART(HOUR, @Date) AND Minute = DATEPART(MINUTE, @Date) AND Second = DATEPART(SECOND, @Date)

    IF NOT EXISTS (
        SELECT 1
        FROM Playback
        WHERE IDSong = @ID_t
        AND IDDate = @DateId
        AND IDTime = @TimeId
        AND IDCustomer = @CustomerId
        AND IDJunk = @JunkId
        AND NumberOfSongsInLibrary = @NumberOfSongsInLibrary
        AND NumberOfFollowedArtists = @NumberOfFollowedArtists
        AND NumberOfDaysWithPremiumAccount = @NumberOfDaysWithPremiumAccount
        AND NumberOfHoursSinceLastLogin = @NumberOfHoursSinceLastLogin
        AND ListenedSongDuration = @ListenedSongDuration
        AND CustomerListeningTimeDuration = DATEDIFF(SECOND, CAST('00:00:00' AS TIME), @Listening_Time)
    )
    BEGIN
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
            @CustomerId,
            @JunkId,
            @NumberOfSongsInLibrary,
            @NumberOfFollowedArtists,
            @NumberOfDaysWithPremiumAccount,
            @NumberOfHoursSinceLastLogin,
            @ListenedSongDuration,
            DATEDIFF(SECOND, CAST('00:00:00' AS TIME), @Listening_Time)
        );
    END

    FETCH NEXT FROM playback_cursor INTO @ID, @Date, @Device, @Listening_Time, @ID_c, @ID_t;
END;

CLOSE playback_cursor;
DEALLOCATE playback_cursor;
