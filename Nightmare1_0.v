// Third party-code:
// 1. the fill module is provided by the teaching team. It is the same module used in lab7
// 2. hexdecoder
// 3. Quartus memory module and PLL module


//Third-party code
module fill
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		KEY,							// On Board Keys
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,   						//	VGA Blue[9:0]
		SW,
		HEX4,
		HEX3,
		HEX2
		
	);

	input			CLOCK_50;				//	50 MHz
	input	[3:0]	KEY;	
	input [9:7] SW;
	output [6:0] HEX4, HEX3, HEX2;
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;
	

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(1'b1),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	final u1000(.Clock(CLOCK_50),.butt1(!KEY[1]),.butt2(!KEY[2]),.swit1(SW[9]),.swit2(SW[8]),.swit3(SW[7]),.ox(x),.oy(y),.ocolor(colour),.reset(KEY[0]),.HEX4(HEX4),.HEX3(HEX3),.HEX2(HEX2));
	
			
	
endmodule

module final(Clock, butt1, butt2, swit1, swit2, swit3,ox,oy,ocolor,reset,HEX4,HEX3,HEX2);

	input Clock;
	input butt1;
	input butt2;
	input swit1;
	input swit2;
	input swit3;
	input reset;
	output [6:0] HEX4;
	output [6:0] HEX3;
	output [6:0] HEX2;
	output reg[7:0] ox;
	output reg[7:0] oy;
	output reg[2:0] ocolor;

	wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w70,w71,w72,w73,w74,w75,w76,w77,w78,w90,w91,w92,w93,w94,w95,w96,w97,w98;
	wire [7:0] w24,w25,w26,w27,w29,w30,w31,w32;
	wire [2:0] w40,w41,w42,w43,w45,w46,w47,w48;
	wire [3:0] wx,wy;
	wire [7:0] w100;
	wire [7:0] w101;
	wire [2:0] w102;
	wire [3:0] displaywire;
	wire newclock;
	
	
	drawingfinite u99(.reset(reset),.Clock(Clock),.num1done(w70),.num2done(w71),.num3done(w72),.num4done(w73),.num5done(w74),.num6done(w75),.num7done(w76),.num8done(w77),.num9done(w78),.startnum1(w90),.startnum2(w91),.startnum3(w92),.startnum4(w93),.startnum5(w94),.startnum6(w95),.startnum7(w96),.startnum8(w97),.startnum9(w98));
	passinvga u55(.reset(reset),.Clock(Clock),.num1loc(w24),.num2loc(w25),.num3loc(w26),.num4loc(w27),.num5loc({{wx},{wy}}),.num6loc(w29),.num7loc(w30),.num8loc(w31),.num9loc(w32),.num1data(w40),.num2data(w41),.num3data(w42),.num4data(w43),.num5data(3'b111),.num6data(w45),.num7data(w46),.num8data(w47),.num9data(w48),.num1done(w70),.num2done(w71),.num3done(w72),.num4done(w73),.num5done(w74),.num6done(w75),.num7done(w76),.num8done(w77),.num9done(w78),.startnum1(w90),.startnum2(w91),.startnum3(w92),.startnum4(w93),.startnum5(w94),.startnum6(w95),.startnum7(w96),.startnum8(w97),.startnum9(w98),.ox(w100),.oy(w101),.ocolor(w102));
	datapath u3(.reset(reset),.Clock(Clock),.posneg(swit1),.leftright(swit2),.updown(swit3),.abombtimeup(w1),.validb(w2),.alreadyhavefourbomb(w3),.startcheckarr(w4),.wren(w6),.placebomb(w7),.left(w8),.writeleft(w9),.right(w10),.writeright(w11),.up(w12),.writeup(w13),.down(w14),.writedown(w15),.checksamecoor(w16),.destructableornot(w5),.dead(w17),.startcheckbombele(w18),.loadenable(w19),.updatecoord(w20),.won(w21),.dowesetup(w22),.setupdone(w23),.topleftaddress(w24),.topleftdata(w40),.topaddress(w25),.topdata(w41),.toprightaddress(w26),.toprightdata(w42),.leftaddress(w27),.leftdata(w43),.rightaddress(w29),.rightdata(w45),.bottomleftaddress(w30),.bottomleftdata(w46),.bottomaddress(w31),.bottomdata(w47),.bottomrightaddress(w32),.bottomrightdata(w48),.xcoord(wx),.ycoord(wy),.bombnum(displaywire));
	FNSM u2(.reset(reset),.Clock(Clock),.loadcoord(butt1),.placebombF(butt2),.abombtimeup(w1),.validb(w2),.alreadyhavefourbomb(w3),.startcheckarr(w4),.destructableornot(w5),.wren(w6),.placebomb(w7),.left(w8),.writeleft(w9),.right(w10),.writeright(w11),.up(w12),.writeup(w13),.down(w14),.writedown(w15),.checksamecoor(w16),.deadalready(w17),.startcheckbombele(w18),.loadenable(w19),.updatecoord(w20),.won(w21),.dowesetup(w22),.setupdone(w23));
	
	hex_decoder u9999 (.c(wx),.display(HEX4));
	hex_decoder u299 (.c(wy),.display(HEX3));
	hex_decoder u654(.c(displaywire),.display(HEX2));
	
	always@(*)
		begin
		ox = w100;
		oy = w101;
		ocolor = w102;
		end
	
	
endmodule







module passinvga(reset,Clock,num1loc,num2loc,num3loc,num4loc,num5loc,num6loc,num7loc,num8loc,num9loc,num1data,num2data,num3data,num4data,num5data,num6data,num7data,num8data,num9data,num1done,num2done,num3done,num4done,num5done,num6done,num7done,num8done,num9done,startnum1,startnum2,startnum3,startnum4,startnum5,startnum6,startnum7,startnum8,startnum9,ox,oy,ocolor);

input Clock;	
input [7:0] num1loc,num2loc,num3loc,num4loc,num5loc,num6loc,num7loc,num8loc,num9loc;
input [2:0] num1data,num2data,num3data,num4data,num5data,num6data,num7data,num8data,num9data;
input startnum1,startnum2,startnum3,startnum4,startnum5,startnum6,startnum7,startnum8,startnum9;
output reg num1done, num2done,num3done,num4done,num5done,num6done,num7done,num8done,num9done;
output reg[7:0] ox, oy;
output reg[2:0] ocolor;
reg [7:0] currentloc;
reg [4:0] counter;
reg [2:0] linecounter;
reg [2:0] data;
input reset;



always@(posedge Clock)
	begin
	if(reset)
		begin
	counter <= 5'b00000;
	num1done = 1'b0;
	num2done = 1'b0;
	num3done = 1'b0;
	num4done = 1'b0;
	num5done = 1'b0;
	num6done = 1'b0;
	num7done = 1'b0;
	num8done = 1'b0;
	num9done = 1'b0;
	end
	if(startnum1)
		begin
			data = num1data;
			if(counter < 5'b00001)
				begin
					counter <= counter + 1'b1;
				end
			else if(counter == 5'b00001)
				begin
					num1done = 1'b1;
					currentloc = num2loc;
					counter <= 5'b00000;
				end
		end
	if(startnum2)
		begin
			data = num2data;
			if(counter < 5'b00001)
				begin
					counter <= counter + 1'b1;
				end
			else if(counter == 5'b00001)
				begin
					num2done = 1'b1;
					currentloc = num3loc;
					counter <= 5'b00000;
				end
		end
	if(startnum3)
		begin
			data = num3data;
			if(counter < 5'b00001)
				begin
					counter <= counter + 1'b1;
				end
			else if(counter == 5'b00001)
				begin
					num3done = 1'b1;
					currentloc = num4loc;
					counter <= 5'b00000;
				end
		end
		if(startnum4)
		begin
			data = num4data;
			if(counter < 5'b00001)
				begin
					counter <= counter + 1'b1;
				end
			else if(counter == 5'b00001)
				begin
					num4done = 1'b1;
					currentloc = num5loc;
					counter <= 5'b00000;
				end
		end
		if(startnum5)
		begin
			data = num5data;
			if(counter < 5'b00001)
				begin
					counter <= counter + 1'b1;
				end
			else if(counter == 5'b00001)
				begin
					num5done = 1'b1;
					currentloc = num6loc;
					counter <= 5'b00000;
				end
		end
		if(startnum6)
		begin
			data = num6data;
			if(counter < 5'b00001)
				begin
					counter <= counter + 1'b1;
				end
			else if(counter == 5'b00001)
				begin
					num6done = 1'b1;
					currentloc = num7loc;
					counter <= 5'b00000;
				end
		end
		if(startnum7)
		begin
			data = num7data;
			if(counter < 5'b00001)
				begin
					counter <= counter + 1'b1;
				end
			else if(counter == 5'b00001)
				begin
					num7done = 1'b1;
					currentloc = num8loc;
					counter <= 5'b00000;
				end
		end
		if(startnum8)
		begin
			data = num8data;
			if(counter < 5'b00001)
				begin
					counter <= counter + 1'b1;
				end
			else if(counter == 5'b00001)
				begin
					num8done = 1'b1;
					currentloc = num9loc;
					counter <= 5'b00000;
				end
		end
		if(startnum9)
		begin
			data = num9data;
			if(counter < 5'b00001)
				begin
					counter <= counter + 1'b1;
				end
			else if(counter == 5'b00001)
				begin
					num9done = 1'b1;
					currentloc = num1loc;
					counter <= 5'b00000;
					num1done = 1'b0;
					num2done = 1'b0;
					num3done = 1'b0;
					num4done = 1'b0;
					num5done = 1'b0;
					num6done = 1'b0;
					num7done = 1'b0;
					num8done = 1'b0;
					
				end
		end
	if(data == 3'b000)
		begin
			ocolor = 3'b111;  
		end
	if(data == 3'b001)
		begin
			ocolor = 3'b010;
		end
	if(data == 3'b010)
		begin
			ocolor = 3'b000;
		end
	if(data == 3'b011)
		begin
			ocolor = 3'b100;
		end
	if(data == 3'b111)
		begin
			ocolor = 3'b010;
		end
	if(currentloc == 8'b11101110)
		begin
			ocolor = 3'b110;
		end
	
	ox = currentloc[7:4]*3;
	oy = currentloc[3:0]*3;
end

endmodule


module drawingfinite(reset, Clock,num1done,num2done,num3done,num4done,num5done,num6done,num7done,num8done,num9done,startnum1,startnum2,startnum3,startnum4,startnum5,startnum6,startnum7,startnum8,startnum9);
	input Clock;
	input num1done;
	input num2done;
	input num3done;
	input num4done;
	input num5done;
	input num6done;
	input num7done;
	input num8done;
	input num9done;
	input reset;
	reg[4:0] currentstate;
	reg[4:0] nextstate;
	
	output reg startnum1;
	output reg startnum2;
	output reg startnum3;
	output reg startnum4;
	output reg startnum5;
	output reg startnum6;
	output reg startnum7;
	output reg startnum8;
	output reg startnum9;
	
	localparam  num1= 5'd0,
					num2 = 5'd1,
					num3 = 5'd2,
					num4 = 5'd3,
					num5 = 5'd4,
					num6 = 5'd5,
					num7 = 5'd6,
					num8 = 5'd7,
					num9 = 5'd8;
					


always@(*)
	begin
		if(reset)
			begin
			nextstate = num1;
		end
		case(currentstate)
		num1:begin
			if(num1done)
				begin
					nextstate = num2;
				end
			else
				begin
					nextstate = num1;
				end
			end
		num2:begin
			if(num2done)
				begin
					nextstate = num3;
				end
			else
				begin
					nextstate = num2;
				end
			end
		num3:begin
			if(num3done)
				begin
					nextstate = num4;
				end
			else
				begin
					nextstate = num3;
				end
			end
		num4:begin
			if(num4done)
				begin
					nextstate = num5;
				end
			else
				begin
					nextstate = num4;
				end
			end
		num5:begin
			if(num5done)
				begin
					nextstate = num6;
				end
			else
				begin
					nextstate = num5;
				end
			end
		num6:begin
			if(num6done)
				begin
					nextstate = num7;
				end
			else
				begin
					nextstate = num6;
				end
			end
		num7:begin
			if(num7done)
				begin
					nextstate = num8;
				end
			else
				begin
					nextstate = num7;
				end
			end
		num8:begin
			if(num8done)
				begin
					nextstate = num9;
				end
			else
				begin
					nextstate = num8;
				end
			end
		num9:begin
			if(num9done)
				begin
					nextstate = num1;
				end
			else
				begin
					nextstate = num9;
				end
			end
		endcase
	end
	always@(*)
		begin
			startnum1 = 1'b0;
			startnum2 = 1'b0;
			startnum3 = 1'b0;
			startnum4 = 1'b0;
			startnum5 = 1'b0;
			startnum6 = 1'b0;
			startnum7 = 1'b0;
			startnum8 = 1'b0;
			startnum9 = 1'b0;
			case(currentstate)
			num1:begin
				startnum1 = 1'b1;
			end
			num2:begin
				startnum2 = 1'b1;
			end
			num3:begin
				startnum3 = 1'b1;
			end
			num4:begin
				startnum4 = 1'b1;
			end
			num5:begin
				startnum5 = 1'b1;
			end
			num6:begin
				startnum6 = 1'b1;
			end
			num7:begin
				startnum7 = 1'b1;
			end
			num8:begin
				startnum8 = 1'b1;
			end
			num9:begin
				startnum9 = 1'b1;
			end
		endcase
	end
	always@(posedge Clock)
		begin
			currentstate = nextstate;
		end
endmodule
			
			

module FNSM(reset, Clock, loadcoord, placebombF,abombtimeup,validb,alreadyhavefourbomb,destructableornot,startcheckarr,startcheckbombele, wren,placebomb,left,writeleft,right,writeright,up,writeup,down,writedown,loadenable,checksamecoor,deadalready,updatecoord,won,dowesetup,setupdone);
	input Clock;
	input loadcoord;
	input placebombF;
	input abombtimeup;
	input validb;
	input alreadyhavefourbomb;
	input deadalready;
	input destructableornot;
	input won;
	input setupdone;
	input reset;
	

	
	reg [4:0] currentstate;
	reg [4:0] nextstate;
	output reg startcheckarr;
	output reg wren;
	output reg startcheckbombele;
	output reg placebomb;
	output reg left;
	output reg writeleft;
	output reg right;
	output reg writeright;
	output reg up;
	output reg writeup;
	output reg down;
	output reg writedown;
	output reg loadenable;
	output reg checksamecoor;
	output reg updatecoord;
	output reg dowesetup;
	reg dead;
	reg [3:0] counter;
	
	

	
	localparam  puttingcoord= 10'd0,
					setupstate = 10'd1,
					checkwithread = 10'd2,
					writearrcoord = 10'd3,
					placebombread = 10'd4,
					placebombwrite = 10'd5,
					bombtimeup = 10'd6,
					checksamecoord = 10'd7,
					checkleftcoord = 10'd9,
					writeleftcoord = 10'd10,
					checkupcoord = 10'd11,
					writeupcoord = 10'd12,
					checkrightcoord = 10'd13,
					writerightcoord = 10'd14,
					checkdowncoord = 10'd15,
					writedowncoord = 10'd16,
					deadstate = 10'd17,
					winstate = 10'd18,
					waitingstate = 10'd19,
					placebombwait = 10'd20;
					
					
	
	
	always@(*)
		begin
			if(reset)
				begin
				nextstate = setupstate;
				counter = 4'b0000;
			end
			case(currentstate)
				setupstate: begin
					if(setupdone)
						begin
							nextstate = puttingcoord;
						end
					else
						begin
							nextstate = setupstate;
						end
					end
				puttingcoord: begin
					if(abombtimeup)
						begin
							nextstate = bombtimeup;
						end
		
					else if(loadcoord)
						begin
							nextstate = waitingstate;
						end
					else if(placebombF)
						begin
							nextstate = placebombwait;
						end
					else
						begin
							nextstate = puttingcoord;
					end	
				end
				
				waitingstate:begin
					if(!loadcoord)
						begin
							nextstate = checkwithread;
						end
					else begin
						nextstate = waitingstate;
					end
				end
						
				checkwithread: begin
					if(validb)
						begin
							nextstate = writearrcoord;
						end
					else 
						begin
							nextstate = puttingcoord;
						end
					end
					
				writearrcoord:begin
					if(won)
							begin
								nextstate = winstate;
							end
					else
						begin
						nextstate = puttingcoord;
						end
					end
				placebombwait:begin
					if(!placebombF)
						begin
							nextstate = placebombread;
						end
					else begin
						nextstate = placebombwait;
					end
				end
				
				placebombread: begin
						if(alreadyhavefourbomb)
							begin
								nextstate = puttingcoord;
							end
						else
							begin
								nextstate = placebombwrite;
							end
					end
					
					
				placebombwrite:begin
						nextstate = puttingcoord;
					end
					
					
					
					
				bombtimeup: begin
						nextstate = checksamecoord;
					end
					
					
				checksamecoord:begin
						if(dead)
							begin
								nextstate = deadstate;
							end
					
						else
							begin
								nextstate = checkleftcoord;
							end
						end
			
				checkleftcoord: begin
						if(dead)
							begin
								nextstate = deadstate;
							end
						if(destructableornot)
							begin
								nextstate = writeleftcoord;
							end
						else
							begin
								nextstate = checkupcoord;
							end
					end
					
					
					
					
				writeleftcoord:begin
							nextstate = checkupcoord;
						end
					
					
				checkupcoord: begin
						if(dead)
							begin
								nextstate = deadstate;
							end
						if(destructableornot)
							begin
								nextstate = writeupcoord;
							end
						else
							begin
								nextstate = checkrightcoord;
							end
						end
						
						
						
				writeupcoord:begin
							nextstate = checkrightcoord;
						end
					
			
				checkrightcoord: begin
						if(dead)
							begin
								nextstate = deadstate;
							end
						if(destructableornot)
							begin
								nextstate = writerightcoord;
							end
						else
							begin
								nextstate = checkdowncoord;
							end
						end
						
				writerightcoord:begin
							nextstate = checkdowncoord;
						end
					
				checkdowncoord: begin
					if(dead)
							begin
								nextstate = deadstate;
							end
						if(destructableornot)
							begin
								nextstate = writedowncoord;
							end
						else
							begin
								nextstate = puttingcoord;
							end
						end
						
						
				writedowncoord:begin
						nextstate = puttingcoord;
					end
					
					
					
				deadstate: begin
					nextstate = deadstate;
				end
				
				winstate:begin
					nextstate = winstate;
				end
		endcase
	end
	
	always@(*)
		begin
		startcheckarr = 1'b0;
		updatecoord = 1'b0;
		wren = 1'b0;
		placebomb = 1'b0;
		left = 1'b0;
		writeleft = 1'b0;
		right = 1'b0;
		writeright = 1'b0;
		up = 1'b0;
		writeup = 1'b0;
		down = 1'b0;
		writedown = 1'b0;
		checksamecoor = 1'b0;
		loadenable = 1'b0;
		dead = 1'b0;
		startcheckbombele = 1'b0;
		dowesetup = 1'b0;
		
		case(currentstate)
			
			setupstate:begin
				wren = 1'b1;
				dowesetup = 1'b1;
			end
			waitingstate: begin
				loadenable = 1'b1;
				startcheckarr = 1'b1;
			end
			checkwithread:begin
				startcheckarr = 1'b1;
			end
			writearrcoord: begin
				updatecoord = 1'b1;
			end
			placebombread:begin
				startcheckbombele = 1'b1;
			end
			placebombwrite:begin
				wren = 1'b1;
				placebomb = 1'b1;
			end
			checksamecoord:begin
				checksamecoor = 1'b1;
			end
			checkleftcoord:begin
				left = 1'b1;
			end
			writeleftcoord: begin
				wren = 1'b1;
				writeleft = 1'b1;
				end
			checkupcoord:begin
				up = 1'b1;
			end
			writeupcoord: begin
				wren = 1'b1;
				writeup = 1'b1;
				end
			checkrightcoord:begin
				right = 1'b1;
			end
			writerightcoord: begin
				wren = 1'b1;
				writeright = 1'b1;
				end	
			checkdowncoord:begin
				down = 1'b1;
			end
			writedowncoord: begin
				wren = 1'b1;
				writedown = 1'b1;
				end
			deadstate:begin
				dead = 1'b1;
			end
			endcase
		end
		
		
		
		
always@(posedge Clock)
	begin
		currentstate <= nextstate;
		if(reset)
			begin
				counter = 8'b0;
			end
		if(counter < 8'b1000000)
			begin
				counter = counter + 1'b1;
			end
		if(counter == 8'b10000000)
			begin
				counter = 8'b0;
			end
	end
	

endmodule
				

module datapath(reset,Clock,posneg,leftright,updown, startcheckbombele, abombtimeup,validb, alreadyhavefourbomb,startcheckarr,wren,placebomb,left,writeleft,right,writeright,up,writeup,down,writedown,checksamecoor,destructableornot,dead,loadenable,updatecoord,won,dowesetup,setupdone,topleftaddress,topleftdata,topaddress,topdata,toprightaddress,toprightdata,leftaddress,leftdata,rightaddress,rightdata,bottomleftaddress,bottomleftdata,bottomaddress,bottomdata,bottomrightaddress,bottomrightdata,xcoord,ycoord,bombnum);
input reset;
input Clock;
input posneg;
input leftright;
input updown;
input startcheckarr;
input wren;
input startcheckbombele;
input placebomb;
input left;
input writeleft;
input right;
input writeright;
input up;
input writeup;
input down;
input writedown;
input loadenable;
input updatecoord;
input checksamecoor;
input dowesetup;


output reg abombtimeup;
output validb;
output reg alreadyhavefourbomb;
output destructableornot;
output reg dead;
output reg won;
output reg setupdone;
output reg[3:0] xcoord;
output reg[3:0] ycoord;
reg[3:0] xtemp;
reg[3:0] ytemp;
reg[7:0] firstbombloc;
reg[7:0] secondbombloc;
reg[7:0] thirdbombloc;
reg[7:0] fourthbombloc;
reg[27:0] firstbombcountdown;
reg[27:0] secondbombcountdown;
reg[27:0] thirdbombcountdown;
reg[27:0] fourthbombcountdown;
output reg[3:0] bombnum;
reg [2:0] datainput;
reg [2:0] dataoutput;
reg [3:0] whichbombsareon;
reg [7:0] currenttriggeredbomb;
reg [7:0] address;
reg [7:0] nextaddress;
reg spacedone;
reg destructabledone;
reg indestructabledone;
reg othersdone;
reg[7:0] counter;
output reg [7:0]topleftaddress;
output reg [2:0]topleftdata;
output reg [7:0]topaddress;
output reg [2:0]topdata;
output reg [7:0]toprightaddress;
output reg [2:0]toprightdata;
output reg [7:0]leftaddress;
output reg [2:0]leftdata;
output reg [7:0]rightaddress;
output reg [2:0]rightdata;
output reg [7:0]bottomleftaddress;
output reg [2:0]bottomleftdata;
output reg [7:0]bottomaddress;
output reg [2:0]bottomdata;
output reg [7:0]bottomrightaddress;
output reg [2:0]bottomrightdata;
reg [7:0] address1;
reg [7:0] address2;
reg [7:0] address3;
reg [7:0] address4;
reg [7:0] address5;
reg [7:0] address6;
reg [7:0] address7;
reg [7:0] address8;
wire [2:0] w50, w51, w52, w53, w54, w55, w56, w57;



always@(posedge Clock)
	begin
		if(reset)
		begin
		xcoord = 4'b0001;
		ycoord = 4'b0001;
		xtemp = 4'b0000;
		ytemp = 4'b0000;
		firstbombloc = 7'b0;
		secondbombloc = 7'b0;
		thirdbombloc = 7'b0;
		fourthbombloc = 7'b0;
		firstbombcountdown = 27'b0;
		secondbombcountdown = 27'b0;
		thirdbombcountdown = 27'b0;
		fourthbombcountdown = 27'b0;
		bombnum = 4'b0;
		datainput = 3'b0;
		dataoutput = 3'b0;
		whichbombsareon = 4'b0;
		currenttriggeredbomb = 8'b0;
		nextaddress = 8'b0;
		won = 1'b0;
		spacedone = 1'b0;
		destructabledone = 1'b0;
		indestructabledone = 1'b0;
		othersdone = 1'b0;
		setupdone = 1'b0;
		topleftaddress = 8'b00000000;
		topleftdata = 3'b010;
		topaddress = 8'b00000001;
		topdata = 3'b010;
		toprightaddress = 8'b00000010;
		toprightdata = 3'b010;
		leftaddress = 8'b00010000;
		leftdata = 3'b010;
		rightaddress = 8'b00010010;
		rightdata = 3'b001;
		bottomleftaddress = 8'b00100000;
		bottomleftdata = 3'b010;
		bottomaddress = 8'b00100001;
		bottomdata = 3'b000;
		bottomrightaddress = 8'b00100010;
		bottomrightdata = 3'b001;
		counter = 8'b0;
	end
		if(dowesetup)
			begin
				if(!othersdone)
					begin
						if(!spacedone)
							begin
								address = nextaddress;
								nextaddress = address + 1'b1;
								datainput = 3'b000;
								if(address == 8'b11111111)
									begin
										spacedone = 1'b1;
										nextaddress = 8'b00010001;
									end
							end
						else if(!destructabledone)
									begin
									address = nextaddress;
									datainput = 3'b001;
									nextaddress = address + 2'b11;
									if(address > 8'b11111101)
										begin
											destructabledone = 1'b1;
											nextaddress = 8'b10011001;
										end
									end
						else if(!indestructabledone)
							begin
								address = nextaddress;
								datainput =3'b010;
								nextaddress = address+ 8'b0001010;
								if(address > 8'b10011001)
									begin
										indestructabledone = 1'b1;
										nextaddress = 8'b00000000;
										othersdone =1'b1;
									end
							end
					end
								
				
					
				else if(othersdone)
					begin
						datainput = 3'b010;
						nextaddress = counter;
						counter = counter + 1'b1;
						if(nextaddress[7:4] == 4'b0 | nextaddress[7:4] == 4'b1111 | nextaddress[3:0] == 4'b0 | nextaddress[3:0] == 4'b1111)
							begin
								address = nextaddress;
							end
						if(address == 8'b11111111)
							begin
								setupdone = 1'b1;
							end
						if(setupdone)
							begin
								datainput = 3'b000;
								address = 8'b00010001;
							end
					end
						
			end			
				
		if(firstbombcountdown!=27'b0)
			begin
				firstbombcountdown = firstbombcountdown -1'b1;
			end
		else if(whichbombsareon[0] == 1'b1)
			begin
				abombtimeup = 1'b1;
				currenttriggeredbomb = firstbombloc;
				bombnum = bombnum -1'b1;
				whichbombsareon[0] = 1'b0;
				alreadyhavefourbomb = 1'b0;
			end
		if(secondbombcountdown!=27'b0)
			begin
				secondbombcountdown = secondbombcountdown -1'b1;
			end
		else if(whichbombsareon[1] == 1'b1)
			begin
				abombtimeup = 1'b1;
				currenttriggeredbomb = secondbombloc;
				bombnum = bombnum -1'b1;
				whichbombsareon[1] = 1'b0;
				alreadyhavefourbomb = 1'b0;
			end
		if(thirdbombcountdown!=27'b0)
			begin
				firstbombcountdown = firstbombcountdown -1'b1;
			end
		else if(whichbombsareon[2] == 1'b1)
			begin
				abombtimeup = 1'b1;
				currenttriggeredbomb = thirdbombloc;
				bombnum = bombnum -1'b1;
				whichbombsareon[2] = 1'b0;
				alreadyhavefourbomb = 1'b0;
			end
		if(fourthbombcountdown!=27'b0)
			begin
				fourthbombcountdown = fourthbombcountdown -1'b1;
			end
		else if(whichbombsareon[3] == 1'b1)
			begin
				abombtimeup = 1'b1;
				currenttriggeredbomb = fourthbombloc;
				bombnum = bombnum -1'b1;
				whichbombsareon[3] = 1'b0;
				alreadyhavefourbomb = 1'b0;
			end
		if(loadenable)
			begin
				if(posneg == 1'b0)
					begin
						xtemp = xcoord - updown;
						ytemp = ycoord - leftright;
					end
				if(posneg == 1'b1)
					begin
						xtemp = xcoord + updown;
						ytemp = ycoord + leftright;
					end
			end
		//if(startcheckarr)
			//begin
				//writeorread = 1'b0;
			//end
			
		if(startcheckarr)
			begin
				address = {{xtemp},{ytemp}};
			end
		if(updatecoord)
			begin
				xcoord = xtemp;
				ycoord = ytemp;
				address = {{xcoord},{ycoord}};
				if({{xcoord},{ycoord}}==8'b11101110)
					begin
						won = 1'b1;
					end
				topleftaddress ={{xcoord-1'b1},{ycoord-1'b1}};
				topaddress = {{xcoord-1'b1},{ycoord}};
				toprightaddress = {{xcoord-1'b1},{ycoord+1'b1}};
				leftaddress = {{xcoord},{ycoord-1'b1}};
				rightaddress = {{xcoord},{ycoord+1'b1}};
				bottomleftaddress = {{xcoord+1'b1},{ycoord-1'b1}};
				bottomaddress = {{xcoord+1'b1},{ycoord}};
				bottomrightaddress = {{xcoord+1'b1},{ycoord+1'b1}};
				
			end
		if(startcheckbombele)
			begin
				if(bombnum == 4'b0100)
					begin
						alreadyhavefourbomb = 1'b1;
					end
			end
				
		if(placebomb)
			begin
				datainput = 3'b011;
				if(firstbombcountdown==27'b0)
					begin
						bombnum = bombnum + 1'b1;
						firstbombcountdown = {{27{1'b1}}};
						firstbombloc = {{xcoord},{ycoord}};
						whichbombsareon = whichbombsareon + 4'b0001;
						address = firstbombloc;
					end
				else if(secondbombcountdown==27'b0)
					begin
						bombnum = bombnum + 1'b1;
						secondbombcountdown = {{27{1'b1}}};
						secondbombloc = {{xcoord},{ycoord}};
						whichbombsareon = whichbombsareon + 4'b0010;
						address = secondbombloc;
					end
				else if(thirdbombcountdown==27'b0)
					begin
						bombnum = bombnum + 1'b1;
						thirdbombcountdown = {{27{1'b1}}};
						thirdbombloc = {{xcoord},{ycoord}};
						whichbombsareon = whichbombsareon + 4'b0100;
						address = thirdbombloc;
					end
				else if(fourthbombcountdown==27'b0)
					begin
						bombnum = bombnum + 1'b1;
						fourthbombcountdown = {{27{1'b1}}};
						fourthbombloc = {{xcoord},{ycoord}};
						whichbombsareon = whichbombsareon + 4'b1000;
						address = fourthbombloc;
					end
			end
		if(up)
			begin
				currenttriggeredbomb = currenttriggeredbomb+1'b1;
				currenttriggeredbomb = currenttriggeredbomb-5'b10000;
				address = currenttriggeredbomb;
				if({{xcoord},{ycoord}}==address)
					begin
						dead = 1'b1;
					end
			end
		if(down)
			begin
				currenttriggeredbomb = currenttriggeredbomb-1'b1;
				currenttriggeredbomb = currenttriggeredbomb+5'b10000;
				address = currenttriggeredbomb;
				if({{xcoord},{ycoord}}==address)
					begin
						dead = 1'b1;
					end
			end
		if(left)
			begin
				currenttriggeredbomb = currenttriggeredbomb-1'b1;
				address = currenttriggeredbomb;
				if({{xcoord},{ycoord}}==address)
					begin
						dead = 1'b1;
					end
			end
		if(right)
			begin
				currenttriggeredbomb = currenttriggeredbomb+5'b10000;
				currenttriggeredbomb = currenttriggeredbomb+1'b1;
				address = currenttriggeredbomb;
				if({{xcoord},{ycoord}}==address)
					begin
						dead = 1'b1;
					end
			end
		else if(writeleft|writeup|writedown|writeright)
			begin
				datainput = 3'b000;
			end
		else if(checksamecoor)
			begin
			address = currenttriggeredbomb;
			if({{xcoord},{ycoord}}==address)
				begin
					dead = 1'b1;
				end
			end
		if(wren)
			begin
				address1 = address;
				address2 = address;
				address3 = address;
				address4 = address;
				address5 = address;
				address6 = address;
				address7 = address;
				address8 = address;

			end
		if(!wren)
			begin
				address1 = topleftaddress;
				address2 = topaddress;
				address3 = toprightaddress;
				address4 = leftaddress;
				address5 = rightaddress;
				address6 = bottomleftaddress;
				address7 = bottomaddress;
				address8 = bottomrightaddress;
				topleftdata = w50;
				topdata = w51;
				toprightdata = w52;
				leftdata = w53;
				rightdata = w54;
				bottomleftdata = w55;
				bottomdata = w56;
				bottomrightdata = w57;
			end
			
	end

	thememory u0(.validb(validb),.address(address), .clock(Clock),.data(datainput),.wren(wren),.destructableornot(destructableornot));
	arraynew u50(.address(address1),.clock(Clock),.data(datainput),.wren(wren),.q(w50));
	arraynew u51(.address(address2),.clock(Clock),.data(datainput),.wren(wren),.q(w51));
	arraynew u52(.address(address3),.clock(Clock),.data(datainput),.wren(wren),.q(w52));
	arraynew u53(.address(address4),.clock(Clock),.data(datainput),.wren(wren),.q(w53));
	arraynew u54(.address(address5),.clock(Clock),.data(datainput),.wren(wren),.q(w54));
	arraynew u55(.address(address6),.clock(Clock),.data(datainput),.wren(wren),.q(w55));
	arraynew u56(.address(address7),.clock(Clock),.data(datainput),.wren(wren),.q(w56));
	arraynew u57(.address(address8),.clock(Clock),.data(datainput),.wren(wren),.q(w57));

	
endmodule
						
						
module thememory(validb,address,clock,data,wren,destructableornot);
	output reg validb;
	input[7:0] address;
	input clock;
	input[2:0] data;
	input wren;
	wire [2:0] targetvalue;
	output reg destructableornot;
	arraynew u1(.address(address),.clock(clock),.data(data),.wren(wren),.q(targetvalue));
	always@(*)
		begin
		validb = 1'b1;
		destructableornot = 1'b1;
		if(wren == 1'b0)
			begin
				if(targetvalue!=3'b000)
					begin
						validb = 1'b0;
					end
				if(targetvalue!=3'b001)
					begin
						destructableornot = 1'b0;
					end
			end
	end
endmodule


//third-party code: HEXdecoder
//
//
module hex_decoder (c, display);
  input [3:0] c;
  output [6:0] display;

  // calculate all minterms with wires, then just or them
  wire m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15;

  assign m0 = ~c[3] & ~c[2] & ~c[1] & ~c[0];
  assign m1 = ~c[3] & ~c[2] & ~c[1] & c[0];
  assign m2 = ~c[3] & ~c[2] & c[1] & ~c[0];
  assign m3 = ~c[3] & ~c[2] & c[1] & c[0];
  assign m4 = ~c[3] & c[2] & ~c[1] & ~c[0];
  assign m5 = ~c[3] & c[2] & ~c[1] & c[0];
  assign m6 = ~c[3] & c[2] & c[1] & ~c[0];
  assign m7 = ~c[3] & c[2] & c[1] & c[0];
  assign m8 = c[3] & ~c[2] & ~c[1] & ~c[0];
  assign m9 = c[3] & ~c[2] & ~c[1] & c[0];
  assign m10 = c[3] & ~c[2] & c[1] & ~c[0];
  assign m11 = c[3] & ~c[2] & c[1] & c[0];
  assign m12 = c[3] & c[2] & ~c[1] & ~c[0];
  assign m13 = c[3] & c[2] & ~c[1] & c[0];
  assign m14 = c[3] & c[2] & c[1] & ~c[0];
  assign m15 = c[3] & c[2] & c[1] & c[0];

  assign display[0] = m1 | m4 | m11 | m13;
  assign display[1] = m5 | m6 | m11 | m12 | m14 | m15;
  assign display[2] = m2 | m12 | m14 | m15;
  assign display[3] = m1 | m4 | m7 | m9 | m10 | m15;
  assign display[4] = m1 | m3 | m4 | m5 | m7 | m9;
  assign display[5] = m1 | m2 | m3 | m7 | m13;
  assign display[6] = m0 | m1 | m7 | m12;

endmodule


module ratedivider(ClockIn, Reset, Enable);
	input ClockIn;
	input Reset;
	output reg Enable;
	reg [3:0] counter;
	always@(posedge ClockIn)
	begin
	Enable = 1'b0;
    if (Reset) 
		begin
      counter <= 4'b1111;
		end
    else if (counter == 0) 
		begin
      counter <= 4'b1111;
		Enable = 1'b1;
		end
    else 
		begin
      counter <= counter - 1;
		end
  end
endmodule

// megafunction wizard: %RAM: 1-PORT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altsyncram 

// ============================================================
// File Name: arraynew.v
// Megafunction Name(s):
// 			altsyncram
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 18.0.0 Build 614 04/24/2018 SJ Lite Edition
// ************************************************************


//Copyright (C) 2018  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module arraynew (
	address,
	clock,
	data,
	wren,
	q);

	input	[7:0]  address;
	input	  clock;
	input	[2:0]  data;
	input	  wren;
	output	[2:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	  clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [2:0] sub_wire0;
	wire [2:0] q = sub_wire0[2:0];

	altsyncram	altsyncram_component (
				.address_a (address),
				.clock0 (clock),
				.data_a (data),
				.wren_a (wren),
				.q_a (sub_wire0),
				.aclr0 (1'b0),
				.aclr1 (1'b0),
				.address_b (1'b1),
				.addressstall_a (1'b0),
				.addressstall_b (1'b0),
				.byteena_a (1'b1),
				.byteena_b (1'b1),
				.clock1 (1'b1),
				.clocken0 (1'b1),
				.clocken1 (1'b1),
				.clocken2 (1'b1),
				.clocken3 (1'b1),
				.data_b (1'b1),
				.eccstatus (),
				.q_b (),
				.rden_a (1'b1),
				.rden_b (1'b1),
				.wren_b (1'b0));
	defparam
		altsyncram_component.clock_enable_input_a = "BYPASS",
		altsyncram_component.clock_enable_output_a = "BYPASS",
		altsyncram_component.intended_device_family = "Cyclone V",
		altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.numwords_a = 256,
		altsyncram_component.operation_mode = "SINGLE_PORT",
		altsyncram_component.outdata_aclr_a = "NONE",
		altsyncram_component.outdata_reg_a = "UNREGISTERED",
		altsyncram_component.power_up_uninitialized = "FALSE",
		altsyncram_component.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
		altsyncram_component.widthad_a = 8,
		altsyncram_component.width_a = 3,
		altsyncram_component.width_byteena_a = 1;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
// Retrieval info: PRIVATE: AclrAddr NUMERIC "0"
// Retrieval info: PRIVATE: AclrByte NUMERIC "0"
// Retrieval info: PRIVATE: AclrData NUMERIC "0"
// Retrieval info: PRIVATE: AclrOutput NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_ENABLE NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
// Retrieval info: PRIVATE: BlankMemory NUMERIC "1"
// Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: Clken NUMERIC "0"
// Retrieval info: PRIVATE: DataBusSeparated NUMERIC "1"
// Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
// Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_A"
// Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "0"
// Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
// Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
// Retrieval info: PRIVATE: MIFfilename STRING ""
// Retrieval info: PRIVATE: NUMWORDS_A NUMERIC "256"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
// Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_A NUMERIC "3"
// Retrieval info: PRIVATE: RegAddr NUMERIC "1"
// Retrieval info: PRIVATE: RegData NUMERIC "1"
// Retrieval info: PRIVATE: RegOutput NUMERIC "0"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: SingleClock NUMERIC "1"
// Retrieval info: PRIVATE: UseDQRAM NUMERIC "1"
// Retrieval info: PRIVATE: WRCONTROL_ACLR_A NUMERIC "0"
// Retrieval info: PRIVATE: WidthAddr NUMERIC "8"
// Retrieval info: PRIVATE: WidthData NUMERIC "3"
// Retrieval info: PRIVATE: rden NUMERIC "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_A STRING "BYPASS"
// Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_A STRING "BYPASS"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: LPM_HINT STRING "ENABLE_RUNTIME_MOD=NO"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
// Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "256"
// Retrieval info: CONSTANT: OPERATION_MODE STRING "SINGLE_PORT"
// Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "NONE"
// Retrieval info: CONSTANT: OUTDATA_REG_A STRING "UNREGISTERED"
// Retrieval info: CONSTANT: POWER_UP_UNINITIALIZED STRING "FALSE"
// Retrieval info: CONSTANT: READ_DURING_WRITE_MODE_PORT_A STRING "NEW_DATA_NO_NBE_READ"
// Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_A NUMERIC "3"
// Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
// Retrieval info: USED_PORT: address 0 0 8 0 INPUT NODEFVAL "address[7..0]"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT VCC "clock"
// Retrieval info: USED_PORT: data 0 0 3 0 INPUT NODEFVAL "data[2..0]"
// Retrieval info: USED_PORT: q 0 0 3 0 OUTPUT NODEFVAL "q[2..0]"
// Retrieval info: USED_PORT: wren 0 0 0 0 INPUT NODEFVAL "wren"
// Retrieval info: CONNECT: @address_a 0 0 8 0 address 0 0 8 0
// Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @data_a 0 0 3 0 data 0 0 3 0
// Retrieval info: CONNECT: @wren_a 0 0 0 0 wren 0 0 0 0
// Retrieval info: CONNECT: q 0 0 3 0 @q_a 0 0 3 0
// Retrieval info: GEN_FILE: TYPE_NORMAL arraynew.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL arraynew.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL arraynew.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL arraynew.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL arraynew_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL arraynew_bb.v TRUE
// Retrieval info: LIB_FILE: altera_mf
		


