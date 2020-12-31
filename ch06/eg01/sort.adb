----------------------------------------------------------------------------
--
--   File:    sort.adb
--   Purpose: Sort an array of integers (shuffle sort)
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
procedure Sort is
    type Array_Type is array (Positive range <>) of Integer;
    A : Array_Type (1..10);

    procedure Shuffle_Sort (X : in out Array_Type) is
        Position : Positive;
        Value    : Integer;
    begin
        for I in X'First+1 .. X'Last loop
            if X(I) < X(I-1) then
                -- Misplaced item found: copy it
                Value := X(I);

                -- Scan backwards until correct position found
                for J in reverse X'First .. I-1 loop
                    exit when X(J) < Value;
                    Position := J;
                end loop;

                -- Move intervening values along and slot in saved copy of item
                X(Position+1 .. I) := X(Position .. I-1);
                X(Position) := Value;
            end if;
        end loop;
    end Shuffle_Sort;

begin   -- main program
    Put_Line ("Enter 10 integers:");
    for I in A'Range loop
        Put (I, Width=>1);
        Put (": ");
        Get (A(I));
    end loop;
    Shuffle_Sort (A);
    Put ("Sorted result: ");
    for I in A'Range loop
        Put (A(I));
    end loop;
end Sort;
