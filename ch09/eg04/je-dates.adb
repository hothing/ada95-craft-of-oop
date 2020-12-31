----------------------------------------------------------------------------
--
--   File:    je-dates.adb
--   Purpose: Date package (body) with fancy construction operators
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package body JE.Dates is
    procedure Validate (Day   : in Day_Type;
                        Month : in Month_Type;
                        Year  : in Year_Type) is
    begin
        case Month is
            when Apr | Jun | Sep | Nov =>
                if Day > 30 then
                    raise Date_Error;
                end if;
            when Feb =>
                if (Year mod 4 = 0 and Day > 29) or
                                                (Year mod 4 /= 0 and Day > 28) then
                    raise Date_Error;
                end if;
            when others =>
                null;
        end case;
    end Validate;

    function Date (Day   : Day_Type;
                   Month : Month_Type;
                   Year  : Year_Type) return Date_Type is
        D : Date_Type := (Day, Month, Year);
    begin
        Validate (Day, Month, Year);
        return D;
    end Date;

    function Day (Date : Date_Type) return Day_Type is
    begin
        return Date.Day;
    end Day;

    function Month (Date : Date_Type) return Month_Type is
    begin
        return Date.Month;
    end Month;

    function Year (Date : Date_Type) return Year_Type is
    begin
        return Date.Year;
    end Year;

    function Weekday (Date : Date_Type) return Weekday_Type is
        D : Integer := Date.Day;
        M : Integer := Month_Type'Pos(Date.Month) + 1;
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
        return Weekday_Type'Val(((26*M - 2)/10 + D + Y + Y/4 + C/4 - 2*C)
                                mod 7);
    end Weekday;

    function "<"  (Left, Right : Date_Type) return Boolean is
    begin
        if Left.Year /= Right.Year then
            return Left.Year < Right.Year;
        elsif Left.Month /= Right.Month then
            return Left.Month < Right.Month;
        else
            return Left.Day < Right.Day;
        end if;
    end "<";

    function ">"  (Left, Right : Date_Type) return Boolean is
    begin
        return Right < Left;
    end ">";

    function "<=" (Left, Right : Date_Type) return Boolean is
    begin
        return not (Left > Right);
    end "<=";

    function ">=" (Left, Right : Date_Type) return Boolean is
    begin
        return not (Left < Right);
    end ">=";

    function "-" (Left : Day_Type; Right : Month_Type) return Day_And_Month is
        Result : Day_And_Month := (Day=>Left, Month=>Right);
    begin
        return Result;
    end "-";

    function "-" (Left : Day_And_Month; Right : Year_Type) return Date_Type is
        Result : Date_Type := (Day=>Left.Day, Month=>Left.Month, Year=>Right);
    begin
        return Result;
    end "-";
end JE.Dates;
