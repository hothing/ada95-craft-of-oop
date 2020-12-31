----------------------------------------------------------------------------
--
--   File:    weekday.adb
--   Purpose: Get the day of the week using Dates package
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, JE.Dates;
use  Ada.Text_IO, Ada.Integer_Text_IO;
procedure Weekday is
    package Month_IO is new Enumeration_IO (JE.Dates.Month_Type);
    package Day_IO   is new Enumeration_IO (JE.Dates.Weekday_Type);
    use Month_IO, Day_IO;
    Date : JE.Dates.Date_Type;
begin
    Put ("Enter a date: ");
    Get (Date.Day);
    Get (Date.Month);
    Get (Date.Year);
    if JE.Dates.Valid_Date(Date) then
        Put (JE.Dates.Day_Of (Date));
    else
        Put_Line ("Invalid date!");
    end if;
end Weekday;
