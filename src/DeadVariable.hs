module DeadVariable where

import LPPE
import Expressions
import Simplify
import DataSpec
import ToPRISM
import Usage
import Data.List
import Auxiliary
import Debug.Trace

data UniqueValue  = Value String | Bottom deriving (Eq, Show)

type Relevance    = [(Int, Int, String)]
type BelongsTo    = [(Int, Int)]
type Rules        = [(Int, Int)]

-- Function that applies dead variable function.
deadVariableReduction :: Bool -> PSpecification -> PSpecification
deadVariableReduction verbose (lppe_, initial_, dataspec) | if verbose then trace("Control flow parameters: " ++ show cfps ++ "\n\nBelongs to: " ++ show belongsTo) True else True = (lppeNew, initialNew, dataspec)
  where
    (lppe,initial) = addParameterToLPPE (lppe_, initial_)
    changed        = getChanged lppe
    used           = getUsed lppe
    directlyUsed   = getDirectlyUsed lppe
    rules          = getRules dataspec lppe
    cfps           = getCFPs dataspec lppe changed rules
    dps            = getDPs dataspec lppe cfps
    belongsTo      = getBelongsTo dataspec lppe changed used rules dps cfps
    relevant       = initialRelevance dataspec lppe directlyUsed belongsTo dps cfps
    relevantPairs  = getRelevance dataspec lppe rules belongsTo relevant dps cfps
    initialNew     = initial -- improveInitialState dataspec lppe belongsTo relevantPairs initial
    lppeNew        = transformLPPE dataspec lppe rules belongsTo initialNew dps cfps relevantPairs

-----------------------------------------------------------
-- Functions for computing the source and destination of --
-- a parameter for a certain summand.                    --
-----------------------------------------------------------

getUniqueValue :: UniqueValue -> String
getUniqueValue (Value v) = v
getUniqueValue x = error("Error: " ++ show x ++ " does not have a unique value.")

source :: DataSpec -> LPPE -> Int -> Int -> UniqueValue
source dataspec lppe summandNr parNr | sources /= Undecided = result
                                     | otherwise                                       = Bottom
  where
    summand              = getPSummand lppe summandNr
    condition            = getCondition summand
    parameter            = fst ((getLPPEPars lppe)!!parNr)
    sources              = possibleValueForConditionToBeTrue parameter condition
    (UniqueValue source) = sources 
    (Variable var)       = source
    result               = if(expressionIsConstant dataspec source) then Value var else Bottom

sourceValue :: DataSpec -> LPPE -> Int -> Int -> String
sourceValue dataspec lppe summandNr parNr = value
  where
    Value value = source dataspec lppe summandNr parNr

-- Alleen aanroepen als de source uniek is.
destination :: DataSpec -> LPPE -> Int -> Int -> UniqueValue
destination dataspec lppe summandNr parNr = destination
  where
    summand              = getPSummand lppe summandNr
    (Value sourceValue)  = source dataspec lppe summandNr parNr
    nextState            = getNextState summand parNr
    parameter            = fst ((getLPPEPars lppe)!!parNr)
    nextState2           = simplifyExpression dataspec (substituteInExpression [(parameter, Variable sourceValue)] nextState)
    destination          = case (nextState2) of
                             (Variable v)         -> if (expressionIsConstant dataspec (Variable v)) then Value v else Bottom
                             (Function name pars) -> Bottom

destinationValue :: DataSpec -> LPPE -> Int -> Int -> String
destinationValue dataspec lppe summandNr parNr = value
  where
    Value value = destination dataspec lppe summandNr parNr

---------------------------------------------------
-- Functions for computing the 'rules' function. --
---------------------------------------------------
checkRules :: DataSpec -> LPPE -> Int -> Int -> Bool
checkRules dataspec lppe summandNr parNr = (source dataspec lppe summandNr parNr /= Bottom) &&
                                           (destination dataspec lppe summandNr parNr /= Bottom)

getRules :: DataSpec -> LPPE -> Rules
getRules dataspec lppe = [(summandNr, parNr) | summandNr <- getPSummandNrs lppe, 
                                                   parNr <- [0..length (getLPPEPars lppe) - 1],
                                                   checkRules dataspec lppe summandNr parNr]

isCFP :: DataSpec -> LPPE -> Changed -> Rules -> Int -> Bool
isCFP dataspec lppe changed rules parNr = and [elem (i, parNr) rules || not(elem (i,parNr) changed) | i <- getPSummandNrs lppe]

getCFPs :: DataSpec -> LPPE -> Changed -> Rules -> [Int]
getCFPs dataspec lppe changed rules = [i | i <- [0..length (getLPPEPars lppe) - 1], isCFP dataspec lppe changed rules i]

getDPs :: DataSpec -> LPPE -> [Int] -> [Int]
getDPs dataspec lppe cfps = [i | i <- [0..length (getLPPEPars lppe) - 1], not(elem i cfps)]

checkBelongsTo :: DataSpec -> LPPE -> Changed -> Used -> Rules -> Int -> [Int] -> [Int]
checkBelongsTo dataspec lppe changed used rules dp cfps = [cfp | cfp <- cfps, and [elem (i,cfp) rules | i <- importantSummands]]
  where
    importantSummands = [i | i <- getPSummandNrs lppe, (elem (i,dp) changed) || (elem (i, dp) used)]

getBelongsTo :: DataSpec -> LPPE -> Changed -> Used -> Rules -> [Int] -> [Int] -> BelongsTo
getBelongsTo dataspec lppe changed used rules dps cfps = [(dp, cfp) | dp <- dps, cfp <- checkBelongsTo dataspec lppe changed used rules dp cfps]


initialRelevance :: DataSpec -> LPPE -> DirectlyUsed -> BelongsTo -> [Int] -> [Int] -> Relevance
initialRelevance dataspec lppe directlyUsed belongsTo dps cfps = concat (map (directRelevance dataspec lppe directlyUsed belongsTo cfps) dps)

directRelevance dataspec lppe directlyUsed belongsTo cfps dp = nub [(dp, cfp, value) | i <- getPSummandNrs lppe, elem (i,dp) directlyUsed, 
                                                                                   cfp <- cfps, elem (dp, cfp) belongsTo, value <- [sourceValue dataspec lppe i cfp]] 
                                                                                   

getRelevance :: DataSpec -> LPPE -> Rules -> BelongsTo -> Relevance -> [Int] -> [Int] -> Relevance
getRelevance dataspec lppe rules belongsTo r dps cfps | newPairs  = getRelevance dataspec lppe rules belongsTo (nub (r ++ newR)) dps cfps
                                   | otherwise = r
  where
    newR     = nub ((concat (map (indirectRelevance2 dataspec lppe rules belongsTo r) (allCombinations [dps, cfps]))) ++
                    (concat (map (indirectRelevance3 dataspec lppe cfps rules belongsTo r) (allCombinations [dps, cfps]))))
    newPairs = newR \\ r /= []

indirectRelevance2 :: DataSpec -> LPPE -> Rules -> BelongsTo -> Relevance -> [Int] -> Relevance
indirectRelevance2 dataspec lppe rules belongsTo relevant [dp, cfp] | elem (dp, cfp) belongsTo = [(dp, cfp, value) | i <- getPSummandNrs lppe,
                                                                                          elem (i, cfp) rules, 
                                                                                          usedInRelevantNextState lppe i dp relevant cfp (destinationValue dataspec lppe i cfp),
                                                                                          value <- [sourceValue dataspec lppe i cfp]
                                                                                     ]
                                                  | otherwise = []

usedInRelevantNextState :: LPPE -> Int -> Int -> Relevance -> Int -> String -> Bool
usedInRelevantNextState lppe summandNr dk relevant cfp target = or [variableInExpression parameter (getNextState summand l) | (l,cfpp,targett) <- relevant, cfp == cfpp, target == targett] 
  where
    summand   = getPSummand lppe summandNr
    parameter = fst ((getLPPEPars lppe)!!dk)

indirectRelevance3 :: DataSpec -> LPPE -> [Int] -> Rules -> BelongsTo -> Relevance -> [Int] -> Relevance
indirectRelevance3 dataspec lppe cfps rules belongsTo relevant [dk, dj] | elem (dk, dj) belongsTo = [(dk, dj, value) | i <- getPSummandNrs lppe,
                                                                                          indirectRelevance3_ dataspec lppe cfps i dk dj rules belongsTo relevant,
                                                                                          value <- [sourceValue dataspec lppe i dj]]
                                                  | otherwise = []

indirectRelevance3_ :: DataSpec -> LPPE -> [Int] -> Int -> Int -> Int -> Rules -> BelongsTo -> Relevance -> Bool
indirectRelevance3_ dataspec lppe cfps summandNr dk dj rules belongsTo relevant = valid
  where
    summand   = getPSummand lppe summandNr
    parameters = [0..length (getLPPEPars lppe) - 1]
    valid = or [usedInRelevantNextState2 lppe summandNr dk belongsTo relevant dp (destinationValue dataspec lppe summandNr dp) dj | dp <- cfps, elem (summandNr, dp) rules]

usedInRelevantNextState2 lppe summandNr dk belongsTo relevant cfp target dj = or [variableInExpression parameter (getNextState summand l) | (l,cfpp,targett) <- relevant, cfp == cfpp, target == targett, not(elem (l, dj) belongsTo)] 
  where
    summand   = getPSummand lppe summandNr
    parameter = fst ((getLPPEPars lppe)!!dk)


transformLPPE :: DataSpec -> LPPE -> Rules -> BelongsTo -> InitialState -> [Int] -> [Int] -> Relevance -> LPPE
transformLPPE dataspec (LPPE name pars summands) rules belongsTo initial dps cfps relevant = LPPE name pars (transformSummands dataspec (LPPE name pars summands) rules belongsTo initial dps cfps relevant summands 0)

transformSummands dataspec lppe rules belongsTo initial dps cfps relevant [] i = [] 
transformSummands dataspec lppe rules belongsTo initial dps cfps relevant (s:ss) i = (transformSummand dataspec lppe rules belongsTo i initial dps cfps relevant s):
                                                                      (transformSummands dataspec lppe rules belongsTo initial dps cfps relevant ss (i+1))

transformSummand dataspec lppe rules belongsTo i initial dps cfps relevant (params, c, a, aps, probChoices, g) = newSummand
  where
    newG       = transformNextStates dataspec lppe rules belongsTo i initial dps cfps relevant g [0..length g - 1]
    newSummand = (params, c, a, aps, probChoices, newG)

transformNextStates dataspec lppe rules belongsTo i initial dps cfps relevant g []     = g
transformNextStates dataspec lppe rules belongsTo i initial dps cfps relevant g (k:ks) | reset && (g!!k) /= Variable (initial!!k) = transformNextStates2 dataspec lppe rules belongsTo i initial dps cfps relevant newG ks (g!!k) (initial!!k)
                                                                       | otherwise = transformNextStates dataspec lppe rules belongsTo i initial dps cfps relevant g ks
  where
    newG = (take k g) ++ [Variable (initial!!k)] ++ (drop (k+1) g) 
    relevanceInfo = [elem k dps && elem (i, cfp) rules && elem (k,cfp) belongsTo && not(elem (k, cfp, destinationValue dataspec lppe i cfp) relevant) | cfp <- cfps]
    reset = (relevanceInfo /= [] && or relevanceInfo)

transformNextStates2 dataspec lppe rules belongsTo i initial dps cfps relevant newG ks old new = transformNextStates dataspec lppe rules belongsTo i initial dps cfps relevant newG ks

improveInitialState :: DataSpec -> LPPE -> BelongsTo -> Relevance -> InitialState -> InitialState
improveInitialState dataspec lppe belongsTo relevant initial = [improveInitialValue dataspec lppe initial belongsTo relevant parNr (initial!!parNr) | parNr <- [0..length initial - 1]]

improveInitialValue :: DataSpec -> LPPE -> InitialState -> BelongsTo -> Relevance -> Int -> String -> String
improveInitialValue dataspec lppe initial belongsTo relevant parNr initValue | canChange && willChange = newValue
                                                                    | otherwise = initValue
  where
    canChange  = [c | (d,c) <- belongsTo, d == parNr, not(elem (d,c,initial!!c) relevant)] /= []
    willChange = shouldChange dataspec lppe parNr
    newValue   = getNewValue dataspec lppe parNr
     

shouldChange :: DataSpec -> LPPE -> Int -> Bool
shouldChange dataspec lppe i = [s | s <- getPSummands lppe, changedToConstant dataspec (getNextState s i)] /= []

changedToConstant dataspec (Variable v) = stringIsConstant dataspec v
changedToConstant dataspec _            = False

getNewValue :: DataSpec -> LPPE -> Int -> String
getNewValue dataspec lppe i = [getValue (getNextState s i) | s <- getPSummands lppe, changedToConstant dataspec (getNextState s i)]!!0

getValue (Variable v) = v