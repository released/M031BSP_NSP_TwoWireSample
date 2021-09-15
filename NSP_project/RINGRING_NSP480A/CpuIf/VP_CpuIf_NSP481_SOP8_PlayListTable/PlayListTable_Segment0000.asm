	_@PLAYLISTTABLE_SEGMENTINT00: SECTION
_@PLAYLISTTABLE_SEGMENTINT00_label:
	.PUBLIC _@STARTADDR_PLAYLIST_TABLE

_@STARTADDR_PLAYLIST_TABLE:
_@PROJECT_ID:
	DB 00H ; 1 --> _@PROJECT_ID:
	DB 00H ; 2 --> _@PROJECT_ID:
	DB 00H ; 3 --> _@PROJECT_ID:
	DB 00H ; 4 --> _@PROJECT_ID:
_@CHIP_PDID:
	DB 89H ; 5 --> _@CHIP_PDID:
	DB 54H ; 6 --> _@CHIP_PDID:
	DB 81H ; 7 --> _@CHIP_PDID:
	DB 7FH ; 8 --> _@CHIP_PDID:
_@INDEXTABLE:
	DB 07H ; 9 --> _@INDEXTABLE:IndexTableCount(Low)
	DB 00H ; 10 --> _@INDEXTABLE:IndexTableCount(Hign)
	DB 00H ; 11 --> _@INDEXTABLE:Redundant byte
	DB 00H ; 12 --> _@INDEXTABLE:Redundant byte
	DB 2CH ; 13 --> _@TABLE_PLAYLIST1:
	DB 00H ; 14 --> _@TABLE_PLAYLIST1:
	DB 00H ; 15 --> _@TABLE_PLAYLIST1:
	DB 00H ; 16 --> _@TABLE_PLAYLIST1:
	DB 34H ; 17 --> _@TABLE_PLAYLIST2:
	DB 00H ; 18 --> _@TABLE_PLAYLIST2:
	DB 00H ; 19 --> _@TABLE_PLAYLIST2:
	DB 00H ; 20 --> _@TABLE_PLAYLIST2:
	DB 3CH ; 21 --> _@TABLE_PLAYLIST3:
	DB 00H ; 22 --> _@TABLE_PLAYLIST3:
	DB 00H ; 23 --> _@TABLE_PLAYLIST3:
	DB 00H ; 24 --> _@TABLE_PLAYLIST3:
	DB 44H ; 25 --> _@TABLE_PLAYLIST4:
	DB 00H ; 26 --> _@TABLE_PLAYLIST4:
	DB 00H ; 27 --> _@TABLE_PLAYLIST4:
	DB 00H ; 28 --> _@TABLE_PLAYLIST4:
	DB 4CH ; 29 --> _@TABLE_PLAYLIST5:
	DB 00H ; 30 --> _@TABLE_PLAYLIST5:
	DB 00H ; 31 --> _@TABLE_PLAYLIST5:
	DB 00H ; 32 --> _@TABLE_PLAYLIST5:
	DB 54H ; 33 --> _@TABLE_PLAYLIST6:
	DB 00H ; 34 --> _@TABLE_PLAYLIST6:
	DB 00H ; 35 --> _@TABLE_PLAYLIST6:
	DB 00H ; 36 --> _@TABLE_PLAYLIST6:
	DB 5CH ; 37 --> _@TABLE_PLAYLIST7:
	DB 00H ; 38 --> _@TABLE_PLAYLIST7:
	DB 00H ; 39 --> _@TABLE_PLAYLIST7:
	DB 00H ; 40 --> _@TABLE_PLAYLIST7:
_@TABLE_PLAYLIST_EMPTY:
	DB 00H ; 41 --> _@TABLE_PLAYLIST_EMPTY:ResCount
	DB 00H ; 42 --> _@TABLE_PLAYLIST_EMPTY:ResCount
	DB 00H ; 43 --> _@TABLE_PLAYLIST_EMPTY:ResCount
	DB 00H ; 44 --> _@TABLE_PLAYLIST_EMPTY:ResCount
_@TABLE_PLAYLIST1:
	DB 01H ; 45 --> _@TABLE_PLAYLIST1:ResCount
	DB 00H ; 46 --> _@TABLE_PLAYLIST1:ResCount
	DB 00H ; 47 --> _@TABLE_PLAYLIST1:ResCount
	DB 00H ; 48 --> _@TABLE_PLAYLIST1:ResCount
	DB .LOW._ALIAS_EQU_1_128_16000_1 ; 49
	DB .HIGH._ALIAS_EQU_1_128_16000_1 ; 50
	DB .HIGH8._ALIAS_EQU_1_128_16000_1 ; 51
	DB 00H ; 52 --> _ALIAS_EQU_1_128_16000_1:Silence
_@TABLE_PLAYLIST2:
	DB 01H ; 53 --> _@TABLE_PLAYLIST2:ResCount
	DB 00H ; 54 --> _@TABLE_PLAYLIST2:ResCount
	DB 00H ; 55 --> _@TABLE_PLAYLIST2:ResCount
	DB 00H ; 56 --> _@TABLE_PLAYLIST2:ResCount
	DB .LOW._ALIAS_EQU_1_128_16000_2 ; 57
	DB .HIGH._ALIAS_EQU_1_128_16000_2 ; 58
	DB .HIGH8._ALIAS_EQU_1_128_16000_2 ; 59
	DB 00H ; 60 --> _ALIAS_EQU_1_128_16000_2:Silence
_@TABLE_PLAYLIST3:
	DB 01H ; 61 --> _@TABLE_PLAYLIST3:ResCount
	DB 00H ; 62 --> _@TABLE_PLAYLIST3:ResCount
	DB 00H ; 63 --> _@TABLE_PLAYLIST3:ResCount
	DB 00H ; 64 --> _@TABLE_PLAYLIST3:ResCount
	DB .LOW._ALIAS_EQU_1_128_16000_3 ; 65
	DB .HIGH._ALIAS_EQU_1_128_16000_3 ; 66
	DB .HIGH8._ALIAS_EQU_1_128_16000_3 ; 67
	DB 00H ; 68 --> _ALIAS_EQU_1_128_16000_3:Silence
_@TABLE_PLAYLIST4:
	DB 01H ; 69 --> _@TABLE_PLAYLIST4:ResCount
	DB 00H ; 70 --> _@TABLE_PLAYLIST4:ResCount
	DB 00H ; 71 --> _@TABLE_PLAYLIST4:ResCount
	DB 00H ; 72 --> _@TABLE_PLAYLIST4:ResCount
	DB .LOW._ALIAS_EQU_1_128_16000_4 ; 73
	DB .HIGH._ALIAS_EQU_1_128_16000_4 ; 74
	DB .HIGH8._ALIAS_EQU_1_128_16000_4 ; 75
	DB 00H ; 76 --> _ALIAS_EQU_1_128_16000_4:Silence
_@TABLE_PLAYLIST5:
	DB 01H ; 77 --> _@TABLE_PLAYLIST5:ResCount
	DB 00H ; 78 --> _@TABLE_PLAYLIST5:ResCount
	DB 00H ; 79 --> _@TABLE_PLAYLIST5:ResCount
	DB 00H ; 80 --> _@TABLE_PLAYLIST5:ResCount
	DB .LOW._ALIAS_EQU_1_128_16000_5 ; 81
	DB .HIGH._ALIAS_EQU_1_128_16000_5 ; 82
	DB .HIGH8._ALIAS_EQU_1_128_16000_5 ; 83
	DB 00H ; 84 --> _ALIAS_EQU_1_128_16000_5:Silence
_@TABLE_PLAYLIST6:
	DB 01H ; 85 --> _@TABLE_PLAYLIST6:ResCount
	DB 00H ; 86 --> _@TABLE_PLAYLIST6:ResCount
	DB 00H ; 87 --> _@TABLE_PLAYLIST6:ResCount
	DB 00H ; 88 --> _@TABLE_PLAYLIST6:ResCount
	DB .LOW._ALIAS_EQU_1_128_16000_RESCRC2808FB41_151549 ; 89
	DB .HIGH._ALIAS_EQU_1_128_16000_RESCRC2808FB41_151549 ; 90
	DB .HIGH8._ALIAS_EQU_1_128_16000_RESCRC2808FB41_151549 ; 91
	DB 00H ; 92 --> _ALIAS_EQU_1_128_16000_RESCRC2808FB41_151549:Silence
_@TABLE_PLAYLIST7:
	DB 01H ; 93 --> _@TABLE_PLAYLIST7:ResCount
	DB 00H ; 94 --> _@TABLE_PLAYLIST7:ResCount
	DB 00H ; 95 --> _@TABLE_PLAYLIST7:ResCount
	DB 00H ; 96 --> _@TABLE_PLAYLIST7:ResCount
	DB .LOW._ALIAS_EQU_1_128_16000_RESCRC8E3945CE_110353 ; 97
	DB .HIGH._ALIAS_EQU_1_128_16000_RESCRC8E3945CE_110353 ; 98
	DB .HIGH8._ALIAS_EQU_1_128_16000_RESCRC8E3945CE_110353 ; 99
	DB 00H ; 100 --> _ALIAS_EQU_1_128_16000_RESCRC8E3945CE_110353:Silence
	ENDS
	EXTERN _ALIAS_EQU_1_128_16000_1
	EXTERN _ALIAS_EQU_1_128_16000_2
	EXTERN _ALIAS_EQU_1_128_16000_3
	EXTERN _ALIAS_EQU_1_128_16000_4
	EXTERN _ALIAS_EQU_1_128_16000_5
	EXTERN _ALIAS_EQU_1_128_16000_RESCRC2808FB41_151549
	EXTERN _ALIAS_EQU_1_128_16000_RESCRC8E3945CE_110353
