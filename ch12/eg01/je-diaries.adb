----------------------------------------------------------------------------
--
--   File:    je-diaries.adb
--   Purpose: Diary ADT (body) using generic linked list package
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Sequential_IO, JE.Times;
package body JE.Diaries is
    package Appt_IO is new Ada.Sequential_IO (Appointment_Type);

    function Size (Diary : Diary_Type) return Natural is
    begin
        return Lists.Size(Diary.List);
    end Size;

    function Choose (Diary : Diary_Type;
                     Appt  : Positive) return Appointment_Type is
        Iterator : Lists.List_Iterator;
    begin
        if Appt not in 1 .. Lists.Size(Diary.List) then
            raise Diary_Error;
        else
            Iterator := Lists.First(Diary.List);
            for I in 2 .. Appt loop
                Iterator := Lists.Succ(Iterator);
            end loop;
            return Lists.Value(Iterator);
        end if;
    end Choose;

    procedure Delete (Diary : in out Diary_Type;
                      Appt  : in Positive) is
        Iterator : Lists.List_Iterator;
    begin
        if Appt not in 1 .. Lists.Size(Diary.List) then
            raise Diary_Error;
        else
            Iterator := Lists.First(Diary.List);
            for I in 2 .. Appt loop
                Iterator := Lists.Succ(Iterator);
            end loop;
            Lists.Delete (Iterator);
        end if;
    end Delete;

    procedure Add (Diary : in out Diary_Type;
                   Appt  : in Appointment_Type) is
        use type JE.Times.Time_Type;        -- to allow use of ">"
        use type Lists.List_Iterator;       -- to allow use of "/="
        Iterator : Lists.List_Iterator;
    begin
        Iterator := Lists.First(Diary.List);
        while Iterator /= Lists.Last(Diary.List) loop
            exit when Date(Lists.Value(Iterator)) > Date(Appt);
            Iterator := Lists.Succ(Iterator);
        end loop;
        Lists.Insert (Iterator, Appt);
    exception
        when Storage_Error =>
            raise Diary_Error;
    end Add;

    procedure Load (Diary : in out Diary_Type;
                    From  : in String) is
        File : Appt_IO.File_Type;
        Appt : Appointment_Type;
    begin
        while Lists.Size(Diary.List) > 0 loop
            Lists.Delete (Lists.First(Diary.List));
        end loop;
        Appt_IO.Open (File, Name => From, Mode => Appt_IO.In_File);
        while not Appt_IO.End_Of_File(File) loop
            Appt_IO.Read (File, Appt);
            Lists.Insert (Lists.Last(Diary.List), Appt);
        end loop;
        Appt_IO.Close (File);
    exception
        when Appt_IO.Name_Error =>
            raise Diary_Error;
    end Load;

    procedure Save (Diary : in Diary_Type;
                    To    : in String) is
        use type Lists.List_Iterator;       -- to allow use of "/="
        File : Appt_IO.File_Type;
        I : Lists.List_Iterator := Lists.First(Diary.List);
    begin
        Appt_IO.Create (File, Name => To);
        while I /= Lists.Last(Diary.List) loop
            Appt_IO.Write (File, Lists.Value(I));
            I := Lists.Succ(I);
        end loop;
        Appt_IO.Close (File);
    end Save;

end JE.Diaries;
