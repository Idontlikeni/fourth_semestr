module fsm#(max_size = 16, bit_size = 16)
(
    input [bit_size-1:0] n,
    input [bit_size-1:0] dataIn, // не забудь поменять здесь на 4 бита если надо
    input R_I,
    input reset,
    input clk, 
    output reg [bit_size * max_size - 1: 0] dataOut,
    output reg R_O
    );
    
localparam S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110;

// S0 - reset/start
// S1 - DataIn - N
// S2 - DataIn - array[N]
// S3 - Sort
// S4 - Print

// reg [bit_size-1:0] n; //  размер массива, след. вывод данных.
reg [bit_size-1:0] arr [0:max_size-1]; // Массив

reg [bit_size * max_size - 1:0] flattered_arr; // Норм массив блэать.

reg [2:0] state; // состояния

reg [bit_size - 1:0] counter; // счетчик индекса массива

integer i;
integer j;
integer k;
integer g;

reg [bit_size - 1:0] it1;
reg [bit_size - 1:0] it2;

reg [bit_size - 1:0] result [0:max_size - 1]; // массив для хранения временных отсортированных данных.

reg [1:0] z;

reg [bit_size * max_size - 1: 0] packed;

initial
begin
    state <= S0;
    // n <= 0;
    it1 <= 0;
    it2 <= 0;
    counter <= 0;
    packed <= 0;
    R_O <= 0;
    for(i = 0; i < max_size; i = i + 1)begin
        arr[i] <= 0;
        result[i] <= 0;
    end
end

function [1:0] merge (input reg [bit_size - 1:0] left, input reg [bit_size - 1:0] mid, input reg [bit_size - 1:0] right);
    begin
        // $display("RIGHT = %0h", right);
        while((left + it1 < mid) && (mid + it2 < right))begin
            if(arr[left + it1] < arr[mid + it2])begin
                result[it1 + it2] = arr[left + it1];
                it1 = it1 + 1;
            end
            else begin
                result[it1 + it2] = arr[mid + it2];
                it2 = it2 + 1;
            end
        end
        
        while(left + it1 < mid)begin
            result[it1 + it2] = arr[left + it1];
            it1 = it1 + 1;
        end
    
        while(mid + it2 < right)begin
            result[it1 + it2] = arr[mid + it2];
            it2 = it2 + 1;
        end
        
        for(g = 0; g < it1 + it2; g = g + 1)begin 
            arr[left + g] = result[g];
        end
    end
endfunction 

always@(posedge clk)
begin
    if(reset)begin
        it1 <= 0;
        it2 <= 0;
        counter <= 0;
        R_O <= 0;
        dataOut <= 0;
        for(i = 0; i < max_size; i = i + 1)begin
            arr[i] = 0;
            result[i] = 0;
        end
        state <= S0;
    end
    else
    case(state)
        S0:
        begin
            // n <= 0;
            it1 <= 0;
            it2 <= 0;
            counter <= 0;
            R_O <= 0;
            dataOut <= 0;
            for(i = 0; i < max_size; i = i + 1)begin
                arr[i] = 0;
                result[i] = 0;
            end
            state <= S2;
        end
//        S1: // ввод n
//        begin
//            if(R_I)begin
//                n <= dataIn;
//                state <= S2;
//            end
//        end
        S2: // ввод массива
        begin
            if(R_I) begin
                arr[counter] <= dataIn;
                counter <= counter + 1;
            end
            if(counter == n)begin
                state <= S3;
                i <= 1;
            end
        end // сортировка
        
        S3: begin
            if(i < n)begin
                j <= 0;
                state <= S4;
            end else state <= S6;
            
        end
        
        S4:begin
            if(j < n - i)begin
                if(j + 2 * i < n)
                    z = merge(j, j + i, j + 2 * i);
                else
                    z = merge(j, j + i, n);
                    it1 = 0;
                    it2 = 0;
                j <= j + 2 * i;
                state <= S4;
            end else begin
                state <= S3;
                i <= i * 2;
            end
        end
        
//        S3: begin
//            //state <= S0;
//            for(i = 1; i < n; i = i * 2)begin 
//                for(j = 0; j < n - i; j = j + 2 * i)begin
//                    // $display("i: %d, j: %d", i, j);
//                    if(j + 2 * i < n)
//                        z = merge(j, j + i, j + 2 * i);
//                    else
//                        z = merge(j, j + i, n);
//                    it1 = 0;
//                    it2 = 0;
////                    for(k = 0; k < max_size; k = k + 1)begin
////                        result[k] = 0;
////                    end
//                end
//            end
//            counter <= 0;
//            state <= S6;
//        end
        S6: begin
            R_O <= 1'b1;
            for (i = 0; i < n; i = i + 1) begin
                packed[i*bit_size +: bit_size] = arr[n - 1 - i];  // "+:" - part-select
            end
            dataOut <= packed;
            //state <= S0;
        end
    endcase
end
endmodule