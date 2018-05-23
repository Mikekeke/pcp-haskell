import           Control.DeepSeq
import           Control.Exception
import           Control.Parallel
import           Control.Parallel.Strategies
import           System.Environment
import           Text.Printf


fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

sl = [14,20,15,21,16,22,17,23,18,24,19]
tl = [[fib 33], [fib 34]]
maps = map (\x -> [fib x])

fn2 l = maps l `using` evalList (rpar . force)
fn3 l = maps l `using` parList rdeepseq

l = [[fib 33], [fib 34]]
f1 = l `using` parList rdeepseq
f2 = l `using` evalList (rpar . force)
f3 = map (\x -> Just $ fib x) sl `using` evalList (rpar . force)
f4 = map (\x -> Just $ fib x) sl `using` parList rdeepseq

main :: IO ()
main = print f3

-- import           Control.DeepSeq
-- import           Control.Exception
-- import           Control.Parallel
-- import           Control.Parallel.Strategies (Strategy, rpar, rparWith, rseq,
--                                               using)
-- import           System.Environment
-- import           Text.Printf

-- -- <<fib
-- fib :: Integer -> Integer
-- fib 0 = 1
-- fib 1 = 1
-- fib n = fib (n-1) + fib (n-2)
-- -- >>

-- rdeepseq x = rseq (force x)

-- main = print pair
--  where
--   pair =
-- -- <<pair
--    ([fib 35], [fib 36]) `using` parPair rdeepseq rdeepseq
-- -- >>

-- -- <<evalPair
-- evalPair :: Strategy a -> Strategy b -> Strategy (a,b)
-- evalPair sa sb (a,b) = do
--   a' <- sa a
--   b' <- sb b
--   return (a',b')
-- -- >>

-- -- <<parPair
-- parPair :: Strategy a -> Strategy b -> Strategy (a,b)
-- parPair sa sb = evalPair (rparWith sa) (rparWith sb)
-- -- >>

