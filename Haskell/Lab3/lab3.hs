-- CSci 117, Lab 3:  ADTs and Type Classes

import Data.List (sort)
import Queue1
--import Queue2
import Fraction

---------------- Part 1: Queue client

-- Queue operations (A = add, R = remove)
data Qops a = A a | R

-- Create an empty queue.
mtq :: Queue a
mtq = Empty


-- Check if the queue is empty.
ismt :: Queue a -> Bool
ismt (Queue2 xs ys) = null xs && null ys

-- Add an element to the front of the queue.
addq :: a -> Queue a -> Queue a
addq x q = Queue x q

-- add a list of elements, in order, into a queue
adds :: [a] -> Queue a -> Queue a
adds [] q = q
adds (x:xs) q = adds xs (addq x q)


-- remove all elements of the queue, then putting them in order into a list
rems :: Queue a -> [a]
rems q
   | ismt q = []
   | otherwise = let (x,q') = remq q
                  in (x:rems q')


-- test whether adding a given list of elements to an initially empty queue
-- and then removing them all produces the same list (FIFO). Should return True.
testq :: Eq a => [a] -> Bool
testq xs = xs(rems (adds xs mtq)) -- doubt!

-- Perform a list of queue operations on an emtpy queue,
-- returning the list of the removed elements
perf :: [Qops a] -> [a]
perf [] q = q 
perf ops = performOps ops []

perfOps (A x) q = error "Queue: add"
perfOps R q = error "Queue: remove"

-- DOUBT!

-- Test the above functions thouroughly. For example, here is one test:
-- perf [A 3, A 5, R, A 7, R, A 9, A 11, R, R, R] ---> [3,5,7,9,11]



---------------- Part 2: Using typeclass instances for fractions

-- Construct a fraction, producing an error if it fails
fraction :: Integer -> Integer -> Fraction
fraction _ 0 = error "Illegal fraction: denominator cannot be zero"
fraction n m = Frac (n `div` d) (m `div` d)
  where
    d = gcd n m


-- Calculate the average of a list of fractions
-- Give the error "Empty average" if xs is empty
average :: [Fraction] -> Fraction
average [] = error "Empty Average"
average xs = (sum xs) * ( fraction 1 (toInteger(length xs)))

-- Some lists of fractions

list1 = [fraction n (n+1) | n <- [1..20]]
list2 = [fraction 1 n | n <- [1..20]]


-- Make up several more lists for testing

list3 = zipWith (+) list1 list2
list4 = [fraction 4 n | n <- [1..10]]
list5 = [fraction 1 (n+2) | n <- [1..10]]
list6 = [fraction 2 n | n <- [1,3..10]]
list7 = [fraction (3*n) (n+2) | n <- [1..40]]

-- Show examples testing the functions sort, sum, product, maximum, minimum,
-- and average on a few lists of fractions each. Think about how these library
-- functions can operate on Fractions, even though they were written long ago
