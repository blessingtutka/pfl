data Bit =  L | R deriving (Eq,Show)
type HCode = [Bit]
data Tree = Leaf Char Int | Node Int Tree Tree deriving (Eq,Show)


mergeSort :: ([a] -> [a] -> [a]) -> [a] -> [a]
mergeSort merge xs 
    |length xs < 2 = xs
    |otherwise = merge (mergeSort merge first) (mergeSort merge second)
        where first = take half xs
              second = drop half xs
              half = (length xs) `div` 2

-- Merge 2 list by sorting according to the alphabe oder and by updating the number of accurrence
alphaMerge :: [(Char,Int)] -> [(Char,Int)] -> [(Char,Int)]
alphaMerge xs [] = xs
alphaMerge [] ys = ys
alphaMerge ((p,n):xs) ((q,m):ys)
    | p == q = (p,n+m):alphaMerge xs ys
    | p < q = (p,n):alphaMerge xs ((q,m):ys)
    | p > q = (q,m):alphaMerge ((p,n):xs) ys

-- Merge 2 list by sorting according to it frequency
freqMerge :: [(Char,Int)] -> [(Char,Int)] -> [(Char,Int)]
freqMerge xs [] = xs
freqMerge [] ys = ys
freqMerge (( p,n):xs) (( q,m):ys)
    | (n < m || (n==m && p < q)) = (p,n): freqMerge xs (( q,m):ys)
    | otherwise = (q,m):freqMerge (( p,n):xs) ys

-- Merge by sorting number in ascending order for me just to understand
intMerge :: [Int] -> [Int] -> [Int]
intMerge xs [] = xs
intMerge [] ys = ys
intMerge (x:xs) (y:ys)
    | x == y = x:(intMerge xs ys)
    | x < y = x:(intMerge xs (y:ys))
    | x > y = y:(intMerge (x:xs) ys)
alphaSort = mergeSort alphaMerge
freqSort = mergeSort freqMerge

-- Order by frequency

-- The map do this: "abracadabra"  -> [(' a ',1) ,(' b ',1) ,(' r ',1) ,(' a ',1) ,(' c ',1) ,(' a ',1) ,
--(' d ',1) ,(' a ',1) ,(' b ',1) , (' r ',1) ,(' a ',1) ]
-- The alphaSort do this: map result -> [(' a ',5) ,(' b ',2) ,(' c ',1) ,(' d ',1) ,(' r ',2) ]
-- The freqSort do this: alphSort result -> [(' c ',1) ,(' d ',1) ,(' b ',2) ,(' r ',2) ,(' a ',5) ]
-- We use the point free notation
freq :: String -> [(Char,Int)]
freq = freqSort . alphaSort . map (\x ->(x,1))

-- TREE CONSTRUCTION 
-- Get the vaalue of a node depending on whether it's a node or a leaf
value :: Tree -> Int
value (Leaf _ n) = n
value (Node n _ _) = n

-- Insert a node or a leaf in the right position 
insert :: Tree -> [Tree] -> [Tree]
insert t [] = [ t ]
insert t (t1 : ts )
    | ( value t ) < (value t1 ) = t : t1 : ts
    | otherwise = t1 :( insert t ts )

-- Combine the value of two subtree to create a parent node with the child nodes value sum
combine :: Tree -> Tree -> Tree
combine t1 t2 = Node (v1+v2) t1 t2
    where v1 = value t1
          v2 = value t2

-- It insert the combined value node  in the tree
amalgamate :: [Tree] -> [Tree]
amalgamate (t1 : t2 : ts ) = insert (combine t1 t2 ) ts


makeCodes :: [Tree] -> Tree
makeCodes [t] = t
makeCodes ts = makeCodes (amalgamate ts)

-- What I learned here is that we can use data type constructors as function
-- We consrtuct the tree starting by the leaf and combining it's value 
-- map (uncurry Leaf) take my freq list  and create a list of Leaf
-- as it's  2 args currify function and my list is a list of  (char, occurence) tuple  I should uncury it
-- to pass it as one argument
makeTree :: [(Char,Int)] -> Tree
makeTree = makeCodes.map (uncurry Leaf)


-- Encodage
type Table = [(Char,HCode)]

convert :: Tree -> Table
convert = walk []

-- We traverse walk through the tree
walk :: HCode -> Tree -> [(Char,HCode)]
walk acc (Leaf c n) = [( c,acc)]
walk acc (Node n t1 t2 ) = (walk (acc++[L]) t1 ) ++ (walk (acc++[R]) t2 )

htree :: String -> Tree
htree = makeTree.freq

encodeChar :: Table -> Char -> HCode
encodeChar t c = (snd.head) (filter ((==c).fst) t )

encode :: String -> HCode
encode xs = (( foldl (++) []) .( map (encodeChar t)) ) xs
    where t = ( convert . htree ) xs


-- Decodage
decodeChar :: Tree -> HCode -> (Char,HCode)
decodeChar (Leaf c n) rs = (c, rs )
decodeChar (Node n t1 t2 ) (L: rs ) = decodeChar t1 rs
decodeChar (Node n t1 t2 ) (R:rs ) = decodeChar t2 rs

decode :: Tree -> HCode -> String
decode t cd = fst ( until ((==[]) .snd) f ("",cd) )
    where f ( st ,cd) = ( st ++[c ], cdr )
                 where (c, cdr ) = decodeChar t cd
decodeAb :: String    
decodeAb = decode ht [L,R,R,L,R,R,R,L,R,L,L,L,R,L,R,L,R,R,L,R,R,R,L]
    where ht = ( htree "abracadabra")

main :: IO ()
main =  do
putStr "CODAGE DE HUFFMAN \n"
print(convert (makeTree (freq "abracadabra")))


