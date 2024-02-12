-- CSci 117, Lab 1:  Introduction to Haskell

---------------- Part 1 ----------------

-- WORK through Chapters 1 - 3 of LYaH. Type in the examples and make
-- sure you understand the results.  Ask questions about anything you
-- don't understand! This is your chance to get off to a good start
-- understanding Haskell.


---------------- Part 2 ----------------

-- The Haskell Prelude has a lot of useful built-in functions related
-- to numbers and lists.  In Part 2 of this lab, you will catalog many
-- of these functions.

-- Below is the definition of a new Color type (also called an
-- "enumeration type").  You will be using this, when you can, in
-- experimenting with the functions and operators below.
data Color = Red | Orange | Yellow | Green | Blue | Violet
     deriving (Show, Eq, Ord, Enum)

-- For each of the Prelude functions listed below, give its type,
-- describe briefly in your own words what the function does, answer
-- any questions specified, and give several examples of its use,
-- including examples involving the Color type, if appropriate (note
-- that Color, by the deriving clause, is an Eq, Ord, and Enum type).
-- Include as many examples as necessary to illustration all of the
-- features of the function.  Put your answers inside {- -} comments.
-- I've done the first one for you (note that "λ: " is my ghci prompt).


-- succ, pred ----------------------------------------------------------------

{- 
succ :: Enum a => a -> a
pred :: Enum a => a -> a

For any Enum type, succ gives the next element of the type after the
given one, and pred gives the previous. Asking for the succ of the
last element of the type, or the pred of the first element of the type
results in an error.

λ: succ 5
6
λ: succ 'd'
'e'
λ: succ False
True
λ: succ True
*** Exception: Prelude.Enum.Bool.succ: bad argument
λ: succ Orange
Yellow
λ: succ Violet
*** Exception: succ{Color}: tried to take `succ' of last tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
λ: pred 6
5
λ: pred 'e'
'd'
λ: pred True
False
λ: pred False
*** Exception: Prelude.Enum.Bool.pred: bad argument
λ: pred Orange
Red
λ: pred Red
*** Exception: pred{Color}: tried to take `pred' of first tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
-}


-- toEnum, fromEnum, enumFrom, enumFromThen, enumFromTo, enumFromThenTo -------
-- As one of your examples, try  (toEnum 3) :: Color --------------------------

{-
toEnum :: Enum a => Int -> a
fromEnum :: Enum a => a -> Int
enumFrom :: Enum a => a -> [a]
enumFromThen :: Enum a => a -> a -> [a]
enumFromTo :: Enum a => a -> a -> [a]
enumFromThenTo :: Enum a => a -> a -> a -> [a]

The function toEnum takes in INT and coverts it into corresponding Enum type. It throws exception if given value is not within range of values.
The fucntion fromEnum takes in Enum type and converts it into corresponding INT.
The function enumFrom generates a list from the value provided till the end.
The function enumFromThen generated a list from the first value to the end but the incrementation is the difference between frist and the second value.
The function enumFromTo generates a list from the start value upto the second value.
enumFromThenTo, there is still confusion in it, but from some examples I think it takes in some difference between the first and second argument and checks it with the third one, generating a list accordingly.

ghci>toEnum 3::Color
Green
ghci>toEnum 6::Color
*** Exception: toEnum{Color}: tag (6) is outside of enumeration's range (0,5)
CallStack (from HasCallStack):
  error, called at <interactive>:10:75 in interactive:Ghci4

ghci>fromEnum Red
0
ghci>fromEnum Blue
4

ghci>enumFrom Red
[Red,Orange,Yellow,Green,Blue,Violet]
ghci>enumFrom Violet
[Violet]
ghci>enumFrom Yellow
[Yellow,Green,Blue,Violet]

ghci>enumFromThen Red Orange
[Red,Orange,Yellow,Green,Blue,Violet]
ghci>enumFromThen Green Blue
[Green,Blue,Violet]
ghci>enumFromThen Yellow Green
[Yellow,Green,Blue,Violet]
ghci> enumFromThen Red Yellow
[Red,Yellow,Blue]
ghci> enumFromThen Orange Green
[Orange,Green,Violet]

ghci> enumFromTo Red Yellow
[Red,Orange,Yellow]
ghci> enumFromTo Yellow Violet
[Yellow,Green,Blue,Violet]

ghci> enumFromThenTo Yellow Green Violet
[Yellow,Green,Blue,Violet]
ghci> enumFromThenTo Blue Green Yellow
[Blue,Green,Yellow]


-}



-- ==, /= ---------------------------------------------------------------------
{-
"==" :: String
"/=" :: String

The function "=" checks whether the first value is equal to the second value.
The function "/=" checks whether the first value does not equal second value.

ghci> 1==2
False
ghci> 1==1
True
ghci> 2/=1
True
ghci> 2/=2
False

-}

-- quot, div (Q: what is the difference? Hint: negative numbers) --------------
{-
quot :: Integral a => a -> a -> a
div :: Integral a => a -> a -> a

Both the functions "quot" & "div" performs integer division.
But they are different when one of the argument has oppposite sign. So if we divide (-7) and 3 the answer comes out to be  around -2.5 so the function 'div' rounds it up to -3, that is near -infinity whereas function 'quot' rounds up to -2, that is near 0

ghci> quot 8 2
4
ghci> quot 3 2
1
ghci> quot 10 4
2
ghci> div 3 2
1
ghci> div (-10) 5
-2
ghci> quot (-10) 5
-2
ghci> quot (-3) 2
-1
ghci> div (-3) 2
-2
ghci> div (-7) 3
-3
ghci> quot (-7) 3
-2


-}

-- rem, mod  (Q: what is the difference? Hint: negative numbers) --------------
{-
  rem :: Integral a => a -> a -> a
  mod :: Integral a => a -> a -> a

  rem and mod both gives remainder as a result of the two arguments but rem gives sign (+/-) according to the first argument whereas mod gives  according to the second argument

  ghci> rem 5 2
  1
  ghci> rem 10 5
  0
  ghci> rem (-10) 4
  -2
  ghci> rem 10 (-4)
  2
  ghci> mod 5 2
  1
  ghci> mod 10 5
  0
  ghci> mod (-10 ) 4
  2
  ghci> mod 10 (-4)
  -2
-}

-- quotRem, divMod ------------------------------------------------------------
{-
  quotRem :: Integral a => a -> a -> (a, a)
  divMod :: Integral a => a -> a -> (a, a)

  quotRem returns the result of division and remainder whereas divMod returns the division and modulus

  ghci> divMod 10 4
  (2,2)
  ghci> divMod 10 (-4)
  (-3,-2)
  ghci> divMod (-10) 4
  (-3,2)
  ghci> quotRem 10 4
  (2,2)
  ghci> quotRem (-10) 4
  (-2,-2)
  ghci> quotRem 10 (-4)
  (-2,2)

-}

-- &&, || ---------------------------------------------------------------------
{-
  "&&" :: String
  "||" :: String

  The function "&&" is like a logical operation and performs (AND).
  The function "||" is also a logical operation but it performs OR.


  ghci> True && False
  False
  ghci> True && True
  True
  ghci> True || False
  True
  ghci> True ||True
  True
  ghci> False||False
  False
-}

-- ++ -------------------------------------------------------------------------

{-
  "+" :: String

  The function "++" helps in combining two list or strings

  ghci> [1,2]++[3,4]
  [1,2,3,4]
  ghci> "Hello"++"World"
  "HelloWorld"
  ghci> [1,2,3,4]++[1,2]
  [1,2,3,4,1,2]

-}

-- compare --------------------------------------------------------------------
{-
  compare :: Ord a => a -> a -> Ordering

  The function "compare", compares two value and return EQ if both are equal, LT if left value is less than the right value & GT if left value is greater than the right value

  ghci> compare 5 7
  LT
  ghci> compare 7 7
  EQ
  ghci> compare "Hello" "Hello"
  EQ
  ghci> compare "Hello" "hello"
  LT
  ghci> compare "Hello" "World"
  LT
  ghci> compare "Hello" "Hello1"
  LT
  ghci> compare "Hello1" "Hello"
  GT
  ghci> compare "Welcome" "Hello"
  GT

-}

-- <, > -----------------------------------------------------------------------
{-
  "<" :: String
  ">" :: String

  These functions are "less than" and "greater than" operators, giving a boolean value accordingly. If the operation is correct, 'True' is returned otherwise 'False' is returned.

  ghci> 1<2
  True
  ghci> 2>1
  True
  ghci> 1>2
  False
  ghci> "Hello"<"Welcome"
  True
  ghci> "Welcome">"Hello"
  True

-}

-- max, min -------------------------------------------------------------------
{-
  max :: Ord a => a -> a -> a
  min :: Ord a => a -> a -> a

  The function 'max' and 'min' are used to print the maximum and minimum value of the arguments provided respectively.

  ghci> max 7 9
  9
  ghci> max "Hello" "Welcome"
  "Welcome"
  ghci> min 7 9
  7
  ghci> min "Hello" "Welcome"
  "Hello"

-}

-- ^ --------------------------------------------------------------------------
{-
  "^" :: String

  The function '^' is a math operator used to find the power of the argument provided. The second argument is raised to the power of first one.

  ghci> 2^ 3
  8
  ghci> 3^4
  81
  ghci> 4^4
  256
  ghci> 5^5
  3125
-}

-- concat ---------------------------------------------------------------------
{-
  concat :: Foldable t => t [a] -> [a]

  The function 'concat' combines different lists or strings into one

  ghci> concat [[1,2,3],[4,5,6]]
  [1,2,3,4,5,6]
  ghci> concat [[1,2,3],[4,5,6],[7,8,9]]
  [1,2,3,4,5,6,7,8,9]
  ghci> concat ["Hello", "World"]
  "HelloWorld"

-}

-- const ----------------------------------------------------------------------
{-
  const :: a -> b -> a

  'const' function prints the first argument ignoring the second one completely

  ghci> const 1 2
  1
  ghci> const "Hello" "World"
  "Hello"
  ghci> const 2 3
  2
  ghci> const 4 4
  4

-}

-- cycle ----------------------------------------------------------------------
{-
  cycle :: [a] -> [a]

  This function creates an infinite list of the argument provided

  ghci> cycle [1,2]
  (infinite list)
-}

-- drop, take -----------------------------------------------------------------
{-
  drop :: Int -> [a] -> [a]
  take :: Int -> [a] -> [a]

  Drop function drops the number of elements from a list specified in the argument whereas 'take' function take in specified number of elements and print it

  ghci> drop 2 [1,2,3,4]
  [3,4]
  ghci> drop 1 [1,2,3,4]
  [2,3,4]
  ghci> drop 1 "Hello"
  "ello"
  ghci> take 2 [1,2,3,4,5]
  [1,2]
  ghci> take 2 "Hello World"
  "He"

-}

-- elem -----------------------------------------------------------------------
{-
  elem :: (Foldable t, Eq a) => a -> t a -> Bool

  'elem' function gives a boolean value accordingly, if a element given in argument is present in the list or not.

  ghci> elem 2 [1,2,3,4]
  True
  ghci> elem 4 [1,2,3]
  False
  ghci> elem h "Hello"

  <interactive>:225:6: error: Variable not in scope: h :: Char
  ghci> elem 'h' "Hello"
  False
  ghci> elem 'H' "Hello"
  True

-}

-- even -----------------------------------------------------------------------
{-
  even :: Integral a => a -> Bool

  'even' function returns a boolean value after checking if the given argument is even or not

  ghci> even 2
  True
  ghci> even 3
  False

-}

-- fst ------------------------------------------------------------------------
{-
  fst :: (a, b) -> a

  This function takes in two arguments and returns the first one.

  ghci> fst  ("Hello", "World")
  "Hello"
  ghci> fst (1,2)
  1
  ghci> fst (3,4)
  3

-}

-- gcd ------------------------------------------------------------------------
{-
  gcd :: Integral a => a -> a -> a

  gcd function gives greatest common divisor of the two arguments provided

  ghci> gcd 4 12
  4
  ghci> gcd 12 24
  12
  ghci> gcd 100 10
  10
  ghci> gcd 4 3
  1

-}

-- head -----------------------------------------------------------------------
{-
  head :: [a] -> a

  'head' function take in as a list or a string and prints the first character 

  ghci> head "Hello"
  'H'
  ghci> head [1,2,3,4]
  1

-}

-- id -------------------------------------------------------------------------
{-
  id :: a -> a

  'id' function takes in an argument and print it without changing it.

  ghci> id 2
  2
  ghci> id "Hello"
  "Hello"
  ghci> id 3
  3
  ghci> id "Welcome"
  "Welcome"
  ghci> id 10
  10

-}

-- init -----------------------------------------------------------------------

{-
  init :: [a] -> [a]

  'init' function take in list or string as an argument and print it without the last element or character.

  ghci> init [1,2,3,4]
  [1,2,3]
  ghci> init "Welcome"
  "Welcom"
  ghci> init [5,6,7,8,9]
  [5,6,7,8]
-}

-- last -----------------------------------------------------------------------
{-
  last :: [a] -> a

  'last' function takes in a list or a string and prints the last element or the last character

  ghci> last "Hello"
  'o'
  ghci> last [1,2,3,4]
  4
  ghci> last "Welcome"
  'e'
  ghci> last [1,2]
  2
-}

-- lcm ------------------------------------------------------------------------
{-
  lcm :: Integral a => a -> a -> a

  'lcm' function gives the least common multiple of the arguments provided

  ghci> lcm 1 2
  2
  ghci> lcm 4 2
  4
  ghci> lcm 3 2
  6
  ghci> lcm 10 100
  100
-}

-- length ---------------------------------------------------------------------
{-
  length :: Foldable t => t a -> Int
  
  'length' function gives the length of the list or the string provided in the argument 

  ghci> length [1,2,3,4]
  4
  ghci> length "Hello"
  5
  ghci> length [7,8,9,0]
  4
  ghci> length "Welcome"
  7

-}

-- null -----------------------------------------------------------------------
{-
  null :: Foldable t => t a -> Bool

  'null' function returns a boolean value accordingly, if the argument (list or string) is empty or not
  ghci> null [1,2,3]
  False
  ghci> null []
  True
  ghci> null "hello"
  False
  ghci> null""
  True
-}

-- odd ------------------------------------------------------------------------
{-
  odd :: Integral a => a -> Bool

  'odd' function returns True if the argument is odd otherwise False

  ghci> odd 1
  True
  ghci> odd 2
  False
  ghci> odd 3
  True
  ghci> odd 4
  False

-}

-- repeat ---------------------------------------------------------------------
{-
  repeat :: a -> [a]

  This function prints infinite number of the argument given

  ghci> repeat 4
  (infinite 4)
-}

-- replicate ------------------------------------------------------------------
{-
  replicate :: Int -> a -> [a]

  This function creates a list with specific number of identical elements provided in the argument.

  ghci> replicate 3 2
  [2,2,2]
  ghci> replicate 2 "Hi"
  ["Hi","Hi"]
  ghci> replicate 5 "Welcome"
  ["Welcome","Welcome","Welcome","Welcome","Welcome"]
-}


-- reverse --------------------------------------------------------------------
{-
  reverse :: [a] -> [a]

  It reverses the elements or characters of the list or string provided in the argument 

  ghci> reverse "hello"
  "olleh"
  ghci> reverse [1,2,3,4,5]
  [5,4,3,2,1]
  ghci> reverse "Welcome"
  "emocleW"
-}

-- snd ------------------------------------------------------------------------
{-
  snd :: (a, b) -> b

  It takes in two arguments and prints the second one 

  ghci> snd (1,2)
  2
  ghci> snd (3,4)
  4
  ghci> snd (5,6)
  6
  ghci> snd (1, "Hello")
  "Hello"
-}

-- splitAt --------------------------------------------------------------------
{-
  splitAt :: Int -> [a] -> ([a], [a])

  This function takes in int and list of int as the arguments and split the list from the int provided in the arguement

  ghci> splitAt 3 [1,2,3,4,5,6]
  ([1,2,3],[4,5,6])
  ghci> splitAt 2 [1,2,3,4,5,6]
  ([1,2],[3,4,5,6])
  ghci> splitAt 5 [1,2,3,4,5]
  ([1,2,3,4,5],[])
  ghci> splitAt 6 [1,2,3,4,5,6]
  ([1,2,3,4,5,6],[])
-}

-- zip ------------------------------------------------------------------------
{-
  zip :: [a] -> [b] -> [(a, b)]

  It takes two list as the arguments and form pairs of each element with the corresponding element of the other list.
  If the elements are not equal it will form pairs until one of the list is completely used.

  ghci> zip [1,2] [3,4]
  [(1,3),(2,4)]
  ghci> zip [1,2,3] ['a','b','c']
  [(1,'a'),(2,'b'),(3,'c')]
  ghci> zip [1,2,3] ['a','b']
  [(1,'a'),(2,'b')]
-}


-- The rest of these are higher-order, i.e., they take functions as
-- arguments. This means that you'll need to "construct" functions to
-- provide as arguments if you want to test them.

-- all, any -------------------------------------------------------------------
{-
all :: Foldable t => (a -> Bool) -> t a -> Bool
any :: Foldable t => (a -> Bool) -> t a -> Bool

'all' takes in function  and a list and checks if the function holds true for EVERY element in the list.
'any' also takes in function  and a list and checks if the function holds true for ANY element in the list.


ghci> all (>0) [1,2,3,4]
True
ghci> all (<0) [1,2,3,4,-1]
False
ghci> all (<0) [-1,-2]
True
ghci> any (>0) [-1,-2,-3]
False
ghci> all (>2) [1,2,3,4,5]
False
ghci> all (>3) [3,4,5,6,7]
False
ghci> any (<2) [1,2,3,4,5]
True

-}

-- break ----------------------------------------------------------------------
{-
break :: (a -> Bool) -> [a] -> ([a], [a])

'break' takes in functions and a list and breaks the list at first element for which function holds true and returns both halves

ghci> break (>1) [0,1,2,3,4]
([0,1],[2,3,4])
ghci> break (>0) [-1,-2,0,1,2]
([-1,-2,0],[1,2])
ghci> break (<0) [1,2,3,4,5,6]
([1,2,3,4,5,6],[])
ghci> break (<2) [3,4,5,6,7,0,1]
([3,4,5,6,7],[0,1])
-}

-- dropWhile, takeWhile -------------------------------------------------------
{-
dropWhile :: (a -> Bool) -> [a] -> [a]
takeWhile :: (a -> Bool) -> [a] -> [a]

dropWhile takes in function and a list. It will continue to drop elements from the list until the function becomes false and then it prints rest of the list as it is.
takeWhile also takes in function and a list. It will continue to print the elements from the list until the function becomes false and then it stops right there.


ghci> dropWhile (<2) [1,2,3,4,5]
[2,3,4,5]
ghci> dropWhile (<2) [4,5,6,7,1,0,2]
[4,5,6,7,1,0,2]
ghci> dropWhile (<2) [1,0,2,3,4]
[2,3,4]
ghci> dropWhile (<0) [-1,-2,3,4,5,-3]
[3,4,5,-3]
ghci> takeWhile (>2) [1,2,3,4,5]
[]
ghci> takeWhile (>2) [3,4,5,2,1]
[3,4,5]
ghci> takeWhile (>0) [1,2,3,4,-1]
[1,2,3,4]
ghci> takeWhile (>0) [-1,-2,1,2,3,4]
[]
-}

-- filter ---------------------------------------------------------------------
{-
filter :: (a -> Bool) -> [a] -> [a]

'filter' uses functions and return the corresponding elements from the list taken in as arguments

ghci> filter even [1,2,3,4,5]
[2,4]
ghci> filter odd [1,2,3,4,5]
[1,3,5]
ghci> filter even [0,1,2]
[0,2]

-}

-- iterate --------------------------------------------------------------------
{-
iterate :: (a -> a) -> a -> [a]

In this function I wasn't able to able to figure out much but what i could get from 2-3 examples below is it takes in arguments on many times we need to run the loop before it stops (base case).

ghci> take 5 (iterate (*2) 1)
[1,2,4,8,16]
ghci> take 10 (iterate (*3) 2)
[2,6,18,54,162,486,1458,4374,13122,39366]
ghci> take 2 (iterate (*100) 100)
[100,10000] 

-}

-- map ------------------------------------------------------------------------
{-
map :: (a -> b) -> [a] -> [b]

map takes in a function and a list and applies that function on the list. 

ghci> map succ [1,2,3,4,5]
[2,3,4,5,6]
ghci> map length ["abcd"]
[4]
ghci> map (>5) [1,2,3,4,5,6,7,8,9,0]
[False,False,False,False,False,True,True,True,True,False]
ghci> map (+1) [1,2,3,4,5]
[2,3,4,5,6]

-}

-- span -----------------------------------------------------------------------
{-
span :: (a -> Bool) -> [a] -> ([a], [a])

'span' function take function and an list in the arguments, then it splits the list into two different lists at the point where the function becomes false,.

ghci> span (<3) [1,2,3,4,5,6]
([1,2],[3,4,5,6])
ghci> span (<2) [4,5,1,3,4,51,0]
([],[4,5,1,3,4,51,0])
ghci> span (<3) [1,2,-1,-2,3,4,5,1]
([1,2,-1,-2],[3,4,5,1])
ghci> span (>1) [-1,-2,0,2,3,4,5]
([],[-1,-2,0,2,3,4,5])
ghci> span (>1) [2,3,4,5,1,0,-1]
([2,3,4,5],[1,0,-1])

-}

