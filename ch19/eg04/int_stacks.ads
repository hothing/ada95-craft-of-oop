----------------------------------------------------------------------------
--
--   File:    int_stacks.ads
--   Purpose: Instantiation of JE.Stacks for stacks of Integers
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Stacks;
package Int_Stacks is new JE.Stacks (Integer);
