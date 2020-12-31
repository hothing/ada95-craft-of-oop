----------------------------------------------------------------------------
--
--   File:    calculator.adb
--   Purpose: Evaluate a two-term expression
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
procedure Calculator is
    First, Second : Integer;
    Operator      : Character;
begin
    Put ("Enter an expression: ");
    Get (First);
    Get (Operator);
    Get (Second);
    case Operator is
        when '+' =>
            Put (First + Second, Width => 1);
        when '-' =>
            Put (First - Second, Width => 1);
        when '*' =>
            Put (First * Second, Width => 1);
        when '/' =>
            Put (First / Second, Width => 1);
        when others =>
            Put ("Invalid operator '");
            Put (Operator);
            Put ("'");
    end case;
    New_Line;
end Calculator;
