----------------------------------------------------------------------------
--
--   File:    je-appointments.adb
--   Purpose: Appointment ADT (body)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package body JE.Appointments is
    function Date (Appt : Appointment_Type) return Time_Type is
    begin
        return Appt.Time;
    end Date;

    function Details (Appt : Appointment_Type) return String is
    begin
        return Appt.Details (1..Appt.Length);
    end Details;

    function Appointment (Date    : Time_Type;
                          Details : String) return Appointment_Type is
        A : Appointment_Type;
    begin
        A.Time := Date;
        if Details'Length > A.Details'Length then
            A.Details :=
                Details(Details'First..Details'First+A.Details'Length-1);
            A.Length := A.Details'Length;
        else
            A.Details(1..Details'Length) := Details;
            A.Length := Details'Length;
        end if;
        return A;
    end Appointment;
end JE.Appointments;
