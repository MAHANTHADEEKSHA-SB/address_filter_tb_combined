//*****************************************************//
//    COMPONENT : SCOREBOARD                           //
//    AUTHOR    : Mahantha Deeksha S B (WS1259)        //
//    FILE      : scoreboard.sv                        //
//*****************************************************//
//------------------------------------------------------------------------------
// imp decl macro for two different imp ports
`uvm_analysis_imp_decl(_slv)
`uvm_analysis_imp_decl(_ahb)
`uvm_analysis_imp_decl(_apb)
//------------------------------------------------------------------------------
class scoreboard extends uvm_scoreboard;
   //-
   local int txn_match;
   local int txn_mismatch;
   local int cfg_err_count;
   local int total_ahb_txn;
   local int total_mem_txn;

   bit [`ADDR_WIDTH - 1 : 0] start_addr;
   bit [`ADDR_WIDTH - 1 : 0] end_addr;
   bit [1 : 0]               ctrl_reg;
   //-
   ahb_m_seq_item ahb_txn [$]; 
   //-
   bit [`DATA_WIDTH - 1 : 0] mem_txn [$];
   // ahb master analysis imp
   uvm_analysis_imp_ahb #(ahb_m_seq_item,scoreboard) ahb_master_imp;
   // slave analysis imp
   uvm_analysis_imp_slv #(mem_seq_item,scoreboard) slave_imp;
   // apb master analysis port
   uvm_analysis_imp_apb #(apb_transfer,scoreboard) apb_master_imp;
   // factory registration
   `uvm_component_utils(scoreboard)
   
   // constructor
   function new(string name = "scoreboard",uvm_component parent);
      super.new(name,parent);
   endfunction : new
   
   // build_phase
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      ahb_master_imp = new("ahb_master_imp",this);
      slave_imp  = new("slave_imp",this);
      apb_master_imp = new("apb_master_imp",this);
   endfunction : build_phase
    
   // master imp write method
   virtual function void write_ahb(ahb_m_seq_item item);
     //item.print();
     if((ctrl_reg != 2'b00) && (ctrl_reg != 2'b10))begin
       if(!((item.haddr >= start_addr) && (item.haddr <= end_addr)) && (ctrl_reg == 2'b01))begin
         ahb_txn.push_back(item);
         total_ahb_txn = total_ahb_txn + 1;
       end
       if(ctrl_reg == 2'b11)begin
         if((item.haddr >= start_addr)&&(item.haddr <= end_addr))begin
           ahb_txn.push_back(item);
           total_ahb_txn = total_ahb_txn + 1;
         end
       end
     end
     else if(!($isunknown(item.haddr)))begin
       ahb_txn.push_back(item);
       total_ahb_txn = total_ahb_txn + 1;
     end
     //`uvm_info(get_type_name(),$sformatf("the total txn in queue : \t%0d",ahb_txn.size()),UVM_DEBUG)
     //`uvm_info(get_type_name(),$sformatf("the haddr : \t%0h",item.haddr),UVM_DEBUG)
   endfunction : write_ahb

   // slave imp write method
   virtual function void write_slv(mem_seq_item item);
     ahb_m_seq_item req;
     total_mem_txn = total_mem_txn + 1;
     item.print();
     `uvm_info(get_type_name(),$sformatf("the total txn in queue : \t%0d",ahb_txn.size()),UVM_DEBUG)
     req = ahb_m_seq_item :: type_id :: create("req");
     if(ahb_txn.size() > 0)begin
       req = ahb_txn.pop_front();
       req.print();
       if((req.haddr == item.addr) && (req.hwdata[0] == item.wr_data) &&(req.hwrite == AHB_WRITE))begin
         `uvm_info(get_type_name(),"\tpassed",UVM_HIGH)
         txn_match = txn_match + 1;
         //item.print();
         //req.print();
       end
       else if((req.haddr == item.addr) && (item.wr_data == req.hrdata[0]) &&(req.hwrite == AHB_READ))begin
         `uvm_info(get_type_name(),"\tpassed",UVM_HIGH)
         txn_match = txn_match + 1;
         //item.print();
         //req.print();
       end
       else begin
         `uvm_info(get_type_name(),"\tFAILED",UVM_HIGH)
         txn_mismatch = txn_mismatch + 1;
         //item.print();
         //req.print();
       end
     `uvm_info(get_type_name(),$sformatf("the total txn in queue : \t%0d",ahb_txn.size()),UVM_DEBUG)
     end
   endfunction : write_slv
   //
   virtual function void write_apb(apb_transfer item);
      //item.print();
     
     if((item.paddr == 'h00) && (item.pwrite == APB_WRITE))
       begin
         start_addr = item.pwdata;
       end
     else if((item.paddr == 'h00) && (item.pwrite == APB_READ)) begin
       if(item.prdata == start_addr)begin
         `uvm_info(get_type_name(),$sformatf("the start_address is matching"),UVM_MEDIUM)
       end
       else begin
         `uvm_info(get_type_name(),$sformatf("the start_address mis_matching"),UVM_MEDIUM)
         cfg_err_count = cfg_err_count + 1;
       end
     end
     if((item.paddr == 'h04) && (item.pwrite == APB_WRITE))
       begin
       end_addr = item.pwdata;
       end
     else if((item.paddr == 'h04) && (item.pwrite == APB_READ)) begin
       if(item.prdata == end_addr)begin
         `uvm_info(get_type_name(),$sformatf("the end_address is matching"),UVM_MEDIUM)
       end
       else begin
         `uvm_info(get_type_name(),$sformatf("the end_address mis_matching"),UVM_MEDIUM)
         cfg_err_count = cfg_err_count + 1;
       end
     end
     if((item.paddr == 'h08) && (item.pwrite == APB_WRITE))
       begin
         ctrl_reg = item.pwdata;
       end
     else if((item.paddr == 'h08) && (item.pwrite == APB_READ)) begin
       if(item.prdata == ctrl_reg)begin
         `uvm_info(get_type_name(),$sformatf("the start_address is matching"),UVM_MEDIUM)
       end
       else begin
         `uvm_info(get_type_name(),$sformatf("the start_address mis_matching"),UVM_MEDIUM)
         cfg_err_count = cfg_err_count + 1;
       end
     end
     //`uvm_info(get_type_name(),$sformatf("local end_addr : \t%0d",end_addr),UVM_MEDIUM)
   endfunction : write_apb
   // run_phase
   virtual task run_phase(uvm_phase phase);
     
   endtask : run_phase
  
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("\n\tcfg_err_count : [ %0d ]\ttotal_ahb_txn : [%0d]\ttotal_mem_txn : [%0d]",cfg_err_count,total_ahb_txn,total_mem_txn),UVM_MEDIUM)
    if((txn_mismatch > 0) || (cfg_err_count != 0))begin
      `uvm_info(get_type_name(),$sformatf("\n\tTEST_FAILED\ttxn_match count: [ %0d ] txn_mismatch count: [ %0d ]",txn_match,txn_mismatch),UVM_MEDIUM)
    end
    else begin
      `uvm_info(get_type_name(),$sformatf("\n\tTEST_PASSED\ttxn_match count: [ %0d ] txn_mismatch count: [ %0d ]",txn_match,txn_mismatch),UVM_MEDIUM)
    end
   
  endfunction : report_phase
endclass : scoreboard
//------------------------------------------------------------------------------
