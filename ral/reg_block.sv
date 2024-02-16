//reg block contains all registers created in reg file and defines a address map

class reg_block extends uvm_reg_block;
  
  `uvm_object_utils(reg_block)
  
  //registers 
  
  rand start_addr_reg s_addr;
  rand end_addr_reg e_addr;
  rand ctrl_reg ctrl;
  
  
  //define register map
  uvm_reg_map bus_map;
  
  function new(string name = "reg_block",int has_coverage = UVM_NO_COVERAGE);
    super.new(name,has_coverage);
  endfunction
  
  //create configure and call the build method of each registers in this block
  virtual function void build();
    s_addr = start_addr_reg::type_id::create("s_addr");
    //function void configure (uvm_reg_block blk_parent,uvm_reg_file regfile_parent	 = 	null,string hdl_path= 	"")
    s_addr.configure(.blk_parent(this));
    s_addr.build();
    
    e_addr = end_addr_reg::type_id::create("e_addr");
    e_addr.configure(.blk_parent(this));
    e_addr.build();
    
    
    ctrl = ctrl_reg::type_id::create("ctrl");
    ctrl.configure(.blk_parent(this));
    ctrl.build();
    
    //creating,configureing and adding hdl path to each memory instances
   // add_hdl_path("tb_top.DUT","RTL");
   
   
    
  
    //create an address map for this block
    //n-bytes - byte width of the bus on which the map is used
    //byte - addressing specifies whether consecutive addresses refer are 1 byte apart (TRUE) or n_bytes apart (FALSE). Default is TRUE.
    bus_map = create_map(.name("bus_map"),.base_addr(32'h0),.n_bytes(4),.endian(UVM_LITTLE_ENDIAN),.byte_addressing(0));
    

    bus_map.add_reg(s_addr,32'h0,"RW");
    bus_map.add_reg(e_addr,32'h4,"RW");
    bus_map.add_reg(ctrl,32'h8,"RW");
    
    lock_model();//finalise the address mapping
    
  endfunction
  
endclass : reg_block
