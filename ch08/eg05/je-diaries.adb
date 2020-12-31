----------------------------------------------------------------------------
--
--   File:    je-diaries.adb
--   Purpose: Diary package (body) with List and Add implemented
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

    procedure Load_Diary is
    begin
        Put_Line ("Load_Diary called");
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
    begin
        Put_Line ("Delete_Appointment called");
    end Delete_Appointment;

    procedure Save_Appointments is
    begin
        Put_Line ("Save_Appointments called");
    end Save_Appointments;

end JE.Diaries;
