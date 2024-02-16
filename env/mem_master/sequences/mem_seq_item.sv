class mem_seq_item extends uvm_sequence_item;
  
  //`uvm_object_utils(mem_seq_item)
  
  bit [`ADDR_WIDTH - 1:0] addr;
  bit [`DATA_WIDTH - 1:0] wr_data;
  bit rd_en;
  bit wr_en;
  bit [`DATA_WIDTH - 1:0] rd_data;
  
  `uvm_object_utils_begin(mem_seq_item)
  `uvm_field_int(addr,UVM_DEFAULT)
  `uvm_field_int(wr_data,UVM_DEFAULT)
  `uvm_field_int(rd_en,UVM_DEFAULT)
  `uvm_field_int(wr_en,UVM_DEFAULT)
  `uvm_field_int(rd_data,UVM_DEFAULT)
  `uvm_object_utils_end
  

  
  function new(string name = "mem_seq_item");
    super.new(name);
  endfunction
  
  
endclass


