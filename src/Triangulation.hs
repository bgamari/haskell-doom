module Triangulation where
import Linear hiding (cross)
import Data.List
import Debug.Trace

clockwise :: (Num a, Ord a) => V2 a -> V2 a -> V2 a -> Bool
clockwise o a b = (a - o) `cross` (b - o) <= 0

collinear :: (Num a, Ord a) => V2 a -> V2 a -> V2 a -> Bool
collinear o a b = (a - o) `cross` (b - o) == 0

cross :: Num a => V2 a -> V2 a -> a
cross (V2 x1 y1) (V2 x2 y2) = x1 * y2 - x2 * y1

pointInTriangle p a b c
    = let cw1 = clockwise a p b
          cw2 = clockwise b p c
          cw3 = clockwise c p a
       in cw1 == cw2 && cw2 == cw3

ear :: (Num a, Ord a) => V2 a -> V2 a -> V2 a -> [V2 a] -> Bool
ear p1 mid p2 xs
    = clockwise p1 mid p2 && not (any (\p -> pointInTriangle p p1 mid p2) xs)

triangulation :: (Show a, Num a, Ord a) => [V2 a] -> [V2 a]
triangulation [a, b, c]
    = [a, b, c]
triangulation (a : b : c : xs)
    -- | not (collinear a b c) && ear a b c xs = [a, b, c] ++ triangulation (a : c : xs)
    | collinear a b c = triangulation (a : c : xs)
    | ear a b c xs = [a, b, c] ++ triangulation (a : c : xs)
    | otherwise = triangulation (b : c : xs ++ [a])
triangulation x = x

test = nub $ concat [[V2 (-95.0) (-198.0),V2 (-104.5) (-194.0)],[V2 (-104.5) (-194.0),V2 (-118.5) (-194.0)],[V2 (-118.5) (-194.0),V2 (-127.5) (-196.5)],[V2 (-127.5) (-196.5),V2 (-133.0) (-204.5)],[V2 (-133.0) (-204.5),V2 (-129.0) (-213.0)],[V2 (-129.0) (-213.0),V2 (-111.5) (-215.5)],[V2 (-111.5) (-215.5),V2 (-96.5) (-211.5)],[V2 (-96.5) (-211.5),V2 (-95.0) (-198.0)]]

--(-95.0) (-198.0)( -104.5) (-194.0) (-104.5) (-194.0) (-118.5) (-194.0) (-118.5) (-194.0) (-127.5) (-196.5) (-127.5) (-196.5) (-133.0) (-204.5) (-133.0) (-204.5) (-129.0) (-213.0) (-129.0) (-213.0) (-111.5) (-215.5) (-111.5) (-215.5) (-96.5) (-211.5) (-96.5) (-211.5) (-95.0) (-198.0)


-- (-118.5) (-194.0) (-127.5) (-196.5) (-133.0) (-204.5) (-129.0) (-213.0) (-111.5) (-215.5) (-96.5) (-211.5) (-104.5) (-194.0)

findItem f [] = error "findItem: item not found"
findItem f (x : xs)
    | f x = (x, xs)
    | otherwise = let (y, ys) = findItem f xs in (y, x : ys)

stuff = [[V2 (-86.0) (-200.0),V2 (-86.0) (-194.0)],[V2 (-86.0) (-194.0),V2 (-86.0) (-184.0)],[V2 (-86.0) (-184.0),V2 (-92.0) (-180.0)],[V2 (-92.0) (-180.0),V2 (-104.0) (-180.0)],[V2 (-104.0) (-180.0),V2 (-116.0) (-180.0)],[V2 (-116.0) (-180.0),V2 (-120.0) (-182.5)],[V2 (-120.0) (-182.5),V2 (-136.0) (-182.5)],[V2 (-136.0) (-182.5),V2 (-140.0) (-182.5)],[V2 (-140.0) (-182.5),V2 (-142.0) (-188.0)],[V2 (-142.0) (-188.0),V2 (-152.0) (-194.5)],[V2 (-152.0) (-194.5),V2 (-171.0) (-194.5)],[V2 (-171.0) (-194.5),V2 (-171.0) (-210.0)],[V2 (-171.0) (-210.0),V2 (-171.0) (-228.0)],[V2 (-171.0) (-228.0),V2 (-140.0) (-228.0)],[V2 (-140.0) (-228.0),V2 (-124.0) (-228.0)],[V2 (-124.0) (-228.0),V2 (-86.0) (-228.0)],[V2 (-86.0) (-228.0),V2 (-86.0) (-220.0)],[V2 (-86.0) (-220.0),V2 (-86.0) (-212.0)],[V2 (-86.0) (-212.0),V2 (-86.0) (-210.0)],[V2 (-86.0) (-210.0),V2 (-86.0) (-204.0)]]