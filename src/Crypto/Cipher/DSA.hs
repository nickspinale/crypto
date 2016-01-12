module Crypto.Cipher.DSA
    ( Params
    , Signature
    , publicKey
    , sign
    , verify
    ) where

import GHC.Integer.GMP.Internals

data Params = Params Integer -- ^ p
                     Integer -- ^ q
                     Integer -- ^ g

data Signature = Signature Integer -- ^ r
                           Integer -- ^ s

publicKey :: Params -> Integer -> Integer
publicKey (Params p _ g) private = powModInteger g private p

sign :: Params -- ^ params
     -> Integer -- ^ private key
     -> Integer -- ^ random value
     -> Integer -- ^ data to sign
     -> Maybe Signature

sign (Params p q g) private k h = Signature <$> filterZero r <*> filterZero s
  where
    r = (powModInteger g r p) `mod` q
    s =  (recipModInteger k q * (h + private * k)) `mod` q

filterZero :: Integer -> Maybe Integer
filterZero 0 = Nothing
filterZero i = Just i

verify :: Params -- ^ params
       -> Integer -- ^ public key
       -> Integer -- ^ data to verify
       -> Signature -- ^ signature to verify against
       -> Bool

verify (Params p q g) public h (Signature r s) =
    0 < r && r < q && 0 < s && s < q && v == r
  where
    w = recipModInteger s q
    u1 = (h * w) `mod` q
    u2 = (r * w) `mod` q
    v = ((powModInteger q u1 p * powModInteger public u2 p) `mod` p) `mod` q
