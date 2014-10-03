{-# OPTIONS_GHC -w #-}
module Parser where

import Data.Char
import Processes
import Expressions
import Auxiliary
import DataSpec
import Debug.Trace

printExpressions [] = []
printExpressions updates = infixString [(printExpression var) ++ " := " ++ (printExpression val) | (var,val) <- updates] ", "

data Item = DataActions [(String, ActionType)]
          | DataHiding [String] 
          | DataGlobal (Variable, Type) Expression 
          | DataRenaming [(String, String)] 
          | DataUntilFormula String
          | DataFormula Expression
          | DataEncapsulation [String]   
          | DataNoCommunication [String]   
          | DataReach [String]   
          | DataReachCondition Expression
          | DataStateReward Expression Expression
          | DataCommunication [(String, String, String)] 
          | DataConstant String Expression
          | DataEnumType String [String] 
          | DataNat String
          | DataQueue String
          | DataRangeType String Expression Expression
          | DataFunction String [([String], String)]
          | ParserProcess Process
          | ParserInitialProcess InitialProcessDefinition
              deriving (Show, Eq)

data ActionType = None | Bool | IntRange Expression Expression deriving (Show, Eq)

data InitialProcessDefinition = InitSingleProcess InitialProcess
                              | InitParallel InitialProcessDefinition InitialProcessDefinition
                              | InitHiding [Action] InitialProcessDefinition
                              | InitEncapsulation [Action] InitialProcessDefinition
                              | InitRenaming [(Action, Action)] InitialProcessDefinition
                                   deriving (Show, Eq)

type LineNumber = Int
data ParseResult a = Ok a | Failed String
type ParserMonad a = String -> LineNumber -> ParseResult a

getLineNo :: ParserMonad LineNumber
getLineNo = \s l -> Ok l


thenParserMonad :: ParserMonad a -> (a -> ParserMonad b) -> ParserMonad b
m `thenParserMonad ` k = \s -> \l ->
   case (m s l) of 
       Ok a -> k a s l
       Failed e -> Failed e

returnParserMonad :: a -> ParserMonad a
returnParserMonad a = \s -> \l -> Ok a

failParserMonad :: String -> ParserMonad a
failParserMonad err = \s -> \l -> Failed (err ++ " on line " ++ show l)

-- parser produced by Happy Version 1.18.6

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 t31 t32 t33 t34 t35 t36 t37 t38 t39
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20
	| HappyAbsSyn21 t21
	| HappyAbsSyn22 t22
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26
	| HappyAbsSyn27 t27
	| HappyAbsSyn28 t28
	| HappyAbsSyn29 t29
	| HappyAbsSyn30 t30
	| HappyAbsSyn31 t31
	| HappyAbsSyn32 t32
	| HappyAbsSyn33 t33
	| HappyAbsSyn34 t34
	| HappyAbsSyn35 t35
	| HappyAbsSyn36 t36
	| HappyAbsSyn37 t37
	| HappyAbsSyn38 t38
	| HappyAbsSyn39 t39

action_0 (68) = happyShift action_4
action_0 (75) = happyShift action_5
action_0 (76) = happyShift action_6
action_0 (77) = happyShift action_7
action_0 (79) = happyShift action_8
action_0 (80) = happyShift action_9
action_0 (81) = happyShift action_10
action_0 (82) = happyShift action_11
action_0 (83) = happyShift action_12
action_0 (84) = happyShift action_13
action_0 (85) = happyShift action_14
action_0 (86) = happyShift action_15
action_0 (87) = happyShift action_16
action_0 (88) = happyShift action_17
action_0 (89) = happyShift action_18
action_0 (90) = happyShift action_19
action_0 (91) = happyShift action_20
action_0 (4) = happyGoto action_21
action_0 (5) = happyGoto action_2
action_0 (6) = happyGoto action_3
action_0 _ = happyReduce_2

action_1 (68) = happyShift action_4
action_1 (75) = happyShift action_5
action_1 (76) = happyShift action_6
action_1 (77) = happyShift action_7
action_1 (79) = happyShift action_8
action_1 (80) = happyShift action_9
action_1 (81) = happyShift action_10
action_1 (82) = happyShift action_11
action_1 (83) = happyShift action_12
action_1 (84) = happyShift action_13
action_1 (85) = happyShift action_14
action_1 (86) = happyShift action_15
action_1 (87) = happyShift action_16
action_1 (88) = happyShift action_17
action_1 (89) = happyShift action_18
action_1 (90) = happyShift action_19
action_1 (91) = happyShift action_20
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 _ = happyFail

action_2 _ = happyReduce_1

action_3 (68) = happyShift action_4
action_3 (75) = happyShift action_5
action_3 (76) = happyShift action_6
action_3 (77) = happyShift action_7
action_3 (79) = happyShift action_8
action_3 (80) = happyShift action_9
action_3 (81) = happyShift action_10
action_3 (82) = happyShift action_11
action_3 (83) = happyShift action_12
action_3 (84) = happyShift action_13
action_3 (85) = happyShift action_14
action_3 (86) = happyShift action_15
action_3 (87) = happyShift action_16
action_3 (88) = happyShift action_17
action_3 (89) = happyShift action_18
action_3 (90) = happyShift action_19
action_3 (91) = happyShift action_20
action_3 (5) = happyGoto action_59
action_3 (6) = happyGoto action_3
action_3 _ = happyReduce_2

action_4 (47) = happyShift action_54
action_4 (75) = happyShift action_55
action_4 (76) = happyShift action_56
action_4 (77) = happyShift action_57
action_4 (80) = happyShift action_58
action_4 (20) = happyGoto action_53
action_4 _ = happyFail

action_5 (47) = happyShift action_51
action_5 (70) = happyShift action_52
action_5 _ = happyFail

action_6 (75) = happyShift action_39
action_6 (17) = happyGoto action_50
action_6 _ = happyFail

action_7 (47) = happyShift action_49
action_7 (15) = happyGoto action_47
action_7 (16) = happyGoto action_48
action_7 _ = happyFail

action_8 (75) = happyShift action_46
action_8 (8) = happyGoto action_44
action_8 (9) = happyGoto action_45
action_8 _ = happyFail

action_9 (75) = happyShift action_39
action_9 (17) = happyGoto action_43
action_9 _ = happyFail

action_10 (47) = happyShift action_42
action_10 (13) = happyGoto action_40
action_10 (14) = happyGoto action_41
action_10 _ = happyFail

action_11 (75) = happyShift action_39
action_11 (17) = happyGoto action_38
action_11 _ = happyFail

action_12 (63) = happyShift action_36
action_12 (75) = happyShift action_37
action_12 (18) = happyGoto action_34
action_12 (19) = happyGoto action_35
action_12 _ = happyFail

action_13 (47) = happyShift action_27
action_13 (56) = happyShift action_28
action_13 (58) = happyShift action_29
action_13 (75) = happyShift action_30
action_13 (38) = happyGoto action_33
action_13 _ = happyFail

action_14 (47) = happyShift action_27
action_14 (56) = happyShift action_28
action_14 (58) = happyShift action_29
action_14 (75) = happyShift action_30
action_14 (38) = happyGoto action_32
action_14 _ = happyFail

action_15 (75) = happyShift action_31
action_15 _ = happyFail

action_16 (47) = happyShift action_27
action_16 (56) = happyShift action_28
action_16 (58) = happyShift action_29
action_16 (75) = happyShift action_30
action_16 (38) = happyGoto action_26
action_16 _ = happyFail

action_17 (75) = happyShift action_25
action_17 _ = happyFail

action_18 (45) = happyShift action_24
action_18 _ = happyFail

action_19 (75) = happyShift action_23
action_19 _ = happyFail

action_20 (75) = happyShift action_22
action_20 _ = happyFail

action_21 (94) = happyAccept
action_21 _ = happyFail

action_22 (70) = happyShift action_116
action_22 _ = happyFail

action_23 (70) = happyShift action_115
action_23 _ = happyFail

action_24 (42) = happyShift action_109
action_24 (47) = happyShift action_110
action_24 (48) = happyShift action_111
action_24 (51) = happyShift action_112
action_24 (56) = happyShift action_113
action_24 (75) = happyShift action_114
action_24 (7) = happyGoto action_108
action_24 _ = happyReduce_23

action_25 (61) = happyShift action_107
action_25 _ = happyFail

action_26 (48) = happyShift action_88
action_26 (52) = happyShift action_89
action_26 (53) = happyShift action_90
action_26 (55) = happyShift action_91
action_26 (57) = happyShift action_92
action_26 (58) = happyShift action_93
action_26 (59) = happyShift action_94
action_26 (60) = happyShift action_95
action_26 (63) = happyShift action_96
action_26 (64) = happyShift action_97
action_26 (67) = happyShift action_98
action_26 (69) = happyShift action_99
action_26 (70) = happyShift action_100
action_26 _ = happyReduce_15

action_27 (47) = happyShift action_27
action_27 (56) = happyShift action_28
action_27 (58) = happyShift action_29
action_27 (75) = happyShift action_30
action_27 (38) = happyGoto action_106
action_27 _ = happyFail

action_28 (47) = happyShift action_27
action_28 (56) = happyShift action_28
action_28 (58) = happyShift action_29
action_28 (75) = happyShift action_30
action_28 (38) = happyGoto action_105
action_28 _ = happyFail

action_29 (47) = happyShift action_27
action_29 (56) = happyShift action_28
action_29 (58) = happyShift action_29
action_29 (75) = happyShift action_30
action_29 (38) = happyGoto action_104
action_29 _ = happyFail

action_30 (47) = happyShift action_103
action_30 _ = happyReduce_128

action_31 (70) = happyShift action_102
action_31 _ = happyFail

action_32 (48) = happyShift action_88
action_32 (52) = happyShift action_89
action_32 (53) = happyShift action_90
action_32 (55) = happyShift action_91
action_32 (57) = happyShift action_92
action_32 (58) = happyShift action_93
action_32 (59) = happyShift action_94
action_32 (60) = happyShift action_95
action_32 (63) = happyShift action_96
action_32 (64) = happyShift action_97
action_32 (67) = happyShift action_98
action_32 (69) = happyShift action_99
action_32 (70) = happyShift action_100
action_32 (72) = happyShift action_101
action_32 _ = happyFail

action_33 (48) = happyShift action_88
action_33 (52) = happyShift action_89
action_33 (53) = happyShift action_90
action_33 (55) = happyShift action_91
action_33 (57) = happyShift action_92
action_33 (58) = happyShift action_93
action_33 (59) = happyShift action_94
action_33 (60) = happyShift action_95
action_33 (63) = happyShift action_96
action_33 (64) = happyShift action_97
action_33 (67) = happyShift action_98
action_33 (69) = happyShift action_99
action_33 (70) = happyShift action_100
action_33 _ = happyReduce_12

action_34 _ = happyReduce_11

action_35 (42) = happyShift action_87
action_35 _ = happyReduce_48

action_36 (63) = happyShift action_36
action_36 (75) = happyShift action_37
action_36 (19) = happyGoto action_86
action_36 _ = happyFail

action_37 (47) = happyShift action_85
action_37 _ = happyReduce_50

action_38 _ = happyReduce_10

action_39 (42) = happyShift action_84
action_39 _ = happyReduce_46

action_40 _ = happyReduce_9

action_41 (42) = happyShift action_83
action_41 _ = happyReduce_40

action_42 (75) = happyShift action_82
action_42 _ = happyFail

action_43 _ = happyReduce_8

action_44 _ = happyReduce_6

action_45 (42) = happyShift action_81
action_45 _ = happyReduce_30

action_46 (61) = happyShift action_80
action_46 _ = happyReduce_32

action_47 _ = happyReduce_5

action_48 (42) = happyShift action_79
action_48 _ = happyReduce_43

action_49 (75) = happyShift action_78
action_49 _ = happyFail

action_50 _ = happyReduce_4

action_51 (75) = happyShift action_77
action_51 (29) = happyGoto action_75
action_51 (30) = happyGoto action_76
action_51 _ = happyFail

action_52 (40) = happyShift action_71
action_52 (47) = happyShift action_72
action_52 (56) = happyShift action_28
action_52 (58) = happyShift action_29
action_52 (63) = happyShift action_73
action_52 (75) = happyShift action_74
action_52 (24) = happyGoto action_68
action_52 (25) = happyGoto action_69
action_52 (38) = happyGoto action_70
action_52 _ = happyFail

action_53 (44) = happyShift action_67
action_53 _ = happyReduce_20

action_54 (47) = happyShift action_54
action_54 (75) = happyShift action_55
action_54 (76) = happyShift action_56
action_54 (77) = happyShift action_57
action_54 (80) = happyShift action_58
action_54 (20) = happyGoto action_66
action_54 _ = happyFail

action_55 (45) = happyShift action_64
action_55 (47) = happyShift action_65
action_55 (22) = happyGoto action_63
action_55 _ = happyReduce_63

action_56 (47) = happyShift action_62
action_56 _ = happyFail

action_57 (47) = happyShift action_61
action_57 _ = happyFail

action_58 (47) = happyShift action_60
action_58 _ = happyFail

action_59 _ = happyReduce_3

action_60 (75) = happyShift action_39
action_60 (17) = happyGoto action_182
action_60 _ = happyFail

action_61 (47) = happyShift action_49
action_61 (15) = happyGoto action_181
action_61 (16) = happyGoto action_48
action_61 _ = happyFail

action_62 (75) = happyShift action_39
action_62 (17) = happyGoto action_180
action_62 _ = happyFail

action_63 _ = happyReduce_53

action_64 (46) = happyShift action_179
action_64 (47) = happyShift action_27
action_64 (56) = happyShift action_28
action_64 (58) = happyShift action_29
action_64 (75) = happyShift action_30
action_64 (37) = happyGoto action_178
action_64 (38) = happyGoto action_134
action_64 _ = happyFail

action_65 (75) = happyShift action_177
action_65 (33) = happyGoto action_175
action_65 (34) = happyGoto action_176
action_65 _ = happyFail

action_66 (44) = happyShift action_67
action_66 (51) = happyShift action_174
action_66 _ = happyFail

action_67 (47) = happyShift action_54
action_67 (75) = happyShift action_55
action_67 (76) = happyShift action_56
action_67 (77) = happyShift action_57
action_67 (80) = happyShift action_58
action_67 (20) = happyGoto action_173
action_67 _ = happyFail

action_68 (54) = happyShift action_172
action_68 _ = happyReduce_22

action_69 _ = happyReduce_84

action_70 (48) = happyShift action_88
action_70 (52) = happyShift action_89
action_70 (53) = happyShift action_90
action_70 (55) = happyShift action_91
action_70 (57) = happyShift action_92
action_70 (58) = happyShift action_93
action_70 (59) = happyShift action_94
action_70 (60) = happyShift action_95
action_70 (63) = happyShift action_96
action_70 (64) = happyShift action_97
action_70 (67) = happyShift action_98
action_70 (69) = happyShift action_99
action_70 (70) = happyShift action_100
action_70 (71) = happyShift action_171
action_70 _ = happyFail

action_71 (47) = happyShift action_170
action_71 _ = happyFail

action_72 (40) = happyShift action_71
action_72 (47) = happyShift action_72
action_72 (56) = happyShift action_28
action_72 (58) = happyShift action_29
action_72 (63) = happyShift action_73
action_72 (75) = happyShift action_74
action_72 (24) = happyGoto action_168
action_72 (25) = happyGoto action_69
action_72 (38) = happyGoto action_169
action_72 _ = happyFail

action_73 (47) = happyShift action_27
action_73 (56) = happyShift action_28
action_73 (58) = happyShift action_29
action_73 (75) = happyShift action_30
action_73 (38) = happyGoto action_167
action_73 _ = happyFail

action_74 (45) = happyShift action_165
action_74 (47) = happyShift action_166
action_74 (48) = happyReduce_128
action_74 (51) = happyReduce_128
action_74 (52) = happyReduce_128
action_74 (53) = happyReduce_128
action_74 (55) = happyReduce_128
action_74 (57) = happyReduce_128
action_74 (58) = happyReduce_128
action_74 (59) = happyReduce_128
action_74 (60) = happyReduce_128
action_74 (63) = happyReduce_128
action_74 (64) = happyReduce_128
action_74 (67) = happyReduce_128
action_74 (69) = happyReduce_128
action_74 (70) = happyReduce_128
action_74 (71) = happyReduce_128
action_74 (72) = happyReduce_128
action_74 (21) = happyGoto action_164
action_74 _ = happyReduce_60

action_75 (42) = happyShift action_162
action_75 (51) = happyShift action_163
action_75 _ = happyFail

action_76 _ = happyReduce_98

action_77 (61) = happyShift action_161
action_77 _ = happyFail

action_78 (42) = happyShift action_160
action_78 _ = happyFail

action_79 (47) = happyShift action_49
action_79 (15) = happyGoto action_159
action_79 (16) = happyGoto action_48
action_79 _ = happyFail

action_80 (49) = happyShift action_157
action_80 (78) = happyShift action_158
action_80 _ = happyFail

action_81 (75) = happyShift action_46
action_81 (8) = happyGoto action_156
action_81 (9) = happyGoto action_45
action_81 _ = happyFail

action_82 (42) = happyShift action_155
action_82 _ = happyFail

action_83 (47) = happyShift action_42
action_83 (13) = happyGoto action_154
action_83 (14) = happyGoto action_41
action_83 _ = happyFail

action_84 (75) = happyShift action_39
action_84 (17) = happyGoto action_153
action_84 _ = happyFail

action_85 (75) = happyShift action_39
action_85 (17) = happyGoto action_152
action_85 _ = happyFail

action_86 (64) = happyShift action_151
action_86 _ = happyFail

action_87 (63) = happyShift action_36
action_87 (75) = happyShift action_37
action_87 (18) = happyGoto action_150
action_87 (19) = happyGoto action_35
action_87 _ = happyFail

action_88 (47) = happyShift action_27
action_88 (56) = happyShift action_28
action_88 (58) = happyShift action_29
action_88 (75) = happyShift action_30
action_88 (38) = happyGoto action_149
action_88 _ = happyFail

action_89 (47) = happyShift action_27
action_89 (56) = happyShift action_28
action_89 (58) = happyShift action_29
action_89 (75) = happyShift action_30
action_89 (38) = happyGoto action_148
action_89 _ = happyFail

action_90 (47) = happyShift action_27
action_90 (56) = happyShift action_28
action_90 (58) = happyShift action_29
action_90 (75) = happyShift action_30
action_90 (38) = happyGoto action_147
action_90 _ = happyFail

action_91 (47) = happyShift action_27
action_91 (56) = happyShift action_28
action_91 (58) = happyShift action_29
action_91 (75) = happyShift action_30
action_91 (38) = happyGoto action_146
action_91 _ = happyFail

action_92 (47) = happyShift action_27
action_92 (56) = happyShift action_28
action_92 (58) = happyShift action_29
action_92 (75) = happyShift action_30
action_92 (38) = happyGoto action_145
action_92 _ = happyFail

action_93 (47) = happyShift action_27
action_93 (56) = happyShift action_28
action_93 (58) = happyShift action_29
action_93 (75) = happyShift action_30
action_93 (38) = happyGoto action_144
action_93 _ = happyFail

action_94 (47) = happyShift action_27
action_94 (56) = happyShift action_28
action_94 (58) = happyShift action_29
action_94 (75) = happyShift action_30
action_94 (38) = happyGoto action_143
action_94 _ = happyFail

action_95 (47) = happyShift action_27
action_95 (56) = happyShift action_28
action_95 (58) = happyShift action_29
action_95 (75) = happyShift action_30
action_95 (38) = happyGoto action_142
action_95 _ = happyFail

action_96 (47) = happyShift action_27
action_96 (56) = happyShift action_28
action_96 (58) = happyShift action_29
action_96 (75) = happyShift action_30
action_96 (38) = happyGoto action_141
action_96 _ = happyFail

action_97 (47) = happyShift action_27
action_97 (56) = happyShift action_28
action_97 (58) = happyShift action_29
action_97 (75) = happyShift action_30
action_97 (38) = happyGoto action_140
action_97 _ = happyFail

action_98 (47) = happyShift action_27
action_98 (56) = happyShift action_28
action_98 (58) = happyShift action_29
action_98 (75) = happyShift action_30
action_98 (38) = happyGoto action_139
action_98 _ = happyFail

action_99 (47) = happyShift action_27
action_99 (56) = happyShift action_28
action_99 (58) = happyShift action_29
action_99 (75) = happyShift action_30
action_99 (38) = happyGoto action_138
action_99 _ = happyFail

action_100 (47) = happyShift action_27
action_100 (56) = happyShift action_28
action_100 (58) = happyShift action_29
action_100 (75) = happyShift action_30
action_100 (38) = happyGoto action_137
action_100 _ = happyFail

action_101 (47) = happyShift action_27
action_101 (56) = happyShift action_28
action_101 (58) = happyShift action_29
action_101 (75) = happyShift action_30
action_101 (38) = happyGoto action_136
action_101 _ = happyFail

action_102 (47) = happyShift action_27
action_102 (56) = happyShift action_28
action_102 (58) = happyShift action_29
action_102 (75) = happyShift action_30
action_102 (38) = happyGoto action_135
action_102 _ = happyFail

action_103 (47) = happyShift action_27
action_103 (56) = happyShift action_28
action_103 (58) = happyShift action_29
action_103 (75) = happyShift action_30
action_103 (37) = happyGoto action_133
action_103 (38) = happyGoto action_134
action_103 _ = happyFail

action_104 _ = happyReduce_124

action_105 (52) = happyShift action_89
action_105 (53) = happyShift action_90
action_105 (57) = happyShift action_92
action_105 (58) = happyShift action_93
action_105 (59) = happyShift action_94
action_105 (60) = happyShift action_95
action_105 (63) = happyShift action_96
action_105 (64) = happyShift action_97
action_105 (67) = happyShift action_98
action_105 (69) = happyShift action_99
action_105 (70) = happyShift action_100
action_105 _ = happyReduce_120

action_106 (48) = happyShift action_88
action_106 (51) = happyShift action_132
action_106 (52) = happyShift action_89
action_106 (53) = happyShift action_90
action_106 (55) = happyShift action_91
action_106 (57) = happyShift action_92
action_106 (58) = happyShift action_93
action_106 (59) = happyShift action_94
action_106 (60) = happyShift action_95
action_106 (63) = happyShift action_96
action_106 (64) = happyShift action_97
action_106 (67) = happyShift action_98
action_106 (69) = happyShift action_99
action_106 (70) = happyShift action_100
action_106 _ = happyFail

action_107 (49) = happyShift action_128
action_107 (75) = happyShift action_129
action_107 (92) = happyShift action_130
action_107 (93) = happyShift action_131
action_107 (26) = happyGoto action_127
action_107 _ = happyFail

action_108 (46) = happyShift action_126
action_108 _ = happyFail

action_109 (42) = happyShift action_109
action_109 (47) = happyShift action_110
action_109 (48) = happyShift action_111
action_109 (51) = happyShift action_112
action_109 (56) = happyShift action_113
action_109 (75) = happyShift action_114
action_109 (7) = happyGoto action_125
action_109 _ = happyReduce_23

action_110 (42) = happyShift action_109
action_110 (47) = happyShift action_110
action_110 (48) = happyShift action_111
action_110 (51) = happyShift action_112
action_110 (56) = happyShift action_113
action_110 (75) = happyShift action_114
action_110 (7) = happyGoto action_124
action_110 _ = happyReduce_23

action_111 (42) = happyShift action_109
action_111 (47) = happyShift action_110
action_111 (48) = happyShift action_111
action_111 (51) = happyShift action_112
action_111 (56) = happyShift action_113
action_111 (75) = happyShift action_114
action_111 (7) = happyGoto action_123
action_111 _ = happyReduce_23

action_112 (42) = happyShift action_109
action_112 (47) = happyShift action_110
action_112 (48) = happyShift action_111
action_112 (51) = happyShift action_112
action_112 (56) = happyShift action_113
action_112 (75) = happyShift action_114
action_112 (7) = happyGoto action_122
action_112 _ = happyReduce_23

action_113 (42) = happyShift action_109
action_113 (47) = happyShift action_110
action_113 (48) = happyShift action_111
action_113 (51) = happyShift action_112
action_113 (56) = happyShift action_113
action_113 (75) = happyShift action_114
action_113 (7) = happyGoto action_121
action_113 _ = happyReduce_23

action_114 (42) = happyShift action_109
action_114 (47) = happyShift action_110
action_114 (48) = happyShift action_111
action_114 (51) = happyShift action_112
action_114 (56) = happyShift action_113
action_114 (75) = happyShift action_114
action_114 (7) = happyGoto action_120
action_114 _ = happyReduce_23

action_115 (47) = happyShift action_118
action_115 (49) = happyShift action_119
action_115 _ = happyFail

action_116 (47) = happyShift action_117
action_116 _ = happyFail

action_117 (75) = happyShift action_222
action_117 (10) = happyGoto action_219
action_117 (11) = happyGoto action_220
action_117 (12) = happyGoto action_221
action_117 _ = happyFail

action_118 (75) = happyShift action_39
action_118 (17) = happyGoto action_218
action_118 _ = happyFail

action_119 (47) = happyShift action_27
action_119 (56) = happyShift action_28
action_119 (58) = happyShift action_29
action_119 (75) = happyShift action_30
action_119 (38) = happyGoto action_217
action_119 _ = happyFail

action_120 _ = happyReduce_24

action_121 _ = happyReduce_26

action_122 _ = happyReduce_28

action_123 _ = happyReduce_25

action_124 _ = happyReduce_27

action_125 _ = happyReduce_29

action_126 _ = happyReduce_14

action_127 (70) = happyShift action_216
action_127 _ = happyFail

action_128 (47) = happyShift action_27
action_128 (56) = happyShift action_28
action_128 (58) = happyShift action_29
action_128 (75) = happyShift action_30
action_128 (38) = happyGoto action_215
action_128 _ = happyFail

action_129 _ = happyReduce_91

action_130 _ = happyReduce_93

action_131 _ = happyReduce_92

action_132 _ = happyReduce_129

action_133 (42) = happyShift action_186
action_133 (51) = happyShift action_214
action_133 _ = happyFail

action_134 (48) = happyShift action_88
action_134 (52) = happyShift action_89
action_134 (53) = happyShift action_90
action_134 (55) = happyShift action_91
action_134 (57) = happyShift action_92
action_134 (58) = happyShift action_93
action_134 (59) = happyShift action_94
action_134 (60) = happyShift action_95
action_134 (63) = happyShift action_96
action_134 (64) = happyShift action_97
action_134 (67) = happyShift action_98
action_134 (69) = happyShift action_99
action_134 (70) = happyShift action_100
action_134 _ = happyReduce_110

action_135 (48) = happyShift action_88
action_135 (52) = happyShift action_89
action_135 (53) = happyShift action_90
action_135 (55) = happyShift action_91
action_135 (57) = happyShift action_92
action_135 (58) = happyShift action_93
action_135 (59) = happyShift action_94
action_135 (60) = happyShift action_95
action_135 (63) = happyShift action_96
action_135 (64) = happyShift action_97
action_135 (67) = happyShift action_98
action_135 (69) = happyShift action_99
action_135 (70) = happyShift action_100
action_135 _ = happyReduce_16

action_136 (48) = happyShift action_88
action_136 (52) = happyShift action_89
action_136 (53) = happyShift action_90
action_136 (55) = happyShift action_91
action_136 (57) = happyShift action_92
action_136 (58) = happyShift action_93
action_136 (59) = happyShift action_94
action_136 (60) = happyShift action_95
action_136 (63) = happyShift action_96
action_136 (64) = happyShift action_97
action_136 (67) = happyShift action_98
action_136 (69) = happyShift action_99
action_136 (70) = happyShift action_100
action_136 _ = happyReduce_13

action_137 (52) = happyShift action_89
action_137 (53) = happyShift action_90
action_137 (57) = happyFail
action_137 (58) = happyShift action_93
action_137 (59) = happyShift action_94
action_137 (60) = happyShift action_95
action_137 (63) = happyShift action_96
action_137 (64) = happyShift action_97
action_137 (67) = happyShift action_98
action_137 (69) = happyShift action_99
action_137 (70) = happyFail
action_137 _ = happyReduce_118

action_138 (52) = happyShift action_89
action_138 (53) = happyShift action_90
action_138 (58) = happyShift action_93
action_138 (59) = happyShift action_94
action_138 (60) = happyShift action_95
action_138 (63) = happyFail
action_138 (64) = happyFail
action_138 (67) = happyFail
action_138 (69) = happyFail
action_138 _ = happyReduce_117

action_139 (52) = happyShift action_89
action_139 (53) = happyShift action_90
action_139 (58) = happyShift action_93
action_139 (59) = happyShift action_94
action_139 (60) = happyShift action_95
action_139 (63) = happyFail
action_139 (64) = happyFail
action_139 (67) = happyFail
action_139 (69) = happyFail
action_139 _ = happyReduce_113

action_140 (52) = happyShift action_89
action_140 (53) = happyShift action_90
action_140 (58) = happyShift action_93
action_140 (59) = happyShift action_94
action_140 (60) = happyShift action_95
action_140 (63) = happyFail
action_140 (64) = happyFail
action_140 (67) = happyFail
action_140 (69) = happyFail
action_140 _ = happyReduce_114

action_141 (52) = happyShift action_89
action_141 (53) = happyShift action_90
action_141 (58) = happyShift action_93
action_141 (59) = happyShift action_94
action_141 (60) = happyShift action_95
action_141 (63) = happyFail
action_141 (64) = happyFail
action_141 (67) = happyFail
action_141 (69) = happyFail
action_141 _ = happyReduce_112

action_142 (53) = happyShift action_90
action_142 _ = happyReduce_125

action_143 (53) = happyShift action_90
action_143 _ = happyReduce_126

action_144 (53) = happyShift action_90
action_144 (59) = happyShift action_94
action_144 (60) = happyShift action_95
action_144 _ = happyReduce_123

action_145 (52) = happyShift action_89
action_145 (53) = happyShift action_90
action_145 (57) = happyFail
action_145 (58) = happyShift action_93
action_145 (59) = happyShift action_94
action_145 (60) = happyShift action_95
action_145 (63) = happyShift action_96
action_145 (64) = happyShift action_97
action_145 (67) = happyShift action_98
action_145 (69) = happyShift action_99
action_145 (70) = happyFail
action_145 _ = happyReduce_119

action_146 (52) = happyShift action_89
action_146 (53) = happyShift action_90
action_146 (57) = happyShift action_92
action_146 (58) = happyShift action_93
action_146 (59) = happyShift action_94
action_146 (60) = happyShift action_95
action_146 (63) = happyShift action_96
action_146 (64) = happyShift action_97
action_146 (67) = happyShift action_98
action_146 (69) = happyShift action_99
action_146 (70) = happyShift action_100
action_146 _ = happyReduce_115

action_147 _ = happyReduce_122

action_148 (53) = happyShift action_90
action_148 (59) = happyShift action_94
action_148 (60) = happyShift action_95
action_148 _ = happyReduce_121

action_149 (52) = happyShift action_89
action_149 (53) = happyShift action_90
action_149 (55) = happyShift action_91
action_149 (57) = happyShift action_92
action_149 (58) = happyShift action_93
action_149 (59) = happyShift action_94
action_149 (60) = happyShift action_95
action_149 (63) = happyShift action_96
action_149 (64) = happyShift action_97
action_149 (67) = happyShift action_98
action_149 (69) = happyShift action_99
action_149 (70) = happyShift action_100
action_149 _ = happyReduce_116

action_150 _ = happyReduce_49

action_151 _ = happyReduce_52

action_152 (51) = happyShift action_213
action_152 _ = happyFail

action_153 _ = happyReduce_47

action_154 _ = happyReduce_41

action_155 (75) = happyShift action_212
action_155 _ = happyFail

action_156 _ = happyReduce_31

action_157 (47) = happyShift action_27
action_157 (56) = happyShift action_28
action_157 (58) = happyShift action_29
action_157 (75) = happyShift action_30
action_157 (38) = happyGoto action_211
action_157 _ = happyFail

action_158 _ = happyReduce_33

action_159 _ = happyReduce_44

action_160 (75) = happyShift action_210
action_160 _ = happyFail

action_161 (49) = happyShift action_128
action_161 (75) = happyShift action_129
action_161 (92) = happyShift action_130
action_161 (93) = happyShift action_131
action_161 (26) = happyGoto action_209
action_161 _ = happyFail

action_162 (75) = happyShift action_77
action_162 (30) = happyGoto action_208
action_162 _ = happyFail

action_163 (70) = happyShift action_207
action_163 _ = happyFail

action_164 (43) = happyShift action_204
action_164 (49) = happyShift action_205
action_164 (66) = happyShift action_206
action_164 (23) = happyGoto action_203
action_164 _ = happyFail

action_165 (46) = happyShift action_201
action_165 (47) = happyShift action_27
action_165 (56) = happyShift action_28
action_165 (58) = happyShift action_29
action_165 (75) = happyShift action_202
action_165 (31) = happyGoto action_198
action_165 (32) = happyGoto action_199
action_165 (37) = happyGoto action_200
action_165 (38) = happyGoto action_134
action_165 _ = happyFail

action_166 (47) = happyShift action_27
action_166 (51) = happyShift action_197
action_166 (56) = happyShift action_28
action_166 (58) = happyShift action_29
action_166 (75) = happyShift action_30
action_166 (37) = happyGoto action_196
action_166 (38) = happyGoto action_134
action_166 _ = happyFail

action_167 (48) = happyShift action_88
action_167 (52) = happyShift action_89
action_167 (53) = happyShift action_90
action_167 (55) = happyShift action_91
action_167 (57) = happyShift action_92
action_167 (58) = happyShift action_93
action_167 (59) = happyShift action_94
action_167 (60) = happyShift action_95
action_167 (63) = happyShift action_96
action_167 (64) = happyShift action_195
action_167 (67) = happyShift action_98
action_167 (69) = happyShift action_99
action_167 (70) = happyShift action_100
action_167 _ = happyFail

action_168 (51) = happyShift action_194
action_168 (54) = happyShift action_172
action_168 _ = happyFail

action_169 (48) = happyShift action_88
action_169 (51) = happyShift action_132
action_169 (52) = happyShift action_89
action_169 (53) = happyShift action_90
action_169 (55) = happyShift action_91
action_169 (57) = happyShift action_92
action_169 (58) = happyShift action_93
action_169 (59) = happyShift action_94
action_169 (60) = happyShift action_95
action_169 (63) = happyShift action_96
action_169 (64) = happyShift action_97
action_169 (67) = happyShift action_98
action_169 (69) = happyShift action_99
action_169 (70) = happyShift action_100
action_169 (71) = happyShift action_171
action_169 _ = happyFail

action_170 (75) = happyShift action_193
action_170 _ = happyFail

action_171 (40) = happyShift action_71
action_171 (47) = happyShift action_72
action_171 (56) = happyShift action_28
action_171 (58) = happyShift action_29
action_171 (63) = happyShift action_73
action_171 (75) = happyShift action_74
action_171 (24) = happyGoto action_192
action_171 (25) = happyGoto action_69
action_171 (38) = happyGoto action_70
action_171 _ = happyFail

action_172 (40) = happyShift action_71
action_172 (47) = happyShift action_72
action_172 (56) = happyShift action_28
action_172 (58) = happyShift action_29
action_172 (63) = happyShift action_73
action_172 (75) = happyShift action_74
action_172 (24) = happyGoto action_191
action_172 (25) = happyGoto action_69
action_172 (38) = happyGoto action_70
action_172 _ = happyFail

action_173 _ = happyReduce_55

action_174 _ = happyReduce_59

action_175 (42) = happyShift action_189
action_175 (51) = happyShift action_190
action_175 _ = happyFail

action_176 _ = happyReduce_104

action_177 (70) = happyShift action_188
action_177 _ = happyFail

action_178 (42) = happyShift action_186
action_178 (46) = happyShift action_187
action_178 _ = happyFail

action_179 _ = happyReduce_64

action_180 (61) = happyShift action_185
action_180 _ = happyFail

action_181 (61) = happyShift action_184
action_181 _ = happyFail

action_182 (61) = happyShift action_183
action_182 _ = happyFail

action_183 (47) = happyShift action_54
action_183 (75) = happyShift action_55
action_183 (76) = happyShift action_56
action_183 (77) = happyShift action_57
action_183 (80) = happyShift action_58
action_183 (20) = happyGoto action_256
action_183 _ = happyFail

action_184 (47) = happyShift action_54
action_184 (75) = happyShift action_55
action_184 (76) = happyShift action_56
action_184 (77) = happyShift action_57
action_184 (80) = happyShift action_58
action_184 (20) = happyGoto action_255
action_184 _ = happyFail

action_185 (47) = happyShift action_54
action_185 (75) = happyShift action_55
action_185 (76) = happyShift action_56
action_185 (77) = happyShift action_57
action_185 (80) = happyShift action_58
action_185 (20) = happyGoto action_254
action_185 _ = happyFail

action_186 (47) = happyShift action_27
action_186 (56) = happyShift action_28
action_186 (58) = happyShift action_29
action_186 (75) = happyShift action_30
action_186 (38) = happyGoto action_253
action_186 _ = happyFail

action_187 _ = happyReduce_65

action_188 (75) = happyShift action_252
action_188 _ = happyFail

action_189 (75) = happyShift action_177
action_189 (34) = happyGoto action_251
action_189 _ = happyFail

action_190 (45) = happyShift action_64
action_190 (22) = happyGoto action_250
action_190 _ = happyReduce_63

action_191 _ = happyReduce_67

action_192 _ = happyReduce_83

action_193 (61) = happyShift action_249
action_193 _ = happyFail

action_194 _ = happyReduce_85

action_195 (43) = happyShift action_248
action_195 (47) = happyShift action_27
action_195 (56) = happyShift action_28
action_195 (58) = happyShift action_29
action_195 (66) = happyShift action_206
action_195 (75) = happyShift action_30
action_195 (23) = happyGoto action_247
action_195 (38) = happyGoto action_140
action_195 _ = happyFail

action_196 (42) = happyShift action_186
action_196 (51) = happyShift action_246
action_196 _ = happyFail

action_197 _ = happyReduce_61

action_198 (42) = happyShift action_244
action_198 (46) = happyShift action_245
action_198 _ = happyFail

action_199 _ = happyReduce_101

action_200 (42) = happyShift action_186
action_200 (46) = happyShift action_243
action_200 _ = happyFail

action_201 _ = happyReduce_90

action_202 (47) = happyShift action_103
action_202 (62) = happyShift action_242
action_202 _ = happyReduce_128

action_203 (43) = happyShift action_241
action_203 _ = happyFail

action_204 (40) = happyShift action_71
action_204 (41) = happyShift action_240
action_204 (47) = happyShift action_72
action_204 (56) = happyShift action_28
action_204 (58) = happyShift action_29
action_204 (63) = happyShift action_73
action_204 (75) = happyShift action_74
action_204 (24) = happyGoto action_239
action_204 (25) = happyGoto action_69
action_204 (38) = happyGoto action_70
action_204 _ = happyFail

action_205 (47) = happyShift action_27
action_205 (56) = happyShift action_28
action_205 (58) = happyShift action_29
action_205 (75) = happyShift action_30
action_205 (35) = happyGoto action_236
action_205 (36) = happyGoto action_237
action_205 (38) = happyGoto action_238
action_205 _ = happyFail

action_206 (47) = happyShift action_27
action_206 (56) = happyShift action_28
action_206 (58) = happyShift action_29
action_206 (75) = happyShift action_30
action_206 (38) = happyGoto action_235
action_206 _ = happyFail

action_207 (40) = happyShift action_71
action_207 (47) = happyShift action_72
action_207 (56) = happyShift action_28
action_207 (58) = happyShift action_29
action_207 (63) = happyShift action_73
action_207 (75) = happyShift action_74
action_207 (24) = happyGoto action_234
action_207 (25) = happyGoto action_69
action_207 (38) = happyGoto action_70
action_207 _ = happyFail

action_208 _ = happyReduce_99

action_209 _ = happyReduce_100

action_210 (51) = happyShift action_233
action_210 _ = happyFail

action_211 (48) = happyShift action_88
action_211 (52) = happyShift action_89
action_211 (53) = happyShift action_90
action_211 (55) = happyShift action_91
action_211 (57) = happyShift action_92
action_211 (58) = happyShift action_93
action_211 (59) = happyShift action_94
action_211 (60) = happyShift action_95
action_211 (63) = happyShift action_96
action_211 (64) = happyShift action_97
action_211 (65) = happyShift action_232
action_211 (67) = happyShift action_98
action_211 (69) = happyShift action_99
action_211 (70) = happyShift action_100
action_211 _ = happyFail

action_212 (42) = happyShift action_231
action_212 _ = happyFail

action_213 _ = happyReduce_51

action_214 _ = happyReduce_127

action_215 (48) = happyShift action_88
action_215 (52) = happyShift action_89
action_215 (53) = happyShift action_90
action_215 (55) = happyShift action_91
action_215 (57) = happyShift action_92
action_215 (58) = happyShift action_93
action_215 (59) = happyShift action_94
action_215 (60) = happyShift action_95
action_215 (63) = happyShift action_96
action_215 (64) = happyShift action_97
action_215 (65) = happyShift action_230
action_215 (67) = happyShift action_98
action_215 (69) = happyShift action_99
action_215 (70) = happyShift action_100
action_215 _ = happyFail

action_216 (47) = happyShift action_27
action_216 (56) = happyShift action_28
action_216 (58) = happyShift action_29
action_216 (75) = happyShift action_30
action_216 (38) = happyGoto action_229
action_216 _ = happyFail

action_217 (48) = happyShift action_88
action_217 (52) = happyShift action_89
action_217 (53) = happyShift action_90
action_217 (55) = happyShift action_91
action_217 (57) = happyShift action_92
action_217 (58) = happyShift action_93
action_217 (59) = happyShift action_94
action_217 (60) = happyShift action_95
action_217 (63) = happyShift action_96
action_217 (64) = happyShift action_97
action_217 (65) = happyShift action_228
action_217 (67) = happyShift action_98
action_217 (69) = happyShift action_99
action_217 (70) = happyShift action_100
action_217 _ = happyFail

action_218 (51) = happyShift action_227
action_218 _ = happyFail

action_219 (51) = happyShift action_226
action_219 _ = happyFail

action_220 (42) = happyShift action_225
action_220 _ = happyReduce_35

action_221 (72) = happyShift action_224
action_221 _ = happyFail

action_222 (60) = happyShift action_223
action_222 _ = happyReduce_38

action_223 (75) = happyShift action_222
action_223 (12) = happyGoto action_278
action_223 _ = happyFail

action_224 (75) = happyShift action_277
action_224 _ = happyFail

action_225 (75) = happyShift action_222
action_225 (10) = happyGoto action_276
action_225 (11) = happyGoto action_220
action_225 (12) = happyGoto action_221
action_225 _ = happyFail

action_226 _ = happyReduce_19

action_227 _ = happyReduce_17

action_228 (47) = happyShift action_27
action_228 (56) = happyShift action_28
action_228 (58) = happyShift action_29
action_228 (75) = happyShift action_30
action_228 (38) = happyGoto action_275
action_228 _ = happyFail

action_229 (48) = happyShift action_88
action_229 (52) = happyShift action_89
action_229 (53) = happyShift action_90
action_229 (55) = happyShift action_91
action_229 (57) = happyShift action_92
action_229 (58) = happyShift action_93
action_229 (59) = happyShift action_94
action_229 (60) = happyShift action_95
action_229 (63) = happyShift action_96
action_229 (64) = happyShift action_97
action_229 (67) = happyShift action_98
action_229 (69) = happyShift action_99
action_229 (70) = happyShift action_100
action_229 _ = happyReduce_7

action_230 (47) = happyShift action_27
action_230 (56) = happyShift action_28
action_230 (58) = happyShift action_29
action_230 (75) = happyShift action_30
action_230 (38) = happyGoto action_274
action_230 _ = happyFail

action_231 (75) = happyShift action_273
action_231 _ = happyFail

action_232 (47) = happyShift action_27
action_232 (56) = happyShift action_28
action_232 (58) = happyShift action_29
action_232 (75) = happyShift action_30
action_232 (38) = happyGoto action_272
action_232 _ = happyFail

action_233 _ = happyReduce_45

action_234 (54) = happyShift action_172
action_234 _ = happyReduce_21

action_235 (48) = happyShift action_88
action_235 (52) = happyShift action_89
action_235 (53) = happyShift action_90
action_235 (55) = happyShift action_91
action_235 (57) = happyShift action_92
action_235 (58) = happyShift action_93
action_235 (59) = happyShift action_94
action_235 (60) = happyShift action_95
action_235 (63) = happyShift action_96
action_235 (64) = happyShift action_97
action_235 (67) = happyShift action_98
action_235 (69) = happyShift action_99
action_235 (70) = happyShift action_100
action_235 _ = happyReduce_66

action_236 (42) = happyShift action_270
action_236 (50) = happyShift action_271
action_236 _ = happyFail

action_237 _ = happyReduce_107

action_238 (48) = happyShift action_88
action_238 (52) = happyShift action_89
action_238 (53) = happyShift action_90
action_238 (55) = happyShift action_91
action_238 (57) = happyShift action_92
action_238 (58) = happyShift action_93
action_238 (59) = happyShift action_94
action_238 (60) = happyShift action_95
action_238 (62) = happyShift action_269
action_238 (63) = happyShift action_96
action_238 (64) = happyShift action_97
action_238 (67) = happyShift action_98
action_238 (69) = happyShift action_99
action_238 (70) = happyShift action_100
action_238 _ = happyFail

action_239 _ = happyReduce_69

action_240 (47) = happyShift action_268
action_240 _ = happyFail

action_241 (40) = happyShift action_71
action_241 (41) = happyShift action_267
action_241 (47) = happyShift action_72
action_241 (56) = happyShift action_28
action_241 (58) = happyShift action_29
action_241 (63) = happyShift action_73
action_241 (75) = happyShift action_74
action_241 (24) = happyGoto action_266
action_241 (25) = happyGoto action_69
action_241 (38) = happyGoto action_70
action_241 _ = happyFail

action_242 (47) = happyShift action_27
action_242 (56) = happyShift action_28
action_242 (58) = happyShift action_29
action_242 (75) = happyShift action_30
action_242 (38) = happyGoto action_265
action_242 _ = happyFail

action_243 _ = happyReduce_88

action_244 (75) = happyShift action_264
action_244 (32) = happyGoto action_263
action_244 _ = happyFail

action_245 _ = happyReduce_89

action_246 (48) = happyReduce_127
action_246 (51) = happyReduce_127
action_246 (52) = happyReduce_127
action_246 (53) = happyReduce_127
action_246 (55) = happyReduce_127
action_246 (57) = happyReduce_127
action_246 (58) = happyReduce_127
action_246 (59) = happyReduce_127
action_246 (60) = happyReduce_127
action_246 (63) = happyReduce_127
action_246 (64) = happyReduce_127
action_246 (67) = happyReduce_127
action_246 (69) = happyReduce_127
action_246 (70) = happyReduce_127
action_246 (71) = happyReduce_127
action_246 (72) = happyReduce_127
action_246 _ = happyReduce_62

action_247 (43) = happyShift action_262
action_247 _ = happyFail

action_248 (40) = happyShift action_71
action_248 (47) = happyShift action_72
action_248 (56) = happyShift action_28
action_248 (58) = happyShift action_29
action_248 (63) = happyShift action_73
action_248 (75) = happyShift action_74
action_248 (24) = happyGoto action_261
action_248 (25) = happyGoto action_69
action_248 (38) = happyGoto action_70
action_248 _ = happyFail

action_249 (49) = happyShift action_128
action_249 (75) = happyShift action_129
action_249 (92) = happyShift action_130
action_249 (93) = happyShift action_131
action_249 (26) = happyGoto action_260
action_249 _ = happyFail

action_250 _ = happyReduce_54

action_251 _ = happyReduce_105

action_252 _ = happyReduce_106

action_253 (48) = happyShift action_88
action_253 (52) = happyShift action_89
action_253 (53) = happyShift action_90
action_253 (55) = happyShift action_91
action_253 (57) = happyShift action_92
action_253 (58) = happyShift action_93
action_253 (59) = happyShift action_94
action_253 (60) = happyShift action_95
action_253 (63) = happyShift action_96
action_253 (64) = happyShift action_97
action_253 (67) = happyShift action_98
action_253 (69) = happyShift action_99
action_253 (70) = happyShift action_100
action_253 _ = happyReduce_111

action_254 (44) = happyShift action_67
action_254 (51) = happyShift action_259
action_254 _ = happyFail

action_255 (44) = happyShift action_67
action_255 (51) = happyShift action_258
action_255 _ = happyFail

action_256 (44) = happyShift action_67
action_256 (51) = happyShift action_257
action_256 _ = happyFail

action_257 _ = happyReduce_57

action_258 _ = happyReduce_58

action_259 _ = happyReduce_56

action_260 (42) = happyShift action_294
action_260 _ = happyFail

action_261 _ = happyReduce_86

action_262 (40) = happyShift action_71
action_262 (47) = happyShift action_72
action_262 (56) = happyShift action_28
action_262 (58) = happyShift action_29
action_262 (63) = happyShift action_73
action_262 (75) = happyShift action_74
action_262 (24) = happyGoto action_293
action_262 (25) = happyGoto action_69
action_262 (38) = happyGoto action_70
action_262 _ = happyFail

action_263 _ = happyReduce_102

action_264 (62) = happyShift action_242
action_264 _ = happyFail

action_265 (48) = happyShift action_88
action_265 (52) = happyShift action_89
action_265 (53) = happyShift action_90
action_265 (55) = happyShift action_91
action_265 (57) = happyShift action_92
action_265 (58) = happyShift action_93
action_265 (59) = happyShift action_94
action_265 (60) = happyShift action_95
action_265 (63) = happyShift action_96
action_265 (64) = happyShift action_97
action_265 (67) = happyShift action_98
action_265 (69) = happyShift action_99
action_265 (70) = happyShift action_100
action_265 _ = happyReduce_103

action_266 _ = happyReduce_68

action_267 (47) = happyShift action_292
action_267 _ = happyFail

action_268 (47) = happyShift action_27
action_268 (56) = happyShift action_28
action_268 (58) = happyShift action_29
action_268 (75) = happyShift action_291
action_268 (27) = happyGoto action_287
action_268 (28) = happyGoto action_288
action_268 (38) = happyGoto action_289
action_268 (39) = happyGoto action_290
action_268 _ = happyFail

action_269 (47) = happyShift action_27
action_269 (56) = happyShift action_28
action_269 (58) = happyShift action_29
action_269 (75) = happyShift action_30
action_269 (38) = happyGoto action_286
action_269 _ = happyFail

action_270 (47) = happyShift action_27
action_270 (56) = happyShift action_28
action_270 (58) = happyShift action_29
action_270 (75) = happyShift action_30
action_270 (36) = happyGoto action_285
action_270 (38) = happyGoto action_238
action_270 _ = happyFail

action_271 (43) = happyShift action_284
action_271 (66) = happyShift action_206
action_271 (23) = happyGoto action_283
action_271 _ = happyFail

action_272 (48) = happyShift action_88
action_272 (50) = happyShift action_282
action_272 (52) = happyShift action_89
action_272 (53) = happyShift action_90
action_272 (55) = happyShift action_91
action_272 (57) = happyShift action_92
action_272 (58) = happyShift action_93
action_272 (59) = happyShift action_94
action_272 (60) = happyShift action_95
action_272 (63) = happyShift action_96
action_272 (64) = happyShift action_97
action_272 (67) = happyShift action_98
action_272 (69) = happyShift action_99
action_272 (70) = happyShift action_100
action_272 _ = happyFail

action_273 (51) = happyShift action_281
action_273 _ = happyFail

action_274 (48) = happyShift action_88
action_274 (50) = happyShift action_280
action_274 (52) = happyShift action_89
action_274 (53) = happyShift action_90
action_274 (55) = happyShift action_91
action_274 (57) = happyShift action_92
action_274 (58) = happyShift action_93
action_274 (59) = happyShift action_94
action_274 (60) = happyShift action_95
action_274 (63) = happyShift action_96
action_274 (64) = happyShift action_97
action_274 (67) = happyShift action_98
action_274 (69) = happyShift action_99
action_274 (70) = happyShift action_100
action_274 _ = happyFail

action_275 (48) = happyShift action_88
action_275 (50) = happyShift action_279
action_275 (52) = happyShift action_89
action_275 (53) = happyShift action_90
action_275 (55) = happyShift action_91
action_275 (57) = happyShift action_92
action_275 (58) = happyShift action_93
action_275 (59) = happyShift action_94
action_275 (60) = happyShift action_95
action_275 (63) = happyShift action_96
action_275 (64) = happyShift action_97
action_275 (67) = happyShift action_98
action_275 (69) = happyShift action_99
action_275 (70) = happyShift action_100
action_275 _ = happyFail

action_276 _ = happyReduce_36

action_277 _ = happyReduce_37

action_278 _ = happyReduce_39

action_279 _ = happyReduce_18

action_280 _ = happyReduce_94

action_281 _ = happyReduce_42

action_282 _ = happyReduce_34

action_283 (43) = happyShift action_305
action_283 _ = happyFail

action_284 (40) = happyShift action_71
action_284 (41) = happyShift action_304
action_284 (47) = happyShift action_72
action_284 (56) = happyShift action_28
action_284 (58) = happyShift action_29
action_284 (63) = happyShift action_73
action_284 (75) = happyShift action_74
action_284 (24) = happyGoto action_303
action_284 (25) = happyGoto action_69
action_284 (38) = happyGoto action_70
action_284 _ = happyFail

action_285 _ = happyReduce_108

action_286 (48) = happyShift action_88
action_286 (52) = happyShift action_89
action_286 (53) = happyShift action_90
action_286 (55) = happyShift action_91
action_286 (57) = happyShift action_92
action_286 (58) = happyShift action_93
action_286 (59) = happyShift action_94
action_286 (60) = happyShift action_95
action_286 (63) = happyShift action_96
action_286 (64) = happyShift action_97
action_286 (67) = happyShift action_98
action_286 (69) = happyShift action_99
action_286 (70) = happyShift action_100
action_286 _ = happyReduce_109

action_287 (61) = happyShift action_302
action_287 _ = happyFail

action_288 (44) = happyShift action_301
action_288 _ = happyReduce_95

action_289 (48) = happyShift action_88
action_289 (52) = happyShift action_89
action_289 (53) = happyShift action_90
action_289 (55) = happyShift action_91
action_289 (57) = happyShift action_92
action_289 (58) = happyShift action_93
action_289 (59) = happyShift action_94
action_289 (60) = happyShift action_95
action_289 (63) = happyShift action_96
action_289 (64) = happyShift action_97
action_289 (67) = happyShift action_98
action_289 (69) = happyShift action_99
action_289 (70) = happyShift action_100
action_289 (72) = happyShift action_300
action_289 _ = happyFail

action_290 (51) = happyShift action_299
action_290 _ = happyFail

action_291 (47) = happyShift action_103
action_291 (61) = happyShift action_298
action_291 _ = happyReduce_128

action_292 (47) = happyShift action_27
action_292 (56) = happyShift action_28
action_292 (58) = happyShift action_29
action_292 (75) = happyShift action_291
action_292 (27) = happyGoto action_296
action_292 (28) = happyGoto action_288
action_292 (38) = happyGoto action_289
action_292 (39) = happyGoto action_297
action_292 _ = happyFail

action_293 _ = happyReduce_87

action_294 (40) = happyShift action_71
action_294 (47) = happyShift action_72
action_294 (56) = happyShift action_28
action_294 (58) = happyShift action_29
action_294 (63) = happyShift action_73
action_294 (75) = happyShift action_74
action_294 (24) = happyGoto action_295
action_294 (25) = happyGoto action_69
action_294 (38) = happyGoto action_70
action_294 _ = happyFail

action_295 (51) = happyShift action_317
action_295 (54) = happyShift action_172
action_295 _ = happyFail

action_296 (61) = happyShift action_316
action_296 _ = happyFail

action_297 (51) = happyShift action_315
action_297 _ = happyFail

action_298 (49) = happyShift action_128
action_298 (75) = happyShift action_129
action_298 (92) = happyShift action_130
action_298 (93) = happyShift action_131
action_298 (26) = happyGoto action_314
action_298 _ = happyFail

action_299 _ = happyReduce_79

action_300 (40) = happyShift action_71
action_300 (47) = happyShift action_72
action_300 (56) = happyShift action_28
action_300 (58) = happyShift action_29
action_300 (63) = happyShift action_73
action_300 (75) = happyShift action_74
action_300 (24) = happyGoto action_313
action_300 (25) = happyGoto action_69
action_300 (38) = happyGoto action_70
action_300 _ = happyFail

action_301 (75) = happyShift action_312
action_301 (27) = happyGoto action_311
action_301 (28) = happyGoto action_288
action_301 _ = happyFail

action_302 (40) = happyShift action_71
action_302 (47) = happyShift action_72
action_302 (49) = happyShift action_310
action_302 (56) = happyShift action_28
action_302 (58) = happyShift action_29
action_302 (63) = happyShift action_73
action_302 (75) = happyShift action_74
action_302 (24) = happyGoto action_309
action_302 (25) = happyGoto action_69
action_302 (38) = happyGoto action_70
action_302 _ = happyFail

action_303 _ = happyReduce_71

action_304 (47) = happyShift action_308
action_304 _ = happyFail

action_305 (40) = happyShift action_71
action_305 (41) = happyShift action_307
action_305 (47) = happyShift action_72
action_305 (56) = happyShift action_28
action_305 (58) = happyShift action_29
action_305 (63) = happyShift action_73
action_305 (75) = happyShift action_74
action_305 (24) = happyGoto action_306
action_305 (25) = happyGoto action_69
action_305 (38) = happyGoto action_70
action_305 _ = happyFail

action_306 _ = happyReduce_70

action_307 (47) = happyShift action_326
action_307 _ = happyFail

action_308 (47) = happyShift action_27
action_308 (56) = happyShift action_28
action_308 (58) = happyShift action_29
action_308 (75) = happyShift action_291
action_308 (27) = happyGoto action_324
action_308 (28) = happyGoto action_288
action_308 (38) = happyGoto action_289
action_308 (39) = happyGoto action_325
action_308 _ = happyFail

action_309 (51) = happyShift action_323
action_309 (54) = happyShift action_172
action_309 _ = happyFail

action_310 (47) = happyShift action_27
action_310 (56) = happyShift action_28
action_310 (58) = happyShift action_29
action_310 (75) = happyShift action_30
action_310 (35) = happyGoto action_322
action_310 (36) = happyGoto action_237
action_310 (38) = happyGoto action_238
action_310 _ = happyFail

action_311 _ = happyReduce_96

action_312 (61) = happyShift action_298
action_312 _ = happyFail

action_313 (54) = happyShift action_321
action_313 _ = happyReduce_130

action_314 (42) = happyShift action_320
action_314 _ = happyFail

action_315 _ = happyReduce_78

action_316 (40) = happyShift action_71
action_316 (47) = happyShift action_72
action_316 (49) = happyShift action_319
action_316 (56) = happyShift action_28
action_316 (58) = happyShift action_29
action_316 (63) = happyShift action_73
action_316 (75) = happyShift action_74
action_316 (24) = happyGoto action_318
action_316 (25) = happyGoto action_69
action_316 (38) = happyGoto action_70
action_316 _ = happyFail

action_317 _ = happyReduce_82

action_318 (51) = happyShift action_336
action_318 (54) = happyShift action_172
action_318 _ = happyFail

action_319 (47) = happyShift action_27
action_319 (56) = happyShift action_28
action_319 (58) = happyShift action_29
action_319 (75) = happyShift action_30
action_319 (35) = happyGoto action_335
action_319 (36) = happyGoto action_237
action_319 (38) = happyGoto action_238
action_319 _ = happyFail

action_320 (47) = happyShift action_27
action_320 (56) = happyShift action_28
action_320 (58) = happyShift action_29
action_320 (75) = happyShift action_30
action_320 (38) = happyGoto action_334
action_320 _ = happyFail

action_321 (40) = happyShift action_71
action_321 (47) = happyShift action_72
action_321 (56) = happyShift action_28
action_321 (58) = happyShift action_29
action_321 (63) = happyShift action_73
action_321 (75) = happyShift action_74
action_321 (24) = happyGoto action_191
action_321 (25) = happyGoto action_69
action_321 (38) = happyGoto action_332
action_321 (39) = happyGoto action_333
action_321 _ = happyFail

action_322 (42) = happyShift action_270
action_322 (50) = happyShift action_331
action_322 _ = happyFail

action_323 _ = happyReduce_73

action_324 (61) = happyShift action_330
action_324 _ = happyFail

action_325 (51) = happyShift action_329
action_325 _ = happyFail

action_326 (47) = happyShift action_27
action_326 (56) = happyShift action_28
action_326 (58) = happyShift action_29
action_326 (75) = happyShift action_291
action_326 (27) = happyGoto action_327
action_326 (28) = happyGoto action_288
action_326 (38) = happyGoto action_289
action_326 (39) = happyGoto action_328
action_326 _ = happyFail

action_327 (61) = happyShift action_341
action_327 _ = happyFail

action_328 (51) = happyShift action_340
action_328 _ = happyFail

action_329 _ = happyReduce_81

action_330 (40) = happyShift action_71
action_330 (47) = happyShift action_72
action_330 (56) = happyShift action_28
action_330 (58) = happyShift action_29
action_330 (63) = happyShift action_73
action_330 (75) = happyShift action_74
action_330 (24) = happyGoto action_339
action_330 (25) = happyGoto action_69
action_330 (38) = happyGoto action_70
action_330 _ = happyFail

action_331 (40) = happyShift action_71
action_331 (47) = happyShift action_72
action_331 (56) = happyShift action_28
action_331 (58) = happyShift action_29
action_331 (63) = happyShift action_73
action_331 (75) = happyShift action_74
action_331 (24) = happyGoto action_338
action_331 (25) = happyGoto action_69
action_331 (38) = happyGoto action_70
action_331 _ = happyFail

action_332 (48) = happyShift action_88
action_332 (52) = happyShift action_89
action_332 (53) = happyShift action_90
action_332 (55) = happyShift action_91
action_332 (57) = happyShift action_92
action_332 (58) = happyShift action_93
action_332 (59) = happyShift action_94
action_332 (60) = happyShift action_95
action_332 (63) = happyShift action_96
action_332 (64) = happyShift action_97
action_332 (67) = happyShift action_98
action_332 (69) = happyShift action_99
action_332 (70) = happyShift action_100
action_332 (71) = happyShift action_171
action_332 (72) = happyShift action_300
action_332 _ = happyFail

action_333 _ = happyReduce_131

action_334 (48) = happyShift action_88
action_334 (52) = happyShift action_89
action_334 (53) = happyShift action_90
action_334 (55) = happyShift action_91
action_334 (57) = happyShift action_92
action_334 (58) = happyShift action_93
action_334 (59) = happyShift action_94
action_334 (60) = happyShift action_95
action_334 (63) = happyShift action_96
action_334 (64) = happyShift action_97
action_334 (67) = happyShift action_98
action_334 (69) = happyShift action_99
action_334 (70) = happyShift action_100
action_334 _ = happyReduce_97

action_335 (42) = happyShift action_270
action_335 (50) = happyShift action_337
action_335 _ = happyFail

action_336 _ = happyReduce_72

action_337 (40) = happyShift action_71
action_337 (47) = happyShift action_72
action_337 (56) = happyShift action_28
action_337 (58) = happyShift action_29
action_337 (63) = happyShift action_73
action_337 (75) = happyShift action_74
action_337 (24) = happyGoto action_345
action_337 (25) = happyGoto action_69
action_337 (38) = happyGoto action_70
action_337 _ = happyFail

action_338 (51) = happyShift action_344
action_338 (54) = happyShift action_172
action_338 _ = happyFail

action_339 (51) = happyShift action_343
action_339 (54) = happyShift action_172
action_339 _ = happyFail

action_340 _ = happyReduce_80

action_341 (40) = happyShift action_71
action_341 (47) = happyShift action_72
action_341 (56) = happyShift action_28
action_341 (58) = happyShift action_29
action_341 (63) = happyShift action_73
action_341 (75) = happyShift action_74
action_341 (24) = happyGoto action_342
action_341 (25) = happyGoto action_69
action_341 (38) = happyGoto action_70
action_341 _ = happyFail

action_342 (51) = happyShift action_347
action_342 (54) = happyShift action_172
action_342 _ = happyFail

action_343 _ = happyReduce_75

action_344 _ = happyReduce_77

action_345 (51) = happyShift action_346
action_345 (54) = happyShift action_172
action_345 _ = happyFail

action_346 _ = happyReduce_76

action_347 _ = happyReduce_74

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_0  5 happyReduction_2
happyReduction_2  =  HappyAbsSyn5
		 ([]
	)

happyReduce_3 = happySpecReduce_2  5 happyReduction_3
happyReduction_3 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 : happy_var_2
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_2  6 happyReduction_4
happyReduction_4 (HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (DataHiding happy_var_2
	)
happyReduction_4 _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_2  6 happyReduction_5
happyReduction_5 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (DataRenaming happy_var_2
	)
happyReduction_5 _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_2  6 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (DataActions happy_var_2
	)
happyReduction_6 _ _  = notHappyAtAll 

happyReduce_7 = happyReduce 6 6 happyReduction_7
happyReduction_7 ((HappyAbsSyn38  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DataGlobal (happy_var_2, happy_var_4) happy_var_6
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_2  6 happyReduction_8
happyReduction_8 (HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (DataEncapsulation happy_var_2
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_2  6 happyReduction_9
happyReduction_9 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (DataCommunication happy_var_2
	)
happyReduction_9 _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_2  6 happyReduction_10
happyReduction_10 (HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (DataNoCommunication happy_var_2
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_2  6 happyReduction_11
happyReduction_11 (HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (DataReach happy_var_2
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_2  6 happyReduction_12
happyReduction_12 (HappyAbsSyn38  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (DataReachCondition happy_var_2
	)
happyReduction_12 _ _  = notHappyAtAll 

happyReduce_13 = happyReduce 4 6 happyReduction_13
happyReduction_13 ((HappyAbsSyn38  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DataStateReward happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_14 = happyReduce 4 6 happyReduction_14
happyReduction_14 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DataUntilFormula happy_var_3
	) `HappyStk` happyRest

happyReduce_15 = happySpecReduce_2  6 happyReduction_15
happyReduction_15 (HappyAbsSyn38  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (DataFormula happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happyReduce 4 6 happyReduction_16
happyReduction_16 ((HappyAbsSyn38  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DataConstant happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_17 = happyReduce 6 6 happyReduction_17
happyReduction_17 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DataEnumType happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 8 6 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyAbsSyn38  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DataRangeType happy_var_2 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 6 6 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn10  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DataFunction happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_2  6 happyReduction_20
happyReduction_20 (HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (ParserInitialProcess happy_var_2
	)
happyReduction_20 _ _  = notHappyAtAll 

happyReduce_21 = happyReduce 6 6 happyReduction_21
happyReduction_21 ((HappyAbsSyn24  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn29  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (ParserProcess (Process happy_var_1 (reverse happy_var_3) happy_var_6)
	) `HappyStk` happyRest

happyReduce_22 = happySpecReduce_3  6 happyReduction_22
happyReduction_22 (HappyAbsSyn24  happy_var_3)
	_
	(HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn6
		 (ParserProcess (Process happy_var_1 [] happy_var_3)
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_0  7 happyReduction_23
happyReduction_23  =  HappyAbsSyn7
		 (""
	)

happyReduce_24 = happySpecReduce_2  7 happyReduction_24
happyReduction_24 (HappyAbsSyn7  happy_var_2)
	(HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn7
		 (happy_var_1 ++ " " ++ happy_var_2
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_2  7 happyReduction_25
happyReduction_25 (HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 ("|" ++ " " ++ happy_var_2
	)
happyReduction_25 _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_2  7 happyReduction_26
happyReduction_26 (HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 ("!" ++ " " ++ happy_var_2
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_2  7 happyReduction_27
happyReduction_27 (HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 ("(" ++ " " ++ happy_var_2
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_2  7 happyReduction_28
happyReduction_28 (HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (")" ++ " " ++ happy_var_2
	)
happyReduction_28 _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_2  7 happyReduction_29
happyReduction_29 (HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 ("," ++ " " ++ happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  8 happyReduction_30
happyReduction_30 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  8 happyReduction_31
happyReduction_31 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1:happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  9 happyReduction_32
happyReduction_32 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn9
		 ((happy_var_1, None)
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  9 happyReduction_33
happyReduction_33 _
	_
	(HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn9
		 ((happy_var_1, Bool)
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happyReduce 7 9 happyReduction_34
happyReduction_34 (_ `HappyStk`
	(HappyAbsSyn38  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 ((happy_var_1, IntRange happy_var_4 happy_var_6)
	) `HappyStk` happyRest

happyReduce_35 = happySpecReduce_1  10 happyReduction_35
happyReduction_35 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 ([happy_var_1]
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  10 happyReduction_36
happyReduction_36 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1:happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  11 happyReduction_37
happyReduction_37 (HappyTerminal (TokenString happy_var_3))
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 ((happy_var_1, happy_var_3)
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  12 happyReduction_38
happyReduction_38 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn12
		 ([happy_var_1]
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  12 happyReduction_39
happyReduction_39 (HappyAbsSyn12  happy_var_3)
	_
	(HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn12
		 (happy_var_1:happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  13 happyReduction_40
happyReduction_40 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ([happy_var_1]
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  13 happyReduction_41
happyReduction_41 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1 : happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happyReduce 7 14 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyTerminal (TokenString happy_var_6)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 ((happy_var_2,happy_var_4,happy_var_6)
	) `HappyStk` happyRest

happyReduce_43 = happySpecReduce_1  15 happyReduction_43
happyReduction_43 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 ([happy_var_1]
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  15 happyReduction_44
happyReduction_44 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1 : happy_var_3
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happyReduce 5 16 happyReduction_45
happyReduction_45 (_ `HappyStk`
	(HappyTerminal (TokenString happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 ((happy_var_2,happy_var_4)
	) `HappyStk` happyRest

happyReduce_46 = happySpecReduce_1  17 happyReduction_46
happyReduction_46 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn17
		 ([happy_var_1]
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  17 happyReduction_47
happyReduction_47 (HappyAbsSyn17  happy_var_3)
	_
	(HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn17
		 (happy_var_1 : happy_var_3
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  18 happyReduction_48
happyReduction_48 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn18
		 ([happy_var_1]
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  18 happyReduction_49
happyReduction_49 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1 : happy_var_3
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  19 happyReduction_50
happyReduction_50 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happyReduce 4 19 happyReduction_51
happyReduction_51 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (happy_var_1 ++ commaList happy_var_3
	) `HappyStk` happyRest

happyReduce_52 = happySpecReduce_3  19 happyReduction_52
happyReduction_52 _
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn19
		 ("rate(" ++ happy_var_2 ++ ")"
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_2  20 happyReduction_53
happyReduction_53 (HappyAbsSyn22  happy_var_2)
	(HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn20
		 (InitSingleProcess (InitialProcess happy_var_1 happy_var_2 [])
	)
happyReduction_53 _ _  = notHappyAtAll 

happyReduce_54 = happyReduce 5 20 happyReduction_54
happyReduction_54 ((HappyAbsSyn22  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn33  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (InitSingleProcess (InitialProcess happy_var_1 happy_var_5 happy_var_3)
	) `HappyStk` happyRest

happyReduce_55 = happySpecReduce_3  20 happyReduction_55
happyReduction_55 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (InitParallel happy_var_1 happy_var_3
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happyReduce 6 20 happyReduction_56
happyReduction_56 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (InitHiding happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_57 = happyReduce 6 20 happyReduction_57
happyReduction_57 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (InitEncapsulation happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_58 = happyReduce 6 20 happyReduction_58
happyReduction_58 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (InitRenaming happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_59 = happySpecReduce_3  20 happyReduction_59
happyReduction_59 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (happy_var_2
	)
happyReduction_59 _ _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_0  21 happyReduction_60
happyReduction_60  =  HappyAbsSyn21
		 ([]
	)

happyReduce_61 = happySpecReduce_2  21 happyReduction_61
happyReduction_61 _
	_
	 =  HappyAbsSyn21
		 ([]
	)

happyReduce_62 = happySpecReduce_3  21 happyReduction_62
happyReduction_62 _
	(HappyAbsSyn37  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (reverse happy_var_2
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_0  22 happyReduction_63
happyReduction_63  =  HappyAbsSyn22
		 ([]
	)

happyReduce_64 = happySpecReduce_2  22 happyReduction_64
happyReduction_64 _
	_
	 =  HappyAbsSyn22
		 ([]
	)

happyReduce_65 = happySpecReduce_3  22 happyReduction_65
happyReduction_65 _
	(HappyAbsSyn37  happy_var_2)
	_
	 =  HappyAbsSyn22
		 (reverse happy_var_2
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_2  23 happyReduction_66
happyReduction_66 (HappyAbsSyn38  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (happy_var_2
	)
happyReduction_66 _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  24 happyReduction_67
happyReduction_67 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (Plus ([happy_var_1] ++ [happy_var_3])
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happyReduce 5 24 happyReduction_68
happyReduction_68 ((HappyAbsSyn24  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then ActionPrefix happy_var_3 happy_var_1 happy_var_2 [("i0", TypeRange 1 1, (Variable "1"))] happy_var_5 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_69 = happyReduce 4 24 happyReduction_69
happyReduction_69 ((HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then ActionPrefix (Variable "0") happy_var_1 happy_var_2 [("i0", TypeRange 1 1, (Variable "1"))] happy_var_4 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_70 = happyReduce 8 24 happyReduction_70
happyReduction_70 ((HappyAbsSyn24  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn35  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then ActionPrefix happy_var_6 (happy_var_1  ++ "{" ++ (printExpressions happy_var_4) ++ "}") happy_var_2 [("i0", TypeRange 1 1, (Variable "1"))] happy_var_8 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_71 = happyReduce 7 24 happyReduction_71
happyReduction_71 ((HappyAbsSyn24  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn35  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then ActionPrefix (Variable "0") (happy_var_1  ++ "{" ++ (printExpressions happy_var_4) ++ "}") happy_var_2 [("i0", TypeRange 1 1, (Variable "1"))] happy_var_7 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_72 = happyReduce 10 24 happyReduction_72
happyReduction_72 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_9) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then ActionPrefix happy_var_3 happy_var_1 happy_var_2 happy_var_7 happy_var_9 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_73 = happyReduce 9 24 happyReduction_73
happyReduction_73 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then ActionPrefix (Variable "0") happy_var_1 happy_var_2 happy_var_6 happy_var_8 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_74 = happyReduce 13 24 happyReduction_74
happyReduction_74 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_12) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_10) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn35  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then  ActionPrefix happy_var_6 (happy_var_1  ++ "{" ++ (printExpressions happy_var_4) ++ "}") happy_var_2 happy_var_10 happy_var_12 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_75 = happyReduce 12 24 happyReduction_75
happyReduction_75 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_11) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_9) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn35  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then  ActionPrefix (Variable "0") (happy_var_1  ++ "{" ++ (printExpressions happy_var_4) ++ "}") happy_var_2 happy_var_9 happy_var_11 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_76 = happyReduce 13 24 happyReduction_76
happyReduction_76 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_12) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn35  happy_var_10) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then  ActionPrefix happy_var_3 (happy_var_1  ++ "{" ++ (printExpressions happy_var_10) ++ "}") happy_var_2 happy_var_7 happy_var_12 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_77 = happyReduce 12 24 happyReduction_77
happyReduction_77 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_11) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn35  happy_var_9) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then  ActionPrefix (Variable "0") (happy_var_1  ++ "{" ++ (printExpressions happy_var_9) ++ "}") happy_var_2 happy_var_6 happy_var_11 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_78 = happyReduce 8 24 happyReduction_78
happyReduction_78 (_ `HappyStk`
	(HappyAbsSyn39  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then  ActionPrefix2 happy_var_3 happy_var_1 happy_var_2 happy_var_7 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_79 = happyReduce 7 24 happyReduction_79
happyReduction_79 (_ `HappyStk`
	(HappyAbsSyn39  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then  ActionPrefix2 (Variable "0") happy_var_1 happy_var_2 happy_var_6 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_80 = happyReduce 11 24 happyReduction_80
happyReduction_80 (_ `HappyStk`
	(HappyAbsSyn39  happy_var_10) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn35  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then  ActionPrefix2 happy_var_6 (happy_var_1  ++ "{" ++ (printExpressions happy_var_4) ++ "}") happy_var_2 happy_var_10 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_81 = happyReduce 10 24 happyReduction_81
happyReduction_81 (_ `HappyStk`
	(HappyAbsSyn39  happy_var_9) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn35  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (if (take 4 happy_var_1) /= "rate" then  ActionPrefix2 (Variable "0") (happy_var_1  ++ "{" ++ (printExpressions happy_var_4) ++ "}") happy_var_2 happy_var_9 else error("Error: you cannot use action names starting with 'rate'")
	) `HappyStk` happyRest

happyReduce_82 = happyReduce 8 24 happyReduction_82
happyReduction_82 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Sum happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_83 = happySpecReduce_3  24 happyReduction_83
happyReduction_83 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn24
		 (Implication happy_var_1 happy_var_3
	)
happyReduction_83 _ _ _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  24 happyReduction_84
happyReduction_84 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_3  24 happyReduction_85
happyReduction_85 _
	(HappyAbsSyn24  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (happy_var_2
	)
happyReduction_85 _ _ _  = notHappyAtAll 

happyReduce_86 = happyReduce 5 24 happyReduction_86
happyReduction_86 ((HappyAbsSyn24  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (LambdaPrefix (Variable "0") happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_87 = happyReduce 6 24 happyReduction_87
happyReduction_87 ((HappyAbsSyn24  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (LambdaPrefix happy_var_4 happy_var_2 happy_var_6
	) `HappyStk` happyRest

happyReduce_88 = happyReduce 4 25 happyReduction_88
happyReduction_88 (_ `HappyStk`
	(HappyAbsSyn37  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (ProcessInstance happy_var_1 (reverse happy_var_3)
	) `HappyStk` happyRest

happyReduce_89 = happyReduce 4 25 happyReduction_89
happyReduction_89 (_ `HappyStk`
	(HappyAbsSyn31  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (ProcessInstance2 happy_var_1 (reverse happy_var_3)
	) `HappyStk` happyRest

happyReduce_90 = happySpecReduce_3  25 happyReduction_90
happyReduction_90 _
	_
	(HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn25
		 (ProcessInstance2 happy_var_1 []
	)
happyReduction_90 _ _ _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_1  26 happyReduction_91
happyReduction_91 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn26
		 (TypeName happy_var_1
	)
happyReduction_91 _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_1  26 happyReduction_92
happyReduction_92 _
	 =  HappyAbsSyn26
		 (TypeName "Queue"
	)

happyReduce_93 = happySpecReduce_1  26 happyReduction_93
happyReduction_93 _
	 =  HappyAbsSyn26
		 (TypeName "Nat"
	)

happyReduce_94 = happyReduce 5 26 happyReduction_94
happyReduction_94 (_ `HappyStk`
	(HappyAbsSyn38  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (TypeRangeExpressions happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_95 = happySpecReduce_1  27 happyReduction_95
happyReduction_95 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn27
		 ([happy_var_1]
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_3  27 happyReduction_96
happyReduction_96 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_1 : happy_var_3
	)
happyReduction_96 _ _ _  = notHappyAtAll 

happyReduce_97 = happyReduce 5 28 happyReduction_97
happyReduction_97 ((HappyAbsSyn38  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 ((happy_var_1, happy_var_3, happy_var_5)
	) `HappyStk` happyRest

happyReduce_98 = happySpecReduce_1  29 happyReduction_98
happyReduction_98 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn29
		 ([happy_var_1]
	)
happyReduction_98 _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_3  29 happyReduction_99
happyReduction_99 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_3 : happy_var_1
	)
happyReduction_99 _ _ _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_3  30 happyReduction_100
happyReduction_100 (HappyAbsSyn26  happy_var_3)
	_
	(HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn30
		 ((happy_var_1, happy_var_3)
	)
happyReduction_100 _ _ _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_1  31 happyReduction_101
happyReduction_101 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 ([happy_var_1]
	)
happyReduction_101 _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_3  31 happyReduction_102
happyReduction_102 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn31
		 (happy_var_3 : happy_var_1
	)
happyReduction_102 _ _ _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_3  32 happyReduction_103
happyReduction_103 (HappyAbsSyn38  happy_var_3)
	_
	(HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn32
		 ((happy_var_1, happy_var_3)
	)
happyReduction_103 _ _ _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_1  33 happyReduction_104
happyReduction_104 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn33
		 ([happy_var_1]
	)
happyReduction_104 _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_3  33 happyReduction_105
happyReduction_105 (HappyAbsSyn34  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_3 : happy_var_1
	)
happyReduction_105 _ _ _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_3  34 happyReduction_106
happyReduction_106 (HappyTerminal (TokenString happy_var_3))
	_
	(HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn34
		 ((happy_var_1, happy_var_3)
	)
happyReduction_106 _ _ _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_1  35 happyReduction_107
happyReduction_107 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn35
		 ([happy_var_1]
	)
happyReduction_107 _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_3  35 happyReduction_108
happyReduction_108 (HappyAbsSyn36  happy_var_3)
	_
	(HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn35
		 (happy_var_3 : happy_var_1
	)
happyReduction_108 _ _ _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_3  36 happyReduction_109
happyReduction_109 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn36
		 ((happy_var_1, happy_var_3)
	)
happyReduction_109 _ _ _  = notHappyAtAll 

happyReduce_110 = happySpecReduce_1  37 happyReduction_110
happyReduction_110 (HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn37
		 ([happy_var_1]
	)
happyReduction_110 _  = notHappyAtAll 

happyReduce_111 = happySpecReduce_3  37 happyReduction_111
happyReduction_111 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn37  happy_var_1)
	 =  HappyAbsSyn37
		 (happy_var_3 : happy_var_1
	)
happyReduction_111 _ _ _  = notHappyAtAll 

happyReduce_112 = happySpecReduce_3  38 happyReduction_112
happyReduction_112 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "lt" [happy_var_1, happy_var_3]
	)
happyReduction_112 _ _ _  = notHappyAtAll 

happyReduce_113 = happySpecReduce_3  38 happyReduction_113
happyReduction_113 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "leq" [happy_var_1, happy_var_3]
	)
happyReduction_113 _ _ _  = notHappyAtAll 

happyReduce_114 = happySpecReduce_3  38 happyReduction_114
happyReduction_114 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "gt" [happy_var_1, happy_var_3]
	)
happyReduction_114 _ _ _  = notHappyAtAll 

happyReduce_115 = happySpecReduce_3  38 happyReduction_115
happyReduction_115 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "and" [happy_var_1, happy_var_3]
	)
happyReduction_115 _ _ _  = notHappyAtAll 

happyReduce_116 = happySpecReduce_3  38 happyReduction_116
happyReduction_116 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "or" [happy_var_1, happy_var_3]
	)
happyReduction_116 _ _ _  = notHappyAtAll 

happyReduce_117 = happySpecReduce_3  38 happyReduction_117
happyReduction_117 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "geq" [happy_var_1, happy_var_3]
	)
happyReduction_117 _ _ _  = notHappyAtAll 

happyReduce_118 = happySpecReduce_3  38 happyReduction_118
happyReduction_118 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "eq" [happy_var_1, happy_var_3]
	)
happyReduction_118 _ _ _  = notHappyAtAll 

happyReduce_119 = happySpecReduce_3  38 happyReduction_119
happyReduction_119 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "not" [Function "eq" [happy_var_1, happy_var_3]]
	)
happyReduction_119 _ _ _  = notHappyAtAll 

happyReduce_120 = happySpecReduce_2  38 happyReduction_120
happyReduction_120 (HappyAbsSyn38  happy_var_2)
	_
	 =  HappyAbsSyn38
		 (Function "not" [happy_var_2]
	)
happyReduction_120 _ _  = notHappyAtAll 

happyReduce_121 = happySpecReduce_3  38 happyReduction_121
happyReduction_121 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "plus" [happy_var_1, happy_var_3]
	)
happyReduction_121 _ _ _  = notHappyAtAll 

happyReduce_122 = happySpecReduce_3  38 happyReduction_122
happyReduction_122 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "power" [happy_var_1, happy_var_3]
	)
happyReduction_122 _ _ _  = notHappyAtAll 

happyReduce_123 = happySpecReduce_3  38 happyReduction_123
happyReduction_123 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "minus" [happy_var_1, happy_var_3]
	)
happyReduction_123 _ _ _  = notHappyAtAll 

happyReduce_124 = happySpecReduce_2  38 happyReduction_124
happyReduction_124 (HappyAbsSyn38  happy_var_2)
	_
	 =  HappyAbsSyn38
		 (Function "multiply" [Variable "-1", happy_var_2]
	)
happyReduction_124 _ _  = notHappyAtAll 

happyReduce_125 = happySpecReduce_3  38 happyReduction_125
happyReduction_125 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "multiply" [happy_var_1, happy_var_3]
	)
happyReduction_125 _ _ _  = notHappyAtAll 

happyReduce_126 = happySpecReduce_3  38 happyReduction_126
happyReduction_126 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (Function "divide" [happy_var_1, happy_var_3]
	)
happyReduction_126 _ _ _  = notHappyAtAll 

happyReduce_127 = happyReduce 4 38 happyReduction_127
happyReduction_127 (_ `HappyStk`
	(HappyAbsSyn37  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenString happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn38
		 (Function happy_var_1 (reverse happy_var_3)
	) `HappyStk` happyRest

happyReduce_128 = happySpecReduce_1  38 happyReduction_128
happyReduction_128 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn38
		 (Variable happy_var_1
	)
happyReduction_128 _  = notHappyAtAll 

happyReduce_129 = happySpecReduce_3  38 happyReduction_129
happyReduction_129 _
	(HappyAbsSyn38  happy_var_2)
	_
	 =  HappyAbsSyn38
		 (happy_var_2
	)
happyReduction_129 _ _ _  = notHappyAtAll 

happyReduce_130 = happySpecReduce_3  39 happyReduction_130
happyReduction_130 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn39
		 ([(happy_var_1, happy_var_3)]
	)
happyReduction_130 _ _ _  = notHappyAtAll 

happyReduce_131 = happyReduce 5 39 happyReduction_131
happyReduction_131 ((HappyAbsSyn39  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn24  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn39
		 ((happy_var_1, happy_var_3) : happy_var_5
	) `HappyStk` happyRest

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	TokenEOF -> action 94 94 tk (HappyState action) sts stk;
	TokenSum -> cont 40;
	TokenPSum -> cont 41;
	TokenComma -> cont 42;
	TokenSeq -> cont 43;
	TokenIndependence -> cont 44;
	TokenOSB -> cont 45;
	TokenCSB -> cont 46;
	TokenOB -> cont 47;
	TokenOr -> cont 48;
	TokenOA -> cont 49;
	TokenCA -> cont 50;
	TokenCB -> cont 51;
	TokenPlus -> cont 52;
	TokenPower -> cont 53;
	TokenPlusPlus -> cont 54;
	TokenAnd -> cont 55;
	TokenNot -> cont 56;
	TokenNotEqual -> cont 57;
	TokenMinus -> cont 58;
	TokenDivide -> cont 59;
	TokenMultiply -> cont 60;
	TokenColon -> cont 61;
	TokenBecomes -> cont 62;
	TokenSmaller -> cont 63;
	TokenGreater -> cont 64;
	TokenDotDot -> cont 65;
	TokenAt -> cont 66;
	TokenSmallerEq -> cont 67;
	TokenInit -> cont 68;
	TokenGreaterEq -> cont 69;
	TokenEqual -> cont 70;
	TokenImplies -> cont 71;
	TokenProbDef -> cont 72;
	TokenTrue -> cont 73;
	TokenFalse -> cont 74;
	TokenString happy_dollar_dollar -> cont 75;
	TokenHide -> cont 76;
	TokenRename -> cont 77;
	TokenBool -> cont 78;
	TokenActions -> cont 79;
	TokenEncap -> cont 80;
	TokenComm -> cont 81;
	TokenNoComm -> cont 82;
	TokenReach -> cont 83;
	TokenReachCondition -> cont 84;
	TokenStateReward -> cont 85;
	TokenConstant -> cont 86;
	TokenFormula -> cont 87;
	TokenGlobal -> cont 88;
	TokenUntilFormula -> cont 89;
	TokenType -> cont 90;
	TokenFunction -> cont 91;
	TokenNat -> cont 92;
	TokenQueue -> cont 93;
	_ -> happyError' tk
	})

happyError_ tk = happyError' tk

happyThen :: () => ParserMonad a -> (a -> ParserMonad b) -> ParserMonad b
happyThen = (thenParserMonad)
happyReturn :: () => a -> ParserMonad a
happyReturn = (returnParserMonad)
happyThen1 = happyThen
happyReturn1 :: () => a -> ParserMonad a
happyReturn1 = happyReturn
happyError' :: () => (Token) -> ParserMonad a
happyError' tk = parseError tk

parse = happySomeParser where
  happySomeParser = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: Token -> ParserMonad a 
parseError t = failParserMonad ("Error: Parser did not expect token \"" ++ show t ++ "\"")


data Token = TokenSum
           | TokenSeq  
           | TokenString String
           | TokenIndependence
           | TokenUntilFormula
           | TokenOB 
           | TokenCB 
           | TokenOSB 
           | TokenCSB 
           | TokenOA
           | TokenCA
           | TokenOr
           | TokenImplies
           | TokenColon
           | TokenBool
           | TokenPlus
           | TokenPower
           | TokenPlusPlus
           | TokenMinus
           | TokenDivide
           | TokenMultiply
           | TokenThen
           | TokenElse
           | TokenActions
           | TokenComma
           | TokenEqual
           | TokenNotEqual
           | TokenNot
           | TokenPSum
           | TokenDotDot
           | TokenAt
           | TokenHide
           | TokenTrue
           | TokenFalse
           | TokenRename
           | TokenEncap
           | TokenAnd
           | TokenComm
           | TokenNoComm
           | TokenReach
           | TokenReachCondition
           | TokenStateReward
           | TokenConstant
           | TokenFormula
           | TokenType
           | TokenGlobal
           | TokenFunction
           | TokenNat
           | TokenQueue
           | TokenInit
           | TokenSmaller
           | TokenGreater
           | TokenSmallerEq
           | TokenGreaterEq
           | TokenProbDef
           | TokenBecomes
           | TokenEOF
instance Show Token where
  show x =
   case x of 
     TokenSum -> "sum("
     TokenSeq -> "."
     TokenString s -> s
     TokenIndependence -> "||"
     TokenUntilFormula -> "U"
     TokenOB  -> "("
     TokenCB  -> ")"
     TokenOSB -> "["
     TokenCSB -> "]"
     TokenOA  -> "{"
     TokenCA  -> "}"
     TokenOr -> "|"
     TokenImplies -> "=>"
     TokenColon -> ":"
     TokenBool -> "Bool"
     TokenPlus -> "+"
     TokenPower -> "^"
     TokenPlusPlus -> "++"
     TokenMinus -> "-"
     TokenDivide -> "/"
     TokenMultiply -> "*"
     TokenThen -> "<|"
     TokenAt -> "@"
     TokenElse -> "|>"
     TokenActions -> "actions"
     TokenComma -> ","
     TokenEqual -> "="
     TokenTrue -> "true"
     TokenFalse -> "false"
     TokenNotEqual -> "!="
     TokenNot -> "!"
     TokenPSum -> "psum"
     TokenDotDot -> ".."
     TokenHide -> "hide"
     TokenGlobal -> "global"
     TokenEncap -> "encap"
     TokenAnd -> "&"
     TokenComm -> "comm"
     TokenNoComm -> "nocomm"
     TokenReach -> "reach"
     TokenReachCondition -> "reachCondition"
     TokenStateReward -> "stateReward"
     TokenConstant -> "constant"
     TokenFormula -> "formula"
     TokenType -> "type"
     TokenFunction -> "function"
     TokenQueue -> "Queue"
     TokenNat -> "Nat"
     TokenInit -> "init"
     TokenSmaller -> "<"
     TokenGreater -> ">"
     TokenSmallerEq -> "<="
     TokenGreaterEq -> ">="
     TokenProbDef -> "->"
     TokenBecomes -> ":="
     TokenEOF -> "EOF"

-- lexer :: String -> [Token] 
lexer :: (Token -> ParserMonad a) -> ParserMonad a
lexer cont ('\n':cs) = \line -> lexer cont cs (line + 1)
lexer cont ('\r':cs) = \line -> lexer cont cs line
lexer cont [] = cont TokenEOF [] 
lexer cont ('-':'-':cs) = lexComment cont (cs)
lexer cont ('.':'.':cs) = cont TokenDotDot cs
lexer cont ('i':'n':'i':'t':' ':cs) = cont TokenInit cs
lexer cont ('i':'n':'i':'t':'\n':cs) = cont TokenInit ('\n':cs)
lexer cont ('i':'n':'i':'t':'\r':cs) = cont TokenInit ('\r':cs)
lexer cont ('i':'n':'i':'t':'\t':cs) = cont TokenInit ('\t':cs)
lexer cont ('u':'n':'t':'i':'l':' ':cs) = cont TokenUntilFormula cs
lexer cont ('u':'n':'t':'i':'l':'\n':cs) = cont TokenUntilFormula ('\n':cs)
lexer cont ('u':'n':'t':'i':'l':'\r':cs) = cont TokenUntilFormula ('\r':cs)
lexer cont ('u':'n':'t':'i':'l':'\t':cs) = cont TokenUntilFormula ('\t':cs)
lexer cont ('b':'o':'o':'l':' ':cs) = cont TokenBool cs
lexer cont ('b':'o':'o':'l':'\n':cs) = cont TokenBool ('\n':cs)
lexer cont ('b':'o':'o':'l':'\r':cs) = cont TokenBool ('\r':cs)
lexer cont ('b':'o':'o':'l':'\t':cs) = cont TokenBool ('\t':cs)
lexer cont ('o':'b':'s':'e':'r':'v':'e':' ':cs) = cont TokenActions cs
lexer cont ('o':'b':'s':'e':'r':'v':'e':'\n':cs) = cont TokenActions ('\n':cs)
lexer cont ('o':'b':'s':'e':'r':'v':'e':'\r':cs) = cont TokenActions ('\r':cs)
lexer cont ('o':'b':'s':'e':'r':'v':'e':'\t':cs) = cont TokenActions ('\t':cs)
lexer cont ('h':'i':'d':'e':' ':cs) = cont TokenHide cs
lexer cont ('h':'i':'d':'e':'\n':cs) = cont TokenHide ('\n':cs)
lexer cont ('h':'i':'d':'e':'\r':cs) = cont TokenHide ('\r':cs)
lexer cont ('h':'i':'d':'e':'\t':cs) = cont TokenHide ('\t':cs)
lexer cont ('h':'i':'d':'e':'(':cs) = cont TokenHide ('(':cs)

lexer cont ('t':'r':'u':'e':' ':cs) = error ("Please use \"T\" instead of \"true\"")
lexer cont ('t':'r':'u':'e':'\n':cs) = error ("Please use \"T\" instead of \"true\"")
lexer cont ('t':'r':'u':'e':'\r':cs) = error ("Please use \"T\" instead of \"true\"")
lexer cont ('t':'r':'u':'e':'\t':cs) = error ("Please use \"T\" instead of \"true\"")
lexer cont ('t':'r':'u':'e':'(':cs) = error ("Please use \"T\" instead of \"true\"")

lexer cont ('f':'a':'l':'s':'e':' ':cs) = error ("Please use \"F\" instead of \"false\"")
lexer cont ('f':'a':'l':'s':'e':'\n':cs) = error ("Please use \"F\" instead of \"false\"")
lexer cont ('f':'a':'l':'s':'e':'\r':cs) = error ("Please use \"F\" instead of \"false\"")
lexer cont ('f':'a':'l':'s':'e':'\t':cs) = error ("Please use \"F\" instead of \"false\"")
lexer cont ('f':'a':'l':'s':'e':'(':cs) = error ("Please use \"F\" instead of \"false\"")


lexer cont ('g':'l':'o':'b':'a':'l':' ':cs) = cont TokenGlobal cs
lexer cont ('g':'l':'o':'b':'a':'l':'\n':cs) = cont TokenGlobal ('\n':cs)
lexer cont ('g':'l':'o':'b':'a':'l':'\r':cs) = cont TokenGlobal ('\r':cs)
lexer cont ('g':'l':'o':'b':'a':'l':'\t':cs) = cont TokenGlobal ('\t':cs)
lexer cont ('g':'l':'o':'b':'a':'l':'(':cs) = cont TokenGlobal ('(':cs)

lexer cont ('s':'u':'m':cs) | not (isAlpha (head cs)) = cont TokenSum cs
lexer cont ('p':'s':'u':'m':cs) | not (isAlpha (head cs)) = cont TokenPSum cs
lexer cont ('c':'o':'n':'s':'t':'a':'n':'t':' ':cs) = cont TokenConstant cs
lexer cont ('c':'o':'n':'s':'t':'a':'n':'t':'\n':cs) = cont TokenConstant ('\n':cs)
lexer cont ('c':'o':'n':'s':'t':'a':'n':'t':'\r':cs) = cont TokenConstant ('\r':cs)
lexer cont ('c':'o':'n':'s':'t':'a':'n':'t':'\t':cs) = cont TokenConstant ('\t':cs)
lexer cont ('f':'o':'r':'m':'u':'l':'a':' ':cs) = cont TokenFormula cs
lexer cont ('f':'o':'r':'m':'u':'l':'a':'\n':cs) = cont TokenFormula ('\n':cs)
lexer cont ('f':'o':'r':'m':'u':'l':'a':'\r':cs) = cont TokenFormula ('\r':cs)
lexer cont ('f':'o':'r':'m':'u':'l':'a':'\t':cs) = cont TokenFormula ('\t':cs)
lexer cont ('t':'y':'p':'e':' ':cs) = cont TokenType cs
lexer cont ('t':'y':'p':'e':'\n':cs) = cont TokenType ('\n':cs)
lexer cont ('t':'y':'p':'e':'\r':cs) = cont TokenType ('\r':cs)
lexer cont ('t':'y':'p':'e':'\t':cs) = cont TokenType ('\t':cs)
lexer cont ('f':'u':'n':'c':'t':'i':'o':'n':' ':cs) = cont TokenFunction cs
lexer cont ('f':'u':'n':'c':'t':'i':'o':'n':'\n':cs) = cont TokenFunction ('\n':cs)
lexer cont ('f':'u':'n':'c':'t':'i':'o':'n':'\r':cs) = cont TokenFunction ('\r':cs)
lexer cont ('f':'u':'n':'c':'t':'i':'o':'n':'\t':cs) = cont TokenFunction ('\t':cs)

lexer cont ('Q':'u':'e':'u':'e':' ':cs) = cont TokenQueue cs
lexer cont ('Q':'u':'e':'u':'e':'\n':cs) = cont TokenQueue ('\n':cs)
lexer cont ('Q':'u':'e':'u':'e':'\r':cs) = cont TokenQueue ('\r':cs)
lexer cont ('Q':'u':'e':'u':'e':'\t':cs) = cont TokenQueue ('\t':cs)

lexer cont ('N':'a':'t':' ':cs) = cont TokenNat cs
lexer cont ('N':'a':'t':'\n':cs) = cont TokenNat ('\n':cs)
lexer cont ('N':'a':'t':'\r':cs) = cont TokenNat ('\r':cs)
lexer cont ('N':'a':'t':'\t':cs) = cont TokenNat ('\t':cs)


lexer cont ('e':'n':'c':'a':'p':' ':cs) = cont TokenEncap cs
lexer cont ('e':'n':'c':'a':'p':'\n':cs) = cont TokenEncap ('\n':cs)
lexer cont ('e':'n':'c':'a':'p':'\r':cs) = cont TokenEncap ('\r':cs)
lexer cont ('e':'n':'c':'a':'p':'\t':cs) = cont TokenEncap ('\t':cs)
lexer cont ('e':'n':'c':'a':'p':'(':cs) = cont TokenEncap ('(':cs)
lexer cont ('r':'e':'n':'a':'m':'e':' ':cs) = cont TokenRename cs
lexer cont ('r':'e':'n':'a':'m':'e':'\n':cs) = cont TokenRename ('\n':cs)
lexer cont ('r':'e':'n':'a':'m':'e':'\r':cs) = cont TokenRename ('\r':cs)
lexer cont ('r':'e':'n':'a':'m':'e':'\t':cs) = cont TokenRename ('\t':cs)
lexer cont ('r':'e':'n':'a':'m':'e':'(':cs) = cont TokenRename ('(':cs)
lexer cont ('n':'o':'c':'o':'m':'m':' ':cs) = cont TokenNoComm cs
lexer cont ('n':'o':'c':'o':'m':'m':'\n':cs) = cont TokenNoComm ('\n':cs)
lexer cont ('n':'o':'c':'o':'m':'m':'\r':cs) = cont TokenNoComm ('\r':cs)
lexer cont ('n':'o':'c':'o':'m':'m':'\t':cs) = cont TokenNoComm ('\t':cs)
lexer cont ('r':'e':'a':'c':'h':' ':cs) = cont TokenReach cs
lexer cont ('r':'e':'a':'c':'h':'\n':cs) = cont TokenReach ('\n':cs)
lexer cont ('r':'e':'a':'c':'h':'\r':cs) = cont TokenReach ('\r':cs)
lexer cont ('r':'e':'a':'c':'h':'\t':cs) = cont TokenReach ('\t':cs)
lexer cont ('r':'e':'a':'c':'h':'C':'o':'n':'d':'i':'t':'i':'o':'n':' ':cs) = cont TokenReachCondition cs
lexer cont ('r':'e':'a':'c':'h':'C':'o':'n':'d':'i':'t':'i':'o':'n':'\n':cs) = cont TokenReachCondition ('\n':cs)
lexer cont ('r':'e':'a':'c':'h':'C':'o':'n':'d':'i':'t':'i':'o':'n':'\r':cs) = cont TokenReachCondition ('\r':cs)
lexer cont ('r':'e':'a':'c':'h':'C':'o':'n':'d':'i':'t':'i':'o':'n':' ':cs) = cont TokenReachCondition cs
lexer cont ('s':'t':'a':'t':'e':'R':'e':'w':'a':'r':'d':' ':cs) = cont TokenStateReward cs
lexer cont ('s':'t':'a':'t':'e':'R':'e':'w':'a':'r':'d':'\n':cs) = cont TokenStateReward ('\n':cs)
lexer cont ('s':'t':'a':'t':'e':'R':'e':'w':'a':'r':'d':'\r':cs) = cont TokenStateReward ('\r':cs)
lexer cont ('s':'t':'a':'t':'e':'R':'e':'w':'a':'r':'d':' ':cs) = cont TokenStateReward cs
lexer cont ('c':'o':'m':'m':' ':cs) = cont TokenComm cs
lexer cont ('c':'o':'m':'m':'\n':cs) = cont TokenComm ('\n':cs)
lexer cont ('c':'o':'m':'m':'\r':cs) = cont TokenComm ('\r':cs)
lexer cont ('c':'o':'m':'m':'\t':cs) = cont TokenComm ('\t':cs)
lexer cont (c:cs) 
      | isSpace c = lexer cont cs 
      | (\x -> isDigit x) c = lexNumber cont (c:cs)
      | (\x -> isAlpha x) c = lexString cont (c:cs)
lexer cont ('.':cs) = cont TokenSeq cs 
lexer cont ('|':'|':cs) = cont TokenIndependence cs
lexer cont ('|':'>':cs) = cont TokenElse cs 
lexer cont ('<':'|':cs) = cont TokenThen cs 
lexer cont ('&':cs) = cont TokenAnd cs 
lexer cont ('<':'=':cs) = cont TokenSmallerEq cs 
lexer cont ('>':'=':cs) = cont TokenGreaterEq cs 
lexer cont ('<':cs) = cont TokenSmaller cs 
lexer cont ('>':cs) = cont TokenGreater cs 
lexer cont ('(':cs) = cont TokenOB cs 
lexer cont ('|':cs) = cont TokenOr cs 
lexer cont (')':cs) = cont TokenCB cs 
lexer cont ('[':cs) = cont TokenOSB cs 
lexer cont (']':cs) = cont TokenCSB cs 
lexer cont ('{':cs) = cont TokenOA cs 
lexer cont ('}':cs) = cont TokenCA cs 
lexer cont ('+':'+':cs) = cont TokenPlusPlus cs
lexer cont ('-':'>':cs) = cont TokenProbDef cs
lexer cont (',':cs) = cont TokenComma cs
lexer cont ('+':cs) = cont TokenPlus cs
lexer cont ('^':cs) = cont TokenPower cs
lexer cont ('@':cs) = cont TokenAt cs
lexer cont ('-':cs) = cont TokenMinus cs
lexer cont ('!':'=':cs) = cont TokenNotEqual cs
lexer cont ('!':cs) = cont TokenNot cs
lexer cont ('/':cs) = cont TokenDivide cs
lexer cont ('*':cs) = cont TokenMultiply cs
lexer cont (':':'=':cs) = cont TokenBecomes cs
lexer cont (':':cs) = cont TokenColon cs
lexer cont ('=':'>':cs) = cont TokenImplies cs
lexer cont ('=':cs) = cont TokenEqual cs
lexer cont s = \line -> error("Error: Lexer could not deal with character \"" ++ [head s] ++ "\" on line " ++ show line)

lexComment cont cs = lexer cont rest
  where
    rest = dropWhile (\x -> x /= '\n' && x /= '\r') cs
lexString cont cs = cont (TokenString var) rest
  where
    (var,rest) = getString cs
lexNumber cont cs = cont (TokenString var) rest
  where
    (var,rest) = getNumber cs

getString [] = ("","")
getString ('.':'.':cs) = ("", '.':'.':cs)
getString (c:cs) | elem c "\n\t\r ',()&=*.<>@+{}^:-/|\"[]" = ("", c:cs)
                 | otherwise = (str,rest)
  where
    (s,r) = getString cs
    str   = c:s
    rest  = r

getNumber [] = ("","")
getNumber ('.':'.':cs) = ("", '.':'.':cs)
getNumber (c:cs) | elem c "\n\t\r ',()&=*<>+_@{}:^-!?/|\"[]" = ("", c:cs)
                 | otherwise = (str,rest)
  where
    (s,r) = getNumber cs
    str   = c:s
    rest  = r
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 30 "templates/GenericTemplate.hs" #-}








{-# LINE 51 "templates/GenericTemplate.hs" #-}

{-# LINE 61 "templates/GenericTemplate.hs" #-}

{-# LINE 70 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	 (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 148 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let (i) = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where (sts1@(((st1@(HappyState (action))):(_)))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
       happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))
       where (sts1@(((st1@(HappyState (action))):(_)))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk





             new_state = action


happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 246 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail  (1) tk old_st _ stk =
--	trace "failing" $ 
    	happyError_ tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 311 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
