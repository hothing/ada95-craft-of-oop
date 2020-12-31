----------------------------------------------------------------------------
--
--   File:    int_pointers.ads
--   Purpose: Library package (specification) of smart pointers to integers
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Pointers;
package Int_Pointers is
    type Int_Access is access Integer;
    package Pointers is new JE.Pointers (Integer, Int_Access);
end Int_Pointers;
