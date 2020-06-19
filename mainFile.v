module mano_cpu(
  input run_code,clk,in_flag,out_flag,
  input [7:0] in,
  input [11:0] address,
  input [15:0] code,
  output reg fgo,fgi,
  output reg [7:0] out,
  output reg [15:0] test);
reg [11:0] pc,return_address;
reg [15:0] mem[0:4065];
reg [15:0] ac,ir,dr;
reg e,if_hlt=0;
reg [7:0] inpr;
initial
pc =12'h100;
always @(posedge clk)begin
if(run_code && if_hlt!=1)begin
    ir = mem[pc];
    pc=pc+1;
    if (ir[14:12] != 3'b111)begin
  dr = mem[ir[11:0]];
  if(ir[15])                dr = mem[dr[11:0]];
  if(ir[14:12] == 3'b000)   ac = ac&dr;
        if(ir[14:12] == 3'b001)   {e,ac} = ac+dr;
  if(ir[14:12] == 3'b010)   ac = dr;//LDA
  if(ir[14:12] == 3'b011)   //STA
          if(ir[15]) mem[mem[ir[11:0]]]= ac;
          else begin mem[ir[11:0]]<= ac; end
  if(ir[14:12] == 3'b100)   pc = dr[11:0];
  if(ir[14:12] == 3'b101)begin return_address = pc;pc=dr; end
  if(ir[14:12] == 3'b110)begin
      dr=dr+1;
      if(dr==16'h0000) pc=pc+12'h0001;
      if(ir[15]) mem[mem[ir[11:0]]]=dr;
      else  mem[ir[11:0]]=dr; end
  
    end
    if(ir == 16'h7800) ac = 16'h0000;
    if(ir == 16'h7400) e = 1'b0;
    if(ir == 16'h7200) ac = ~ac;
    if(ir == 16'h7100) e=~e;
    if(ir == 16'h7080) {e,ac} = {ac[0],e,ac[15:1]};
    if(ir == 16'h7040) {e,ac} = {ac,e};
    if(ir == 16'h7020) ac = ac+16'h0001;
    if(ir == 16'h7010) //SPA
  if(ac[15]==1'b0 && ac!=16'h0000) pc=pc+12'h0001;
    if(ir == 16'h7008) //SNA
  if(ac[15]==1'b1) pc=pc+12'h0001;
    if(ir == 16'h7004) //SZA
  if(ac==16'h0000) pc=pc+12'b0001;
    if(ir == 16'h7002 && e==1'b0) pc=pc+12'b0001;
    if(ir == 16'h7001) if_hlt=1;
////  I/O INSTRUCTIONS /////
    if(ir == 16'hf800) begin
  fgi=1'b0;
  while(in_flag==1'b0)begin pc=pc; end
  ac = {8'h00,in};fgi=1'b0;end
    if(ir == 16'hf400)begin
  fgo=1'b0;
  while(out_flag==1'b0)begin pc=pc; end
  ac = {8'h00,out};fgo=1'b0;end
   if(ir == 16'hf200)
  if(in_flag) pc = pc+1;
   if(ir == 16'hf100)
  if(out_flag) pc = pc+1;
end
else if(if_hlt!= 1) begin
 mem[address]<=code;
end
end

always @(posedge clk)
test<=pc;

always @(in_flag,out_flag)begin
fgi=in_flag;fgo=out_flag;end

endmodule
