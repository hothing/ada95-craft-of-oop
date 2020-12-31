----------------------------------------------------------------------------
--
--   File:    weekday.adb
--   Purpose: Demonstration of ragged string array using aliased strings
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

    Sun_Name : aliased constant String := "Sunday";
    Mon_Name : aliased constant String := "Monday";
    Tue_Name : aliased constant String := "Tuesday";
    Wed_Name : aliased constant String := "Wednesday";
    Thu_Name : aliased constant String := "Thursday";
    Fri_Name : aliased constant String := "Friday";
    Sat_Name : aliased constant String := "Saturday";

    type Name_Type is access constant String;
    Day_Names : constant array (0..6) of Name_Type :=
        (Sun_Name'Access, Mon_Name'Access, Tue_Name'Access, Wed_Name'Access,
         Thu_Name'Access, Fri_Name'Access, Sat_Name'Access);
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
    Put (Day_Names(((26*Month - 2)/10 + Day + Year + Year/4 + Century/4
                    - 2*Century) mod 7).all);
    Put_Line (".");
end Weekday;
