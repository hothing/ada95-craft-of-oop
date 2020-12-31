----------------------------------------------------------------------------
--
--   File:    je-lists.adb
--   Purpose: Linked list package (body)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Unchecked_Deallocation;
package body JE.Lists is
    procedure Delete_Item is new Ada.Unchecked_Deallocation
                                        (Item_Record, Item_Access);

    function Size (List : List_Type) return Natural is
    begin
        return List.List.Count;
    end Size;

    function First (List : List_Type) return List_Iterator is
    begin
        return (List => List.List, Current => List.List.First);
    end First;

    function Last (List : List_Type) return List_Iterator is
    begin
        return (List => List.List, Current => null);
    end Last;

    function Succ (Iterator : List_Iterator) return List_Iterator is
    begin
        if Iterator.List = null or else Iterator.Current = null then
            raise List_Error;
        else
            return (List => Iterator.List, Current => Iterator.Current.Next);
        end if;
    end Succ;

    function Pred (Iterator : List_Iterator) return List_Iterator is
    begin
        if Iterator.List = null or else
                         Iterator.Current = Iterator.List.First then
            raise List_Error;
        elsif Iterator.Current = null then
            return (List => Iterator.List, Current => Iterator.List.Last);
        else
            return (List => Iterator.List, Current => Iterator.Current.Pred);
        end if;
    end Pred;

    function Value (Iterator : List_Iterator) return Item_Type is
    begin
        if Iterator.List = null or else Iterator.Current = null then
            raise List_Error;
        else
            return Iterator.Current.Item;
        end if;
    end Value;

    procedure Delete (Iterator : in List_Iterator) is
        Item : Item_Access := Iterator.Current;
    begin
        if Iterator.List = null or else Iterator.Current = null then
            raise List_Error;
        else
            if Iterator.Current.Next = null then
                Iterator.List.Last := Iterator.Current.Pred;
            else
                Iterator.Current.Next.Pred := Iterator.Current.Pred;
            end if;

            if Iterator.Current.Pred = null then
                Iterator.List.First := Iterator.Current.Next;
            else
                Iterator.Current.Pred.Next := Iterator.Current.Next;
            end if;

            Delete_Item (Item);
            Iterator.List.Count := Iterator.List.Count - 1;
        end if;
    end Delete;

    procedure Insert (Iterator : in List_Iterator;
                      Item     : in Item_Type) is
        New_Item : Item_Access;
    begin
        if Iterator.List = null then
            raise List_Error;
        else
            New_Item := new Item_Record;
            New_Item.Next := Iterator.Current;
            New_Item.Item := Item;

            if Iterator.Current = null then
                New_Item.Pred := Iterator.List.Last;
                Iterator.List.Last := New_Item;
            else
                New_Item.Pred := Iterator.Current.Pred;
                Iterator.Current.Pred := New_Item;
            end if;

            if Iterator.Current = Iterator.List.First then
                Iterator.List.First := New_Item;
            else
                New_Item.Pred.Next := New_Item;
            end if;

            Iterator.List.Count := Iterator.List.Count + 1;
        end if;
    end Insert;
end JE.Lists;
