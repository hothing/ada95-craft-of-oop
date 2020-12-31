----------------------------------------------------------------------------
--
--   File:    dates.ads
--   Purpose: Date-handling package (specification)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package Dates is
    function Day_Of     (Day, Month, Year : Integer) return Integer;
    function Valid_Date (Day, Month, Year : Integer) return Boolean;
end Dates;
