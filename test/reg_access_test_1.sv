class reg_access_test_1 extends base_test;
  reg_access_seq_1 seq;
  `uvm_component_utils(reg_access_test_1)
  
  function new(string name = "reg_access_test_1",uvm_component parent);
    super.new(name,parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = reg_access_seq_1 :: type_id :: create("seq");
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    seq.start(environment.v_seqr);
    phase.drop_objection(this);
  endtask : run_phase
endclass : reg_access_test_1