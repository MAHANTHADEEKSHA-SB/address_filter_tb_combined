class virtual_write_seq extends uvm_sequence#(uvm_sequence_item);
  apb_write_seq   apb_w_seq;
  apb_read_seq    apb_r_seq;
  ahb_m_write_seq ahb_w_seq;
  
  
  `uvm_object_utils_begin(virtual_write_seq)
    `uvm_field_object(apb_w_seq,UVM_DEFAULT|UVM_REFERENCE)
    `uvm_field_object(apb_r_seq,UVM_DEFAULT|UVM_REFERENCE)
    `uvm_field_object(ahb_w_seq,UVM_DEFAULT|UVM_REFERENCE)
  `uvm_object_utils_end
  
  `uvm_declare_p_sequencer(virtual_sequencer)
  
  function new(string name = "virtual_write_seq");
    super.new(name);
  endfunction : new
  
  task body();
    apb_w_seq = apb_write_seq :: type_id :: create("apb_w_seq");
    apb_r_seq = apb_read_seq :: type_id :: create("apb_r_seq");
    ahb_w_seq = ahb_m_write_seq :: type_id :: create("ahb_w_seq");
    
    apb_w_seq.start(p_sequencer.apb_sequencer);
    apb_r_seq.start(p_sequencer.apb_sequencer);
    repeat(2)begin
    ahb_w_seq.start(p_sequencer.ahb_sequencer);
    end
  endtask : body
  
endclass : virtual_write_seq
