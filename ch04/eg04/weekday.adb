----------------------------------------------------------------------------
--
--   File:    weekday.adb
--   Purpose: Get the day of the week (using separate compilation)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Calendar;
use  Ada.Text_IO, Ada.Integer_Text_IO;
procedure Weekday is
    Day, Month, Year : Integer;

    function Day_Of (Day, Month, Year : Integer) return Integer
            is separate;

begin
    Put ("Enter a date: ");
    Get (Day);
    Get (Month);
    Get (Year);
    Put ( Day_Of (Day,Month,Year) );
end Weekday;
