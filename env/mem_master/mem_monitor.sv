class mem_monitor extends uvm_monitor;
  
  `uvm_component_utils(mem_monitor)
  
  uvm_analysis_port #(mem_seq_item) mem_ap;
  
  virtual mem_intf vif;
  mem_seq_item mem_item; 
  
  function new(string name = "mem_monitor",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mem_ap = new("mem_ap",this);
    mem_item = mem_seq_item :: type_id :: create("mem_item");
    if(!uvm_config_db #(virtual mem_intf) :: get(this, "", "mem_vif", vif))
       `uvm_fatal(get_full_name(), "Unable to access interface handle from config_db")
      
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase); 
    forever begin
      mem_item = mem_seq_item :: type_id :: create("mem_item");
      void'(begin_tr(mem_item,"mem_monitor"));
      @(posedge vif.clk);
      if(vif.wr_en == 1)begin
        mem_item.addr = vif.addr;
        mem_item.wr_data = vif.wr_data;
        mem_item.wr_en = 1'b1;
        end_tr(mem_item);
        mem_ap.write(mem_item);
      end
      if(vif.rd_en == 1)begin
        mem_item.addr = vif.addr;
        mem_item.rd_data = vif.rd_data;
        mem_item.rd_en = 1'b1;
        end_tr(mem_item);
        mem_ap.write(mem_item);
      end
    end
  endtask
  
endclass
