----------------------------------------------------------------------------
--
--   File:    diary-diary_view.adb
--   Purpose: User interface package for diary program (body)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, JE.Times, JE.Diaries, JE.Appointments;
use  Ada.Text_IO, Ada.Integer_Text_IO;
separate (Diary)
package body Diary_View is
    Diary_Name : constant String := "Diary";

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

    procedure Load_Diary (Diary : in out JE.Diaries.Diary_Type) is
    begin
        JE.Diaries.Load (Diary, Diary_Name);
    end Load_Diary;

    procedure Save_Diary (Diary : in JE.Diaries.Diary_Type) is
    begin
        JE.Diaries.Save (Diary, Diary_Name);
    end Save_Diary;

    procedure Add_Appointment (Diary : in out JE.Diaries.Diary_Type) is
        package Month_IO is
                    new Ada.Text_IO.Enumeration_IO (JE.Times.Month_Type);
        use Month_IO;

        Day       : JE.Times.Day_Type;
        Month     : JE.Times.Month_Type;
        Year      : JE.Times.Year_Type;
        Hour      : JE.Times.Hour_Type;
        Minute    : JE.Times.Minute_Type;
        Details   : String (1..50);
        Length    : Natural;
        Separator : Character;
    begin
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
        JE.Diaries.Add
            ( Diary,
              JE.Appointments.Appointment
                  ( JE.Times.Time (Year, Month, Day, Hour, Minute),
                    Details(1..Length)
                  )
            );
    exception
        when Data_Error | Constraint_Error | JE.Times.Time_Error =>
            Put_Line ("Invalid input.");
    end Add_Appointment;

    procedure Put (Appt : in JE.Appointments.Appointment_Type) is
        package Month_IO is new Enumeration_IO (JE.Times.Month_Type);
        use Month_IO, JE.Times, JE.Appointments;
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

    procedure List_Appointments (Diary : in JE.Diaries.Diary_Type) is
        use JE.Diaries, JE.Appointments;
    begin
        if Size(Diary) = 0 then
            Put_Line ("No appointments found.");
        else
            for I in 1 .. Size(Diary) loop
                Put (I, Width=>3); Put (") ");
                Put (Choose(Diary,I));
                New_Line;
            end loop;
        end if;
    end List_Appointments;

    procedure Delete_Appointment (Diary : in out JE.Diaries.Diary_Type) is
        Appt_No : Positive;
    begin
        Put ("Enter appointment number: ");
        Get (Appt_No);
        if Appt_No not in 1 .. JE.Diaries.Size(Diary) then
            raise Constraint_Error;
        end if;
        JE.Diaries.Delete (Diary, Appt_No);
    exception
        when Constraint_Error | Data_Error =>
            Put_Line ("Invalid appointment number");
            Skip_Line;
    end Delete_Appointment;
end Diary_View;
