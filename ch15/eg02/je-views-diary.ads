----------------------------------------------------------------------------
--
--   File:    je-views-diary.ads
--   Purpose: User interface package (specification) for diary program
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Diaries, JE.Appointments.Meetings, JE.Appointments.Deadlines;
use  JE.Diaries;
package JE.Views.Diary is
    type Appointment_Type is new JE.Appointments.Appointment_Type
                                        with null record;
    procedure Put (Appt : in Appointment_Type);

    type Meeting_Type is new JE.Appointments.Meetings.Meeting_Type
                                        with null record;
    procedure Put (Appt : in Meeting_Type);

    type Deadline_Type is new JE.Appointments.Deadlines.Deadline_Type
                                        with null record;
    procedure Put (Appt : in Deadline_Type);

    type Command_Type is (Add, List, Delete, Save, Quit);
    function  Next_Command return Command_Type;

    procedure Load_Diary         (Diary : in out Diary_Type);
    procedure Save_Diary         (Diary : in Diary_Type);
    procedure Add_Appointment    (Diary : in out Diary_Type);
    procedure List_Appointments  (Diary : in Diary_Type);
    procedure Delete_Appointment (Diary : in out Diary_Type);
end JE.Views.Diary;
