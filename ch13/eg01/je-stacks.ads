----------------------------------------------------------------------------
--
--   File:    je-stacks.ads
--   Purpose: Stack ADT (specification) using array implementation
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

generic
    type Item_Type is private;
package JE.Stacks is
    type Stack_Type is limited private;

    procedure Push  (Stack : in out Stack_Type;
                     Item  : in Item_Type);
    procedure Pop   (Stack : in out Stack_Type;
                     Item  : out Item_Type);

    function  Top   (Stack : Stack_Type) return Item_Type;
    function  Size  (Stack : Stack_Type) return Natural;
    function  Empty (Stack : Stack_Type) return Boolean;

    Stack_Overflow, Stack_Underflow : exception;

private
    Max_Items : constant := 100;    -- arbitrary maximum stack size
    type    Stack_Array   is array (1..Max_Items) of Item_Type;
    subtype Stack_Pointer is Natural range 0..Max_Items;
    type    Stack_Type    is
        record
            Value : Stack_Array;
            Top   : Stack_Pointer := 0;
        end record;
end JE.Stacks;
