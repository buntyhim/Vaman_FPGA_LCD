`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IITH
// Engineer: Himanshu Yadav
// 
// Create Date: 12.07.2022
// Design Name: 
// Module Name: top
// Project Name: 16x2 LCD Hello
// Target Devices: Zedboard
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Print a custom string string on 16x2 LCD
// 
//////////////////////////////////////////////////////////////////////////////////


module lcd_top(
    output reg LCD_RS,
    output reg LCD_RW,
    output reg LCD_E,
    output reg[7:0] DATA,
    
    input [7:0] DATA_IN,
    input trig,
    input clk
    );
    parameter str_len = 14;
    reg [31:0]count=0;
    reg [7:0]data;
    reg [str_len*8-1:0]string = "HELLO ZedBoard";
    reg [3:0]i = str_len-1;
    
//    reg rs, rw, e;
    //reg [31:0]count;

//    assign LCD_RS = rs;
    
    always @(posedge clk)begin //20 Mhz clock - one clock pulse 50ns - count + 1 in 100ns - 1usec = 10 count
        data<=DATA_IN;
        count <= count + 1;
        case(count)
             80 : begin LCD_RS <= 1'b0;  LCD_RW <= 1'b0;   LCD_E <= 1'b0;  end
     
             100: begin LCD_E <= 1'b0; LCD_RS <= 1'b0; end
             10000:   DATA <= 8'h0x30;      // function set 8 bit operation, 2 line disply, 5x8 character
             10100:      LCD_E <= 1'b1;
             10300:      LCD_E <= 1'b0; 
             12000:   DATA <= 8'h0x30;      // function set 8 bit operation, 2 line disply, 5x8 character
             12100:      LCD_E <= 1'b1;
             12300:      LCD_E <= 1'b0; 
             14000:   DATA <= 8'h0x30;      // function set 8 bit operation, 2 line disply, 5x8 character
             14100:      LCD_E <= 1'b1;
             14300:      LCD_E <= 1'b0; 
             14000:   DATA <= 8'h0x38;      // function set 8 bit operation, 2 line disply, 5x8 character
             20100:      LCD_E <= 1'b1;
             20300:      LCD_E <= 1'b0;     // 2us pulse for writing the data/command
             40000:  DATA <= 8'h0x0E;       //Turns on display and cursor
             40100:      LCD_E <= 1'b1;
             40300:      LCD_E <= 1'b0;     // 2us pulse for writing the data/command
             60000:  DATA <= 8'h0x06;       // shift cursor right after write
             60100:      LCD_E <= 1'b1;
             60300:      LCD_E <= 1'b0;     // 2us pulse for writing the data/command
             80000:  begin LCD_RS = 1'b1;  DATA = string[8*i +: 7]; end   
             80100:      LCD_E <= 1'b1;
             80300:      begin    LCD_E <= 1'b0; i = i-1; end
             100000: begin LCD_RS = 1'b1; DATA = string[8*i +: 7];end
             100100:      LCD_E <= 1'b1;
             100300:      begin    LCD_E <= 1'b0; i = i-1; end
             120000:  begin LCD_RS = 1'b1;  DATA = string[8*i +: 7]; end 
             120100:      LCD_E <= 1'b1;
             120300:      begin    LCD_E <= 1'b0; i = i-1; end
             140000:  begin LCD_RS = 1'b1;  DATA = string[8*i +: 7];end 
             140100:      LCD_E <= 1'b1;
             140300:      begin    LCD_E <= 1'b0; i = i-1; end
             160000:  begin LCD_RS = 1'b1;  DATA = string[8*i +: 7];end  
             160100:      LCD_E <= 1'b1;
             160300:      begin    LCD_E <= 1'b0; i = i-1; end
             200000:  begin LCD_RS = 1'b1; DATA = string[8*i +: 7]; end  
             200100:      LCD_E <= 1'b1;
             200300:      begin    LCD_E <= 1'b0; i = i-1; end
             220000:    begin LCD_RS = 1'b1; DATA = string[8*i +: 7]; end
             220100:      LCD_E <= 1'b1;
             220300:      begin    LCD_E <= 1'b0; i = i-1; end
             240000:    begin LCD_RS = 1'b1; DATA = string[8*i +: 7]; end
             240100:      LCD_E <= 1'b1;
             240300:      begin    LCD_E <= 1'b0; i = i-1; end
             260000:    begin LCD_RS = 1'b1;  DATA = string[8*i +: 7]; end
             260100:      LCD_E <= 1'b1;
             260300:      begin    LCD_E <= 1'b0; i = i-1; end
             280000:    begin LCD_RS = 1'b1;  DATA = string[8*i +: 7]; end
             280100:      LCD_E <= 1'b1;
             280300:      begin    LCD_E <= 1'b0; i = i-1; end
             300000:    begin LCD_RS = 1'b1;  DATA = string[8*i +: 7]; end
             300100:      LCD_E <= 1'b1;
             300300:      begin    LCD_E <= 1'b0; i = i-1; end
             320000:    begin LCD_RS = 1'b1;  DATA = string[8*i +: 7]; end
             320100:      LCD_E <= 1'b1;
             320300:      begin    LCD_E <= 1'b0; i = i-1; end
             340000:    begin LCD_RS = 1'b1;  DATA = string[8*i +: 7]; end
             340100:      LCD_E <= 1'b1;
             340300:      begin    LCD_E <= 1'b0; i = i-1; end
             360000:    begin LCD_RS = 1'b1;  DATA = string[8*i +: 7]; end
             360100:      LCD_E <= 1'b1;
             360300:      begin    LCD_E <= 1'b0; i = i-1; end
             
             3000000:  begin LCD_RS = 1'b0; DATA <= 8'h0x01; i <= str_len-1; end  //HOME
             3000100:      LCD_E <= 1'b1;
             3000300:      LCD_E <= 1'b0;
              default: ;         
        endcase
        if (count > 3200000) count<= 70000;
    end
        
endmodule
