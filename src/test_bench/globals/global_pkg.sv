package global_pkg;
    //enumerations
    typedef enum bit [1:0] {OKAY, EXOKAY, SLVERR, DECERR} resp_e;
    typedef enum bit [1:0] {RW, RO, WO, INV} address_access_type_e;
    typedef enum int {WRITE, READ, BOTH} operation_e;
    typedef enum int {LOW,HIGH} data_range_e;
        
    //defines
    `define DATAWIDTH 32
    `define ADDRWIDTH 32
        
endpackage