int PORTA;
int PORTB;
int PORTC;
int PORTD;
int DDRA;
int DDRB;
int DDRC;
int DDRD;
int PIND;
int TCNT2;
int TIMSK;
int GIFR;
int TCCR2;
int UCSRA;
int PINB;
int UCSRB;
int UCSRC;
int UBRRH;
int OCR1AL;
int OCR1BH;
int OCR1BL;
int OCR2;
int GICR;
int UDR;
int ICR1L;
int ICR1H;
int TCNT1L;
int OCR1AH;
int ASSR;
int TCCR1A;
int TCCR1B;
int TCNT0;
int TCNT1L;
int TCNT1H;
int UBRRL;
int ACSR;
int SFIOR;
int WDTCR;
int TIM2_OVF;
int TIM0_OVF;
int EXT_INT1;
int OCR1AH;
int MCUCR;
int TCCR0;
int UDRE;

#define NO_INT

int P_CLK;
int P_DATA;
int P_CLK_DIR;
int P_DATA_DIR;
#define CLK_READ 0
#define DATA_READ 0

int PORT_LED;

#define eeprom

#define delay_ms(X) {}
#define delay_us(X) {}
