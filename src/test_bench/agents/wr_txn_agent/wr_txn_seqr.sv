class wr_txn_seqr extenfs uvm_sequencer #(seq_item);
    `uvm_component_utils(wr_txn_seqr)

    function new(string name = "wr_txn_seqr", uvm_component parent);
        super.new(name, parent);
    endfunction

    function build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    
endclass 