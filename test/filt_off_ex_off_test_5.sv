class filt_off_ex_off_test_5 extends base_test;
  filt_off_ex_off_seq_5 seq;
  
  `uvm_component_utils(filt_off_ex_off_test_5)

  function new(string name = "filt_off_ex_off_test_5",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = filt_off_ex_off_seq_5 :: type_id :: create("seq");
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
      seq.start(environment.v_seqr);
      #20;
    phase.drop_objection(this);
  endtask : run_phase
  
endclass : filt_off_ex_off_test_5