----------------------------------------------------------------------------
--
--   File:    je-views-diary.adb
--   Purpose: User interface package (body) for diary program
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, JE.Times;
use  Ada.Text_IO, Ada.Integer_Text_IO;
package body JE.Views.Diary is
    package Month_IO is new Enumeration_IO (JE.Times.Month_Type);
    use Month_IO;

    Diary_Name : constant String := "Diary";

    procedure Put (Appt : in Appointment_Type) is
        use JE.Times, JE.Appointments;
    begin
        Put (Day(Date(Appt)), Width=>2);
        Put ("-");
        Put (Month(Date(Appt)));
        Put ("-");
        Put (Year(Date(Appt)), Width=>4);
        Put (" ");
        Put (Hour(Date(Appt)), Width=>2);
        Put (":");
        Put (Minute(Date(Appt)), Width=>2);
        Put (" ");
        Put (Details(Appt));
    end Put;

    procedure Put (Appt : in Meeting_Type) is
    begin
        Put (Appointment_Type'(JE.Appointments.Appointment_Type(Appt)
                                with null record));
        Put (" in room ");
        Put (Room(Appt), Width=>1);
    end Put;

    procedure Put (Appt : in Deadline_Type) is
    begin
        Put (Appointment_Type'(JE.Appointments.Appointment_Type(Appt)
                                with null record));
        Put (" (URGENT)");
    end Put;

    function Next_Command return Command_Type is
        Command : Character;
    begin
        loop
            -- display menu
            New_Line (5);
            Put_Line ("Diary menu:");
            Put_Line ("   [A]dd appointment");
            Put_Line ("   [D]elete appointment");
            Put_Line ("   [L]ist appointments");
            Put_Line ("   [S]ave appointments");
            Put_Line ("   [Q]uit");
            New_Line;
            Put ("Enter your choice: ");

            -- get a key
            Get (Command);
            Skip_Line;

            -- return selected command
            case Command is
                when 'A' | 'a' =>
                    return Add;
                when 'D' | 'd' =>
                    return Delete;
                when 'L' | 'l' =>
                    return List;
                when 'S' | 's' =>
                    return Save;
                when 'Q' | 'q' =>
                    return Quit;
                when others =>
                    Put_Line ("Invalid choice -- please enter A, D, L, S or Q");
            end case;
        end loop;
    exception
        when End_Error =>       -- quit if end-of-file character entered
            return Quit;
    end Next_Command;

    procedure Load_Diary (Diary : in out Diary_Type) is
    begin
        Load (Diary, Diary_Name);
    end Load_Diary;

    procedure Save_Diary (Diary : in Diary_Type) is
    begin
        Save (Diary, Diary_Name);
    end Save_Diary;

    procedure Add_Appointment (Diary : in out Diary_Type) is
        Day       : JE.Times.Day_Type;
        Month     : JE.Times.Month_Type;
        Year      : JE.Times.Year_Type;
        Hour      : JE.Times.Hour_Type;
        Minute    : JE.Times.Minute_Type;
        Details   : String (1..50);
        Length    : Natural;
        Separator : Character;
        Appt_Kind : Character;
    begin
        Put ("Appointment (A), meeting (M) or deadline (D)? ");
        Get (Appt_Kind);
        if Appt_Kind /= 'A' and Appt_Kind /= 'a' and
                                Appt_Kind /= 'M' and Appt_Kind /= 'm' and
                                Appt_Kind /= 'D' and Appt_Kind /= 'd' then
            raise Data_Error;
        end if;
        Put ("Enter date:  ");
        Get (Day);
        Get (Separator);
        Get (Month);
        Get (Separator);
        Get (Year);
        Skip_Line;
        Put ("Enter time:  ");
        Get (Hour);
        Get (Separator);
        Get (Minute);
        Skip_Line;
        Put ("Description: ");
        Get_Line (Details, Length);
        if Appt_Kind = 'M' or Appt_Kind = 'm' then
            declare
                Room : JE.Appointments.Meetings.Room_Type;
                Appt : Meeting_Type;
            begin
                Put ("Room number: ");
                Get (Room);
                Skip_Line;
                Meeting (JE.Times.Time(Year,Month,Day,Hour,Minute),
                         Details(1..Length), Room, Appt);
                Add (Diary, Appt);
            end;
        elsif Appt_Kind = 'D' or Appt_Kind = 'd' then
            declare
                Appt : Deadline_Type;
            begin
                Appointment (JE.Times.Time(Year,Month,Day,Hour,Minute),
                             Details(1..Length), Appt);
                JE.Diaries.Add (Diary, Appt);
            end;
        else
            declare
                Appt : Appointment_Type;
            begin
                Appointment (JE.Times.Time(Year,Month,Day,Hour,Minute),
                             Details(1..Length), Appt);
                Add (Diary, Appt);
            end;
        end if;
    exception
        when Data_Error | Constraint_Error | Diary_Error =>
            Put_Line ("Invalid input.");
    end Add_Appointment;

    procedure List_Appointments (Diary : in Diary_Type) is
        use JE.Diaries;
        --Appt : Meeting_Type;
    begin
        if Size(Diary) = 0 then
            Put_Line ("No appointments found.");
        else
            for I in 1 .. Size(Diary) loop
                Put (I, Width=>3); Put (") ");
                JE.Appointments.Put (Choose(Diary,I));
                New_Line;
            end loop;
        end if;
    end List_Appointments;

    procedure Delete_Appointment (Diary : in out Diary_Type) is
        Appt_No : Positive;
    begin
        Put ("Enter appointment number: ");
        Get (Appt_No);
        if Appt_No not in 1 .. Size(Diary) then
            raise Constraint_Error;
        end if;
        Delete (Diary, Appt_No);
    exception
        when Constraint_Error | Data_Error =>
            Put_Line ("Invalid appointment number");
            Skip_Line;
    end Delete_Appointment;
end JE.Views.Diary;
