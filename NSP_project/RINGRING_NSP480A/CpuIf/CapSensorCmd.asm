	CHIP		N589

	INCLUDE		PGM_HEAD.INI
	

;==========================================================================
; CapSensorCmd Used RAM
;==========================================================================
	USER_RAM: SECTION


	ENDS

;============================================;
; CAP SENSOR KEYS LABLE LIST
;============================================;
	CODE:	SECTION

	PUBLIC     CAPKEY1T
	PUBLIC     CAPKEY2T
	PUBLIC     CAPKEY3T
	PUBLIC     CAPKEY4T
	PUBLIC     CAPKEY5T
	PUBLIC     CAPKEY6T
	PUBLIC     CAPKEY7T
	PUBLIC     CAPKEY8T
	
	PUBLIC     CAPKEY1U
	PUBLIC     CAPKEY2U
	PUBLIC     CAPKEY3U
	PUBLIC     CAPKEY4U
	PUBLIC     CAPKEY5U
	PUBLIC     CAPKEY6U
	PUBLIC     CAPKEY7U
	PUBLIC     CAPKEY8U
	
;----------------------------------------
; Cap Sensor Key be Touched label
;----------------------------------------
CAPKEY1T:
CAPKEY2T:
CAPKEY3T:
CAPKEY4T:
CAPKEY5T:
CAPKEY6T:
CAPKEY7T:
CAPKEY8T:

    RTS


;----------------------------------------
; Cap Sensor Key be un-Touched label
;----------------------------------------
CAPKEY1U: 
CAPKEY2U:
CAPKEY3U:
CAPKEY4U:
CAPKEY5U:
CAPKEY6U:
CAPKEY7U:
CAPKEY8U:

    RTS

	ENDS
