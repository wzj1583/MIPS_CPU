module MEMWB(
  input                   clk,                  //修改
  input                   reset,                //修改
  input                   Stall,
  // RAM control signals
  input   [31:0]          ram_read_data_in,
  // input from MEM stage

  input                   MemRd_in,              //修改
  input                   MemWr_in,              //修改
  input                   mem_sign_ext_flag_in,  //保留，扩展标识
  input   [3:0]           mem_sel_in,            //保留，用于使用LH等指令
  input   [31:0]          result_in,
  input                   reg_write_en_in,       //保留，寄存器写标志用于forwarding
  input   [4:0]           reg_write_addr_in,     //保留，寄存器写标志用于forwarding
  input   [31:0]          current_pc_addr_in,
  input   [3:0]           AN_in,                 //修改
  input   [7:0]           digital_in,            //修改
  input   [7:0]           led_in,                //修改
  input                   inter                  //修改
  // RAM data
  output  [31:0]          ReadData_out,          //修改
  // memory accessing signals
  output                  MemRd_out,             //修改
  output                  MemWr_out,             //修改
  output                  mem_sign_ext_flag_out, //保留，扩展标识
  output  [3:0]           mem_sel_out,           //保留，用于使用LH等指令
  // regfile
  output  [31:0]          result_out,
  output                  reg_write_en_out,      //保留，寄存器写标志用于forwarding
  output  [4:0]           reg_write_addr_out,    //保留，寄存器写标志用于forwarding
  // debug signals
  output  [31:0]          current_pc_addr_out,
  output  [3:0]           AN_out,                 //修改
  output  [7:0]           digital_out,            //修改
  output  [7:0]           led_out,                //修改
  output                  inter
);
  always @(posedge clk,posedge reset)
   begin
    if(reset)
     begin
      MenRd_out <= 1'b0;
      MemWr_out <= 1'b0;
      mem_sign_ext_flag_out <= 32'b0;
      mem_sel_out <= 4'b0;
      result_out <= 32'b0;
      reg_write_en_out <= 1'b0;
      reg_write_addr_out <= 5'b0;
     end
    else
     begin 
      //memory accessing signals
      MenRd_out <= Stall? 1'b0:MenRd_in;
      MemWr_out <= Stall? 1'b0:MenWr_in;
      mem_sign_ext_flag_out <= Stall? 1'b0:mem_sign_ext_flag_in;
      mem_sel_out <= Stall? 4'b0:mem_sel_in;
      result_out <= Stall? 32'b0:result_in;
      reg_write_en_out <= Stall? 1'b0:reg_write_en_in;
      reg_write_addr_out <= Stall? 5'b0:reg_write_addr_in;
      // debug
      current_pc_addr_out <= current_pc_addr_in;
      AN_out <= AN_in;
      digital_out <= digital_in;
      led_out <= led_in;
     end
   end    
endmodule

endmodule // MEMWB
