//*****************************************************//
//    COMPONENT : ENVIRONMENT                          //
//    AUTHOR    : Mahantha Deeksha S B (WS1259)        //
//    FILE      : env.sv                               //
//*****************************************************//
//-----------------------------------------------------------------------------
class env extends uvm_env;
   // virtual sequencer
   virtual_sequencer v_seqr;
   // apb_config
   apb_config cfg;
   //ahb master agent
   ahb_m_agent ahb_master;
   // apb master agent
   apb_master_agent apb_master;
   // slave agent
   mem_agent mem_agt;
   // scoreboard handle
   scoreboard sco;
   // coverage handle
   coverage cov;
  
   // factory registration
   `uvm_component_utils(env)
   
   // constructor method
   function new(string name = "env",uvm_component parent);
      super.new(name,parent);
   endfunction : new

   // build_phase
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     
      if(uvm_config_db #(apb_config) :: get(this, "*", "cfg", cfg))begin
        `uvm_info(get_type_name(), "got config from config_db",UVM_MEDIUM)end
      v_seqr = virtual_sequencer :: type_id :: create("v_seqr",this);
      ahb_master = ahb_m_agent :: type_id :: create("ahb_master",this);
      apb_master = apb_master_agent :: type_id :: create("apb_master",this);
      mem_agt = mem_agent :: type_id :: create("mem_agt",this);
      sco = scoreboard :: type_id :: create("scoreboard",this);
      cov = coverage :: type_id :: create("cov",this);
   endfunction : build_phase

   // connect_phase
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      v_seqr.ahb_sequencer = ahb_master.m_sequencer;
      v_seqr.apb_sequencer = apb_master.sequencer;
      v_seqr.mem_seqr      = mem_agt.sequencer;
      ahb_master.master_agent_ap.connect(sco.ahb_master_imp);
      apb_master.master_agent_ap.connect(sco.apb_master_imp);
      mem_agt.mon.mem_ap.connect(sco.slave_imp);
     
      ahb_master.master_agent_ap.connect(cov.ahb_imp);
      apb_master.master_agent_ap.connect(cov.apb_imp);
      mem_agt.mon.mem_ap.connect(cov.mem_imp);
   endfunction : connect_phase
endclass : env
