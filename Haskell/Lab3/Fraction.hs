module Fraction (Fraction, frac) where

-- Fraction type. ADT maintains the INVARIANT that every fraction Frac n m
-- satisfies m > 0 and gcd n m == 1. For fractions satisfying this invariant
-- equality is the same as literal equality (hence "deriving Eq")

data Fraction = Frac Integer Integer deriving Eq


-- Public constructor: take two integers, n and m, and construct a fraction
-- representing n/m that satisfies the invariant, if possible (the case
-- where this is impossible is when m == 0).

frac :: Integer -> Integer -> Maybe Fraction
frac _ 0 = Nothing
frac n m
   | m' > 0 = Just (Frac n' m')
   | otherwise = Just (Frac (-1*n') (-1*m)) where
     d = gcd n m
     n' = div n d
     m' = div m d

-- Show instance that outputs Frac n m as n/m

instance Show Fraction where
show (Frac n 1) = show n
show (Frac n m) = show n ++ "/" ++ show m


-- Ord instance for Fraction

instance Ord Fraction where
compare (Frac n1 m1) (Frac n2 m2) = compare (n1 * m2) (n2 * m1)

-- Num instance for Fraction

instance Num Fraction where

-- Addition of fractions
(Frac n1 m1) + (Frac n2 m2) = frac (n1*m2 + n2*m1) (m1*m2)

-- Subtraction of fractions
(Frac n1 m1) - (Frac n2 m2) = frac (n1*m2 - n2*m1) (m1*m2)

-- Multiplication of fractions
(Frac n1 m1) * (Frac n2 m2) = frac (n1*n2) (m1*m2)

-- Absolute value of a fraction
abs (Frac n m) = Frac (abs n) m

-- Signum of a fraction
-- signum (Frac n m) = Frac (signum n )m   (DOUBT- didn't run)

-- Conversion from an integer to a fraction
-- DOUBT


