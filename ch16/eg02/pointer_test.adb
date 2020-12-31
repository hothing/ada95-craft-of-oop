----------------------------------------------------------------------------
--
--   File:    pointer_test.adb
--   Purpose: Test program for smart pointers package
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Int_Pointers;
use  Ada.Text_IO, Int_Pointers;
procedure Pointer_Test is
    use Int_Pointers.Pointers;
    P, Q : Pointer_Type;
begin
    Put_Line ("Assigning to P");
    P := Pointer(new Integer'(123));
    Put_Line ("Assigning to Q");
    Q := Pointer(null);
    Put_Line ("Copying P to Q");
    Q := P;
    declare
        R : Pointer_Type;
    begin
        Put_Line ("Inner block -- copying P to R");
        R := P;
        Put_Line ("End of inner block");
    end;
    Put_Line ("Back in outer block -- assigning to Q");
    Q := Pointer(null);
    Put_Line ("Copying P to Q");
    Q := P;
    Put_Line ("End of program");
end Pointer_Test;
