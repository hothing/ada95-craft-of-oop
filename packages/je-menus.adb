----------------------------------------------------------------------------
--
--   File:    je-menus.adb
--   Purpose: Generic menu package (body)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Characters.Handling;
use  Ada.Text_IO;
package body JE.Menus is
    use Menu_Lists;

    procedure Add (Menu   : in out Menu_Type;
                   Title  : in String;
                   Key    : in Character;
                   Action : in Action_Type) is
        Item : Menu_Item_Type;
        use Menu_Lists;
    begin
        if Title'Length > Item.Title'Length then
            Item.Title  := Title (Title'First .. Item.Title'Length-Title'First+1);
            Item.Length := Item.Title'Length;
        else
            Item.Title (Item.Title'First .. Title'Length-Item.Title'First+1)
                                                                    := Title;
            Item.Length := Title'Length;
        end if;

        Item.Choice := Ada.Characters.Handling.To_Upper(Key);
        Item.Action := Action;
        Insert( Last(Menu.Menu_List), Item );
    end Add;

    function Execute (Menu : Menu_Type) return Boolean is
        Item   : Menu_Item_Type;
        Choice : Character;
        I : List_Iterator;
    begin
        loop
            New_Line (3);

            -- Display the menu
            I := First(Menu.Menu_List);
            while I /= Last(Menu.Menu_List) loop
                Item := Value(I);
                Put ("   [");
                Put (Item.Choice);
                Put ("] ");
                Put_Line (Item.Title(1..Item.Length));
                I := Succ(I);
            end loop;

            -- Display the Quit option and prompt
            Put_Line ("   [Q] Quit");
            Put ("Enter your choice: ");

            -- Get user's choice in upper case
            Get (Choice);
            Choice := Ada.Characters.Handling.To_Upper(Choice);

            if Choice = 'Q' then
                -- Quit chosen, so return
                return False;
            else
                -- Search menu for choice
                I := First(Menu.Menu_List);
                while I /= Last(Menu.Menu_List) loop
                    if Choice = Value(I).Choice then
                        -- Choice found, so call procedure and return
                        Value(I).Action.all;
                        return True;
                    end if;
                    I := Succ(I);
                end loop;
            end if;

            -- Choice wasn't found, so display error message and loop
            Put_Line ("Invalid choice -- please try again.");
        end loop;
    end Execute;
end JE.Menus;
