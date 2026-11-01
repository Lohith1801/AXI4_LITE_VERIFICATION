package tb_pkg;
    //globals
    `include "./globals/global_pkg.sv"

    //static components
    `include "../../rtl_pkg.sv"
    `include "./interface/if_pkg.sv"
    `include "./assetion/assertion_pkg.sv"

    //dynamic components
    `include "./agents/agents_pkg.sv"
    `include "./agents/agents_pkg.sv"
    `include "./environment/env_pkg.sv"
    `include "./sequences/seq_pkg.sv"
    `include "./tests/tests_pkg.sv"
endpackage