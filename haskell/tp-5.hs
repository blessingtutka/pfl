
-- QUESTION 1
ilExiste :: (a->Bool) -> [a] -> Bool
ilExiste f = foldr (\x -> \r -> r || f x) False


pourTout :: (a->Bool) -> [a] -> Bool
pourTout f = foldr (\x -> \r -> r && f x) True

-- QUESTION 2

-- concat, elem, length, reverse

concate :: [[a]] -> [a] 
concate =  foldl (++) []

concateList :: [a] -> [a]-> [a] 
concateList xs ys =  foldr (:) ys xs
-- concateList xs ys =  foldl (flip (:)) ys  (reverse xs)

lengthe :: [a] -> Integer
lengthe = foldr (\x -> \r -> r + 1) 0

reversee :: [a] -> [a]
reversee = foldl (\r -> \x -> (x:r))  []
-- reversee = foldr (\x -> \r -> r ++ [x])  []

eleme :: Eq a => a -> [a] -> Bool
eleme a = foldr (\x -> \r -> if x==a then True else r  ) False

-- QUESTION 3
parenthesesOk :: String  -> Bool 
parenthesesOk str = fst r == 0 && snd r == True
    where r = foldl (\(n,ok) s -> if s =='(' then (n+1, ok) else if s==')' then (n-1,ok && (n>0)) else (n,ok)) (0,True) str

-- QUESTION 4
factorielle :: Integer -> Integer
factorielle n = foldr (*) 1 [2..n]

-- QUESTION 5
repet :: Int -> a -> [a]
repet n x = foldr (\_ -> \r -> (x:r)) [] [1..n]

-- QUESTION 6

moyenne :: [Int] -> Int
moyenne ls = fst res `div` snd res
    where res = foldl (\(s,l) -> \x -> (s+x,l+1)) (0,0) ls

-- QUESTION 7

unzipe :: [(a, b)] -> ([a], [b])
unzipe = foldr (\(x,y) (xs,ys) -> ((x:xs),(y:ys))) ([],[])

-- QUESTION 8
uniq :: Eq a => [a] -> [a] 
uniq = foldr (\x -> \r ->  if x `elem` r then r else (x:r)) []

-- QUESTION 9 

nbLettres ::  Char->String->Int
nbLettres lettre mot = foldr (\x -> \r -> if x == lettre then r+1 else r ) 0 mot

-- QUESTION 10
countLettres :: String->[(Char,Int)]
-- countLettres mot = [(x, nbLettres x mot) | x <- uniq mot]
countLettres mot = map(\x -> (x, nbLettres x mot)) $ uniq mot

-- QUESTION 11 
foldle :: (b -> a -> b) -> b ->  [a] -> b
-- foldle _ acc [] = acc
-- foldle f acc (x:xs) =  foldle f (f x acc) 
foldle f acc xs =  foldr (\x r -> f r x) acc (reverse xs)

foldre :: (a -> b -> b) -> b ->  [a] -> b
-- foldre _ r [] = r
-- foldre f r (x:xs) = f x (foldre f r xs)
foldre f r xs = foldl (\acc x -> f x acc) r (reverse xs)

-- QUESTION 12

compression ::Eq a => [a]->[(Int,a)]
compression = foldr (\x -> \acc -> case acc of 
                                            [] -> [(1,x)] 
                                            (n,e):rest -> if (x == e) then (n+1,e):rest else ((1,x):acc)) []
                                            
decompression ::Eq a => [(Int,a)]-> [a]
decompression = foldr (\(n,e) -> \acc -> take n (repeat e)  ++ acc  ) []

-- QUESTION 13
splitter :: [Char] -> String ->  [String] 
splitter sep str =  fst result ++ (if not (null (snd result)) then [snd result] else [])
        where result = foldl (\(wordList,word) -> \char -> if char `elem` sep then  
                    if not (null word) then (wordList ++ [word],"") else (wordList,"") 
                    else (wordList, word ++ [char] )) ([],"") str

-- QUESTION 14
naturelMontant :: Eq a => (Int -> a ) -> Int -> [a]
-- naturelMontant f n = map f [n,n-1..0]
-- naturelMontant f n = foldl (\r x -> r ++ [f x]) [] [n,n-1..0]
naturelMontant f n = foldr (\x r -> (f x):r) [] [n,n-1..0]

-- QUESTION 15
naturelDescandent :: Eq a => (Int -> a ) -> Int -> [a]
-- naturelDescandent f n = map f [0..n]
-- naturelDescandent f n = foldl (\r x -> r ++ [f x]) [] [0..n]
naturelDescandent f n = foldr (\x r -> (f x):r) [] [0..n]

-- QUESTION 16
fromto :: Int -> Int -> [Int]
fromto x y 
    | x <= y = [x .. y]
    -- | x <= y = foldr (:) [] [x .. y]
    -- | x <= y = foldl (\r x -> r ++ [x]) [] [x .. y]
    |otherwise = []

-- QUESTION 17
fromtoby :: Int -> Int -> Int -> [Int]
fromtoby x y s  
    | x <= y = [x, x+s .. y]
    -- | x <= y = foldr (:) [] [x, x+s .. y]
    -- | x <= y = foldl (\r x -> r ++ [x]) [] [x, x+s .. y]
    |otherwise = []
    
-- QUESTION 18
genlist :: (a -> a) -> a -> Int -> [a]
genlist f a n 
    | n == 0 = []
    |otherwise = foldr (\_ r -> a: map f r) [] [1..n]
    
    
repet :: a -> Int -> [a]
-- repet a n  = genlist id a n
repet a n  = genlist (\x -> x) a n

fromtogen :: Int -> Int -> [Int] 
fromtogen x y = genlist (+1) x (y-x+1)

-- QUESTION 19
ecrit :: Int -> [Int]
ecrit n 
    | n <=0 = []
    | otherwise = foldr (\x r -> read [x]:r ) [] (show n)

main :: IO ()
main =  do
putStr "TP5 ANSWERS \n"
print(show(compression "Bleessiinggs"))
print(show(decompression [(3, 'a'), (2, 'b'), (1, 'c')]))


