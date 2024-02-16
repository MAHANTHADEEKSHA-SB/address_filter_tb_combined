//`uvm_analysis_imp_decl(_apb)
//`uvm_analysis_imp_decl(_ahb)
`uvm_analysis_imp_decl(_mem)

class coverage extends uvm_component;
  
  local bit[`ADDR_WIDTH - 1 : 0]in_addr;
  
  local bit[`ADDR_WIDTH - 1 : 0]l_start_reg;
  
  local bit[`ADDR_WIDTH - 1 : 0]l_end_reg;
  
  local bit[1 : 0] l_ctrl_reg;
  
  uvm_analysis_imp_apb #(apb_transfer,coverage) apb_imp;
  
  uvm_analysis_imp_ahb #(ahb_m_seq_item, coverage) ahb_imp;
  
  uvm_analysis_imp_mem #(mem_seq_item, coverage) mem_imp;
  
  mem_seq_item mem_item;
  
  ahb_m_seq_item ahb_item;
  
  apb_transfer apb_item;
  
  covergroup cg1;
    
    option.per_instance = 1;
    
    ahb_size: coverpoint ahb_item.hsize{bins allign = {WORD,HALFWORD,BYTE} ;//with (ahb_item.haddr[1 : 0] == 'b00);
                                        bins word = {WORD};
                                        ignore_bins allign_rest = {DOUBLEWORD, WORD_LINE_4, WORD_LINE_8, WORD_512, WORD_1024};
                                        bins def = default;
    }
    ahb_hwrite : coverpoint ahb_item.hwrite{bins write = {AHB_WRITE};
                                            bins read = {AHB_READ};
    }
    ahb_word_allign : coverpoint(ahb_item.haddr[1 : 0] == 'b00){bins true = {1};
                                                                bins false = {0};
    }
    
    ahb_size_x_word_allign : cross ahb_size, ahb_word_allign{bins alligned = binsof(ahb_size.word)&&binsof(ahb_word_allign.true);
                                                             illegal_bins non_alligned = binsof(ahb_size.word)&&binsof(ahb_word_allign.false);
    }
    
    ahb_addr : coverpoint ahb_item.haddr{bins min = {[32'h0000_0000 : 32'hFFFF]};
                                         bins mid = {[32'h0001_0000 : 32'h00AF_FFFF]};
                                         bins max = {[32'h00B0_0000 : 32'hFFFF_FFFF]};
                                         bins incr4_trans = (in_addr => in_addr + 'h4 => in_addr + 'h8 => in_addr + 'hC) ;//with (ahb_item.hburst == INCR4);
    }
    ahb_burst : coverpoint ahb_item.hburst{bins beat_4 = {INCR4,WRAP4};
                                           bins beat_8 = {INCR8,WRAP8};
                                           bins beat_16 = {INCR16,WRAP16};
    }
    ahb_burst_x_address : cross ahb_addr, ahb_burst;
    
    ahb_htrans : coverpoint ahb_item.htrans[0] {bins non_seq = {NONSEQ};
                                                bins seq_busy = {SEQ, BUSY};
                                                ignore_bins idle = {IDLE};
                                                bins trans = (NONSEQ => SEQ => SEQ => SEQ); //with ((ahb_item.hburst == INCR4)||(ahb_item.hburst == WRAP4));
    }
    ahb_burst_x_htrans : cross ahb_burst, ahb_htrans;
    
    apb_addr : coverpoint apb_item.paddr{bins start_reg = {0};
                                         bins end_reg = {4};
                                         bins ctrl_reg = {8};
                                         ignore_bins igr = {[9:$]};
                                         bins def = default;
    }
    apb_data : coverpoint apb_item.pwdata{bins ctrl = {2'b00,2'b11,2'b01,2'b10};// with (apb_item.paddr == 'h8);
                                          bins min = {[32'h0000_0000 : 32'hFFFF]};
                                          bins mid = {[32'h0001_0000 : 32'h00AF_FFFF]};
                                          bins max = {[32'h00B0_0000 : 32'hFFFF_FFFF]};
                                          bins start_addr = {apb_item.pwdata} ;//with (apb_item.paddr == 'h0);
                                          bins end_addr   = {apb_item.pwdata} ;//with (apb_item.paddr == 'h4);
    }
    
    apb_pwrite : coverpoint apb_item.pwrite{bins write = {APB_WRITE};
                                            bins read = {APB_READ};
    }
    
    apb_addr_x_apb_data : cross apb_addr, apb_data, apb_pwrite;
    
    start_addr : coverpoint l_start_reg {bins min = {[32'h0000_0000 : 32'hFFFF]};
                                         bins mid = {[32'h0001_0000 : 32'h00AF_FFFF]};
                                         bins max = {[32'h00B0_0000 : 32'hFFFF_FFFF]};
    }
    
    end_addr : coverpoint l_end_reg {bins min = {[32'h0000_0000 : 32'hFFFF]};
                                     bins mid = {[32'h0001_0000 : 32'h00AF_FFFF]};
                                     bins max = {[32'h00B0_0000 : 32'hFFFF_FFFF]};
    }
    
    addr_condtn : coverpoint(l_start_reg <= l_end_reg){bins true = {1'b1};
                                                       illegal_bins false = {1'b0};
    }
    
    /*mem_addr : coverpoint mem_item.addr{bins min = {[32'h0000_0000 : 32'hFFFF]};
                                        bins mid = {[32'h0001_0000 : 32'h00AF_FFFF]};
                                        bins max = {[32'h00B0_0000 : 32'hFFFF_FFFF]};
                                       }*/
    address_x_reg : cross mem_addr, addr_condtn, start_addr, end_addr{bins b1 = binsof(addr_condtn.true)&&binsof(start_addr)&&binsof(end_addr)&&binsof(mem_addr);
    }
    
    filt_stat : coverpoint l_ctrl_reg[0]{bins filter_on = {1'b1};
                                         bins filter_off = {1'b0};
    }
    ex_or_stat : coverpoint l_ctrl_reg[1]{bins ex_on = {1'b1};
                                          bins ex_off = {1'b0};
    }
    /*filter : coverpoint ((mem_item.addr >= l_start_reg) && (mem_item.addr <= l_end_reg)){bins in_range = {1'b1};
                                                                                         bins out_range = {1'b0};
    }*/
    
   /* filt_cross : cross filt_stat, ex_or_stat, filter, mem_addr{bins filt_on_ex_on = binsof(filt_stat.filter_on)&&binsof(ex_or_stat.ex_on)&&binsof(filter.out_range)&&binsof(mem_addr);
                                                               bins filt_off_ex_on = binsof(filt_stat.filter_off)&&binsof(ex_or_stat.ex_on)&&binsof(filter)&&binsof(mem_addr);
                                                               bins filt_on_ex_off = binsof(filt_stat.filter_on)&&binsof(ex_or_stat.ex_off)&&binsof(filter.in_range)&&binsof(mem_addr);
                                                               bins filt_off_ex_off = binsof(filt_stat.filter_off)&&binsof(ex_or_stat.ex_off)&&binsof(filter)&&binsof(mem_addr);
    }*/
  endgroup : cg1
  
  `uvm_component_utils(coverage)
  
  function new(string name = "coverage",uvm_component parent);
    super.new(name,parent);
    mem_item = mem_seq_item :: type_id :: create("mem_item");
    
    ahb_item = ahb_m_seq_item :: type_id :: create("ahb_item");
    
    apb_item = apb_transfer :: type_id :: create("apb_item");
    cg1 = new();
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    apb_imp = new("apb_imp",this);
    ahb_imp = new("ahb_imp",this);
    mem_imp = new("mem_imp",this);
    
    //mem_item = mem_seq_item :: type_id :: create("mem_item");
    
    //ahb_item = ahb_m_seq_item :: type_id :: create("ahb_item");
    
    //apb_item = apb_transfer :: type_id :: create("apb_item");
    
  endfunction : build_phase
  
  virtual function void write_ahb(ahb_m_seq_item item);
    $cast(ahb_item,item.clone());
    //item.print();
    if(ahb_item.htrans[0] == NONSEQ)begin
      in_addr = ahb_item.haddr;
      //$display("\n\t%0h\n",in_addr);
      //$display("\n\t%0h\n",item.haddr);
    end
    //$display("\n\t%0h\n",item.haddr);
    cg1.sample();
  endfunction : write_ahb
  
  virtual function void write_apb(apb_transfer item);
    $cast(apb_item,item.clone());
    if(item.paddr == 'h8)begin
      l_ctrl_reg = item.pwdata;
    end
    else if(item.paddr == 'h0)begin
      l_start_reg = item.pwdata;
    end
    else if(item.paddr == 'h4)begin
      l_end_reg = item.pwdata;
    end
    cg1.sample();
  endfunction : write_apb
  
  virtual function void write_mem(mem_seq_item item);
    mem_item = item;
    cg1.sample();
  endfunction : write_mem
  
endclass : coverage
