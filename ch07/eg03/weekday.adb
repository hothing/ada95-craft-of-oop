----------------------------------------------------------------------------
--
--   File:    weekday.adb
--   Purpose: Get the day of the week (using Ada.Calendar to validate date)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Calendar, JE.Day_Of;
use  Ada.Text_IO, Ada.Integer_Text_IO;
procedure Weekday is
    Day, Month, Year : Integer;
    Junk : Ada.Calendar.Time;
begin
    Put ("Enter a date: ");
    Get (Day);
    Get (Month);
    Get (Year);
    Junk := Ada.Calendar.Time_Of (Year, Month, Day);
    Put ( JE.Day_Of (Day, Month, Year) );
exception
    when Constraint_Error | Data_Error | Ada.Calendar.Time_Error =>
        Put_Line ("Invalid date!");
end Weekday;
