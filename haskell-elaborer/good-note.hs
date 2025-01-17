
mycurry :: ((a,b)-> c) -> a -> b -> c
mycurry f a b = f (a,b)


myuncurry ::  (a-> b -> c) -> (a,b) -> c
myuncurry f (a,b) = f a b

mysum :: Int -> Int -> Int
mysum a b =  a + b

data Shape = Circle Float | Rectangle Float Float

isRound :: Shape -> Bool
isRound (Circle _) = True
isRound (Rectangle _ _) = False


main :: IO ()
main =  do
putStr "Sum of x + y = "
print (show(mycurry fst 1 2))
print (show(myuncurry mysum (1,2)))
