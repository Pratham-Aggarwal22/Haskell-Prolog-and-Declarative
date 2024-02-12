module Queue1 (Queue, mtq, ismt, addq, remq) where

---- Interface ----------------
mtq  :: Queue a                  -- empty queue
ismt :: Queue a -> Bool          -- is the queue empty?
addq :: a -> Queue a -> Queue a  -- add element to front of queue
remq :: Queue a -> (a, Queue a)  -- remove element from back of queue;
                                 --   produces error "Can't remove an element
                                 --   from an empty queue" on empty

---- Implementation -----------

{- In this implementation, a queue is represented as an ordinary list.
The "front" of the queue is at the head of the list, and the "back" of
the queue is at the end of the list.
-}

data Queue a = Queue1 [a] -- deriving Show

mtq = Queue1 []

-- Check if a queue is empty.
ismt (Queue1 xs) = null xs

-- Add an element to the front of the queue.
addq :: a -> Queue a -> Queue a
addq x (Queue1 xs) = Queue1 (x:xs)


-- Remove an element from the back of the queue.
-- If the queue is empty, produce an error.
remq :: Queue a -> (a, Queue a)
remq (Queue1 []) = error "Can't remove an element from an empty queue"
remq (Queue1 xs) =  (x, Queue1 xs)
