-- Question 1
chem :: Eq(a) => [(a,a)] -> a -> a -> Bool
chem [] _ _ = True
chem [( x , y )] a b = a == x && b == y
chem (( x , y ): ls ) a b = x == a && chem ls y b

-- Without using an Accumulator

chemTerminal :: Eq(a) => [(a,a)] -> a -> a -> Bool
chemTerminal [] _ _ = False
chemTerminal (( x , y ): ls ) a b 
    | x == a && y == b = null ls
    | x == a = chemTerminal ls y b
    | otherwise = False

chemImplicite ::  Eq(a) => [(a,a)] -> a -> a -> Bool
chemImplicite ls a b  = snd $ foldr (\(x,y) (current,res)-> if x == current then (y, res || y == b) else (current,res)) (a,False) ls

-- Question 4
type EscapeGame = [ Room ]
data Room = NormalRoom Int [ Puzzle ] | FinalRoom Int String
type Puzzle = ( Char , Description , Clue )
-- Either char or nt mean that a clue can refers to a room or a puzzle
type Clue = ( String , ( Either Char Int ))
type Description = String


getRoonClues :: Room -> [Clue]
getRoonClues (FinalRoom _ _) = []
getRoonClues (NormalRoom _ puzzles) = foldr (\(_,_,clue) r -> (clue:r) ) [] puzzles


allClues :: EscapeGame -> [Clue]
allClues rooms  = foldl (\r room -> r ++ getRoonClues room ) [] rooms


getRoomClues :: [Clue] -> [Int]
getRoomClues clues = map getRoomClue $ filter isRoomClue clues
  where
    isRoomClue (_, Left _)  = False
    isRoomClue (_, Right _) = True
    getRoomClue ( _ , ( Right room )) = room

getRoomIds :: [Room] -> [Int]
getRoomIds rooms = map extractId rooms
  where
    extractId (FinalRoom idd _)   = idd
    extractId (NormalRoom idd _) = idd

reachableRooms :: EscapeGame -> [Int]
reachableRooms rooms = filter (\ids -> ids `elem` getRoomClues(allClues(rooms)) )  $  getRoomIds rooms


game :: EscapeGame
game = [ NormalRoom 1 [('a', "desc1", ("clue1", Left 'x'))]
       , NormalRoom 2 [('b', "desc2", ("clue2", Right 2))]
       , FinalRoom 3 "Congratulations!"
       ]

main :: IO ()
main =  do
putStr "Janvier 2022 \n"
print(allClues game)
print(reachableRooms game)