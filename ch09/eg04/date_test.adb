----------------------------------------------------------------------------
--
--   File:    date_test.adb
--   Purpose: Test program for fancy date construction operators
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, JE.Dates;
use  Ada.Text_IO, JE.Dates;
procedure Date_Test is
    package Int_IO   is new Ada.Text_IO.Integer_IO (Integer);
    package Month_IO is new Ada.Text_IO.Enumeration_IO (Month_Type);
    use Int_IO, Month_IO;

    procedure Get (D : out Date_Type) is
        Day    : Day_Type;
        Month  : Month_Type;
        Year   : Year_Type;
        Filler : Character;
    begin
        Get (Day);
        Get (Filler);
        Get (Month);
        Get (Filler);
        Get (Year);
        D := Date (Day,Month,Year);
    end Get;

    procedure Put (D : in Date_Type) is
    begin
        Put (Day(D), Width=>1);
        Put ("-");
        Put (Month(D));
        Put ("-");
        Put (Year(D), Width=>1);
    end Put;

    D1 : Date_Type;
    D2 : Date_Type := 25-Dec-1995;
begin
    Put ("Enter a date: ");
    Get (D1);
    
    Put (D1);
    Put (" is ");
    if D1 > D2 then
        Put ("greater than ");
    elsif D1 <= D2 then
        Put ("not greater than ");
    end if;
    Put (D2);
    New_Line;

    Put (D1);
    Put (" is ");
    if D1 < D2 then
        Put ("less than ");
    elsif D1 >= D2 then
        Put ("not less than ");
    end if;
    Put (D2);
    New_Line;

    Put (D1);
    Put (" is ");
    if D1 = D2 then
        Put ("equal to ");
    elsif D1 /= D2 then
        Put ("not equal to ");
    end if;
    Put (D2);
    New_Line;
end Date_Test;
