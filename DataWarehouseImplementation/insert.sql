INSERT INTO Date (Year, Month, Day, MonthNumber, DayOfWeek, DayOfWeekNumber, WorkingDay, Vacation, VacationType)
VALUES
(2023, 'December', 1, 12, 'Thursday', 4, 'Working day', 'No vacation', 'None'),
(2023, 'December', 2, 12, 'Friday', 5, 'Working day', 'No vacation', 'None'),
(2023, 'December', 3, 12, 'Saturday', 6, 'Free day', 'No vacation', 'None'),
(2023, 'December', 4, 12, 'Sunday', 7, 'Free day', 'No vacation', 'None'),
(2023, 'December', 5, 12, 'Monday', 1, 'Working day', 'No vacation', 'None'),
(2023, 'December', 6, 12, 'Tuesday', 2, 'Working day', 'No vacation', 'None'),
(2023, 'December', 7, 12, 'Wednesday', 3, 'Working day', 'No vacation', 'None'),
(2023, 'December', 8, 12, 'Thursday', 4, 'Working day', 'No vacation', 'None'),
(2023, 'December', 9, 12, 'Friday', 5, 'Working day', 'No vacation', 'None'),
(2023, 'December', 10, 12, 'Saturday', 6, 'Free day', 'No vacation', 'None');

INSERT INTO Time (Hour, Minute, Second)
VALUES
(10, 30, 0),
(12, 45, 0),
(15, 0, 0),
(9, 0, 0),
(18, 15, 0),
(14, 20, 0),
(8, 0, 0),
(6, 50, 0),
(21, 0, 0),
(13, 10, 0);

INSERT INTO Artist (Pseudonym, PseudonymID, NameAndSurname, AgeCategory, Email, PhoneNumber, OriginCountry, FollowerNumberCategory, SongQuantityCategory, MusicGenre, IDDate, TotalHoursOfSongsCategory, UpToDate, ArtistExperienceCategory)
VALUES
('Artist1', 101, 'John Doe', '30-40', 'johndoe@example.com', '123456789', 'USA', '100-200', '30-40', 'Pop', 1, '1-2', 1, '40-60'),
('Artist2', 102, 'Jane Smith', '20-30', 'janesmith@example.com', '987654321', 'UK', '200-300', '50-60', 'Rock', 2, '2-3', 1, '60-80'),
('Artist3', 103, 'Robert Johnson', '40-50', 'robertjohnson@example.com', '555123789', 'Canada', '300-400', '70-80', 'Jazz', 3, '3-4', 1, '80-100'),
('Artist4', 104, 'Emily Davis', '20-30', 'emilydavis@example.com', '333888555', 'Australia', '400-500', '90-100', 'Electronic', 4, '4-5', 1, '100-120'),
('Artist5', 105, 'Michael Brown', '50-60', 'michaelbrown@example.com', '777999111', 'Germany', '500-600', '10-20', 'Classical', 5, '5-6', 1, '120-140'),
('Artist6', 106, 'Olivia Wilson', '30-40', 'oliviawilson@example.com', '222333444', 'France', '600-700', '30-40', 'R&B', 6, '6-7', 1, '140-160'),
('Artist7', 107, 'William Martinez', '40-50', 'williammartinez@example.com', '666777888', 'Spain', '700-800', '50-60', 'Hip Hop', 7, '7-8', 1, '160-180'),
('Artist8', 108, 'Sophia Anderson', '20-30', 'sophiaanderson@example.com', '999000222', 'Italy', '800-900', '70-80', 'Folk', 8, '8-9', 1, '180-200'),
('Artist9', 109, 'Daniel Garcia', '60-70', 'danielgarcia@example.com', '444555666', 'Japan', '900-1000', '90-100', 'Alternative', 9, '9-10', 1, '200-220'),
('Artist10', 110, 'Ava Miller', '20-30', 'avamiller@example.com', '111222333', 'Brazil', '1000-', '40-', 'Metal', 10, '10-', 1, '220-240');

INSERT INTO Customer (NameAndSurname, Login, LoginID, Subscription, AgeCategory, Email, PhoneNumber, CustomerExperienceCategory, PreferredMusicGenre, PreferredDevice, UpToDate)
VALUES
('Alice Johnson', 'alicej', 201, 'paid', '20-30', 'alice@example.com', '555123456', '40-60', 'Pop', 'Mobile', 1),
('Bob Williams', 'bobw', 202, 'free', '30-40', 'bob@example.com', '555987654', '60-80', 'Rock', 'Desktop', 1),
('Charlie Davis', 'charlied', 203, 'paid', '40-50', 'charlie@example.com', '555333222', '80-100', 'Jazz', 'Mobile', 1),
('Diana Moore', 'dianam', 204, 'free', '20-30', 'diana@example.com', '555444333', '10-20', 'Classical', 'Mobile', 1),
('Eva Garcia', 'evag', 205, 'paid', '50-60', 'eva@example.com', '555555222', '30-40', 'R&B', 'Desktop', 1),
('Frank Martinez', 'frankm', 206, 'free', '30-40', 'frank@example.com', '555666111', '50-60', 'Hip Hop', 'Mobile', 1),
('Grace Anderson', 'gracea', 207, 'paid', '40-50', 'grace@example.com', '555777888', '70-80', 'Folk', 'Desktop', 1),
('Henry Wilson', 'henryw', 208, 'free', '20-30', 'henry@example.com', '555888999', '90-100', 'Alternative', 'Mobile', 1),
('Isabella Thomas', 'isabellat', 209, 'paid', '60-70', 'isabella@example.com', '555999000', '40-', 'Metal', 'Desktop', 1),
('Jack Brown', 'jackb', 210, 'free', '20-30', 'jack@example.com', '555000111', '70-', 'Folk', 'Mobile', 1);

INSERT INTO Album (Title, DurationCategory, IDDate, IDArtist)
VALUES
('Album1', '180-240', 1, 1),
('Album2', '240-300', 1, 2),
('Album3', '300-360', 2, 3),
('Album4', '360-420', 3, 4),
('Album5', '420-', 4, 5),
('Album6', '180-240', 5, 6),
('Album7', '240-300', 6, 7),
('Album8', '300-360', 7, 8),
('Album9', '360-420', 8, 9),
('Album10', '420-', 9, 10);

INSERT INTO Song (Title, NumberInAlbum, IDAlbum)
VALUES
('Song1', 1, 1),
('Song2', 2, 1),
('Song3', 1, 2),
('Song4', 2, 2),
('Song5', 1, 3),
('Song6', 2, 3),
('Song7', 1, 4),
('Song8', 2, 4),
('Song9', 1, 5),
('Song10', 2, 5);

INSERT INTO Playlist (Name, Privacy)
VALUES
('My Playlist', 'private'),
('Party Mix', 'public'),
('Chill Vibes', 'public'),
('Workout Jams', 'private'),
('Road Trip Tunes', 'private'),
('Study Session', 'public'),
('Throwback Hits', 'private'),
('Dance Party', 'public'),
('Relaxation Station', 'private'),
('Romantic Melodies', 'public');

INSERT INTO PlaylistSong (IDPlaylist, IDSong)
VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10);

INSERT INTO PlaylistCreation (IDCustomer, IDPlaylist, IDDate, PlaylistDuration)
VALUES
(1, 1, 1, 3600),
(2, 2, 1, 7200),
(3, 3, 2, 5400),
(4, 4, 3, 6300),
(5, 5, 4, 4500),
(6, 6, 5, 8000),
(7, 7, 6, 4200),
(8, 8, 7, 3600),
(9, 9, 8, 9000),
(10, 10, 9, 5400);

INSERT INTO Junk (Device)
VALUES
('Mobile'),
('Desktop'),
('Tablet'),
('Smart Speaker'),
('Smartwatch'),
('Car Audio System'),
('Gaming Console'),
('Smart TV'),
('Laptop'),
('Music Player');

INSERT INTO Playback (IDDate, IDTime, IDSong, IDCustomer, IDJunk, NumberOfSongsInLibrary, NumberOfSongsInPrivateLibrary, NumberOfFollowedArtists, NumberOfDaysWithPremiumAccount, NumberOfHoursSinceLastLogin, ListenedSongDuration, CustomerListeningTimeDuration)
VALUES
(1, 1, 1, 1, 1, 100, 50, 20, 60, 2, 180, 360),
(2, 2, 2, 2, 2, 150, 75, 40, 120, 5, 240, 480),
(3, 3, 3, 3, 3, 200, 100, 60, 180, 6, 300, 600),
(4, 4, 4, 4, 4, 250, 125, 80, 240, 8, 360, 720),
(5, 5, 5, 5, 5, 300, 150, 100, 300, 10, 420, 840),
(6, 6, 6, 6, 6, 350, 175, 120, 360, 11, 480, 960),
(7, 7, 7, 7, 7, 400, 200, 140, 420, 13, 540, 1080),
(8, 8, 8, 8, 8, 450, 225, 160, 480, 15, 600, 1200),
(9, 9, 9, 9, 9, 500, 250, 180, 540, 17, 660, 1320),
(10, 10, 10, 10, 10, 550, 275, 200, 600, 20, 720, 1440);
