`timescale 1ns/1ps
module top_tb 
  ();

  logic a,b;
  logic [7:0] cnt;
 
  enc dut ( .* );  
  
  //assign a = seq1;
  //assign b = seq2;

   task automatic seq (input dir);//dir == 1 => rigt, dir == 0 => left
     bit [4:0] seq_buf = {1'b0,1'b0,1'b1,1'b1,1'b0};
     begin
       if (dir)
         for (int i = 0;i < 4; i = i + 1)
           begin
             $display("input a = %0d, input b = %0d, i = %0d", a, b, i);
             a = seq_buf[i+1];
             b = seq_buf[i];
             #10;
           end 
       else
         for (int i = 0;i < 4; i = i + 1)
           begin
             $display("input a = %0d, input b = %0d, i = %0d", a, b, i);
             b = seq_buf[i+1];
             a = seq_buf[i];
             #10;
           end 
     end
   endtask

  initial
    begin  
      a = 0; 
      b = 0; 
      
      #50;

     repeat (10)
       begin
         seq(1);
       end
       
     repeat (10)
       begin
         seq(0);
       end 
       
       #50; 
       $stop; 
     end 
     

endmodule
