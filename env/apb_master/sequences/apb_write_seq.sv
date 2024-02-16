class apb_write_seq extends apb_base_seq;
  rand bit [`ADDR_WIDTH - 1 : 0] addr;
  rand bit [`DATA_WIDTH - 1 : 0] range_1;
  rand bit [`DATA_WIDTH - 1 : 0] range_2;
  
  constraint c{range_1 <= range_2;}
  `uvm_object_utils(apb_write_seq)
  
  function new(string name = "apb_write_seq");
    super.new(name);
  endfunction : new
  
  virtual task body();
    apb_transfer trans;
    trans = apb_transfer :: type_id :: create("trans");
    start_item(trans);
    assert(trans.randomize() with {this.paddr == addr;
                                   this.pwdata inside {[range_1 : range_2]};
                                   trans.pwrite == APB_WRITE;
                                   trans.delay_kind == ZERO;
                                   trans.pslverr == 1'b1;
                                   });
    finish_item(trans);
  endtask : body
endclass : apb_write_seq
