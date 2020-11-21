module Exercise02 where

import Data.List
import Data.Ord

{-H2.1a)-}
twoThirdsAverageWinners :: [(String, Int)] -> [String]
twoThirdsAverageWinners gs = [x | (x,y) <- gs, abs (twoThirdAvg gs - y) ==  minGuess gs]

minGuess :: [(String, Int)] -> Int
minGuess gs = minimum [abs (twoThirdAvg gs - snd g)| g <- gs]
                  
twoThirdAvg :: [(String, Int)] -> Int
twoThirdAvg gs = floor ((2 * fromIntegral guessSum / fromIntegral (length gs)) / 3)        
            where guessSum = sum (map snd gs)

{-H2.1b)-}
lowestUniqueBidder :: [(String, Int)] -> String
lowestUniqueBidder bs = if lowestUniqueBid == -1 then "Nobody" else concat [str | (str, bid) <- bs, bid == lowestUniqueBid]
            where lowestUniqueBid = if null ls then -1 else minimum ls
                  ls = [snd b | b <- bs, count bs (snd b) == 1]

count :: [(String, Int)] -> Int -> Int
count bs i = length [x | (x,y) <- bs, y == i]

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
dominant tournament xs = not (null xs) && and [checkDom x | x <- xs]
            where checkDom pl = null [x | x <- players tournament \\ xs, x `notElem` dominion tournament pl]
            
{-WETT-}        

{-H2.2d)-}
copeland :: [[Int]] -> [Int]
copeland tournament =  filter ((== maximum (map length tournament)) . length . dominion tournament) $ players tournament

{-H2.2e)-}
uncoveredSet :: [[Int]] -> [Int]
uncoveredSet tournament = filter (\pl-> 1 == length [x | x <-players tournament, covers tournament x pl]) $ players tournament
        

{-H2.2f)-} 
topCycle :: [[Int]] -> [Int]
topCycle tournament = shortest $ filter (dominant tournament) (inits $ sortOn (Down . length . dominion tournament) $ players tournament) 
  

{-TTEW-}









ex10 :: [[Int]]
ex10 = [[2,3,4,5,6,8,9],[3,5,6],[5,8],[2,3,5,6,7,8,9,10],[],[3,5,8],[1,2,3,5,6,8,9],[2,5],[2,3,5,6,8],[1,2,3,5,6,7,8,9]]
-- CO: [4, 10]
-- UC: [1, 4, 10]
-- TC: [1, 4, 7, 10]

ex20 :: [[Int]]
ex20 = [[2,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,20],[3,4,5,8,10,13,15,19],[4,5,12,13,15,19,20],[6,10,13,15,19],[4,9,10,13,15,19,20],[2,3,5,9,13,15,19],[2,3,4,5,6,8,9,10,11,12,13,15,19],[3,4,5,6,9,11,13,15,19],[2,3,4,10,11,13,15,19,20],[3,6,8,11,13,15,19],[2,3,4,5,6,13,15,19],[2,4,5,6,8,9,10,11,13,15,19],[19],[1,2,3,4,5,6,7,8,9,10,11,12,13,15,17,19,20],[13,19],[2,3,4,5,6,7,8,9,10,11,12,13,14,15,18,19,20],[1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,20],[2,3,4,5,6,7,8,9,10,11,12,13,14,15,19,20],[],[2,4,6,7,8,10,11,12,13,15,19]]
-- CO: [17]
-- UC: [14,16,17]
-- TC: [1,14,16,17,18]

ex30 :: [[Int]]
ex30 = [[2,3,5,6,7,8,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30],[18,23,29],[2,7,8,10,11,14,18,19,20,21,22,23,25,26,27,28,29],[1,2,3,6,7,8,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30],[2,3,4,6,7,8,9,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30],[2,3,7,8,10,11,13,14,15,17,18,19,20,22,23,24,25,26,27,28,29,30],[2,8,10,11,14,17,18,20,22,23,24,25,26,27,28,29],[2,10,11,14,18,19,20,23,25,26,27,28],[1,2,3,4,6,7,8,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30],[2,18,23,28],[2,10,18,23,28],[2,3,6,7,8,10,11,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29],[2,3,7,8,10,11,14,17,18,19,20,21,22,23,24,25,26,27,28,29,30],[2,10,11,18,19,20,23,25,26,27,28,29],[2,3,7,8,10,11,13,14,17,18,19,20,22,23,25,26,27,28,29],[1,2,3,4,5,6,7,8,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30],[2,3,8,10,11,14,18,19,20,23,25,26,27,28,29],[23],[2,7,10,11,18,23,25,28],[2,10,11,18,19,22,23,25,26,27,28,29],[2,6,7,8,10,11,14,15,17,18,19,20,22,23,24,25,26,27,28,29,30],[2,8,10,11,14,17,18,19,23,24,25,26,27,28,29,30],[],[2,3,8,10,11,14,15,17,18,19,20,23,25,26,27,28,29],[2,10,11,18,23,28],[2,10,11,18,19,23,25,27,28],[2,10,11,18,19,23,25,28],[2,18,23],[8,10,11,18,19,23,25,26,27,28],[2,3,7,8,10,11,12,14,15,17,18,19,20,23,24,25,26,27,28,29]]
-- CO: [9,16]
-- UC: [5,9,16]
-- TC: [1,4,5,9,16]

ex35 :: [[Int]]
ex35 = [[2,3,4,5,6,7,9,12,13,14,18,19,20,21,22,23,24,25,26,27,29,30,31,34,35],[3,4,5,6,7,9,14,18,19,20,21,22,23,24,25,26,27,29,30,31,34,35],[4,5,6,12,14,18,19,20,21,22,23,24,25,26,27,29,30,31,34,35],[5,6,12,14,18,19,20,21,22,23,24,25,26,27,29,30,31,34,35],[29],[5,14,18,21,22,23,24,26,27,29,31,35],[3,4,5,6,9,12,14,18,19,20,21,22,23,24,25,26,27,29,30,31,35],[1,2,3,4,5,6,7,9,10,12,14,18,19,20,21,22,23,24,25,26,27,29,30,31,34,35],[3,4,5,6,14,18,19,21,22,23,24,25,26,27,29,30,35],[1,2,3,4,5,6,7,9,11,12,14,18,19,20,21,22,23,24,25,26,27,29,30,31,34,35],[1,2,3,4,5,6,7,8,9,12,14,18,19,20,21,22,23,24,25,26,27,29,30,31,34,35],[2,5,6,9,13,14,18,19,20,21,22,23,24,25,26,27,29,30,31,34,35],[2,3,4,5,6,7,8,9,10,11,14,18,19,20,21,22,23,24,25,26,27,29,30,31,34,35],[5,18,27,35],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,29,30,31,33,34,35],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,18,19,20,21,22,23,24,25,26,27,28,29,30,31,34,35],[5],[5,6,14,18,21,22,23,26,27,29,31,35],[5,6,9,14,18,19,21,23,26,27,29,30,31,34,35],[5,14,18,23,27,31],[5,14,18,20,21,23,27,29,30,31,35],[5,14,18,27,35],[5,14,18,19,20,21,22,23,27,29,31,35],[5,6,14,18,19,20,21,22,23,24,26,27,29,30,31,35],[5,14,18,21,22,23,24,27,29,30,31,34,35],[5,18,29,31],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,29,30,31,34,35],[14,18,21,23],[5,6,14,18,19,21,23,24,27,29,31,35],[5,9,14,18,23,29],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,34,35],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35],[5,6,7,9,14,18,19,21,22,23,24,25,27,29,30,31,35],[5,18,21,27,29,31]]
-- CO: [15,16,32,33]
-- UC: [15,16,28,32,33]
-- TC: [15,16,17,28,32,33]

ex50 :: [[Int]]
ex50 = [[2,5,7,10,11,12,13,14,17,18,19,20,21,22,23,24,26,27,29,30,31,32,33,34,35,36,37,38,39,41,42,44,49,50],[5,7,8,10,11,12,14,15,17,18,19,20,21,22,23,24,26,27,29,30,31,32,33,35,36,37,38,39,41,42,43,44,48,49,50],[1,2,5,6,7,8,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,41,42,43,44,45,46,48,49,50],[1,2,3,5,6,7,8,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,41,42,43,44,45,48,49,50],[7,11,36,37],[1,2,5,7,8,9,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],[26,36],[1,5,7,10,11,12,14,18,19,20,21,22,23,24,26,27,29,30,31,32,33,35,36,37,38,39,41,42,44,49,50],[1,2,3,4,5,7,8,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],[5,7,11,12,14,18,21,22,24,26,27,29,30,31,32,33,35,36,37,39,41,42,44,49,50],[7,27,36],[5,7,11,18,21,22,24,26,27,29,30,33,35,36,37,39,42,50],[2,5,7,8,10,11,12,14,17,18,19,20,21,22,23,24,26,27,29,30,31,32,33,34,35,36,37,38,39,41,42,43,44,49,50],[5,7,11,12,18,21,22,24,26,27,29,30,31,32,33,35,36,37,39,42,44,49,50],[1,5,7,8,10,11,12,13,14,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,41,42,43,44,45,49,50],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,41,42,43,44,45,46,47,48,49,50],[5,7,8,10,11,12,14,18,19,21,22,23,24,26,27,29,30,31,32,33,34,35,36,37,39,41,42,44,49,50],[5,7,11,22,24,26,27,29,30,32,33,36,37,39,42,44,50],[5,7,10,11,12,14,18,21,22,24,26,27,29,30,31,32,33,34,35,36,37,38,39,41,42,44,49,50],[5,7,10,11,12,14,17,18,19,21,22,24,26,27,29,30,31,32,33,34,35,36,37,38,39,41,42,44,49,50],[5,7,11,18,22,24,26,27,29,30,33,36,37,39,44],[5,7,11,27,29,36],[5,7,10,11,12,14,18,19,20,21,22,24,26,27,29,30,31,32,33,35,36,37,38,39,41,42,44,49,50],[5,7,11,22,26,27,29,33,36,39,42,50],[1,2,5,7,8,10,11,12,13,14,17,18,19,20,21,22,23,24,26,27,29,30,31,32,33,34,35,36,37,38,39,41,42,43,44,48,49,50],[5,11,22,29,33,36,39],[5,7,26,29,33,36,37,44],[1,2,5,7,8,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,41,42,43,44,45,48,49,50],[5,7,11,36,42],[5,7,11,22,24,26,27,29,33,36],[5,7,11,12,18,21,22,24,26,27,29,30,32,33,35,36,37,38,39,41,42,44,49,50],[5,7,11,12,21,22,24,26,27,29,30,33,35,36,37,39,41,42,44,50],[5,7,11,22,29,36],[2,5,7,8,10,11,12,14,18,21,22,23,24,26,27,29,30,31,32,33,35,36,37,38,39,41,42,44,49,50],[5,7,11,18,21,22,24,26,27,29,30,33,36,37,39,41,42,44,50],[],[7,11,22,24,26,29,30,33,36,42],[5,7,10,11,12,14,17,18,21,22,24,26,27,29,30,32,33,35,36,37,39,41,42,44,49,50],[5,7,11,22,27,29,30,33,36,37],[1,2,3,4,5,7,8,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,41,42,43,44,45,47,48,49,50],[5,7,11,12,14,18,21,22,24,26,27,29,30,33,36,37,39,42,44,49],[5,7,11,21,22,26,27,30,33,36,39],[1,5,7,8,10,11,12,14,17,18,19,20,21,22,23,24,26,27,29,30,31,32,33,34,35,36,37,38,39,41,42,44,48,49,50],[5,7,11,12,22,24,26,29,30,33,36,37,39,42,49],[1,2,5,7,8,10,11,12,13,14,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,41,42,43,44,48,49,50],[1,2,4,5,7,8,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,47,48,49,50],[1,2,3,4,5,7,8,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,41,42,43,44,45,48,49,50],[1,5,7,8,10,11,12,13,14,15,17,18,19,20,21,22,23,24,26,27,29,30,31,32,33,34,35,36,37,38,39,41,42,44,49,50],[5,7,11,12,18,21,22,24,26,27,29,30,32,33,35,36,37,39,42,50],[5,7,11,21,22,26,27,29,30,33,36,37,39,41,42,44]]
-- CO: [16]
-- UC: [6,9,16,40]
-- TC: [3,4,6,9,16,40,46,47]

