----------------------------------------------------------------------------
--
--   File:    je-appointments-meetings.adb
--   Purpose: Meeting ADT (body) using contained appointment
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
        Result := (Appt => A, Room => Room);
    end Meeting;

    function Date (Meeting : Meeting_Type) return Time_Type is
    begin
        return Date (Meeting.Appt);
    end Date;

    function Details (Meeting : Meeting_Type) return String is
    begin
        return Details (Meeting.Appt);
    end Details;

    function Room (Meeting : Meeting_Type) return Room_Type is
    begin
        return Meeting.Room;
    end Room;

    procedure Put (Meeting : in Meeting_Type) is
    begin
        null;
    end Put;
end JE.Appointments.Meetings;
