----------------------------------------------------------------------------
--
--   File:    je-diaries.ads
--   Purpose: Appointments diary package (specification)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Lists, JE.Appointments;
use  JE.Appointments;
package JE.Diaries is
    type Diary_Type is limited private;

    procedure Load   (Diary : in out Diary_Type;
                      From  : in String);
    procedure Save   (Diary : in Diary_Type;
                      To    : in String);
    procedure Add    (Diary : in out Diary_Type;
                      Appt  : in Appointment_Type'Class);
    function  Choose (Diary : Diary_Type;
                      Appt  : Positive) return Appointment_Type'Class;
    procedure Delete (Diary : in out Diary_Type;
                      Appt  : in Positive);
    function  Size   (Diary : Diary_Type) return Natural;

    Diary_Error : exception;

private
    type Appointment_Access is access Appointment_Type'Class;
    package Lists is new JE.Lists (Item_Type => Appointment_Access);
    type Diary_Type is
        limited record
            List : Lists.List_Type;
        end record;
end JE.Diaries;
