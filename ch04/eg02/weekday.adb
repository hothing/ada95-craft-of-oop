----------------------------------------------------------------------------
--
--   File:    weekday.adb
--   Purpose: Get the day of the week (using an internal procedure)
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
    Day, Month, Year, Which : Integer;                         -- 1

    procedure Day_Of (Day, Month, Year : in Integer;
                    Result : out Integer) is
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
        C := Y / 100;           -- first two digits of Year
        Y := Y mod 100;     -- last two digits of Year
        Result := ((26*M - 2)/10 + Day + Y + Y/4 + C/4 - 2*C) mod 7;
    end Day_Of;

begin       -- main program
    Put ("Enter a date: ");
    Get (Day);
    Get (Month);
    Get (Year);
    Day_Of (Day, Month, Year, Which);
    Put (Which);
end Weekday;
