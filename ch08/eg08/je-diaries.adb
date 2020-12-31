----------------------------------------------------------------------------
--
--   File:    je-diaries.adb
--   Purpose: Diary package (body) with bug fix in Load
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO;   use Ada.Text_IO;
package body JE.Diaries is
    subtype Day_Type    is Integer range 1..31;
    type    Month_Type  is (Jan, Feb, Mar, Apr, May, Jun,
                            Jul, Aug, Sep, Oct, Nov, Dec);
    subtype Year_Type   is Integer range 1901..2099;
    subtype Hour_Type   is Integer range 0..23;
    subtype Minute_Type is Integer range 0..59;

    package Int_IO   is new Integer_IO (Integer);               use Int_IO;
    package Month_IO is new Enumeration_IO (Month_Type);        use Month_IO;

    type Date_Type is
        record
            Day   : Day_Type;
            Month : Month_Type;
            Year  : Year_Type;
        end record;

    type Time_Type is
        record
            Hour   : Hour_Type;
            Minute : Minute_Type;
        end record;

    type Appointment_Type is
        record
            Date    : Date_Type;
            Time    : Time_Type;
            Details : String (1..50);       -- an arbitrarily-chosen size
            Length  : Natural := 0;
        end record;

    type Appointment_Array is array (Positive range <>) of Appointment_Type;
    type Diary_Type (Maximum : Positive) is
        record
            Appts : Appointment_Array (1..Maximum);
            Count : Natural := 0;
        end record;

    Diary : Diary_Type (10);

    Diary_File_Name : constant String := "Diary";

    procedure Load_Diary is
        Diary_File : File_Type;
    begin
        Open (Diary_File, Mode => In_File, Name => Diary_File_Name);
        Get (Diary_File, Diary.Count);
        Skip_Line (Diary_File);
        for I in Diary.Appts'First .. Diary.Count loop
            declare
                Appt : Appointment_Type renames Diary.Appts(I);
                Space : Character;                                -- bug fix
            begin
                Get (Diary_File, Appt.Date.Day);
                Get (Diary_File, Appt.Date.Month);
                Get (Diary_File, Appt.Date.Year);
                Get (Diary_File, Appt.Time.Hour);
                Get (Diary_File, Appt.Time.Minute);
                Get (Diary_File, Space);                          -- bug fix
                Get_Line (Diary_File, Appt.Details, Appt.Length);
            end;
        end loop;
        Close (Diary_File);
    exception
        when Name_Error =>
            null;
        when Use_Error =>
            Put_Line ("Couldn't open diary file!");
    end Load_Diary;

    procedure Put (Item : in Appointment_Type) is
    begin
        Put (Item.Date.Day,    Width => 2);  Put ("-");
        Put (Item.Date.Month);               Put ("-");
        Put (Item.Date.Year,   Width => 4);  Put (" ");
        Put (Item.Time.Hour,   Width => 2);  Put (":");
        Put (Item.Time.Minute, Width => 2);  Put (" ");
        Put_Line (Item.Details (1..Item.Length));
    end Put;

    procedure List_Appointments is
    begin
        if Diary.Count = 0 then
            Put_Line ("No appointments found.");
        else
            for I in Diary.Appts'First .. Diary.Count loop
                Put (I, Width=>3); Put (") ");
                Put ( Diary.Appts(I) );
            end loop;
        end if;
    end List_Appointments;

    procedure Get (Item : out Date_Type) is
    begin
        Get (Item.Day);
        Get (Item.Month);
        Get (Item.Year);
    end Get;

    procedure Get (Item : out Time_Type) is
    begin
        Get (Item.Hour);
        Get (Item.Minute);
    end Get;

    procedure Add_Appointment is
        New_Appt : Appointment_Type;
    begin
        begin
            Put_Line ("Enter appointment details...");
            Put ("Date: ");
            Get (New_Appt.Date);
            Put ("Time: ");
            Get (New_Appt.Time);
            Put ("Details: ");
            Skip_Line;
            Get_Line (New_Appt.Details, New_Appt.Length);
        exception
            when Data_Error | Constraint_Error =>
                Put_Line ("Error in input -- please try again");
                Skip_Line;
                return;
        end;

        Diary.Count := Diary.Count + 1;
        Diary.Appts (Diary.Count) := New_Appt;

    exception
        when Constraint_Error =>
            Put_Line ("Diary full -- appointment not added");

    end Add_Appointment;

    procedure Delete_Appointment is
        Appt_No : Positive;
    begin
        Put ("Enter appointment number: ");
        Get (Appt_No);
        if Appt_No not in Diary.Appts'First .. Diary.Count then
            raise Constraint_Error;
        end if;
        Diary.Appts(Appt_No..Diary.Count-1) := Diary.Appts(Appt_No+1..Diary.Count);
        Diary.Count := Diary.Count - 1;
    exception
        when Constraint_Error | Data_Error =>
            Put_Line ("Invalid appointment number");
            Skip_Line;
    end Delete_Appointment;

    procedure Save_Appointments is
        Diary_File : File_Type;
    begin
        Create (Diary_File, Name => Diary_File_Name);
        Put (Diary_File, Diary.Count);
        New_Line (Diary_File);
        for I in Diary.Appts'First .. Diary.Count loop
            declare
                Appt : Appointment_Type renames Diary.Appts(I);
            begin
                Put (Diary_File, Appt.Date.Day, Width=>1);
                Put (Diary_File, ' ');
                Put (Diary_File, Appt.Date.Month);
                Put (Diary_File, ' ');
                Put (Diary_File, Appt.Date.Year, Width=>1); 
                Put (Diary_File, ' ');
                Put (Diary_File, Appt.Time.Hour, Width=>1); 
                Put (Diary_File, ' ');
                Put (Diary_File, Appt.Time.Minute, Width=>1);
                Put (Diary_File, ' ');
                Put (Diary_File, Appt.Details (1..Appt.Length));
                New_Line (Diary_File);
            end;
        end loop;
        Close (Diary_File);
    exception
        when Use_Error =>
            Put_Line ("Couldn't create diary file!");
    end Save_Appointments;

end JE.Diaries;
