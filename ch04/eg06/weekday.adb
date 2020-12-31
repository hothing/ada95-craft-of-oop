----------------------------------------------------------------------------
--
--   File:    weekday.adb
--   Purpose: Get the day of the week (using dates package)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, Dates;
use  Ada.Text_IO, Ada.Integer_Text_IO;
procedure Weekday is
    Day, Month, Year : Integer;
begin
    Put ("Enter a date: ");
    Get (Day);
    Get (Month);
    Get (Year);
    if Dates.Valid_Date(Day,Month,Year) then
        Put (Dates.Day_Of (Day, Month, Year));
    else
        Put_Line ("Invalid date!");
    end if;
end Weekday;
