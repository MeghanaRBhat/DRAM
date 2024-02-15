class dram_coverage #(type pack=dram_seq_item) extends uvm_subscriber #(pack);
  `uvm_component_utils(dram_coverage)
pack  pkt;

covergroup cov;	//@(posedge intf.clk);
 address : coverpoint  pkt.add {
   bins low    = {[0:31]};
   bins high   = {[32:63]};
  } 
  data : coverpoint  pkt.data_in {
    bins low    = {[0:127]};
    bins high   = {[128:255]};
}
  wr : coverpoint pkt.wr {
    bins low = {0};
    bins high = {1};
  }
  en : coverpoint pkt.en {
    bins low = {0};
    bins high ={1};
  }
endgroup

function new (string name = "dram_coverage", uvm_component parent);
      super.new (name, parent);
	  cov = new;
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction
	  
  virtual function void write (pack t);
	`uvm_info("SEQ","SEQUENCE TRANSACTIONS",UVM_NONE);
	pkt = t;
	cov.sample();
endfunction

endclass
