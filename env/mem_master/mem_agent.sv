class mem_agent extends uvm_agent;
  mem_sequencer sequencer;
  `uvm_component_utils(mem_agent)
  mem_monitor mon;
  
  function new(string name = "mem_agent",uvm_component parent);
    
    super.new(name,parent);
    
  endfunction
 
  function void build_phase(uvm_phase phase);
    mon = mem_monitor :: type_id::create("mon",this);
    sequencer = mem_sequencer :: type_id :: create("sequencer",this);
  endfunction
  

  
endclass