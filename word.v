`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:21:01 01/03/2017 
// Design Name: 
// Module Name:    word 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module word(
    input clk,
  	input rst,
    input [10:0]col,
    input [10:0]row,
	output gameover
    );


reg [7:0]data;
reg [11:0]word_count;
reg [11:0]row_count;



always@(posedge clk or posedge rst)
  if(rst) word_count=0;
  else begin
    case(col)
      184,264,344,424,504,584,664,744: word_count=7;    
      194,274,354,434,514,594,674,754: word_count=6;  
      204,284,364,444,524,604,684,764: word_count=5;  
      214,294,374,454,534,614,694,774: word_count=4;  
      224,304,384,464,544,624,704,784: word_count=3;  
      234,314,394,474,554,634,714,794: word_count=2;  
      244,324,404,484,564,644,724,804: word_count=1;  
      254,334,414,494,574,654,734,814: word_count=0;  
      default:word_count=word_count;
     endcase   
  end


always@(posedge clk or posedge rst)
  if(rst) row_count=0;
  else begin
    case(row)
      250,251,252,253,254,255,256,257,258,259: row_count=0;    
      260,261,262,263,264,265,266,267,268,269: row_count=1;   
      270,271,272,273,274,275,276,277,278,279: row_count=2;   
      280,281,282,283,284,285,286,287,288,289: row_count=3;   
      290,291,292,293,294,295,296,297,298,299: row_count=4;   
      300,301,302,303,304,305,306,307,308,309: row_count=5;   
      310,311,312,313,314,315,316,317,318,319: row_count=6;   
      320,321,322,323,324,325,326,327,328,329: row_count=7;   
      330,331,332,333,334,335,336,337,338,339: row_count=8;   
      340,341,342,343,344,345,346,347,348,349: row_count=9;   
      350,351,352,353,354,355,356,357,358,359: row_count=10;   
      360,361,362,363,364,365,366,367,368,369: row_count=11;   
      370,371,372,373,374,375,376,377,378,379: row_count=12;   
      380,381,382,383,384,385,386,387,388,389: row_count=13;   
      390,391,392,393,394,395,396,397,398,399: row_count=14;    
      default:row_count=row_count;
     endcase   
  end

  
assign gameover=(row>=250 && row <400 && col>=184 && col<824) ? data[word_count]:0;


always@(posedge clk or posedge rst)
  if(rst) data=0;
  else if(row<400 && row>=250) 
      case (col)
         183:      
         case  (row_count) 
             0:   data = 8'b00000000; // 
             1:   data = 8'b00111100; //   ****
             2:   data = 8'b01100110; //  **  **
             3:   data = 8'b11000010; // **    *
             4:   data = 8'b11000000; // **
             5:   data = 8'b11000000; // **
             6:   data = 8'b11011110; // ** ****
             7:   data = 8'b11000110; // **   **
             8:   data = 8'b11000110; // **   **
             9:   data = 8'b01100110; //  **  **
             10:  data = 8'b00111010; //   *** *
             11:  data = 8'b00000000; // 
             12:  data = 8'b00000000; // 
             13:  data = 8'b00000000; // 
             14:  data = 8'b00000000; // 
             default: data=data;
         endcase
         263:
         case  (row_count) 
             0:   data = 8'b00000000; // 
             1:   data = 8'b00010000; //    *
             2:   data = 8'b00111000; //   ***
             3:   data = 8'b01101100; //  ** **
             4:   data = 8'b11000110; // **   **
             5:   data = 8'b11000110; // **   **
             6:   data = 8'b11111110; // *******
             7:   data = 8'b11000110; // **   **
             8:   data = 8'b11000110; // **   **
             9:   data = 8'b11000110; // **   **
             10:  data = 8'b11000110; // **   **
             11:  data = 8'b00000000; // 
             12:  data = 8'b00000000; // 
             13:  data = 8'b00000000; // 
             14:  data = 8'b00000000; // 
             default: data=data;
         endcase
         343 :      
         case  (row_count) 
             0:   data = 8'b00000000; // 
             1:   data = 8'b11000011; // **    **
             2:   data = 8'b11100111; // ***  ***
             3:   data = 8'b11111111; // ********
             4:   data = 8'b11111111; // ********
             5:   data = 8'b11011011; // ** ** **
             6:   data = 8'b11000011; // **    **
             7:   data = 8'b11000011; // **    **
             8:   data = 8'b11000011; // **    **
             9:   data = 8'b11000011; // **    **
             10:  data = 8'b11000011; // **    **
             11:  data = 8'b00000000; // 
             12:  data = 8'b00000000; // 
             13:  data = 8'b00000000; // 
             14:  data = 8'b00000000; // 
             default: data=data;
         endcase
         423:
         case  (row_count) 
             0:   data = 8'b00000000; // 
             1:   data = 8'b11111110; // *******
             2:   data = 8'b01100110; //  **  **
             3:   data = 8'b01100010; //  **   *
             4:   data = 8'b01101000; //  ** *
             5:   data = 8'b01111000; //  ****
             6:   data = 8'b01101000; //  ** *
             7:   data = 8'b01100000; //  **
             8:   data = 8'b01100010; //  **   *
             9:   data = 8'b01100110; //  **  **
             10:  data = 8'b11111110; // *******
             11:  data = 8'b00000000; // 
             12:  data = 8'b00000000; // 
             13:  data = 8'b00000000; // 
             14:  data = 8'b00000000; // 
             default: data=data;
         endcase         
         503:
         case  (row_count) 
             0:   data = 8'b00000000; // 
             1:   data = 8'b01111100; //  *****
             2:   data = 8'b11000110; // **   **
             3:   data = 8'b11000110; // **   **
             4:   data = 8'b11000110; // **   **
             5:   data = 8'b11000110; // **   **
             6:   data = 8'b11000110; // **   **
             7:   data = 8'b11000110; // **   **
             8:   data = 8'b11000110; // **   **
             9:   data = 8'b11000110; // **   **
             10:  data = 8'b01111100; //  *****
             11:  data = 8'b00000000; // 
             12:  data = 8'b00000000; // 
             13:  data = 8'b00000000; // 
             14:  data = 8'b00000000; // 
             default: data=data;
         endcase 
         583:
         case  (row_count) 
             0:   data = 8'b00000000; // 
             1:   data = 8'b11000011; // **    **
             2:   data = 8'b11000011; // **    **
             3:   data = 8'b11000011; // **    **
             4:   data = 8'b11000011; // **    **
             5:   data = 8'b11000011; // **    **
             6:   data = 8'b11000011; // **    **
             7:   data = 8'b11000011; // **    **
             8:   data = 8'b01100110; //  **  **
             9:   data = 8'b00111100; //   ****
             10:  data = 8'b00011000; //    **
             11:  data = 8'b00000000; // 
             12:  data = 8'b00000000; // 
             13:  data = 8'b00000000; // 
             14:  data = 8'b00000000; // 
             default: data=data;
         endcase 
         663:
         case  (row_count) 
             0:   data = 8'b00000000; // 
             1:   data = 8'b11111110; // *******
             2:   data = 8'b01100110; //  **  **
             3:   data = 8'b01100010; //  **   *
             4:   data = 8'b01101000; //  ** *
             5:   data = 8'b01111000; //  ****
             6:   data = 8'b01101000; //  ** *
             7:   data = 8'b01100000; //  **
             8:   data = 8'b01100010; //  **   *
             9:   data = 8'b01100110; //  **  **
             10:  data = 8'b11111110; // *******
             11:  data = 8'b00000000; // 
             12:  data = 8'b00000000; // 
             13:  data = 8'b00000000; // 
             14:  data = 8'b00000000; // 
             default: data=data;
         endcase               
         743:	
         case  (row_count) 
             0:   data = 8'b00000000; // 
             1:   data = 8'b11111100; // ******
             2:   data = 8'b01100110; //  **  **
             3:   data = 8'b01100110; //  **  **
             4:   data = 8'b01100110; //  **  **
             5:   data = 8'b01111100; //  *****
             6:   data = 8'b01101100; //  ** **
             7:   data = 8'b01101100; //  ** **
             8:   data = 8'b01101100; //  ** **
             9:   data = 8'b01100110; //  **  **
             10:  data = 8'b11100110; // ***  **
             11:  data = 8'b00000000; // 
             12:  data = 8'b00000000; // 
             13:  data = 8'b00000000; // 
             14:  data = 8'b00000000; // 
             default: data=data;
         endcase
         default: data=data;
   endcase
   else data=data;

endmodule
