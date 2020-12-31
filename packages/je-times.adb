----------------------------------------------------------------------------
--
--   File:    je-times.adb
--   Purpose: Wrapper for Ada.Calendar (body)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package body JE.Times is
    Seconds_Per_Minute : constant := 60;
    Minutes_Per_Hour   : constant := 60;
    Hours_Per_Day      : constant := 24;
    Seconds_Per_Hour   : constant := Minutes_Per_Hour * Seconds_Per_Minute;
    Seconds_Per_Day    : constant := Hours_Per_Day * Seconds_Per_Hour;
    type Integer_Time is range 0 .. Seconds_Per_Day;

    function Convert_Time (Time : Day_Duration) return Integer_Time is
        type Extended_Integer_Time is
               range Integer_Time'First .. Integer_Time'Last + 1;
        T : Extended_Integer_Time := Extended_Integer_Time (Time);
    begin
        return Integer_Time (T mod Extended_Integer_Time'Last);
    end Convert_Time;

    function Interval (Days    : Natural := 0;
                       Hours   : Natural := 0;
                       Minutes : Natural := 0;
                       Seconds : Natural := 0) return Duration is
    begin
        return Duration( (Days * Seconds_Per_Day) +
                         (Hours * Seconds_Per_Hour) +
                         (Minutes * Seconds_Per_Minute) + Seconds );
    end Interval;

    function Month  (Date : Ada.Calendar.Time) return Month_Type is
    begin
        return Month_Type'Val (Ada.Calendar.Month(Date) - 1);
    end Month;

    function Hour (Date : Time_Type) return Hour_Type is
        S : Ada.Calendar.Day_Duration := Ada.Calendar.Seconds (Date);
    begin
        return Hour_Type( Convert_Time(S) / Seconds_Per_Hour );
    end Hour;

    function Minute (Date : Time_Type) return Minute_Type is
        S : Ada.Calendar.Day_Duration := Ada.Calendar.Seconds (Date);
    begin
        return Minute_Type( (Convert_Time(S) / Seconds_Per_Minute)
                                               mod Minutes_Per_Hour );
    end Minute;

    function Second (Date : Time_Type) return Second_Type is
        S : Ada.Calendar.Day_Duration := Ada.Calendar.Seconds (Date);
    begin
        return Second_Type( Convert_Time(S) mod Seconds_Per_Minute );
    end Second;

    function Time (Year    : Year_Type;
                   Month   : Month_Type;
                   Day     : Day_Type;
                   Hour    : Hour_Type   := 0;
                   Minute  : Minute_Type := 0;
                   Second  : Second_Type := 0) return Time_Type is
        Seconds : Day_Duration :=
                   Day_Duration( (Hour * Seconds_Per_Hour) +
                                 (Minute * Seconds_Per_Minute) + Second );
    begin
        return Ada.Calendar.Time_Of (Year, Month_Type'Pos(Month) + 1,
                                     Day, Seconds);
    end Time;
end JE.Times;
