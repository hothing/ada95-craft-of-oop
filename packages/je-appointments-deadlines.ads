----------------------------------------------------------------------------
--
--   File:    je-appointments-deadlines.ads
--   Purpose: Derived appointment type to represent a deadline
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package JE.Appointments.Deadlines is
    type Deadline_Type is
                    abstract new Appointment_Type with null record;

    procedure Put (Appt : in Deadline_Type) is abstract;

    -- Date, Details and Appointment inherited unchanged
    -- from Appointment_Type
end JE.Appointments.Deadlines;
