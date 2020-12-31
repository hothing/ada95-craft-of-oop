----------------------------------------------------------------------------
--
--   File:    je-stacks.ads
--   Purpose: Stack ADT (specification) using linked list implementation
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Lists;
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
    package Item_Lists is new JE.Lists (Item_Type);
    type Stack_Type is
        record
            L : Item_Lists.List_Type;
        end record;
end JE.Stacks;
