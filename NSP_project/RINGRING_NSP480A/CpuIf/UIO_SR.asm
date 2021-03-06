    CHIP N589
    INCLUDE PGM_HEAD.INI
    INCLUDE SLD_SR.ASM
.PUBLIC UIO_COMMAND_ADDR_TABLE
.PUBLIC UIO_INIT
.PUBLIC UIO_N55P_INIT
.PUBLIC UIO_N55P_ENTER_SLEEP
.PUBLIC UIO_N55P_WAKE_UP
.PUBLIC UIO_START
.PUBLIC UIO_STOP
.PUBLIC BAM_EVENT_ADDR_OFFSET_TABLE
.PUBLIC BAM_CH_BIT_TABLE
.PUBLIC BAM_EVENT_ADDR_SP1
.PUBLIC UIO_EVENT_CH_FLAG
    CODE: SECTION
UIO_COMMAND_ADDR_TABLE:
BAM_EVENT_ADDR_OFFSET_TABLE:
BAM_CH_BIT_TABLE:
UIO_INIT:
UIO_START:
UIO_STOP:
UIO_N55P_INIT:
UIO_N55P_ENTER_SLEEP:
UIO_N55P_WAKE_UP:
    RTS
    ENDS

    UIO_USED_RAM: SECTION
BAM_EVENT_ADDR_SP1: DS 0
UIO_EVENT_CH_FLAG: DS 0
.PUBLIC DUTY_LEVEL_ARRAY
.PUBLIC UIO_PIN_CH_FLAG_ARRAY
.PUBLIC UIO_EN_MULTI_PIN_ARRAY
DUTY_LEVEL_ARRAY: DS 0
UIO_PIN_CH_FLAG_ARRAY: DS 0
UIO_EN_MULTI_PIN_ARRAY: DS 0
    ENDS

.PUBLIC SLD_COMMAND_ADDR_TABLE
.PUBLIC UIO_PIN_NUM
UIO_PIN_NUM: EQU 0
	UIO_TABLE: SECTION
.PUBLIC UIO_USED_PIN_TABLE
.PUBLIC UIO_MULTI_PIN_TABLE
.PUBLIC UIO_PIN_TABLE
UIO_USED_PIN_TABLE:
UIO_MULTI_PIN_TABLE:
UIO_PIN_TABLE:
.PUBLIC UIO_SET_PIN_STOP_VALUE_TABLE
.PUBLIC UIO_SET_DIS_PIN_STOP_VALUE_TABLE
.PUBLIC UIO_SET_PIN_ENABLE_VALUE_TABLE
UIO_SET_PIN_STOP_VALUE_TABLE:
UIO_SET_DIS_PIN_STOP_VALUE_TABLE:
UIO_SET_PIN_ENABLE_VALUE_TABLE:
.PUBLIC UIO_PIN_RAM_OFFSET_TABLE
UIO_PIN_RAM_OFFSET_TABLE:
		ENDS

