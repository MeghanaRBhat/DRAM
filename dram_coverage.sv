class dram_coverage #(type T=dram_seq_item) extends uvm_subscriber #(T);
  `uvm_component_utils(dram_coverage)
//dram_seq_item pkt;
T pkt;

covergroup CovPort;	//@(posedge intf.clk);
 address : coverpoint  pkt.add{
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

function new (string name = "dram_cov", uvm_component parent);
      super.new (name, parent);
	  CovPort = new;
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	//pkt=dram_seq_item::type_id::create("pkt");
    //CovPort = new("CovPort",this);
endfunction
	  
  virtual function void write (T t);
	`uvm_info("SEQ","SEQUENCE TRANSACTIONS",UVM_NONE);
	pkt = t;
	CovPort.sample();
endfunction

endclass
