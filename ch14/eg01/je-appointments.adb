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

    procedure Appointment (Date    : in Time_Type;
                           Details : in String;
                           Result  : out Appointment_Type) is
    begin
        Result.Time := Date;
        if Details'Length > Result.Details'Length then
            Result.Details := Details(Details'First..Details'First+Result.Details'Length-1);
            Result.Length := Result.Details'Length;
        else
            Result.Details(1..Details'Length) := Details;
            Result.Length := Details'Length;
        end if;
    end Appointment;

    procedure Put (Appt : in Appointment_Type) is
    begin
        null;
    end Put;
end JE.Appointments;
