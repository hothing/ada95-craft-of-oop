----------------------------------------------------------------------------
--
--   File:    je-stacks.adb
--   Purpose: Generic stack package (body)
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
    package Lists is new JE.Lists (Item_Type);

    type Stack_Item is
        record
            L : Lists.List_Type;
        end record;

    procedure Push (Stack : in out Stack_Type;
                    Item  : in Item_Type) is
    begin
        if Stack = null then
            Stack := new Stack_Item;
        end if;
        Lists.Insert (Lists.First(Stack.L), Item);
    exception
        when Storage_Error =>
            raise Stack_Overflow;
    end Push;

    procedure Pop (Stack : in out Stack_Type;
                   Item  : out Item_Type) is
    begin
        Item := Top(Stack);
        Lists.Delete (Lists.First(Stack.L));
    exception
        when Lists.List_Error =>
            raise Stack_Underflow;
    end Pop;

    function Top (Stack : Stack_Type) return Item_Type is
    begin
        return Lists.Value(Lists.First(Stack.L));
    exception
        when Lists.List_Error =>
            raise Stack_Underflow;
    end Top;

    function Size (Stack : Stack_Type) return Natural is
    begin
        if Stack = null then
            return 0;
        else
            return Lists.Size (Stack.L);
        end if;
    end Size;

    function Empty (Stack : Stack_Type) return Boolean is
    begin
        return Size(Stack) = 0;
    end Empty;
end JE.Stacks;
