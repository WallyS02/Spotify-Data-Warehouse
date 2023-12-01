CREATE TABLE Date (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Year INT,
    Month VARCHAR(20),
    Day INT,
    MonthNumber INT,
    DayOfWeek VARCHAR(20),
    DayOfWeekNumber INT,
    WorkingDay VARCHAR(20),
    Vacation VARCHAR(20),
    VacationType VARCHAR(20)
);

CREATE TABLE Time (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Hour INT,
    Minute INT,
    Second INT
);

CREATE TABLE Artist (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Pseudonym VARCHAR(20),
    PseudonymID INT,
    NameAndSurname VARCHAR(41),
    AgeCategory VARCHAR(20),
    Email VARCHAR(50),
    PhoneNumber VARCHAR(20),
    OriginCountry VARCHAR(20),
    FollowerNumberCategory VARCHAR(20),
    SongQuantityCategory VARCHAR(20),
    MusicGenre VARCHAR(20),
    IDDate INT REFERENCES Date,
    TotalHoursOfSongsCategory VARCHAR(20),
    UpToDate BIT,
    ArtistExperienceCategory VARCHAR(20)
);

CREATE TABLE Customer (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NameAndSurname VARCHAR(41),
    Login VARCHAR(20),
    LoginID INT,
    Subscription VARCHAR(9),
    AgeCategory VARCHAR(20),
    Email VARCHAR(50),
    PhoneNumber VARCHAR(20),
    CustomerExperienceCategory VARCHAR(20),
    PreferredMusicGenre VARCHAR(20),
    PreferredDevice VARCHAR(20),
    UpToDate BIT
);

CREATE TABLE Album (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(20),
    DurationCategory VARCHAR(20),
    IDDate INT REFERENCES Date,
    IDArtist INT REFERENCES Artist
);

CREATE TABLE Song (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(20),
    NumberInAlbum INT,
    IDAlbum INT REFERENCES Album
);

CREATE TABLE Playlist (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(20),
    Privacy VARCHAR(20)
);

CREATE TABLE PlaylistSong (
    IDPlaylist INT REFERENCES Playlist,
    IDSong INT REFERENCES Song,
    PRIMARY KEY (IDPlaylist, IDSong)
);

CREATE TABLE PlaylistCreation (
    IDCustomer INT REFERENCES Customer,
    IDPlaylist INT REFERENCES Playlist,
    IDDate INT REFERENCES Date,
    PlaylistDuration INT
    PRIMARY KEY (IDCustomer, IDPlaylist)
);

CREATE TABLE Junk (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Device VARCHAR(20)
);

CREATE TABLE Playback (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    IDDate INT REFERENCES Date,
    IDTime INT REFERENCES Time,
    IDSong INT REFERENCES Song,
    IDCustomer INT REFERENCES Customer,
    IDJunk INT REFERENCES Junk,
    NumberOfSongsInLibrary INT,
    NumberOfSongsInPrivateLibrary INT,
    NumberOfFollowedArtists INT,
    NumberOfDaysWithPremiumAccount INT,
    NumberOfHoursSinceLastLogin INT,
    ListenedSongDuration INT,
    CustomerListeningTimeDuration INT
);
