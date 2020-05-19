module Main where

import Graphics.GD
import Plot
import Mandelbrot
import Julia
import Ship
imageDim::Size
imageDim = (600,600)

mbWindow::Window
mbWindow = ((-1.9,1.3),(0.7, -1.3))
--mbWindow = ((-1.8,0.02),(-1.7, -0.08))

main :: IO ()
main = savePlot drawJulia imageDim mbWindow "juia2.png"
