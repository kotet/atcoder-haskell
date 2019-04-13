import Data.List -- sort
import Control.Monad -- replicateM

readInt = read <$> getLine :: IO Integer
arrayInt = map read . words <$> getLine :: IO [Integer]
writeln x = putStrLn $ unwords x :: IO ()

main = do
    n <- readInt
    txys <- replicateM (fromIntegral n) arrayInt
    -- print txys
    putStrLn $ if solve ([0,0,0]:txys) then "Yes" else "No"
    

solve [a,b] = reachable a b
solve (a:b:xs) = reachable a b && solve (b:xs)

reachable [t1,x1,y1] [t2,x2,y2]
    | (t2 - t1) < (abs (x1-x2)) + (abs (y1-y2)) = False
    | ((t2 - t1) - (abs (x1-x2)) - (abs (y1-y2))) `mod` 2 == 0 = True
    | otherwise = False 