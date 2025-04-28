module fsm(
    input [15:0] dataIn,
    input R_I,
    input reset,
    input clk, 
    output reg [15:0] dataOut,
    output reg R_O
    );
    
parameter max_size = 16, S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;

// S0 - reset/start
// S1 - DataIn - N
// S2 - DataIn - array[N]
// S3 - Sort
// S4 - Print

reg [15:0] n, next_dataOut; //  размер массива
reg [15:0] arr [0:max_size-1]; // Массив

reg [1:0] state, next_state;
reg next_R_O;

reg [15:0] counter;

initial begin
    state <= 0;
    n <= 0;
    R_O <= 0;
    counter <= 0;
end

// Трехпроцессорный стиль стиль

always@(posedge clk)
begin
    if (reset)
        state <= S0;
    else begin
        state <= next_state;
        R_O <= next_R_O;
        dataOut <= next_dataOut;
    end
end

always@*
    case(state)
        S0: next_state <= S1; // Начало рабты
        S1: if(R_I) // чтение размера массива
                next_state <= S2;
            else
                next_state <= state;
        S2: if(R_I && counter == n) // чтение элементов массива
                next_state <= S3;
            else 
                next_state <= state;
        default: next_state <= state;
    
    endcase

function [15:0][0:max_size-1] merge (input reg [15:0] arr [0:max_size-1], input reg [15:0] left, input reg [15:0] mid, input reg [15:0] right);
    reg [15:0] it1;
    reg [15:0] it2;
    
    reg [15:0] result [0:max_size];
    
endfunction

function [15:0][0:max_size-1] merge_sort (input reg [15:0] arr [0:max_size-1], input reg n);
    integer i;
    integer j;
    for(i = 1; i < n; i = i * 2)begin 
        for(j = 0; j < n - i; j = j + 2 * i)begin
            if(j + 2 * i < n)
                merge(arr, j, j + i, j + 2 * i);
            else
                merge(arr, j, j + i, n);
        end
    end
endfunction

always@*
begin
    case(state)
        S0: begin
            next_R_O <= 0;
            next_dataOut <= 0;
            n <= 0;
            counter <= 0;
        end
        S1: begin
            if (R_I) n <= dataIn;
        end
        S2: begin
            if (R_I) begin // При приход сигнала R_I считаем след. значение массива. 
                arr[counter] <= dataIn;
                counter <= counter + 1;
            end
        end
        S3: begin // Здесь и должна проходить магия
            
        end
        S4: begin // Вывод элементов на дисплей
            
        end
     endcase
end 

endmodule
