class ahb_incr4_write_seq extends ahb_m_base_seq;
  `uvm_object_utils(ahb_incr4_write_seq)
  rand bit [`ADDR_WIDTH - 1 : 0] start_addr;
  rand bit [`ADDR_WIDTH - 1 : 0] end_addr;
  function new(string name = "ahb_incr4_write_seq");
    super.new(name);
  endfunction : new
  
  task body();
    ahb_m_seq_item trans;
    trans = ahb_m_seq_item :: type_id :: create("trans");
    start_item(trans);
    assert(trans.randomize() with {hsize == WORD;
                                   hburst == INCR4;
                                   hwrite == AHB_WRITE;
                                   haddr inside {[start_addr : end_addr]};
                                   no_of_busy == 0;
                                   });
    finish_item(trans);
    get_response(trans);
    //trans.print();
  endtask : body
endclass : ahb_incr4_write_seq