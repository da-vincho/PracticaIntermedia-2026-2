import System.IO

properDivisors :: Int -> [Int]
properDivisors n = [x | x <- [1..n-1], n `mod` x == 0]

aliquotSum :: Int -> Int
aliquotSum n = sum (properDivisors n)

classifyCategory :: Int -> String
classifyCategory n
    | aliquotSum n > n = "Administrative"
    | aliquotSum n == n = "Engineering"
    | otherwise = "Humanities"

getPeriod :: Int -> String
getPeriod code =
    let period = code `div` 100000
        year = 2000 + period `div` 10
        semester = period `mod` 10
    in show year ++ "-" ++ show semester

getCategory :: Int -> Int
getCategory code =
    (code `div` 1000) `mod` 100

getNumber :: Int -> Int
getNumber code =
    code `mod` 1000

numberType :: Int -> String
numberType code
    | even code = "even"
    | otherwise = "odd"

isValidPeriod :: Int -> Bool
isValidPeriod code =
    let period = code `div` 100000
    in period `elem` [262, 271, 272, 281, 282, 291, 292]

isValidCode :: Int -> Bool
isValidCode code =
    code >= 10000000 &&
    code <= 99999999 &&
    isValidPeriod code

processCode :: Int -> String
processCode code
    | not (isValidCode code) = "Invalid code"
    | otherwise =
        getPeriod code ++ " " ++
        classifyCategory (getCategory code) ++ " num" ++
        show (getNumber code) ++ " " ++
        numberType code

main :: IO ()
main = do
    putStrLn "Ingrese el codigo:"
    input <- getLine
    let code = read input :: Int
    putStrLn (processCode code)
    putStrLn "Presione Enter para salir..."
    _<-getLine
    return()