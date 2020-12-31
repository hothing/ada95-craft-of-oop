----------------------------------------------------------------------------
--
--   File:    je-stacks.adb
--   Purpose: Stack ADT (body) using linked list implementation
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Lists;
package body JE.Stacks is
    package ILP renames Item_Lists;

    procedure Push (Stack : in out Stack_Type;
                    Item  : in Item_Type) is
    begin
        ILP.Insert (ILP.First(Stack.L), Item);
    exception
        when Storage_Error =>
            raise Stack_Overflow;
    end Push;

    procedure Pop (Stack : in out Stack_Type;
                   Item  : out Item_Type) is
    begin
        Item := Top(Stack);
        ILP.Delete (ILP.First(Stack.L));
    exception
        when ILP.List_Error =>
            raise Stack_Underflow;
    end Pop;

    function Top (Stack : Stack_Type) return Item_Type is
    begin
        return ILP.Value(ILP.First(Stack.L));
    exception
        when ILP.List_Error =>
            raise Stack_Underflow;
    end Top;

    function Size (Stack : Stack_Type) return Natural is
    begin
        return ILP.Size(Stack.L);
    end Size;

    function Empty (Stack : Stack_Type) return Boolean is
    begin
        return Size(Stack) = 0;
    end Empty;
end JE.Stacks;
