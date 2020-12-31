----------------------------------------------------------------------------
--
--   File:    weekday.adb
--   Purpose: Use library function to get the day of the week
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, Day_Of;
use  Ada.Text_IO, Ada.Integer_Text_IO;
procedure Weekday is
    Day, Month, Year : Integer;
begin
    Put ("Enter a date: ");
    Get (Day);
    Get (Month);
    Get (Year);
    Put ( Day_Of (Day, Month, Year) );
end Weekday;
