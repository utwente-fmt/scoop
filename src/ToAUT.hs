module ToAUT where

import ToPA
import StepPA
import LPPE
import Confluence
import DataSpec
import Data.Ratio
import Data.List
import Debug.Trace
import Data.HashMap

-------------------------------
-- Translation to AUT format --
-------------------------------

data OutputString = OutputString [Char]
instance Show OutputString where
   show (OutputString s) = s


toAUTNonProb :: Bool -> PSpecification -> Bool -> ConfluentSummands -> Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> [String] -> OutputString
toAUTNonProb ignorecycles spec cadp confl checkConfluence checkDTMC isMA removeRates preserveDivergence showDeadlocks storeReps reachActions = OutputString ("des (0," ++ show (length transitions2) ++ "," ++ show (size (fst statespace)) ++ ")\n" ++ (printTransitionsNonProb cadp transitions2))
  where
    (statespace,initial,_) = getStateSpace ignorecycles spec confl checkConfluence False checkDTMC isMA removeRates preserveDivergence showDeadlocks storeReps reachActions
    transitions            = snd statespace
    transitions2           = createTransitionsNonProb transitions

createTransitionsNonProb :: [(Int, EdgeLabel, [(Probability, Int)])] -> [(Int, EdgeLabel, Int)]
createTransitionsNonProb []                              = []
createTransitionsNonProb ((from, label, []):trans)       = createTransitionsNonProb trans
createTransitionsNonProb ((from, label, (to:tos)):trans) | label == "reachConditionAction" = createTransitionsNonProb trans
                                                         | otherwise                 = (from, label, snd to):rest
  where
    rest = createTransitionsNonProb ((from, label, tos):trans)

printTransitionsNonProb cadp [] = []
printTransitionsNonProb cadp ((from, label, to):ts) = "(" ++ show from ++ ",\"" ++ (if cadp then (if label == "tau" then "i" else changeCommas label) else label) ++ "\"," ++ show to ++ ")\n" ++ (printTransitionsNonProb cadp ts)

toIMCA :: [String] -> Bool -> PSpecification -> Bool -> ConfluentSummands -> Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> [String] -> OutputString
toIMCA reach ignorecycles spec cadp confl checkConfluence checkDTMC isMA removeRates preserveDivergence showDeadlocks storeReps reachActions = OutputString ("#INITIALS\ns0\n#GOALS\n" ++ goalStates ++ "#TRANSITIONS\n"  ++ transitionsOutput)
    where
     (statespace,initial,_)     = getStateSpace ignorecycles spec confl checkConfluence False checkDTMC isMA removeRates preserveDivergence showDeadlocks storeReps reachActions
     states                     = fst statespace
     transitions                = snd statespace
     (transitionsOutput, reachStates) = printTransitionsIMC transitions reach
     goalStates                 = concat [x ++ "\n" | x <- nub reachStates]

printTransitionsIMC :: [(Int, EdgeLabel, [(Probability, Int)])] -> [String] -> ([Char], [String])
printTransitionsIMC [] reachActions                                  = ([],[])
printTransitionsIMC ((from, label, ((prob,to):tos)):ts) reachActions = (imcTransitions, reach1 ++ reach2 ++ reach3) 
  where
    (transitions1, reach1, next) = printRates   from ((from, label, ((prob,to):tos)):ts) reachActions
    (transitions2, reach2)       = printActions from ((from, label, ((prob,to):tos)):ts) reachActions
    (rest, reach3)               = printTransitionsIMC next reachActions
    imcTransitions               = (if transitions1 /= "" then "s" ++ show from ++ " !" ++ "\n" else [])
                                   ++ if transitions2 == "" && rest == "" then [transitions1!!i | i <- [0..length transitions1 - 2]] else transitions1
                                   ++ if rest == "" then [transitions2!!i | i <- [0..length transitions2 - 2]] else transitions2
                                   ++ rest

printRates fromState [] reachActions                                  = ([],[],[])
printRates fromState ((from, label, ((prob,to):tos)):ts) reachActions 
  | fromState /= from      = ([],[], ((from, label, ((prob,to):tos)):ts))
  | take 4 label /= "rate" = (rest,reachRest,next)
  | otherwise              = ("* s" ++ show to ++ " " ++ newLabel ++ "\n" ++ rest, reach, next)
  where
    newLabel              = printFraction (takeWhile (/= ')') (drop 5 label))
    (rest,reachRest,next) = printRates fromState ts reachActions
    reach                 = (if checkLabel label reachActions then ["s" ++ show from] else []) ++ reachRest

printActions fromState [] reachActions = ([],[])
printActions fromState ((from, label, ((prob,to):tos)):ts) reachActions
  | fromState /= from         = ([],[])
  | take 4 label == "rate"    = (rest, reachRest)
  | label == "reachConditionAction" = (rest, ("s" ++ show from):reachRest)
  | otherwise                 = (transition ++ rest, reach)
  where
    transition        = ("s" ++ show from ++ " " ++ (changeCommas label) ++ "\n"
                        ++ printTransitionsIMC2 (from, label, ((prob,to):tos))
	                    ++ "\n")
    (rest, reachRest) = printActions fromState ts reachActions
    reach             = (if checkLabel label reachActions then ["s" ++ show from] else []) ++ reachRest

checkLabel :: String -> [String] -> Bool
checkLabel label reachActions = or [label == r || takeWhile (/= '(') label == r | r <- reachActions]
 
printTransitionsIMC2 :: (Int, EdgeLabel, [(Probability, Int)]) -> [Char]
printTransitionsIMC2  (from, label, [])             = []
printTransitionsIMC2 (from, label, [(prob,to)]) = "* s" ++ show to ++ " " ++ (printFraction prob)
printTransitionsIMC2 (from, label, ((prob,to):tos)) = "* s" ++ show to ++ " " ++ (printFraction prob) ++ "\n" ++ (printTransitionsIMC2 (from, label, tos))

changeFraction = \x -> (toInteger (numerator x)) % (toInteger (denominator x))
printFraction  = \x -> show (fromRational (changeFraction (getFraction x)))



toAUTProb :: Bool -> PSpecification -> Bool -> ConfluentSummands -> Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> [String] -> OutputString
toAUTProb ignorecycles spec cadp confl checkConfluence checkDTMC isMA removeRates preserveDivergence showDeadlocks storeReps reachActions = OutputString ("des (0, " ++ show (length transitions + length transitions2 - probOneTrans) ++ ", " ++ show (size (fst statespace) + length transitions - probOneTrans) ++ ")\n" ++ (printTransitionsProb cadp transitions (size (fst statespace))))
    where
     (statespace,initial,_) = getStateSpace ignorecycles spec confl checkConfluence False checkDTMC isMA removeRates preserveDivergence showDeadlocks storeReps reachActions
     transitions            = snd statespace
     transitions2           = createTransitionsNonProb transitions
     probOneTrans           = length ["" | (f,l,t) <- transitions, length t == 1]

printTransitionsProb :: Bool -> [(Int, EdgeLabel, [(Probability, Int)])] -> Int -> [Char]
printTransitionsProb cadp [] i                                  = []
printTransitionsProb cadp ((from, label, [("1",to)]):ts) i      | label == "reachConditionAction" = printTransitionsProb cadp ts i
                                                                | otherwise = "(" ++ show from ++ ", \"" ++ (if cadp then (if label == "tau" then "i" else changeCommas label) else label) ++ "\", " ++ show to ++ ")\n"
                                                                           ++ printTransitionsProb cadp ts i
printTransitionsProb cadp ((from, label, ((prob,to):tos)):ts) i = printTransitionsProb2 cadp (from, label, ((prob,to):tos)) i
                                                                  ++ printTransitionsProb cadp ts (i+1)

printTransitionsProb2 :: Bool -> (Int, EdgeLabel, [(Probability, Int)]) -> Int -> [Char]
printTransitionsProb2 cadp (from, label, []) i              = "(" ++ show from ++ ", \"" ++ (if cadp then (if label == "tau" then "i" else changeCommas label) else label) ++ "\", " ++ show i ++ ")\n"
printTransitionsProb2 cadp (from, label, ((prob,to):tos)) i = "(" ++ show i ++ ", \"prob " ++ (if cadp then printFraction prob else prob) ++ "\", " ++ show to ++ ")\n" ++ (printTransitionsProb2 cadp (from, label, tos) i)
  where
    changeFraction = \x -> (toInteger (numerator x)) % (toInteger (denominator x))
    printFraction  = \x -> show (fromRational (changeFraction (getFraction prob)))

changeCommas ""       = ""
changeCommas (',':y) = ';':(changeCommas y)
changeCommas (x:y)    = x:(changeCommas y)


--printTransitionsProb cadp ((from, label, []):ts) i = "(" ++ show from ++ ",\"" ++ (if cadp then (if label == "tau" then "i" else label) else label) ++ "\"," ++ show i ++ ")\n" ++ (printTransitionsProb cadp ts (i+1))



--printTransitionsProb :: Bool -> [(Int, EdgeLabel, [(Probability, Int)])] -> Int -> [Char]
--printTransitionsProb cadp [] i                                  = []
--printTransitionsProb cadp ((from, label, []):ts) i              = "(" ++ show from ++ ", " ++ (if cadp then (if label == "tau" then "i" else label) else label) ++ ", " ++ show i ++ ")\n" ++ (printTransitionsProb cadp ts (i+1))
--printTransitionsProb cadp ((from, label, ((prob,to):tos)):ts) i = "(" ++ show i ++ ", \"prob " ++ (if cadp then printFraction prob else prob) ++ "\", " ++ show to ++ ")\n" ++ (printTransitionsProb cadp ((from, label, tos):ts) i)
--  where
--    changeFraction = \x -> (toInteger (numerator x)) % (toInteger (denominator x))
--    printFraction  = \x -> show (fromRational (changeFraction (getFraction prob)))
--printTransitionsProb cadp ((from, label, []):ts) i = "(" ++ show from ++ ",\"" ++ (if cadp then (if label == "tau" then "i" else label) else label) ++ "\"," ++ show i ++ ")\n" ++ (printTransitionsProb cadp ts (i+1))

toAUTDTMC :: Bool -> PSpecification -> Bool -> ConfluentSummands -> Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> [String] -> OutputString
toAUTDTMC ignorecycles spec cadp confl checkConfluence checkDTMC isMA removeRates preserveDivergence showDeadlocks storeReps reachActions = OutputString ("des (0, " ++ show (length transitions2) ++ ", " ++ show (size (fst statespace)) ++ ")\n" ++ (printTransitionsDTMC cadp transitions))
    where
     (statespace,initial,_) = getStateSpace ignorecycles spec confl checkConfluence False checkDTMC isMA removeRates preserveDivergence showDeadlocks storeReps reachActions
     transitions            = snd statespace
     transitions2           = createTransitionsNonProb transitions

printTransitionsDTMC :: Bool -> [(Int, EdgeLabel, [(Probability, Int)])] -> [Char] 
printTransitionsDTMC cadp []                                  = []
printTransitionsDTMC cadp ((from, label, []):ts)              = printTransitionsDTMC cadp ts
printTransitionsDTMC cadp ((from, label, ((prob,to):tos)):ts) | label == "reachConditionAction" = printTransitionsDTMC cadp ts
                                                              | otherwise                 = printTransitionsDTMC2 cadp ((from, label, outgoing):ts)
    where
	 outgoing = sortBy order ((prob,to):tos)

order :: (Probability, Int) -> (Probability, Int) -> Ordering
order (p1,t1) (p2,t2) | t1 < t2   = LT
                      | otherwise = GT
	
printTransitionsDTMC2 :: Bool -> [(Int, EdgeLabel, [(Probability, Int)])] -> [Char] 
printTransitionsDTMC2 cadp ((from, label, []):ts)              = printTransitionsDTMC cadp ts
printTransitionsDTMC2 cadp ((from, label, ((prob,to):tos)):ts) = "(" ++ show from ++ ", \"" ++ (if cadp then (if label == "tau" then "i" else changeCommas label) else label) ++ "; prob " ++ (if cadp then printFraction prob else prob) ++ "\", " ++ show to ++ ")\n" ++ (printTransitionsDTMC2 cadp ((from, label, tos):ts))
  where
    changeFraction = \x -> (toInteger (numerator x)) % (toInteger (denominator x))
    printFraction  = \x -> show (fromRational (changeFraction (getFraction prob)))

--toAUTMA :: Bool -> PSpecification -> Bool -> ConfluentSummands -> Bool -> OutputString
--toAUTMA ignorecycles spec cadp confl = OutputString ("des (0, " ++ show (length transitions + length transitions2) ++ ", " ++ show (length states + length transitions) ++ ")\n" ++ (printTransitionsProb cadp transitions (length states)))
--    where
--     (statespace,initial,_) = getStateSpace ignorecycles spec confl False False
--     states                 = fst statespace
--     transitions            = snd statespace
--     transitions2           = createTransitionsNonProb transitions

