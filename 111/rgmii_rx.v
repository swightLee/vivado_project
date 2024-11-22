module rgmii_rx #(
    parameter   IDELAY_VALUE = 0  //输入数据IO延时(如果为n,表示延时n*78+600ps);
)(
    input                       idelay_clk      ,//200Mhz时钟，IDELAY时钟
    input                       RES_N,
    //以太网RGMII接口
    input                       rgmii_rxc       ,//RGMII接收时钟
    input                       rgmii_rx_ctl    ,//RGMII接收数据控制信号
    input       [3:0]           rgmii_rxd       ,//RGMII接收数据    

    //以太网GMII接口
    output                      gmii_rx_clk     ,//GMII接收时钟
    output                      gmii_rx_dv      ,//GMII接收数据有效信号
    output      [7:0]           gmii_rxd_out        //GMII接收数据   
);
    wire                        rgmii_rxc_bufg  ;//全局时钟缓存
    wire                        rgmii_rxc_bufio ;//全局时钟IO缓存
    wire        [4 : 0]         din             ;//将接收的数据和控制信号进行拼接；
    wire        [4 : 0]         din_delay       ;//将接收到的数据延时2ns。
    wire        [9 : 0]         gmii_data       ;//双沿转单沿的信号；
    wire                        rst;
    wire                        rgmii_rxc_delay;
    wire                        rgmii_rxc_bufh;
    
    assign gmii_rx_clk = rgmii_rxc;//将时钟全局时钟网络驱动CLB等资源。

            IDELAYE3 #(
                .CASCADE           ("NONE"),              // Cascade setting
                .DELAY_FORMAT      ("TIME"),              // Units of the DELAY_VALUE
                .DELAY_SRC         ("IDATAIN"),           // Delay input
                .DELAY_TYPE        ("FIXED"),          // Set the type of tap delay line
                .DELAY_VALUE       (IDELAY_VALUE),        // Input delay value setting
                .IS_CLK_INVERTED   (1'b0),                // Optional inversion for CLK
                .IS_RST_INVERTED   (1'b0),                // Optional inversion for RST
                .REFCLK_FREQUENCY  (200.0),               // IDELAYCTRL clock input frequency in MHz
                .SIM_DEVICE       ("ULTRASCALE"),   // Set the device version for simulation functionality
                .UPDATE_MODE       ("ASYNC")             // Determines when updates to the delay will take effect
            )
            u_delay_rxc (
                .CNTVALUEOUT       (),                     // 9-bit output: Counter value output
                .DATAOUT           (rgmii_rxc_delay),         // 1-bit output: Delayed data output
//                .C                 (1'b0),                 // 1-bit input: Clock input
                .CE                (1'b0),                 // 1-bit input: Enable increment/decrement
//                .CINVCTRL          (1'b0),                 // 1-bit input: Dynamic clock inversion
                .CNTVALUEIN        (9'b0),                 // 9-bit input: Counter value input
                .DATAIN            (1'b0),                 // 1-bit input: Internal delay data input
                .IDATAIN           (rgmii_rxc),               // 1-bit input: Data input from the I/O
                .INC               (1'b0),              // 1-bit input: Inc/Decrement tap delay
//                .LD                (1'b0),                 // 1-bit input: Load IDELAY_VALUE input
//                .LDPIPEEN          (1'b0),                 // 1-bit input: Enable PIPELINE register 
                .RST            (1'b0)                  // 1-bit input: Active-high reset tap-delay
            );

//    ///例化全局时钟资源。
////    BUFH bufd_inst (
////        .O(rgmii_rxc_bufh),               // Output
////        .I(rgmii_rxc_delay)               // Input
////    );
    
////    // BUFG 使用 BUFH 的输出
//    BUFG bufg_inst (
//        .O(rgmii_rxc_bufg),               // Output
//        .I(rgmii_rxc_delay)                // Input
//    );

    //全局时钟IO缓存
    BUFIO BUFIO_inst (
        .I  ( rgmii_rxc_delay         ),//1-bit input: Clock input
        .O  ( rgmii_rxc_bufio   ) //1-bit output: Clock output
    );

    //输入延时控制
    (* IODELAY_GROUP = "rgmii_rx" *) 
    IDELAYCTRL #(
        .SIM_DEVICE ("ULTRASCALE")  // Set to "ULTRASCALE" to match the target architecture
    )
    IDELAYCTRL_inst (
        .RDY    ( rst         ),   // 1-bit output: Ready output
        .REFCLK ( idelay_clk     ),   // 1-bit input: Reference clock input
        .RST    ( ~RES_N           )    // 1-bit input: Active high reset input
    );


    //将输入控制信号和数据进行拼接，便于后面好用循环进行处理。
    assign din[4 : 0] = {rgmii_rx_ctl,rgmii_rxd};

    //rgmii_rx_ctl和rgmii_rxd输入延时与双沿采样
    generate
        genvar i;
        for(i=0 ; i<5 ; i=i+1)begin : RXDATA_BUS
            // 输入延时
            (* IODELAY_GROUP = "rgmii_rx" *) 
            IDELAYE3 #(
                .CASCADE           ("NONE"),              // Cascade setting
                .DELAY_FORMAT      ("TIME"),              // Units of the DELAY_VALUE
                .DELAY_SRC         ("IDATAIN"),           // Delay input
                .DELAY_TYPE        ("FIXED"),          // Set the type of tap delay line
                .DELAY_VALUE       (IDELAY_VALUE),        // Input delay value setting
                .IS_CLK_INVERTED   (1'b0),                // Optional inversion for CLK
                .IS_RST_INVERTED   (1'b0),                // Optional inversion for RST
                .REFCLK_FREQUENCY  (200.0),               // IDELAYCTRL clock input frequency in MHz
                .SIM_DEVICE       ("ULTRASCALE"),   // Set the device version for simulation functionality
                .UPDATE_MODE       ("ASYNC")             // Determines when updates to the delay will take effect
            )
            u_delay_rxd (
                .CNTVALUEOUT       (),                     // 9-bit output: Counter value output
                .DATAOUT           (din_delay[i]),         // 1-bit output: Delayed data output
//                .C                 (1'b0),                 // 1-bit input: Clock input
                .CE                (1'b0),                 // 1-bit input: Enable increment/decrement
//                .CINVCTRL          (1'b0),                 // 1-bit input: Dynamic clock inversion
                .CNTVALUEIN        (9'b0),                 // 9-bit input: Counter value input
                .DATAIN            (1'b0),                 // 1-bit input: Internal delay data input
                .IDATAIN           (din[i]),               // 1-bit input: Data input from the I/O
                .INC               (1'b0),              // 1-bit input: Inc/Decrement tap delay
//                .LD                (1'b0),                 // 1-bit input: Load IDELAY_VALUE input
//                .LDPIPEEN          (1'b0),                 // 1-bit input: Enable PIPELINE register 
                .RST            (1'b0)                  // 1-bit input: Active-high reset tap-delay
            );


            // 输入双沿采样寄存器
            IDDRE1 #(
                .DDR_CLK_EDGE   ("SAME_EDGE_PIPELINED"), // DDR时钟边沿模式（"OPPOSITE_EDGE", "SAME_EDGE", "SAME_EDGE_PIPELINED"）
                .IS_CB_INVERTED (1'b0),           // CB输入是否取反
                .IS_C_INVERTED  (1'b0)            // C输入是否取反
            ) IDDRE1_inst (
                .Q1             (gmii_data[i]),   // 1-bit output: 正沿时钟的寄存器输出 Q1
                .Q2             (gmii_data[5 + i]), // 1-bit output: 负沿时钟的寄存器输出 Q2
                .C              (rgmii_rxc_bufio), // 1-bit input: 高速时钟 C
                .CB             (1'b0),           // 1-bit input: 高速时钟 C 的取反输入（通常为 0，表示不使用）
                .D              (din_delay[i]),   // 1-bit input: 串行数据输入
                .R              (1'b0)            // 1-bit input: 高电平有效的异步复位
            );

        end
    endgenerate

    //通过拼接生成数据信号和数据有效指示信号。
    assign gmii_rxd_out = {gmii_data[8:5],gmii_data[3:0]};
    assign gmii_rx_dv = gmii_data[4] & gmii_data[9];//只有当上升沿和下降沿采集到的控制信号均为高电平时，数据才有效。
    
endmodule