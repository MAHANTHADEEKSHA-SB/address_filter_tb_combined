class filt_off_ex_off_test_3 extends base_test;
  filt_off_ex_off_seq_3 seq;
  
  `uvm_component_utils(filt_off_ex_off_test_3)
  
  function new(string name = "filt_off_ex_off_test_3",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = filt_off_ex_off_seq_3 :: type_id :: create("seq");
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
      seq.start(environment.v_seqr);
      #20;
    phase.drop_objection(this);
  endtask : run_phase
endclass : filt_off_ex_off_test_3 