module Numeric.ByteString
    ( toIntegerBE
    , toIntegerLE
    ) where

toIntegerBE :: ByteString -> Integer
toIntegerBE = decode
