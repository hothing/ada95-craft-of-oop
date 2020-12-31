----------------------------------------------------------------------------
--
--   File:    date_test.adb
--   Purpose: Test program for date ADT using deferred constant
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

    D : Date_Type := Invalid_Date;
begin
    Put ("Day = ");
    Put (Day(D));
    New_Line;
    Put ("Month = ");
    Put (Month(D));
    New_Line;
    Put ("Year = ");
    Put (Year(D));
    New_Line;
    D := Date(Day(D),Month(D),Year(D));
end Date_Test;
