class rd_txn_agent extends uvm_agent;
    `uvm_component_utils(rd_txn_agent)
    
    rd_txn_seqr rd_txn_seqr_h;
    rd_txn_drv rd_txn_drv_h;
    rd_txn_mon rd_txn_mon_h;

    function new(string name = "rd_txn_agent", uvm_component parent);
        super.new(name,parent);
    endfunction 

    function build_phase(uvm_phase phase);
        super.build_phase(phase);
        rd_txn_seqr_h = rd_txn_seqr::type_id::create("rd_txn_seqr_h",this);
        rd_txn_drv_h = rd_txn_drv::type_id::create("rd_txn_drv_h",this);
        rd_txn_mon_h = rd_txn_mon::type_id::create("rd_txn_mon_h",this);
    endfunction

    function connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        rd_txn_drv_h.seq_item_port.connect(rd_txn_seqr_h.seq_item_export)
    endfunction
    
endclass //rd_txn_agent extends uvm_agent