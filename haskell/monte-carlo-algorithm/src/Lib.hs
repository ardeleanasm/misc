{-|
 -Module      : MonteCarlo
 -Description : What is the probability to obtain either 3, 6 or 9 heads if one draws a coin ten times?
 -Copyright   : (c) ardeleanasm, 2017
 -License     : GPL-2
 -Maintainer  : ardeleanasm@gmail.com
 -Stability   : experimental
 -Portability : POSIX
 --}

module Lib
    ( 
    randomList,
    probabilityEstimation
    ) where

import System.Random


seed::Int
seed=(-958036805781772734)

someFunc :: IO ()
someFunc = putStrLn "someFunc"


randomList :: Int -> [Double]
randomList seed=randoms (mkStdGen seed)::[Double]


getRandomValue::Double
getRandomValue=head $ randomList (seed)


countHeads::Double->Int->Int
countHeads doubleValue h
    | doubleValue<0.5   =h+1
    | otherwise         =h

drawRandomVariable::Int-> Int->Int->Int
drawRandomVariable 0 _ t=t
drawRandomVariable n h t=do
    let heads=(countHeads (getRandomValue ) h)
    case heads of
        3->(drawRandomVariable (n-1) heads (t+1))
        6->(drawRandomVariable (n-1) heads (t+1))
        9->(drawRandomVariable (n-1) heads (t+1))
        otherwise->(drawRandomVariable (n-1) heads t)


ranAlgorithm::Int->[Double]->[Double]
ranAlgorithm 0 value=value
ranAlgorithm n value=do
    let randomValue=(fromIntegral $drawRandomVariable 10 0 0)/(fromIntegral n)
    (ranAlgorithm (n-1) (randomValue:value))
    

    


probabilityEstimation::[Double]
probabilityEstimation=ranAlgorithm 1000 []


