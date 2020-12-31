----------------------------------------------------------------------------
--
--   File:    je-diaries.adb
--   Purpose: Diary ADT (body) using linked list
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Sequential_IO, Ada.Unchecked_Deallocation, JE.Times;
package body JE.Diaries is
    package   Appt_IO     is new Ada.Sequential_IO (Appointment_Type);
    procedure Delete_Appt is new Ada.Unchecked_Deallocation
                                    (Appointment_Record, Appointment_Access);

    function First (Diary : Diary_Type) return Diary_Iterator is
    begin
        return (List => Diary.List, Current => Diary.List.First);
    end First;

    function Last (Diary : Diary_Type) return Diary_Iterator is
    begin
        return (List => Diary.List, Current => null);
    end Last;

    function Succ (Iterator : Diary_Iterator) return Diary_Iterator is
    begin
        if Iterator.List = null or else Iterator.Current = null then
            raise Diary_Error;
        else
            return (List => Iterator.List, Current => Iterator.Current.Next);
        end if;
    end Succ;

    function Pred (Iterator : Diary_Iterator) return Diary_Iterator is
    begin
        if Iterator.List = null or else
                           Iterator.Current = Iterator.List.First then
            raise Diary_Error;
        elsif Iterator.Current = null then
            return (List => Iterator.List, Current => Iterator.List.Last);
        else
            return (List => Iterator.List, Current => Iterator.Current.Pred);
        end if;
    end Pred;

    function Value (Iterator : Diary_Iterator) return Appointment_Type is
    begin
        if Iterator.List = null or else Iterator.Current = null then
            raise Diary_Error;
        else
            return Iterator.Current.Appt;
        end if;
    end Value;

    procedure Delete (Iterator : in Diary_Iterator) is
        Appt : Appointment_Access := Iterator.Current;
    begin
        if Iterator.List = null or else Iterator.Current = null then
            raise Diary_Error;
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

            Delete_Appt (Appt);
            Iterator.List.Count := Iterator.List.Count - 1;
        end if;
    end Delete;

    procedure Insert (Iterator : in Diary_Iterator;
                      Appt     : in Appointment_Type) is
        New_Appt : Appointment_Access;
    begin
        if Iterator.List = null then
            raise Diary_Error;
        else
            New_Appt := new Appointment_Record;
            New_Appt.Next := Iterator.Current;
            New_Appt.Appt := Appt;

            if Iterator.Current = null then
                New_Appt.Pred := Iterator.List.Last;
                Iterator.List.Last := New_Appt;
            else
                New_Appt.Pred := Iterator.Current.Pred;
                Iterator.Current.Pred := New_Appt;
            end if;

            if Iterator.Current = Iterator.List.First then
                Iterator.List.First := New_Appt;
            else
                New_Appt.Pred.Next := New_Appt;
            end if;

            Iterator.List.Count := Iterator.List.Count + 1;
        end if;
    end Insert;

    function Size (Diary : Diary_Type) return Natural is
    begin
        return Diary.List.Count;
    end Size;

    function Choose (Diary : Diary_Type;
                     Appt  : Positive) return Appointment_Type is
        Iterator : Diary_Iterator;
    begin
        if Appt not in 1 .. Size(Diary) then
            raise Diary_Error;
        else
            Iterator := First(Diary);
            for I in 2 .. Appt loop
                Iterator := Succ(Iterator);
            end loop;
            return Value(Iterator);
        end if;
    end Choose;

    procedure Delete (Diary : in out Diary_Type;
                      Appt  : in Positive) is
        Iterator : Diary_Iterator;
    begin
        if Appt not in 1 .. Size(Diary) then
            raise Diary_Error;
        else
            Iterator := First(Diary);
            for I in 2 .. Appt loop
                Iterator := Succ(Iterator);
            end loop;
            Delete (Iterator);
        end if;
    end Delete;

    procedure Add (Diary : in out Diary_Type;
                   Appt  : in Appointment_Type) is
        use type JE.Times.Time_Type;        -- to allow use of ">"
        Iterator : Diary_Iterator;
    begin
        Iterator := First(Diary);
        while Iterator /= Last(Diary) loop
            exit when Date(Value(Iterator)) > Date(Appt);
            Iterator := Succ(Iterator);
        end loop;
        Insert (Iterator, Appt);
    exception
        when Storage_Error =>
            raise Diary_Error;
    end Add;

    procedure Load (Diary : in out Diary_Type;
                    From  : in String) is
        File : Appt_IO.File_Type;
        Appt : Appointment_Type;
    begin
        while First(Diary) /= Last(Diary) loop
            Delete (First(Diary));
        end loop;
        Appt_IO.Open (File, Name => From, Mode => Appt_IO.In_File);
        while not Appt_IO.End_Of_File(File) loop
            Appt_IO.Read (File, Appt);
            Insert (Last(Diary), Appt);
        end loop;
        Appt_IO.Close (File);
    exception
        when Appt_IO.Name_Error =>
            raise Diary_Error;
    end Load;

    procedure Save (Diary : in Diary_Type;
                    To    : in String) is
        File : Appt_IO.File_Type;
        I : Diary_Iterator := First(Diary);
    begin
        Appt_IO.Create (File, Name => To);
        while I /= Last(Diary) loop
            Appt_IO.Write (File, Value(I));
            I := Succ(I);
        end loop;
        Appt_IO.Close (File);
    end Save;

end JE.Diaries;
