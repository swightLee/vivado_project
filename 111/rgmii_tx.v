module rgmii_tx(
    //GMII���Ͷ˿�
    input                   gmii_tx_clk     ,//GMII����ʱ��;
    input       [7:0]       gmii_txd_in       ,//GMII�������;
    input                   gmii_tx_en      ,//GMII���������Ч�źţ��ߵ�ƽ��Ч��
    input                   RES_N,
    //RGMII���Ͷ˿�
    output                  rgmii_txc       ,//RGMII��������ʱ�ӣ�
    output                  rgmii_tx_ctl    ,//RGMII���������Ч�źţ�
    output      [3:0]       rgmii_txd        //RGMII������ݣ�
);
    assign rgmii_txc = gmii_tx_clk;

    //���˫�ز����Ĵ��� (rgmii_tx_ctl)
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
            // ���˫�ز����Ĵ���
            ODDRE1 #(
//                .DDR_CLK_EDGE   ("SAME_EDGE"),  // DDRʱ�ӱ���ģʽ��"OPPOSITE_EDGE" or "SAME_EDGE"��
                .IS_C_INVERTED  (1'b0),        // C�����Ƿ�ȡ��
                .IS_D1_INVERTED (1'b0),        // D1�����Ƿ�ȡ������֧�֣�����Ϊ0��
                .IS_D2_INVERTED (1'b0),        // D2�����Ƿ�ȡ������֧�֣�����Ϊ0��
                .SIM_DEVICE     ("ULTRASCALE"), // �����豸�汾���з��棨ULTRASCALE��
                .SRVAL          (1'b0)         // ��λ���ʼֵ
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