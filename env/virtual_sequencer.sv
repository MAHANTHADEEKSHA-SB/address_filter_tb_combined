class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);
  apb_master_sequencer apb_sequencer;
  ahb_m_sequencer      ahb_sequencer;
  mem_sequencer        mem_seqr;
  `uvm_component_utils_begin(virtual_sequencer)
    `uvm_field_object(apb_sequencer,UVM_DEFAULT|UVM_REFERENCE)
    `uvm_field_object(ahb_sequencer,UVM_DEFAULT|UVM_REFERENCE)
    `uvm_field_object(mem_seqr,UVM_DEFAULT|UVM_REFERENCE)
  `uvm_component_utils_end
  
  function new(string name = "virtual_sequencer",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase
endclass : virtual_sequencer