//*****************************************************//
//    COMPONENT : BASE_TEST                            //
//    AUTHOR    : Mahantha Deeksha S B (WS1259)        //
//    FILE      : base_test.sv                         //
//*****************************************************//
//----------------------------------------------------------------
class base_test extends uvm_test;
   apb_config cfg;
   bit coverage_enable = 1;
   bit checks_enable = 1;
   int i;
   // environment instance
   env environment;   

   // factory registration
   `uvm_component_utils(base_test)
   
   // constructor method 
   function new(string name = "base_test",uvm_component parent);
      super.new(name,parent);
   endfunction : new
   
   virtual function void build_phase(uvm_phase phase);
      uvm_factory factory = uvm_factory :: get();
      super.build_phase(phase);
      
      environment = env :: type_id :: create("environment",this);
     
      cfg = apb_config :: type_id :: create("cfg");
      uvm_config_db #(bit) :: set(this,"*","coverage_enable",coverage_enable);
      uvm_config_db #(bit) :: set(this,"*","checks_enable",checks_enable);
    
      for(i = 0;i < `NO_OF_SLAVES; i = i + 1)begin
        bit[`ADDR_WIDTH - 1 : 0] start_addr,end_addr;
      
        start_addr = start_addr + (`ADDR_WIDTH'h100*i);
        end_addr = end_addr + ((`ADDR_WIDTH 'h100*i) + `ADDR_WIDTH'hFC);
        cfg.wait_cycles[i] = i;
        cfg.add_slave(.start_addr(start_addr),.end_addr(end_addr));
      end
      uvm_config_db #(apb_config) ::set(this,"*","cfg",cfg);
      //factory.print();
   endfunction :build_phase
   //
   virtual function void end_of_elaboration_phase(uvm_phase phase);
     super.end_of_elaboration_phase(phase);
     //uvm_top.print_topology();
   endfunction 
   // run_phase
   virtual task run_phase(uvm_phase phase);
   endtask : run_phase
   virtual function void report_phase(uvm_phase phase);
     super.report_phase(phase);
      //$stop();
   endfunction : report_phase
endclass : base_test
