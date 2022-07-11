`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IITH
// Engineer: Himanshu Yadav
// 
// Create Date: 14.06.2022 23:07:41
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
// Additional Comments: This works perfectly and prints hello on the LCD
// 
//////////////////////////////////////////////////////////////////////////////////


module lcd_top(
    output reg LCD_RS,
    output reg LCD_RW,
    output reg LCD_E,
    output reg[7:0] DATA,
    input clk
    );
    reg [31:0]count;
//    reg rs, rw, e;
    //reg [31:0]count;

//    assign LCD_RS = rs;
    
    always @(posedge clk)begin //20 Mhz clock - one clock pulse 50ns - count + 1 in 100ns - 1usec = 10 count
        count <= count + 1;
        case(count)
            80 : begin LCD_RS <= 1'b0;  LCD_RW <= 1'b0;   LCD_E <= 1'b0;  end
     
             100: begin LCD_E <= 1'b0; LCD_RS <= 1'b0; end
             20000:   DATA <= 8'h0x30;
             20100:      LCD_E <= 1'b1;
             20300:      LCD_E <= 1'b0;     // 2us pulse for writing the data/command
             40000:  DATA <= 8'h0x0E;
             40100:      LCD_E <= 1'b1;
             40300:      LCD_E <= 1'b0;     // 2us pulse for writing the data/command
             60000:  DATA <= 8'h0x06;
             60100:      LCD_E <= 1'b1;
             60300:      LCD_E <= 1'b0;     // 2us pulse for writing the data/command
             80000:  begin LCD_RS = 1'b1; DATA <= 8'h0x48;end   //H
             80100:      LCD_E <= 1'b1;
             80300:      LCD_E <= 1'b0;
             100000:  begin LCD_RS = 1'b1; DATA <= 8'h0x45;end  //E
             100100:      LCD_E <= 1'b1;
             100300:      LCD_E <= 1'b0;
             120000:  begin LCD_RS = 1'b1; DATA <= 8'h0x4C;end  //L
             120100:      LCD_E <= 1'b1;
             120300:      LCD_E <= 1'b0;
             140000:  begin LCD_RS = 1'b1; DATA <= 8'h0x4C;end  //L
             140100:      LCD_E <= 1'b1;
             140300:      LCD_E <= 1'b0;
             160000:  begin LCD_RS = 1'b1; DATA <= 8'h0x4F;end  //O
             160100:      LCD_E <= 1'b1;
             160300:      LCD_E <= 1'b0;
             180000:  begin LCD_RS = 1'b1; DATA <= 8'h0x20;end  //SPACE
             180100:      LCD_E <= 1'b1;
             180300:      LCD_E <= 1'b0;
             3000000:  begin LCD_RS = 1'b0; DATA <= 8'h0x01;end  //HOME
             3000100:      LCD_E <= 1'b1;
             3000300:      LCD_E <= 1'b0;
              default: ;         
        endcase
        if (count > 3200000) count<= 0;
    end
        
endmodule
