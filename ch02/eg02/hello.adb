----------------------------------------------------------------------------
--
--   File:    hello.adb
--   Purpose: Display "Hello world!" (no indentation or other layout)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with ada.text_io;procedure hello is begin ada.text_io.put("Hello world!"
);ada.text_io.new_line;end hello;
