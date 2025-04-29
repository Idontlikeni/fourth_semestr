module fsm(
    input [15:0] dataIn, // не забудь поменять здесь на 4 бита если надо
    input R_I,
    input reset,
    input clk, 
    output reg [15:0] dataOut,
    output reg R_O
    );
    
parameter max_size = 16, bit_size = 16,S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;

// S0 - reset/start
// S1 - DataIn - N
// S2 - DataIn - array[N]
// S3 - Sort
// S4 - Print

reg [bit_size-1:0] n, next_dataOut; //  размер массива
reg [bit_size-1:0] arr [0:max_size-1]; // Массив

reg [bit_size * max_size - 1:0] flattered_arr; // Норм массив блэать.

reg [1:0] state, next_state;
reg next_R_O;

reg [bit_size:0] counter;

integer i;
integer j;

task merge (input reg [bit_size * max_size - 1:0] flat_arr, input reg [bit_size - 1:0] left, input reg [bit_size - 1:0] mid, input reg [bit_size - 1:0] right);
    
    reg [bit_size - 1:0] it1;
    reg [bit_size - 1:0] it2;
    
    reg [bit_size - 1:0] result [0:max_size];
    
    reg [bit_size - 1:0] arr [0:max_size];
    
    while(left + it1 < mid && mid + it2 < right)begin
        if(arr[left + it1] < arr[mid + it2])begin
            result[it1 + it2] <= arr[left + it1];
            it1 <= it1 + 1;
        end
        else begin
            result[it1 + it2] <= arr[mid + it2];
            it2 <= it2 + 1;
        end
    end
    
    while(left + it1 < mid)begin
        result[it1 + it2] <= arr[left + it1];
        it1 <= it1 + 1;
    end

    while(mid + it2 < right)begin
        result[it1 + it2] <= arr[mid + it2];
        it2 <= it2 + 1;
    end
    
    for(i = 0; i < it1 + it2; i = i + 1)begin 
        arr[left + i] <= result[i];
    end
    
endtask

task merge_sort (input reg [bit_size * max_size - 1:0] flat_arr, input reg [bit_size - 1:0] n);
    for(i = 1; i < n; i = i * 2)begin 
        for(j = 0; j < n - i; j = j + 2 * i)begin
            if(j + 2 * i < n)
                merge(flat_arr, j, j + i, j + 2 * i);
            else
                merge(flat_arr, j, j + i, n);
        end
    end
endtask

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
                //flatted_arr[counter * bit_size:bit_size] <= dataIn;
                counter <= counter + 1;
            end
        end
        S3: begin // Здесь и должна проходить магия
            for(i = 0; i < n; i = i + 1) begin // преобразуем массив в плоский
                flattered_arr[i * bit_size+:bit_size] <= arr[i];
            end
            merge_sort(flattered_arr, n);
        end
        S4: begin // Вывод элементов на дисплей
            
        end
     endcase
end 

endmodule
