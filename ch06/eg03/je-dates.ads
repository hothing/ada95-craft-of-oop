----------------------------------------------------------------------------
--
--   File:    je-dates.ads
--   Purpose: Dates package (specification) using a record type
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package JE.Dates is
    subtype Day_Type     is Integer range 1..31;
    type    Month_Type   is (Jan, Feb, Mar, Apr, May, Jun,
                             Jul, Aug, Sep, Oct, Nov, Dec);
    subtype Year_Type    is Integer range 1901..2099;
    type    Weekday_Type is (Sun, Mon, Tue, Wed, Thu, Fri, Sat);

    type Date_Type is
        record
            Day   : Day_Type;
            Month : Month_Type;
            Year  : Year_Type;
        end record;

    function Day_Of     (Date : Date_Type) return Weekday_Type;
    function Valid_Date (Date : Date_Type) return Boolean;
end JE.Dates;
