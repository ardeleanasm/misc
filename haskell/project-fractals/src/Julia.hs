module Julia (
    drawJulia
    ) where

import Data.Complex
import Graphics.GD
import Plot

maxNumberOfIterations = 4096

c::Complex Double
c = ((-0.835) :+ (-0.2321))
--c= (-0.7269) :+ 0.1889


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

createPalette::Int -> [Int]
createPalette ind = [[r,g,b] | r<-[0,16..255],g<-[0,16..255],b<-[0,16..255]] !! ind

getColor::Int -> Color
getColor x
    | x > maxNumberOfIterations = rgb 255 255 255
    | otherwise = let c = createPalette x
                   --   r = x `mod` 4 * 64
                   --   g = x `mod` 8 * 32
                   --   b = x `mod` 16 * 16
                in rgb (c !! 0) (c !! 1) (c !! 2) 

