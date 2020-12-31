----------------------------------------------------------------------------
--
--   File:    je-dates.ads
--   Purpose: Date package (specification) with fancy construction
--            operators
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

    -- Comparison operators
    function "<"  (Left, Right : Date_Type) return Boolean;
    function ">"  (Left, Right : Date_Type) return Boolean;
    function "<=" (Left, Right : Date_Type) return Boolean;
    function ">=" (Left, Right : Date_Type) return Boolean;

    -- Fancy construction operators
    type Day_And_Month is
        record
            Day   : Day_Type;
            Month : Month_Type;
        end record;
    function "-" (Left : Day_Type; Right : Month_Type) return Day_And_Month;
    function "-" (Left : Day_And_Month; Right : Year_Type) return Date_Type;

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
end JE.Dates;
