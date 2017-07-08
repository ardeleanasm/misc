--
-- Copyright (c) 2017 ardeleanasm - https://ardeleanasm.github.io
-- GPL version 2 or later (see http://www.gnu.org/copyleft/gpl.html)
--


{-|
Module      : BaseConvertor
Description : Application made for converting decimal to binary or hex
Copyright   : (c) ardeleanasm, 2017
License     : GPL-2
Maintainer  : ardeleanasm@gmail.com
Stability   : experimental
Portability : POSIX


-}
import System.Environment
import System.Exit
import Data.Char


appname="BaseConvertor"
appversion="0.1.0.0"
{-|
  The 'toBin' converts a number from decimal to binary.
  It takes one argument, of type 'Integer' and returns a list of 'Integers'.
-}
toBin::Integer->[Integer]
toBin 0= [0]
toBin 1= [1]
toBin n
    | n `mod` 2==0= toBin(n `div` 2)++[0]
    | otherwise =toBin(n `div` 2)++[1]

    
{-|
  The 'toHex' converts a number from decimal to hexadecimal.
  It takes one argument, of type 'Integer' and returns a list of 'Chars'.
-}
toHex::Integer->[Char]
toHex 0=['0']
toHex n=do
    let x = n `mod` 16
    case x of
        10->toHex(n `div` 16)++['A']
        11->toHex(n `div` 16)++['B']
        12->toHex(n `div` 16)++['C']
        13->toHex(n `div` 16)++['D']
        14->toHex(n `div` 16)++['E']
        15->toHex(n `div` 16)++['F']
        otherwise->toHex(n `div` 16)++[intToDigit $ fromIntegral x]



    
{-|
  The 'printBinary' is a helper function used to print the number in binary base.
  It takes one argument, of type 'Integer'.
-}
printBinary::Integer->IO ()
printBinary n = putStrLn $list_to_string result
    where 
        list_to_string=unwords . map show
        result = toBin n

{-| The 'printHex' is a helper function used to print the number in hexadecimal base.
It takes one argument, of type 'Integer'.
-}
printHex::Integer->IO ()
printHex n = putStrLn $toHex n

-- | 'main' Application's entry point
main::IO ()
main=do
    args<-getArgs
    case args of
        ["-h"]      -> usage>>exit_success
        ["-help"]   -> usage>>exit_success
        ["-v"]      -> version>>exit_success
        ["-b",value]->do
            let x=read value::Integer
            printBinary x
        ["-h",value]->do
            let x=read value::Integer
            printHex x
        []-> usage>>exit_failure

-- | 'usage' is a helper function used to print the application's usage
usage   = do
    putStrLn "Usage: bc <parameter>[<value>]"
    putStrLn "parameters:"
    putStrLn "\t\t-h/-help:\thelp"
    putStrLn "\t\t-v:\t\tversion"
    putStrLn "\t\t-b value:\tdecToBin"
    putStrLn "\t\t-h value:\tdecToHex"

-- | 'version' is a helper function used to print the application's name and version
version = putStrLn $ appname++" Version: "++appversion


exit_success    = exitWith ExitSuccess
exit_failure    = exitWith (ExitFailure 1)
