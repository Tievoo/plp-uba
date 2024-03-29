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


