----------------------------------------------------------------------------
--
--   File:    sum.adb
--   Purpose: Add two integers together and display their sum
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO;          --  1
use  Ada.Text_IO, Ada.Integer_Text_IO;          --  2
procedure Sum is
    First, Second : Integer;                    --  3
begin
    Put ("Enter two integers: ");               --  4
    Get (First);                                --  5
    Get (Second);                               --  6
    Put ("The sum is");                         --  7
    Put (First + Second);                       --  8
    New_Line;                                   --  9
end Sum;
