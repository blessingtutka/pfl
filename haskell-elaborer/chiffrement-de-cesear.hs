-- W'll use a module called char that has 2 method:
-- ord and chr thal hep us to translate a char to an asii code an vise versa
ord :: Char −> Int
chr :: Int −> Char
isLower :: Char −> Bool -- check if a charcter is in lower case

import Data.Char

-- ENCODEDAGE
-- Zero based position or indexing
charPosition :: Char -> Int 
charPosition c = ord c - ord 'a'

getCharAtPosition :: Int -> Char
getCharAtPosition n  = chr( ord 'a' + n)

shift :: Int -> Char -> Char
shift n c
    | isLower c = getCharAtPosition((charPosition(c) + n) `mod` 26)
    |otherwise = c
    
encode :: Int -> [Char] -> [Char]
encode key = map (shift key)

asciier :: [Char] -> [Int]
asciier = map ord


-- DECODATE WIHT AN KNOWN KEY

shiftPosition :: Int -> Int 
shiftPosition n = if n < 0 then n + 26 else n


unshift :: Int -> Char -> Char
unshift n c
    | isLower c = getCharAtPosition(shiftPosition((charPosition(c) - n)))
    |otherwise = c
    
decode :: Int -> [Char] -> [Char]
decode key = map (unshift key) 

-- CRAKING WIHT AN UNKNOWN KEY

count :: String -> [Int]
count str = map occurence ['a'..'z']
    where occurence x = length (filter (\y -> y==x) str)

perfCount :: String -> [(Char,Int)]
perfCount str = (filter (\x -> snd x /= 0 ).(map occurence)) ['a'..'z']
    where occurence x = (x , length (filter (\y -> y==x) str))

freqs :: String -> [Float]
freqs xs = map f (count xs)
    where f x = (fromIntegral x) / (fromIntegral (length xs) )
    
-- objesrved o and expected e 
chisqr :: [Float] -> [Float] -> Float
-- sqaure the different to avoid negative value and divide by e
chisqr os es = sum (map (\(o,e)->((o-e)*(o-e))/e) cs)
    where cs = (zip os es )
    
-- put the n first elements at the end of the list 
rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs

-- Find the positions of a value in a list 
positions :: Eq a => a -> [a] -> [Int]
positions x xs = map (\(a,b)->b) ls
    where ls = ( filter (\(a, b)->a == x) (zip xs [0.. n]) )
                where n = length xs - 1
        
crack :: String -> String
crack xs = encode (-factor ) xs
    -- The observed frequencies are close to the expected ones, suggesting a good fit, the best key
    where factor = head ( positions (minimum chitab) chitab)
          -- frequency of each letter in the string
          tablep = freqs xs
          -- the chi sqr statist for all posible shift
          chitab = map f [0..25]
            where f n = chisqr ( rotate n tablep ) tablep



main :: IO ()
main =  do
putStr "Exercises Elaborer: "
print(charPosition 'z')
print(getCharAtPosition 2)
print(shift 2 'z')
print(ord 'A')
print(encode 7 "benedicte")
print(decode 7 "ilulkpjal")
print(asciier "benedicte")
print(count "ilulkpjal")
print(perfCount "ilulkpjal")
print(freqs "ilulkpjal")
print(positions 'e' "benedicte")
print(crack "ilulkpjal")
