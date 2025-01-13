--  -- FUNCTION -- -- 
-- EXERCICES 1
cube :: Int -> Int 
cube x = x*x*x
-- EXERCICES 2
pair :: Int -> Bool 
-- pair x = x `mod` 2 == 0
pair = (==0).(mod 2)
-- EXERCICES 3
volpar :: (Float, Float, Float) -> Float
volpar (x, y, z) 
 | (x <=0) || (y<=0) || (z<=0) = error "Bad"
 | otherwise = x*y*z
-- EXERCICES 4
nombreDeSolutions :: (Float, Float, Float) -> Int
nombreDeSolutions (a,b,c) 
    |delta > 0 = 2
    |delta == 0 = 1
    | otherwise = error "Pas de solution"
    where delta = b*b -  4*a*c 
-- EXERCICES 5
aireTriangle :: Float -> Float -> Float -> Float
aireTriangle x y z 
    | (x <=0) || (y<=0) || (z<=0) = error "Bad"
    | otherwise = sqrt(p*(p - x)*(p - y)*(p - z))
                    where  p= (x+y+z)/2
-- EXERCICES 6
trouverCube ::   Int ->  [Int]
trouverCube x = if null list  then [] else head list
    where list =  [[y,z] | y <- [1..(x-1)], z <- [1..(x-2)], y /= z , x == cube y + cube z]
    
    
    
trouver ::   Int ->  [(Int,Int)]
trouver x = [(y,z) | y <- [1..(x-1)], z <- [1..(x-2)], y /= z , x == cube y + cube z]
-- EXERCICES 7
quelTriangle :: Float -> Float -> Float -> String 
quelTriangle x y z 
    | x==y && y==z = "équilatéral"
    | x==y || x==z || y==z = "isocèle"
    | otherwise = "scalène"

--  -- Réduction -- -- 
-- EXERCICES 8
-- EXERCICES 9
--  -- CurrycatioN -- -- 
-- EXERCICES 10
-- Non la function volpar  n'est pas currifier
-- version currifier: volpar :: Float -> Float -> Float -> Float
-- EXERCICES 12
curry2 :: ((a,b)->c)->(a->(b->c)) 
curry2 f = f x y
-- EXERCICES 13
uncurry2 :: (a->(b->c->d))->((a,b,c)->d)
uncurry2 f  = f (a,b,c)

--  -- Fonctions d'ordre supérieur -- -- 

-- EXERCICES 14
dollard :: (a->b) -> a
dollard f x = f x
-- EXERCICES 15
-- CAR ELLES PRENNENT UNE FONCTION COMME ARGUMENT
-- EXERCICES 16
compo :: (b->c)->(a->b)->a->c
compo g f = g.f
-- EXERCICES 17
appel3 :: (a->a) -> a
appel3 f = f.f.f
-- EXERCICES 18
update :: Eq a,b => (a->b) -> a -> b -> a -> (a->b)
update f a b  = (\c -> if a==c then b else f c)
-- EXERCICES 19
reverser :: (a->a->c) -> a -> a -> c
reverser f a b = f b a

dodo :: Int -> Int -> Int
dodo a b = (a*2) + b

-- EXERCICES 20
reverser :: ((a,a)->c) -> (a,a) -> c
reverser f (a,b) = f (b,a)

dodo :: (Int,Int) -> Int
dodo (a,b) = (a*2) + b
-- EXERCICES 21
applynTimes :: (a->a) -> a -> Int -> a
applynTimes f x 0 =  x
applynTimes f x n = applynTimes f  (f x) (n-1)

-- EXERCICES 22