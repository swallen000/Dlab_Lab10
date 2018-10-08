`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:14:55 01/02/2017 
// Design Name: 
// Module Name:    frogger 
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
module frogger(
	input clk,
	input PS2_CLK,
	input PS2_DATA,
	input rst,
	input [3:0]SW,
	output reg [4:0]LED,
	output VGA_RED,
	output VGA_GREEN,
	output VGA_BLUE,
	output VGA_HSYNC,
	output VGA_VSYNC,
	output reg LCD_E,
	output reg LCD_RS,
	output reg LCD_RW,
	output reg SF_8,
	output reg SF_9,
	output reg SF_10,
	output reg SF_11
    );


	
reg current_state,next_state;
reg crazy;
reg [21:0] key_reg;
reg [10:0] key_data;
reg [3:0] key_counter;
reg [7:0]move;
reg [23:0] count;
reg flag;
wire check;

always@(posedge clk) begin
	if(rst) begin
		current_state<=0;
		next_state<=0;
	end
	else begin
		current_state<=next_state;
		next_state<=PS2_CLK;
	end
end

reg [47:0]row1;
reg [63:0]row2;
reg [15:0]score1;
reg [39:0]score2;
reg [27:0]lcd_count;
reg [5:0]code;
reg refresh;

parameter IDLE=0,PLAY=1,OVER=2,CRAZY=3,PLUGIN=4,DANGER=5;
reg [26:0] count4;
reg flag4,flag5;
reg [2:0] cstate,nstate;
reg [3:0]over;

always@(posedge clk) begin
	if(rst)
		score1<=16'b0010000000100000;
    else if(crazy)
        score1<=16'b0011111100111111;
	else begin
		if(LED>9) begin
			score1[15:8]<=8'h31;
            case(LED)
                10:  score1[7:0]<=8'h30;
                11:  score1[7:0]<=8'h31;
                12:  score1[7:0]<=8'h32;
                13:  score1[7:0]<=8'h33;
                14:  score1[7:0]<=8'h34;
                15:  score1[7:0]<=8'h35;
                default:    score1<=score1;
            endcase
		end
        else begin
            score1[15:8]<=8'h30;
            case(LED)
                0:  score1[7:0]<=8'h30;
                1:  score1[7:0]<=8'h31;
                2:  score1[7:0]<=8'h32;
                3:  score1[7:0]<=8'h33;
                4:  score1[7:0]<=8'h34;
                5:  score1[7:0]<=8'h35;
                6:  score1[7:0]<=8'h36;
                7:  score1[7:0]<=8'h37;
                8:  score1[7:0]<=8'h38;
                9:  score1[7:0]<=8'h39;
                default:    score1<=score1;
            endcase
        end
	end
end

always@(posedge clk) begin
	if(rst)
		row1<=48'b010011000110010101110110011001010110110000111010;
	else row1<=row1;
end

always@(posedge clk) begin
	if(rst)
		row2<=64'b0010000000100000001000000010000000100000001000000010000000100000;
	else if(cstate==OVER)
		row2<=64'b0101100101101111011101010010000001000100011010010110010100100001;
	else if(crazy)
		row2<=64'b0100010001000001010011100100011101000101010100100010000100100001;
	else
		row2<=64'b0010000000100000001000000010000000100000001000000010000000100000;
end

always@(posedge clk)begin
  if(rst) begin
    code<=0;
    lcd_count<=0;
  end 
  else begin
    lcd_count<=lcd_count+1;
    case(lcd_count[27:18])
      0:  code<=6'h03;
      1:  code<=6'h03;
      2:  code<=6'h03;
      3:  code<=6'h02;
      ////// initial
      4:  code<=6'b000010;
      5:  code<=6'b001000;
      ///// function
      6:  code<=6'b000000;
      7:  code<=6'b000110;
      ///// entry
      8:  code<=6'b000000;
      9:  code<=6'b001100;
      ///// display
     10:  code<=6'b000000;
     11:  code<=6'b000001;
	 12:  code<=32+row1[47:44];
	 13:  code<=32+row1[43:40];
	 14:  code<=32+row1[39:36];
	 15:  code<=32+row1[35:32];
	 16:  code<=32+row1[31:28];
	 17:  code<=32+row1[27:24];
	 18:  code<=32+row1[23:20];
	 19:  code<=32+row1[19:16];
	 20:  code<=32+row1[15:12];
	 21:  code<=32+row1[11:8];
	 22:  code<=32+row1[7:4];
	 23:  code<=32+row1[3:0];
	 24:  code<=32+score1[15:12];
	 25:  code<=32+score1[11:8];
	 26:  code<=32+score1[7:4];
	 27:  code<=32+score1[3:0];
	 28:  code<=6'b001100;
     29:  code<=6'b000000;
     30:  code<=32+row2[63:60];
     31:  code<=32+row2[59:56];
     32:  code<=32+row2[55:52];
     33:  code<=32+row2[51:48];
	 34:  code<=32+row2[47:44];
	 35:  code<=32+row2[43:40];
	 36:  code<=32+row2[39:36];
	 37:  code<=32+row2[35:32];
	 38:  code<=32+row2[31:28];
	 39:  code<=32+row2[27:24];
	 40:  code<=32+row2[23:20];
	 41:  code<=32+row2[19:16];
	 42:  code<=32+row2[15:12];
	 43:  code<=32+row2[11:8];
	 44:  code<=32+row2[7:4];
	 45:  code<=32+row2[3:0];
     46:  code<=6'b001000;
     47:  code<=6'b000000;
     /*22:  code<=
     23:  code<=
     24:  code<=
     25:  code<=
     26:  code<=*/
     default:
          lcd_count<=28'b0000001100000000000000000000; 
    endcase
    refresh<=lcd_count[17];
    {LCD_E,LCD_RS,LCD_RW,SF_11,SF_10,SF_9,SF_8}={refresh,code};
  end
end

always@(posedge clk) begin
	if(rst)
		key_reg<=0;
	else begin
		case({current_state,next_state})
			2'b10: key_reg <= {PS2_DATA, key_reg[21:1]};
            default: key_reg <= key_reg; 
		endcase
	end
end

assign check = key_reg[1]^key_reg[2]^key_reg[3]^key_reg[4]^key_reg[5]^key_reg[6]^key_reg[7]^key_reg[8]^key_reg[9];

always@(posedge clk) begin
	if(rst)
		key_counter<=0;
	else if(PS2_CLK)
		key_counter<= (key_counter<11)? key_counter+1:0;
	else 
		key_counter<=key_counter;
end

always@(posedge clk) begin
	if(rst)
		count4<=0;
	else if(cstate==IDLE) begin
		if(count4<=50000000)
			count4<=count4+1;
		else
			count4<=count4;
	end
	else if(cstate==DANGER) begin
		if(count4<=100000000)
			count4<=count4+1;
		else
			count4<=count4;
	end
	else
		count4<=0;
end

always@(posedge clk) begin
	if(rst)
		flag5<=0;
	else if(cstate==DANGER)
		flag5<=(count4>=100000000)?1:0;
	else
		flag5<=0;
end

always@(posedge clk) begin
	if(rst)
		flag4<=0;
	else if(cstate==IDLE)
		flag4<=(count4>=50000000)?1:0;
	else
		flag4<=0;
end

always@(posedge clk) begin
	if(rst)
		cstate<=0;
	else
		cstate<=nstate;
end

always@(*) begin
	case(cstate)
        IDLE:begin
            if(flag4)
				nstate<=PLAY;
			else
				nstate<=IDLE;
        end
		PLAY:begin
			if(over==1)
				nstate<=OVER;
            else if(over==2)
                nstate<=IDLE;
            else if(key_data==8'h76)
                nstate<=DANGER;
            else if(key_data==8'h01)
                nstate<=PLUGIN;
			else
				nstate<=PLAY;
		end
		OVER:begin
			if(key_data==8'h14)
				nstate<=PLAY;
			else
				nstate<=OVER;
		end
        CRAZY: begin
            if(over==1)
                nstate<=OVER;
            else if(over==2)
                nstate<=IDLE;
            else if(key_data==8'h01)
                nstate<=PLUGIN;
            else
                nstate<=CRAZY;
        end
        PLUGIN: begin
            if(over==1)
                nstate<=OVER;
            else if(over==2)
                nstate<=IDLE;
            else
                nstate<=PLUGIN;
        end
		DANGER: begin
			if(flag5)
				nstate<=CRAZY;
			else
				nstate<=DANGER;
		end
		default:nstate<=0;
	endcase
end

always @(posedge clk) begin
    if(rst||cstate==IDLE) 
		key_data <= 0;
    else if(key_counter == 4'd11 && check == 1) begin
        if(key_reg[11:1] == 11'hXX) 
			key_data <= 8'd0;
		else if(key_reg[8:1]==8'hf0)
			key_data<=0;
        else 
			key_data <= key_reg[19:12];
    end
    else 
		key_data <= key_data;
end


always@(posedge clk) begin
	if(rst||cstate==IDLE)
		move<=0;
	else begin
		case(key_data)
			8'h75:	move<=1;
			8'h72:	move<=2;
			8'h6b:	move<=3;
			8'h74:	move<=4;
			default:move<=0;
		endcase
	end
end

always@(posedge clk) begin
	if(rst||key_data==8'hf0)
		LED<=SW;
	else begin
		LED<=SW;
	end
end

reg [2:0]color;
wire visible;
reg [10:0]col,row;
assign {VGA_RED,VGA_GREEN,VGA_BLUE}=color;
always@(posedge clk) begin
	if(rst)	col<=0;
	else if(col==1039)	col<=0;
	else	col<=col+1;
end

always@(posedge clk) begin
	if(rst)	row<=0;
	else if(row==665)	row<=0;
	else if(col==1039)	row<=row+1;
	else	row<=row;
end
//>=919 <1039
assign VGA_HSYNC = ~((col>=919)&(col<1039));
assign VGA_VSYNC = ~((row>=659)&row<665);
assign visible	= ((col>=104)&(col<904)&(row>=23)&(row<623));

reg frog;

always@(posedge clk) begin
	if(rst)
		count<=0;
	/*else begin
		if(count==6000000)
			count<=0;
		else
			count<=count+1;
	end*/
    else if(crazy) begin
        if(count==100000)
            count<=0;
        else
            count<=count+1;
    end
	else begin
		case(LED)
			0: begin
				if(count==6000000)
					count<=0;
				else
					count<=count+1;
			end
			1: begin
				if(count==5500000)
					count<=0;
				else
					count<=count+1;
			end
			2: begin
				if(count==5000000)
					count<=0;
				else
					count<=count+1;
			end
			3: begin
				if(count==4500000)
					count<=0;
				else
					count<=count+1;
			end
			4: begin
				if(count==4000000)
					count<=0;
				else
					count<=count+1;
			end
			5: begin
				if(count==3500000)
					count<=0;
				else
					count<=count+1;
			end
			6: begin
				if(count==3000000)
					count<=0;
				else
					count<=count+1;
			end
			7: begin
				if(count==2500000)
					count<=0;
				else
					count<=count+1;
			end
			8: begin
				if(count==2000000)
					count<=0;
				else
					count<=count+1;
			end
			9: begin
				if(count==1500000)
					count<=0;
				else
					count<=count+1;
			end
			10: begin
				if(count==1000000)
					count<=0;
				else
					count<=count+1;
			end
			11: begin
				if(count==850000)
					count<=0;
				else
					count<=count+1;
			end
			12: begin
				if(count==700000)
					count<=0;
				else
					count<=count+1;
			end
			13: begin
				if(count==550000)
					count<=0;
				else
					count<=count+1;
			end
			14: begin
				if(count==400000)
					count<=0;
				else
					count<=count+1;
			end
			15: begin
				if(count==250000)
					count<=0;
				else
					count<=count+1;
			end
		endcase
	end
end

reg flag2;
reg [25:0]count2;
reg [26:0]count3;
reg flag3;
always@(posedge clk) begin
    if(rst)
        count3<=0;
    else
        count3<=count3+1;
end

always@(posedge clk) begin
    if(rst)
        flag3<=0;
    else
        flag3<=count3[25];
end

always@(posedge clk) begin
	if(rst)
		count2<=0;
	else begin
		if(count2==2000000)
			count2<=0;
		else
			count2<=count2+1;
	end
end

always@(posedge clk) begin
	if(rst)
		flag2<=0;
	else begin
		if(count2==0)
			flag2<=!flag2;
		else
			flag2<=flag2;
	end
end

always@(posedge clk) begin
	if(rst)
		flag<=0;
	else begin
		if(count==0)
			flag<=!flag;
		else
			flag<=flag;
	end
end


reg signed [10:0]a,b,c,d,e,f,g,h;
reg [23:0]sec_count;
reg signed [10:0] x,y,z,w;
reg f1;
wire signed [11:0] car1_s,car1_e,car2_s,car2_e,car3_s,car3_e,car4_s,car4_e;
wire signed [11:0] t_s,t_e;
wire  red_car_1,red_car_2,yellow_car_1,yellow_car_2;
wire  white_train,last;
wire leaf1,leaf2,leaf3,leaf4,leaf5,leaf6,leaf7;
wire frog_1;
wire signed [10:0]x1,y1;
//assign frog_1=frog;
assign x1=x+w+z;
assign y1=y;
assign white_train=(500+h>0)?(((row>290&&row<=350)&&(col>500+h&&col<=750+h))):(750+h>0)?(((row>290&&row<=350)&&(col>0&&col<=750+h))):((row>290&&row<=350)&&(col>0&&col<=80));
assign leaf1=(((row-160)*(row-160)+(col+b-200)*(col+b-200))<=900)?1:0;
assign leaf2=(((row-160)*(row-160)+(col+a-260)*(col+a-260))<=900)?1:0;
assign leaf3=(((row-160)*(row-160)+(col+c-650)*(col+c-650))<=900)?1:0;
assign leaf4=(((row-160)*(row-160)+(col+d-710)*(col+d-710))<=900)?1:0;
assign leaf5=(((row-240)*(row-240)+(col+e-500)*(col+e-500))<=900)?1:0;
assign leaf6=(((row-240)*(row-240)+(col+f-560)*(col+f-560))<=900)?1:0;
assign leaf7=(((row-240)*(row-240)+(col+g-620)*(col+g-620))<=900)?1:0;

always@(posedge flag) begin
	if(key_data==8'h14)
		a<=0;
	else begin
		if(a<-670)
			a<=170;
		else
			a<=a-10;
	end
end

always@(posedge flag) begin
	if(key_data==8'h14)
		b<=0;
	else begin
		if(b<-730)
			b<=110;
		else
			b<=b-10;
	end
end

always@(posedge flag) begin
	if(key_data==8'h14)
		c<=0;
	else begin
		if(c<-280)
			c<=560;
		else
			c<=c-10;
	end
end

always@(posedge flag) begin
	if(key_data==8'h14)
		d<=0;
	else begin
		if(d<-220)
			d<=620;
		else
			d<=d-10;
	end
end

always@(posedge flag) begin
	if(key_data==8'h14)
		e<=0;
	else begin
		if(e>410)
			e<=-430;
		else
			e<=e+10;
	end
end

always@(posedge flag) begin
	if(key_data==8'h14)
		f<=0;
	else begin
		if(f>470)
			f<=-370;
		else
			f<=f+10;
	end
end

always@(posedge flag) begin
	if(key_data==8'h14)
		g<=0;
	else begin
		if(g>530)
			g<=-310;
		else
			g<=g+10;
	end
end

always@(posedge flag) begin
	if(key_data==8'h14)
		h<=0;
	else begin
		if(h>400)
			h<=-900;
		else
			h<=h+15;
	end
end

wire danger;

cars car(.red_car1(red_car1),.red_car2(red_car2),.yellow_car1(yellow_car1),.yellow_car2(yellow_car2),.car1_s(car1_s),.car1_e(car1_e),.car2_s(car2_s),.car2_e(car2_e),.car3_s(car3_s),.car3_e(car3_e),.car4_s(car4_s),.car4_e(car4_e),.sec_count(sec_count),.clk(clk),.rst(rst),.col(col),.row(row));
//train train(.white_train(white_train),.t_s(t_s),.t_e(t_e),.sec_count(sec_count),.clk(clk),.rst(rst),.col(col),.row(row));
word word(.gameover(gameover),.clk(clk),.rst(rst),.col(col),.row(row));
skull skull(.clk(clk),.rst(rst),.col(col),.row(row),.danger(danger));
frog_mona mona(.clk(clk),.rst(rst),.row(row),.col(col),.fro(frog_1),.frog_s(x1),.frog_e(x1+64),.frog_up(y1),.frog_down(y1+64));

always@(posedge flag2) begin
	if(key_data==8'h14||cstate==IDLE) begin
		x<=840;
		y<=530;
	end
	else if(cstate==PLUGIN) begin
		case(move)
				1: begin
					x<=x;
					if(y>=130)
						y<=y-80;
				end
				2: begin
					x<=x;
					if(y<=450)
						y<=y+80;
				end
				3: begin
					if(x>=150)
						x<=x-30;
					y<=y;
				end
				4: begin
					if(x<=810)
						x<=x+30;
					y<=y;
				end
				default: begin
					x<=x;
					y<=y;
				end
			endcase
	end
	else if(cstate==PLAY||cstate==CRAZY)begin
		begin
			case(move)
				1: begin
					x<=x;
					if(y>=130)
						y<=y-80;
				end
				2: begin
					x<=x;
					if(y<=450)
						y<=y+80;
				end
				3: begin
					if(x+z+w>=150)
						x<=x-30;
					y<=y;
				end
				4: begin
					if(x+z+w<=810)
						x<=x+30;
					y<=y;
				end
				default: begin
					x<=x;
					y<=y;
				end
			endcase

		end
	end
end

always@(posedge flag) begin
	if(key_data==8'h14||cstate==IDLE||cstate==PLUGIN)
		z<=0;
	else if((y==130&&((x+w+z+60>200-b-30))&&((x+w+z<260-a+30))))begin
		if(x+z+w>900)
			z<=60-x-w;
		else
			z<=z+10;
	end
	else if(y==130&&((x+z+w+60>650-c-30))&&((x+z+w<710-d+30))) begin
		if(x+w+z>900)
			z<=60-x-w;
		else
			z<=z+10;
	end
	else
		z<=z;
end

always@(posedge flag) begin
	if(key_data==8'h14||cstate==IDLE||cstate==PLUGIN)
		w<=0;
	else if(y==210&&((x+w+z+60>500-e-30)&&(x+w+z<620-g+30))) begin
		if(x+w+z<100)
            w<=900-x-z;
        else
            w<=w-10;
	end
	else
		w<=w;
end


always@(posedge clk) begin

	if(key_data==8'h14||cstate==IDLE) begin
		frog<=((row>530&row<=590)&(col>840&col<=900));
		over<=0;
	end
    else if(cstate==PLUGIN) begin
        if(y==50&&x>=60&&x<=180) begin
            frog<=((row>530&row<=590)&(col>840&col<=900));
            over<=2;
		end
        else begin
            frog<=((row>y&row<=y+60)&(col>x&col<=60+x));
			over<=over;
        end     
    end
	else if(cstate==PLAY||cstate==CRAZY)begin
		if(y==50&&x+z+w>=60&&x+z+w<=180) begin
            frog<=((row>530&row<=590)&(col>840&col<=900));
            over<=2;
		end
		else if(y==130) begin
			if(x+z+w+60>909||x+w+z<104) begin
				frog<=((row>530&row<=590)&(col>840&col<=900));
				over<=1;
			end
			else if(x+w+z+60>200-b-30&&x+w+z<260-a+30)begin
				frog<=((row>y&row<=y+60)&(col>x+z+w&col<=60+x+z+w));
				over<=over;
			end
			else if(x+w+z+60>650-c-30&&x+w+z<710-d+30)begin
				frog<=((row>y&row<=y+60)&(col>x+z+w&col<=60+x+z+w));
				over<=over;
			end
			else begin
				frog<=((row>530&row<=590)&(col>840&col<=900));
				over<=1;
			end
		end
		else if(y==210) begin
			if(x+w+z+60>909||x+w+z<104) begin
				frog<=((row>530&row<=590)&(col>840&col<=900));
				over<=1;
			end
			else if(x+w+z+60>500-e-30&&x+w+z<620-g+30)
				frog<=((row>y&row<=y+60)&(col>x+w+z&col<=60+x+w+z));
			else begin
				frog<=((row>530&row<=590)&(col>840&col<=900));
				over<=1;
			end
		end
		else if(y==450&&((x+z+w+60>car1_s&x+z+w<car1_e)||(x+w+z+60>car2_s&&x+w+z<car2_e))) begin
			frog<=((row>530&row<=590)&(col>840&col<=900));
			over<=1;
		end
		else if(y==370&&((x+z+w+60>car3_s&x+w+z<car3_e)||(x+w+z+60>car4_s&x+w+z<car4_e))) begin
			frog<=((row>530&row<=590)&(col>840&col<=900));
			over<=1;
		end
		else if(y==290&&(x+z+w+60>500+h&x+z+w<750+h)) begin
			frog<=((row>530&row<=590)&(col>840&col<=900));
			over<=1;
		end
		else begin
			frog<=((row>y&row<=y+60)&(col>x+z+w&col<=60+x+z+w));
			over<=over;
		end
	end
end

//assign cube=((row>120+y&row<=180+y)&(col>240+x&col<=300+x));
/*assign bridge=((row>240&row<=300)&(col>300+a&col<=380+a));
assign death=((row>310&row<=370)&(col>240-a&col<=300-a));*/


wire ground,road,river,line,rail,rail2,cave2;
reg cave;
assign road=(row<=600&row>360&col>104&col<=904);
assign ground=(((row>280&row<=360)||(row>40&row<=120))&(col>104&col<=904));
assign river=(row>120&row<=280&col>104&col<=904);
assign line=((row>118&row<=122)||(row>518&row<=522)||(row>438&row<=442)||(row>358&row<=362)||(row>278&row<=282));	//358-362     278-282
assign rail=((row>303&row<=307)||(row>333&row<=337));
assign rail2=((row>295&row<345));
assign cave2=(row<=120)?(((((120-row)*(120-row)+(180-col)*(180-col))>=3600)&(((120-row)*(120-row)+(180-col)*(180-col))<=3900))?1:0):0;
always@(posedge clk) begin
	if(rst)
		cave<=0;
	else if(row<=120)
		cave<=(((120-row)*(120-row)+(180-col)*(180-col))<=3600)?1:0;
	else 
		cave<=cave;
end


always@(posedge clk or posedge rst) begin
  if(rst)
    sec_count=0;
    else if(crazy) begin
        if(sec_count==599999)
            sec_count=0;
        else
            sec_count=sec_count+1;
    end
  /*else if(sec_count==19999999)
    sec_count=0;
  else
    sec_count=sec_count+1;*/
	else begin
		case(LED)
			0:	begin
				if(sec_count==19999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			1:	begin
				if(sec_count==18999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			2:	begin
				if(sec_count==17999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			3:	begin
				if(sec_count==16999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			4:	begin
				if(sec_count==15999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			5:	begin
				if(sec_count==14999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			6:	begin
				if(sec_count==13999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			7:	begin
				if(sec_count==12999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			8:	begin
				if(sec_count==10999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			9:	begin
				if(sec_count==8999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			10:	begin
				if(sec_count==69999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			11:	begin
				if(sec_count==4999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			12:	begin
				if(sec_count==3999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			13:	begin
				if(sec_count==2999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			14:	begin
				if(sec_count==1999999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
			15:	begin
				if(sec_count==1599999)
					sec_count=0;
				else
					sec_count=sec_count+1;
			end
		endcase
	end
end

always@(posedge clk) begin
    if(rst||cstate==IDLE||cstate==OVER) 
        crazy<=0;
    else if(key_data==8'h76)
        crazy<=1;
    else
        crazy<=crazy;
end

always@(posedge clk) begin
    if(rst)
        f1<=0;
    else begin
        f1<=count3[24];
    end
end

always@(posedge clk) begin
	if(rst)
		color<=0;    
	else if(visible) begin
        if(cstate==OVER) begin
          if(gameover)
            color<=3'b111;
          else
            color<=3'b000;
        end
		else if(cstate==DANGER) begin
			if(danger)
				color<=3'b111;
			else
				color<=0;
		end
        else if(cstate==PLUGIN) begin
            if(frog_1) begin
                if(f1)
                    color<=(flag3)?3'b101:3'b111;
                else 
                    color<=(flag3)?3'b011:3'b110;
            end
            else if(line) begin
				if(((row>358&&row<=362)||(row>278&&row<=282))&&h<-640) begin
					if(flag)
						color<=3'b100;
					else
						color<=3'b111;
				end	
				else
					color<=3'b111;
			end
            else if(red_car1||red_car2)
                color<=3'b100;          
            else if(yellow_car1||yellow_car2)
                color<=3'b110;
			else if(white_train)
				color<=3'b111;
            /*else if(row>290&&row<=350&&col>500+h&&col<=750+h) begin
				if(white_train)
					color<=3'b111;
				else if(col>t_s&&col<=t_e)
					color<=3'b110;
				else
					color<=color;
			end*/
            else if(leaf1||leaf2||leaf3||leaf4||leaf5||leaf6||leaf7) 
                color<=3'b010;
            else if(cave)
                color<=0;
            else if(cave2)
                color<=3'b110;
            else if(rail)
                color<=0;
            else if(rail2) begin
                if((col>110&col<114)||(col>140&col<144)||(col>170&col<174)||(col>200&col<204)||(col>230&col<234)||(col>260&col<264)||(col>290&col<294)||(col>320&col<324)||(col>350&col<354)||(col>380&col<384)||(col>410&col<414)||(col>440&col<444)||(col>470&col<474)||(col>500&col<504)||(col>530&col<534))
                    color<=0;
                else if((col>560&col<564)||(col>590&col<594)||(col>620&col<624)||(col>650&col<654)||(col>680&col<684)||(col>710&col<714)||(col>740&col<744)||(col>770&col<774)||(col>800&col<804)||(col>830&col<834)||(col>860&col<864)||(col>890&col<894))
                    color<=0;
                else
                    color<=3'b010;
            end		
            else if(road) begin
                if(row>450&&row<=510) begin
                    if((col>car1_s&&col<=car1_e)||(col>car2_s&&col<=car2_e)) begin
                        if((col<=car1_e-10&&col>car1_s)||(col<=car2_e-10&&col>car2_s)) begin   
                            color<=(flag3==1)?3'b110:3'b000;
                        end
                        else begin
                            if(row>460&&row<=500) begin
                                if(flag)
                                    color<=3'b110;
                                else
                                    color<=0;
                            end
                            else
                                color<=0;
                        end
                    end
                    else begin
                        if((row%2)^(col%2))
							color<=3'b111;
						else
							color<=0;
					end
                end
                else if(row>370&&row<=430) begin
                    if((col>car3_s&&col<=car3_e)||(col>car4_s&&col<=car4_e)) begin
                        if((col>car3_s+10&&col<=car3_e)||(col>car4_s+10&&col<=car4_e))
                            color<=(flag3==1)?3'b100:0;
                        else begin
                            if(row>380&&row<=420) begin
                                if(flag)
                                    color<=3'b100;
                                else
                                    color<=0;
                            end
                            else
                                color<=0;
                        end
                    end
                    else begin
                        if((row%2)^(col%2))
							color<=3'b111;
						else
							color<=0;
					end
                end
                else begin
                        if((row%2)^(col%2))
							color<=3'b111;
						else
							color<=0;
				end
            end
            else if(ground)
                color<=3'b010;
            else if(river)
                color<=3'b001;
            else 
                color<=3'b011;
        end
        else begin
            if(line) begin
                if(((row>358&&row<=362)||(row>278&&row<=282))&&h<-640) begin
					if(flag)
						color<=3'b100;
					else
						color<=3'b111;				
				end
				else
					color<=3'b111;
			end
            else if(red_car1||red_car2)
                color<=3'b100;          
            else if(yellow_car1||yellow_car2)
                color<=3'b110;
			else if(white_train)
				color<=3'b111;
            /*else if(row>290&&row<=350&&col>500+h&&col<=750+h) begin
				if(white_train)
					color<=3'b111;
				else if(col>t_s&&col<=t_e)
					color<=3'b110;
				else
					color<=color;
			end*/
            else if(frog_1)
                color<=(3'b110+3'b100)/2;
            else if(leaf1||leaf2||leaf3||leaf4||leaf5||leaf6||leaf7) 
                color<=3'b010;
            else if(cave)
                color<=0;
            else if(cave2)
                color<=3'b110;
            else if(rail)
                color<=0;
            else if(rail2) begin
                if((col>110&col<114)||(col>140&col<144)||(col>170&col<174)||(col>200&col<204)||(col>230&col<234)||(col>260&col<264)||(col>290&col<294)||(col>320&col<324)||(col>350&col<354)||(col>380&col<384)||(col>410&col<414)||(col>440&col<444)||(col>470&col<474)||(col>500&col<504)||(col>530&col<534))
                    color<=0;
                else if((col>560&col<564)||(col>590&col<594)||(col>620&col<624)||(col>650&col<654)||(col>680&col<684)||(col>710&col<714)||(col>740&col<744)||(col>770&col<774)||(col>800&col<804)||(col>830&col<834)||(col>860&col<864)||(col>890&col<894))
                    color<=0;
                else
                    color<=3'b010;
            end		
            else if(road) begin
                if(row>450&&row<=510) begin
                    if((col>car1_s&&col<=car1_e)||(col>car2_s&&col<=car2_e)) begin
                        if((col<=car1_e-10&&col>car1_s)||(col<=car2_e-10&&col>car2_s)) begin   
                            color<=(flag3==1)?3'b110:3'b000;
                        end
                        else begin
                            if(row>460&&row<=500) begin
                                if(flag)
                                    color<=3'b110;
                                else
                                    color<=0;
                            end
                            else
                                color<=0;
                        end
                    end
                    else begin
                        if((row%2)^(col%2))
							color<=3'b111;
						else
							color<=0;
					end
                end
                else if(row>370&&row<=430) begin
                    if((col>car3_s&&col<=car3_e)||(col>car4_s&&col<=car4_e)) begin
                        if((col>car3_s+10&&col<=car3_e)||(col>car4_s+10&&col<=car4_e))
                            color<=(flag3==1)?3'b100:0;
                        else begin
                            if(row>380&&row<=420) begin
                                if(flag)
                                    color<=3'b100;
                                else
                                    color<=0;
                            end
                            else
                                color<=0;
                        end
                    end
                    else begin
                        if((row%2)^(col%2))
							color<=3'b111;
						else
							color<=0;
					end
                end
                else begin
                    if((row%2)^(col%2))
						color<=3'b111;
					else
						color<=0;
				end
            end
            else if(ground)
                color<=3'b010;
            else if(river)
                color<=3'b001;
            else 
                color<=3'b011;
        end
    end
	else
		color<=0;
end
endmodule
