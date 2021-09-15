/*_____ I N C L U D E S ____________________________________________________*/
#include <stdio.h>
#include <string.h>
#include "NuMicro.h"

#include	"project_config.h"

#include "nsp_driver.h"
#include "nsp_PlaySample.h"
/*_____ D E C L A R A T I O N S ____________________________________________*/

/*_____ D E F I N I T I O N S ______________________________________________*/
volatile uint32_t BitFlag = 0;
volatile uint32_t counter_tick = 0;

//#define USE_NSP960B

/*_____ M A C R O S ________________________________________________________*/

/*_____ F U N C T I O N S __________________________________________________*/

void tick_counter(void)
{
	counter_tick++;
}

uint32_t get_tick(void)
{
	return (counter_tick);
}

void set_tick(uint32_t t)
{
	counter_tick = t;
}

void compare_buffer(uint8_t *src, uint8_t *des, int nBytes)
{
    uint16_t i = 0;	
	
    for (i = 0; i < nBytes; i++)
    {
        if (src[i] != des[i])
        {
            printf("error idx : %4d : 0x%2X , 0x%2X\r\n", i , src[i],des[i]);
			set_flag(flag_error , ENABLE);
        }
    }

	if (!is_flag_set(flag_error))
	{
    	printf("%s finish \r\n" , __FUNCTION__);	
		set_flag(flag_error , DISABLE);
	}

}

void reset_buffer(void *dest, unsigned int val, unsigned int size)
{
    uint8_t *pu8Dest;
//    unsigned int i;
    
    pu8Dest = (uint8_t *)dest;

	#if 1
	while (size-- > 0)
		*pu8Dest++ = val;
	#else
	memset(pu8Dest, val, size * (sizeof(pu8Dest[0]) ));
	#endif
	
}

void copy_buffer(void *dest, void *src, unsigned int size)
{
    uint8_t *pu8Src, *pu8Dest;
    unsigned int i;
    
    pu8Dest = (uint8_t *)dest;
    pu8Src  = (uint8_t *)src;


	#if 0
	  while (size--)
	    *pu8Dest++ = *pu8Src++;
	#else
    for (i = 0; i < size; i++)
        pu8Dest[i] = pu8Src[i];
	#endif
}

void dump_buffer(uint8_t *pucBuff, int nBytes)
{
    uint16_t i = 0;
    
    printf("dump_buffer : %2d\r\n" , nBytes);    
    for (i = 0 ; i < nBytes ; i++)
    {
        printf("0x%2X," , pucBuff[i]);
        if ((i+1)%8 ==0)
        {
            printf("\r\n");
        }            
    }
    printf("\r\n\r\n");
}

void  dump_buffer_hex(uint8_t *pucBuff, int nBytes)
{
    int     nIdx, i;

    nIdx = 0;
    while (nBytes > 0)
    {
        printf("0x%04X  ", nIdx);
        for (i = 0; i < 16; i++)
            printf("%02X ", pucBuff[nIdx + i]);
        printf("  ");
        for (i = 0; i < 16; i++)
        {
            if ((pucBuff[nIdx + i] >= 0x20) && (pucBuff[nIdx + i] < 127))
                printf("%c", pucBuff[nIdx + i]);
            else
                printf(".");
            nBytes--;
        }
        nIdx += 16;
        printf("\n");
    }
    printf("\n");
}

void delay(uint16_t dly)
{
/*
	delay(100) : 14.84 us
	delay(200) : 29.37 us
	delay(300) : 43.97 us
	delay(400) : 58.5 us	
	delay(500) : 73.13 us	
	
	delay(1500) : 0.218 ms (218 us)
	delay(2000) : 0.291 ms (291 us)	
*/

	while( dly--);
}

void NSP_IO_Detect_loop(void)
{
	uint8_t io_state = 0;

	// BP17 use PULL HIGH button , default HIGH , active LOW
	// BP20 use PULL LOW button , default LOW , active HIGH

	while (!TwoWire_AskStatus());
	// detect IO state
	N_GET_INOUT(&io_state);

	if (((io_state >> 7) & 0x01) == DISABLE )
	{
		printf("BP17 BTN\r\n");
	
		N_WAKUP();
    	N_AUTO_SLEEP_DIS();		


		N_SET_VOL(0x40);	// max : 0x80 (128)
		N_PLAY(6);  
		TwoWire_WaitPlayEND();
		printf("TwoWire_WaitPlayEND\r\n");		
	}
	else if (((io_state >> 0) & 0x01) == ENABLE)
	{
//		N_WAKUP();
//    	N_AUTO_SLEEP_DIS();		
		printf("BP20 BTN\r\n");

		N_SET_VOL(0x40);	// max : 0x80 (128)
		N_PLAY(5);  
		TwoWire_WaitPlayEND();
		printf("TwoWire_WaitPlayEND\r\n");		
	}
	
}

/*
	NSP960B
	BIT7 : BP17_CFG
	BIT6 : RESERVED
	BIT5 : RESERVED
	BIT4 : RESERVED

	BIT3 : BP13_CFG
	BIT2 : BP12_CFG
	BIT1 : RESERVED
	BIT0 : BP20_CFG

	set 1 input
	set 0 output
	
*/

void NSP_IO_Init(void)
{
	uint8_t io_state = 0;
	
	N_WAKUP();
	N_AUTO_SLEEP_DIS();

	// enable BP17 , BP20 as input , BP17 : pull high button , BP20 : pull low button
	// BP13 , BP12 as output
	io_state = 0x00 | BIT7 | BIT0 ;
	N_IO_CONFIG(io_state);

	io_state = 0;
	N_IO_TYPE(&io_state); 
	printf("IO_TYPE : 0x%2X\r\n" , io_state);

	N_SET_OUT(0x00); 		
}

void process_loop(void)
{
    UINT8 NSP_STATUS = 0;

	
	if (is_flag_set(flag_indexQ))
	{
		set_flag(flag_indexQ , FALSE);
		
		TwoWire_SleepWakeUpSample();		
	}
	else if (is_flag_set(flag_indexW))
	{
		set_flag(flag_indexW , FALSE);
		
		N_WAKUP();
    	N_AUTO_SLEEP_DIS();		

		N_SET_VOL(0x40);	// max : 0x80 (128)
		N_PLAY(2);  
		TwoWire_WaitPlayEND();
		printf("TwoWire_WaitPlayEND (W) \r\n");

		// entry power down , volume data will lost
		N_AUTO_SLEEP_EN();		
		N_PWR_DOWN();
	}
	else if (is_flag_set(flag_indexE))
	{
		set_flag(flag_indexE , FALSE);
		
		N_WAKUP();
    	N_AUTO_SLEEP_DIS();		

//		N_SET_VOL(0x10);	// max : 0x80 (128)
		N_PLAY(6);  
		TwoWire_WaitPlayEND();
		printf("TwoWire_WaitPlayEND (E) \r\n");

		// entry power down , volume data will lost
		N_AUTO_SLEEP_EN();		
		N_PWR_DOWN();
	}
	else if (is_flag_set(flag_indexR))
	{
		set_flag(flag_indexR , FALSE);
		

	}		
	else if (is_flag_set(flag_indexT))		// enable GPIO , to start play wave
	{
		set_flag(flag_indexT , FALSE);

		#if defined (USE_NSP960B)
		NSP_IO_Detect_loop();
		#endif
	}		
	else if (is_flag_set(flag_index1))
	{
		set_flag(flag_index1 , FALSE);
		
		N_WAKUP();
    	N_AUTO_SLEEP_DIS();		

		N_SET_VOL(0x40);	// max : 0x80 (128)
		N_PLAY(1);  
		TwoWire_WaitPlayEND();
		printf("TwoWire_WaitPlayEND (1) \r\n");
	}
	else if (is_flag_set(flag_index2))
	{
		set_flag(flag_index2 , FALSE);
		
		N_WAKUP();
    	N_AUTO_SLEEP_DIS();		

//		N_SET_VOL(0x20);	// max : 0x80 (128)
		N_PLAY(2);  
		TwoWire_WaitPlayEND();
		printf("TwoWire_WaitPlayEND (2)\r\n");
	}	
	else if (is_flag_set(flag_index3))
	{
		set_flag(flag_index3 , FALSE);
		
		N_WAKUP();
    	N_AUTO_SLEEP_DIS();		

//		N_SET_VOL(0x20);	// max : 0x80 (128)
		N_PLAY(3);  
		TwoWire_WaitPlayEND();
		printf("TwoWire_WaitPlayEND (3)\r\n");
	}	
	else if (is_flag_set(flag_index4))
	{
		set_flag(flag_index4 , FALSE);
		
		N_WAKUP();
    	N_AUTO_SLEEP_DIS();		

//		N_SET_VOL(0x20);	// max : 0x80 (128)
		N_PLAY(4);  
		TwoWire_WaitPlayEND();
		printf("TwoWire_WaitPlayEND (4)\r\n");
	}	
	else if (is_flag_set(flag_index5))
	{
		set_flag(flag_index5 , FALSE);
		
		N_WAKUP();
    	N_AUTO_SLEEP_DIS();		

//		N_SET_VOL(0x20);	// max : 0x80 (128)
		N_PLAY(5);  
		TwoWire_WaitPlayEND();
		printf("TwoWire_WaitPlayEND (5)\r\n");
	}	
	else if (is_flag_set(flag_index6))
	{
		set_flag(flag_index6 , FALSE);
		
		N_WAKUP();
    	N_AUTO_SLEEP_DIS();		

//		N_SET_VOL(0x20);	// max : 0x80 (128)
		N_PLAY(6);  
		TwoWire_WaitPlayEND();
		printf("TwoWire_WaitPlayEND (6)\r\n");
	}		
	else if (is_flag_set(flag_index7))
	{
		set_flag(flag_index7 , FALSE);
		
		N_WAKUP();
    	N_AUTO_SLEEP_DIS();		

//		N_SET_VOL(0x20);	// max : 0x80 (128)
		N_PLAY(7);  

		#if 1	// force to stop playing , if press 'S'
	    do
	    {
			HOST_Delay500uS();
			
			if(is_flag_set(flag_indexS))
			{
				printf("trigger stop playing\r\n");
				set_flag(flag_indexS , FALSE);	
				N_STOP();
				printf("stop playing\r\n");
				break;
			}
			
	    }while(!TwoWire_AskStatus());
		#else
		TwoWire_WaitPlayEND();
		#endif
			
		printf("TwoWire_WaitPlayEND (7)\r\n");
	}	
				
}

//void delay_ms(uint16_t ms)
//{
//	TIMER_Delay(TIMER0, 1000*ms);
//}

void GPIO_Init (void)
{
    SYS->GPB_MFPH = (SYS->GPB_MFPH & ~(SYS_GPB_MFPH_PB14MFP_Msk)) | (SYS_GPB_MFPH_PB14MFP_GPIO);
    SYS->GPB_MFPH = (SYS->GPB_MFPH & ~(SYS_GPB_MFPH_PB15MFP_Msk)) | (SYS_GPB_MFPH_PB15MFP_GPIO);
	
    GPIO_SetMode(PB, BIT14, GPIO_MODE_OUTPUT);
    GPIO_SetMode(PB, BIT15, GPIO_MODE_OUTPUT);	
}


void TMR1_IRQHandler(void)
{
	static uint32_t LOG = 0;
	uint8_t io_state = 0;
	
    if(TIMER_GetIntFlag(TIMER1) == 1)
    {
        TIMER_ClearIntFlag(TIMER1);
		tick_counter();

		if ((get_tick() % 1000) == 0)
		{
//        	printf("%s : %4d\r\n",__FUNCTION__,LOG++);
			PB14 ^= 1;

			#if defined (USE_NSP960B)
			// detect IO state
			N_GET_INOUT(&io_state);
        	printf("io_state : 0x%2X , BP17 = 0x%2X , BP13 = 0x%2X ,BP12 = 0x%2X ,BP20 = 0x%2X ,\r\n",
					io_state, 
					((io_state >> 7) & 0x01),
					((io_state >> 3) & 0x01),
					((io_state >> 2) & 0x01),
					((io_state >> 0) & 0x01));
			#endif
		}

		if ((get_tick() % 50) == 0)
		{
			#if defined (USE_NSP960B)			
			set_flag(flag_indexT , TRUE);		
			#endif
		}	
    }
}


void TIMER1_Init(void)
{
    TIMER_Open(TIMER1, TIMER_PERIODIC_MODE, 1000);
    TIMER_EnableInt(TIMER1);
    NVIC_EnableIRQ(TMR1_IRQn);	
    TIMER_Start(TIMER1);
}

void UARTx_Process(void)
{
	uint8_t res = 0;
	uint8_t volume = 0;
	
	res = UART_READ(UART0);

	if (res == 'x' || res == 'X')
	{
		NVIC_SystemReset();
	}

	if (res > 0x7F)
	{
		printf("invalid command\r\n");
	}
	else
	{
		printf("%s : %c\r\n" , __FUNCTION__ , res);
		switch(res)
		{
			case '1':
				set_flag(flag_index1 , TRUE);
				break;
			case '2':
				set_flag(flag_index2 , TRUE);
				break;
			case '3':
				set_flag(flag_index3 , TRUE);
				break;
			case '4':
				set_flag(flag_index4 , TRUE);
				break;
			case '5':
				set_flag(flag_index5 , TRUE);
				break;
			case '6':
				set_flag(flag_index6 , TRUE);
				break;
			case '7':
				set_flag(flag_index7 , TRUE);
				break;

			case 'Q':
			case 'q':				
				set_flag(flag_indexQ , TRUE);
				break;

			case 'W':
			case 'w':				
				set_flag(flag_indexW , TRUE);
				break;

			case 'E':
			case 'e':				
				set_flag(flag_indexE , TRUE);
				break;
			
			case 'R':
			case 'r':				
				set_flag(flag_indexR , TRUE);
				break;			

			case 'T':
			case 't':				
				set_flag(flag_indexT , TRUE);
				break;	

			case 'S':
			case 's':				
				set_flag(flag_indexS , TRUE);			
				break;	
				
			case 'A':
			case 'a':
				N_GET_VOL(&volume);
				printf("volume 0x%2X\r\n"  , volume);
				if (volume++ >= 0x80)
				{
					volume = 0x80;
				}
				N_SET_VOL(volume);
				break;
			case 'D':
			case 'd':				
				N_GET_VOL(&volume);
				printf("volume 0x%2X\r\n"  , volume);
				if (volume-- <= 1)
				{
					volume = 1;
				}
				N_SET_VOL(volume);
				break;	
			
			case 'X':
			case 'x':
			case 'Z':
			case 'z':
				NVIC_SystemReset();		
				break;
		}
	}
}

void UART02_IRQHandler(void)
{

    if(UART_GET_INT_FLAG(UART0, UART_INTSTS_RDAINT_Msk | UART_INTSTS_RXTOINT_Msk))     /* UART receive data available flag */
    {
        while(UART_GET_RX_EMPTY(UART0) == 0)
        {
            UARTx_Process();
        }
    }

    if(UART0->FIFOSTS & (UART_FIFOSTS_BIF_Msk | UART_FIFOSTS_FEF_Msk | UART_FIFOSTS_PEF_Msk | UART_FIFOSTS_RXOVIF_Msk))
    {
        UART_ClearIntFlag(UART0, (UART_INTSTS_RLSINT_Msk| UART_INTSTS_BUFERRINT_Msk));
    }	
}

void UART0_Init(void)
{
    SYS_ResetModule(UART0_RST);

    /* Configure UART0 and set UART0 baud rate */
    UART_Open(UART0, 115200);
    UART_EnableInt(UART0, UART_INTEN_RDAIEN_Msk | UART_INTEN_RXTOIEN_Msk);
    NVIC_EnableIRQ(UART02_IRQn);
	
	#if (_debug_log_UART_ == 1)	//debug
	printf("\r\nCLK_GetCPUFreq : %8d\r\n",CLK_GetCPUFreq());
	printf("CLK_GetHXTFreq : %8d\r\n",CLK_GetHXTFreq());
	printf("CLK_GetLXTFreq : %8d\r\n",CLK_GetLXTFreq());	
	printf("CLK_GetPCLK0Freq : %8d\r\n",CLK_GetPCLK0Freq());
	printf("CLK_GetPCLK1Freq : %8d\r\n",CLK_GetPCLK1Freq());	
	#endif	

}

void SYS_Init(void)
{
    /* Unlock protected registers */
    SYS_UnlockReg();

    CLK_EnableXtalRC(CLK_PWRCTL_HIRCEN_Msk);
    CLK_WaitClockReady(CLK_STATUS_HIRCSTB_Msk);

//    CLK_EnableXtalRC(CLK_PWRCTL_HXTEN_Msk);
//    CLK_WaitClockReady(CLK_STATUS_HXTSTB_Msk);

//    CLK_EnableXtalRC(CLK_PWRCTL_LIRCEN_Msk);
//    CLK_WaitClockReady(CLK_STATUS_LIRCSTB_Msk);	

//    CLK_EnableXtalRC(CLK_PWRCTL_LXTEN_Msk);
//    CLK_WaitClockReady(CLK_STATUS_LXTSTB_Msk);	

    /* Select HCLK clock source as HIRC and HCLK source divider as 1 */
    CLK_SetHCLK(CLK_CLKSEL0_HCLKSEL_HIRC, CLK_CLKDIV0_HCLK(1));

    CLK_EnableModuleClock(UART0_MODULE);
    CLK_SetModuleClock(UART0_MODULE, CLK_CLKSEL1_UART0SEL_HIRC, CLK_CLKDIV0_UART0(1));

    CLK_EnableModuleClock(TMR0_MODULE);
  	CLK_SetModuleClock(TMR0_MODULE, CLK_CLKSEL1_TMR0SEL_HIRC, 0);

    CLK_EnableModuleClock(TMR1_MODULE);
  	CLK_SetModuleClock(TMR1_MODULE, CLK_CLKSEL1_TMR1SEL_HIRC, 0);

    /* Set PB multi-function pins for UART0 RXD=PB.12 and TXD=PB.13 */
    SYS->GPB_MFPH = (SYS->GPB_MFPH & ~(SYS_GPB_MFPH_PB12MFP_Msk | SYS_GPB_MFPH_PB13MFP_Msk)) |
                    (SYS_GPB_MFPH_PB12MFP_UART0_RXD | SYS_GPB_MFPH_PB13MFP_UART0_TXD);

   /* Update System Core Clock */
    SystemCoreClockUpdate();

    /* Lock protected registers */
    SYS_LockReg();
}

/*
 * This is a template project for M031 series MCU. Users could based on this project to create their
 * own application without worry about the IAR/Keil project settings.
 *
 * This template application uses external crystal as HCLK source and configures UART0 to print out
 * "Hello World", users may need to do extra system configuration based on their system design.
 */

int main()
{
    SYS_Init();

	UART0_Init();
	GPIO_Init();
	TIMER1_Init();

    HOST_BUS_Init();	// BP01 : DATA (PA11)  , BP00 : CLK (PA10)

	N_WAKUP();
	N_AUTO_SLEEP_DIS();		

	N_SET_VOL(0x40);

	#if defined (USE_NSP960B)	
    NSP_IO_Init();
	#endif

//	PlaySample_1();
//	PlaySample_2();

//	PlaySample_ISP();

//	PlayNormalSample();

//	TwoWirePlaySample();

    /* Got no where to go, just loop forever */
    while(1)
    {
		process_loop();
		
    }
}

/*** (C) COPYRIGHT 2017 Nuvoton Technology Corp. ***/
