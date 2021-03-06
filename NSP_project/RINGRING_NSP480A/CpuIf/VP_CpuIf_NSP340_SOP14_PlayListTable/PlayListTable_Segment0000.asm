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
	DB 53H ; 6 --> _@CHIP_PDID:
	DB 40H ; 7 --> _@CHIP_PDID:
	DB 5FH ; 8 --> _@CHIP_PDID:
_@INDEXTABLE:
	DB 05H ; 9 --> _@INDEXTABLE:IndexTableCount(Low)
	DB 00H ; 10 --> _@INDEXTABLE:IndexTableCount(Hign)
	DB 00H ; 11 --> _@INDEXTABLE:Redundant byte
	DB 00H ; 12 --> _@INDEXTABLE:Redundant byte
	DB 24H ; 13 --> _@TABLE_PLAYLIST1:
	DB 00H ; 14 --> _@TABLE_PLAYLIST1:
	DB 00H ; 15 --> _@TABLE_PLAYLIST1:
	DB 00H ; 16 --> _@TABLE_PLAYLIST1:
	DB 2CH ; 17 --> _@TABLE_PLAYLIST2:
	DB 00H ; 18 --> _@TABLE_PLAYLIST2:
	DB 00H ; 19 --> _@TABLE_PLAYLIST2:
	DB 00H ; 20 --> _@TABLE_PLAYLIST2:
	DB 34H ; 21 --> _@TABLE_PLAYLIST3:
	DB 00H ; 22 --> _@TABLE_PLAYLIST3:
	DB 00H ; 23 --> _@TABLE_PLAYLIST3:
	DB 00H ; 24 --> _@TABLE_PLAYLIST3:
	DB 3CH ; 25 --> _@TABLE_PLAYLIST4:
	DB 00H ; 26 --> _@TABLE_PLAYLIST4:
	DB 00H ; 27 --> _@TABLE_PLAYLIST4:
	DB 00H ; 28 --> _@TABLE_PLAYLIST4:
	DB 44H ; 29 --> _@TABLE_PLAYLIST5:
	DB 00H ; 30 --> _@TABLE_PLAYLIST5:
	DB 00H ; 31 --> _@TABLE_PLAYLIST5:
	DB 00H ; 32 --> _@TABLE_PLAYLIST5:
_@TABLE_PLAYLIST_EMPTY:
	DB 00H ; 33 --> _@TABLE_PLAYLIST_EMPTY:ResCount
	DB 00H ; 34 --> _@TABLE_PLAYLIST_EMPTY:ResCount
	DB 00H ; 35 --> _@TABLE_PLAYLIST_EMPTY:ResCount
	DB 00H ; 36 --> _@TABLE_PLAYLIST_EMPTY:ResCount
_@TABLE_PLAYLIST1:
	DB 01H ; 37 --> _@TABLE_PLAYLIST1:ResCount
	DB 00H ; 38 --> _@TABLE_PLAYLIST1:ResCount
	DB 00H ; 39 --> _@TABLE_PLAYLIST1:ResCount
	DB 00H ; 40 --> _@TABLE_PLAYLIST1:ResCount
	DB .LOW._ALIAS_EQU_1_128_16000_1 ; 41
	DB .HIGH._ALIAS_EQU_1_128_16000_1 ; 42
	DB .HIGH8._ALIAS_EQU_1_128_16000_1 ; 43
	DB 00H ; 44 --> _ALIAS_EQU_1_128_16000_1:Silence
_@TABLE_PLAYLIST2:
	DB 01H ; 45 --> _@TABLE_PLAYLIST2:ResCount
	DB 00H ; 46 --> _@TABLE_PLAYLIST2:ResCount
	DB 00H ; 47 --> _@TABLE_PLAYLIST2:ResCount
	DB 00H ; 48 --> _@TABLE_PLAYLIST2:ResCount
	DB .LOW._ALIAS_EQU_1_128_16000_2 ; 49
	DB .HIGH._ALIAS_EQU_1_128_16000_2 ; 50
	DB .HIGH8._ALIAS_EQU_1_128_16000_2 ; 51
	DB 00H ; 52 --> _ALIAS_EQU_1_128_16000_2:Silence
_@TABLE_PLAYLIST3:
	DB 01H ; 53 --> _@TABLE_PLAYLIST3:ResCount
	DB 00H ; 54 --> _@TABLE_PLAYLIST3:ResCount
	DB 00H ; 55 --> _@TABLE_PLAYLIST3:ResCount
	DB 00H ; 56 --> _@TABLE_PLAYLIST3:ResCount
	DB .LOW._ALIAS_EQU_1_128_16000_3 ; 57
	DB .HIGH._ALIAS_EQU_1_128_16000_3 ; 58
	DB .HIGH8._ALIAS_EQU_1_128_16000_3 ; 59
	DB 00H ; 60 --> _ALIAS_EQU_1_128_16000_3:Silence
_@TABLE_PLAYLIST4:
	DB 01H ; 61 --> _@TABLE_PLAYLIST4:ResCount
	DB 00H ; 62 --> _@TABLE_PLAYLIST4:ResCount
	DB 00H ; 63 --> _@TABLE_PLAYLIST4:ResCount
	DB 00H ; 64 --> _@TABLE_PLAYLIST4:ResCount
	DB .LOW._ALIAS_EQU_1_128_16000_4 ; 65
	DB .HIGH._ALIAS_EQU_1_128_16000_4 ; 66
	DB .HIGH8._ALIAS_EQU_1_128_16000_4 ; 67
	DB 00H ; 68 --> _ALIAS_EQU_1_128_16000_4:Silence
_@TABLE_PLAYLIST5:
	DB 01H ; 69 --> _@TABLE_PLAYLIST5:ResCount
	DB 00H ; 70 --> _@TABLE_PLAYLIST5:ResCount
	DB 00H ; 71 --> _@TABLE_PLAYLIST5:ResCount
	DB 00H ; 72 --> _@TABLE_PLAYLIST5:ResCount
	DB .LOW._ALIAS_EQU_1_128_16000_5 ; 73
	DB .HIGH._ALIAS_EQU_1_128_16000_5 ; 74
	DB .HIGH8._ALIAS_EQU_1_128_16000_5 ; 75
	DB 00H ; 76 --> _ALIAS_EQU_1_128_16000_5:Silence
	ENDS
	EXTERN _ALIAS_EQU_1_128_16000_1
	EXTERN _ALIAS_EQU_1_128_16000_2
	EXTERN _ALIAS_EQU_1_128_16000_3
	EXTERN _ALIAS_EQU_1_128_16000_4
	EXTERN _ALIAS_EQU_1_128_16000_5
