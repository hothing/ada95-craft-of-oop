----------------------------------------------------------------------------
--
--   File:    init_test.adb
--   Purpose: Initialise a record component using a function call
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO;   use Ada.Text_IO;
procedure Init_Test is
    type Account_Number_Type is range 1000_0000..9999_9999;
    type Money_Type          is delta 0.01 range 0.00 .. 1_000_000_000.00;
    Last_Account : Account_Number_Type := Account_Number_Type'First;

    package Acct_IO is new Ada.Text_IO.Integer_IO (Account_Number_Type);

    function Next_Account_Number return Account_Number_Type is
        New_Account : Account_Number_Type := Last_Account;
    begin
        Last_Account := Last_Account + 1;
        return New_Account;
    end Next_Account_Number;

    type Bank_Account_Type is
        record
            Account_Number : Account_Number_Type := Next_Account_Number;
            Balance        : Money_Type          := 0.00;
            -- and so on
        end record;

    A, B : Bank_Account_Type;
    C    : Bank_Account_Type;

begin      -- main program
    Acct_IO.Put (A.Account_Number);
    Acct_IO.Put (B.Account_Number);
    Acct_IO.Put (C.Account_Number);
end Init_Test;
