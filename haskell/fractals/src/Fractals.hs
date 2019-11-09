module Fractals
    (
      mkFractal
    , mkImage
    , Fractal
    , Image
    , C
    ) where


import Data.Complex
type C = Complex Float
type Fractal =C -> [C]
type Image color = C -> color

notFar::C -> Bool
notFar p = let threshold = 47
    in realPart (abs p) < threshold

next::C -> C -> C
next p z = z^2 + p


inFractal::Fractal -> C -> Bool
inFractal f p = all notFar (f p)


inFractalAprox::Int -> Fractal -> C -> Int
inFractalAprox n f p = length . take n . takeWhile notFar $ f p


mkFractal::C -> C -> [C]
mkFractal z p = iterate (next p) z


mkImage::Fractal -> [color] -> Image color
mkImage f palette = (palette !!).steps
    where
        steps = inFractalAprox (length palette - 1) f
