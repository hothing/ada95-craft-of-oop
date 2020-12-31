----------------------------------------------------------------------------
--
--   File:    je-appointments-meetings.adb
--   Purpose: Extended appointments package for meetings (body)
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
    begin
        Appointment (Date, Details, Result);
        Result.Room := Room;
    end Meeting;

    function Room (Appt : Meeting_Type) return Room_Type is
    begin
        return Appt.Room;
    end Room;
end JE.Appointments.Meetings;
