-- CSci 117, Lab 2:  Functional techniques, iterators/accumulators,
-- and higher-order functions. Make sure you test all of your functions,
-- including key tests and their output in comments after your code.


---- Part 1: Basic structural recursion ----------------

-- 1. Merge sort

-- Deal a list into two (almost) equal-sizes lists by alternating elements
-- For example, deal [1,2,3,4,5,6,7] = ([1,3,5,7], [2,4,6])
-- and          deal   [2,3,4,5,6,7] = ([2,4,6], [3,5,7])
-- Hint: notice what's happening between the answers to deal [2..7] and
-- deal (1:[2..7]) above to get an idea of how to approach the recursion
deal :: [a] -> ([a],[a])
deal [] = ([],[])
deal (x:xs) = let (ys,zs) = deal xs
              in (x: zs, ys)

{- 
  Example:
  ghci> deal [1,2,3,4,5,6,7,8]
([1,3,5,7],[2,4,6,8])
-}



-- Now implement merge and mergesort (ms), and test with some
-- scrambled lists to gain confidence that your code is correct
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y = x: merge xs (y:ys)
  | x > y  = y: merge (x:xs) ys 

  {- 
    Example:
    ghci> merge [1,2,3] [4,5,6]
    [1,2,3,4,5,6]
  -}


ms :: Ord a => [a] -> [a]
ms [] = []
ms [x] = [x]
ms xs = merge (ms as)(ms bs)   -- general case: deal, recursive call, merge
  where
  (as, bs) = deal xs

  {- 
    Example:
    ghci> ms [1,4,5,3,2,7,8]
    [1,2,3,4,5,7,8]
  -}




-- 2. A backward list data structure 

-- Back Lists: Lists where elements are added to the back ("snoc" == rev "cons")
-- For example, the list [1,2,3] is represented as Snoc (Snoc (Snoc Nil 1) 2) 3
data BList a = Nil | Snoc (BList a) a deriving (Show,Eq)

-- Add an element to the beginning of a BList, like (:) does
cons :: a -> BList a -> BList a
cons x Nil = Snoc Nil x
cons x (Snoc xs y) = Snoc (cons x xs) y

-- Convert a usual list into a BList (hint: use cons in the recursive case)
toBList :: [a] -> BList a
toBList [] = Nil
toBList (x:xs) = cons x (toBList xs)

-- Add an element to the end of an ordinary list
snoc :: [a] -> a -> [a]
snoc [] y = [y]
snoc (y:xs) x = y:(snoc xs x)

-- Convert a BList into an ordinary list (hint: use snoc in the recursive case)
fromBList :: BList a -> [a]
fromBList Nil = []
fromBList (Snoc xs y) = snoc (fromBList xs) y

{-
  Examples:
  ghci> cons 1 (Snoc (Snoc Nil 2) 3)
  Snoc (Snoc (Snoc Nil 1) 2) 3

  ghci> toBList [1,2,3,4,5]
  Snoc (Snoc (Snoc (Snoc (Snoc Nil 1) 2) 3) 4) 5

  ghci> snoc [1,2,3,4]5
  [1,2,3,4,5]

  ghci> fromBList (Snoc (Snoc (Snoc Nil 1) 2) 3)
  [1,2,3]
-}


-- 3. A binary tree data structure
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Eq)

-- Count number of Empty's in the tree
num_empties :: Tree a -> Int
num_empties Empty = 1
num_empties (Node _ lt1 lt2) = (num_empties lt1) + (num_empties lt2)

-- Count number of Node's in the tree
num_nodes :: Tree a -> Int
num_nodes Empty = 0
num_nodes (Node _ subtr1 subtr2) = 1 + num_nodes(subtr1) + num_nodes(subtr2)


-- Insert a new node in the leftmost spot in the tree
insert_left :: a -> Tree a -> Tree a
insert_left x Empty = Node x Empty Empty
insert_left z (Node y t1 t2) = Node y (insert_left z t1) t2

-- Insert a new node in the rightmost spot in the tree
insert_right :: a -> Tree a -> Tree a
insert_right x Empty = Node x Empty Empty
insert_right z (Node y t1 t2) = Node y t1 (insert_right z t2)

-- Add up all the node values in a tree of numbers
sum_nodes :: Num a => Tree a -> a
sum_nodes Empty = 0
sum_nodes (Node x t1 t2) = x + (sum_nodes t1) + (sum_nodes t2)

-- Produce a list of the node values in the tree via an inorder traversal
-- Feel free to use concatenation (++)
inorder :: Tree a -> [a]
inorder Empty = []
inorder (Node x t1 t2) = (inorder t1) ++ [x] ++ (inorder t2)

{-
  Examples:
  ghci> tree1 = Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty)
  ghci> num_empties tree1
  4
  ghci> num_nodes tree1
  3
  ghci> insert_right 4 tree1
  Node 1 (Node 2 Empty Empty) (Node 3 Empty (Node 4 Empty Empty))
  ghci> insert_left 5 tree1
  Node 1 (Node 2 (Node 5 Empty Empty) Empty) (Node 3 Empty Empty)
  ghci> tree1
  Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty)

-}



-- 4. A different, leaf-based tree data structure
data Tree2 a = Leaf a | Node2 a (Tree2 a) (Tree2 a) deriving Show

-- Count the number of elements in the tree (leaf or node)
num_elts :: Tree2 a -> Int
num_elts (Leaf a) = 1
num_elts (Node2 a lst rst) = 1 + num_elts lst + num_elts rst

-- Add up all the elements in a tree of numbers
sum_nodes2 :: Num a => Tree2 a -> a
sum_nodes2 (Leaf a) = a
sum_nodes2 (Node2 a lst rst) = sum_nodes2 lst + a + sum_nodes2 rst

-- Produce a list of the elements in the tree via an inorder traversal
-- Again, feel free to use concatenation (++)
inorder2 :: Tree2 a -> [a]
inorder2 (Leaf a) = [a]
inorder2 (Node2 a lst rst) = inorder2 lst ++ [a] ++ inorder2 rst

-- Convert a Tree2 into an equivalent Tree1 (with the same elements)
conv21 :: Tree2 a -> Tree a
conv21  (Leaf a) = Node a Empty Empty
conv21 (Node2 a lst rst) = (Node a (conv21 lst) (conv21 rst))

{-
    CONFUSION in creating specific bst tree!
-}



---- Part 2: Iteration and Accumulators ----------------


-- Both toBList and fromBList from Part 1 Problem 2 are O(n^2) operations.
-- Reimplement them using iterative helper functions (locally defined using
-- a 'where' clause) with accumulators to make them O(n)
toBList' :: [a] -> BList a
toBList' xs = help xs Nil 
 where
  help [] a = a
  help (x:xs) a = help xs (Snoc a x)

fromBList' :: BList a -> [a]
fromBList' xs = help xs [] 
 where
  help Nil a = a
  help (Snoc xs x) a  = help xs (x:a)


-- Even tree functions that do multiple recursive calls can be rewritten
-- iteratively using lists of trees and an accumulator. For example,
sum_nodes' :: Num a => Tree a -> a
sum_nodes' t = sum_nodes_help [t] 0
 where
  sum_nodes_help :: Num a => [Tree a] -> a -> a
  sum_nodes_help [] a = a
  sum_nodes_help (Empty:ts) a = sum_nodes_help ts a
  sum_nodes_help (Node n t1 t2:ts) a = sum_nodes_help (t1:t2:ts) (n+a)

-- Use the same technique to convert num_empties, num_nodes, and sum_nodes2
-- into iterative functions with accumulators

num_empties' :: Tree a -> Int
num_empties' a = helper [a] 0 
 where
    helper :: [Tree a] -> Int -> Int
    helper [] a = a
    helper (Empty: s) a = helper s (a+1)
    helper (Node x lst rst:s) a = helper (lst: rst: s) a

num_nodes' :: Tree a -> Int
num_nodes' t = num_nodes_help [t] 0 
 where
  num_nodes_help :: [Tree a] -> Int -> Int
  num_nodes_help [] a = a
  num_nodes_help (Empty:ts) a = num_nodes_help ts (a)
  num_nodes_help (Node n t1 t2:ts) a = num_nodes_help (t1:t2:ts) (a+1)


sum_nodes2' :: Num a => Tree2 a -> a
sum_nodes2'  t = sum_nodes2_help [t] 0 
 where
  sum_nodes2_help :: Num a => [Tree2 a] -> a -> a
  sum_nodes2_help [Leaf n] a = a+n
  sum_nodes2_help (Leaf n:ts) a = sum_nodes2_help ts (a+n)
  sum_nodes2_help (Node2 n t1 t2:ts) a = sum_nodes2_help (t1:t2:ts) (n+a)

-- Use the technique once more to rewrite inorder2 so it avoids doing any
-- concatenations, using only (:).
-- Hint 1: (:) produces lists from back to front, so you should do the same.
-- Hint 2: You may need to get creative with your lists of trees to get the
-- right output.
inorder2' :: Tree2 a -> [a]
inorder2' t = inorder2_help [t] [] 
 where
  inorder2_help [Leaf n] a = n:a
  inorder2_help (Leaf n:ts) a = inorder2_help ts (n:a)
  inorder2_help ((Node2 n t1 t2):ts) a = inorder2_help (t1:ts)  (n: inorder2_help (t2:ts) a)


{-
  Examples:
  ghci> toBList' [1,2,3,4,5,6,7,8,9,10]
  Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc Nil 1) 2) 3) 4) 5) 6) 7) 8) 9) 10

  ghci> fromBList' (Snoc (Snoc (Snoc Nil 1) 2) 3)
  [1,2,3]

  ghci> sum_nodes' tree1
  6

  ghci> num_empties' tree1
  4

  ghci> num_nodes' tree1
  7

  sum_nodes2' and in_order2 - CONFUSION!

-}




---- Part 3: Higher-order functions ----------------

-- The functions map, all, any, filter, dropWhile, takeWhile, and break
-- from the Prelude are all higher-order functions. Reimplement them here
-- as list recursions. break should process each element of the list at
-- most once. All functions should produce the same output as the originals.

my_map :: (a -> b) -> [a] -> [b]
my_map f (x:xs) = f x : my_map f xs

{-
  ghci> my_map (^3) [1,2,3,4,5]
  [1,8,27,64,125
-}

my_all :: (a -> Bool) -> [a] -> Bool
my_all p (x:xs) = p x && my_all p xs

{-
  ghci> my_all (>1) [1,2,3,4,5,6,7]
  False
  ghci> my_all (>2) [3,4,5,6]
  *** Exception: Desktop\lab2-2.hs:290:1-36: Non-exhaustive patterns in function my_all

  ghci> my_all (>4) [1,2,3,4,5,6,7]
  False
-}

my_any :: (a -> Bool) -> [a] -> Bool
my_any p (x:xs) = p x || my_any p xs

{-
  ghci> my_any (>1) [2,3,4,5,1]
  True
  ghci> my_any (>10) [1,2,3,4,5,5,6,7]
  *** Exception: Desktop\lab2-2.hs:293:1-36: Non-exhaustive patterns in function my_any
-}

my_filter :: (a -> Bool) -> [a] -> [a]
my_filter p (x:xs)
  | p x       = x : my_filter p xs  
  | otherwise = my_filter p xs 

{-
   my_filter (>2) [1,0,2,3,4,5,6]
  [3,4,5,6 *** Exception: Desktop\lab2-2.hs:(296,1)-(298,30): Non-exhaustive patterns in function my_filter
-}

my_dropWhile :: (a -> Bool) -> [a] -> [a]
my_dropWhile p (x:xs)
  | p x       = my_dropWhile p xs  
  | otherwise = x : xs 

  {-
  my_dropWhile (<2) [1,2,3,4,5,6,7]
  [2,3,4,5,6,7]
  -}


my_takeWhile :: (a -> Bool) -> [a] -> [a]
my_takeWhile p (x:xs)
  | p x       = x : my_takeWhile p xs  
  | otherwise = []  

  {-
  ghci> my_takeWhile (<1) [0,-1,-2,3,4,5]
  [0,-1,-2]
  -}                   

{- my_break :: (a -> Bool) -> [a] -> ([a], [a])
my_break p (x:xs)
  | p x       = (x : first, rest)  
  | 
    Having confusion here! -}

-- Implement the Prelude functions and, or, concat using foldr

my_and :: [Bool] -> Bool
my_and = foldr (&&) True

{-
  ghci> my_and [True, False, True]
  False
  ghci> my_and [False, True, False]
  False
-}

my_or :: [Bool] -> Bool
my_or = foldr (||) False

{-
  my_or [True,True,False]
  True
-}


my_concat :: [[a]] -> [a]
my_concat = foldr (++) []

{-
  ghci> my_concat [[1,2,3], [4,5,6]]
  [1,2,3,4,5,6] 
-}

-- Implement the Prelude functions sum, product, reverse using foldl

my_sum :: Num a => [a] -> a
my_sum = foldl (+) 0

{-
  my_sum [1,2,3,4]
  10
-}


my_product :: Num a => [a] -> a
my_product = foldl (*) 1 

{-
  ghci> my_product [1,2,3,4]
  24
-}

{- my_reverse :: [a] -> [a]
my_reverse = foldr (\acc x -> x : acc) [] xs -}



---- Part 4: Extra Credit ----------------

-- Convert a Tree into an equivalent Tree2, IF POSSIBLE. That is, given t1,
-- return t2 such that conv21 t2 = t1, if it exists. (In math, this is called
-- the "inverse image" of the function conv21.)  Thus, if conv21 t2 = t1, then
-- it should be that conv 12 t1 = Just t2. If there does not exist such a t2,
-- then conv12 t1 = Nothing. Do some examples on paper first so you can get a
-- sense of when this conversion is possible.


conv12 :: Tree a -> Maybe (Tree2 a)
conv12 Empty = undefined
conv12 (Node x left right) =
    case conv12 left of
        Just left' -> case conv12 right of
        Just right' -> case Conv12
        _ -> Nothing


-- Binary Search Trees. Determine, by making only ONE PASS through a tree,
-- whether or not it's a Binary Search Tree, which means that for every
-- Node a t1 t2 in the tree, every element in t1 is strictly less than a and
-- every element in t2 is strictly greater than a. Complete this for both
-- Tree a and Tree2 a.

-- Hint: use a helper function that keeps track of the range of allowable
-- element values as you descend through the tree. For this, use the following
-- extended integers, which add negative and positvie infintiies to Int:

data ExtInt = NegInf | Fin Int | PosInf deriving Eq

instance Show ExtInt where
  show NegInf     = "-oo"
  show (Fin n) = show n
  show PosInf     = "+oo"

instance Ord ExtInt where
  compare NegInf  NegInf  = EQ
  compare NegInf  _       = LT
  compare (Fin n) (Fin m) = compare n m
  compare (Fin n) PosInf  = LT
  compare PosInf  PosInf  = EQ
  compare _       _       = GT
  -- Note: defining compare automatically defines <, <=, >, >=, ==, /=
  
bst :: Tree Int -> Bool
bst = bstHelper t NegInf PosInf
  where
    bstHelper Empty __ = True
    bstHelper (Node x left right) minVal maxVal =
        x > minVal && x < maxVal
            {- To check if the tree is valid or not -}
    
bst2 :: Tree2 Int -> Bool
bst2 = bst2Helper t NegInf PosInf
  where
    bst2Helper (Leaf x) minVal maxVal = x > minVal && x < maxVal
    bst2Helper (Node2 x left right) minVal maxVal =
        x > minVal && x < maxVal
        {- -}
