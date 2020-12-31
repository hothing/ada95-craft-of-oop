----------------------------------------------------------------------------
--
--   File:    sort.adb
--   Purpose: Demonstration of generic shuffle sort procedure
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

    -- Generic procedure specification
    generic
        type Item_Type  is private;
        type Index_Type is (<>);
        type Array_Type is array (Index_Type range <>) of Item_Type;
        with function "<" (Left, Right : Item_Type) return Boolean is <>;
    procedure Generic_Sort (X : in out Array_Type);

    -- Procedure definition
    procedure Generic_Sort (X : in out Array_Type) is
        Position : Index_Type;
        Value    : Item_Type;
    begin
        for I in Index_Type'Succ(X'First)..X'Last loop
            if X(I) < X(Index_Type'Pred(I)) then
                Value := X(I);
                for J in reverse X'First .. Index_Type'Pred(I) loop
                    exit when X(J) < Value;
                    Position := J;
                end loop;
                X(Index_Type'Succ(Position)..I) := X(Position..Index_Type'Pred(I));
                X(Position) := Value;
            end if;
        end loop;
    end Generic_Sort;

    procedure Shuffle_Sort is new Generic_Sort (Item_Type  => Integer,
                                                Index_Type => Positive,
                                                Array_Type => Array_Type);
    procedure Reverse_Sort is new Generic_Sort (Item_Type  => Integer,
                                                Index_Type => Positive,
                                                Array_Type => Array_Type,
                                                "<"        => ">");

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
        Put (A(I), Width=>1);
        Put (" ");
    end loop;
    New_Line;

    Reverse_Sort (A);
    Put ("Reversed result: ");
    for I in A'Range loop
        Put (A(I), Width=>1);
        Put (" ");
    end loop;
    New_Line;
end Sort;
