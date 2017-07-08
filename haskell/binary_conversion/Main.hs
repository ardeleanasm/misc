import System.Environment
import System.Exit
import Data.Char


appname="BaseConvertor"
appversion="0.1.0.0"

toBin::Integer->[Integer]
toBin 0= [0]
toBin 1= [1]
toBin n
	| n `mod` 2==0= toBin(n `div` 2)++[0]
	| otherwise =toBin(n `div` 2)++[1]
	

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



	

printBinary::Integer->IO ()
printBinary n = putStrLn $list_to_string result
	where 
		list_to_string=unwords . map show
		result = toBin n

printHex::Integer->IO ()
printHex n = putStrLn $toHex n


main::IO ()
main=do
	args<-getArgs
	case args of
		["-h"]		-> usage>>exit_success
		["-help"]	-> usage>>exit_success
		["-v"]		-> version>>exit_success
		["-b",value]->do
			let x=read value::Integer
			printBinary x
		["-h",value]->do
			let x=read value::Integer
			printHex x
		[]-> usage>>exit_failure


usage   = do
	putStrLn "Usage: bc <parameter>[<value>]"
	putStrLn "parameters:"
	putStrLn "\t\t-h/-help:\thelp"
	putStrLn "\t\t-v:\t\tversion"
	putStrLn "\t\t-b value:\tdecToBin"
	putStrLn "\t\t-h value:\tdecToHex"

version = putStrLn $ appname++" Version: "++appversion
exit_success	= exitWith ExitSuccess
exit_failure	= exitWith (ExitFailure 1)
