USE SpotifyDW;

DECLARE @ID INT, @Name CHAR(15), @Surname CHAR(15), @Birth_date DATE, @Phone_Number CHAR(50), @Email CHAR(75), @Login CHAR(30), @Subscription CHAR(30);

CLOSE customer_cursor;
DEALLOCATE customer_cursor;

DECLARE customer_cursor CURSOR FOR
SELECT
    ID,
	NAME,
	SURNAME,
	BIRTH_DATE,
	PHONE_NUMBER,
	EMAIL,
    LOGIN,
    SUBSCRIPTION
FROM
    Spotify.dbo.CUSTOMER ORDER BY ID;

OPEN customer_cursor;
FETCH NEXT FROM customer_cursor INTO @ID, @Name, @Surname, @Birth_date, @Phone_Number, @Email, @Login, @Subscription;

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @RegistrationDate Date, @MostListenedGenre VARCHAR(100), @SongsInPrivateLibrary INT, @FollowersNumber INT, @LastLoginDatetime Datetime, @NumberOfDaysOfPremiumAccount INT, @MostUsedDevice VARCHAR(100);
    SELECT @RegistrationDate = RegistrationDate, @MostListenedGenre = MostListenedGenre, @SongsInPrivateLibrary = SongsInPrivateLibrary, @FollowersNumber = FollowersNumber, @LastLoginDatetime = LastLoginDatetime, @NumberOfDaysOfPremiumAccount = NumberOfDaysOfPremiumAccount, @MostUsedDevice = MostUsedDevice FROM auxiliary.dbo.SpotifyCustomersCSV WHERE CustomerID = @ID
    DECLARE @Age INT = YEAR(GETDATE()) - YEAR(@Birth_date)
    DECLARE @CustomerExperience INT = DATEDIFF(DAY, @RegistrationDate, GETDATE())
    IF NOT EXISTS (
        SELECT 1
        FROM Customer
        WHERE NameAndSurname = @Name + ' ' + @Surname
        AND Login = @Login
        AND LoginID = @ID
        AND Subscription = @Subscription
        AND AgeCategory =
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
            END
        AND Email = @Email
        AND PhoneNumber = @Phone_Number
        AND CustomerExperienceCategory =
            CASE
                WHEN @CustomerExperience BETWEEN 0 AND 20 THEN '0-10'
                WHEN @CustomerExperience BETWEEN 20 AND 40 THEN '20-40'
                WHEN @CustomerExperience BETWEEN 40 AND 60 THEN '40-60'
                WHEN @CustomerExperience BETWEEN 60 AND 80 THEN '60-80'
                WHEN @CustomerExperience BETWEEN 80 AND 100 THEN '80-100'
                ELSE '100-'
            END
        AND PreferredMusicGenre = @MostListenedGenre
        AND PreferredDevice = @MostUsedDevice
        AND UpToDate = 1
    )
    BEGIN
        IF NOT EXISTS (
			SELECT 1
			FROM Customer
			WHERE LoginID = @ID
		)
        BEGIN
            INSERT INTO Customer (
                NameAndSurname,
                Login,
                LoginID,
                Subscription,
                AgeCategory,
                Email,
                PhoneNumber,
                CustomerExperienceCategory,
                PreferredMusicGenre,
                PreferredDevice,
                UpToDate
            )
            VALUES (
                @Name + ' ' + @Surname,
                @Login,
                @ID,
                @Subscription,
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
                CASE
                    WHEN @CustomerExperience BETWEEN 0 AND 20 THEN '0-10'
                    WHEN @CustomerExperience BETWEEN 20 AND 40 THEN '20-40'
                    WHEN @CustomerExperience BETWEEN 40 AND 60 THEN '40-60'
                    WHEN @CustomerExperience BETWEEN 60 AND 80 THEN '60-80'
                    WHEN @CustomerExperience BETWEEN 80 AND 100 THEN '80-100'
                    ELSE '100-'
                END,
                @MostListenedGenre,
                @MostUsedDevice,
                1
            );
        END
        ELSE
        BEGIN
            DECLARE @OldCustomerId INT;
        SELECT @OldCustomerId = ID FROM Customer WHERE LoginID = @ID AND UpToDate = 1;
        UPDATE Customer SET UpToDate = 0 WHERE LoginID = @ID;

        INSERT INTO Customer (
            NameAndSurname,
            Login,
            LoginID,
            Subscription,
            AgeCategory,
            Email,
            PhoneNumber,
            CustomerExperienceCategory,
            PreferredMusicGenre,
            PreferredDevice,
            UpToDate
        )
        VALUES (
            @Name + ' ' + @Surname,
            @Login,
            @ID,
            @Subscription,
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
            CASE
                WHEN @CustomerExperience BETWEEN 0 AND 20 THEN '0-10'
                WHEN @CustomerExperience BETWEEN 20 AND 40 THEN '20-40'
                WHEN @CustomerExperience BETWEEN 40 AND 60 THEN '40-60'
                WHEN @CustomerExperience BETWEEN 60 AND 80 THEN '60-80'
                WHEN @CustomerExperience BETWEEN 80 AND 100 THEN '80-100'
                ELSE '100-'
            END,
            @MostListenedGenre,
            @MostUsedDevice,
            1
        );

        DECLARE @NewCustomerId INT;
        SELECT @NewCustomerId = ID FROM Customer WHERE LoginID = @ID AND UpToDate = 1;

        UPDATE Playback SET IDCustomer = @NewCustomerId WHERE IDCustomer = @OldCustomerId;
        UPDATE PlaylistCreation SET IDCustomer = @NewCustomerId WHERE IDCustomer = @OldCustomerId;
        END
    END

    FETCH NEXT FROM customer_cursor INTO @ID, @Name, @Surname, @Birth_date, @Phone_Number, @Email, @Login, @Subscription;
END;

CLOSE customer_cursor;
DEALLOCATE customer_cursor;
