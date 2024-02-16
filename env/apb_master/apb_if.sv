`define NO_OF_SLAVES 7
// Code your design here
interface apb_if(input logic pclock);
  logic                         presetn;
  logic [`ADDR_WIDTH - 1 : 0]   paddr;
  logic [`DATA_WIDTH - 1 : 0]   pwdata;
  logic [`DATA_WIDTH - 1 : 0]   prdata;
  logic                         pwrite;
  logic                         pready;
  logic [`NO_OF_SLAVES - 1 : 0] psel_x;
  logic                         penable;
  logic                         pslverr;
  
  bit has_checks ;
  bit has_coverage ;
  
  clocking m_drv_cb@(posedge pclock);
     default input #1 output #0;
     output psel_x;
     output penable;
     output pwrite;
     output paddr;
     output pwdata;
     input  pready;
     input  prdata;

  endclocking : m_drv_cb
//----------------------------------------------------------------------
  clocking m_mon_cb@(posedge pclock);
     default input #1 output #0;
     input psel_x;
     input penable;
     input pwrite;
     input paddr;
     input pwdata;
     input  pready;
     input  prdata;

  endclocking : m_mon_cb
//-----------------------------------------------------------------------
  clocking slv_drv_cb@(posedge pclock);
     default input #1 output #0;
     input psel_x;
     input penable;
     input pwrite;
     input paddr;
     input pwdata;
     output  pready;
     output  prdata;

  endclocking : slv_drv_cb
//-----------------------------------------------------------------------
  clocking slv_mon_cb@(posedge pclock);
     default input #1 output #0;
     input psel_x;
     input penable;
     input pwrite;
     input paddr;
     input pwdata;
     input  pready;
     input  prdata;   
  endclocking : slv_mon_cb
//---------------------------------------------------------------------
  modport m_drv_mp(clocking m_drv_cb,input presetn);
    modport m_mon_mp(clocking m_mon_cb,input presetn);
//-----------------------------------------------------------------------
      modport slv_drv_mp(clocking slv_drv_cb,input presetn);
        modport slv_mon_mp(clocking slv_mon_cb,input presetn);
//-----------------------------------------------------------------------
endinterface : apb_if
