----------------------------------------------------------------------------
--
--   File:    task_test.adb
--   Purpose: Demonstration of two tasks saying "Hello!" five times each
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO;
use  Ada.Text_IO;
procedure Task_Test is
    task type Repeat;

    task body Repeat is
    begin
        for I in 1..5 loop
            Put_Line ("Hello!");
            delay 2.0;
        end loop;
    end Repeat;

    A, B : Repeat;      -- declare two tasks
begin                   -- both tasks are started at this point
    null;
end Task_Test;          -- wait here for both tasks to end
