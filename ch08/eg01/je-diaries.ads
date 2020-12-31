----------------------------------------------------------------------------
--
--   File:    je-diaries.ads
--   Purpose: Diary package (specification)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package JE.Diaries is
    procedure Load_Diary;
    procedure Add_Appointment;
    procedure Delete_Appointment;
    procedure List_Appointments;
    procedure Save_Appointments;
end JE.Diaries;
