----------------------------------------------------------------------------
--
--   File:    hello_3.adb
--   Purpose: Use "Hello world!" program as a procedure in a larger program
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Hello;             -- refer to compiled version of Hello in library
procedure Hello_3 is
begin
    Hello;
    Hello;
    Hello;
end Hello_3;
