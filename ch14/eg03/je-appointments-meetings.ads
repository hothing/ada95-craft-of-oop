----------------------------------------------------------------------------
--
--   File:    je-appointments-meetings.ads
--   Purpose: Meeting ADT (specification) using derivation from tagged type
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package JE.Appointments.Meetings is
    subtype Room_Type is Integer range 100 .. 999;
    type Meeting_Type is new Appointment_Type with private;

    procedure Meeting (Date    : in Time_Type;
                       Details : in String;
                       Room    : in Room_Type;
                       Result  : out Meeting_Type);
    function  Room    (Meeting : Meeting_Type) return Room_Type;
    procedure Put     (Meeting : in Meeting_Type);

private
    type Meeting_Type is new Appointment_Type with
        record
            Room : Room_Type;
        end record;
end JE.Appointments.Meetings;
