class wr_txn_monitor extends uvm_monitor;
    `uvm_component_utils(wr_txn_monitor)

    uvm_analysis_port #(seq_item) wr_addr_ch_ap;
    uvm_analysis_port #(seq_item) wr_data_ch_ap;
    uvm_analysis_port #(seq_item) wr_resp_ch_ap;

    virtual axi4_lite_interface.WR_MON vif;
    
    function new(string name = "wr_txn_monitor", uvm_component parent);
        super.new(name,parent);
        wr_addr_ch_ap = new("wr_addr_ch_ap",this);
        wr_data_ch_ap = new("wr_data_ch_ap",this);
        wr_resp_ch_ap = new("wr_resp_ch_ap",this);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual axi4_lite_interface.WR_MON)::get(this,"","vif",vif)) begin
            `uvm_fatal("wr_txn_monitor","virtual interface is not set by config_db!")
        end
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);  
        fork: main
        begin: WRITE_ADDRESS_CHANNEL
            seq_item wr_addr_tx;
            forever begin
                @(vif.wr_mon_cb);
                if(vif.wr_mon_cb.AWVALID && vif.wr_mon_cb.AWREADY) begin
                    wr_addr_tx = seq_item::type_id::create("wr_addr_tx");
                    wr_addr_tx.awaddr = vif.wr_mon_cb.AWADDR;
                    wr_addr_ch_ap.write(wr_addr_tx); 
                end               
            end
        end

        begin: WRITE_DATA_CHANNEL
            seq_item wr_data_tx;   
            forever begin
                @(vif.wr_mon_cb);
                if(vif.wr_mon_cb.WVALID && vif.wr_mon_cb.WREADY) begin
                    wr_data_tx = seq_item::type_id::create("wr_data_tx");
                    wr_data_tx.wdata = vif.wr_mon_cb.WDATA;
                    wr_data_tx.wstrb = vif.wr_mon_cb.WSTRB;
                    wr_data_ch_ap.write(wr_data_tx); 
                end
            end
        end  

        begin: WRITE_RESPONSE_CHANNEL
            seq_item wr_resp_tx;   
            forever begin
                @(vif.wr_mon_cb);
                if(vif.wr_mon_cb.BVALID && vif.wr_mon_cb.BREADY) begin
                    wr_resp_tx = seq_item::type_id::create("wr_resp_tx");
                    wr_resp_tx.bresp = vif.wr_mon_cb.BRESP;
                    wr_resp_ch_ap.write(wr_resp_tx); 
                end
            end
        end  
        join 
    endtask 
endclass //wr_txn_monitor extends uvm_monitor