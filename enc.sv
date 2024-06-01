module enc
	(
	input a,b,
	output reg [7:0] cnt = 0 
	);
	
	reg [1:0] a_buf = 0,b_buf = 0;//буферы входных сигналов a и b
	reg up,down;//сигналы напрвления
//	reg a_buf_in = 0,b_buf_in = 0;//входные буферы
	
	wire clk,u,d;
	assign clk = (a ^ b);
//	assign up = (a_buf[1] == b) ? 1 : 0;
//	assign down = (b_buf[1] == a) ? 1 : 0;

	/*Запись входных значений во входной регистр*/
	
//	always @(*)
//		begin
//			a_buf_in = a; 
//			b_buf_in = b; 
//		end
	
	/*Регистр сдвига для организации выравнивания двух сигалов a и b*/
	
	always @(a,b)
		begin
			a_buf[0] <= a;
			a_buf[1] <= a_buf[0];
			b_buf[0] <= b;
			b_buf[1] <= b_buf[0];
		end
 
	/*Вычисление напрвления вращения енкодера*/
 
	always @(posedge clk)
		begin
			if (a_buf[1] == b_buf[0])
				begin
					 up <= 1;
					 down <= 0;
				end
			else if (b_buf[1] == a_buf[0])
				begin
					 up <= 0;
					 down <= 1;
				end
			else
				begin
					 up <= 0;
					 down <= 0;
				end
		end 
 
		
	/*Счетчик*/
		
	always @(a,b)
		begin
			if (up)
				begin
					cnt = cnt + 1'b1;
				end
			else if (down)
				begin
					cnt = cnt - 1'b1;
				end
			else
				begin
					cnt = cnt;
				end
		end
endmodule