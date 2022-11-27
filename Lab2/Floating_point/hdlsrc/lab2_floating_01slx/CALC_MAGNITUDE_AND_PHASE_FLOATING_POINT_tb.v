// -------------------------------------------------------------
// 
// File Name: D:\Matlab_Projects\Labs\lab2_floating_01\hdlsrc\lab2_floating_01slx\CALC_MAGNITUDE_AND_PHASE_FLOATING_POINT_tb.v
// Created: 2022-11-27 06:19:49
// 
// Generated by MATLAB 9.12 and HDL Coder 3.20
// 
// 
// -- -------------------------------------------------------------
// -- Rate and Clocking Details
// -- -------------------------------------------------------------
// Model base rate: 1
// Target subsystem base rate: 1
// 
// 
// Clock Enable  Sample Time
// -- -------------------------------------------------------------
// ce_out        1
// -- -------------------------------------------------------------
// 
// 
// Output Signal                 Clock Enable  Sample Time
// -- -------------------------------------------------------------
// o_VALID                       ce_out        1
// o_MAGNITUDE                   ce_out        1
// o_PHASE                       ce_out        1
// -- -------------------------------------------------------------
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: CALC_MAGNITUDE_AND_PHASE_FLOATING_POINT_tb
// Source Path: 
// Hierarchy Level: 0
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module CALC_MAGNITUDE_AND_PHASE_FLOATING_POINT_tb;



  reg  clk;
  reg  reset;
  wire clk_enable;
  wire o_PHASE_done;  // ufix1
  wire rdEnb;
  wire o_PHASE_done_enb;  // ufix1
  reg [3:0] o_VALID_addr;  // ufix4
  wire o_PHASE_lastAddr;  // ufix1
  wire resetn;
  reg  check3_done;  // ufix1
  wire o_MAGNITUDE_done;  // ufix1
  wire o_MAGNITUDE_done_enb;  // ufix1
  wire o_MAGNITUDE_lastAddr;  // ufix1
  reg  check2_done;  // ufix1
  wire o_VALID_done;  // ufix1
  wire o_VALID_done_enb;  // ufix1
  wire o_VALID_active;  // ufix1
  wire [3:0] ComplexValFixed_addr_delay;  // ufix4
  reg  tb_enb_delay;
  reg signed [31:0] fp_i_COMPLEX_VALUE_im;  // sfix32
  reg [31:0] i_COMPLEX_VALUE_imraw;  // ufix32
  reg signed [31:0] status_i_COMPLEX_VALUE_im;  // sfix32
  wire [31:0] rawData_i_COMPLEX_VALUE_im;  // ufix32
  reg [31:0] holdData_i_COMPLEX_VALUE_im;  // ufix32
  reg [31:0] i_COMPLEX_VALUE_im_offset;  // ufix32
  reg [31:0] i_COMPLEX_VALUE_im;  // ufix32
  wire [31:0] i_COMPLEX_VALUE_im_1;  // ufix32
  reg [3:0] Constant_out1_addr;  // ufix4
  wire Constant_out1_active;  // ufix1
  wire Constant_out1_enb;  // ufix1
  reg signed [31:0] fp_i_COMPLEX_VALUE_re;  // sfix32
  reg [31:0] i_COMPLEX_VALUE_reraw;  // ufix32
  reg signed [31:0] status_i_COMPLEX_VALUE_re;  // sfix32
  wire [31:0] rawData_i_COMPLEX_VALUE_re;  // ufix32
  reg [31:0] holdData_i_COMPLEX_VALUE_re;  // ufix32
  reg [31:0] i_COMPLEX_VALUE_re_offset;  // ufix32
  reg [31:0] i_COMPLEX_VALUE_re;  // ufix32
  wire [31:0] i_COMPLEX_VALUE_re_1;  // ufix32
  wire rawData_i_VALID;
  reg  holdData_i_VALID;
  reg  i_VALID_offset;
  wire i_VALID;
  wire snkDone;
  wire snkDonen;
  wire tb_enb;
  wire ce_out;
  wire o_VALID;
  wire [31:0] o_MAGNITUDE;  // ufix32
  wire [31:0] o_PHASE;  // ufix32
  wire o_VALID_enb;  // ufix1
  wire o_VALID_lastAddr;  // ufix1
  reg  check1_done;  // ufix1
  reg [5:0] o_VALID_chkcnt;  // ufix6
  wire o_VALID_ignCntDone;  // ufix1
  wire o_VALID_needToCount;  // ufix1
  wire o_VALID_chkenb;  // ufix1
  wire o_VALID_chkdata;  // ufix1
  wire o_VALID_expected_1;
  wire o_VALID_ref;
  reg  o_VALID_testFailure;  // ufix1
  reg [5:0] o_MAGNITUDE_chkcnt;  // ufix6
  wire o_MAGNITUDE_ignCntDone;  // ufix1
  wire o_MAGNITUDE_needToCount;  // ufix1
  wire o_MAGNITUDE_chkenb;  // ufix1
  wire o_MAGNITUDE_chkdata;  // ufix1
  wire [31:0] o_MAGNITUDE_expected_1;  // ufix32
  wire [31:0] o_MAGNITUDE_ref;  // ufix32
  reg  o_MAGNITUDE_testFailure;  // ufix1
  reg [5:0] o_PHASE_chkcnt;  // ufix6
  wire o_PHASE_ignCntDone;  // ufix1
  wire o_PHASE_needToCount;  // ufix1
  wire o_PHASE_chkenb;  // ufix1
  wire o_PHASE_chkdata;  // ufix1
  wire [31:0] o_PHASE_expected_1;  // ufix32
  wire [31:0] o_PHASE_ref;  // ufix32
  reg  o_PHASE_testFailure;  // ufix1
  wire testFailure;  // ufix1

  function real absReal(input real num);
  begin
    if (num < 0)
      absReal = -num;
    else
      absReal = num;
  end
  endfunction

  function real floatHalfToReal;
  input [15:0] x;
  reg [63:0] conv;

  begin
    conv[63] = x[15]; // sign 
    if (x[14:10] == 5'b0) // exp 
      conv[62:52] = 11'b0; 
    else
      conv[62:52] = 1023 + (x[14:10] - 15);
    conv[51:42] = x[9:0]; // mantissa 
    conv[41:0] = 42'b0;
    if (((x[14:10] == 5'h1F) && (x[9:0] != 10'h0))) // check for NaN 
    begin
      conv[63] = 1'b0;
      conv[62:52] = 11'h7FF;
      conv[51:0] = 52'h0;
    end
    floatHalfToReal = $bitstoreal(conv);
  end
  endfunction

  function real floatSingleToReal;
  input [31:0] x;
  reg [63:0] conv;

  begin
    conv[63] = x[31]; // sign 
    if (x[30:23] == 8'b0) // exp 
      conv[62:52] = 11'b0; 
    else
      conv[62:52] = 1023 + (x[30:23] - 127);
    conv[51:29] = x[22:0]; // mantissa 
    conv[28:0] = 29'b0;
    if (((x[30:23] == 8'hFF) && (x[22:0] != 23'h0))) // check for NaN 
    begin
      conv[63] = 1'b0;
      conv[62:52] = 11'h7FF;
      conv[51:0] = 52'h0;
    end
    floatSingleToReal = $bitstoreal(conv);
  end
  endfunction

  function real floatDoubleToReal;
  input [63:0] x;
  reg [63:0] conv;

  begin
    conv[63:0] = x[63:0]; 
    if (((x[62:52] == 11'h7FF) && (x[51:0] != 52'h0))) // check for NaN 
    begin
      conv[63] = 1'b0;
      conv[62:52] = 11'h7FF;
      conv[51:0] = 52'h0;
    end
    floatDoubleToReal = $bitstoreal(conv);
  end
  endfunction

  function isFloatEpsEqual(input real a, input real b, input real eps);
  real absdiff;

  begin
    absdiff = absReal(a - b);
    if (absdiff < eps) // absolute error check 
      isFloatEpsEqual = 1;
    else if (a == b) // check infinities 
      isFloatEpsEqual = 1; 
    else if (a*b == 0.0) // either is zero 
      isFloatEpsEqual = (absdiff < eps);
    else if (absReal(a) < absReal(b)) // relative error check
      isFloatEpsEqual = absdiff/absReal(b) < eps;
    else
      isFloatEpsEqual = absdiff/absReal(a) < eps;
  end
  endfunction
  function isFloatHalfEpsEqual;
  input [15:0] x;
  input [15:0] y;
  input real eps;
  real a, b;
  real absdiff;

  begin
    a = floatHalfToReal(x);
    b = floatHalfToReal(y);
    isFloatHalfEpsEqual = isFloatEpsEqual(a, b, eps);
  end
  endfunction
  function isFloatSingleEpsEqual;
  input [31:0] x;
  input [31:0] y;
  input real eps;
  real a, b;
  real absdiff;

  begin
    a = floatSingleToReal(x);
    b = floatSingleToReal(y);
    isFloatSingleEpsEqual = isFloatEpsEqual(a, b, eps);
  end
  endfunction
  function isFloatDoubleEpsEqual;
  input [63:0] x;
  input [63:0] y;
  input real eps;
  real a, b;
  real absdiff;

  begin
    a = floatDoubleToReal(x);
    b = floatDoubleToReal(y);
    isFloatDoubleEpsEqual = isFloatEpsEqual(a, b, eps);
  end
  endfunction

  assign o_PHASE_done_enb = o_PHASE_done & rdEnb;



  assign o_PHASE_lastAddr = o_VALID_addr >= 4'b1010;



  assign o_PHASE_done = o_PHASE_lastAddr & resetn;



  // Delay to allow last sim cycle to complete
  always @(posedge clk or posedge reset)
    begin : checkDone_3
      if (reset) begin
        check3_done <= 0;
      end
      else begin
        if (o_PHASE_done_enb) begin
          check3_done <= o_PHASE_done;
        end
      end
    end

  assign o_MAGNITUDE_done_enb = o_MAGNITUDE_done & rdEnb;



  assign o_MAGNITUDE_lastAddr = o_VALID_addr >= 4'b1010;



  assign o_MAGNITUDE_done = o_MAGNITUDE_lastAddr & resetn;



  // Delay to allow last sim cycle to complete
  always @(posedge clk or posedge reset)
    begin : checkDone_2
      if (reset) begin
        check2_done <= 0;
      end
      else begin
        if (o_MAGNITUDE_done_enb) begin
          check2_done <= o_MAGNITUDE_done;
        end
      end
    end

  assign o_VALID_done_enb = o_VALID_done & rdEnb;



  assign o_VALID_active = o_VALID_addr != 4'b1010;



  // Data source for i_COMPLEX_VALUE_im
  initial
    begin : i_COMPLEX_VALUE_im_fileread
      fp_i_COMPLEX_VALUE_im = $fopen("i_COMPLEX_VALUE_im.dat", "r");
      status_i_COMPLEX_VALUE_im = $rewind(fp_i_COMPLEX_VALUE_im);
    end

  always @(ComplexValFixed_addr_delay, rdEnb, tb_enb_delay)
    begin
      if (tb_enb_delay == 0) begin
        i_COMPLEX_VALUE_imraw <= 0;
      end
      else if (rdEnb == 1) begin
        status_i_COMPLEX_VALUE_im = $fscanf(fp_i_COMPLEX_VALUE_im, "%h", i_COMPLEX_VALUE_imraw);
      end
    end

  assign rawData_i_COMPLEX_VALUE_im = (rdEnb == 1'b0 ? 32'h00000000 :
              i_COMPLEX_VALUE_imraw);



  // holdData reg for ComplexValFixed
  always @(posedge clk or posedge reset)
    begin : stimuli_ComplexValFixed
      if (reset) begin
        holdData_i_COMPLEX_VALUE_im <= 0;
      end
      else begin
        holdData_i_COMPLEX_VALUE_im <= rawData_i_COMPLEX_VALUE_im;
      end
    end

  always @(rawData_i_COMPLEX_VALUE_im or rdEnb or tb_enb_delay)
    begin : stimuli_ComplexValFixed_1
      if (tb_enb_delay == 1'b0) begin
        i_COMPLEX_VALUE_im_offset <= 32'b0;
      end
      else begin
        if (rdEnb == 1'b0) begin
          i_COMPLEX_VALUE_im_offset <= holdData_i_COMPLEX_VALUE_im;
        end
        else begin
          i_COMPLEX_VALUE_im_offset <= rawData_i_COMPLEX_VALUE_im;
        end
      end
    end

  always #2 i_COMPLEX_VALUE_im <= i_COMPLEX_VALUE_im_offset;

  assign i_COMPLEX_VALUE_im_1 = i_COMPLEX_VALUE_im;

  assign Constant_out1_active = Constant_out1_addr != 4'b1010;



  assign Constant_out1_enb = Constant_out1_active & (rdEnb & tb_enb_delay);



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 10
  always @(posedge clk or posedge reset)
    begin : Constant_process
      if (reset == 1'b1) begin
        Constant_out1_addr <= 4'b0000;
      end
      else begin
        if (Constant_out1_enb) begin
          if (Constant_out1_addr >= 4'b1010) begin
            Constant_out1_addr <= 4'b0000;
          end
          else begin
            Constant_out1_addr <= Constant_out1_addr + 4'b0001;
          end
        end
      end
    end



  assign #1 ComplexValFixed_addr_delay = Constant_out1_addr;

  // Data source for i_COMPLEX_VALUE_re
  initial
    begin : i_COMPLEX_VALUE_re_fileread
      fp_i_COMPLEX_VALUE_re = $fopen("i_COMPLEX_VALUE_re.dat", "r");
      status_i_COMPLEX_VALUE_re = $rewind(fp_i_COMPLEX_VALUE_re);
    end

  always @(ComplexValFixed_addr_delay, rdEnb, tb_enb_delay)
    begin
      if (tb_enb_delay == 0) begin
        i_COMPLEX_VALUE_reraw <= 0;
      end
      else if (rdEnb == 1) begin
        status_i_COMPLEX_VALUE_re = $fscanf(fp_i_COMPLEX_VALUE_re, "%h", i_COMPLEX_VALUE_reraw);
      end
    end

  assign rawData_i_COMPLEX_VALUE_re = (rdEnb == 1'b0 ? 32'h00000000 :
              i_COMPLEX_VALUE_reraw);



  // holdData reg for ComplexValFixed
  always @(posedge clk or posedge reset)
    begin : stimuli_ComplexValFixed_2
      if (reset) begin
        holdData_i_COMPLEX_VALUE_re <= 0;
      end
      else begin
        holdData_i_COMPLEX_VALUE_re <= rawData_i_COMPLEX_VALUE_re;
      end
    end

  always @(rawData_i_COMPLEX_VALUE_re or rdEnb or tb_enb_delay)
    begin : stimuli_ComplexValFixed_3
      if (tb_enb_delay == 1'b0) begin
        i_COMPLEX_VALUE_re_offset <= 32'b0;
      end
      else begin
        if (rdEnb == 1'b0) begin
          i_COMPLEX_VALUE_re_offset <= holdData_i_COMPLEX_VALUE_re;
        end
        else begin
          i_COMPLEX_VALUE_re_offset <= rawData_i_COMPLEX_VALUE_re;
        end
      end
    end

  always #2 i_COMPLEX_VALUE_re <= i_COMPLEX_VALUE_re_offset;

  assign i_COMPLEX_VALUE_re_1 = i_COMPLEX_VALUE_re;

  // Data source for i_VALID
  assign rawData_i_VALID = (rdEnb == 1'b0 ? 1'b0 :
              1'b1);



  // holdData reg for Constant_out1
  always @(posedge clk or posedge reset)
    begin : stimuli_Constant_out1
      if (reset) begin
        holdData_i_VALID <= 0;
      end
      else begin
        holdData_i_VALID <= rawData_i_VALID;
      end
    end

  always @(rawData_i_VALID or rdEnb or tb_enb_delay)
    begin : stimuli_Constant_out1_1
      if (tb_enb_delay == 1'b0) begin
        i_VALID_offset <= 1'b0;
      end
      else begin
        if (rdEnb == 1'b0) begin
          i_VALID_offset <= holdData_i_VALID;
        end
        else begin
          i_VALID_offset <= rawData_i_VALID;
        end
      end
    end

  assign #2 i_VALID = i_VALID_offset;

  assign snkDonen =  ~ snkDone;



  assign resetn =  ~ reset;



  assign tb_enb = resetn & snkDonen;



  // Delay inside enable generation: register depth 1
  always @(posedge clk or posedge reset)
    begin : u_enable_delay
      if (reset) begin
        tb_enb_delay <= 0;
      end
      else begin
        tb_enb_delay <= tb_enb;
      end
    end

  assign rdEnb = (snkDone == 1'b0 ? tb_enb_delay :
              1'b0);



  assign #2 clk_enable = rdEnb;

  initial
    begin : reset_gen
      reset <= 1'b1;
      # (20);
      @ (posedge clk)
      # (2);
      reset <= 1'b0;
    end

  always 
    begin : clk_gen
      clk <= 1'b1;
      # (5);
      clk <= 1'b0;
      # (5);
      if (snkDone == 1'b1) begin
        clk <= 1'b1;
        # (5);
        clk <= 1'b0;
        # (5);
        $stop;
      end
    end

  CALC_MAGNITUDE_AND_PHASE_FLOATING_POINT u_CALC_MAGNITUDE_AND_PHASE_FLOATING_POINT (.clk(clk),
                                                                                     .reset(reset),
                                                                                     .clk_enable(clk_enable),
                                                                                     .i_VALID(i_VALID),
                                                                                     .i_COMPLEX_VALUE_re(i_COMPLEX_VALUE_re_1),  // single
                                                                                     .i_COMPLEX_VALUE_im(i_COMPLEX_VALUE_im_1),  // single
                                                                                     .ce_out(ce_out),
                                                                                     .o_VALID(o_VALID),
                                                                                     .o_MAGNITUDE(o_MAGNITUDE),  // single
                                                                                     .o_PHASE(o_PHASE)  // single
                                                                                     );

  assign o_VALID_enb = ce_out & o_VALID_active;



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 10
  always @(posedge clk or posedge reset)
    begin : c_2_process
      if (reset == 1'b1) begin
        o_VALID_addr <= 4'b0000;
      end
      else begin
        if (o_VALID_enb) begin
          if (o_VALID_addr >= 4'b1010) begin
            o_VALID_addr <= 4'b0000;
          end
          else begin
            o_VALID_addr <= o_VALID_addr + 4'b0001;
          end
        end
      end
    end



  assign o_VALID_lastAddr = o_VALID_addr >= 4'b1010;



  assign o_VALID_done = o_VALID_lastAddr & resetn;



  // Delay to allow last sim cycle to complete
  always @(posedge clk or posedge reset)
    begin : checkDone_1
      if (reset) begin
        check1_done <= 0;
      end
      else begin
        if (o_VALID_done_enb) begin
          check1_done <= o_VALID_done;
        end
      end
    end

  assign snkDone = check3_done & (check1_done & check2_done);



  assign o_VALID_ignCntDone = o_VALID_chkcnt != 6'b101111;



  assign o_VALID_needToCount = ce_out & o_VALID_ignCntDone;



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 47
  always @(posedge clk or posedge reset)
    begin : o_VALID_IgnoreDataChecking_process
      if (reset == 1'b1) begin
        o_VALID_chkcnt <= 6'b000000;
      end
      else begin
        if (o_VALID_needToCount) begin
          if (o_VALID_chkcnt >= 6'b101111) begin
            o_VALID_chkcnt <= 6'b000000;
          end
          else begin
            o_VALID_chkcnt <= o_VALID_chkcnt + 6'b000001;
          end
        end
      end
    end



  assign o_VALID_chkenb = o_VALID_chkcnt == 6'b101111;



  assign o_VALID_chkdata = ce_out & o_VALID_chkenb;



  // Data source for o_VALID_expected
  assign o_VALID_expected_1 = 1'b0;



  assign o_VALID_ref = o_VALID_expected_1;

  always @(posedge clk or posedge reset)
    begin : o_VALID_checker
      if (reset == 1'b1) begin
        o_VALID_testFailure <= 1'b0;
      end
      else begin
        if (o_VALID_chkdata == 1'b1 && o_VALID !== o_VALID_ref) begin
          o_VALID_testFailure <= 1'b1;
          $display("ERROR in o_VALID at time %t : Expected '%h' Actual '%h'", $time, o_VALID_ref, o_VALID);
        end
      end
    end

  assign o_MAGNITUDE_ignCntDone = o_MAGNITUDE_chkcnt != 6'b101111;



  assign o_MAGNITUDE_needToCount = ce_out & o_MAGNITUDE_ignCntDone;



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 47
  always @(posedge clk or posedge reset)
    begin : o_MAGNITUDE_IgnoreDataChecking_process
      if (reset == 1'b1) begin
        o_MAGNITUDE_chkcnt <= 6'b000000;
      end
      else begin
        if (o_MAGNITUDE_needToCount) begin
          if (o_MAGNITUDE_chkcnt >= 6'b101111) begin
            o_MAGNITUDE_chkcnt <= 6'b000000;
          end
          else begin
            o_MAGNITUDE_chkcnt <= o_MAGNITUDE_chkcnt + 6'b000001;
          end
        end
      end
    end



  assign o_MAGNITUDE_chkenb = o_MAGNITUDE_chkcnt == 6'b101111;



  assign o_MAGNITUDE_chkdata = ce_out & o_MAGNITUDE_chkenb;



  // Data source for o_MAGNITUDE_expected
  assign o_MAGNITUDE_expected_1 = 32'h00000000;



  assign o_MAGNITUDE_ref = o_MAGNITUDE_expected_1;

  always @(posedge clk or posedge reset)
    begin : o_MAGNITUDE_checker
      if (reset == 1'b1) begin
        o_MAGNITUDE_testFailure <= 1'b0;
      end
      else begin
        if (o_MAGNITUDE_chkdata == 1'b1 && !isFloatSingleEpsEqual(o_MAGNITUDE, o_MAGNITUDE_ref, 9.9999999999999995e-08)) begin
          o_MAGNITUDE_testFailure <= 1'b1;
          $display("ERROR in o_MAGNITUDE at time %t : Expected '%h' Actual '%h'", $time, o_MAGNITUDE_ref, o_MAGNITUDE);
        end
      end
    end

  assign o_PHASE_ignCntDone = o_PHASE_chkcnt != 6'b101111;



  assign o_PHASE_needToCount = ce_out & o_PHASE_ignCntDone;



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 47
  always @(posedge clk or posedge reset)
    begin : o_PHASE_IgnoreDataChecking_process
      if (reset == 1'b1) begin
        o_PHASE_chkcnt <= 6'b000000;
      end
      else begin
        if (o_PHASE_needToCount) begin
          if (o_PHASE_chkcnt >= 6'b101111) begin
            o_PHASE_chkcnt <= 6'b000000;
          end
          else begin
            o_PHASE_chkcnt <= o_PHASE_chkcnt + 6'b000001;
          end
        end
      end
    end



  assign o_PHASE_chkenb = o_PHASE_chkcnt == 6'b101111;



  assign o_PHASE_chkdata = ce_out & o_PHASE_chkenb;



  // Data source for o_PHASE_expected
  assign o_PHASE_expected_1 = 32'h00000000;



  assign o_PHASE_ref = o_PHASE_expected_1;

  always @(posedge clk or posedge reset)
    begin : o_PHASE_checker
      if (reset == 1'b1) begin
        o_PHASE_testFailure <= 1'b0;
      end
      else begin
        if (o_PHASE_chkdata == 1'b1 && !isFloatSingleEpsEqual(o_PHASE, o_PHASE_ref, 9.9999999999999995e-08)) begin
          o_PHASE_testFailure <= 1'b1;
          $display("ERROR in o_PHASE at time %t : Expected '%h' Actual '%h'", $time, o_PHASE_ref, o_PHASE);
        end
      end
    end

  assign testFailure = o_PHASE_testFailure | (o_VALID_testFailure | o_MAGNITUDE_testFailure);



  always @(posedge clk)
    begin : completed_msg
      if (snkDone == 1'b1) begin
        if (testFailure == 1'b0) begin
          $display("**************TEST COMPLETED (PASSED)**************");
        end
        else begin
          $display("**************TEST COMPLETED (FAILED)**************");
        end
      end
    end

endmodule  // CALC_MAGNITUDE_AND_PHASE_FLOATING_POINT_tb

