-- -------------------- Ejercicio 1

max2 :: (Float, Float) -> Float
max2 (x, y) | x >= y = x
            | otherwise = y

normaVectorial :: (Float, Float) -> Float
normaVectorial (x, y) = sqrt (x^2 + y^2)

subtract2 :: Float -> Float -> Float
subtract2 = flip (-)

predecesor :: Float -> Float
predecesor = subtract2 1

evaluarEnCero :: (Float -> Float) -> Float
evaluarEnCero = \f -> f 0

dosVeces :: (Float -> Float) -> Float -> Float
dosVeces = \f -> f . f

flipAll :: [a -> b -> c] -> [b -> a -> c] 
flipAll = map flip

--No entendí este typing
flipRaro :: b -> (a -> b -> c) -> a -> c
flipRaro = flip flip


-- -------------------- Ejercicio 2

curry2 :: ((a, b) -> c) -> a -> b -> c
curry2 f = \x y -> f (x, y)

uncurry2:: (a -> b -> c) -> (a, b) -> c
uncurry2 f = \(x,y) -> f x y

-- -------------------- Ejercicio 3

-- (I)
sum' :: Num a => [a] -> a
sum' a = foldr (+) 0 a

elem' :: Eq a => a -> [a] -> Bool
elem' n a = foldr (\x rec -> rec || x == n ) False a

app' :: [a] -> [a] -> [a]
app' xs ys = foldr (:) ys xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' f a = foldr (\x acc -> if f x then (x:acc) else acc) [] a 

map' :: (a -> b) -> [a] -> [b]
map' f a = foldr (\x acc -> (f x:acc)) [] a

-- (II)

mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f a= foldr1 (\x acc -> if f x acc then x else acc) a

-- (III)

sumasParciales :: Num a => [a] -> [a]
sumasParciales xs = tail (scanl (+) 0 xs)

-- (IV)

sumaAlt :: Num a => [a] -> a
sumaAlt xs = foldr (-) 0 xs



-- -------------------- Ejercicio 5

elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares [] = []
elementosEnPosicionesPares (x:xs) = if null xs then [x] else x : elementosEnPosicionesPares (tail xs)

entrelazar :: [a] -> [a] -> [a]
entrelazar [] = id
entrelazar (x:xs) = \ys -> if null ys then x : entrelazar xs [] else x : head ys : entrelazar xs (tail ys)

-- La primera si pq es estructural y fin
-- el otro no pq usa el coso con el coso (entendes)

--no se como hacerla con foldr



-- -------------------- Ejercicio 6

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna n xs = recr (\x xs rec -> if x == n then xs else x : rec) [] xs

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado n xs = recr (\x xs rec -> if x < n then x : rec else n : x : xs) [] xs

-- -------------------- Ejercicio 8

-- (I)

mapPares :: (a -> b -> c) -> [(a,b)] -> [c]
mapPares f = map (uncurry f)

-- (II)

armarPares :: [a] -> [b] -> [(a,b)]
-- Without using zip
armarPares [] _ = []
armarPares _ [] = []
armarPares (x:xs) (y:ys) = (x, y) : armarPares xs ys

-- (III)

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = mapPares f (armarPares xs ys)

-- -------------------- Ejercicio 10

generate :: ([a] -> Bool) -> ([a] -> a) -> [a]
generate stop next = generateFrom stop next []

generateFrom:: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
generateFrom stop next xs | stop xs = init xs
                          | otherwise = generateFrom stop next (xs ++ [next xs])

-- (I)

generateBase :: ([a] -> Bool) -> a -> (a -> a) -> [a]
generateBase stop base next = generate stop (\l -> if null l then base else next (last l))

-- (II)

factoriales :: Int -> [Int]
factoriales n = generate (\l -> length l > n) next
    where
        next :: [Int] -> Int
        next [] = 1
        next l = product [1..(length l)]

-- (III)

iterateN :: Int -> (a -> a) -> a -> [a]
iterateN n f x = generateBase (\l -> length l > n) x f

-- (IV)

-- idk

-- -------------------- Ejercicio 11

foldNat :: (Integer -> a -> a) -> a -> Integer -> a
foldNat _ b 0 = b
foldNat f b n = f n (foldNat f b (n-1))

potencia :: Integer -> Integer -> Integer
potencia n = foldNat (\x r ->  r * n) 1


-- -------------------- Ejercicio 12

data Polinomio a = X
                    | Cte a
                    | Suma (Polinomio a) (Polinomio a)
                    | Prod (Polinomio a) (Polinomio a)

foldPoli :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b 
foldPoli f1 f2 f3 f4 t = case t of
    X -> f1
    Cte x -> f2 x
    Suma t k -> f3 (r t) (r k)
    Prod t k -> f4 (r t) (r k)
    where r = foldPoli f1 f2 f3 f4

evaluar :: Num a => a -> Polinomio a -> a
evaluar x = foldPoli x id (+) (*)

-- -------------------- Ejercicio 13

data AB a = Nil | Bin (AB a) a (AB a)

foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB f1 f2 t = case t of
    Nil -> f1
    Bin i x d ->  f2 (r i) x (r d)
    where r = foldAB f1 f2

recAB :: b -> (AB a -> a -> AB a -> b -> b -> b) -> AB a -> b
recAB f1 f2 t = case t of
    Nil -> f1
    Bin i x d -> f2 i x d (r i) (r d)
    where r = recAB f1 f2

-- (II)

esNil :: AB a -> Bool
esNil (Nil) = True
esNil (Bin i r d) = False

altura :: AB a -> Integer
altura = foldAB 1 (\i x d -> 1 + max i d)

cantNodos :: AB a -> Integer
cantNodos = foldAB 1 (\i x d -> 1 + i+d)

-- (III)

mejorSegunAB :: (a -> a -> Bool) -> AB a -> a
mejorSegunAB f (Bin i1 x1 d1) = foldAB x1 (\ir x dr -> comp (comp ir x1) dr) (Bin i1 x1 d1)
    where comp x y = if f x y then x else y

-- (IV)

esABB :: Ord a => AB a -> Bool
esABB = recAB True f
    where f i v d ri rd 
                | esNil i && esNil d = True
                | esNil d = ri && raiz i <= v
                | esNil i = rd && raiz d > v
                | otherwise = ri && rd && raiz i <= v && raiz d > v

raiz :: AB a -> a
raiz (Bin i r d) = r

abb = Bin (Bin (Bin Nil 5 Nil) 7 (Bin Nil 9 Nil) ) 10 (Bin (Bin Nil 11 Nil) 15 (Bin Nil 16 Nil))