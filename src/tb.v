
`timescale 1ps/1ps
module tb;

reg clk1;
reg rst ;

reg but0,but1;
reg [7:0] ssw;

wire [6:0] sseg;
wire       dp;
wire [7:0] led ;
wire [3:0] an  ;

always begin 
clk1 = 0; 
forever #1 clk1 = ~clk1; 
end

reg       flag=0;

reg [3:0] sseg2hex_temp1;
reg [3:0] sseg2hex_temp2;
reg [7:0] sseg2hex3=7'b0;

reg [17:0]count   ; 

always @ (posedge clk1 or posedge rst) begin
  if (rst)
   count <= 1'b0     ; // Count Numbers
  else
   count <= count + 1; // Count Numbers
end

task initialize;
begin
rst  = 1'b1;
but0 = 1'h0;
but1 = 1'b0;
ssw = 7'b0;
#10 rst =1'b0;
end
endtask



task switch_set;
input [7:0] slide_switch1;
begin
ssw=slide_switch1;
repeat(2)@(posedge clk1);
but0=1'b1;
repeat(5)@(posedge clk1);
but0=1'b0;
wait(pro.ctrl0.temp);
wait(~pro.ctrl0.temp);
end
endtask

always@(posedge count[15])begin

if(count[17:16]==00) begin
sseg2hex_temp1=sseg2hex(sseg);
end else if (count[17:16]==01) begin
sseg2hex_temp2=sseg2hex(sseg);
sseg2hex3={sseg2hex_temp2,sseg2hex_temp1};
if(sseg2hex3==ssw)
$display("At Time : %0t  Result : <PASS> Actual Data : %h Expected Data : %h" ,$time,sseg2hex3,ssw);
else
$display("At Time : %0t  Result : <FAIL> Actual Data : %h Expected Data : %h" ,$time,sseg2hex3,ssw);
end
end

project1 pro ( .rst  (rst)
             ,.clk  (clk1)
             ,.but0 (but0)
             ,.ssw  (ssw)
             ,.sseg (sseg)
             ,.an   (an)
             ,.dp   (dp)
             ,.led  (led)); 

initial begin
$display("--Tests Start--");
initialize;
$display("--Basic Tests--");
switch_set(8'h00);
switch_set(8'h81);
switch_set(8'h82);
switch_set(8'h84);
switch_set(8'h88);
switch_set(8'h90);
switch_set(8'hA0);
switch_set(8'hC0);
switch_set(8'h41);
switch_set(8'h42);
switch_set(8'h44);
switch_set(8'h48);
switch_set(8'h50);
switch_set(8'h60);
switch_set(8'h21);
switch_set(8'h22);
switch_set(8'h24);
switch_set(8'h28);
switch_set(8'h30);
switch_set(8'h11);
switch_set(8'h12);
switch_set(8'h14);
switch_set(8'h18);
switch_set(8'h09);
switch_set(8'h0A);
switch_set(8'h0C);
switch_set(8'h05);
switch_set(8'h06);
switch_set(8'h03);
$display("--Error Tests--");
switch_set(8'hFF);
switch_set(8'hA2);
switch_set(8'hB6);
switch_set(8'h98);
switch_set(8'h4E);
switch_set(8'h32);
switch_set(8'h42); //Good Value
switch_set(8'h7F);
switch_set(8'h10);
switch_set(8'h23);
$finish;
end


function [3:0] sseg2hex;

input [6:0] sseg;
begin
case(sseg) 
   7'b1000000    : sseg2hex = 4'b0000 ;   //0
   7'b1111001    : sseg2hex = 4'b0001 ;   //1
   7'b0100100    : sseg2hex = 4'b0010 ;   //2                                         
   7'b0110000    : sseg2hex = 4'b0011 ;   //3                                         
   7'b0011001    : sseg2hex = 4'b0100 ;   //4                                         
   7'b0010010    : sseg2hex = 4'b0101 ;   //5                                         
   7'b0000010    : sseg2hex = 4'b0110 ;   //6                                         
   7'b1111000    : sseg2hex = 4'b0111 ;   //7                                         
   7'b0000000    : sseg2hex = 4'b1000 ;   //8       
   7'b0010000    : sseg2hex = 4'b1001 ;   //9
   7'b0001000    : sseg2hex = 4'b1010 ;   //A                                         
   7'b0000011    : sseg2hex = 4'b1011 ;   //b                                         
   7'b1000110    : sseg2hex = 4'b1100 ;   //C                                         
   7'b0100001    : sseg2hex = 4'b1101 ;   //d                                         
   7'b0000110    : sseg2hex = 4'b1110 ;   //E                                         
   7'b0001110    : sseg2hex = 4'b1111 ;   //F
   7'b0101111    : sseg2hex = 4'b1111 ;      
endcase
end
endfunction



endmodule
