----------------------------------------------------------------------------
--
--   File:    greetings.adb
--   Purpose: Display a greeting using current time
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Calendar;     use Ada.Text_IO;
procedure Greetings is
begin
    if Ada.Calendar.Seconds (Ada.Calendar.Clock) <= 43200.0 then
        Put_Line ("Good morning!");
    else
        Put_Line ("Good afternoon!");
    end if;
end Greetings;
