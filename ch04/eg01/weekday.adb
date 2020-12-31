----------------------------------------------------------------------------
--
--   File:    weekday.adb
--   Purpose: Get the day of the week using Zeller's Congruence
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO;
use  Ada.Text_IO, Ada.Integer_Text_IO;
procedure Weekday is
    Day     : Integer;
    Month   : Integer;
    Year    : Integer;
    Century : Integer;
begin
    Put ("Enter a date: ");
    Get (Day);
    Get (Month);
    Get (Year);
    if Month < 3 then
        Year := Year - 1;
        Month := Month + 10;
    else
        Month := Month - 2;
    end if;
    Century := Year / 100;      -- first two digits of Year
    Year := Year mod 100;       -- last two digits of Year
    Put (((26*Month - 2)/10 + Day + Year + Year/4 + Century/4 - 2*Century)
            mod 7);
end Weekday;
