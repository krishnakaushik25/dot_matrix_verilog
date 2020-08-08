`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2019 08:33:42 PM
// Design Name: 
// Module Name: DOTMATRIX_VERSION2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DOTMATRIX_VERSION2(reset,power,clk,up,down,right,left,
                            y00,y01,y02,y03,
                            y10,y11,y12,y13,
                            y20,y21,y22,y23,
                            y30,y31,y32,y33);
input reset,power,clk,up,down,right,left;
reg [3:0]control;

output y00,y01,y02,y03,y10,y11,y12,y13,y20,y21,y22,y23,y30,y31,y32,y33;
reg [0:3]mat[0:3];
reg [3:0] i,j;

reg [1:0] row, col;

parameter	 INITIALLY=4'b1111,	//4'hf
			 OFF=4'b1010,		//4'ha
             START=4'b0101;     //4'h5
reg [3:0] present, next;

always@(posedge clk)begin		//1
   control = {left,down,right,up}; 
if(power)begin
    if(reset)  present<=INITIALLY;
     else present<=next;
end else present<=OFF;

end		//1

//end 
always@(posedge clk)
begin
    case(present)
        OFF : begin
                for(j=0;j<4;j=j+1) begin
                    for(i=0;i<4;i=i+1) begin
                        mat[i][j]=0;    end end
               end  
        INITIALLY : begin
                        row=0;col=0;
                     for(j=0;j<4;j=j+1)    begin
                            for(i=0;i<4;i=i+1)  begin
                                if(i==row & j==col) mat[i][j]=1'b1;
                                 else mat[i][j]=1'b0;   end   
                                                  end
                      next = START;                           
                    end 
        START : begin
                    case(control)
                        4'b0001 : begin         //up
                                   row = row - 2'b01;
                                  for(j=0;j<4;j=j+1)    begin
                                    for(i=0;i<4;i=i+1)  begin
                                     if(i==row & j==col) mat[i][j]=1'b1;
                                      else mat[i][j]=1'b0;   end   end
                         end 
                        4'b0010 : begin           //right
                                    col = col + 2'b01;
                                    for(j=0;j<4;j=j+1)    begin
                                    for(i=0;i<4;i=i+1)  begin
                                     if(i==row & j==col) mat[i][j]=1'b1;
                                      else mat[i][j]=1'b0;   end   end
                        end 
                        4'b0100 : begin         //down
                                    row = row + 2'b01;
                                    for(j=0;j<4;j=j+1)    begin
                                    for(i=0;i<4;i=i+1)  begin
                                     if(i==row & j==col) mat[i][j]=1'b1;
                                      else mat[i][j]=1'b0;   end    end
                        end
                        4'b1000 : begin         //left
                                    col = col - 2'b01;
                                    for(j=0;j<4;j=j+1)    begin
                                    for(i=0;i<4;i=i+1)  begin
                                     if(i==row & j==col) mat[i][j]=1'b1;
                                      else mat[i][j]=1'b0;   end    end 
                        end 
                        default : for(j=0;j<4;j=j+1)    begin
                                    for(i=0;i<4;i=i+1)  begin
                                     if(i==row & j==col) mat[i][j]=1'b1;
                                      else mat[i][j]=1'b0;   end    end    
                    endcase                                          
                 end 
        default : begin
                        row=0;col=0;
                     for(j=0;j<4;j=j+1)    begin
                            for(i=0;i<4;i=i+1)  begin
                                if(i==row & j==col) mat[i][j]=1'b1;
                                 else mat[i][j]=1'b0;   end   
                                                  end
                      next = START;                           
                    end        
    endcase
end


assign y00 = mat[0][0];   assign y01 = mat[0][1];   assign y02 = mat[0][2];   assign y03 = mat[0][3];
assign y10 = mat[1][0];   assign y11 = mat[1][1];   assign y12 = mat[1][2];   assign y13 = mat[1][3];
assign y20 = mat[2][0];   assign y21 = mat[2][1];   assign y22 = mat[2][2];   assign y23 = mat[2][3];
assign y30 = mat[3][0];   assign y31 = mat[3][1];   assign y32 = mat[3][2];   assign y33 = mat[3][3];
endmodule


module testbench(

    );
    
    reg reset,power,clk,up,down,right,left;
    wire y00,y01,y02,y03,
                            y10,y11,y12,y13,
                            y20,y21,y22,y23,
                            y30,y31,y32,y33;
DOTMATRIX_VERSION2 test(reset,power,clk,up,down,right,left,
                            y00,y01,y02,y03,
                            y10,y11,y12,y13,
                            y20,y21,y22,y23,
                            y30,y31,y32,y33);
initial begin
clk = 0;
forever #5 clk = ~ clk;
end

initial begin
power = 1'b0; up = 1'b0; down = 1'b0; right = 1'b0; left = 1'b0;
#18 power =1'b1; reset = 1'b1;
#20 reset = 1'b0;
#20 up = 1'b0; down = 1'b1; right = 1'b0; left = 1'b0;
#30 up = 1'b0; down = 1'b0; right = 1'b1; left = 1'b0;
#25 up = 1'b1; down = 1'b0; right = 1'b0; left = 1'b0;
#30 up = 1'b0; down = 1'b1; right = 1'b0; left = 1'b0;
#25 up = 1'b0; down = 1'b1; right = 1'b1; left = 1'b0;
#30 up = 1'b0; down = 1'b0; right = 1'b0; left = 1'b1;
#250 $finish;
end
endmodule


