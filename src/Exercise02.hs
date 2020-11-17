module Exercise02 where

import Data.List
import Data.Ord

{-H2.1a)-}
twoThirdsAverageWinners :: [(String, Int)] -> [String]
twoThirdsAverageWinners gs = undefined

{-H2.1b)-}
lowestUniqueBidder :: [(String, Int)] -> String
lowestUniqueBidder bs = undefined


{-H2-}

-- returns the shortest list in a list of lists
shortest :: [[Int]] -> [Int]
shortest = minimumBy (comparing length)

-- returns the set of all players in a tournament
players :: [[Int]] -> [Int]
players tournament = [1..length tournament]

-- returns the dominion of player i
dominion :: [[Int]] -> Int -> [Int]
dominion tournament i = tournament !! (i - 1)


{-H2.2a)-}
dominators :: [[Int]] -> Int -> [Int]
dominators tournament i = [x | x <- players tournament, i `elem` dominion tournament x]

{-H2.2b)-}
covers :: [[Int]] -> Int -> Int-> Bool
covers tournament i j =  null [x | x <- dominion tournament j,  x `notElem` dominion tournament i]

{-2.2c)-}
dominant :: [[Int]] -> [Int] -> Bool
dominant tournament xs = undefined

{-WETT-}

{-H2.2d)-}
copeland :: [[Int]] -> [Int]
copeland tournament = [pl | pl <- players tournament, length (dominion tournament pl) == maxDomSize]
            where maxDomSize = maximum [length (dominion tournament x)| x <- players tournament]
{-H2.2e)-}
uncoveredSet :: [[Int]] -> [Int]
uncoveredSet tournament = undefined
       
{-H2.2f)-} 
topCycle :: [[Int]] -> [Int]
topCycle tournament = undefined

{-TTEW-}

