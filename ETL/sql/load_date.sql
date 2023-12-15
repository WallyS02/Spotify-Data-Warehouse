DECLARE @EndDate DATE = '2025-12-31';
DECLARE @CurrentDate DATE = '1970-01-01';

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

    MERGE INTO SpotifyDW.dbo.Date AS Target
    USING (VALUES (
            YEAR(@CurrentDate),
            FORMAT(@CurrentDate, 'MMMM'),
            DAY(@CurrentDate),
            MONTH(@CurrentDate),
            DATENAME(WEEKDAY, @CurrentDate),
            DATEPART(WEEKDAY, @CurrentDate),
            CASE
                WHEN @IsHoliday = 1 THEN 'Free day'
                WHEN DATENAME(WEEKDAY, @CurrentDate) IN ('Saturday', 'Sunday') THEN 'Free day'
                ELSE 'Working day'
            END,
            CASE
                WHEN MONTH(@CurrentDate) IN (7, 8) THEN 'Summer holidays'
                WHEN MONTH(@CurrentDate) IN (1, 2) THEN 'Winter holidays'
                ELSE 'No holidays'
            END,
            CASE
                WHEN @IsHoliday = 1 THEN @HolidayName
                ELSE 'None'
            END
        )
    ) AS Source (Year, Month, Day, MonthNumber, DayOfWeek, DayOfWeekNumber, WorkingDay, Vacation, VacationType)
    ON Target.Year = Source.Year
        AND Target.MonthNumber = Source.MonthNumber
        AND Target.Day = Source.Day
    WHEN NOT MATCHED THEN
        INSERT (Year, Month, Day, MonthNumber, DayOfWeek, DayOfWeekNumber, WorkingDay, Vacation, VacationType)
        VALUES (Source.Year, Source.Month, Source.Day, Source.MonthNumber, Source.DayOfWeek, Source.DayOfWeekNumber, Source.WorkingDay, Source.Vacation, Source.VacationType);

    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
END;
