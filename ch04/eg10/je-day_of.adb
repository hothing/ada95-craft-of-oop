----------------------------------------------------------------------------
--
--   File:    je-day_of.adb
--   Purpose: Get the day of the week (child function of JE)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

function JE.Day_Of (Day, Month, Year : Integer) return Integer is
    D : Integer := Day;
    M : Integer := Month;
    Y : Integer := Year;
    C : Integer;
begin
    if M < 3 then
        Y := Y - 1;
        M := M + 10;
    else
        M := M - 2;
    end if;
    C := Y / 100;       -- first two digits of Year
    Y := Y mod 100;     -- last two digits of Year
    return ((26*M - 2)/10 + D + Y + Y/4 + C/4 - 2*C) mod 7;
end JE.Day_Of;
