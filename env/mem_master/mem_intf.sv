interface mem_intf(input logic clk);
  
  logic rst_n;
  logic [`ADDR_WIDTH - 1 : 0] addr;
  logic [`DATA_WIDTH - 1 : 0] wr_data;
  logic [`DATA_WIDTH - 1 : 0] rd_data;
  logic                       wr_en;
  logic                       rd_en;
 
  

  
endinterface