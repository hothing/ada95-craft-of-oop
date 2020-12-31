----------------------------------------------------------------------------
--
--   File:    var_test.adb
--   Purpose: Demonstration of variant records
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, JE.Times;
use  Ada.Text_IO, Ada.Integer_Text_IO, JE.Times;
procedure Var_Test is
    package Month_IO is new Ada.Text_IO.Enumeration_IO (Month_Type);
    use Month_IO;

    subtype Room_Type is Integer range 100 .. 999;

    type Appointment_Kind is (Appointment, Meeting);
    type Appointment_Type (Kind : Appointment_Kind) is
        record
            Date    : Time_Type;
            Details : String (1..50);
            Length  : Natural := 0;
            case Kind is
                when Appointment =>
                    null;
                when Meeting =>
                    Room : Room_Type;
            end case;
        end record;

    procedure Put (Appt : in Appointment_Type) is
    begin
        Put (Day(Appt.Date), Width=>2);
        Put ("-");
        Put (Month(Appt.Date));
        Put ("-");
        Put (Year(Appt.Date), Width=>4);
        Put (" ");
        Put (Hour(Appt.Date), Width=>2);
        Put (":");
        Put (Minute(Appt.Date), Width=>2);
        Put (" ");
        Put (Appt.Details(1..Appt.Length));
        case Appt.Kind is
            when Appointment =>
                null;           -- nothing else to do for ordinary appointments
            when Meeting =>
                Put (" in room ");
                Put (Appt.Room, Width=>1);      -- display extra Room component for meetings
        end case;
        New_Line;
    end Put;

    A : Appointment_Type(Appointment);
    M : Appointment_Type(Meeting);
begin
    A.Date := Time (1995,Jan,1,9,15);
    A.Details(1..8) := "New year";
    A.Length := 8;

    M.Date := Time (1995,Jan,1,9,15);
    M.Details(1..8) := "New year";
    M.Length := 8;
    M.Room := 101;

    Put (A);
    Put (M);
end Var_Test;
