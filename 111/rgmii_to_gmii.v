module rgmii_to_gmii #(
    parameter   IDELAY_VALUE = 0  //��������IO��ʱ(���Ϊn,��ʾ��ʱn*78+600ps) 
)(
    input               idelay_clk      ,//IDELAYʱ��
    input               RES_N,
    //��̫��GMII�ӿ�
    output              gmii_rx_clk     ,//GMII����ʱ��
    output              gmii_rx_dv      ,//GMII����������Ч�ź�
    output      [7:0]   gmii_rxd_out        ,//GMII��������
    output              gmii_tx_clk     ,//GMII����ʱ��
    input               gmii_tx_en      ,//GMII��������ʹ���ź�
    input       [7:0]   gmii_txd_in        ,//GMII��������            
    //��̫��RGMII�ӿ�   
    input               rgmii_rxc       ,//RGMII����ʱ��
    input               rgmii_rx_ctl    ,//RGMII�������ݿ����ź�
    input       [3:0]   rgmii_rxd       ,//RGMII��������
    output              rgmii_txc       ,//RGMII����ʱ��    
    output              rgmii_tx_ctl    ,//RGMII�������ݿ����ź�
    output      [3:0]   rgmii_txd        //RGMII��������          
);
    assign gmii_tx_clk = gmii_rx_clk;

    //����RGMII����ģ��
    rgmii_rx #(
        .IDELAY_VALUE  ( IDELAY_VALUE   )
    )
    u_rgmii_rx(
        .idelay_clk     ( idelay_clk    ),
        .RES_N          (RES_N),
        .gmii_rx_clk    ( gmii_rx_clk   ),
        .rgmii_rxc      ( rgmii_rxc     ),
        .rgmii_rx_ctl   ( rgmii_rx_ctl  ),
        .rgmii_rxd      ( rgmii_rxd     ),
        .gmii_rx_dv     ( gmii_rx_dv    ),
        .gmii_rxd_out       ( gmii_rxd_out      )
    );

    //����RGMII����ģ��
    rgmii_tx u_rgmii_tx(
        .gmii_tx_clk   ( gmii_tx_clk    ),
        .RES_N          (RES_N),
        .gmii_tx_en    ( gmii_tx_en     ),
        .gmii_txd_in      ( gmii_txd_in       ),
        .rgmii_txc     ( rgmii_txc      ),
        .rgmii_tx_ctl  ( rgmii_tx_ctl   ),
        .rgmii_txd     ( rgmii_txd      )
    );

endmodule