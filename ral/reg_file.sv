//all register classes are coded in this file


//*******************************************************************************************************************
////addr:'h0 start_addr

//register model is extended from uvm_reg class and each of the fileds are defined as uvm_reg_field. fields are configured in build method
class start_addr_reg extends uvm_reg;
  
  `uvm_object_utils(start_addr_reg) 
  
  rand uvm_reg_field start_addr;
  
  //reg field.value is its mirrored value
  constraint con {start_addr.value[1:0] == 0;} //word alligned 
  
  function new(string name = "start_addr",int unsigned n_bits = 32 ,int has_coverage = UVM_NO_COVERAGE);
    super.new(name,n_bits,has_coverage);
  endfunction
  
  
  virtual function void build();
    
    start_addr = uvm_reg_field::type_id::create("start_addr");
    start_addr.configure(.parent(this),
                  .size(32),
                  .lsb_pos(0),
                  .access("RW"),
                  .volatile(0),
                  .reset(0),   //uvm_reg_data_t reset -> reset value
                  .has_reset(1),
                  .is_rand(1),
                  .individually_accessible(1)); //Check if this field can be written individually, i.e. without affecting other fields in the containing register.
                   
  endfunction
endclass :start_addr_reg


//*******************************************************************************************************************

////addr:'h4
class end_addr_reg extends uvm_reg;
  `uvm_object_utils(end_addr_reg)
 
  rand uvm_reg_field end_addr;
  
   //reg field.value is its mirrored value
  constraint con {end_addr.value[1:0] == 0;} //word alligned 
  
  function new(string name ="end_addr",int unsigned n_bits = 32,int has_coverage = UVM_NO_COVERAGE);
    super.new(name,n_bits,has_coverage);    
  endfunction
  
  virtual function void build();
    
    end_addr = uvm_reg_field::type_id::create("end_addr");
    //data.configure(parent,size,lsb_pos,access,volatile,reset,has_reset,is_rand,individualy_accessibele)
    end_addr.configure(this,32,0,"RW",0,0,1,1,1);
  endfunction
  
endclass:end_addr_reg

//*******************************************************************************************************************
////addr : 'h8
  
class ctrl_reg extends uvm_reg;
  
  `uvm_object_utils(ctrl_reg);
  
  //enable bit
  rand uvm_reg_field en_b;
  //xor bit
  rand uvm_reg_field xor_b;
  
  function new(string name = "ctrl_reg",int unsigned n_bits = 2,int has_coverage = UVM_NO_COVERAGE);
    super.new(name,n_bits,has_coverage);    
  endfunction 
  
  virtual function void build();
    en_b = uvm_reg_field::type_id::create("sel");
    //data.configure(parent,size,lsb_pos,access,volatile,reset,has_reset,is_rand,individualy_accessible)
    en_b.configure(this,1,0,"RW",0,0,1,1,1);
    
    xor_b = uvm_reg_field::type_id::create("xor_b");
    xor_b.configure(this,1,1,"RW",0,0,1,1,1);
    
  
  endfunction
   
endclass :ctrl_reg

//*******************************************************************************************************************