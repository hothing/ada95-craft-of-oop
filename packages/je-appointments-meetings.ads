----------------------------------------------------------------------------
--
--   File:    je-appointments-meetings.ads
--   Purpose: Extended appointments package for meetings (specification)
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
    type Meeting_Type is abstract new Appointment_Type with private;

    procedure Meeting (Date    : in Time_Type;
                       Details : in String;
                       Room    : in Room_Type;
                       Result  : out Meeting_Type);

    function  Room (Appt : Meeting_Type) return Room_Type;

    -- Date, Details and Put inherited unchanged
    -- from Appointment_Type; so is Appointment, but don't use it!

private
    type Meeting_Type is abstract new Appointment_Type with
        record
            Room : Room_Type;
        end record;
end JE.Appointments.Meetings;
