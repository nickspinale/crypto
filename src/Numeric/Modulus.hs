module Numeric.Modulus
    ( modExpBySqr
    ) where

import GHC.Integer.GMP.Internals

-- | Modular exponentiation
--
-- > modExpBySqr g n m = g^n mod m

modExpBySqr :: Integer -- ^ base
            -> Integer -- ^ exponent
            -> Integer -- ^ modulus
            -> Integer -- ^ result

modExpBySqr g n m = if n < 0
                    then recipModInteger (go 1 g $ negate n) m
                    else go 1 g n
  where
    go acc _  0  = acc
    go acc g' n' = let sqr = g' * g'
                   in if even n'
                      then go        acc           sqr ( n'      `div` 2)
                      else go ((g' * acc) `mod` m) sqr ((n' - 1) `div` 2)
    
