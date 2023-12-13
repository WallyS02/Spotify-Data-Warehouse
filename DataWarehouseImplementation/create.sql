USE SpotifyDW;

CREATE TABLE Date (
    Year INT,
    Month VARCHAR(20),
    Day INT,
    MonthNumber INT,
    PRIMARY KEY(Year, MonthNumber, Day),
    DayOfWeek VARCHAR(20),
    DayOfWeekNumber INT,
    WorkingDay VARCHAR(20),
    Vacation VARCHAR(20),
    VacationType VARCHAR(100)
);

CREATE TABLE Time (
    Hour INT,
    Minute INT,
    Second INT,
    PRIMARY KEY(Hour, Minute, Second)
);

CREATE TABLE Artist (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Pseudonym VARCHAR(20),
    PseudonymID INT,
    NameAndSurname VARCHAR(41),
    AgeCategory VARCHAR(20),
    Email VARCHAR(50),
    PhoneNumber VARCHAR(100),
    OriginCountry VARCHAR(80),
    FollowerNumberCategory VARCHAR(20),
    SongQuantityCategory VARCHAR(20),
    MusicGenre VARCHAR(20),
    Year INT,
	MonthNumber INT,
	Day INT,
	FOREIGN KEY(Year, MonthNumber, Day) REFERENCES DATE,
    TotalHoursOfSongsCategory VARCHAR(20),
    UpToDate BIT,
    ArtistExperienceCategory VARCHAR(20)
);

CREATE TABLE Customer (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NameAndSurname VARCHAR(75),
    Login VARCHAR(75),
    LoginID INT,
    Subscription VARCHAR(9),
    AgeCategory VARCHAR(75),
    Email VARCHAR(50),
    PhoneNumber VARCHAR(100),
    CustomerExperienceCategory VARCHAR(75),
    PreferredMusicGenre VARCHAR(75),
    PreferredDevice VARCHAR(75),
    UpToDate BIT
);

CREATE TABLE Album (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(75),
    DurationCategory VARCHAR(20),
    Year INT,
	MonthNumber INT,
	Day INT,
	FOREIGN KEY(Year, MonthNumber, Day) REFERENCES DATE,
    IDArtist INT REFERENCES Artist
);

CREATE TABLE Song (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(75),
    NumberInAlbum INT,
    IDAlbum INT REFERENCES Album
);

CREATE TABLE Playlist (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(75),
    Privacy VARCHAR(50)
);

CREATE TABLE PlaylistSong (
    IDPlaylist INT REFERENCES Playlist,
    IDSong INT REFERENCES Song,
    PRIMARY KEY (IDPlaylist, IDSong)
);

CREATE TABLE PlaylistCreation (
    IDCustomer INT REFERENCES Customer,
    IDPlaylist INT REFERENCES Playlist,Year INT,
	MonthNumber INT,
	Day INT,
	FOREIGN KEY(Year, MonthNumber, Day) REFERENCES DATE,
    PlaylistDuration INT
    PRIMARY KEY (IDCustomer, IDPlaylist)
);

CREATE TABLE Junk (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Device VARCHAR(75) UNIQUE
);

CREATE TABLE Playback (
    ID INT IDENTITY(1,1) PRIMARY KEY,Year INT,
	MonthNumber INT,
	Day INT,
	FOREIGN KEY(Year, MonthNumber, Day) REFERENCES DATE,
    Hour INT,
	Minute INT,
	Second INT,
	FOREIGN KEY(Hour, Minute, Second) REFERENCES TIME,
    IDSong INT REFERENCES Song,
    IDCustomer INT REFERENCES Customer,
    IDJunk INT REFERENCES Junk,
    NumberOfSongsInLibrary INT,
    NumberOfFollowedArtists INT,
    NumberOfDaysWithPremiumAccount INT,
    NumberOfHoursSinceLastLogin INT,
    ListenedSongDuration INT,
    CustomerListeningTimeDuration INT
);
