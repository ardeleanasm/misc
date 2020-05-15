module Julia (
    drawJulia
    ) where

import Data.Complex
import Graphics.GD
import Plot

maxNumberOfIterations = 255

c::Complex Double
c= (-0.423) :+ 0.745


drawJulia::Coordinate->Color
drawJulia (x,y) = getColor $ julia (x :+ y) c 0

julia::Complex Double
    -> Complex Double
    -> Int
    -> Int
julia z c iter
    | iter > maxNumberOfIterations = 0
    | otherwise = let zNext = z^2 + c in 
                if magnitude zNext > 2 
                then iter
                else julia zNext c (iter+1)


getColor::Int -> Color
getColor x
    | x > maxNumberOfIterations = rgb 255 255 255
    | otherwise = let c = x * 2
                   --   r = x `mod` 4 * 64
                   --   g = x `mod` 8 * 32
                   --   b = x `mod` 16 * 16
                in rgb x c x
