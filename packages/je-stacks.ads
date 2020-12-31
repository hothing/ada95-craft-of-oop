----------------------------------------------------------------------------
--
--   File:    je-stacks.ads
--   Purpose: Generic stack package (specification)
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
    type Stack_Item;
    type Stack_Type is access Stack_Item;

    -- Because JE.Lists defines a controlled type, it has to be instantiated
    -- here rather than in the package body:

    package Lists is new JE.Lists (Item_Type);
end JE.Stacks;
