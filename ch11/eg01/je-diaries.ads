----------------------------------------------------------------------------
--
--   File:    je-diaries.ads
--   Purpose: Diary ADT (specification) using linked list
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Appointments;
use  JE.Appointments;
package JE.Diaries is
    type Diary_Type is limited private;

    procedure Load   (Diary : in out Diary_Type;
                      From  : in String);
    procedure Save   (Diary : in Diary_Type;
                      To    : in String);

    procedure Add    (Diary : in out Diary_Type;
                      Appt  : in Appointment_Type);
    procedure Delete (Diary : in out Diary_Type;
                      Appt  : in Positive);
    function  Choose (Diary : Diary_Type;
                      Appt  : Positive)   return Appointment_Type;
    function  Size   (Diary : Diary_Type) return Natural;

    Diary_Error : exception;

private
    type Appointment_Record;
    type Appointment_Access is access Appointment_Record;

    type Appointment_Record is
        record
            Appt : JE.Appointments.Appointment_Type;
            Next : Appointment_Access;
            Pred : Appointment_Access;
        end record;

    type List_Header is
        record
            First : Appointment_Access;
            Last  : Appointment_Access;
            Count : Natural := 0;
        end record;
    type List_Access is access List_Header;

    type Diary_Type is
        record
            List : List_Access := new List_Header;
        end record;

    type Diary_Iterator is
        record
            List    : List_Access;
            Current : Appointment_Access;
        end record;

    function  First  (Diary    : Diary_Type)     return Diary_Iterator;
    function  Last   (Diary    : Diary_Type)     return Diary_Iterator;
    function  Succ   (Iterator : Diary_Iterator) return Diary_Iterator;
    function  Pred   (Iterator : Diary_Iterator) return Diary_Iterator;
    function  Value  (Iterator : Diary_Iterator) return Appointment_Type;
    procedure Insert (Iterator : in Diary_Iterator;
                      Appt     : in Appointment_Type);
    procedure Delete (Iterator : in Diary_Iterator);

end JE.Diaries;
