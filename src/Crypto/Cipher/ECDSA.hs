module Crypto.Cipher.ECDSA
    ( Params
    , Signature
    , publicKey
    , sign
    , verify
    ) where

-- | y^2 = x^3 + ax + b

data Curve = Curve Integer -- ^ a
                   Integer -- ^ b

data Params = Params Curve -- ^ CURVE
                     (Integer, Integer) -- ^ G
                     Integer -- ^ |G|




