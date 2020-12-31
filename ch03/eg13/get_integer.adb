----------------------------------------------------------------------------
--
--   File:    get_integer.adb
--   Purpose: Get an integer safely (using exception handling)
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
procedure Get_Integer is
    X : Integer;
begin
    loop
        begin
            Put ("Enter an integer: ");
            Get (X);
            exit;
        exception
            when Constraint_Error | Data_Error =>
                Put_Line ("Error in input -- please try again.");
                Skip_Line;
        end;
    end loop;

    Put ("The value entered was ");
    Put (X, Width=>1);
    New_Line;
end Get_Integer;
