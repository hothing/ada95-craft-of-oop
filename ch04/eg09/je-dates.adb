----------------------------------------------------------------------------
--
--   File:    je-dates.adb
--   Purpose: Date-handling package (body) as a child of JE
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package body JE.Dates is
    function Day_Of (Day, Month, Year : Integer) return Integer is
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
        return (((26*M - 2)/10 + D + Y + Y/4 + C/4 - 2*C) mod 7);
    end Day_Of;

    function Month_Length (Month : Integer) return Integer is
    begin
        case Month is
            when 2 =>
                return 28;
            when 4 | 6 | 9 | 11 =>
                return 30;
            when 1 | 3 | 5 | 7 | 8 | 10 | 12 =>
                return 31;
            when others =>
                return 0;
        end case;
    end Month_Length;

    function Valid_Date (Day, Month, Year : Integer) return Boolean is
    begin
        if Year < 1901 or Year > 2099 or Day < 1 then
            return False;
        elsif Month = 2 and Year mod 4 = 0 then
            return Day <= 29;
        else
            return Day <= Month_Length (Month);
        end if;
    end Valid_Date;
end JE.Dates;
