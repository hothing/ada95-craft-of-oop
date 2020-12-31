----------------------------------------------------------------------------
--
--   File:    greetings.adb
--   Purpose: Display a greeting using current time (with constants)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Calendar;
use  Ada.Text_IO, Ada.Calendar;
procedure Greetings is
    Minute : constant := 60;
    Hour   : constant := 60 * Minute;

    Noon   : constant Day_Duration := Day_Duration (12 * Hour);
    Now    : constant Day_Duration := Seconds (Clock);

begin
    if Now <= Noon then
        Put_Line ("Good morning!");
    else
        Put_Line ("Good afternoon!");
    end if;
end Greetings;
