module fifo_two_clock#(
    MEM_SIZE = 6,
    DATA_SIZE = 4,
    localparam ADDR_SIZE = $clog2(MEM_SIZE)
)
(
    input [DATA_SIZE - 1 : 0] data_in,
    input clk_write, clk_read, read_mode, write_mode, enable, reset,
    
    output reg [DATA_SIZE - 1 : 0] data_out,
    output reg full, empty, valid
);

reg [DATA_SIZE - 1 : 0] mem [0 : MEM_SIZE - 1];
reg next_full, next_empty;

reg [ADDR_SIZE - 1 : 0] write_pointer, read_pointer;
reg [ADDR_SIZE - 1 : 0] next_write_pointer, next_read_pointer;

reg [ADDR_SIZE - 1 : 0] i;
initial
begin
    write_pointer = {ADDR_SIZE{1'b0}};
    read_pointer = {ADDR_SIZE{1'b0}};
    
    next_write_pointer = {ADDR_SIZE{1'b0}} + 1;
    next_read_pointer = {ADDR_SIZE{1'b0}} + 1;
    
    full = 1'b0;
    next_full = 1'b0;
    
    empty = 1'b1;
    next_empty = 1'b1;
    
    valid = 1'b0;
    
    data_out = {DATA_SIZE{1'b0}};
    
    for (i = 0; i < MEM_SIZE; i = i + 1)
        mem[i] = {DATA_SIZE{1'b0}};
end

// Операция записи
always @(posedge clk_write)
begin
    if ( reset )
        write_pointer <= {ADDR_SIZE{1'b0}};
    else 
    begin
        if ( enable && write_mode && !full )
        begin
            mem[write_pointer] <= data_in;
            write_pointer <= next_write_pointer;
        end
    end
end 
                
// Операция чтения в буфер
always @(posedge clk_read)
begin
    if ( reset )
    begin
        read_pointer <= {ADDR_SIZE{1'b0}};    
    end
    else
    begin
        if ( enable && read_mode && !empty )
            begin
                read_pointer <= next_read_pointer;
                data_out <= mem[read_pointer];
                valid <= 1; 
            end
        else
            valid <= 0;
    end        
end
        
always @(posedge clk_read, posedge clk_write)
begin
    if ( reset )
    begin
        full <= 1'b0;
        empty <= 1'b1;
    end
    else if ( enable )
    begin
        full = next_full;
        empty = next_empty;
    end
end
        
function [ADDR_SIZE-1:0] next (input [ADDR_SIZE-1:0] pointer);
begin
    if (pointer == MEM_SIZE - 1)
        next = {ADDR_SIZE{1'b0}};
    else 
        next = pointer + 1;
end
endfunction

localparam NONE = 0, READ = 1, WRITE = 2, READ_AND_WRITE = 3;
reg  [1:0] op;

//
always @*
begin
    case({write_mode, read_mode})
        2'b01:
            op <= !empty ? READ : NONE;
        2'b10:
            op <= !full ? WRITE : NONE;
        2'b11: 
            case({full, empty})
                2'b10: op <= READ;
                2'b01: op <= WRITE;
                default: op <= READ_AND_WRITE;
            endcase
        default: 
            op <= NONE;
    endcase
    
    case(op)
        NONE:
            begin
                next_full <= full;
                next_empty <= empty;
            end
            
        READ:
            begin
                next_full <= next_write_pointer == read_pointer;
                next_empty <= next_read_pointer == write_pointer;
                next_read_pointer <= next(read_pointer);                
            end
                
        WRITE:
            begin
                next_full <= next_write_pointer == read_pointer;
                next_empty <= next_read_pointer == write_pointer;
                next_write_pointer <= next(write_pointer);                
            end
            
        READ_AND_WRITE:
            begin
                next_empty <= next_read_pointer == write_pointer;
                next_full <= next_write_pointer == read_pointer;
                
                next_read_pointer <= next(read_pointer);
                next_write_pointer <= next(write_pointer);
            end
        
    endcase
    
end

endmodule
