----------------------------------------------------------------------------
--
--   File:    je-stacks.adb
--   Purpose: Stack ADT (body) using opaque type; array implementation
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package body JE.Stacks is
    Max_Items : constant := 100;    -- arbitrary maximum stack size

    type    Stack_Array   is array (1..Max_Items) of Item_Type;
    subtype Stack_Pointer is Natural range 0..Max_Items;
    type    Stack_Item    is
        record
            Value : Stack_Array;
            Top  : Stack_Pointer := 0;
        end record;

    procedure Push (Stack : in out Stack_Type;
                    Item  : in Item_Type) is
    begin
        if Stack = null then
            Stack := new Stack_Item;
        end if;
        Stack.Top := Stack.Top + 1;
        Stack.Value(Stack.Top) := Item;
    exception
        when Storage_Error | Constraint_Error =>
            raise Stack_Overflow;
    end Push;

    procedure Pop (Stack : in out Stack_Type;
                   Item  : out Item_Type) is
    begin
        Item := Top(Stack);
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
        if Stack = null then
            return 0;
        else
            return Stack.Top;
        end if;
    end Size;

    function Empty (Stack : Stack_Type) return Boolean is
    begin
        return Size(Stack) = 0;
    end Empty;
end JE.Stacks;
