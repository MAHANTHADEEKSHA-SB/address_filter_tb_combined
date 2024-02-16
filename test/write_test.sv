class write_test extends base_test;
  ahb_m_write_seq seqa;
  apb_write_seq seq;
  apb_read_seq seq_r;
  
  virtual_write_seq v_seq;
  `uvm_component_utils(write_test)
  
  function new(string name = "ahb_write_test",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqa = ahb_m_write_seq :: type_id :: create("seqa");
    seq = apb_write_seq :: type_id :: create("seq");
    seq_r = apb_read_seq :: type_id :: create("seqr");
    v_seq = virtual_write_seq :: type_id :: create("v_seq"); 
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    v_seq.start(environment.v_seqr);
    #30;
    phase.drop_objection(this);
  endtask : run_phase
  
endclass : write_test
