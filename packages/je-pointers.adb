----------------------------------------------------------------------------
--
--   File:    je-pointers.adb
--   Purpose: Generic "smart pointers" package (body)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Unchecked_Deallocation;
package body JE.Pointers is
    procedure Delete_Item is
                new Ada.Unchecked_Deallocation (Item_Type, Access_Type);
    procedure Delete_Pointer is
                new Ada.Unchecked_Deallocation (Reference_Counted_Object,
                                                Reference_Counted_Pointer);

    function Pointer (Value : Access_Type) return Pointer_Type is
        Object : Pointer_Type;
    begin
        if Object.Pointer /= null then
            Delete_Item (Object.Pointer.Value);
        else
            Object.Pointer := new Reference_Counted_Object;
        end if;
        Object.Pointer.all := (Value => Value, Count => 1);
        return Object;
    end Pointer;

    function Value (Pointer : Pointer_Type) return Access_Type is
    begin
        if Pointer.Pointer = null then
            return null;
        else
            return Pointer.Pointer.Value;
        end if;
    end Value;

    procedure Finalize (Object : in out Pointer_Type) is
    begin
        if Object.Pointer /= null then
            Object.Pointer.Count := Object.Pointer.Count - 1;
            if Object.Pointer.Count = 0 then
                Delete_Item (Object.Pointer.Value);
                Delete_Pointer (Object.Pointer);
            end if;
        end if;
    end Finalize;

    procedure Adjust (Object : in out Pointer_Type) is
    begin
        if Object.Pointer /= null then
            Object.Pointer.Count := Object.Pointer.Count + 1;   
        end if;
    end Adjust;
end JE.Pointers;
