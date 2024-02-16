class apb_read_seq extends apb_base_seq;
  rand bit [`ADDR_WIDTH - 1 : 0] addr;
  `uvm_object_utils(apb_read_seq)
  
  function new(string name = "apb_read_seq");
    super.new(name);
  endfunction : new
  
  virtual task body();
    apb_transfer trans;
    trans = apb_transfer :: type_id :: create("trans");
    start_item(trans);
    assert(trans.randomize() with {trans.paddr == addr;
                                   trans.pwdata == 0;
                                   trans.pwrite == APB_READ;
                                   trans.delay_kind == ZERO;
                                   trans.pslverr == 1'b1;
                                   });
    finish_item(trans);
  endtask : body
endclass : apb_read_seq
