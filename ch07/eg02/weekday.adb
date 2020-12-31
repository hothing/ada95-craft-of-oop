----------------------------------------------------------------------------
--
--   File:    weekday.adb
--   Purpose: Get the day of the week (with subtypes and exception handling)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, JE.Day_Of;
use  Ada.Text_IO, Ada.Integer_Text_IO;
procedure Weekday is
    subtype Day_Type   is Integer range 1 .. 31;
    subtype Month_Type is Integer range 1 .. 12;
    subtype Year_Type  is Integer range 1901 .. 2099;
    Day   : Day_Type;
    Month : Month_Type;
    Year  : Year_Type;
begin
    Put ("Enter a date: ");
    Get (Day);
    Get (Month);
    Get (Year);
    Put ( JE.Day_Of (Day, Month, Year) );
exception
    when Constraint_Error | Data_Error =>
        Put_Line ("Invalid date!");
end Weekday;
