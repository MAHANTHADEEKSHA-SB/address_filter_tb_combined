class reg_access_seq_2 extends virtual_base_seq;
  `uvm_object_utils(reg_access_seq_2)
  
  function new(string name = "reg_access_seq_2");
    super.new(name);
  endfunction : new
  
  task body();
    super.body();
     assert(apb_w_seq.randomize() with {addr == 0; range_1 inside {[`START_ADDR : 'h4F]}; range_2 inside {['h50 : `END_ADDR]};})
     apb_w_seq.start(p_sequencer.apb_sequencer);
     assert(apb_w_seq.randomize() with {addr == 4;  range_1 inside {[`START_ADDR : 'h4F]}; range_2 inside {['h50 : `END_ADDR]};})
     apb_w_seq.start(p_sequencer.apb_sequencer);
     assert(apb_w_seq.randomize() with {addr == 8;  range_1 inside {[`START_ADDR : 'h4F]}; range_2 inside {['h50 : `END_ADDR]};})
     apb_w_seq.start(p_sequencer.apb_sequencer);
     assert(apb_w_seq.randomize() with {addr == 12;  range_1 inside {[`START_ADDR : 'h4F]}; range_2 inside {['h50 : `END_ADDR]};})
     apb_w_seq.start(p_sequencer.apb_sequencer);
    
     assert(apb_r_seq.randomize() with {addr == 0;})
     apb_r_seq.start(p_sequencer.apb_sequencer);
     assert(apb_r_seq.randomize() with {addr == 4;})
     apb_r_seq.start(p_sequencer.apb_sequencer);
     assert(apb_r_seq.randomize() with {addr == 8;})
     apb_r_seq.start(p_sequencer.apb_sequencer);
     assert(apb_r_seq.randomize() with {addr == 12;})
     apb_r_seq.start(p_sequencer.apb_sequencer);
  endtask : body
endclass : reg_access_seq_2