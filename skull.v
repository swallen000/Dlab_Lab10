`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:45:45 01/05/2017 
// Design Name: 
// Module Name:    skull 
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
module skull(
	input clk,
	input rst,
	input [10:0]col,
	input [10:0]row,
	output danger
    );

reg [10:0]row_count;
reg [10:0]col_count;
reg [41:0]sk;

assign danger=(row>=210&&row<=460&&col>=294&&col<714)?sk[col_count]:0;

always@(posedge clk) begin
	if(rst)
		col_count<=0;
	else begin
		case(col)
			294: col_count<=41;
			304: col_count<=40;
			314: col_count<=39;
			324: col_count<=38;
			334: col_count<=37;
			344: col_count<=36;
			354: col_count<=35;
			364: col_count<=34;
			374: col_count<=33;
			384: col_count<=32;
			394: col_count<=31;
			404: col_count<=30;
			414: col_count<=29;
			424: col_count<=28;
			434: col_count<=27;
			444: col_count<=26;
			454: col_count<=25;
			464: col_count<=24;
			474: col_count<=23;
			484: col_count<=22;
			494: col_count<=21;
			504: col_count<=20;
			514: col_count<=19;
			524: col_count<=18;
			534: col_count<=17;
			544: col_count<=16;
			554: col_count<=15;
			564: col_count<=14;
			574: col_count<=13;
			584: col_count<=12;
			594: col_count<=11;
			604: col_count<=10;
			614: col_count<=9;
			624: col_count<=8;
			634: col_count<=7;
			644: col_count<=6;
			654: col_count<=5;
			664: col_count<=4;
			674: col_count<=3;
			684: col_count<=2;
			694: col_count<=1;
			704: col_count<=0;
			default:col_count<=col_count;
		endcase
	end
end

always@(posedge clk) begin
	if(rst)
		row_count<=0;
	else begin
		case(row)
			210:	row_count<=0;
			220:	row_count<=1;
			230:	row_count<=2;
			240:	row_count<=3;
			250:	row_count<=4;
			260:	row_count<=5;
			270:	row_count<=6;
			280:	row_count<=7;
			290:	row_count<=8;
			300:	row_count<=9;
			310:	row_count<=10;
			320:	row_count<=11;
			330:	row_count<=12;
			340:	row_count<=13;
			350:	row_count<=14;
			360:	row_count<=15;
			370:	row_count<=16;
			380:	row_count<=17;
			390:	row_count<=18;
			400:	row_count<=19;
			410:	row_count<=20;
			420:	row_count<=21;
			430:	row_count<=22;
			440:	row_count<=23;
			450:	row_count<=24;
			460:	row_count<=25;
			default:row_count<=row_count;
		endcase
	end
end

always@(posedge clk) begin
	if(rst)
		sk<=0;
	else if(row>=210&&row<=460) begin
		case(col)
			294:
			case (row_count)
				0:	sk<=42'b000000000000000011111110000000000000000000;
				1:	sk<=42'b000000000000011111111111111100000000000000;
				2:	sk<=42'b000000000011111111111111111111100000000000;
				3:	sk<=42'b000000000111111111111111111111110000000000;
				4:	sk<=42'b000000001111111111111111111111111000000000;
				5:	sk<=42'b000000011111111111111111111111111100000000;
				6:	sk<=42'b000000011111111111111111111111111100000000;
				7:	sk<=42'b000000011111110001111100011111111100000000;
				8:	sk<=42'b000000011111100000011100000001111100000000;
				9:	sk<=42'b000000001111000000011100000001111000000000;
				10:	sk<=42'b000000001111000000111110000001111000000000;
				11:	sk<=42'b000000000111111111100011111111110000000000;
				12:	sk<=42'b000000000011111111100011111111100000000000;
				13:	sk<=42'b000000000000111111111111111110000000000000;
				14:	sk<=42'b000000000000011111111111111100000000000000;
				15:	sk<=42'b001110000000011110101010111100000001110000;
				16:	sk<=42'b011111000000001111111111111000000011111000;
				17:	sk<=42'b001111111000000111111111110000011111111000;
				18:	sk<=42'b111111111111110000111110000111111111111110;
				19:	sk<=42'b111111111111111111110001111111111111111110;
				20:	sk<=42'b011100000011111111111111101111110000000000;
				21:	sk<=42'b000000000001111011111111111111100000000000;
				22:	sk<=42'b001111111111111111110111111111111111111100;
				23:	sk<=42'b001111111111111100000000000111111111111110;
				24:	sk<=42'b000111111100000000000000000000001111111100;
				25:	sk<=42'b000001111000000000000000000000000011111000;
				default:sk<=sk;
			endcase         
			default:sk<=sk;           
		endcase             
	end                     
	else                    
		sk<=sk;
end
//42*26




endmodule
