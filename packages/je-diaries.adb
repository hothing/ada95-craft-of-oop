----------------------------------------------------------------------------
--
--   File:    je-diaries.adb
--   Purpose: Appointments diary package (body)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Streams.Stream_IO, JE.Times;
package body JE.Diaries is
    use type JE.Times.Time_Type;        -- to allow use of ">"
    use type Lists.List_Iterator;       -- to allow use of "/="

    function Size (Diary : Diary_Type) return Natural is
    begin
        return Lists.Size(Diary.List);
    end Size;

    function Choose (Diary : Diary_Type;
                     Appt  : Positive) return Appointment_Type'Class is
        Iterator : Lists.List_Iterator;
    begin
        if Appt not in 1 .. Lists.Size(Diary.List) then
            raise Diary_Error;
        else
            Iterator := Lists.First(Diary.List);
            for I in 2 .. Appt loop
                Iterator := Lists.Succ(Iterator);
            end loop;
            return Lists.Value(Iterator).all;
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
                   Appt  : in Appointment_Type'Class) is
        Iterator : Lists.List_Iterator;
    begin
        Iterator := Lists.First(Diary.List);
        while Iterator /= Lists.Last(Diary.List) loop
            exit when Date(Lists.Value(Iterator).all) > Date(Appt);
            Iterator := Lists.Succ(Iterator);
        end loop;
        Lists.Insert (Iterator, new Appointment_Type'Class'(Appt));
    exception
        when Storage_Error =>
            raise Diary_Error;
    end Add;

    procedure Save (Diary : in Diary_Type;
                    To    : in String) is
        File   : Ada.Streams.Stream_IO.File_Type;
        Stream : Ada.Streams.Stream_IO.Stream_Access;
        I : Lists.List_Iterator := Lists.First(Diary.List);
    begin
        Ada.Streams.Stream_IO.Create (File, Name => To);
        Stream := Ada.Streams.Stream_IO.Stream(File);

        while I /= Lists.Last(Diary.List) loop
            Appointment_Type'Class'Output (Stream, Lists.Value(I).all);
            I := Lists.Succ(I);
        end loop;

        Ada.Streams.Stream_IO.Close (File);
    end Save;

    procedure Load (Diary : in out JE.Diaries.Diary_Type;
                    From  : in String) is
        File   : Ada.Streams.Stream_IO.File_Type;
        Stream : Ada.Streams.Stream_IO.Stream_Access;
    begin
        while Size(Diary) > 0 loop
            Lists.Delete (Lists.First(Diary.List));
        end loop;

        Ada.Streams.Stream_IO.Open (File, Name => From,
                                    Mode => Ada.Streams.Stream_IO.In_File);
        Stream := Ada.Streams.Stream_IO.Stream(File);

        while not Ada.Streams.Stream_IO.End_Of_File(File) loop
            Add (Diary, Appointment_Type'Class'Input (Stream));
        end loop;

        Ada.Streams.Stream_IO.Close (File);

    exception
        when Ada.Streams.Stream_IO.Name_Error =>
            raise Diary_Error;
    end Load;

end JE.Diaries;
