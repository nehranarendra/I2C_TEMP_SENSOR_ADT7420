`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2024 16:41:51
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input         CLK100MHZ,        // nexys clk signal
    input         reset,            // btnC on nexys
    inout         TMP_SDA,          // i2c sda on temp sensor - bidirectional
    output        TMP_SCL,          // i2c scl on temp sensor
    output [7:0]  LED               // nexys leds = binary temp in deg C
    );
    
    wire sda_dir;                   // direction of SDA signal - to or from master
    wire w_200kHz;                  // 200kHz SCL
    wire [7:0] w_data;              // 8 bits of temperature data

    // Instantiate i2c master
    i2c_master master(
        .clk_200kHz(w_200kHz),
        .reset(reset),
        .temp_data(w_data),
        .SDA(TMP_SDA),
        .SDA_dir(sda_dir),
        .SCL(TMP_SCL)
    );
    
    // Instantiate 200kHz clock generator
    clkgen_200kHz cgen(
        .clk_100MHz(CLK100MHZ),
        .clk_200kHz(w_200kHz)
    );
    
    // Set LED value to temp data
    assign LED = w_data;

endmodule
