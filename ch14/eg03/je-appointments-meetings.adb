----------------------------------------------------------------------------
--
--   File:    je-appointments-meetings.adb
--   Purpose: Meeting ADT (body) using derivation from tagged type
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package body JE.Appointments.Meetings is
    procedure Meeting (Date    : in Time_Type;
                       Details : in String;
                       Room    : in Room_Type;
                       Result  : out Meeting_Type) is
        A : Appointment_Type;
    begin
        Appointment (Date, Details, A);
        Result := (A with Room => Room);
    end Meeting;

    function Room (Meeting : Meeting_Type) return Room_Type is
    begin
        return Meeting.Room;
    end Room;

    procedure Put (Meeting : in Meeting_Type) is
    begin
        null;
    end Put;
end JE.Appointments.Meetings;
