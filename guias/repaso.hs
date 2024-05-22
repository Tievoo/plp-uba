data Componente = Contenedor
  | Motor
  | Escudo
  | Cañon
  deriving Eq

data Nave
    = Modulo Componente Nave Nave
    | Base Componente
    deriving Eq

recNave :: (Componente -> b) -> (Componente -> Nave -> Nave -> b -> b -> b) -> Nave -> b
recNave f1 f2 n = case n of
    Base c -> f1 c
    Modulo c n1 n2 -> f2 c n1 n2 (r n1) (r n2)
    where r = recNave f1 f2

foldNave :: (Componente -> b) -> (Componente -> b -> b -> b) -> Nave -> b
foldNave f1 f2 n = case n of
    Base c -> f1 c
    Modulo c n1 n2 -> f2 c (r n1) (r n2)
    where r = foldNave f1 f2

espejo :: Nave -> Nave
espejo = foldNave (Base) (\c r1 r2 -> Modulo c r2 r1)


esSubnavePropia :: Nave -> Nave -> Bool
esSubnavePropia n = recNave (const False) (\c n1 n2 r1 r2 -> n1 == n || n2 == n || r1 || r2)

truncar :: Nave -> Integer -> Nave
truncar = foldNave (\c -> \i -> Base c) (\c r1 r2 -> \i -> if i == 0 then Base c else (Modulo c (r1 (i-1)) (r2 (i-1)) ) )