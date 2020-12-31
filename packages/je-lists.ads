----------------------------------------------------------------------------
--
--   File:    je-lists.ads
--   Purpose: Doubly linked list package (specification)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Finalization;
use  Ada.Finalization;
generic
    type Item_Type is private;
package JE.Lists is
    type List_Type is new Limited_Controlled with private;
    type List_Iterator is private;

    function  Size   (List     : List_Type)     return Natural;
    function  First  (List     : List_Type)     return List_Iterator;
    function  Last   (List     : List_Type)     return List_Iterator;
    function  Succ   (Iterator : List_Iterator) return List_Iterator;
    function  Pred   (Iterator : List_Iterator) return List_Iterator;
    function  Value  (Iterator : List_Iterator) return Item_Type;
    procedure Insert (Iterator : in List_Iterator;
                      Item     : in Item_Type);
    procedure Delete (Iterator : in List_Iterator);

    List_Error : exception;
private
    type Item_Record;
    type Item_Access is access Item_Record;

    type Item_Record is
        record
            Item : Item_Type;
            Next : Item_Access;
            Pred : Item_Access;
        end record;

    type List_Header is
        record
            First : Item_Access;
            Last  : Item_Access;
            Count : Natural := 0;
        end record;

    type List_Access is access List_Header;

    type List_Type is new Limited_Controlled with
        record
            List : List_Access := new List_Header;
        end record;

    procedure Finalize (Object : in out List_Type);
    
    type List_Iterator is
        record
            List    : List_Access;
            Current : Item_Access;
        end record;
end JE.Lists;
