module bissc_clock_Brtl_688934845f22049cb14668832efa33d45013b6b9
  (input  clk_i,
   input  rst_i,
   input  go_i,
   output busy_o,
   input  [5:0] n_rising_edges_i,
   input  [7:0] half_clk_period_i,
   input  data_i,
   output clk_o);
  wire [7:0] clock_timer;
  wire [1:0] clock_state;
  wire [5:0] rising_counter;
  wire n665;
  wire n668;
  wire [1:0] n670;
  wire n672;
  wire n674;
  wire n675;
  wire n676;
  wire n678;
  wire [5:0] n680;
  wire n682;
  wire [1:0] n684;
  wire [5:0] n685;
  wire n686;
  wire n687;
  wire [5:0] n688;
  wire [7:0] n690;
  wire n691;
  wire n692;
  wire [7:0] n693;
  wire n694;
  wire n695;
  wire n697;
  wire n698;
  wire n700;
  wire [1:0] n702;
  wire n704;
  wire [2:0] n705;
  reg n706;
  reg n707;
  reg [7:0] n708;
  reg [1:0] n709;
  reg [5:0] n710;
  wire n712;
  wire n713;
  wire [7:0] n714;
  wire [1:0] n716;
  wire [5:0] n717;
  reg n724;
  reg n725;
  reg [7:0] n726;
  reg [1:0] n727;
  reg [5:0] n728;
  assign busy_o = n724; //(module output)
  assign clk_o = n725; //(module output)
  /*# build/top.vhdl:101:12 */
  assign clock_timer = n726; // (signal)
  /*# build/top.vhdl:103:12 */
  assign clock_state = n727; // (signal)
  /*# build/top.vhdl:104:12 */
  assign rising_counter = n728; // (signal)
  /*# build/top.vhdl:118:25 */
  assign n665 = go_i ? 1'b1 : n724;
  /*# build/top.vhdl:118:25 */
  assign n668 = go_i ? 1'b0 : 1'b1;
  /*# build/top.vhdl:118:25 */
  assign n670 = go_i ? 2'b01 : clock_state;
  /*# build/top.vhdl:115:21 */
  assign n672 = clock_state == 2'b00;
  /*# build/top.vhdl:126:40 */
  assign n674 = clock_timer == 8'b00000000;
  /*# build/top.vhdl:127:38 */
  assign n675 = ~n725;
  /*# build/top.vhdl:129:32 */
  assign n676 = ~n725;
  /*# build/top.vhdl:130:51 */
  assign n678 = rising_counter == 6'b000000;
  /*# build/top.vhdl:138:70 */
  assign n680 = rising_counter - 6'b000001;
  /*# build/top.vhdl:126:25 */
  assign n682 = n691 ? 1'b0 : n724;
  /*# build/top.vhdl:126:25 */
  assign n684 = n694 ? 2'b00 : clock_state;
  /*# build/top.vhdl:130:33 */
  assign n685 = n678 ? rising_counter : n680;
  /*# build/top.vhdl:129:29 */
  assign n686 = n678 & n676;
  /*# build/top.vhdl:129:29 */
  assign n687 = n678 & n676;
  /*# build/top.vhdl:126:25 */
  assign n688 = n695 ? n685 : rising_counter;
  /*# build/top.vhdl:142:56 */
  assign n690 = clock_timer - 8'b00000001;
  /*# build/top.vhdl:126:25 */
  assign n691 = n686 & n674;
  /*# build/top.vhdl:126:25 */
  assign n692 = n674 ? n675 : n725;
  /*# build/top.vhdl:126:25 */
  assign n693 = n674 ? half_clk_period_i : n690;
  /*# build/top.vhdl:126:25 */
  assign n694 = n687 & n674;
  /*# build/top.vhdl:126:25 */
  assign n695 = n676 & n674;
  /*# build/top.vhdl:125:21 */
  assign n697 = clock_state == 2'b01;
  /*# build/top.vhdl:145:35 */
  assign n698 = data_i | go_i;
  /*# build/top.vhdl:145:25 */
  assign n700 = n698 ? 1'b0 : n724;
  /*# build/top.vhdl:145:25 */
  assign n702 = n698 ? 2'b00 : clock_state;
  /*# build/top.vhdl:144:21 */
  assign n704 = clock_state == 2'b10;
  /*# build/top.vhdl:114:17 */
  assign n705 = {n704, n697, n672};
  /*# build/top.vhdl:114:17 */
  always @*
    case (n705)
      3'b100: n706 = n700;
      3'b010: n706 = n682;
      3'b001: n706 = n665;
      default: n706 = n724;
    endcase
  /*# build/top.vhdl:114:17 */
  always @*
    case (n705)
      3'b100: n707 = n725;
      3'b010: n707 = n692;
      3'b001: n707 = n668;
      default: n707 = n725;
    endcase
  /*# build/top.vhdl:114:17 */
  always @*
    case (n705)
      3'b100: n708 = clock_timer;
      3'b010: n708 = n693;
      3'b001: n708 = half_clk_period_i;
      default: n708 = clock_timer;
    endcase
  /*# build/top.vhdl:114:17 */
  always @*
    case (n705)
      3'b100: n709 = n702;
      3'b010: n709 = n684;
      3'b001: n709 = n670;
      default: n709 = clock_state;
    endcase
  /*# build/top.vhdl:114:17 */
  always @*
    case (n705)
      3'b100: n710 = rising_counter;
      3'b010: n710 = n688;
      3'b001: n710 = n_rising_edges_i;
      default: n710 = rising_counter;
    endcase
  /*# build/top.vhdl:110:13 */
  assign n712 = rst_i ? 1'b0 : n706;
  /*# build/top.vhdl:110:13 */
  assign n713 = rst_i ? n725 : n707;
  /*# build/top.vhdl:110:13 */
  assign n714 = rst_i ? clock_timer : n708;
  /*# build/top.vhdl:110:13 */
  assign n716 = rst_i ? 2'b00 : n709;
  /*# build/top.vhdl:110:13 */
  assign n717 = rst_i ? rising_counter : n710;
  /*# build/top.vhdl:109:9 */
  always @(posedge clk_i)
    n724 <= n712;
  /*# build/top.vhdl:109:9 */
  always @(posedge clk_i)
    n725 <= n713;
  /*# build/top.vhdl:109:9 */
  always @(posedge clk_i)
    n726 <= n714;
  /*# build/top.vhdl:109:9 */
  always @(posedge clk_i)
    n727 <= n716;
  /*# build/top.vhdl:109:9 */
  always @(posedge clk_i)
    n728 <= n717;
endmodule

module bissc_clock_Brtl_f70af62ee4cd5ae2b0ba027eb472ca7c56eacd2e
  (input  clk_i,
   input  rst_i,
   input  go_i,
   output busy_o,
   input  [5:0] n_rising_edges_i,
   input  [7:0] half_clk_period_i,
   input  data_i,
   output clk_o);
  wire [7:0] clock_timer;
  wire [1:0] clock_state;
  wire [5:0] rising_counter;
  wire n600;
  wire n603;
  wire [1:0] n605;
  wire n607;
  wire n609;
  wire n610;
  wire n611;
  wire n613;
  wire [5:0] n615;
  wire [1:0] n617;
  wire [5:0] n618;
  wire n619;
  wire [5:0] n620;
  wire [7:0] n622;
  wire n623;
  wire [7:0] n624;
  wire n625;
  wire n626;
  wire n628;
  wire n629;
  wire n631;
  wire [1:0] n633;
  wire n635;
  wire [2:0] n636;
  reg n637;
  reg n638;
  reg [7:0] n639;
  reg [1:0] n640;
  reg [5:0] n641;
  wire n643;
  wire n644;
  wire [7:0] n645;
  wire [1:0] n647;
  wire [5:0] n648;
  reg n655;
  reg n656;
  reg [7:0] n657;
  reg [1:0] n658;
  reg [5:0] n659;
  assign busy_o = n655; //(module output)
  assign clk_o = n656; //(module output)
  /*# build/top.vhdl:101:12 */
  assign clock_timer = n657; // (signal)
  /*# build/top.vhdl:103:12 */
  assign clock_state = n658; // (signal)
  /*# build/top.vhdl:104:12 */
  assign rising_counter = n659; // (signal)
  /*# build/top.vhdl:118:25 */
  assign n600 = go_i ? 1'b1 : n655;
  /*# build/top.vhdl:118:25 */
  assign n603 = go_i ? 1'b0 : 1'b1;
  /*# build/top.vhdl:118:25 */
  assign n605 = go_i ? 2'b01 : clock_state;
  /*# build/top.vhdl:115:21 */
  assign n607 = clock_state == 2'b00;
  /*# build/top.vhdl:126:40 */
  assign n609 = clock_timer == 8'b00000000;
  /*# build/top.vhdl:127:38 */
  assign n610 = ~n656;
  /*# build/top.vhdl:129:32 */
  assign n611 = ~n656;
  /*# build/top.vhdl:130:51 */
  assign n613 = rising_counter == 6'b000000;
  /*# build/top.vhdl:138:70 */
  assign n615 = rising_counter - 6'b000001;
  /*# build/top.vhdl:126:25 */
  assign n617 = n625 ? 2'b10 : clock_state;
  /*# build/top.vhdl:130:33 */
  assign n618 = n613 ? rising_counter : n615;
  /*# build/top.vhdl:129:29 */
  assign n619 = n613 & n611;
  /*# build/top.vhdl:126:25 */
  assign n620 = n626 ? n618 : rising_counter;
  /*# build/top.vhdl:142:56 */
  assign n622 = clock_timer - 8'b00000001;
  /*# build/top.vhdl:126:25 */
  assign n623 = n609 ? n610 : n656;
  /*# build/top.vhdl:126:25 */
  assign n624 = n609 ? half_clk_period_i : n622;
  /*# build/top.vhdl:126:25 */
  assign n625 = n619 & n609;
  /*# build/top.vhdl:126:25 */
  assign n626 = n611 & n609;
  /*# build/top.vhdl:125:21 */
  assign n628 = clock_state == 2'b01;
  /*# build/top.vhdl:145:35 */
  assign n629 = data_i | go_i;
  /*# build/top.vhdl:145:25 */
  assign n631 = n629 ? 1'b0 : n655;
  /*# build/top.vhdl:145:25 */
  assign n633 = n629 ? 2'b00 : clock_state;
  /*# build/top.vhdl:144:21 */
  assign n635 = clock_state == 2'b10;
  /*# build/top.vhdl:114:17 */
  assign n636 = {n635, n628, n607};
  /*# build/top.vhdl:114:17 */
  always @*
    case (n636)
      3'b100: n637 = n631;
      3'b010: n637 = n655;
      3'b001: n637 = n600;
      default: n637 = n655;
    endcase
  /*# build/top.vhdl:114:17 */
  always @*
    case (n636)
      3'b100: n638 = n656;
      3'b010: n638 = n623;
      3'b001: n638 = n603;
      default: n638 = n656;
    endcase
  /*# build/top.vhdl:114:17 */
  always @*
    case (n636)
      3'b100: n639 = clock_timer;
      3'b010: n639 = n624;
      3'b001: n639 = half_clk_period_i;
      default: n639 = clock_timer;
    endcase
  /*# build/top.vhdl:114:17 */
  always @*
    case (n636)
      3'b100: n640 = n633;
      3'b010: n640 = n617;
      3'b001: n640 = n605;
      default: n640 = clock_state;
    endcase
  /*# build/top.vhdl:114:17 */
  always @*
    case (n636)
      3'b100: n641 = rising_counter;
      3'b010: n641 = n620;
      3'b001: n641 = n_rising_edges_i;
      default: n641 = rising_counter;
    endcase
  /*# build/top.vhdl:110:13 */
  assign n643 = rst_i ? 1'b0 : n637;
  /*# build/top.vhdl:110:13 */
  assign n644 = rst_i ? n656 : n638;
  /*# build/top.vhdl:110:13 */
  assign n645 = rst_i ? clock_timer : n639;
  /*# build/top.vhdl:110:13 */
  assign n647 = rst_i ? 2'b00 : n640;
  /*# build/top.vhdl:110:13 */
  assign n648 = rst_i ? rising_counter : n641;
  /*# build/top.vhdl:109:9 */
  always @(posedge clk_i)
    n655 <= n643;
  /*# build/top.vhdl:109:9 */
  always @(posedge clk_i)
    n656 <= n644;
  /*# build/top.vhdl:109:9 */
  always @(posedge clk_i)
    n657 <= n645;
  /*# build/top.vhdl:109:9 */
  always @(posedge clk_i)
    n658 <= n647;
  /*# build/top.vhdl:109:9 */
  always @(posedge clk_i)
    n659 <= n648;
endmodule

module bissc_capture_Brtl
  (input  clk_i,
   input  rst_i,
   input  go_i,
   input  samp_i,
   input  data_i,
   input  done_i,
   output [50:0] pos_o,
   output valid_o,
   output err_o);
  reg [1:0] state;
  wire [2:0] initial_bits;
  wire [5:0] crc;
  wire [58:0] shift_pos;
  wire [1:0] n495;
  wire n497;
  wire n500;
  wire [1:0] n502;
  wire [1:0] n503;
  wire [2:0] n504;
  wire n506;
  wire [1:0] n508;
  wire n509;
  wire [2:0] n510;
  wire n513;
  wire [57:0] n514;
  wire [58:0] n515;
  wire [3:0] n516;
  wire n517;
  wire n518;
  wire n519;
  wire n520;
  wire n521;
  wire [5:0] n522;
  wire [5:0] n523;
  wire [58:0] n524;
  wire [50:0] n525;
  wire n527;
  wire n528;
  wire n529;
  wire n530;
  wire n533;
  wire [50:0] n534;
  wire n537;
  wire n539;
  wire [1:0] n541;
  wire n543;
  wire [2:0] n544;
  reg [50:0] n546;
  reg n549;
  reg n552;
  reg [1:0] n554;
  reg [2:0] n557;
  reg [5:0] n560;
  reg [58:0] n563;
  wire [50:0] n566;
  wire n568;
  wire n571;
  wire [1:0] n574;
  wire [2:0] n575;
  wire [5:0] n576;
  wire [58:0] n577;
  reg [50:0] n588;
  reg n589;
  reg n590;
  reg [1:0] n591;
  reg [2:0] n592;
  reg [5:0] n593;
  reg [58:0] n594;
  assign pos_o = n588; //(module output)
  assign valid_o = n589; //(module output)
  assign err_o = n590; //(module output)
  /*# build/top.vhdl:23:12 */
  always @*
    state = n591; // (isignal)
  initial
    state = 2'b00;
  /*# build/top.vhdl:24:12 */
  assign initial_bits = n592; // (signal)
  /*# build/top.vhdl:25:12 */
  assign crc = n593; // (signal)
  /*# build/top.vhdl:26:12 */
  assign shift_pos = n594; // (signal)
  /*# build/top.vhdl:42:25 */
  assign n495 = go_i ? 2'b01 : state;
  /*# build/top.vhdl:38:21 */
  assign n497 = state == 2'b00;
  /*# build/top.vhdl:46:25 */
  assign n500 = done_i ? 1'b1 : 1'b0;
  /*# build/top.vhdl:46:25 */
  assign n502 = done_i ? 2'b00 : state;
  /*# build/top.vhdl:51:62 */
  assign n503 = initial_bits[1:0]; // extract
  /*# build/top.vhdl:51:75 */
  assign n504 = {n503, data_i};
  /*# build/top.vhdl:53:50 */
  assign n506 = n504 == 3'b010;
  /*# build/top.vhdl:50:25 */
  assign n508 = n509 ? 2'b10 : n502;
  /*# build/top.vhdl:50:25 */
  assign n509 = n506 & samp_i;
  /*# build/top.vhdl:50:25 */
  assign n510 = samp_i ? n504 : initial_bits;
  /*# build/top.vhdl:45:21 */
  assign n513 = state == 2'b01;
  /*# build/top.vhdl:59:51 */
  assign n514 = shift_pos[57:0]; // extract
  /*# build/top.vhdl:59:65 */
  assign n515 = {n514, data_i};
  /*# build/top.vhdl:60:51 */
  assign n516 = crc[4:1]; // extract
  /*# build/top.vhdl:61:42 */
  assign n517 = crc[0]; // extract
  /*# build/top.vhdl:61:53 */
  assign n518 = crc[5]; // extract
  /*# build/top.vhdl:61:46 */
  assign n519 = n517 ^ n518;
  /*# build/top.vhdl:62:53 */
  assign n520 = crc[5]; // extract
  /*# build/top.vhdl:62:46 */
  assign n521 = data_i ^ n520;
  /*# build/top.vhdl:58:25 */
  assign n522 = {n516, n519, n521};
  /*# build/top.vhdl:58:25 */
  assign n523 = samp_i ? n522 : crc;
  /*# build/top.vhdl:58:25 */
  assign n524 = samp_i ? n515 : shift_pos;
  /*# build/top.vhdl:67:47 */
  assign n525 = shift_pos[58:8]; // extract
  /*# build/top.vhdl:68:36 */
  assign n527 = crc != 6'b111111;
  /*# build/top.vhdl:68:60 */
  assign n528 = shift_pos[7]; // extract
  /*# build/top.vhdl:68:64 */
  assign n529 = ~n528;
  /*# build/top.vhdl:68:48 */
  assign n530 = n527 | n529;
  /*# build/top.vhdl:68:29 */
  assign n533 = n530 ? 1'b1 : 1'b0;
  /*# build/top.vhdl:64:25 */
  assign n534 = done_i ? n525 : n588;
  /*# build/top.vhdl:64:25 */
  assign n537 = done_i ? 1'b1 : 1'b0;
  /*# build/top.vhdl:64:25 */
  assign n539 = done_i ? n533 : 1'b0;
  /*# build/top.vhdl:64:25 */
  assign n541 = done_i ? 2'b00 : state;
  /*# build/top.vhdl:57:21 */
  assign n543 = state == 2'b10;
  /*# build/top.vhdl:37:17 */
  assign n544 = {n543, n513, n497};
  /*# build/top.vhdl:37:17 */
  always @*
    case (n544)
      3'b100: n546 = n534;
      3'b010: n546 = n588;
      3'b001: n546 = n588;
      default: n546 = 51'bX;
    endcase
  /*# build/top.vhdl:37:17 */
  always @*
    case (n544)
      3'b100: n549 = n537;
      3'b010: n549 = 1'b0;
      3'b001: n549 = 1'b0;
      default: n549 = 1'bX;
    endcase
  /*# build/top.vhdl:37:17 */
  always @*
    case (n544)
      3'b100: n552 = n539;
      3'b010: n552 = n500;
      3'b001: n552 = 1'b0;
      default: n552 = 1'bX;
    endcase
  /*# build/top.vhdl:37:17 */
  always @*
    case (n544)
      3'b100: n554 = n541;
      3'b010: n554 = n508;
      3'b001: n554 = n495;
      default: n554 = 2'bX;
    endcase
  /*# build/top.vhdl:37:17 */
  always @*
    case (n544)
      3'b100: n557 = initial_bits;
      3'b010: n557 = n510;
      3'b001: n557 = 3'b000;
      default: n557 = 3'bX;
    endcase
  /*# build/top.vhdl:37:17 */
  always @*
    case (n544)
      3'b100: n560 = n523;
      3'b010: n560 = crc;
      3'b001: n560 = 6'b000000;
      default: n560 = 6'bX;
    endcase
  /*# build/top.vhdl:37:17 */
  always @*
    case (n544)
      3'b100: n563 = n524;
      3'b010: n563 = shift_pos;
      3'b001: n563 = 59'b00000000000000000000000000000000000000000000000000000000000;
      default: n563 = 59'bX;
    endcase
  /*# build/top.vhdl:34:13 */
  assign n566 = rst_i ? n588 : n546;
  /*# build/top.vhdl:34:13 */
  assign n568 = rst_i ? 1'b0 : n549;
  /*# build/top.vhdl:34:13 */
  assign n571 = rst_i ? 1'b0 : n552;
  /*# build/top.vhdl:34:13 */
  assign n574 = rst_i ? 2'b00 : n554;
  /*# build/top.vhdl:34:13 */
  assign n575 = rst_i ? initial_bits : n557;
  /*# build/top.vhdl:34:13 */
  assign n576 = rst_i ? crc : n560;
  /*# build/top.vhdl:34:13 */
  assign n577 = rst_i ? shift_pos : n563;
  /*# build/top.vhdl:31:9 */
  always @(posedge clk_i)
    n588 <= n566;
  /*# build/top.vhdl:31:9 */
  always @(posedge clk_i)
    n589 <= n568;
  /*# build/top.vhdl:31:9 */
  always @(posedge clk_i)
    n590 <= n571;
  /*# build/top.vhdl:31:9 */
  always @(posedge clk_i)
    n591 <= n574;
  initial
    n591 = 2'b00;
  /*# build/top.vhdl:31:9 */
  always @(posedge clk_i)
    n592 <= n575;
  /*# build/top.vhdl:31:9 */
  always @(posedge clk_i)
    n593 <= n576;
  /*# build/top.vhdl:31:9 */
  always @(posedge clk_i)
    n594 <= n577;
endmodule

module bissc_extended_clock_Brtl
  (input  clk_i,
   input  rst_i,
   input  go_i,
   output done_o,
   input  [5:0] n_rising_edges_i,
   input  [7:0] half_clk_period_i,
   input  data_i,
   output samp_o,
   output data_o,
   output clk_o);
  wire [5:0] nbits;
  wire samp_clk;
  wire samp_clk_dly;
  wire samp_clk_rise;
  wire go2;
  reg [1:0] state;
  wire data_dly;
  wire data_dly2;
  wire busy1;
  wire busy2;
  wire [5:0] n426;
  wire \bissc_clock_inst.clk_o ;
  wire n431;
  wire n432;
  wire [1:0] n437;
  wire n439;
  wire n440;
  wire [1:0] n442;
  wire n445;
  wire [1:0] n447;
  wire n449;
  wire n450;
  wire n451;
  wire n452;
  wire n455;
  wire [1:0] n457;
  wire n459;
  wire [2:0] n460;
  reg n462;
  reg n465;
  reg [1:0] n466;
  wire n467;
  wire n469;
  wire [1:0] n472;
  reg n480;
  reg n481;
  reg n482;
  reg [1:0] n483;
  reg n484;
  reg n485;
  assign done_o = n480; //(module output)
  assign samp_o = samp_clk_rise; //(module output)
  assign data_o = data_dly2; //(module output)
  assign clk_o = \bissc_clock_inst.clk_o ; //(module output)
  /*# build/top.vhdl:180:12 */
  assign nbits = n426; // (signal)
  /*# build/top.vhdl:182:12 */
  assign samp_clk_dly = n481; // (signal)
  /*# build/top.vhdl:183:12 */
  assign samp_clk_rise = n432; // (signal)
  /*# build/top.vhdl:184:12 */
  assign go2 = n482; // (signal)
  /*# build/top.vhdl:186:12 */
  always @*
    state = n483; // (isignal)
  initial
    state = 2'b00;
  /*# build/top.vhdl:187:12 */
  assign data_dly = n484; // (signal)
  /*# build/top.vhdl:188:12 */
  assign data_dly2 = n485; // (signal)
  /*# build/top.vhdl:193:31 */
  assign n426 = n_rising_edges_i - 6'b000010;
  /*# build/top.vhdl:195:5 */
  bissc_clock_Brtl_f70af62ee4cd5ae2b0ba027eb472ca7c56eacd2e bissc_clock_inst (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .go_i(go_i),
    .n_rising_edges_i(n_rising_edges_i),
    .half_clk_period_i(half_clk_period_i),
    .data_i(data_i),
    .busy_o(busy1),
    .clk_o(\bissc_clock_inst.clk_o ));
  /*# build/top.vhdl:209:5 */
  bissc_clock_Brtl_688934845f22049cb14668832efa33d45013b6b9 bissc_samp_clock_inst (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .go_i(go2),
    .n_rising_edges_i(nbits),
    .half_clk_period_i(half_clk_period_i),
    .data_i(data_i),
    .busy_o(busy2),
    .clk_o(samp_clk));
  /*# build/top.vhdl:223:35 */
  assign n431 = ~samp_clk_dly;
  /*# build/top.vhdl:223:31 */
  assign n432 = samp_clk & n431;
  /*# build/top.vhdl:239:25 */
  assign n437 = go_i ? 2'b01 : state;
  /*# build/top.vhdl:238:21 */
  assign n439 = state == 2'b00;
  /*# build/top.vhdl:243:28 */
  assign n440 = ~data_i;
  /*# build/top.vhdl:246:25 */
  assign n442 = go_i ? 2'b10 : state;
  /*# build/top.vhdl:243:25 */
  assign n445 = n440 ? 1'b1 : 1'b0;
  /*# build/top.vhdl:243:25 */
  assign n447 = n440 ? 2'b10 : n442;
  /*# build/top.vhdl:242:21 */
  assign n449 = state == 2'b01;
  /*# build/top.vhdl:250:28 */
  assign n450 = ~busy1;
  /*# build/top.vhdl:250:42 */
  assign n451 = ~busy2;
  /*# build/top.vhdl:250:38 */
  assign n452 = n450 & n451;
  /*# build/top.vhdl:250:25 */
  assign n455 = n452 ? 1'b1 : 1'b0;
  /*# build/top.vhdl:250:25 */
  assign n457 = n452 ? 2'b00 : state;
  /*# build/top.vhdl:249:21 */
  assign n459 = state == 2'b10;
  /*# build/top.vhdl:237:17 */
  assign n460 = {n459, n449, n439};
  /*# build/top.vhdl:237:17 */
  always @*
    case (n460)
      3'b100: n462 = n455;
      3'b010: n462 = 1'b0;
      3'b001: n462 = 1'b0;
      default: n462 = 1'b0;
    endcase
  /*# build/top.vhdl:237:17 */
  always @*
    case (n460)
      3'b100: n465 = 1'b0;
      3'b010: n465 = n445;
      3'b001: n465 = 1'b0;
      default: n465 = 1'b0;
    endcase
  /*# build/top.vhdl:237:17 */
  always @*
    case (n460)
      3'b100: n466 = n457;
      3'b010: n466 = n447;
      3'b001: n466 = n437;
      default: n466 = state;
    endcase
  /*# build/top.vhdl:233:13 */
  assign n467 = rst_i ? n480 : n462;
  /*# build/top.vhdl:233:13 */
  assign n469 = rst_i ? 1'b0 : n465;
  /*# build/top.vhdl:233:13 */
  assign n472 = rst_i ? 2'b00 : n466;
  /*# build/top.vhdl:228:9 */
  always @(posedge clk_i)
    n480 <= n467;
  /*# build/top.vhdl:228:9 */
  always @(posedge clk_i)
    n481 <= samp_clk;
  /*# build/top.vhdl:228:9 */
  always @(posedge clk_i)
    n482 <= n469;
  /*# build/top.vhdl:228:9 */
  always @(posedge clk_i)
    n483 <= n472;
  initial
    n483 = 2'b00;
  /*# build/top.vhdl:228:9 */
  always @(posedge clk_i)
    n484 <= data_i;
  /*# build/top.vhdl:228:9 */
  always @(posedge clk_i)
    n485 <= data_dly;
endmodule

module trigger_generator_Brtl
  (input  clk_i,
   input  rst_i,
   input  go_i,
   output busy_o,
   input  [31:0] trig_period_i,
   input  [31:0] ntrig_i,
   output trig_o);
  wire [31:0] trig_timer;
  wire [31:0] trig_count;
  wire running;
  wire n372;
  wire n374;
  wire n376;
  wire [31:0] n378;
  wire [31:0] n379;
  wire [31:0] n380;
  wire n382;
  wire [31:0] n384;
  wire n387;
  wire [31:0] n388;
  wire [31:0] n389;
  wire n390;
  wire [31:0] n391;
  wire [31:0] n392;
  wire n394;
  wire n396;
  wire [31:0] n397;
  wire [31:0] n398;
  wire n399;
  wire n401;
  wire [31:0] n404;
  wire [31:0] n406;
  wire n408;
  reg n415;
  reg n416;
  reg [31:0] n417;
  reg [31:0] n418;
  reg n419;
  assign busy_o = n415; //(module output)
  assign trig_o = n416; //(module output)
  /*# build/top.vhdl:635:12 */
  assign trig_timer = n417; // (signal)
  /*# build/top.vhdl:636:12 */
  assign trig_count = n418; // (signal)
  /*# build/top.vhdl:637:12 */
  assign running = n419; // (signal)
  /*# build/top.vhdl:643:31 */
  assign n372 = running | go_i;
  /*# build/top.vhdl:649:31 */
  assign n374 = trig_timer == 32'b00000000000000000000000000000000;
  /*# build/top.vhdl:651:35 */
  assign n376 = trig_count == 32'b00000000000000000000000000000000;
  /*# build/top.vhdl:654:50 */
  assign n378 = trig_count - 32'b00000000000000000000000000000001;
  /*# build/top.vhdl:651:21 */
  assign n379 = n376 ? trig_timer : trig_period_i;
  /*# build/top.vhdl:651:21 */
  assign n380 = n376 ? trig_count : n378;
  /*# build/top.vhdl:649:17 */
  assign n382 = n390 ? 1'b0 : running;
  /*# build/top.vhdl:658:46 */
  assign n384 = trig_timer - 32'b00000000000000000000000000000001;
  /*# build/top.vhdl:649:17 */
  assign n387 = n374 ? 1'b1 : 1'b0;
  /*# build/top.vhdl:649:17 */
  assign n388 = n374 ? n379 : n384;
  /*# build/top.vhdl:649:17 */
  assign n389 = n374 ? n380 : trig_count;
  /*# build/top.vhdl:649:17 */
  assign n390 = n376 & n374;
  /*# build/top.vhdl:661:13 */
  assign n391 = go_i ? trig_period_i : trig_timer;
  /*# build/top.vhdl:661:13 */
  assign n392 = go_i ? ntrig_i : trig_count;
  /*# build/top.vhdl:661:13 */
  assign n394 = go_i ? 1'b1 : running;
  /*# build/top.vhdl:648:13 */
  assign n396 = running ? n387 : 1'b0;
  /*# build/top.vhdl:648:13 */
  assign n397 = running ? n388 : n391;
  /*# build/top.vhdl:648:13 */
  assign n398 = running ? n389 : n392;
  /*# build/top.vhdl:648:13 */
  assign n399 = running ? n382 : n394;
  /*# build/top.vhdl:644:13 */
  assign n401 = rst_i ? 1'b0 : n396;
  /*# build/top.vhdl:644:13 */
  assign n404 = rst_i ? 32'b00000000000000000000000000000000 : n397;
  /*# build/top.vhdl:644:13 */
  assign n406 = rst_i ? 32'b00000000000000000000000000000000 : n398;
  /*# build/top.vhdl:644:13 */
  assign n408 = rst_i ? 1'b0 : n399;
  /*# build/top.vhdl:641:9 */
  always @(posedge clk_i)
    n415 <= n372;
  /*# build/top.vhdl:641:9 */
  always @(posedge clk_i)
    n416 <= n401;
  /*# build/top.vhdl:641:9 */
  always @(posedge clk_i)
    n417 <= n404;
  /*# build/top.vhdl:641:9 */
  always @(posedge clk_i)
    n418 <= n406;
  /*# build/top.vhdl:641:9 */
  always @(posedge clk_i)
    n419 <= n408;
endmodule

module pulse_stretch_Brtl
  (input  clk_i,
   input  rst_i,
   input  [25:0] width_i,
   input  trig_i,
   output pulse_o);
  wire [25:0] pulse_timer;
  wire pulse;
  wire n344;
  wire n349;
  wire [25:0] n351;
  wire [25:0] n352;
  wire n355;
  wire [25:0] n356;
  wire n358;
  wire [25:0] n360;
  wire n362;
  reg [25:0] n366;
  reg n367;
  assign pulse_o = n344; //(module output)
  /*# build/top.vhdl:405:12 */
  assign pulse_timer = n366; // (signal)
  /*# build/top.vhdl:406:12 */
  assign pulse = n367; // (signal)
  /*# build/top.vhdl:408:22 */
  assign n344 = pulse | trig_i;
  /*# build/top.vhdl:419:31 */
  assign n349 = pulse_timer != 26'b00000000000000000000000000;
  /*# build/top.vhdl:420:44 */
  assign n351 = pulse_timer - 26'b00000000000000000000000001;
  /*# build/top.vhdl:419:13 */
  assign n352 = n349 ? n351 : pulse_timer;
  /*# build/top.vhdl:419:13 */
  assign n355 = n349 ? 1'b1 : 1'b0;
  /*# build/top.vhdl:416:13 */
  assign n356 = trig_i ? width_i : n352;
  /*# build/top.vhdl:416:13 */
  assign n358 = trig_i ? 1'b1 : n355;
  /*# build/top.vhdl:413:13 */
  assign n360 = rst_i ? 26'b00000000000000000000000000 : n356;
  /*# build/top.vhdl:413:13 */
  assign n362 = rst_i ? 1'b0 : n358;
  /*# build/top.vhdl:412:9 */
  always @(posedge clk_i)
    n366 <= n360;
  /*# build/top.vhdl:412:9 */
  always @(posedge clk_i)
    n367 <= n362;
endmodule

module bissc_Barch
  (input  clk_i,
   input  rst_i,
   input  go_i,
   input  [7:0] half_clk_period_i,
   input  [5:0] n_rising_edges_i,
   output [50:0] pos_o,
   output valid_o,
   output err_o,
   output clk_o,
   input  data_i);
  wire clock_done;
  wire data;
  wire samp;
  wire \bissc_extended_clock_inst.clk_o ;
  wire [50:0] \bissc_capture_inst.pos_o ;
  wire \bissc_capture_inst.valid_o ;
  wire \bissc_capture_inst.err_o ;
  assign pos_o = \bissc_capture_inst.pos_o ; //(module output)
  assign valid_o = \bissc_capture_inst.valid_o ; //(module output)
  assign err_o = \bissc_capture_inst.err_o ; //(module output)
  assign clk_o = \bissc_extended_clock_inst.clk_o ; //(module output)
  /*# build/top.vhdl:286:5 */
  bissc_extended_clock_Brtl bissc_extended_clock_inst (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .go_i(go_i),
    .n_rising_edges_i(n_rising_edges_i),
    .half_clk_period_i(half_clk_period_i),
    .data_i(data_i),
    .done_o(clock_done),
    .samp_o(samp),
    .data_o(data),
    .clk_o(\bissc_extended_clock_inst.clk_o ));
  /*# build/top.vhdl:299:5 */
  bissc_capture_Brtl bissc_capture_inst (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .go_i(go_i),
    .samp_i(samp),
    .data_i(data),
    .done_i(clock_done),
    .pos_o(\bissc_capture_inst.pos_o ),
    .valid_o(\bissc_capture_inst.valid_o ),
    .err_o(\bissc_capture_inst.err_o ));
endmodule

module deglitcher_Brtl_3
  (input  clk_i,
   input  bit_i,
   output bit_o);
  wire [2:0] bit_shift;
  wire [1:0] n317;
  wire [2:0] n318;
  wire n320;
  wire n322;
  wire n324;
  wire n326;
  reg n330;
  reg [2:0] n331;
  assign bit_o = n330; //(module output)
  /*# build/top.vhdl:327:12 */
  assign bit_shift = n331; // (signal)
  /*# build/top.vhdl:334:35 */
  assign n317 = bit_shift[1:0]; // extract
  /*# build/top.vhdl:334:48 */
  assign n318 = {n317, bit_i};
  /*# build/top.vhdl:335:26 */
  assign n320 = bit_shift == 3'b111;
  /*# build/top.vhdl:337:29 */
  assign n322 = bit_shift == 3'b000;
  /*# build/top.vhdl:337:13 */
  assign n324 = n322 ? 1'b0 : n330;
  /*# build/top.vhdl:335:13 */
  assign n326 = n320 ? 1'b1 : n324;
  /*# build/top.vhdl:333:9 */
  always @(posedge clk_i)
    n330 <= n326;
  /*# build/top.vhdl:333:9 */
  always @(posedge clk_i)
    n331 <= n318;
endmodule

module sync_bit_Brtl
  (input  clk_i,
   input  bit_i,
   output bit_o);
  reg bit_meta;
  reg n311;
  reg n312;
  assign bit_o = n311; //(module output)
  /*# build/top.vhdl:606:12 */
  always @*
    bit_meta = n312; // (isignal)
  initial
    bit_meta = 1'b0;
  /*# build/top.vhdl:610:9 */
  always @(posedge clk_i)
    n311 <= bit_meta;
  /*# build/top.vhdl:610:9 */
  always @(posedge clk_i)
    n312 <= bit_i;
  initial
    n312 = 1'b0;
endmodule

module pulsed_trigger_Brtl
  (input  clk_i,
   input  rst_i,
   input  go_i,
   output busy_o,
   input  [31:0] trig_period_i,
   input  [31:0] ntrig_i,
   input  [25:0] width_i,
   output trig_o,
   output pulse_o);
  wire trig;
  wire busy;
  wire n299;
  wire \pulse_stretch_inst.pulse_o ;
  assign busy_o = n299; //(module output)
  assign trig_o = trig; //(module output)
  assign pulse_o = \pulse_stretch_inst.pulse_o ; //(module output)
  /*# build/top.vhdl:368:20 */
  assign n299 = busy | \pulse_stretch_inst.pulse_o ;
  /*# build/top.vhdl:371:5 */
  pulse_stretch_Brtl pulse_stretch_inst (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .width_i(width_i),
    .trig_i(trig),
    .pulse_o(\pulse_stretch_inst.pulse_o ));
  /*# build/top.vhdl:379:5 */
  trigger_generator_Brtl trig_gen_inst (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .go_i(go_i),
    .trig_period_i(trig_period_i),
    .ntrig_i(ntrig_i),
    .busy_o(busy),
    .trig_o(trig));
endmodule

module spi_registers_Brtl
  (input  clk_i,
   input  rst_i,
   input  cs_i,
   input  sck_i,
   input  rx_i,
   output tx_o,
   input  [31:0] pos_i,
   input  pos_valid_i,
   input  error_event_i,
   output [31:0] ntrig_o,
   output [31:0] trig_period_o,
   output [25:0] width_o,
   output pos_req_o,
   output acq_start_o,
   output [7:0] bissc_half_clk_period_o,
   output [5:0] bissc_n_rising_edges_o);
  wire [31:0] dataout;
  wire [39:0] datain;
  wire cs_prev;
  wire cs_fall;
  wire sck_prev;
  wire sck_fall;
  wire sck_rise;
  wire sck;
  wire cs;
  wire rx;
  wire [5:0] bit_counter;
  wire [7:0] n_err;
  wire [7:0] n_over;
  wire [15:0] n_pos;
  wire new_pos;
  wire n44;
  wire n45;
  wire n46;
  wire n47;
  wire n48;
  wire n49;
  wire [15:0] n53;
  wire [15:0] n54;
  wire [7:0] n56;
  wire [7:0] n57;
  wire [7:0] n59;
  wire [15:0] n61;
  wire [5:0] n70;
  wire [38:0] n71;
  wire [39:0] n72;
  wire n74;
  wire [7:0] n75;
  wire n77;
  wire [15:0] n78;
  wire [31:0] n79;
  wire n81;
  wire n83;
  wire n85;
  wire n87;
  wire n90;
  localparam [23:0] n91 = 24'b000000000000000000000000;
  wire n93;
  localparam [25:0] n94 = 26'b00000000000000000000000000;
  wire n96;
  wire [7:0] n97;
  wire [5:0] n99;
  wire [5:0] n100;
  wire [5:0] n101;
  wire [5:0] n102;
  wire [5:0] n103;
  wire [5:0] n104;
  reg [5:0] n106;
  wire [1:0] n108;
  wire [1:0] n109;
  wire [1:0] n110;
  wire [1:0] n111;
  wire [1:0] n112;
  wire [1:0] n113;
  wire [1:0] n114;
  reg [1:0] n116;
  wire [17:0] n118;
  wire [17:0] n119;
  wire [17:0] n120;
  wire [17:0] n121;
  wire [17:0] n122;
  wire [17:0] n123;
  wire [17:0] n124;
  reg [17:0] n126;
  wire [5:0] n128;
  wire [5:0] n129;
  wire [5:0] n130;
  wire [5:0] n131;
  wire [5:0] n132;
  wire [5:0] n133;
  reg [5:0] n135;
  reg n137;
  wire n139;
  wire [7:0] n140;
  wire [31:0] n141;
  wire n143;
  wire [31:0] n144;
  wire n146;
  wire [25:0] n147;
  wire n149;
  wire [7:0] n150;
  wire n152;
  wire [5:0] n153;
  wire n155;
  wire n157;
  wire n159;
  wire [6:0] n160;
  reg [31:0] n161;
  reg [31:0] n162;
  reg [25:0] n163;
  reg n166;
  reg n169;
  reg [7:0] n170;
  reg [5:0] n171;
  wire [31:0] n172;
  wire [31:0] n173;
  wire [25:0] n174;
  wire n176;
  wire n178;
  wire [7:0] n179;
  wire [5:0] n180;
  wire [31:0] n181;
  wire [31:0] n182;
  wire [25:0] n183;
  wire n185;
  wire n187;
  wire [7:0] n188;
  wire [5:0] n189;
  wire [31:0] n190;
  wire [31:0] n191;
  wire n192;
  wire [30:0] n193;
  wire [31:0] n195;
  wire n196;
  wire n197;
  wire [31:0] n198;
  wire n199;
  wire [31:0] n200;
  wire [31:0] n201;
  wire [25:0] n202;
  wire n204;
  wire n206;
  wire [7:0] n207;
  wire [5:0] n208;
  wire [31:0] n209;
  wire [39:0] n210;
  wire [5:0] n211;
  wire n212;
  wire n214;
  wire [31:0] n215;
  wire [31:0] n216;
  wire [25:0] n217;
  wire n219;
  wire n221;
  wire [7:0] n222;
  wire [5:0] n223;
  wire [31:0] n224;
  wire [39:0] n225;
  wire [5:0] n227;
  wire n228;
  wire n230;
  wire [31:0] n232;
  wire [31:0] n234;
  wire [25:0] n236;
  wire n238;
  wire n241;
  wire [7:0] n244;
  wire [5:0] n246;
  wire [31:0] n248;
  wire [39:0] n249;
  wire [5:0] n250;
  wire [7:0] n252;
  wire n254;
  wire [7:0] n257;
  wire [7:0] n258;
  wire n259;
  wire n261;
  reg n279;
  reg [31:0] n280;
  reg [31:0] n281;
  reg [25:0] n282;
  reg n283;
  reg n284;
  reg [7:0] n285;
  reg [5:0] n286;
  reg [31:0] n287;
  reg [39:0] n288;
  reg n289;
  reg n290;
  reg [5:0] n291;
  reg [7:0] n292;
  reg [7:0] n293;
  reg [15:0] n294;
  reg n295;
  assign tx_o = n279; //(module output)
  assign ntrig_o = n280; //(module output)
  assign trig_period_o = n281; //(module output)
  assign width_o = n282; //(module output)
  assign pos_req_o = n283; //(module output)
  assign acq_start_o = n284; //(module output)
  assign bissc_half_clk_period_o = n285; //(module output)
  assign bissc_n_rising_edges_o = n286; //(module output)
  /*# build/top.vhdl:454:12 */
  assign dataout = n287; // (signal)
  /*# build/top.vhdl:455:12 */
  assign datain = n288; // (signal)
  /*# build/top.vhdl:456:12 */
  assign cs_prev = n289; // (signal)
  /*# build/top.vhdl:457:12 */
  assign cs_fall = n45; // (signal)
  /*# build/top.vhdl:458:12 */
  assign sck_prev = n290; // (signal)
  /*# build/top.vhdl:459:12 */
  assign sck_fall = n47; // (signal)
  /*# build/top.vhdl:460:12 */
  assign sck_rise = n49; // (signal)
  /*# build/top.vhdl:464:12 */
  assign bit_counter = n291; // (signal)
  /*# build/top.vhdl:465:12 */
  assign n_err = n292; // (signal)
  /*# build/top.vhdl:466:12 */
  assign n_over = n293; // (signal)
  /*# build/top.vhdl:467:12 */
  assign n_pos = n294; // (signal)
  /*# build/top.vhdl:468:12 */
  assign new_pos = n295; // (signal)
  /*# build/top.vhdl:470:5 */
  sync_bit_Brtl sync_sck_inst (
    .clk_i(clk_i),
    .bit_i(sck_i),
    .bit_o(sck));
  /*# build/top.vhdl:476:5 */
  sync_bit_Brtl sync_cs_inst (
    .clk_i(clk_i),
    .bit_i(cs_i),
    .bit_o(cs));
  /*# build/top.vhdl:482:5 */
  sync_bit_Brtl sync_rx_inst (
    .clk_i(clk_i),
    .bit_i(rx_i),
    .bit_o(rx));
  /*# build/top.vhdl:488:28 */
  assign n44 = ~cs;
  /*# build/top.vhdl:488:24 */
  assign n45 = cs_prev & n44;
  /*# build/top.vhdl:489:30 */
  assign n46 = ~sck;
  /*# build/top.vhdl:489:26 */
  assign n47 = sck_prev & n46;
  /*# build/top.vhdl:490:17 */
  assign n48 = ~sck_prev;
  /*# build/top.vhdl:490:30 */
  assign n49 = n48 & sck;
  /*# build/top.vhdl:500:36 */
  assign n53 = n_pos + 16'b0000000000000001;
  /*# build/top.vhdl:499:17 */
  assign n54 = pos_valid_i ? n53 : n_pos;
  /*# build/top.vhdl:503:36 */
  assign n56 = n_err + 8'b00000001;
  /*# build/top.vhdl:502:17 */
  assign n57 = error_event_i ? n56 : n_err;
  /*# build/top.vhdl:495:13 */
  assign n59 = rst_i ? 8'b00000000 : n57;
  /*# build/top.vhdl:495:13 */
  assign n61 = rst_i ? 16'b0000000000000000 : n54;
  /*# build/top.vhdl:529:44 */
  assign n70 = bit_counter + 6'b000001;
  /*# build/top.vhdl:530:38 */
  assign n71 = datain[38:0]; // extract
  /*# build/top.vhdl:530:52 */
  assign n72 = {n71, rx};
  /*# build/top.vhdl:532:32 */
  assign n74 = bit_counter == 6'b000111;
  /*# build/top.vhdl:533:37 */
  assign n75 = n72[7:0]; // extract
  /*# build/top.vhdl:534:25 */
  assign n77 = n75 == 8'b00000000;
  /*# build/top.vhdl:537:64 */
  assign n78 = {n_over, n_err};
  /*# build/top.vhdl:537:72 */
  assign n79 = {n78, n_pos};
  /*# build/top.vhdl:536:25 */
  assign n81 = n75 == 8'b00000001;
  /*# build/top.vhdl:538:25 */
  assign n83 = n75 == 8'b00000010;
  /*# build/top.vhdl:541:25 */
  assign n85 = n75 == 8'b00000011;
  /*# build/top.vhdl:543:25 */
  assign n87 = n75 == 8'b00000100;
  /*# build/top.vhdl:545:25 */
  assign n90 = n75 == 8'b00000101;
  /*# build/top.vhdl:548:25 */
  assign n93 = n75 == 8'b00000110;
  /*# build/top.vhdl:552:25 */
  assign n96 = n75 == 8'b00000111;
  /*# build/top.vhdl:533:21 */
  assign n97 = {n96, n93, n90, n87, n85, n83, n81, n77};
  /*# build/top.vhdl:537:72 */
  assign n99 = n79[5:0]; // extract
  /*# build/top.vhdl:432:8 */
  assign n100 = pos_i[5:0]; // extract
  /*# build/top.vhdl:444:9 */
  assign n101 = n281[5:0]; // extract
  /*# build/top.vhdl:443:9 */
  assign n102 = n280[5:0]; // extract
  /*# build/top.vhdl:445:9 */
  assign n103 = n282[5:0]; // extract
  /*# build/top.vhdl:448:9 */
  assign n104 = n285[5:0]; // extract
  /*# build/top.vhdl:533:21 */
  always @*
    case (n97)
      8'b10000000: n106 = n286;
      8'b01000000: n106 = n104;
      8'b00100000: n106 = n103;
      8'b00010000: n106 = n102;
      8'b00001000: n106 = n101;
      8'b00000100: n106 = n100;
      8'b00000010: n106 = n99;
      8'b00000001: n106 = 6'b000001;
      default: n106 = 6'b000000;
    endcase
  /*# build/top.vhdl:537:72 */
  assign n108 = n79[7:6]; // extract
  /*# build/top.vhdl:432:8 */
  assign n109 = pos_i[7:6]; // extract
  /*# build/top.vhdl:444:9 */
  assign n110 = n281[7:6]; // extract
  /*# build/top.vhdl:443:9 */
  assign n111 = n280[7:6]; // extract
  /*# build/top.vhdl:445:9 */
  assign n112 = n282[7:6]; // extract
  /*# build/top.vhdl:448:9 */
  assign n113 = n285[7:6]; // extract
  assign n114 = n94[1:0]; // extract
  /*# build/top.vhdl:533:21 */
  always @*
    case (n97)
      8'b10000000: n116 = n114;
      8'b01000000: n116 = n113;
      8'b00100000: n116 = n112;
      8'b00010000: n116 = n111;
      8'b00001000: n116 = n110;
      8'b00000100: n116 = n109;
      8'b00000010: n116 = n108;
      8'b00000001: n116 = 2'b00;
      default: n116 = 2'b00;
    endcase
  /*# build/top.vhdl:537:72 */
  assign n118 = n79[25:8]; // extract
  /*# build/top.vhdl:432:8 */
  assign n119 = pos_i[25:8]; // extract
  /*# build/top.vhdl:444:9 */
  assign n120 = n281[25:8]; // extract
  /*# build/top.vhdl:443:9 */
  assign n121 = n280[25:8]; // extract
  /*# build/top.vhdl:445:9 */
  assign n122 = n282[25:8]; // extract
  assign n123 = n91[17:0]; // extract
  assign n124 = n94[19:2]; // extract
  /*# build/top.vhdl:533:21 */
  always @*
    case (n97)
      8'b10000000: n126 = n124;
      8'b01000000: n126 = n123;
      8'b00100000: n126 = n122;
      8'b00010000: n126 = n121;
      8'b00001000: n126 = n120;
      8'b00000100: n126 = n119;
      8'b00000010: n126 = n118;
      8'b00000001: n126 = 18'b000000000000000000;
      default: n126 = 18'b000000000000000000;
    endcase
  /*# build/top.vhdl:537:72 */
  assign n128 = n79[31:26]; // extract
  /*# build/top.vhdl:432:8 */
  assign n129 = pos_i[31:26]; // extract
  /*# build/top.vhdl:444:9 */
  assign n130 = n281[31:26]; // extract
  /*# build/top.vhdl:443:9 */
  assign n131 = n280[31:26]; // extract
  assign n132 = n91[23:18]; // extract
  assign n133 = n94[25:20]; // extract
  /*# build/top.vhdl:533:21 */
  always @*
    case (n97)
      8'b10000000: n135 = n133;
      8'b01000000: n135 = n132;
      8'b00100000: n135 = 6'b000000;
      8'b00010000: n135 = n131;
      8'b00001000: n135 = n130;
      8'b00000100: n135 = n129;
      8'b00000010: n135 = n128;
      8'b00000001: n135 = 6'b100000;
      default: n135 = 6'b000000;
    endcase
  /*# build/top.vhdl:533:21 */
  always @*
    case (n97)
      8'b10000000: n137 = new_pos;
      8'b01000000: n137 = new_pos;
      8'b00100000: n137 = new_pos;
      8'b00010000: n137 = new_pos;
      8'b00001000: n137 = new_pos;
      8'b00000100: n137 = 1'b0;
      8'b00000010: n137 = new_pos;
      8'b00000001: n137 = new_pos;
      default: n137 = new_pos;
    endcase
  /*# build/top.vhdl:559:35 */
  assign n139 = bit_counter == 6'b100111;
  /*# build/top.vhdl:560:37 */
  assign n140 = n72[39:32]; // extract
  /*# build/top.vhdl:562:66 */
  assign n141 = n72[31:0]; // extract
  /*# build/top.vhdl:561:25 */
  assign n143 = n140 == 8'b10000011;
  /*# build/top.vhdl:564:60 */
  assign n144 = n72[31:0]; // extract
  /*# build/top.vhdl:563:25 */
  assign n146 = n140 == 8'b10000100;
  /*# build/top.vhdl:566:60 */
  assign n147 = n72[25:0]; // extract
  /*# build/top.vhdl:565:25 */
  assign n149 = n140 == 8'b10000101;
  /*# build/top.vhdl:568:76 */
  assign n150 = n72[7:0]; // extract
  /*# build/top.vhdl:567:25 */
  assign n152 = n140 == 8'b10000110;
  /*# build/top.vhdl:570:75 */
  assign n153 = n72[5:0]; // extract
  /*# build/top.vhdl:569:25 */
  assign n155 = n140 == 8'b10000111;
  /*# build/top.vhdl:571:25 */
  assign n157 = n140 == 8'b10001000;
  /*# build/top.vhdl:573:25 */
  assign n159 = n140 == 8'b10001001;
  /*# build/top.vhdl:560:21 */
  assign n160 = {n159, n157, n155, n152, n149, n146, n143};
  /*# build/top.vhdl:560:21 */
  always @*
    case (n160)
      7'b1000000: n161 = n280;
      7'b0100000: n161 = n280;
      7'b0010000: n161 = n280;
      7'b0001000: n161 = n280;
      7'b0000100: n161 = n280;
      7'b0000010: n161 = n144;
      7'b0000001: n161 = n280;
      default: n161 = n280;
    endcase
  /*# build/top.vhdl:560:21 */
  always @*
    case (n160)
      7'b1000000: n162 = n281;
      7'b0100000: n162 = n281;
      7'b0010000: n162 = n281;
      7'b0001000: n162 = n281;
      7'b0000100: n162 = n281;
      7'b0000010: n162 = n281;
      7'b0000001: n162 = n141;
      default: n162 = n281;
    endcase
  /*# build/top.vhdl:560:21 */
  always @*
    case (n160)
      7'b1000000: n163 = n282;
      7'b0100000: n163 = n282;
      7'b0010000: n163 = n282;
      7'b0001000: n163 = n282;
      7'b0000100: n163 = n147;
      7'b0000010: n163 = n282;
      7'b0000001: n163 = n282;
      default: n163 = n282;
    endcase
  /*# build/top.vhdl:560:21 */
  always @*
    case (n160)
      7'b1000000: n166 = 1'b0;
      7'b0100000: n166 = 1'b1;
      7'b0010000: n166 = 1'b0;
      7'b0001000: n166 = 1'b0;
      7'b0000100: n166 = 1'b0;
      7'b0000010: n166 = 1'b0;
      7'b0000001: n166 = 1'b0;
      default: n166 = 1'b0;
    endcase
  /*# build/top.vhdl:560:21 */
  always @*
    case (n160)
      7'b1000000: n169 = 1'b1;
      7'b0100000: n169 = 1'b0;
      7'b0010000: n169 = 1'b0;
      7'b0001000: n169 = 1'b0;
      7'b0000100: n169 = 1'b0;
      7'b0000010: n169 = 1'b0;
      7'b0000001: n169 = 1'b0;
      default: n169 = 1'b0;
    endcase
  /*# build/top.vhdl:560:21 */
  always @*
    case (n160)
      7'b1000000: n170 = n285;
      7'b0100000: n170 = n285;
      7'b0010000: n170 = n285;
      7'b0001000: n170 = n150;
      7'b0000100: n170 = n285;
      7'b0000010: n170 = n285;
      7'b0000001: n170 = n285;
      default: n170 = n285;
    endcase
  /*# build/top.vhdl:560:21 */
  always @*
    case (n160)
      7'b1000000: n171 = n286;
      7'b0100000: n171 = n286;
      7'b0010000: n171 = n153;
      7'b0001000: n171 = n286;
      7'b0000100: n171 = n286;
      7'b0000010: n171 = n286;
      7'b0000001: n171 = n286;
      default: n171 = n286;
    endcase
  /*# build/top.vhdl:559:17 */
  assign n172 = n139 ? n161 : n280;
  /*# build/top.vhdl:559:17 */
  assign n173 = n139 ? n162 : n281;
  /*# build/top.vhdl:559:17 */
  assign n174 = n139 ? n163 : n282;
  /*# build/top.vhdl:559:17 */
  assign n176 = n139 ? n166 : 1'b0;
  /*# build/top.vhdl:559:17 */
  assign n178 = n139 ? n169 : 1'b0;
  /*# build/top.vhdl:559:17 */
  assign n179 = n139 ? n170 : n285;
  /*# build/top.vhdl:559:17 */
  assign n180 = n139 ? n171 : n286;
  /*# build/top.vhdl:532:17 */
  assign n181 = n74 ? n280 : n172;
  /*# build/top.vhdl:532:17 */
  assign n182 = n74 ? n281 : n173;
  /*# build/top.vhdl:532:17 */
  assign n183 = n74 ? n282 : n174;
  /*# build/top.vhdl:532:17 */
  assign n185 = n74 ? 1'b0 : n176;
  /*# build/top.vhdl:532:17 */
  assign n187 = n74 ? 1'b0 : n178;
  /*# build/top.vhdl:532:17 */
  assign n188 = n74 ? n285 : n179;
  /*# build/top.vhdl:532:17 */
  assign n189 = n74 ? n286 : n180;
  /*# build/top.vhdl:532:17 */
  assign n190 = {n135, n126, n116, n106};
  /*# build/top.vhdl:532:17 */
  assign n191 = n74 ? n190 : dataout;
  /*# build/top.vhdl:528:13 */
  assign n192 = n212 ? n137 : new_pos;
  /*# build/top.vhdl:580:35 */
  assign n193 = dataout[30:0]; // extract
  /*# build/top.vhdl:580:49 */
  assign n195 = {n193, 1'b0};
  /*# build/top.vhdl:581:32 */
  assign n196 = dataout[31]; // extract
  /*# build/top.vhdl:579:13 */
  assign n197 = sck_fall ? n196 : n279;
  /*# build/top.vhdl:579:13 */
  assign n198 = sck_fall ? n195 : dataout;
  /*# build/top.vhdl:528:13 */
  assign n199 = sck_rise ? n279 : n197;
  /*# build/top.vhdl:528:13 */
  assign n200 = sck_rise ? n181 : n280;
  /*# build/top.vhdl:528:13 */
  assign n201 = sck_rise ? n182 : n281;
  /*# build/top.vhdl:528:13 */
  assign n202 = sck_rise ? n183 : n282;
  /*# build/top.vhdl:528:13 */
  assign n204 = sck_rise ? n185 : 1'b0;
  /*# build/top.vhdl:528:13 */
  assign n206 = sck_rise ? n187 : 1'b0;
  /*# build/top.vhdl:528:13 */
  assign n207 = sck_rise ? n188 : n285;
  /*# build/top.vhdl:528:13 */
  assign n208 = sck_rise ? n189 : n286;
  /*# build/top.vhdl:528:13 */
  assign n209 = sck_rise ? n191 : n198;
  /*# build/top.vhdl:528:13 */
  assign n210 = sck_rise ? n72 : datain;
  /*# build/top.vhdl:528:13 */
  assign n211 = sck_rise ? n70 : bit_counter;
  /*# build/top.vhdl:528:13 */
  assign n212 = n74 & sck_rise;
  /*# build/top.vhdl:526:13 */
  assign n214 = cs_fall ? n279 : n199;
  /*# build/top.vhdl:526:13 */
  assign n215 = cs_fall ? n280 : n200;
  /*# build/top.vhdl:526:13 */
  assign n216 = cs_fall ? n281 : n201;
  /*# build/top.vhdl:526:13 */
  assign n217 = cs_fall ? n282 : n202;
  /*# build/top.vhdl:526:13 */
  assign n219 = cs_fall ? 1'b0 : n204;
  /*# build/top.vhdl:526:13 */
  assign n221 = cs_fall ? 1'b0 : n206;
  /*# build/top.vhdl:526:13 */
  assign n222 = cs_fall ? n285 : n207;
  /*# build/top.vhdl:526:13 */
  assign n223 = cs_fall ? n286 : n208;
  /*# build/top.vhdl:526:13 */
  assign n224 = cs_fall ? dataout : n209;
  /*# build/top.vhdl:526:13 */
  assign n225 = cs_fall ? datain : n210;
  /*# build/top.vhdl:526:13 */
  assign n227 = cs_fall ? 6'b000000 : n211;
  /*# build/top.vhdl:526:13 */
  assign n228 = cs_fall ? new_pos : n192;
  /*# build/top.vhdl:517:13 */
  assign n230 = rst_i ? n279 : n214;
  /*# build/top.vhdl:517:13 */
  assign n232 = rst_i ? 32'b00000000000000000000000000000000 : n215;
  /*# build/top.vhdl:517:13 */
  assign n234 = rst_i ? 32'b00000000000000000000000000000000 : n216;
  /*# build/top.vhdl:517:13 */
  assign n236 = rst_i ? 26'b00000000000000000000000000 : n217;
  /*# build/top.vhdl:517:13 */
  assign n238 = rst_i ? 1'b0 : n219;
  /*# build/top.vhdl:517:13 */
  assign n241 = rst_i ? 1'b0 : n221;
  /*# build/top.vhdl:517:13 */
  assign n244 = rst_i ? 8'b00000000 : n222;
  /*# build/top.vhdl:517:13 */
  assign n246 = rst_i ? 6'b000000 : n223;
  /*# build/top.vhdl:517:13 */
  assign n248 = rst_i ? 32'b00000000000000000000000000000000 : n224;
  /*# build/top.vhdl:517:13 */
  assign n249 = rst_i ? datain : n225;
  /*# build/top.vhdl:517:13 */
  assign n250 = rst_i ? bit_counter : n227;
  /*# build/top.vhdl:517:13 */
  assign n252 = rst_i ? 8'b00000000 : n_over;
  /*# build/top.vhdl:517:13 */
  assign n254 = rst_i ? 1'b0 : n228;
  /*# build/top.vhdl:586:38 */
  assign n257 = n_over + 8'b00000001;
  /*# build/top.vhdl:583:13 */
  assign n258 = n259 ? n257 : n252;
  /*# build/top.vhdl:583:13 */
  assign n259 = new_pos & pos_valid_i;
  /*# build/top.vhdl:583:13 */
  assign n261 = pos_valid_i ? 1'b1 : n254;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n279 <= n230;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n280 <= n232;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n281 <= n234;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n282 <= n236;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n283 <= n238;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n284 <= n241;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n285 <= n244;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n286 <= n246;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n287 <= n248;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n288 <= n249;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n289 <= cs;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n290 <= sck;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n291 <= n250;
  /*# build/top.vhdl:494:9 */
  always @(posedge clk_i)
    n292 <= n59;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n293 <= n258;
  /*# build/top.vhdl:494:9 */
  always @(posedge clk_i)
    n294 <= n61;
  /*# build/top.vhdl:512:9 */
  always @(posedge clk_i)
    n295 <= n261;
endmodule

module tt_um_emiliopeju_lightscan
  (input  clk,
   input  [7:0] ui_in,
   output [7:0] uo_out,
   input  [7:0] uio_in,
   output [7:0] uio_out,
   output [7:0] uio_oe,
   input  ena,
   input  rst_n);
  wire [50:0] pos;
  wire pos_valid;
  wire pos_err;
  wire pos_req;
  wire rst;
  wire biss_data_sync;
  wire bissc_go;
  wire acq_start;
  wire trig;
  wire [31:0] trig_period;
  wire [31:0] ntrig;
  wire [25:0] width;
  wire [7:0] bissc_half_clk_period;
  wire [5:0] bissc_n_rising_edges;
  localparam [7:0] n3 = 8'b00000001;
  wire n4;
  wire n5;
  wire \reg_inst.tx_o ;
  wire n6;
  wire n7;
  wire n8;
  wire [31:0] n10;
  wire \pulsed_trigger_inst.busy_o ;
  wire \pulsed_trigger_inst.pulse_o ;
  wire n21;
  wire \deglitcher_inst.bit_o ;
  wire \bissc_inst.clk_o ;
  wire [7:0] n30;
  wire [7:0] n32;
  assign uo_out = n30; //(module output)
  assign uio_out = n32; //(module output)
  assign uio_oe = n3; //(module output)
  /*# build/top.vhdl:693:12 */
  assign rst = n4; // (signal)
  /*# build/top.vhdl:696:12 */
  assign bissc_go = n5; // (signal)
  /*# build/top.vhdl:706:12 */
  assign n4 = ~rst_n;
  /*# build/top.vhdl:707:25 */
  assign n5 = pos_req | trig;
  /*# build/top.vhdl:709:5 */
  spi_registers_Brtl reg_inst (
    .clk_i(clk),
    .rst_i(rst),
    .cs_i(n6),
    .sck_i(n7),
    .rx_i(n8),
    .pos_i(n10),
    .pos_valid_i(pos_valid),
    .error_event_i(pos_err),
    .tx_o(\reg_inst.tx_o ),
    .ntrig_o(ntrig),
    .trig_period_o(trig_period),
    .width_o(width),
    .pos_req_o(pos_req),
    .acq_start_o(acq_start),
    .bissc_half_clk_period_o(bissc_half_clk_period),
    .bissc_n_rising_edges_o(bissc_n_rising_edges));
  /*# build/top.vhdl:712:22 */
  assign n6 = ui_in[0]; // extract
  /*# build/top.vhdl:713:23 */
  assign n7 = ui_in[1]; // extract
  /*# build/top.vhdl:714:22 */
  assign n8 = ui_in[2]; // extract
  /*# build/top.vhdl:716:21 */
  assign n10 = pos[31:0]; // extract
  /*# build/top.vhdl:728:5 */
  pulsed_trigger_Brtl pulsed_trigger_inst (
    .clk_i(clk),
    .rst_i(rst),
    .go_i(acq_start),
    .trig_period_i(trig_period),
    .ntrig_i(ntrig),
    .width_i(width),
    .busy_o(\pulsed_trigger_inst.busy_o ),
    .trig_o(trig),
    .pulse_o(\pulsed_trigger_inst.pulse_o ));
  /*# build/top.vhdl:740:5 */
  sync_bit_Brtl sync_biss_data_inst (
    .clk_i(clk),
    .bit_i(n21),
    .bit_o(biss_data_sync));
  /*# build/top.vhdl:742:24 */
  assign n21 = uio_in[1]; // extract
  /*# build/top.vhdl:746:5 */
  deglitcher_Brtl_3 deglitcher_inst (
    .clk_i(clk),
    .bit_i(biss_data_sync),
    .bit_o());
  /*# build/top.vhdl:752:5 */
  bissc_Barch bissc_inst (
    .clk_i(clk),
    .rst_i(rst),
    .go_i(bissc_go),
    .half_clk_period_i(bissc_half_clk_period),
    .n_rising_edges_i(bissc_n_rising_edges),
    .data_i(biss_data_sync),
    .pos_o(pos),
    .valid_o(pos_valid),
    .err_o(pos_err),
    .clk_o(\bissc_inst.clk_o ));
  /*# build/top.vhdl:678:9 */
  assign n30 = {4'bZ, \reg_inst.tx_o , 1'bZ, \pulsed_trigger_inst.pulse_o , \pulsed_trigger_inst.busy_o };
  /*# build/top.vhdl:680:9 */
  assign n32 = {7'bZ, \bissc_inst.clk_o };
endmodule

