class filt_on_ex_on_seq_1 extends virtual_base_seq;
  `uvm_object_utils(filt_on_ex_on_seq_1)
  
  function new(string name = "filt_on_ex_on_seq_1");
    super.new(name);
  endfunction : new
  
  task body();
    super.body();
    assert(apb_w_seq.randomize() with {addr == 0; range_1 == 'h10; range_2 == 'h10;});
     apb_w_seq.start(p_sequencer.apb_sequencer);
    assert(apb_w_seq.randomize() with {addr == 4;  range_1 == 'h0000_7fff; range_2 == 'h0000_7fff;})
     apb_w_seq.start(p_sequencer.apb_sequencer);
    assert(apb_w_seq.randomize() with {addr == 8;  range_1 == 'b11; range_2 == 'b11;});
     apb_w_seq.start(p_sequencer.apb_sequencer);
     assert(apb_w_seq.randomize() with {addr == 12;  range_1 inside {[`START_ADDR : 'h4F]}; range_2 inside {['h50 : `END_ADDR]};});
     apb_w_seq.start(p_sequencer.apb_sequencer);
    
    repeat(9)begin
      assert(ahb_w_seq.randomize() with {addr dist {[32'h0000_0000 : 32'h0010] :/ 1,[32'h000_020 : 32'h000_7FFF] :/ 1,[32'h0000_7fff : 32'h0000_9FFF] :/ 1};
                                         addr[1 : 0] == 2'b00;
                                         if ((burst == INCR4)) {(addr[10:0] <= (1024 - (4 * (2 ** size))));}
                                         burst == INCR4;
                                         size  == WORD;
                                         });
      ahb_w_seq.start(p_sequencer.ahb_sequencer);
    end
  endtask : body
endclass : filt_on_ex_on_seq_1