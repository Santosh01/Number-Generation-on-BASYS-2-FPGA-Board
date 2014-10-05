//Description : This Module just decode Slide Switches only
//Code is Documented  line by line .
//Top module of project where all both the instance
//sd0 and ctrl0 are intanciated.
module project(rst,clk,but0,ssw,sseg,an,dp,led); 

input        rst          ; //Reset Mapped with Button 3
input        clk          ; //System Clock
input        but0         ; //Button 0
input  [7:0] ssw          ; //Slide Switch

output [3:0] an           ; //Seven Segment Enable 0
output       dp           ; //Decimal Enable ( "1" Disabled all the time )
output [6:0] sseg         ; //Seven Segment Output
output [7:0] led          ; //Led Output

wire   [13:0] digits      ;
wire   [ 3:0] an          ;
wire   [ 6:0] sseg        ;

//Switch Decode Logic
switch_decode  sd0( .slide_switch(ssw)
                   ,.outp(digits)
                   ,.ledout(led)
						 );

//Main Control State Machine
ctrl  ctrl0( .clk(clk)
            ,.rst(rst)
            ,.but0(but0)
            ,.digit0(digits[6:0])
            ,.digit1(digits[13:7])
            ,.dp(dp)
            ,.an(an)
            ,.sseg(sseg)
				);
 
endmodule
