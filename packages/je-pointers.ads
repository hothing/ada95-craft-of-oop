----------------------------------------------------------------------------
--
--   File:    je-pointers.ads
--   Purpose: Generic "smart pointers" package (specification)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Finalization;
generic
    type Item_Type(<>) is limited private;
    type Access_Type   is access Item_Type;
package JE.Pointers is
    type Pointer_Type is private;

    function Pointer (Value   : Access_Type)  return Pointer_Type;
    function Value   (Pointer : Pointer_Type) return Access_Type;

private
    type Reference_Counted_Object is
        record
            Value : Access_Type;
            Count : Natural;
        end record;
    type Reference_Counted_Pointer is access Reference_Counted_Object;

    type Pointer_Type is new Ada.Finalization.Controlled with
        record
            Pointer : Reference_Counted_Pointer;
        end record;

    procedure Finalize (Object : in out Pointer_Type);
    procedure Adjust   (Object : in out Pointer_Type);
end JE.Pointers;

