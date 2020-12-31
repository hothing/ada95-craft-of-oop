----------------------------------------------------------------------------
--
--   File:    date_test.adb
--   Purpose: Test program for Times package
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, JE.Times;
use  Ada.Text_IO, JE.Times;
procedure Date_Test is
    package Int_IO   is new Ada.Text_IO.Integer_IO (Integer);
    package Month_IO is new Ada.Text_IO.Enumeration_IO (Month_Type);
    use Int_IO, Month_IO;

    procedure Get (D : out Time_Type) is
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
        D := Time (Year,Month,Day);
    end Get;

    procedure Put (D : in Time_Type) is
    begin
        Put (Day(D), Width=>1);
        Put ("-");
        Put (Month(D));
        Put ("-");
        Put (Year(D), Width=>1);
    end Put;

    D : Time_Type;
begin
    Put ("Enter a date: ");
    Get (D);
    
    Put ("One week from ");
    Put (D);
    Put (" it will be ");
    Put (D + Interval(Days=>7));
    New_Line;
end Date_Test;
