 //*****************************************************//
//    COMPONENT : AHB_TOP_TB                           //
//    AUTHOR    : Mahantha Deeksha S B (WS1259)        //
//    FILE      : ahb_top.sv                           //
//*****************************************************//
// Top testbench module

// To include uvm macros source library file
`include "uvm_macros.svh"

// To import uvm package
import uvm_pkg :: *;

`include "ahb_defines.sv"
`include "apb_defines.sv"
//
`include "ahb_interface.sv"
`include "apb_if.sv"
//
`include "apb_config.sv"
//
`include "ahb_m_seq_item.sv"
`include "apb_transfer.sv"
`include "mem_seq_item.sv"
//
`include "ahb_m_base_seq.sv"
`include "apb_base_seq.sv"
//
`include "ahb_write_seq.sv"
`include "apb_write_seq.sv"
`include "apb_read_seq.sv"
//
`include "ahb_incr4_write_seq.sv"
//
`include "ahb_m_sequencer.sv"
`include "apb_master_sequencer.sv"
`include "mem_sequencer.sv"
`include "virtual_sequencer.sv"
//
`include "virtual_base_seq.sv"
//
`include "reg_access_seq_1.sv"
`include "reg_access_seq_2.sv"
`include "filt_off_ex_off_seq_1.sv"
`include "filt_off_ex_off_seq_2.sv"
`include "filt_off_ex_off_seq_3.sv"
`include "filt_off_ex_off_seq_4.sv"
`include "filt_off_ex_off_seq_5.sv"
`include "filt_off_ex_off_seq_6.sv"
`include "filt_off_ex_off_seq_7.sv"
`include "filt_off_ex_off_seq_8.sv"
//
`include "filt_off_ex_on_seq_1.sv"
`include "filt_off_ex_on_seq_2.sv"
`include "filt_off_ex_on_seq_3.sv"
`include "filt_off_ex_on_seq_4.sv"
`include "filt_off_ex_on_seq_5.sv"
`include "filt_off_ex_on_seq_6.sv"
`include "filt_off_ex_on_seq_7.sv"
`include "filt_off_ex_on_seq_8.sv"
//
`include "filt_on_ex_on_seq_1.sv"
`include "filt_on_ex_on_seq_2.sv"
`include "filt_on_ex_on_seq_3.sv"
`include "filt_on_ex_on_seq_4.sv"
`include "filt_on_ex_on_seq_5.sv"
`include "filt_on_ex_on_seq_6.sv"
`include "filt_on_ex_on_seq_7.sv"
`include "filt_on_ex_on_seq_8.sv"
//
`include "filt_on_ex_off_seq_1.sv"
`include "filt_on_ex_off_seq_2.sv"
`include "filt_on_ex_off_seq_3.sv"
`include "filt_on_ex_off_seq_4.sv"
`include "filt_on_ex_off_seq_5.sv"
`include "filt_on_ex_off_seq_6.sv"
`include "filt_on_ex_off_seq_7.sv"
`include "filt_on_ex_off_seq_8.sv"
//
`include "incr4_write_seq.sv"
//
`include "ahb_m_driver.sv"
`include "apb_master_driver.sv"
`include "mem_driver.sv"
//
`include "ahb_m_monitor.sv"
`include "apb_master_monitor.sv"
`include "mem_monitor.sv"
//
`include "ahb_m_agent.sv"
`include "apb_master_agent.sv"
`include "mem_agent.sv"
//
`include "reg_file.sv"
`include "reg_block.sv"
//`include "reg2bus_adapter.sv"
`include "scoreboard.sv"
//
`include "coverage.sv"
//
`include "env.sv"
//
`include "base_test.sv"
`include "reg_access_test_1.sv"
`include "reg_access_test_2.sv"
//
`include "filt_off_ex_off_test_1.sv"
`include "filt_off_ex_off_test_2.sv"
`include "filt_off_ex_off_test_3.sv"
`include "filt_off_ex_off_test_4.sv"
`include "filt_off_ex_off_test_5.sv"
`include "filt_off_ex_off_test_6.sv"
`include "filt_off_ex_off_test_7.sv"
`include "filt_off_ex_off_test_8.sv"
//
`include "filt_off_ex_on_test_1.sv"
`include "filt_off_ex_on_test_2.sv"
`include "filt_off_ex_on_test_3.sv"
`include "filt_off_ex_on_test_4.sv"
`include "filt_off_ex_on_test_5.sv"
`include "filt_off_ex_on_test_6.sv"
`include "filt_off_ex_on_test_7.sv"
`include "filt_off_ex_on_test_8.sv"
//
`include "filt_on_ex_on_test_1.sv"
`include "filt_on_ex_on_test_2.sv"
`include "filt_on_ex_on_test_3.sv"
`include "filt_on_ex_on_test_4.sv"
`include "filt_on_ex_on_test_5.sv"
`include "filt_on_ex_on_test_6.sv"
`include "filt_on_ex_on_test_7.sv"
`include "filt_on_ex_on_test_8.sv"
//
`include "filt_on_ex_off_test_1.sv"
`include "filt_on_ex_off_test_2.sv"
`include "filt_on_ex_off_test_3.sv"
`include "filt_on_ex_off_test_4.sv"
`include "filt_on_ex_off_test_5.sv"
`include "filt_on_ex_off_test_6.sv"
`include "filt_on_ex_off_test_7.sv"
`include "filt_on_ex_off_test_8.sv"
//
`include "incr4write_test.sv"

// Top dut
module tb_top;
   bit hclk,pclock,clk;
   string test_name;
  
  logic                       hresetn;
  logic                       hready;
  logic [1 : 0]               htrans;
  logic [2 : 0]               hburst;
  logic [2 : 0]               hsize;
  logic                       hwrite;
  logic [`ADDR_WIDTH - 1 : 0] haddr;
  logic [`DATA_WIDTH - 1 : 0] hwdata;
  logic [`DATA_WIDTH - 1 : 0] hrdata;
  logic [1 : 0]  hresp;
  
  
  
  ahb_interface ahb_pif(.hclk(hclk));
  
  apb_intf apb_pif(.pclock(pclock));
  //apb_intf apbif(pclock);
  
  mem_intf memif(clk);
  
  memory_controller DUT(.memif(memif),
                        .ahbif(ahb_pif),
                        .apbif(apb_pif));
  
  assign hresetn = ahb_pif.hresetn;
  assign haddr = ahb_pif.haddr;
  assign hwdata = ahb_pif.hwdata;
  assign hrdata = ahb_pif.hrdata;
  assign hwrite = ahb_pif.hwrite;
  assign hready = ahb_pif.hready;
  assign hresp = ahb_pif.hresp;
  assign hsize = ahb_pif.hsize;
  assign hburst = ahb_pif.hburst;
  assign htrans = ahb_pif.htrans;
                       
   initial begin
     $dumpfile("dump.vcd");
     $dumpvars(0, tb_top);
      fork
         // Clock generation thread
         begin
            hclk = 1;
            
            forever #5 hclk = ~hclk;
         end
         begin
           pclock = 1;
           forever #5 pclock = ~pclock;
         end
         begin
           clk = 1;
           forever #5 clk = ~clk;
         end
         // Reset signal generation thread
         // Active low reset signal
         begin
            ahb_pif.hresetn = 1;
            apb_pif.presetn = 1;
            #2 ahb_pif.hresetn = 1'b0;
               apb_pif.presetn = 1'b0;
            repeat(3) @(posedge hclk);
            ahb_pif.hresetn = 1'b1;
            apb_pif.presetn = 1'b1;
            repeat(10)@(posedge hclk);
            //#300 $stop();
         end
        begin
          memif.rst_n = 1;
          #2 memif.rst_n = 0;
          repeat(3) @(posedge clk);
          memif.rst_n = 1;
        end
      join

   end 
   initial begin
      // Setting the virtual interface in config db
      // This interface hanlde can be retireved from any component down the hierarchy
     uvm_config_db #(virtual ahb_interface) :: set (uvm_root :: get(), "*", "ahb_vif", ahb_pif);
     uvm_config_db #(virtual apb_intf) :: set(uvm_root :: get(),"*","apb_vif",apb_pif);
     uvm_config_db #(virtual mem_intf) :: set(uvm_root :: get(),"*","mem_vif",memif);
     run_test();
     

   end

  

endmodule : tb_top

//**************************************EOF******************************************************//
