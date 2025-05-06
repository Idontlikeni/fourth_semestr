`timescale 1ns / 1ps

module vioController(
    input clk,
    output error_led,
    output non_error_led,
    output [7:0] AN,
    output [6:0] SEG,
    output [7:0] LEDS
    );
    
    wire button_in, RESET;
    wire[15:0] SW;
    vio_0 vio (
        .clk(clk),
        .probe_in0(AN),
        .probe_in1(SEG),
        .probe_in2(error_led),
        .probe_in3(non_error_led),
        .probe_in4(LEDS),
        .probe_out0(button_in),
        .probe_out1(RESET),
        .probe_out2(SW)
    );
    /*
    main controller (
        .SWITCHES(SW),
        .button_in(button_in), 
        .clk(clk), 
        .button_reset_in(RESET),
        .error_led(error_led),
        .non_error_led(non_error_led),
        .AN(AN),
        .SEG(SEG),
        .LEDS(LEDS)
    );
    */
endmodule


/*
create_clock -period 10.000 -name sys_clk -waveform {0.000 5.000} -add
[get_ports clk]

#аноды
set_property IOSTANDARD LVCMOS33 [get_ports {AN[0]}]
set_property PACKAGE_PIN J17 [get_ports {AN[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[1]}]
set_property PACKAGE_PIN J18 [get_ports {AN[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[2]}]
set_property PACKAGE_PIN T9 [get_ports {AN[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[3]}]
set_property PACKAGE_PIN J14 [get_ports {AN[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[4]}]
set_property PACKAGE_PIN P14 [get_ports {AN[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[5]}]
set_property PACKAGE_PIN T14 [get_ports {AN[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[6]}]
set_property PACKAGE_PIN K2 [get_ports {AN[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[7]}]
set_property PACKAGE_PIN U13 [get_ports {AN[7]}]
#катоды
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[0]}]
set_property PACKAGE_PIN T10 [get_ports {SEG[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[1]}]
set_property PACKAGE_PIN R10 [get_ports {SEG[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[2]}]
set_property PACKAGE_PIN K16 [get_ports {SEG[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[3]}]
set_property PACKAGE_PIN K13 [get_ports {SEG[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[4]}]
set_property PACKAGE_PIN P15 [get_ports {SEG[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[5]}]
set_property PACKAGE_PIN T11 [get_ports {SEG[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[6]}]
set_property PACKAGE_PIN L18 [get_ports {SEG[6]}]
#леды
#ошибка
set_property IOSTANDARD LVCMOS33 [get_ports error_led]
set_property PACKAGE_PIN N15 [get_ports error_led]
set_property IOSTANDARD LVCMOS33 [get_ports non_error_led]
set_property PACKAGE_PIN G16 [get_ports non_error_led]
#колличество вписанных
set_property IOSTANDARD LVCMOS33 [get_ports {LEDS[0]}]
set_property PACKAGE_PIN V11 [get_ports {LEDS[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDS[1]}]
set_property PACKAGE_PIN V12 [get_ports {LEDS[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDS[2]}]
set_property PACKAGE_PIN V14 [get_ports {LEDS[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDS[3]}]
set_property PACKAGE_PIN V15 [get_ports {LEDS[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDS[4]}]
set_property PACKAGE_PIN T16 [get_ports {LEDS[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDS[5]}]
set_property PACKAGE_PIN U14 [get_ports {LEDS[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDS[6]}]
set_property PACKAGE_PIN T15 [get_ports {LEDS[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDS[7]}]
set_property PACKAGE_PIN V16 [get_ports {LEDS[7]}]
*/
