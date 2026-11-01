interface axi4_lite_interface(input bit ACLK, input bit ARESETn);
    //write address channel
    logic [31:0] AWADDR;
    logic        AWVALID;
    logic        AWREADY;

    //write data channel
    logic [31:0] WDATA;
    logic [3:0]  WSTRB;
    logic        WVALID;
    logic        WREADY;

    //write response channel
    logic [1:0]  BRESP;
    logic        BVALID;
    logic        BREADY;

    //read address channel
    logic [31:0] ARADDR;
    logic        ARVALID;
    logic        ARREADY;

    //read response channel
    logic [31:0] RDATA;
    logic [1:0]  RRESP;
    logic        RVALID;
    logic        RREADY;


    clocking wr_drv_cb @(negedge ACLK);

        default input #1step output #1step;  
        output AWADDR;
        output AWVALID;
        input  AWREADY;

        output WDATA;
        output WSTRB;
        output WVALID;
        input  WREADY;

        input  BRESP;
        input  BVALID;
        output BREADY;

    endclocking


    clocking rd_drv_cb @(negedge ACLK);

        default input #1step output #1step;  
        output ARADDR;
        output ARVALID;
        input  ARREADY;

        input  RDATA;
        input  RRESP;
        input  RVALID;
        output RREADY;

    endclocking


    clocking wr_mon_cb @(posedge ACLK);
        
        default input #1step;
        input AWADDR;
        input AWVALID;
        input AWREADY;

        input WDATA;
        input WSTRB;
        input WVALID;
        input WREADY;

        input BRESP;
        input BVALID;
        input BREADY;

    endclocking


    clocking rd_mon_cb @(posedge ACLK);
        default input #1step;
        input ARADDR;
        input ARVALID;
        input ARREADY;

        input RDATA;
        input RRESP;
        input RVALID;
        input RREADY;

    endclocking


    modport WR_DRV (clocking wr_drv_cb);

    modport RD_DRV (clocking rd_drv_cb);

    modport WR_MON (clocking wr_mon_cb);

    modport RD_MON (clocking rd_mon_cb);


endinterface //axi4_lite_interface