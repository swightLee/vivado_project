/*`timescale 1 ns/1 ns
module test();
    parameter	CYCLE		= 10;//ϵͳʱ�����ڣ���λns��Ĭ��10ns��
    parameter	RST_TIME	= 10;//ϵͳ��λ����ʱ�䣬Ĭ��10��ϵͳʱ�����ڣ�
    parameter	STOP_TIME	= 1000;//��������ʱ�䣬��λ��ɺ�����1000��ϵͳʱ�Ӻ�ֹͣ��
    parameter BOARD_MAC     = 48'h00_11_22_33_44_55;
    parameter BOARD_IP      = {8'd192,8'd168,8'd1,8'd10};
    localparam SOURCE_MAC   = 48'h23_45_67_89_0a_bc;
    localparam SOURCE_IP    = {8'd192,8'd168,8'd1,8'd23};
    localparam ETH_TPYE     = 16'h0806 ;//��̫��֡���� ARP

    reg			        clk         ;//ϵͳʱ�ӣ�Ĭ��100MHz��
    reg			        rst_n       ;//ϵͳ��λ��Ĭ�ϵ͵�ƽ��Ч��
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

    //��������ΪCYCLE��ֵ��ϵͳʱ��;
    initial begin
        clk = 0;
        forever #(CYCLE/2) clk = ~clk;
    end

    //���ɸ�λ�źţ�
    initial begin
        #1;gmii_rxd = 0; gmii_rx_dv = 0;gmii_crc_vld = 1'b0;
        gmii_rxd_r=0;gmii_rx_dv_r=0;crc_clr=0;
        rst_n = 1;
        #2;
        rst_n = 0;//��ʼʱ��λ10��ʱ�ӣ�
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
        $stop;//ֹͣ���棻
    end
    
    reg [5:0] i;
    task gmii_tx_test;
        begin
            crc_data_vld = 1'b0;
            #(CYCLE);
            repeat(7)begin//����ǰ����7��8'H55��
                gmii_rxd_r = 8'h55;
                gmii_rx_dv_r = 1'b1;
                #(CYCLE);
            end
            gmii_rxd_r = 8'hd5;//����SFD��һ���ֽڵ�8'hd5��
            #(CYCLE);
            crc_data_vld = 1'b1;
            for(i=0 ; i<6 ; i=i+1)begin//����6���ֽڵ�Ŀ��MAC��ַ��
                gmii_rxd_r = BOARD_MAC[47-8*i -: 8];
                #(CYCLE);
            end
            for(i=0 ; i<6 ; i=i+1)begin//����6���ֽڵ�ԴMAC��ַ��
                gmii_rxd_r = SOURCE_MAC[47-8*i -: 8];
                #(CYCLE);
            end
            for(i=0 ; i<2 ; i=i+1)begin//����2���ֽڵ���̫�����ͣ�
                gmii_rxd_r = ETH_TPYE[15-8*i -: 8];
                #(CYCLE);
            end
            gmii_rxd_r = 8'd0;//����2�ֽڵ�Ӳ����ַ���͡�
            #(CYCLE);
            gmii_rxd_r = 8'd1;
            #(CYCLE);
            gmii_rxd_r = 8'h08;//����2�ֽڵ�Э�����ͣ�0X0800��ʾ�ϲ�IPЭ�顣
            #(CYCLE);
            gmii_rxd_r = 8'h00;
            #(CYCLE);
            gmii_rxd_r = 8'h06;//����1�ֽڵ�Ӳ����ַ���ȡ�
            #(CYCLE);
            gmii_rxd_r = 8'h04;//����1�ֽڵ�IP��ַ���ȡ�
            #(CYCLE);
            gmii_rxd_r = 8'h00;//����2�ֽڵ�OP���룬1��ʾARP����2��ʾARPӦ��
            #(CYCLE);
            gmii_rxd_r = 8'h02;
            #(CYCLE);
            for(i=0 ; i<6 ; i=i+1)begin//����6���ֽڵ�ԴMAC��ַ��
                gmii_rxd_r = SOURCE_MAC[47-8*i -: 8];
                #(CYCLE);
            end
            for(i=0 ; i<4 ; i=i+1)begin//����4���ֽڵ�ԴIP��ַ��
                gmii_rxd_r = SOURCE_IP[31-8*i -: 8];
                #(CYCLE);
            end
            for(i=0 ; i<6 ; i=i+1)begin//����6���ֽ�Ŀ��MAC��ַ��
                gmii_rxd_r = BOARD_MAC[47-8*i -: 8];
                #(CYCLE);
            end
            for(i=0 ; i<4 ; i=i+1)begin//����4���ֽڵ�Ŀ��IP��ַ��
                gmii_rxd_r = BOARD_IP[31-8*i -: 8];
                #(CYCLE);
            end
            for(i=0 ; i<18 ; i=i+1)begin//����18���ֽڵ�0��
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
        if(rst_n==1'b0)begin//��ʼֵΪ0;
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
    localparam      CYCLE	    =   8                           ;//ϵͳʱ�����ڣ���λns��Ĭ��10ns��
    localparam      RST_TIME    =   10                          ;//ϵͳ��λ����ʱ�䣬Ĭ��10��ϵͳʱ�����ڣ�
    localparam      BOARD_MAC   =   48'h00_11_22_33_44_55       ;
    localparam      BOARD_IP    =   {8'd192,8'd168,8'd1,8'd10}  ;
    localparam      DES_MAC     =   48'h23_45_67_89_0a_bc       ;
    localparam      DES_IP      =   {8'd192,8'd168,8'd1,8'd23}  ;
    localparam      ETH_TPYE    =   16'h0806                    ;//��̫��֡���� ARP

    reg			                    clk                         ;//ϵͳʱ�ӣ�Ĭ��100MHz��
    reg			                    rst_n                       ;//ϵͳ��λ��Ĭ�ϵ͵�ƽ��Ч��
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
    
    //����ARPģ�飻
    arp #(
        .BOARD_MAC      ( BOARD_MAC     ),
        .BOARD_IP       ( BOARD_IP      ),
        .DES_MAC        ( DES_MAC       ),
        .DES_IP         ( DES_IP        )
    )
    u_arp (
        .rst_n          ( rst_n         ),//ϵͳ��λ��Ĭ�ϵ͵�ƽ��Ч��
        .gmii_rx_clk    ( clk           ),//ϵͳʱ�ӣ�Ĭ��125MHz��
        .gmii_rx_dv     ( gmii_rx_dv    ),
        .gmii_rxd       ( gmii_rxd      ),
        .gmii_tx_clk    ( clk           ),//ϵͳʱ�ӣ�Ĭ��125MHz��
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
    

    //��������ΪCYCLE��ֵ��ϵͳʱ��;
    initial begin
        clk = 0;
        forever #(CYCLE/2) clk = ~clk;
    end

    //���ɸ�λ�źţ�
    initial begin
        #1;arp_tx_en = 0;arp_tx_type = 0;des_mac = 0; des_ip = 0;
        rst_n = 1;
        #2;
        rst_n = 0;//��ʼʱ��λ10��ʱ�ӣ�
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
        $stop;//ֹͣ���棻
    end

endmodule