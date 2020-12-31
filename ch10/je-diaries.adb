----------------------------------------------------------------------------
--
--   File:    je-diaries.adb
--   Purpose: Diary ADT (body)
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

    procedure Load (Diary : in out Diary_Type;
                    From  : in String) is
        File : Appt_IO.File_Type;
    begin
        Diary.Count := 0;
        Appt_IO.Open (File, Name => From, Mode => Appt_IO.In_File);
        while not Appt_IO.End_Of_File(File) loop
            Diary.Count := Diary.Count + 1;
            Appt_IO.Read (File, Diary.Appts(Diary.Count));
        end loop;
        Appt_IO.Close (File);
    exception
        when Appt_IO.Name_Error =>
            raise Diary_Error;
    end Load;

    procedure Save (Diary : in Diary_Type;
                    To    : in String) is
        File : Appt_IO.File_Type;
    begin
        Appt_IO.Create (File, Name => To);
        for I in 1..Diary.Count loop
            Appt_IO.Write (File, Diary.Appts(I));
        end loop;
        Appt_IO.Close (File);
    end Save;

    function Size (Diary : Diary_Type) return Natural is
    begin
        return Diary.Count;
    end Size;

    procedure Add (Diary : in out Diary_Type;
                   Appt  : in Appointment_Type) is
        use type JE.Times.Time_Type;        -- to allow use of ">"
        Pos : Positive;                     -- position to insert new appt.
    begin
        if Diary.Count = Diary.Appts'Length then
            raise Diary_Error;
        else
            Pos := 1;
            for I in 1 .. Diary.Count loop
                exit when Date(Diary.Appts(I)) > Date(Appt);
                Pos := Pos + 1;
            end loop;
            Diary.Appts(Pos+1 .. Diary.Count+1) := Diary.Appts(Pos..Diary.Count);
            Diary.Appts(Pos) := Appt;
            Diary.Count := Diary.Count + 1;
        end if;
    end Add;

    procedure Delete (Diary : in out Diary_Type;
                      Appt  : in Positive) is
    begin
        if Appt not in 1 .. Diary.Count then
            raise Diary_Error;
        else
            Diary.Appts(Appt..Diary.Count-1) := Diary.Appts(Appt+1..Diary.Count);
            Diary.Count := Diary.Count - 1;
        end if;
    end Delete;

    function Choose (Diary : Diary_Type;
                     Appt  : Positive) return Appointment_Type is
    begin
        if Appt not in 1 .. Diary.Count then
            raise Diary_Error;
        else
            return Diary.Appts(Appt);
        end if;
    end Choose;
end JE.Diaries;
