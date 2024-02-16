class incr4_write_seq extends uvm_sequence#(uvm_sequence_item);
  rand apb_write_seq   apb_w_seq;
  rand apb_read_seq    apb_r_seq;
  rand ahb_incr4_write_seq ahb_w_seq;
  
  
  `uvm_object_utils_begin(incr4_write_seq)
    `uvm_field_object(apb_w_seq,UVM_DEFAULT)
    `uvm_field_object(apb_r_seq,UVM_DEFAULT)
    `uvm_field_object(ahb_w_seq,UVM_DEFAULT)
  `uvm_object_utils_end
  
  `uvm_declare_p_sequencer(virtual_sequencer)
  
  function new(string name = "virtual_write_seq");
    super.new(name);
  endfunction : new
  
  task body();
    apb_w_seq = apb_write_seq :: type_id :: create("apb_w_seq");
    apb_r_seq = apb_read_seq :: type_id :: create("apb_r_seq");
    ahb_w_seq = ahb_incr4_write_seq :: type_id :: create("ahb_w_seq");
    assert(ahb_w_seq.randomize() with {start_addr == 'h34;end_addr == 'h34;});
    assert(apb_w_seq.randomize() with {addr == 'h4;range_1 == 'h34; range_2 == 'h34;});
    assert(apb_r_seq.randomize() with {addr == 'h4;});
    apb_w_seq.start(p_sequencer.apb_sequencer);
    apb_r_seq.start(p_sequencer.apb_sequencer);
    repeat(2)begin
    ahb_w_seq.start(p_sequencer.ahb_sequencer);
      
    end
  endtask : body
  
endclass : incr4_write_seq