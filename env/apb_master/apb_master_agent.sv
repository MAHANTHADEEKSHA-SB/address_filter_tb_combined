class apb_master_agent extends uvm_agent;
  apb_config cfg;
  
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  
  uvm_analysis_port #(apb_transfer) master_agent_ap;
  
  apb_master_sequencer sequencer;
  apb_master_driver driver;
  apb_master_monitor monitor;
  
  `uvm_component_utils_begin(apb_master_agent)
     `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
  `uvm_component_utils_end
  
  function new(string name = "apb_master_agent",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass : apb_master_agent
    
    function void apb_master_agent :: build_phase(uvm_phase phase);
      super.build_phase(phase);
      master_agent_ap = new("master_agent_ap",this);
      
      monitor = apb_master_monitor :: type_id :: create("apb_master_monitor",this);
      if(is_active == UVM_ACTIVE)begin
        sequencer = apb_master_sequencer :: type_id :: create("apb_master_sequencer",this);
        driver = apb_master_driver :: type_id :: create("apb_master_driver",this);
      end
      
    endfunction : build_phase
    
    function void apb_master_agent :: connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      monitor.monitor_ap.connect(master_agent_ap);
      if(is_active == UVM_ACTIVE)begin
        driver.seq_item_port.connect(sequencer.seq_item_export);
        driver.rsp_port.connect(sequencer.rsp_export);
      end
      
    endfunction : connect_phase
