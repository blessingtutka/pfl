data Command = Set String Int
 | Add String Int
 | Sub String Int
 | Mul String Int
 deriving (Eq, Show)
 
getWords :: String -> [String]
getWords str = if not (null (fst res)) then fst res:snd res else snd res
                where res = foldr (\char (word,phrase)-> if (char `elem` " ") 
                                                  then ("",if null word then phrase else word : phrase) 
                                                  else (char:word,phrase)) ("",[]) str
      
      
parseCommand :: String -> Maybe Command
parseCommand str = fAux $  getWords str 
            where fAux [op,var,val] 
                        |op == "set" = Just(Set var (read val))
                        |op == "add" = Just(Add var (read val))
                        |op == "sub" = Just(Sub var (read val))
                        |op == "mul" = Just(Mul var (read val))
                        |otherwise = Nothing
                                            
main :: IO ()
main =  do
putStr "Sum of x + y = "
print(parseCommand "mul z 2 " )