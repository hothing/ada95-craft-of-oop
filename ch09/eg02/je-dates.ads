----------------------------------------------------------------------------
--
--   File:    je-dates.ads
--   Purpose: Date package (spec) using deferred constant
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package JE.Dates is
    -- Visible part of package
    subtype Day_Type      is Integer range 1..31;
    type    Month_Type    is (Jan, Feb, Mar, Apr, May, Jun,
                              Jul, Aug, Sep, Oct, Nov, Dec);
    subtype Year_Type     is Integer range 1901..2099;
    type    Weekday_Type  is (Sun, Mon, Tue, Wed, Thu, Fri, Sat);

    type Date_Type is private;

    -- Accessor functions
    function Day     (Date : Date_Type) return Day_Type;
    function Month   (Date : Date_Type) return Month_Type;
    function Year    (Date : Date_Type) return Year_Type;
    function Weekday (Date : Date_Type) return Weekday_Type;

    -- Constructor function
    function Date    (Day   : Day_Type;
                      Month : Month_Type;
                      Year  : Year_Type) return Date_Type;

    Invalid_Date : constant Date_Type;                  -- deferred constant

    -- Exception for error reporting
    Date_Error : exception;     -- can be raised by Date

private                         -- visible part ends here
    -- Private part of package
    type Date_Type is
        record
            Day   : Day_Type;
            Month : Month_Type;
            Year  : Year_Type;
        end record;

    Invalid_Date : constant Date_Type := (31,Feb,1901); -- full declaration

end JE.Dates;
