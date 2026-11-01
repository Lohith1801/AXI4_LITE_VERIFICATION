class wr_txn_agent extends uvm_agent;
    `uvm_component_utils(wr_txn_agent)
    
    wr_txn_seqr wr_txn_seqr_h;
    wr_txn_drv wr_txn_drv_h;
    wr_txn_mon wr_txn_mon_h;

    function new(string name = "wr_txn_agent", uvm_component parent);
        super.new(name,parent);
    endfunction 

    function build_phase(uvm_phase phase);
        super.build_phase(phase);
        wr_txn_seqr_h = wr_txn_seqr::type_id::create("wr_txn_seqr_h",this);
        wr_txn_drv_h = wr_txn_drv::type_id::create("wr_txn_drv_h",this);
        wr_txn_mon_h = wr_txn_mon::type_id::create("wr_txn_mon_h",this);
    endfunction

    function connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        wr_txn_drv_h.seq_item_port.connect(wr_txn_seqr_h.seq_item_export)
    endfunction
    
endclass //wr_txn_agent extends uvm_agent