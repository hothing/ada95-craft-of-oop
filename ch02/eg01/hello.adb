----------------------------------------------------------------------------
--
--   File:    hello.adb
--   Purpose: Everyone's first program; displays "Hello world!"
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO;                                       --  1
procedure Hello is                                      --  2
begin                                                   --  3
    Ada.Text_IO.Put ("Hello world!");                   --  4
    Ada.Text_IO.New_Line;                               --  5
end Hello;                                              --  6
