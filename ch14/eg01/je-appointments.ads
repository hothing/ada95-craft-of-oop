----------------------------------------------------------------------------
--
--   File:    je-appointments.ads
--   Purpose: Appointment ADT (specification)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Times;
use  JE.Times;
package JE.Appointments is
    type Appointment_Type is private;

    function Date    (Appt : Appointment_Type) return Time_Type;
    function Details (Appt : Appointment_Type) return String;

    procedure Appointment (Date    : in Time_Type;
                           Details : in String;
                           Result  : out Appointment_Type);

    procedure Put (Appt : in Appointment_Type);

private
    type Appointment_Type is
        record
            Time    : Time_Type;
            Details : String (1..50);
            Length  : Natural := 0;
        end record;
end JE.Appointments;
