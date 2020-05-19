module Mandelbrot (
    drawMandelbrot
    ) where

import Data.Complex
import Graphics.GD
import Plot

maxNumberOfIterations = 2048

drawMandelbrot::Coordinate->Color
drawMandelbrot (x,y) = getColor $ mandelbrot (0 :+ 0) (x :+ y) 0

mandelbrot::Complex Double
    -> Complex Double
    -> Int
    -> Int
mandelbrot z c iter
    | iter > maxNumberOfIterations = 0
    | otherwise = let zNext = z^2 + c in 
                if magnitude zNext > 2 
                then iter
                else mandelbrot zNext c (iter+1)

createPalette::Int -> [Int]
createPalette ind = [[r,g,b] | r<-[0..255],g<-[0..255],b<-[0..255]] !! ind

getColor::Int -> Color
getColor x
    | x > maxNumberOfIterations = rgb 255 255 255
    | otherwise = let c = createPalette x
                   --   r = x `mod` 4 * 64
                   --   g = x `mod` 8 * 32
                   --   b = x `mod` 16 * 16
                in rgb (c !! 0) (c !! 1) (c !! 2) 
