# M031BSP_NSP_TwoWireSample
 M031BSP_NSP_TwoWireSample


update @ 2021/09/03

1. pre programming wave file index in NSP960B EVB by Nuvoton NSP PlayList Editor V1.13.000 with NSP 1-1 Writer

2. Below file copy from Nuvoton NSP PlayList Editor V1.13.000 folder

	nsp_driver.c , use PA11 as BP01(DATA) , PA10 as BP00(CLK)
	
	nsp_driver.h  ,
	
	nsp_PlaySample.c , 
	
	nsp_PlaySample.h 

3. under NSP_project folder is zip file of NSP project , include project file with 6 wave file (index from 1 ~ 6) 

	open project file by Nuvoton NSP PlayList Editor , wave file re-sample as 16000 Hz 

	refer NSP PlayList Editor Tool User Guilde.pdf


4. scenario 

	initial GPIO : use PA11 as BP01(DATA) , PA10 as BP00(CLK) 
	
	initial NSP960B EVB , BP17 and BP20 as GPIO input , and connect with external button 
		
		BP17 use external PULL HIGH button , press button will play wave file
		
		BP20 use external PULL LOW button , press button will play wave file
	
	by terminal , press digit 2 , 3 to play wave file (however , NSP will entry power down after play finish , and data will lost)
	
	by terminal , press digit 4 , 5 to play wave file (NSP will not go into power down)
	
	by terminal , press A or a , to increase volume and D or d , to decrease volume
	

5. below is NSP960EVB

![image](https://github.com/released/M031BSP_NSP_TwoWireSample/blob/main/NSP960_EVB.jpg)


6. below is screen capture about digit 4 , 5

![image](https://github.com/released/M031BSP_NSP_TwoWireSample/blob/main/DIGIT_4_5.jpg)

when use external PULL HIGH button (BP17) 

![image](https://github.com/released/M031BSP_NSP_TwoWireSample/blob/main/BP17_IO.jpg)

when use external PULL HIGH button (BP20) 

![image](https://github.com/released/M031BSP_NSP_TwoWireSample/blob/main/BP20_IO.jpg)

