


-- QUESTION 1


-- QUESTION 2
-- data Erreur = Erreur String
data Const = Entier Int | Car Char |Booleen Bool
    deriving (Eq,Show)

data Expr = ExprConst Const | Add Expr Expr | Equal Expr Expr | Neg Expr | If Expr Expr Expr
    deriving (Eq,Show)

data TypeExpr = Int | Char | Bool | Erreur String
    deriving (Eq,Show)
typeExpr :: Expr -> TypeExpr 
-- emun (ExprConst (Entier _)) = Int
-- emun (ExprConst (Car _)) = Char
-- emun (ExprConst (Booleen _)) = Bool
typeExpr (ExprConst c) =  case c of -- the base case 
        Entier _ -> Int
        Car _ -> Char 
        Booleen _ -> Bool
typeExpr (Add e1 e2) = 
    if (typeExpr e1 == Int) && (typeExpr e2 == Int) 
    then Int
    else Erreur "Doit etre un Nombre" 
    
typeExpr (Equal e1 e2) =
    if (typeExpr e1) ==  (typeExpr e2)
    then typeExpr e1
    else Erreur "e1 et e2 doivent etre du meme type" 
typeExpr (Neg e) =
    if (typeExpr e == Bool)
    then Bool
    else Erreur "Doit etre un booleen" 
typeExpr (If e1 e2 e3) =
    if (typeExpr e1 == Bool) 
        then if (typeExpr e2) == (typeExpr e3)
             then typeExpr e2
             else Erreur "e1 et e2 doivent etre du meme type" 
        else Erreur "Condition non approprie"

testExpr :: Expr
testExpr = If (Neg (ExprConst (Booleen False)))
              (Add (ExprConst (Entier 5)) (ExprConst (Entier 3)))
              (ExprConst (Entier 10)) 
        

main :: IO ()
main =  do
putStr "Sum of x + y = "
print(show(isRound (Rectangle 2 3)))
print(show(typeExpr testExpr))

