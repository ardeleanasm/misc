{--
Made based on the following resources:

http://web.cecs.pdx.edu/~mpj/pubs/composing-fractals.html

https://docs.google.com/presentation/d/1h88WKBrgarV_3jn6a_mXZnUJSDK5Qg7RCgy8Pqq7Gw8/pub?start=false&loop=false&delayms=3000#slide=id.g385b6f77d_041

https://github.com/AnotherKamila/composing_fractals


--}

module Main where

import Fractals
import Data.Complex
import Graphics.Gloss.Raster.Field
import Text.Printf
import Graphics.Gloss.Interface.Pure.Animate


mandelbrot ::Fractal
mandelbrot = mkFractal (0:+0)

julia :: C -> Fractal
julia c p = mkFractal p c


-- ...and a few pretty presets :)
rabbit     = julia ((-0.123) :+ 0.745)
siegeldisk = julia ((-0.391) :+ (-0.587))
fancy = julia ((-0.702) :+ (-0.384))



palette = map (\v -> makeColor 0 0.1 (v^2) 0) [0, 0.02 .. 1]

myAnimate :: Fractal -> Float -> (Point -> Color)
myAnimate frac t (re,im) = mkImage frac palette ((re/sc - 0.108) :+ (im/sc - 0.1))
                         where sc = (1.1**t)/2

julia_anim :: C -> (Point -> Color)
julia_anim p (re,im) = mkImage (julia p) palette ((re) :+ (im))

scaletime t
    | t < 18 = t
    | t < 23 = t + (t - 18)*5
    | otherwise = t + 25

pic t = pictures [frac, param]
        where re = 0.35; im = ((scaletime t)-10)/100
              --time  = Translate (-80) (-180) $ Scale 0.3 0.3 $ Text (show t)
              param = Translate (-320) (-250) $ Scale 0.2 0.2 $ Text (printf "%.3f + %.3fi" re im)
              frac  = makePicture 800 600 3 3 $ julia_anim (re :+ im)

window = InWindow "Magic!" (800, 600) (100, 100)

main = 
   -- animate window black pic
    animateField window (1,1) (myAnimate fancy)
