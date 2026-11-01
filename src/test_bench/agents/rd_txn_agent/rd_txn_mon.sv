class rd_txn_monitor extends uvm_monitor;
    `uvm_component_utils(rd_txn_monitor)

    uvm_analysis_port #(seq_item) rd_addr_ch_ap;
    uvm_analysis_port #(seq_item) rd_data_ch_ap;
    virtual axi4_lite_interface.RD_MON vif;
    
    function new(string name = "rd_txn_monitor", uvm_component parent);
        super.new(name,parent);
        rd_addr_ch_ap = new("rd_addr_ch_ap",this);
        rd_data_ch_ap = new("rd_data_ch_ap",this);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual axi4_lite_interface.RD_MON)::get(this,"","vif",vif)) begin
            `uvm_fatal("rd_txn_monitor","virtual interface is not set by config_db!")
        end
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);  
        fork: main
        begin: READ_ADDRESS_CHANNEL
            seq_item rd_addr_tx;
            forever begin
                @(vif.rd_mon_cb);
                if(vif.rd_mon_cb.ARVALID && vif.rd_mon_cb.ARREADY) begin
                    rd_addr_tx = seq_item::type_id::create("rd_addr_tx");
                    rd_addr_tx.araddr = vif.rd_mon_cb.ARADDR;
                    rd_addr_ch_ap.write(rd_addr_tx); 
                end               
            end
        end

        begin: READ_DATA_CHANNEL
            seq_item rd_data_tx;   
            forever begin
                @(vif.rd_mon_cb);
                if(vif.rd_mon_cb.RVALID && vif.rd_mon_cb.RREADY) begin
                    rd_data_tx = seq_item::type_id::create("rd_data_tx");
                    rd_data_tx.rdata = vif.rd_mon_cb.RDATA;
                    rd_data_tx.rresp = vif.rd_mon_cb.RRESP;
                    rd_data_ch_ap.write(rd_data_tx); 
                end
            end
        end    
        join 
    endtask 
endclass //rd_txn_monitor extends uvm_monitor