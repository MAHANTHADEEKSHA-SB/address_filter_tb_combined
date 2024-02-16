class filt_on_ex_off_test_2 extends base_test;
  filt_on_ex_off_seq_2 seq;
  
  `uvm_component_utils(filt_on_ex_off_test_2)
  
  function new(string name = "filt_on_ex_off_test_2",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = filt_on_ex_off_seq_2 :: type_id :: create("seq");
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
      seq.start(environment.v_seqr);
      #20;
    phase.drop_objection(this);
  endtask : run_phase
endclass : filt_on_ex_off_test_2