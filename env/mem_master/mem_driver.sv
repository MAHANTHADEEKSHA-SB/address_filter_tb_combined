class mem_driver extends uvm_driver#(mem_seq_item);
  
  `uvm_component_utils(mem_driver)
  
  function new(string name = "mem_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
  endtask
  
endclass