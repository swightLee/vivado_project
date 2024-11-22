module rgmii_tx(
    //GMII发送端口
    input                   gmii_tx_clk     ,//GMII发送时钟;
    input       [7:0]       gmii_txd_in       ,//GMII输出数据;
    input                   gmii_tx_en      ,//GMII输出数据有效信号，高电平有效；
    input                   RES_N,
    //RGMII发送端口
    output                  rgmii_txc       ,//RGMII发送数据时钟；
    output                  rgmii_tx_ctl    ,//RGMII输出数据有效信号；
    output      [3:0]       rgmii_txd        //RGMII输出数据；
);
    assign rgmii_txc = gmii_tx_clk;

    //输出双沿采样寄存器 (rgmii_tx_ctl)
    ODDRE1 #(
//        .SRTYPE        ( "ASYNC"         ), // Set/Reset type: "SYNC" or "ASYNC"
        .IS_C_INVERTED ( 1'b0           ), // Optional inversion for C
        .IS_D1_INVERTED( 1'b0           ), // Optional inversion for D1
        .IS_D2_INVERTED( 1'b0           ), // Optional inversion for D2
        .SRVAL         ( 1'b0           ), // Initializes the ODDRE1 Flip-Flops to the specified value (1'b0 or 1'b1)
        .SIM_DEVICE("ULTRASCALE") // Set the device version for simulation functionality (ULTRASCALE)
    ) ODDRE1_inst (
        .Q             ( rgmii_tx_ctl   ), // 1-bit DDR output
        .C             ( gmii_tx_clk    ), // 1-bit clock input
//        .CE            ( 1'b1           ), // 1-bit clock enable input
        .D1            ( gmii_tx_en     ), // 1-bit data input (positive edge)
        .D2            ( gmii_tx_en     ), // 1-bit data input (negative edge)
        .SR            ( ~RES_N           )  // 1-bit active-high async reset
);


    generate
        genvar i;
        for(i=0; i<4; i=i+1) begin : txdata_bus
            // 输出双沿采样寄存器
            ODDRE1 #(
//                .DDR_CLK_EDGE   ("SAME_EDGE"),  // DDR时钟边沿模式（"OPPOSITE_EDGE" or "SAME_EDGE"）
                .IS_C_INVERTED  (1'b0),        // C输入是否取反
                .IS_D1_INVERTED (1'b0),        // D1输入是否取反（不支持，设置为0）
                .IS_D2_INVERTED (1'b0),        // D2输入是否取反（不支持，设置为0）
                .SIM_DEVICE     ("ULTRASCALE"), // 设置设备版本进行仿真（ULTRASCALE）
                .SRVAL          (1'b0)         // 复位后初始值
            ) ODDRE1_inst (
                .Q             (rgmii_txd[i]),  // 1-bit DDR output
                .C             (gmii_tx_clk),   // 1-bit clock input
//                .CE            (1'b1),          // 1-bit clock enable input
                .D1            (gmii_txd_in[i]),// 1-bit data input (positive edge)
                .D2            (gmii_txd_in[4+i]),// 1-bit data input (negative edge)
                .SR            (~RES_N)           // 1-bit active-high async reset
            );        
        end
    endgenerate


endmodule