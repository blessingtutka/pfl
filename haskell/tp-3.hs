-- QUESTION 1

-- Simple/Explicite
someVecteur :: [(Float,Float)] -> Float
someVecteur [] = 0
someVecteur ((x,y):ys) = norm x y + someVecteur ys
                        where norm x y = sqrt(x*x+y*y)
                        
-- Terminal
someVecteurTerminal :: [(Float,Float)] -> Float
someVecteurTerminal vecteurs = svo vecteurs 0 
    where svo [] acc = acc
          svo ((x,y):ys) acc = svo ys (acc + norm x y )
                                where norm x y = sqrt(x*x+y*y)

-- QUESTION  2
--simple
ouCalcule  :: [Bool] -> Bool
ouCalcule [] = False
ouCalcule (b:bs) = b || ouCalcule bs

--simple
etCalcule  :: [Bool] -> Bool
etCalcule [] = True
etCalcule (b:bs) = b && etCalcule bs

--terminal 
ouCalculeTerminal :: [Bool] -> Bool 
ouCalculeTerminal xs = faux xs False
        where faux [] acc = acc
              faux (b:bs) acc = faux bs  (acc || b)
              
-- Terminal garder                              
-- ouCalculeTerminalGarde :: [Bool] -> Bool 
-- ouCalculeTerminalGarde xs = faux xs False
--         where faux 
--                     |[] acc = acc
--                     |(b:bs) acc = faux bs  (acc || b)
              
-- Implicte
ouCalculeImplicite :: [Bool] -> Bool -- utilise  le point free (non specification du dernier argumentt)
ouCalculeImplicite = foldr (\b -> \r -> r || b  ) False -- r: resultat partielle, b"l'element de la list
-- ouCalculeImplicite = foldl (\acc -> \b -> acc || b  ) False -- acc:accumulateur

-- QUESTION 3 
--simple 
compte :: (a-> Bool) -> [a] -> Int
compte _ [] = 0
compte f (x:xs)  = if f x then compte f xs + 1 else compte f xs

-- Terminal 
compteTerminal :: (a-> Bool) -> [a] -> Int
compteTerminal f xs = faux f xs 0
        where faux _ [] acc = acc
              faux f (x:xs) acc
                |f x = faux f xs (acc+1)
                |otherwise = faux f xs acc
-- Implicite
compteImplicte :: (a-> Bool) -> [a] -> Int 
compteImplicte f =  length.filter f 
-- compteImplicte f xs =  length (filter f xs)

-- QUESTION 4
--simple 
pourTout :: (a-> Bool) -> [a] -> Bool
pourTout _ [] = True
pourTout f (x:xs)  = f x && pourTout f xs

--Terminal 
pourToutTerminal :: (a-> Bool) -> [a] -> Bool
pourToutTerminal f xs = faux f xs True
            where faux _ [] acc = acc  
                  faux f (x:xs) acc = faux f xs (acc && f x)
                  
--Implicite 
pourToutImplicite :: (a-> Bool) -> [a] -> Bool
pourToutImplicite f = foldr (\x -> \r -> f x && r) True

-- QUESTION 5
-- Simple
puissance :: [Integer] -> Integer
puissance [] = 0 
puissance (x:xs) = x^x + puissance xs 

-- Terminal
puissanceTerminal :: [Integer] -> Integer
puissanceTerminal xs = faux xs 0
    where faux [] acc = acc
          faux (x:xs) acc = faux xs (acc + x^x)
          
-- Implicite
puissanceImplicite :: [Integer] -> Integer
puissanceImplicite = (foldr (+) 0).(map (\x -> x^x)) 
-- puissanceImplicite xs = foldr (+) 0 (map (\x -> x^x) xs)

-- QUESTION 6 
-- Simple 
applatir :: [[a]] -> [a]
applatir [] = []
applatir (x:xs) = x ++ applatir xs

-- Terminal 
applatirTerminal :: [[a]] -> [a]
applatirTerminal ls = faux ls []
        where faux [] acc = acc
              faux (x:xs) acc = faux xs (acc ++ x)    
-- Implicite 
applatirImplicite :: [[a]] -> [a]
applatirImplicite = foldl (\acc -> \x -> acc ++ x) [] 

-- QUESTION 7
-- Simple 
positivise :: (Ord a,Num a) => [a] -> [a]
positivise [] = []
positivise (x:xs) = if x<0 then (-x:positivise xs) else (x:positivise xs)
-- Terminal
positiviseTerminal :: (Ord a,Num a) => [a] -> [a]
positiviseTerminal ls = faux ls []
        where faux [] acc = acc
              faux (x:xs) acc 
                | x < 0 = faux xs (acc ++ [-x])
                | otherwise = faux xs (acc ++ [x])            
-- Implicite
positiviseImplicite:: (Ord a,Num a) => [a] -> [a]
positiviseImplicite = map (\x ->  if x < 0 then -x else x) -- point free
-- positiviseImplicte ls = map (\x ->  if x < 0 then -x else x) ls

-- QUESTION 8 
--Simple 
substitute :: Ord a => a -> a -> [a] -> [a]
substitute _ _ []  = [] 
substitute a b (x:xs)  = if x==a then b:substitute a b xs else x:substitute a b xs
--Terminal 
substituteTerminal :: Ord a => a -> a -> [a] -> [a]
substituteTerminal a b ls  = faux a b ls []
    where faux a b [] acc = acc
          faux a b (x:xs) acc =  faux  a b xs (if x==a then acc++[b] else acc++[x])   
--Implicite 
substituteImplicite :: Ord a => a -> a -> [a] -> [a]
substituteImplicite a b = map (\x ->  if x== a then b else x)

-- QUESTION 9

-- Simple
pop :: [a] ->  [a]
pop [x] = []
pop (x:xs) = x:pop xs

-- Terminal
popTerminal :: [a] -> [a]
popTerminal ls = faux ls [] 
    where faux [x] acc = acc
          faux (x:xs) acc = faux xs (acc ++ [x])
          
-- Implicite
popImplicite :: [a] -> [a]
-- popImplicite = init
popImplicite ls = [x | (x, i) <- zip ls [0..], i < length ls - 1]

-- QUESTION 10


-- QUESTION 11

-- Simple 
concatanate :: [String] -> String  ->String
concatanate [] _ = ""
concatanate [x] _ = x
concatanate (s:xs) sep = s ++ sep ++ concatanate xs sep


-- Terminal 
concatanateTerminal :: [String] -> String  ->String
concatanateTerminal str sep = faux str sep ""
    where faux [] _ acc = acc
          faux [x] _ acc = acc ++ x
          faux (s:xs) sep acc = faux xs sep (acc ++ s ++ sep)

-- Implicite
concatanateImplicite :: [String] -> String  ->String
concatanateImplicite str sep = foldr  (\s -> \r -> if null r then s else  r ++ sep ++ s) "" str

-- QUESTION 12

-- Simple 
mapAccumL :: (acc -> x -> (acc, y)) -> acc -> [x] -> (acc, [y])
mapAccumL f acc [] =  (acc,[])
mapAccumLSimple f acc (x:xs) = (finalAcc, mapify f xs)   
    where finalAcc = mapAccumLSimple f fst(f acc x)  xs 
          mapify _ [] = []
          mapify f (y:ys) = (snd(f acc y) : mapify ys) 

main :: IO ()
main =  do
putStr "Sum of x + y = "
print(show(concatanateImplicite ["Ichi","Ni","San"] "|" ))