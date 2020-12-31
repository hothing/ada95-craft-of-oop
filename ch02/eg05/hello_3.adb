----------------------------------------------------------------------------
--
--   File:    hello_3.adb
--   Purpose: Display "Hello world!" three times (without using Hello)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO;  use Ada.Text_IO;
procedure Hello_3 is
begin
    Put ("Hello world!");       -- first call to Hello
    New_Line;
    Put ("Hello world!");       -- second call to Hello
    New_Line;
    Put ("Hello world!");       -- third call to Hello
    New_Line;
end Hello_3;
