module tb_minuse();
    reg run_code,clk,in_flag,out_flag;
    reg [7:0] in;
    reg [11:0] address;
    reg [15:0] code;
    wire fgo,fgi;
    wire [7:0] out;
    wire [15:0] te;
    mano_cpu mc(run_code, clk, in_flag, out_flag, in, address, code, fgo, fgi, out, te);
    initial begin
	clk=1'b1;
	run_code=1'b0;
	address=12'h100;
	code=16'h2107;#2
	address=12'h101;
	code=16'h7200;#2
	address=12'h102;
	code=16'h7020;#2
	address=12'h103;
	code=16'h1106;#2
	address=12'h104;
	code=16'h3108;#2
	address=12'h105;
	code=16'h7001;#2
	address=12'h106;
	code=16'h0053;#2
	address=12'h107;
	code=16'hffe9;#2
	address=12'h108;
	code=16'h0000;#3
	run_code=1'b1;#20;
	$stop();
     end
     always
	#1 clk=~clk;
endmodule
