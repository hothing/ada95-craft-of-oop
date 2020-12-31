----------------------------------------------------------------------------
--
--   File:    je-stacks.adb
--   Purpose: Stack ADT (body) using array implementation
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package body JE.Stacks is
    procedure Push (Stack : in out Stack_Type;
                    Item  : in Item_Type) is
    begin
        Stack.Top := Stack.Top + 1;
        Stack.Value(Stack.Top) := Item;
    exception
        when Constraint_Error =>
            raise Stack_Overflow;
    end Push;

    procedure Pop (Stack : in out Stack_Type;
                   Item  : out Item_Type) is
    begin
        Item := Stack.Value(Stack.Top);
        Stack.Top := Stack.Top - 1;
    exception
        when Constraint_Error =>
            raise Stack_Underflow;
    end Pop;

    function Top (Stack : Stack_Type) return Item_Type is
    begin
        return Stack.Value(Stack.Top);
    exception
        when Constraint_Error =>
            raise Stack_Underflow;
    end Top;

    function Size (Stack : Stack_Type) return Natural is
    begin
        return Stack.Top;
    end Size;

    function Empty (Stack : Stack_Type) return Boolean is
    begin
        return Size(Stack) = 0;
    end Empty;
end JE.Stacks;
