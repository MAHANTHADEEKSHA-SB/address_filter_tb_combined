class reg2bus_adapter extends uvm_reg_adapter;
  
  `uvm_object_utils(reg2bus_adapter)

  function new(string name = "reg2bus_adapter");
    super.new(name);
  endfunction
  
  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    
    apb_sequence_item item ;
    item = apb_sequence_item::type_id::create("item");
    item.wr_rd = (rw.kind == UVM_READ )? 0 : 1;
    item.addr = rw.addr;
    if(item.wr_rd)
        item.data = rw.data;
    else
      item.data = '0;
    
    return item;
  endfunction
    
  function void bus2reg(uvm_sequence_item bus_item ,ref uvm_reg_bus_op rw);
    
    apb_sequence_item item;
    if(!$cast(item,bus_item))
      `uvm_fatal(get_type_name(),"provided bus_item is not of correct type")
    rw.kind = item.wr_rd ? UVM_WRITE:UVM_READ;
    rw.addr = item.addr;
    if(rw.kind == UVM_READ)      
      rw.data = item.prdata;
    else
      rw.data = item.data;
    
    rw.status = UVM_IS_OK;
    
  endfunction
  
  
endclass:reg2bus_adapter
