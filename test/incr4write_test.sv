class incr4_write_test extends base_test;
  incr4_write_seq v_seq;
  `uvm_component_utils(incr4_write_test)
  
  function new(string name = "ahb_write_test",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    v_seq = incr4_write_seq :: type_id :: create("v_seq"); 
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    v_seq.start(environment.v_seqr);
    #30;
    phase.drop_objection(this);
  endtask : run_phase
  
endclass : incr4_write_test