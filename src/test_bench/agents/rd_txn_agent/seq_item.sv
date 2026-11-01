class seq_item extends uvm_sequence_item;

    rand bit [`DATAWIDTH-1:0]wdata; //write data
    rand bit [`ADDRWIDTH-1:0]awaddr; //write addrs
    rand bit [(`DATAWIDTH/8) -1:0]wstrb; //write strobe byte enable
    rand bit [`ADDRWIDTH-1:0]araddr; //read addrs
    resp_e bresp;
    resp_e rresp;

    rand operation_e operation;
    rand address_access_type_e access_type;
    rand data_range_e data_range;

    
    `uvm_object_utils_begin(seq_item)
        `uvm_field_int(wdata,  UVM_DEFAULT | UVM_DEC)
        `uvm_field_int(awaddr, UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(wstrb,  UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(araddr, UVM_DEFAULT | UVM_HEX)
        `uvm_field_enum(resp_e,     bresp, UVM_DEFAULT)
        `uvm_field_enum(resp_e,     rresp, UVM_DEFAULT)
        `uvm_field_enum(operation_e, operation, UVM_DEFAULT)
        `uvm_field_enum(address_access_type_e, access_type, UVM_DEFAULT)
        `uvm_field_enum(data_range_e, data_range, UVM_DEFAULT)
    `uvm_object_utils_end

    function new(string name = "wr_txn_seq_item");
        super.new(name);
    endfunction 

    //constraints
    constraint set{
        solve data_range before wdata;
        solve access_type before awaddr;
        solve access_type before araddr;
    }

    constraint set_wdata{
        if(data_range == LOW){
            wdata inside {[0:`DATAWIDTH/2]};
        }
        else{
            wdata inside {[`DATAWIDTH/2:`DATAWIDTH]};
        }
    }

    constraint set_addresses_word_alligned{
        awaddr[1:0] == 2'b00;
        araddr[1:0] == 2'b00; 
    }

    constraint set_addresses{
        if(access_type == RW){
            awaddr inside {['h00:'h24],'h3C};
            araddr inside {['h00:'h24],'h3C};
        }
        else if(access_type ==RO){
            awaddr inside {['h28:'h30]};
            araddr inside {['h28:'h30]};
        }
        else if(access_type ==WO){
            awaddr inside {['h34:'h38]};
            araddr inside {['h34:'h38]};
        }
        else{
            awaddr > 'h3C;
            araddr > 'h3C;
        }
    }


    
endclass //wr_txn_seq_item extends uvm_sequence_item