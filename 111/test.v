/*`timescale 1 ns/1 ns
module test();
    parameter	CYCLE		= 10;//系统时钟周期，单位ns，默认10ns；
    parameter	RST_TIME	= 10;//系统复位持续时间，默认10个系统时钟周期；
    parameter	STOP_TIME	= 1000;//仿真运行时间，复位完成后运行1000个系统时钟后停止；
    parameter BOARD_MAC     = 48'h00_11_22_33_44_55;
    parameter BOARD_IP      = {8'd192,8'd168,8'd1,8'd10};
    localparam SOURCE_MAC   = 48'h23_45_67_89_0a_bc;
    localparam SOURCE_IP    = {8'd192,8'd168,8'd1,8'd23};
    localparam ETH_TPYE     = 16'h0806 ;//以太网帧类型 ARP

    reg			        clk         ;//系统时钟，默认100MHz；
    reg			        rst_n       ;//系统复位，默认低电平有效；
    reg   [7 : 0]       gmii_rxd    ;
    reg                 gmii_rx_dv  ;

    top #(
        .BOARD_MAC  ( BOARD_MAC     ),
        .BOARD_IP   ( BOARD_IP      )
    )
    u_top (
        .clk        ( clk           ),
        .rst_n      ( rst_n         ),
        .gmii_rxd   ( gmii_rxd      ),
        .gmii_rx_dv ( gmii_rx_dv    )
    );
    
    reg                 crc_clr         ;
    reg                 gmii_crc_vld    ;
    reg   [7 : 0]       gmii_rxd_r      ;
    reg                 gmii_rx_dv_r    ;
    reg                 crc_data_vld    ;
    wire  [31 : 0]      crc_out         ;

    //生成周期为CYCLE数值的系统时钟;
    initial begin
        clk = 0;
        forever #(CYCLE/2) clk = ~clk;
    end

    //生成复位信号；
    initial begin
        #1;gmii_rxd = 0; gmii_rx_dv = 0;gmii_crc_vld = 1'b0;
        gmii_rxd_r=0;gmii_rx_dv_r=0;crc_clr=0;
        rst_n = 1;
        #2;
        rst_n = 0;//开始时复位10个时钟；
        #(RST_TIME*CYCLE);
        rst_n = 1;
        #(20*CYCLE);
        gmii_tx_test();
        gmii_crc_vld = 1'b1;
        gmii_rxd_r = crc_out[31 : 24];
        #(CYCLE);
        gmii_rxd_r = crc_out[23 : 16];
        #(CYCLE);
        gmii_rxd_r = crc_out[15 : 8];
        #(CYCLE);
        gmii_rxd_r = crc_out[7 : 0];
        #(CYCLE);
        gmii_crc_vld = 1'b0;
        crc_clr = 1'b1;
        #(CYCLE);
        crc_clr = 1'b0;
        #(20*CYCLE);
        $stop;//停止仿真；
    end
    
    reg [5:0] i;
    task gmii_tx_test;
        begin
            crc_data_vld = 1'b0;
            #(CYCLE);
            repeat(7)begin//发送前导码7个8'H55；
                gmii_rxd_r = 8'h55;
                gmii_rx_dv_r = 1'b1;
                #(CYCLE);
            end
            gmii_rxd_r = 8'hd5;//发送SFD，一个字节的8'hd5；
            #(CYCLE);
            crc_data_vld = 1'b1;
            for(i=0 ; i<6 ; i=i+1)begin//发送6个字节的目的MAC地址；
                gmii_rxd_r = BOARD_MAC[47-8*i -: 8];
                #(CYCLE);
            end
            for(i=0 ; i<6 ; i=i+1)begin//发送6个字节的源MAC地址；
                gmii_rxd_r = SOURCE_MAC[47-8*i -: 8];
                #(CYCLE);
            end
            for(i=0 ; i<2 ; i=i+1)begin//发送2个字节的以太网类型；
                gmii_rxd_r = ETH_TPYE[15-8*i -: 8];
                #(CYCLE);
            end
            gmii_rxd_r = 8'd0;//发送2字节的硬件地址类型。
            #(CYCLE);
            gmii_rxd_r = 8'd1;
            #(CYCLE);
            gmii_rxd_r = 8'h08;//发送2字节的协议类型，0X0800表示上层IP协议。
            #(CYCLE);
            gmii_rxd_r = 8'h00;
            #(CYCLE);
            gmii_rxd_r = 8'h06;//发送1字节的硬件地址长度。
            #(CYCLE);
            gmii_rxd_r = 8'h04;//发送1字节的IP地址长度。
            #(CYCLE);
            gmii_rxd_r = 8'h00;//发送2字节的OP编码，1表示ARP请求，2表示ARP应答。
            #(CYCLE);
            gmii_rxd_r = 8'h02;
            #(CYCLE);
            for(i=0 ; i<6 ; i=i+1)begin//发送6个字节的源MAC地址；
                gmii_rxd_r = SOURCE_MAC[47-8*i -: 8];
                #(CYCLE);
            end
            for(i=0 ; i<4 ; i=i+1)begin//发送4个字节的源IP地址；
                gmii_rxd_r = SOURCE_IP[31-8*i -: 8];
                #(CYCLE);
            end
            for(i=0 ; i<6 ; i=i+1)begin//发送6个字节目的MAC地址；
                gmii_rxd_r = BOARD_MAC[47-8*i -: 8];
                #(CYCLE);
            end
            for(i=0 ; i<4 ; i=i+1)begin//发送4个字节的目的IP地址；
                gmii_rxd_r = BOARD_IP[31-8*i -: 8];
                #(CYCLE);
            end
            for(i=0 ; i<18 ; i=i+1)begin//补发18个字节的0；
                gmii_rxd_r = 8'd0;
                #(CYCLE);
            end
            crc_data_vld = 1'b0;
            gmii_rx_dv_r = 1'b0;
        end
    endtask
    
    crc32_d8  u_crc32_d8_1 (
        .clk        ( clk           ),
        .rst_n      ( rst_n         ),
        .data       ( gmii_rxd_r    ),
        .crc_en     ( crc_data_vld  ),
        .crc_clr    ( crc_clr       ),
        .crc_out    ( crc_out       )
    );

    always@(posedge clk)begin
        if(rst_n==1'b0)begin//初始值为0;
            gmii_rxd <= 8'd0;
            gmii_rx_dv <= 1'b0;
        end
        else if(gmii_rx_dv_r || gmii_crc_vld)begin
            gmii_rxd <= gmii_rxd_r;
            gmii_rx_dv <= 1'b1;
        end
        else begin
            gmii_rx_dv <= 1'b0;
        end
    end

endmodule*/

`timescale 1 ns/1 ns
module test();
    localparam      CYCLE	    =   8                           ;//系统时钟周期，单位ns，默认10ns；
    localparam      RST_TIME    =   10                          ;//系统复位持续时间，默认10个系统时钟周期；
    localparam      BOARD_MAC   =   48'h00_11_22_33_44_55       ;
    localparam      BOARD_IP    =   {8'd192,8'd168,8'd1,8'd10}  ;
    localparam      DES_MAC     =   48'h23_45_67_89_0a_bc       ;
    localparam      DES_IP      =   {8'd192,8'd168,8'd1,8'd23}  ;
    localparam      ETH_TPYE    =   16'h0806                    ;//以太网帧类型 ARP

    reg			                    clk                         ;//系统时钟，默认100MHz；
    reg			                    rst_n                       ;//系统复位，默认低电平有效；
    reg                             gmii_rx_dv                  ;
    reg             [7 : 0]         gmii_rxd                    ;
    reg                             arp_tx_en                   ;
    reg                             arp_tx_type                 ;
    reg             [47 : 0]        des_mac                     ;
    reg             [31 : 0]        des_ip                      ;

    wire                            gmii_tx_en                  ;
    wire            [7 : 0]         gmii_txd                    ;
    wire                            arp_rx_done                 ;
    wire                            arp_rx_type                 ;
    wire            [47 : 0]        src_mac                     ;
    wire            [31 : 0]        src_ip                      ;
    wire                            arp_tx_rdy                  ;

    always@(*)begin
        gmii_rxd = gmii_txd;
        gmii_rx_dv = gmii_tx_en;
    end
    
    //例化ARP模块；
    arp #(
        .BOARD_MAC      ( BOARD_MAC     ),
        .BOARD_IP       ( BOARD_IP      ),
        .DES_MAC        ( DES_MAC       ),
        .DES_IP         ( DES_IP        )
    )
    u_arp (
        .rst_n          ( rst_n         ),//系统复位，默认低电平有效；
        .gmii_rx_clk    ( clk           ),//系统时钟，默认125MHz；
        .gmii_rx_dv     ( gmii_rx_dv    ),
        .gmii_rxd       ( gmii_rxd      ),
        .gmii_tx_clk    ( clk           ),//系统时钟，默认125MHz；
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
    

    //生成周期为CYCLE数值的系统时钟;
    initial begin
        clk = 0;
        forever #(CYCLE/2) clk = ~clk;
    end

    //生成复位信号；
    initial begin
        #1;arp_tx_en = 0;arp_tx_type = 0;des_mac = 0; des_ip = 0;
        rst_n = 1;
        #2;
        rst_n = 0;//开始时复位10个时钟；
        #(RST_TIME*CYCLE);
        rst_n = 1;
        #(20*CYCLE);
        des_mac = BOARD_MAC;
        des_ip = BOARD_IP;
        arp_tx_en = 1'b1;
        arp_tx_type = 1'b0;
        #(CYCLE);
        arp_tx_en = 1'b0;
        @(posedge arp_tx_rdy);
        #(20*CYCLE);
        des_mac = src_mac;
        des_ip = src_ip;
        arp_tx_en = 1'b1;
        arp_tx_type = 1'b1;
        #(CYCLE);
        arp_tx_en = 1'b0;
        @(posedge arp_tx_rdy);
        #(20*CYCLE);
        $stop;//停止仿真；
    end

endmodule