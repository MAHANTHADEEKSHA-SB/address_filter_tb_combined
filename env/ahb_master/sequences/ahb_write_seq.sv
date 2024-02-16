class ahb_write_seq extends ahb_m_base_seq;
  rand bit[`ADDR_WIDTH - 1 : 0] addr;
  //rand bit[`ADDR_WIDTH - 1 : 0] end_addr;
  
  rand hburst_e burst;
  rand hsize_e size;
  /*
  constraint c_hsize { (8*(2**hsize)) <= `ADDR_WIDTH;}
  
  constraint c_allign {solve hsize before start_addr;
                       solve hsize before end_addr;
                       (hsize == HALFWORD)    -> {start_addr[0] == 1'b0; end_addr[0] == 1'b0;}
                       (hsize == WORD)        -> {start_addr[1 : 0] == 2'b00;end_addr[1 : 0] == 2'b00;}
                       (hsize == DOUBLEWORD)  -> {start_addr[2 : 0] == 3'b000;end_addr[2 : 0] == 3'b000;}
                       (hsize == WORD_LINE_4) -> {start_addr[3 : 0] == 4'b0000;end_addr[3 : 0] == 4'b0000;}
                       (hsize == WORD_LINE_8) -> {start_addr[4 : 0] == 5'b00000;end_addr[4 : 0] == 5'b00000;}
                       (hsize == WORD_512)    -> {start_addr[5 : 0] == 6'b000000;end_addr[5 : 0] == 6'b000000;}
                       (hsize == WORD_1024)   -> {start_addr[6 : 0] == 7'b0000000;end_addr[6 : 0] == 7'b0000000;}
                       }
  */
  `uvm_object_utils(ahb_write_seq)
  
  function new(string name = "ahb_write_seq");
    super.new(name);
  endfunction : new
  
  task body();
    ahb_m_seq_item req;
    req = ahb_m_seq_item :: type_id :: create("req");
    start_item(req);
    assert(req.randomize() with {req.haddr == addr;
                                 req.hburst == burst;
                                 req.hsize == size;
                                 req.hwrite == AHB_WRITE;
                                 req.no_of_busy == 0;
                                });
    finish_item(req);
    
  endtask : body
endclass : ahb_write_seq