USE SpotifyDW;

DECLARE @ID INT, @Name CHAR(15), @Surname CHAR(15), @Birth_date DATE, @Phone_Number CHAR(50), @Email CHAR(75), @Login CHAR(30), @Subscription CHAR(30);
DECLARE @CustomerID INT, @RegistrationDate Date, @MostListenedGenre VARCHAR(100), @SongsInPrivateLibrary INT, @FollowersNumber INT, @LastLoginDatetime Datetime, @NumberOfDaysOfPremiumAccount INT, @MostUsedDevice VARCHAR(100);

CLOSE customer_cursor;
DEALLOCATE customer_cursor;

CLOSE customer_csv_cursor;
DEALLOCATE customer_csv_cursor;

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

DECLARE customer_csv_cursor CURSOR FOR
SELECT
    CustomerID,
    RegistrationDate,
    MostListenedGenre,
    SongsInPrivateLibrary,
    FollowersNumber,
    LastLoginDatetime,
    NumberOfDaysOfPremiumAccount,
    MostUsedDevice
FROM
    auxiliary.dbo.SpotifyCustomersCSV ORDER BY CustomerID;

OPEN customer_csv_cursor;
FETCH NEXT FROM customer_csv_cursor INTO @CustomerID, @RegistrationDate, @MostListenedGenre, @SongsInPrivateLibrary, @FollowersNumber, @LastLoginDatetime, @NumberOfDaysOfPremiumAccount, @MostUsedDevice;

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @Age INT = YEAR(GETDATE()) - YEAR(@Birth_date)
    DECLARE @CustomerExperience INT = DATEDIFF(DAY, @RegistrationDate, GETDATE())
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

    FETCH NEXT FROM customer_cursor INTO @ID, @Name, @Surname, @Birth_date, @Phone_Number, @Email, @Login, @Subscription;
    FETCH NEXT FROM customer_csv_cursor INTO @CustomerID, @RegistrationDate, @MostListenedGenre, @SongsInPrivateLibrary, @FollowersNumber, @LastLoginDatetime, @NumberOfDaysOfPremiumAccount, @MostUsedDevice;
END;

CLOSE customer_cursor;
DEALLOCATE customer_cursor;

CLOSE customer_csv_cursor;
DEALLOCATE customer_csv_cursor;
