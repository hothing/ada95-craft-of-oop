----------------------------------------------------------------------------
--
--   File:    je-dates.adb
--   Purpose: Dates package (body) using a record type
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package body JE.Dates is
    function Day_Of (Date : Date_Type) return Weekday_Type is
        D : Integer := Date.Day;
        M : Integer := Month_Type'Pos (Date.Month) + 1;
        Y : Integer := Date.Year;
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
        return Weekday_Type'Val (((26*M - 2)/10 + D + Y + Y/4 + C/4 - 2*C)
                                 mod 7);
    end Day_Of;

    function Month_Length (Month : Month_Type) return Integer is
    begin
        case Month is
            when Feb =>
                return 28;
            when Apr | Jun | Sep | Nov =>
                return 30;
            when others =>
                return 31;
        end case;
    end Month_Length;

    function Valid_Date (Date : Date_Type) return Boolean is
    begin
        if Date.Year < 1901 or Date.Year > 2099 or Date.Day < 1 then
            return False;
        elsif Date.Month = Feb and Date.Year mod 4 = 0 then
            return Date.Day <= 29;
        else
            return Date.Day <= Month_Length (Date.Month);
        end if;
    end Valid_Date;
end JE.Dates;
