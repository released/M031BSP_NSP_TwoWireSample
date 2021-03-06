	CHIP		N589
	SYMBOLS
	LINEAR		ON

	;*.LIC
	INCLUDE		SYS_DEF_EQU.INI

	INCLUDE		CONFIGURATION_PUBLIC.INI	;generated by WIDE according to user configuration
	INCLUDE		CONFIGURATION.INI			;generated by WIDE according to user configuration
	INCLUDE 	RAMVAR_PUBLIC.INI			;generated by WIDE according to configuration.ini
	INCLUDE 	RAMVAR.INI					;generated by WIDE according to configuration.ini

	INCLUDE		SynthConstant_PUBLIC.INI
	INCLUDE		SynthConstant.INI  
	
	INCLUDE		MACROS.INI
	;INCLUDE	SYNTH_MACROS.INI
	INCLUDE		HWE_DEFINE.INI
	INCLUDE		FLASH_MACROS.INI
;==========================================================================
;	LIBRARY RAM USED SECTION
;==========================================================================
	LIBRARY_USED_RAM: SECTION
	ORG 0000H
LIBRARY_RAM DS USER_START
	.ENDS
	
	STACK_RAM: SECTION
STACK_USED_RAM DS WITH_STACK_SIZE
HWENGINE_USED_SHARED_RAM DS WITH_HWENGINE_SHARED_RAM_SIZE
	.ENDS

	LIBRARY_USED_DPD_RAM: SECTION
LIBRARY_USED_DPD_RAM DS DPD_USER_START-F00H
  	.ENDS

	LIBRARY_CODE: SECTION
	ORG	0000H

	LONGA OFF
	LONGI OFF
	
;==============================================================================
;==========================================================
;add by angela 2006.03.23 for DIS/EN CLOBALVOL feature
	.IF (WITH_SP .EQ. 1)
	.IF (WITH_VOL_ADJ .EQ. 1)	
	PUBLIC SP_GLOBAL_VOLUME_TABLE
SP_GLOBAL_VOLUME_TABLE:	
			DB GLOBAL_VOL_SP0
			DB GLOBAL_VOL_SP1
			DB GLOBAL_VOL_SP2
	.ENDIF
	.ENDIF
;-------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------
	.PUBLIC SP_BUSY_GLOBAL_PLAY_TABLE
SP_BUSY_GLOBAL_PLAY_TABLE:
.IF(WITH_SP .EQ. 1)
	DB SP1_BZ
	DB SP2_BZ
	DB SP3_BZ
.ENDIF				
;==========================================================
	.PUBLIC EVO_BUSY_GLOBAL_PLAY_TABLE
EVO_BUSY_GLOBAL_PLAY_TABLE:
.IF(WITH_EVO .EQ. 1)
	DB EVO1_BZ
	DB EVO2_BZ
	DB EVO3_BZ
.ENDIF
;-------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------	
	PUBLIC DIS_UIO_EVENT_FLAG  ;COMMON_FLAG2: en/dis UIO event for speech channel
DIS_UIO_EVENT_FLAG:
	DB DIS_UIO_EVENT_FLAG_CH0
	DB DIS_UIO_EVENT_FLAG_CH1
	DB DIS_UIO_EVENT_FLAG_CH2
;-------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------	
	PUBLIC PLAY_BACK_FLAG_TABLE  ;COMMON_FLAG2: en/dis UIO event for speech channel
PLAY_BACK_FLAG_TABLE:
	DB PLAY_BACK_CH0
	DB PLAY_BACK_CH1
	DB PLAY_BACK_CH2
;-------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------	
	;PUBLIC SPEECH_PLAY_SEGMENT_RAM_TABLE
;SPEECH_PLAY_SEGMENT_RAM_TABLE:
;.IF (WITH_SP_SKIP .EQ. 1)
	;DB CH1_PLAY_SEGMENT-CH1_PLAY_SEGMENT
	;DB CH2_PLAY_SEGMENT-CH1_PLAY_SEGMENT
	;DB CH3_PLAY_SEGMENT-CH1_PLAY_SEGMENT
;.ENDIF
;-------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------	
	;PUBLIC SPEECH_GLOBAL_SR_TMC_TABLE
;SPEECH_GLOBAL_SR_TMC_TABLE:
;.IF (WITH_SP_GLOBAL_SR .EQ. 1)
	;DB CH1_GLOBAL_TMC-CH1_GLOBAL_TMC
	;DB CH2_GLOBAL_TMC-CH1_GLOBAL_TMC
	;DB CH3_GLOBAL_TMC-CH1_GLOBAL_TMC
;.ENDIF
;==========================================================
;	PUBLIC SPEECH_GLOBAL_SR_TMV_TABLE
;SPEECH_GLOBAL_SR_TMV_TABLE:
;.IF (WITH_SP_GLOBAL_SR .EQ. 1)
;	DB CH1_GLOBAL_TMV-CH1_GLOBAL_TMV
;	DB CH2_GLOBAL_TMV-CH1_GLOBAL_TMV
;	DB CH3_GLOBAL_TMV-CH1_GLOBAL_TMV
;.ENDIF
;-------------------------------------------------------------------------------------------	
;-------------------------------------------------------------------------------------------
.IF (WITH_SP .EQ. 1) .OR. (WITH_MS .EQ. 1) .OR. (WITH_EVO .EQ. 1)
;==========================================================
	PUBLIC MS_CH1_NOTE_ON_SYNC_TABLE
MS_CH1_NOTE_ON_SYNC_TABLE:
	.IF (WITH_SYNC_CH1_MS .EQ. 1H)
		EXTERN MS_CH1_NOTE_ON_SYNC
		DW MS_CH1_NOTE_ON_SYNC
	.ELSE
		EXTERN NOTE_ON_PROC_NEXT
		DW NOTE_ON_PROC_NEXT
	.ENDIF
;==========================================================
	PUBLIC MS_CH1_NOTE_OFF_SYNC_TABLE
MS_CH1_NOTE_OFF_SYNC_TABLE:
	.IF (WITH_SYNC_CH1_MS .EQ. 1H)
		EXTERN MS_CH1_NOTE_OFF_SYNC
		DW MS_CH1_NOTE_OFF_SYNC
	.ELSE
		EXTERN NOTE_OFF_PROC_NEXT
		DW NOTE_OFF_PROC_NEXT
	.ENDIF
;==========================================================
	.ENDIF
;==========================================================
	PUBLIC EVENT_INT_TYPE_TABLE
EVENT_INT_TYPE_TABLE:
	DW HWE_INT_TYPE_BA

;==========================================================
	PUBLIC EVENT_NRPN_ADDR_TABLE
EVENT_NRPN_ADDR_TABLE:
	DW HWE_NRPN_BA

;==========================================================
	PUBLIC EVENT_COUNT_TABLE
EVENT_COUNT_TABLE:
	DW HWE_CACHE1_BA+CACHE_COUNT

;==========================================================
	PUBLIC EVENT_CHUNK_ADDR_TABLE
EVENT_CHUNK_ADDR_TABLE:
	DW HWE_CACHE1_EVENT_CHUNK
	
;==========================================================
	PUBLIC EVENT_CH_TABLE
EVENT_CH_TABLE:
	DW HWE_CACHE1_BA+CACHE_CH

;==========================================================
	PUBLIC COLOR_FLY_EVENT_ADDR_TABLE
COLOR_FLY_EVENT_ADDR_TABLE:
	DW HWE_COLOR_FLY_BA
	
;==========================================================
	PUBLIC COLOR_FLY_GROUP_TABLE
COLOR_FLY_GROUP_TABLE:
	DW WITH_COLOR_FLY_CURVENUMS
;==========================================================
	PUBLIC GET_EVENT_CHANNEL_TYPE
GET_EVENT_CHANNEL_TYPE:
	;0:SPEECH, 1:EVO
	CMP #(EVO_CHANNEL_BASE)
	BCC EVENT_CH_TYPE_SP
EVENT_CH_TYPE_EVO:
	LDA #EVO_TYPE
	RTS
EVENT_CH_TYPE_SP:
	LDA #SPEECH_TYPE
	RTS
;==========================================================
	PUBLIC GET_EVENT_CHANNEL
GET_EVENT_CHANNEL:
	;Speech		0:CH1, 1:CH2
	;EVO		0:EVO1, 1:EVO2
	CMP #(EVO_CHANNEL_BASE)
	BCC GET_EVENT_CH_END
EVENT_CH_EVO:
	SEC
	SBC #EVO_CHANNEL_BASE
GET_EVENT_CH_END:
	RTS
;==========================================================
	PUBLIC CHK_HWE_IDLE
CHK_HWE_IDLE:
	LDA HWE_CTRL_BA
	BIT #02H
	BEQ CHK_HWE_IDLE_RTN_0
CHK_HWE_IDLE_RTN_1:
	LDA #1
	RTS
CHK_HWE_IDLE_RTN_0:
	LDA #0
	RTS
;==========================================================
	PUBLIC LEAKPROOF_SETTING_FUNC
LEAKPROOF_SETTING_FUNC:
.IF	(MAINBODY='A340')
	; A340 series
	.IF (PARTNO='N589A080').OR.(PARTNO='N589A150').OR.(PARTNO='N589A200').OR.(PARTNO='N589A280').OR.(PARTNO='N589B080').OR.(PARTNO='N589B120').OR.(PARTNO='N589B170').OR.(PARTNO='N589B200').OR.(PARTNO='N589B250').OR.(PARTNO='N589B340').OR.(PARTNO='N589C080').OR.(PARTNO='N589C120').OR.(PARTNO='N589C170').OR.(PARTNO='N589C200').OR.(PARTNO='N589C250').OR.(PARTNO='N589C340').OR.(PARTNO='N589D080').OR.(PARTNO='N589D120').OR.(PARTNO='N589D170').OR.(PARTNO='N589D200').OR.(PARTNO='N589D250').OR.(PARTNO='N589D340')
	.IF (SUBTYPE='SOP8')
	LDA	#FCH
	TSB !BP0D
	TSB !BP0M
	
	LDA	#FFH
	TSB !BP1D
	TSB !BP1M
	
	TSB !BP2D
	TSB !BP2M
	
	TSB !BP3D
	TSB !BP3M
	.ENDIF

	.IF (SUBTYPE='SOP14')
	LDA	#38H
	TSB !BP0D
	TSB !BP0M
	
	LDA	#F7H
	TSB !BP1D
	TSB !BP1M
	
	LDA	#FFH
	TSB !BP2D
	TSB !BP2M
	
	TSB !BP3D
	TSB !BP3M
	.ENDIF

	.IF (SUBTYPE='SOP20').OR.(SUBTYPE='TSSOP20')
	LDA	#28H
	TSB !BP0D
	TSB !BP0M
	
	LDA	#F6H
	TSB !BP1D
	TSB !BP1M
	
	LDA #0FH
	TSB !BP2D
	TSB !BP2M
	
	LDA	#FFH
	TSB !BP3D
	TSB !BP3M
	.ENDIF
	.ENDIF

	.IF (PARTNO='N589A080').OR.(PARTNO='N589A150').OR.(PARTNO='N589A200').OR.(PARTNO='N589A280').OR.(PARTNO='N589B200').OR.(PARTNO='N589B250').OR.(PARTNO='N589B340')
	.IF (SUBTYPE='UNDEFINE').OR.(SUBTYPE='LQFP48')
	LDA	#28H
	TSB !BP0D
	TSB !BP0M

	LDA	#03H
	TSB !BP3D
	TSB !BP3M
	.ENDIF
	.ENDIF
	
	.IF (PARTNO='N589B080').OR.(PARTNO='N589B120').OR.(PARTNO='N589B170').OR.(PARTNO='N589C200').OR.(PARTNO='N589C250').OR.(PARTNO='N589C340').OR.(PARTNO='N589D200').OR.(PARTNO='N589D250').OR.(PARTNO='N589D340')
	.IF (SUBTYPE='UNDEFINE').OR.(SUBTYPE='LQFP48')
	LDA	#28H
	TSB !BP0D
	TSB !BP0M

	LDA	#FFH
	TSB !BP3D
	TSB !BP3M
	.ENDIF
	.ENDIF
	
	.IF (PARTNO='N589C080').OR.(PARTNO='N589C120').OR.(PARTNO='N589C170').OR.(PARTNO='N589D080').OR.(PARTNO='N589D120').OR.(PARTNO='N589D170')
	.IF (SUBTYPE='UNDEFINE').OR.(SUBTYPE='LQFP48')
	LDA	#28H
	TSB !BP0D
	TSB !BP0M

	LDA	#06H
	TSB !BP1D
	TSB !BP1M

	LDA	#0FH
	TSB !BP2D
	TSB !BP2M

	LDA	#FFH
	TSB !BP3D
	TSB !BP3M
	.ENDIF
	.ENDIF

	.IF (SUBTYPE='SOP20').OR.(SUBTYPE='TSSOP20').OR.(SUBTYPE='SOP14').OR.(SUBTYPE='SOP8')
	; set BP1[7:4] output low
	LDA #F0H
	TRB !BP1R
	TSB !BP1M
	TRB !BP1D
	.ENDIF
	
	.IF (SUBTYPE='SOP28').OR.(SUBTYPE='SOP20').OR.(SUBTYPE='TSSOP20').OR.(SUBTYPE='SOP14')
	; set LDO33EN=0
	LDA #1
	TRB !LDOEN
	.ENDIF

.ENDIF

.IF	(MAINBODY='D171').OR.(MAINBODY='D481')
	; D171 & D481 series
	.IF (PARTNO='N589D081').OR.(PARTNO='N589D121').OR.(PARTNO='N589D171').OR.(PARTNO='N589D201').OR.(PARTNO='N589D251').OR.(PARTNO='N589D341').OR.(PARTNO='N589D481')
	.IF (SUBTYPE='SOP8')
	LDA	#FCH
	TSB !BP0D
	TSB !BP0M
	
	LDA	#FFH
	TSB !BP1D
	TSB !BP1M
	
	TSB !BP2D
	TSB !BP2M
	
	TSB !BP3D
	TSB !BP3M
	.ENDIF

	.IF (SUBTYPE='SOP14')
	LDA	#F8H
	TSB !BP0D
	TSB !BP0M
	
	LDA	#1FH
	TSB !BP1D
	TSB !BP1M
	
	LDA	#FFH
	TSB !BP2D
	TSB !BP2M
	
	TSB !BP3D
	TSB !BP3M
	.ENDIF

	.IF (SUBTYPE='SOP20').OR.(SUBTYPE='TSSOP20')
	LDA	#F8H
	TSB !BP0D
	TSB !BP0M
	
	LDA	#07H
	TSB !BP1D
	TSB !BP1M
	
	LDA	#0FH
	TSB !BP2D
	TSB !BP2M

	LDA	#FFH
	TSB !BP3D
	TSB !BP3M
	.ENDIF
	.ENDIF
	
	.IF (PARTNO='N589D201').OR.(PARTNO='N589D251').OR.(PARTNO='N589D341').OR.(PARTNO='N589D481')
	.IF (SUBTYPE='UNDEFINE').OR.(SUBTYPE='LQFP48')
	LDA	#28H
	TSB !BP0D
	TSB !BP0M

	LDA	#06H
	TSB !BP1D
	TSB !BP1M

	LDA	#07H
	TSB !BP2D
	TSB !BP2M
	.ENDIF
	.ENDIF
	
	.IF (PARTNO='N589D081').OR.(PARTNO='N589D121').OR.(PARTNO='N589D171')
	.IF (SUBTYPE='UNDEFINE').OR.(SUBTYPE='LQFP48')
	LDA	#28H
	TSB !BP0D
	TSB !BP0M

	LDA	#06H
	TSB !BP1D
	TSB !BP1M

	LDA	#0FH
	TSB !BP2D
	TSB !BP2M

	LDA	#FFH
	TSB !BP3D
	TSB !BP3M
	.ENDIF
	.ENDIF

	.IF (PARTNO='N589D081').OR.(PARTNO='N589D121').OR.(PARTNO='N589D171').OR.(PARTNO='N589D201').OR.(PARTNO='N589D251').OR.(PARTNO='N589D341').OR.(PARTNO='N589D481')
	.IF (SUBTYPE='SOP8')
	; set BP1[7:4] output low
	LDA #F0H
	TRB !BP1R
	TSB !BP1M
	TRB !BP1D
	.ENDIF
	
	.IF (SUBTYPE='SOP14')
	; set BP1[4] output low
	LDA #10H
	TRB !BP1R
	TSB !BP1M
	TRB !BP1D
	.ENDIF
	.ENDIF
	
	.IF (SUBTYPE='SOP28').OR.(SUBTYPE='SOP20').OR.(SUBTYPE='TSSOP20').OR.(SUBTYPE='SOP14')
	; set LDO33EN=0
	LDA #1
	TRB !LDOEN
	.ENDIF
.ENDIF

.IF	(MAINBODY='A960')
	; A960 series
	.IF (PARTNO='N589A400').OR.(PARTNO='N589A600').OR.(PARTNO='N589A900').OR.(PARTNO='N589B480').OR.(PARTNO='N589B650').OR.(PARTNO='N589B960').OR.(PARTNO='N589C480').OR.(PARTNO='N589C650').OR.(PARTNO='N589C960').OR.(PARTNO='N589D650').OR.(PARTNO='N589D960')
	.IF (SUBTYPE='SOP8')
	LDA	#FCH
	TSB !BP0D
	TSB !BP0M
	
	LDA	#FFH
	TSB !BP1D
	TSB !BP1M
	
	TSB !BP2D
	TSB !BP2M
	
	TSB !BP3D
	TSB !BP3M
	.ENDIF

	.IF (SUBTYPE='SOP14')
	LDA	#3CH
	TSB !BP0D
	TSB !BP0M
	
	LDA	#7EH
	TSB !BP1D
	TSB !BP1M
	
	LDA	#FFH
	TSB !BP2D
	TSB !BP2M
	
	TSB !BP3D
	TSB !BP3M
	.ENDIF

	.IF (SUBTYPE='TSSOP20')
	LDA	#73H
	TSB !BP1D
	TSB !BP1M
	
	LDA	#FEH
	TSB !BP2D
	TSB !BP2M
	
	LDA	#FFH
	TSB !BP3D
	TSB !BP3M
	.ENDIF
	
	.IF (SUBTYPE='TSSOP20').OR.(SUBTYPE='SOP14')
	; set BP1[6:4] output low
	LDA #70H
	TRB !BP1R
	TSB !BP1M
	TRB !BP1D
	.ENDIF
	
	.IF (SUBTYPE='SOP8')
	; set BP1[7:4] output low
	LDA #F0H
	TRB !BP1R
	TSB !BP1M
	TRB !BP1D
	.ENDIF
	.ENDIF

	.IF (PARTNO='N589B480N').OR.(PARTNO='N589D650N').OR.(PARTNO='N589D960N')
	.IF (SUBTYPE='UNDEFINE')
	LDA	#FCH
	TSB !BP0D
	TSB !BP0M
	
	LDA #73H
	TSB !BP1D
	TSB !BP1M
	
	LDA #FEH
	TSB !BP2D
	TSB !BP2M
	
	LDA	#FFH
	TSB !BP3D
	TSB !BP3M
	
	; set BP1[6:4] output low
	LDA #70H
	TRB !BP1R
	TSB !BP1M
	TRB !BP1D
	.ENDIF
	.ENDIF
.ENDIF
	RTS

;----------------------------------------------------------------
;-------------------------------------------------------------------------------------------
	INCLUDE		HweComm.asm
.IF (WITH_PROTECTION_PAGE_UPDATE .EQ. 0)
	INCLUDE		HweBoot.asm
.ENDIF 
	INCLUDE		FlashComm.asm
	INCLUDE		CapSensorTable.asm
	INCLUDE		AdcTable.asm
    
	.ENDS

	LIBRARY_CODE_NOCROSSING: SECTION
	INCLUDE		ProtectionPageComm.asm
	INCLUDE		ProtectionPageSEComm.asm
	.ENDS

