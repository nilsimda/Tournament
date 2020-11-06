module Exercise01 where

import Test.QuickCheck

{-H1.1a)-}
myPair :: Integer -> Integer -> Integer
myPair = undefined

{-H1.1b)-}
mySnd :: Integer -> Integer
mySnd = undefined 

{-H1.1c)-}
myFst :: Integer -> Integer
myFst = undefined

{-H1.1d)-}
prop_myPair :: Integer -> Integer -> Integer -> Property
prop_myPair = undefined

{-H2-}
digitToEo :: Integer -> String
digitToEo 0 = "nul"
digitToEo 1 = "unu"
digitToEo 2 = "du"
digitToEo 3 = "tri"
digitToEo 4 = "kvar"
digitToEo 5 = "kvin"
digitToEo 6 = "ses"
digitToEo 7 = "sep"
digitToEo 8 = "ok"
digitToEo 9 = "nau"

{-WETT-}

numberToEo :: Integer -> String
numberToEo n = undefined

{-TTEW-}
