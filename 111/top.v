module top #(
    parameter           BOARD_MAC       =   48'h00_11_22_33_44_55       ,//开发板MAC地址 00-11-22-33-44-55;
    parameter           BOARD_IP        =   {8'd192,8'd168,8'd1,8'd10}  ,//开发板IP地址 192.168.1.10;
    parameter           DES_MAC         =   48'hff_ff_ff_ff_ff_ff       ,//目的MAC地址 ff_ff_ff_ff_ff_ff;
    parameter           DES_IP          =   {8'd192,8'd168,8'd1,8'd102}  //目的IP地址 192.168.1.102;
)(
    input									clk		    ,//系统时钟信号；
    input									rst_n	    ,//系统复位信号，低电平有效；

    input				[7 : 0]	            gmii_rxd    ,//输入数据；
    input									gmii_rx_dv	,//输入数据有效指示信号，高电平有效；
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

    //例化ARP模块；
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