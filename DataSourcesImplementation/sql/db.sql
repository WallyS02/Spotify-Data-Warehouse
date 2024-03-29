CREATE TABLE ARTIST(
    ID INT IDENTITY(1,1) PRIMARY KEY,
	NAME CHAR(15) NOT NULL,
	SURNAME CHAR(15) NOT NULL,
	BIRTH_DATE DATE NOT NULL,
	PHONE_NUMBER CHAR(50),
	EMAIL CHAR(75),
    PSEUDONYM CHAR(30) NOT NULL
)

CREATE TABLE CUSTOMER(
    ID INT IDENTITY(1,1) PRIMARY KEY,
	NAME CHAR(15) NOT NULL,
	SURNAME CHAR(15) NOT NULL,
	BIRTH_DATE DATE NOT NULL,
	PHONE_NUMBER CHAR(50),
	EMAIL CHAR(75),
    LOGIN CHAR(30) NOT NULL,
    SUBSCRIPTION CHAR(9) NOT NULL CHECK (SUBSCRIPTION = 'paid' OR SUBSCRIPTION = 'free')
)

CREATE TABLE ALBUM(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    TITLE CHAR(30) NOT NULL,
    LENGTH TIME(0) NOT NULL,
    RELEASE_DATE DATE NOT NULL,
    ID_A INT NOT NULL REFERENCES ARTIST ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE TRACK(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    TITLE CHAR(30) NOT NULL,
    LENGTH TIME(0) NOT NULL,
    NUMBER_IN_ALBUM TINYINT NOT NULL,
    ID_A INT NOT NULL REFERENCES ALBUM ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE PLAYLIST(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NAME CHAR(30) NOT NULL,
    CREATION_DATE DATE NOT NULL,
    PRIVACY CHAR(9) NOT NULL CHECK(PRIVACY = 'public' OR PRIVACY = 'private'),
    LENGTH TIME(0) NOT NULL,
    ID_C INT NOT NULL REFERENCES CUSTOMER ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE PLAYLIST_TRACK(
    ID_P INT NOT NULL REFERENCES PLAYLIST ON UPDATE CASCADE ON DELETE CASCADE,
    ID_T INT NOT NULL REFERENCES TRACK ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (ID_P, ID_T)
)

CREATE TABLE PLAYBACK(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    DATE DATETIME NOT NULL,
    DEVICE CHAR(75) NOT NULL,
    LISTENING_TIME TIME(0) NOT NULL,
    ID_C INT REFERENCES CUSTOMER ON UPDATE CASCADE ON DELETE SET NULL,
    ID_T INT NOT NULL REFERENCES TRACK ON UPDATE CASCADE ON DELETE CASCADE
)
