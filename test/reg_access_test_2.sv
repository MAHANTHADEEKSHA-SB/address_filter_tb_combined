class reg_access_test_2 extends base_test;
  reg_access_seq_2 seq;
  `uvm_component_utils(reg_access_test_2)
  
  function new(string name = "reg_access_test",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = reg_access_seq_2 :: type_id :: create("seq");
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
      seq.start(environment.v_seqr);
    phase.drop_objection(this);
  endtask : run_phase
endclass : reg_access_test_2