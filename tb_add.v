module tb();
    reg run_code,clk,in_flag,out_flag;
    reg [7:0] in;
    reg [11:0] address;
    reg [15:0] code;
    wire fgo,fgi;
    wire [7:0] out;
wire [11:0] te;
    mano_cpu mc0(run_code, clk, in_flag, out_flag, in, address, code, fgo, fgi, out, te);
    initial begin
	clk=1'b1;
	run_code=1'b0;
	address=12'b0;
	code=16'h2004;#2
	address=12'b01;
	code=16'h1005;#2
	address=12'b10;
	code=16'h3006;#2
	address=12'b11;
	code=16'h7001;#2
	address=12'b100;
	code=16'h0053;#2
	address=12'b101;
	code=16'hffe9;#2
	address=12'b110;
	code=16'h0000;#3
	run_code=1'b1;#20;
	$stop();
     end
     always
	#1 clk=~clk;
endmodule

