DECLARE @EndDate DATE = '2035-12-31';
DECLARE @CurrentDate DATE = GETDATE();

WHILE @CurrentDate <= @EndDate
BEGIN
    DECLARE @IsHoliday BIT;
    DECLARE @HolidayName VARCHAR(100);

    USE auxiliary;
    SELECT @IsHoliday = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END,
           @HolidayName = COALESCE(MAX(Name), '')
    FROM Holidays
    WHERE date = @CurrentDate;
    USE SpotifyDW;

    INSERT INTO Date (Year, Month, Day, MonthNumber, DayOfWeek, DayOfWeekNumber, WorkingDay, Vacation, VacationType)
    SELECT
        YEAR(@CurrentDate),
        FORMAT(@CurrentDate, 'MMMM'),
        DAY(@CurrentDate),
        MONTH(@CurrentDate),
        DATENAME(WEEKDAY, @CurrentDate),
        DATEPART(WEEKDAY, @CurrentDate),
        IIF(@IsHoliday = 1, 'Free day',
            IIF(DATENAME(WEEKDAY, @CurrentDate) IN ('Saturday', 'Sunday'), 'Free day', 'Working day')) AS WorkingDay,
        IIF(MONTH(@CurrentDate) IN (7, 8), 'Summer holidays',
            IIF(MONTH(@CurrentDate) IN (1, 2), 'Winter holidays', 'No holidays')) AS Vacation,
        IIF(@IsHoliday = 1, @HolidayName, 'None') AS VacationType
    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
END;
