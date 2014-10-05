// Description : This Module will decode and control the slide switch part
// and Output of this Module should be Sent to hex2seven Segment Decodar Module
// Code is Documented  line by line .
module switch_decode(slide_switch,outp,ledout); 

input   [7:0] slide_switch ;// Input Connected to slide switches 
output  [13:0] outp        ;// Output Connected to Seaven Segment
output  [7:0] ledout       ;// Output for LED

reg     [13:0] outp        ;


assign ledout = slide_switch ; // assignment of LED to slide switch

always@(slide_switch)begin
  case(slide_switch)
       8'b0000_0000: outp = 14'b1000000_1000000    ; // Start Condition "00" No Switch is ON
       8'b1000_0001: outp = 14'b0000000_1111001    ; // 7th and 0th switch is ON "81"
       8'b1000_0010: outp = 14'b0000000_0100100    ; // 7th and 1st switch is ON "82"
       8'b1000_0100: outp = 14'b0000000_0011001    ; // 7th and 2nd switch is ON "84" 
       8'b1000_1000: outp = 14'b0000000_0000000    ; // 7th and 3rd switch is ON "88"
       8'b1001_0000: outp = 14'b0010000_1000000    ; // 7th and 4th switch is ON "90"
       8'b1010_0000: outp = 14'b0001000_1000000    ; // 7th and 5th switch is ON "A0"
       8'b1100_0000: outp = 14'b1000110_1000000    ; // 7th and 6th switch is ON "C0"
       8'b0100_0001: outp = 14'b0011001_1111001    ; // 6th and 0th switch is ON "41"
       8'b0100_0010: outp = 14'b0011001_0100100    ; // 6th and 1st switch is ON "42"
       8'b0100_0100: outp = 14'b0011001_0011001    ; // 6th and 2nd switch is ON "44"
       8'b0100_1000: outp = 14'b0011001_0000000    ; // 6th and 3th switch is ON "48"
       8'b0101_0000: outp = 14'b0010010_1000000    ; // 6th and 4th switch is ON "50"
       8'b0110_0000: outp = 14'b0000010_1000000    ; // 6th and 5th switch is ON "60"
       8'b0010_0001: outp = 14'b0100100_1111001    ; // 5th and 0th switch is ON "21"
       8'b0010_0010: outp = 14'b0100100_0100100    ; // 5th and 1st switch is ON "22"
       8'b0010_0100: outp = 14'b0100100_0011001    ; // 5th and 2nd switch is ON "24"
       8'b0010_1000: outp = 14'b0100100_0000000    ; // 5th and 3th switch is ON "28"
       8'b0011_0000: outp = 14'b0110000_1000000    ; // 5th and 4th switch is ON "30"
       8'b0001_0001: outp = 14'b1111001_1111001    ; // 4th and 0th switch is ON "11"
       8'b0001_0010: outp = 14'b1111001_0100100    ; // 4th and 1st switch is ON "12"
       8'b0001_0100: outp = 14'b1111001_0011001    ; // 4th and 2nd switch is ON "14"
       8'b0001_1000: outp = 14'b1111001_0000000    ; // 4th and 3rd switch is ON "18"
       8'b0000_1001: outp = 14'b1000000_0010000    ; // 3rd and 0th switch is ON "09"
       8'b0000_1010: outp = 14'b1000000_0001000    ; // 3rd and 1st switch is ON "0A"
       8'b0000_1100: outp = 14'b1000000_1000110    ; // 3rd and 2nd switch is ON "0C"
       8'b0000_0101: outp = 14'b1000000_0010010    ; // 2nd and 0th switch is ON "05"
       8'b0000_0110: outp = 14'b1000000_0000010    ; // 2nd and 1st switch is ON "06"
       8'b0000_0011: outp = 14'b1000000_0110000    ; // 2nd and 1st switch is ON "03"
          default  : outp = 14'b0000110_0101111    ; // Error Condition "Er"
endcase
end

endmodule
