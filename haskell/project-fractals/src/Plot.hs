module Plot (
     Coordinate
    ,Window
    ,savePlot
    ) where
import Graphics.GD

type Coordinate = (Double, Double) 
type Window = (Coordinate,Coordinate)

savePlot::(Coordinate->Color)
    -> Size     -- saved image dimensions
    -> Window
    -> String   -- saved image name
    -> IO ()
savePlot d s w n = do pic <- newImage s
                      fillImage (rgb 255 255 255) pic
                      mapM_ (\p -> setPixel p (d (mapPixelToCoordinate p w s)) pic) $ allPixels s
                      savePngFile n pic

allPixels::Size -> [Point]
allPixels (w,h) = [(x,y) | x <- [0..(w - 1)], y <- [0..(h - 1)]]

mapPixelToCoordinate::Point
    -> Window
    -> Size
    -> Coordinate
mapPixelToCoordinate (x,y) ((lx,ty),(rx,by)) (xsize,ysize) =
    let xscale = fromIntegral x / fromIntegral xsize
        yscale = fromIntegral y / fromIntegral ysize
    in
        ((((rx - lx) * xscale) + lx), (((ty - by) * yscale) + by))
