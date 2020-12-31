----------------------------------------------------------------------------
--
--   File:    weekday.adb
--   Purpose: Get the day of the week (reporting exceptions by name)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Exceptions, Ada.Calendar, JE.Day_Of;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Exceptions;
procedure Weekday is
    Day, Month, Year : Integer;
begin
    loop
        declare
            Junk : Ada.Calendar.Time;
        begin
            Put ("Enter a date: ");
            Get (Day);
            Get (Month);
            Get (Year);
            Junk := Ada.Calendar.Time_Of (Year, Month, Day);
            exit;                                                       -- 1
        exception
            when Error : Constraint_Error | Data_Error
                       | Ada.Calendar.Time_Error =>
                Put ("The exception was ");
                Put_Line (Exception_Name(Error));                       -- 2
                Skip_Line;
        end;                                                            -- 3
    end loop;                                                           -- 4
    Put ( JE.Day_Of (Day, Month, Year) );                               -- 5
end Weekday;
