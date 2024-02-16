`define ADDR_WIDTH  32
`define DATA_WIDTH  32
`define NO_OF_SLAVES 7

`define START_ADDR 32'h000
`define END_ADDR 32'h8FFFF

typedef enum bit {APB_READ  = 1'b0,
                  APB_WRITE = 1'b1} pwrite_e;

typedef enum {ZERO ,
              SHORT,
              MEDIUM,
              LONG,
              MAX} apb_dly_e;
