
class filt_on_ex_off_seq_7 extends virtual_base_seq;
  bit [`ADDR_WIDTH - 1 : 0] temp;
  
  `uvm_object_utils(filt_on_ex_off_seq_7)
  
  function new(string name = "filt_on_ex_off_seq_7");
    super.new(name);
  endfunction : new
  
  task body();
     super.body();
     assert(apb_w_seq.randomize() with {addr == 0; solve range_2 before range_1;range_1 == range_2;});
     temp = apb_w_seq.range_2;
     apb_w_seq.start(p_sequencer.apb_sequencer);
     assert(apb_w_seq.randomize() with {addr == 4;  solve range_2 before range_1;range_1 == range_2; range_2 > temp;});
     apb_w_seq.start(p_sequencer.apb_sequencer);
    assert(apb_w_seq.randomize() with {addr == 8;  range_1 == 'b01; range_2 == 'b01;})
     apb_w_seq.start(p_sequencer.apb_sequencer);
     assert(apb_w_seq.randomize() with {addr == 12;  range_1 inside {[`START_ADDR : 'h4F]}; range_2 inside {['h50 : `END_ADDR]};});
     apb_w_seq.start(p_sequencer.apb_sequencer);
    
    repeat(9)begin
      assert(ahb_w_seq.randomize() with {addr dist {[32'h0000_0000 : 32'h009f] :/ 1,[32'h000_020 : 32'h000_7FFF] :/ 1,[32'h0000_00ff : 32'hffff_ffff] :/ 1};
                                         addr[1 : 0] == 2'b00;
                                         if ((burst == INCR4)) {(addr[10:0] <= (1024 - (4 * (2 ** size))));}
                                         burst == INCR4;
                                         size  == WORD;
                                         });
      ahb_w_seq.start(p_sequencer.ahb_sequencer);
    end
  endtask : body
endclass : filt_on_ex_off_seq_7