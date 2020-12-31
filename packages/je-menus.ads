----------------------------------------------------------------------------
--
--   File:    je-menus.ads
--   Purpose: Generic menu package (specification)
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
package JE.Menus is
    type Action_Type is access procedure;
    type Menu_Type   is limited private;

    procedure Add     (Menu   : in out Menu_Type;
                       Title  : in String;
                       Key    : in Character;
                       Action : in Action_Type);
    function  Execute (Menu   : Menu_Type) return Boolean;

private
    type Menu_Item_Type is
        record
            Title  : String (1..40);
            Length : Natural;
            Choice : Character;
            Action : Action_Type;
        end record;

    package Menu_Lists is new JE.Lists (Menu_Item_Type);
    
    type Menu_Type is
        limited record
            Menu_List : Menu_Lists.List_Type;
        end record;
end JE.Menus;
