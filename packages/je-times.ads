----------------------------------------------------------------------------
--
--   File:    je-times.ads
--   Purpose: Wrapper for Ada.Calendar (specification)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Calendar;
package JE.Times is
    subtype Time_Type    is Ada.Calendar.Time;

    subtype Year_Type    is Ada.Calendar.Year_Number;
    type    Month_Type   is (Jan, Feb, Mar, Apr, May, Jun,
                             Jul, Aug, Sep, Oct, Nov, Dec);
    subtype Day_Type     is Ada.Calendar.Day_Number;
    subtype Hour_Type    is Integer range 0..23;
    subtype Minute_Type  is Integer range 0..59;
    subtype Second_Type  is Integer range 0..59;

    subtype Day_Duration is Ada.Calendar.Day_Duration;

    function Clock return Ada.Calendar.Time        renames Ada.Calendar.Clock;

    function Interval (Days    : Natural := 0;
                       Hours   : Natural := 0;
                       Minutes : Natural := 0;
                       Seconds : Natural := 0)     return Duration;

    function Year   (Date : Ada.Calendar.Time)     return Year_Type
                                                   renames Ada.Calendar.Year;
    function Month  (Date : Time_Type) return Month_Type;
    function Day    (Date : Ada.Calendar.Time)     return Day_Type
                                                   renames Ada.Calendar.Day;
    function Hour   (Date : Time_Type) return Hour_Type;
    function Minute (Date : Time_Type) return Minute_Type;
    function Second (Date : Time_Type) return Second_Type;

    function Time   (Year    : Year_Type;
                     Month   : Month_Type;
                     Day     : Day_Type;
                     Hour    : Hour_Type   := 0;
                     Minute  : Minute_Type := 0;
                     Second  : Second_Type := 0)   return Time_Type;

    function "+" (Left  : Ada.Calendar.Time;
                  Right : Duration)                return Ada.Calendar.Time
                                                   renames Ada.Calendar."+";
    function "+" (Left  : Duration;
                  Right : Ada.Calendar.Time)       return Ada.Calendar.Time
                                                   renames Ada.Calendar."+";
    function "-" (Left  : Ada.Calendar.Time;
                  Right : Duration)                return Ada.Calendar.Time
                                                   renames Ada.Calendar."-";
    function "-" (Left  : Ada.Calendar.Time;
                  Right : Ada.Calendar.Time)       return Duration
                                                   renames Ada.Calendar."-";

    function "<" (Left, Right : Ada.Calendar.Time) return Boolean
                                                   renames Ada.Calendar."<";
    function "<="(Left, Right : Ada.Calendar.Time) return Boolean
                                                   renames Ada.Calendar."<=";
    function ">" (Left, Right : Ada.Calendar.Time) return Boolean
                                                   renames Ada.Calendar.">";
    function ">="(Left, Right : Ada.Calendar.Time) return Boolean
                                                   renames Ada.Calendar.">=";

    Time_Error : exception renames Ada.Calendar.Time_Error;

end JE.Times;
