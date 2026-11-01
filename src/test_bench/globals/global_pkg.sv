package global_pkg;
    //enumerations
    typedef enum bit [1:0] {OKAY, EXOKAY, SLVERR, DECERR} resp_e;
    typedef enum bit [1:0] {NORMAL, STATUS, COMMAND, RESERVED} reg_type;
        
    //defines
    `define DATAWIDTH 32
    `define ADDRWIDTH 32
        
endpackage