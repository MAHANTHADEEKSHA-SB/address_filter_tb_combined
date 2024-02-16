
// Code your design here
interface apb_intf(input logic pclock);
  logic                         presetn;
  logic [`ADDR_WIDTH - 1 : 0]   paddr;
  logic [`DATA_WIDTH - 1 : 0]   pwdata;
  logic [`DATA_WIDTH - 1 : 0]   prdata;
  logic                         pwrite;
  logic                         pready;
  logic                         psel;
  logic                         penable;
  logic                         pslverr; 
  logic has_checks;
  logic has_coverage;
endinterface : apb_intf