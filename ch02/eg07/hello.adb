----------------------------------------------------------------------------
--
--   File:    hello.adb
--   Purpose: Display "Hello world!" (using Put_Line)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO;  use Ada.Text_IO;
procedure Hello is
begin
    Put_Line ("Hello world!");
end Hello;
