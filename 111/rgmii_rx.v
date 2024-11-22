module rgmii_rx #(
    parameter   IDELAY_VALUE = 0  //��������IO��ʱ(���Ϊn,��ʾ��ʱn*78+600ps);
)(
    input                       idelay_clk      ,//200Mhzʱ�ӣ�IDELAYʱ��
    input                       RES_N,
    //��̫��RGMII�ӿ�
    input                       rgmii_rxc       ,//RGMII����ʱ��
    input                       rgmii_rx_ctl    ,//RGMII�������ݿ����ź�
    input       [3:0]           rgmii_rxd       ,//RGMII��������    

    //��̫��GMII�ӿ�
    output                      gmii_rx_clk     ,//GMII����ʱ��
    output                      gmii_rx_dv      ,//GMII����������Ч�ź�
    output      [7:0]           gmii_rxd_out        //GMII��������   
);
    wire                        rgmii_rxc_bufg  ;//ȫ��ʱ�ӻ���
    wire                        rgmii_rxc_bufio ;//ȫ��ʱ��IO����
    wire        [4 : 0]         din             ;//�����յ����ݺͿ����źŽ���ƴ�ӣ�
    wire        [4 : 0]         din_delay       ;//�����յ���������ʱ2ns��
    wire        [9 : 0]         gmii_data       ;//˫��ת���ص��źţ�
    wire                        rst;
    wire                        rgmii_rxc_delay;
    wire                        rgmii_rxc_bufh;
    
    assign gmii_rx_clk = rgmii_rxc;//��ʱ��ȫ��ʱ����������CLB����Դ��

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

//    ///����ȫ��ʱ����Դ��
////    BUFH bufd_inst (
////        .O(rgmii_rxc_bufh),               // Output
////        .I(rgmii_rxc_delay)               // Input
////    );
    
////    // BUFG ʹ�� BUFH �����
//    BUFG bufg_inst (
//        .O(rgmii_rxc_bufg),               // Output
//        .I(rgmii_rxc_delay)                // Input
//    );

    //ȫ��ʱ��IO����
    BUFIO BUFIO_inst (
        .I  ( rgmii_rxc_delay         ),//1-bit input: Clock input
        .O  ( rgmii_rxc_bufio   ) //1-bit output: Clock output
    );

    //������ʱ����
    (* IODELAY_GROUP = "rgmii_rx" *) 
    IDELAYCTRL #(
        .SIM_DEVICE ("ULTRASCALE")  // Set to "ULTRASCALE" to match the target architecture
    )
    IDELAYCTRL_inst (
        .RDY    ( rst         ),   // 1-bit output: Ready output
        .REFCLK ( idelay_clk     ),   // 1-bit input: Reference clock input
        .RST    ( ~RES_N           )    // 1-bit input: Active high reset input
    );


    //����������źź����ݽ���ƴ�ӣ����ں������ѭ�����д���
    assign din[4 : 0] = {rgmii_rx_ctl,rgmii_rxd};

    //rgmii_rx_ctl��rgmii_rxd������ʱ��˫�ز���
    generate
        genvar i;
        for(i=0 ; i<5 ; i=i+1)begin : RXDATA_BUS
            // ������ʱ
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


            // ����˫�ز����Ĵ���
            IDDRE1 #(
                .DDR_CLK_EDGE   ("SAME_EDGE_PIPELINED"), // DDRʱ�ӱ���ģʽ��"OPPOSITE_EDGE", "SAME_EDGE", "SAME_EDGE_PIPELINED"��
                .IS_CB_INVERTED (1'b0),           // CB�����Ƿ�ȡ��
                .IS_C_INVERTED  (1'b0)            // C�����Ƿ�ȡ��
            ) IDDRE1_inst (
                .Q1             (gmii_data[i]),   // 1-bit output: ����ʱ�ӵļĴ������ Q1
                .Q2             (gmii_data[5 + i]), // 1-bit output: ����ʱ�ӵļĴ������ Q2
                .C              (rgmii_rxc_bufio), // 1-bit input: ����ʱ�� C
                .CB             (1'b0),           // 1-bit input: ����ʱ�� C ��ȡ�����루ͨ��Ϊ 0����ʾ��ʹ�ã�
                .D              (din_delay[i]),   // 1-bit input: ������������
                .R              (1'b0)            // 1-bit input: �ߵ�ƽ��Ч���첽��λ
            );

        end
    endgenerate

    //ͨ��ƴ�����������źź�������Чָʾ�źš�
    assign gmii_rxd_out = {gmii_data[8:5],gmii_data[3:0]};
    assign gmii_rx_dv = gmii_data[4] & gmii_data[9];//ֻ�е������غ��½��زɼ����Ŀ����źž�Ϊ�ߵ�ƽʱ�����ݲ���Ч��
    
endmodule