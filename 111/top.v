module top #(
    parameter           BOARD_MAC       =   48'h00_11_22_33_44_55       ,//������MAC��ַ 00-11-22-33-44-55;
    parameter           BOARD_IP        =   {8'd192,8'd168,8'd1,8'd10}  ,//������IP��ַ 192.168.1.10;
    parameter           DES_MAC         =   48'hff_ff_ff_ff_ff_ff       ,//Ŀ��MAC��ַ ff_ff_ff_ff_ff_ff;
    parameter           DES_IP          =   {8'd192,8'd168,8'd1,8'd102}  //Ŀ��IP��ַ 192.168.1.102;
)(
    input									clk		    ,//ϵͳʱ���źţ�
    input									rst_n	    ,//ϵͳ��λ�źţ��͵�ƽ��Ч��

    input				[7 : 0]	            gmii_rxd    ,//�������ݣ�
    input									gmii_rx_dv	,//����������Чָʾ�źţ��ߵ�ƽ��Ч��
    input                                   arp_tx_en   ,
    input                                   arp_tx_type ,
    input               [47 : 0]            des_mac     ,
    input               [31 : 0]            des_ip       
);
    wire                                    gmii_tx_en  ;
    wire                [7 : 0]             gmii_txd    ;
    wire                                    arp_rx_done ;
    wire                                    arp_rx_type ;
    wire                [47 : 0]            src_mac     ;
    wire                [31 : 0]            src_ip      ;
    wire                                    arp_tx_rdy  ;

    //����ARPģ�飻
    arp #(
        .BOARD_MAC      ( BOARD_MAC     ),
        .BOARD_IP       ( BOARD_IP      ),
        .DES_MAC        ( DES_MAC       ),
        .DES_IP         ( DES_IP        )
    )
    u_arp (
        .rst_n          ( rst_n         ),
        .gmii_rx_clk    ( clk           ),
        .gmii_rx_dv     ( gmii_rx_dv    ),
        .gmii_rxd       ( gmii_rxd      ),
        .gmii_tx_clk    ( clk           ),
        .arp_tx_en      ( arp_tx_en     ),
        .arp_tx_type    ( arp_tx_type   ),
        .des_mac        ( des_mac       ),
        .des_ip         ( des_ip        ),
        .gmii_tx_en     ( gmii_tx_en    ),
        .gmii_txd       ( gmii_txd      ),
        .arp_rx_done    ( arp_rx_done   ),
        .arp_rx_type    ( arp_rx_type   ),
        .src_mac        ( src_mac       ),
        .src_ip         ( src_ip        ),
        .arp_tx_rdy     ( arp_tx_rdy    )
    );
    
endmodule