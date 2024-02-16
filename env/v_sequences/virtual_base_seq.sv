class virtual_base_seq extends uvm_sequence#(uvm_sequence_item);
  apb_write_seq apb_w_seq;
  apb_read_seq  apb_r_seq;
  ahb_write_seq ahb_w_seq;
  
  `uvm_object_utils(virtual_base_seq)
  
  `uvm_declare_p_sequencer(virtual_sequencer)
  
  function new(string name = "virtual_base_seq");
    super.new(name);
  endfunction : new
  
  virtual task body();
    apb_w_seq = apb_write_seq :: type_id :: create("apb_w_seq");
    apb_r_seq = apb_read_seq :: type_id :: create("apb_r_seq");
    ahb_w_seq = ahb_write_seq :: type_id :: create("ahb_w_seq");
  endtask : body
endclass : virtual_base_seq