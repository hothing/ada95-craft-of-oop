----------------------------------------------------------------------------
--
--   File:    fact_test.adb
--   Purpose: Test program for recursive factorial function
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
procedure Fact_Test is

    function Factorial (N : Positive) return Positive is
    begin
        if N = 1 then
            return 1;
        else
            return N * Factorial(N-1);
        end if;
    end Factorial;

    N : Positive;

begin
    Put ("Enter an integer: ");
    Get (N);
    Put (N, Width=>1);
    Put ("! = ");
    Put (Factorial(N), Width=>1);
    New_Line;
end Fact_Test;
