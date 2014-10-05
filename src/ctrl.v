//Description : Control State machine which will latch
//Value of 7-Seg Display Until the Next Switch is pressed.
module ctrl(clk,rst,but0,digit0,digit1,dp,an,sseg);

input       clk    ; // Connected with Systme Clock
input       rst    ; // Connected with Button 1
input       but0   ; // Connected with Button 0
input [6:0] digit0 ; // Connected with Slide switch Digit0
input [6:0] digit1 ; // Connected with Slide switch Digit1

output       dp    ; // Decimal Point Output which is Hardcoded to 1
output [3:0] an    ; // AN ( 4 Anode Signals for 7-seg display)
output [6:0] sseg  ; // 7-Segment Display Output 

localparam N = 18  ; // to Control Refreshing rate count 

wire         dp    ; 

reg [3:0 ] an      ;
reg [6:0 ] sseg    ;
reg [6:0 ] sseg3, sseg2, sseg1, sseg0; // All four Display Values which lated on used by mux
reg [N-1:0]count   ;           
reg        temp    ;

assign dp     = 1'b1 ; // Hard Code Decimal Point to 1 ( Dot will not be Enabled )

// Assign Digits to 7-Segments whenever but0 is pressed
always@(posedge clk or posedge rst) begin
  if(rst) begin
     sseg3 = 7'b1111111; 
     sseg2 = 7'b1111111; 
     sseg1 = 7'b1111111; 
     sseg0 = 7'b1111111; 
  end else if(but0) begin
     sseg3 = 7'b1111111; 
     sseg2 = 7'b1111111; 
     sseg1 = digit1; // Slide Switch Values 
     sseg0 = digit0; // Slide Switch Values
  end
end

always @ (posedge clk or posedge rst) begin
  if (rst)
   count <= 1'b0     ; // Count Numbers
  else
   count <= count + 1; // Count Numbers
end

//Generic Mux for 7-Seg Display
//Where only Segment 0 and Segment 1 is Enabled

always @ (*) begin

  case(count[N-1:N-2]) // Count(17-16)

   2'b00 :  begin
	         temp = 1'b0;
            sseg = sseg0  ;// seg0 
            an   = 4'b1110;// an<0>
            end
   2'b01:   begin
	         temp = 1'b0  ;
            sseg = sseg1  ;// seg1  
            an = 4'b1101  ;// san<1> 
            end
   2'b10:   begin
	         temp = 1'b0  ;
            sseg = sseg2  ;// Parmanently OFF 
            an   = 4'b1111;// Parmanently Disabled
            end
   2'b11:   begin
	         temp = 1'b1   ;
            sseg = sseg3  ;// Parmanently OFF
            an   = 4'b1111;// Parmanently Disabled
            end
  endcase
 end

endmodule