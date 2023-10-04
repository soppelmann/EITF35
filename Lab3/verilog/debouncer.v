module debouncer(
    input clk,
    input button_in,  // "PB" is the glitchy, asynchronous to clk, active low push-button signal
    input  rst_n,
    output wire button_out  // 1 for one clock cycle when the push-button goes down (i.e. just pushed)
);

// First use two flip-flops to synchronize the PB signal the "clk" clock domain
reg PB_sync_0;  always @(posedge clk) PB_sync_0 <= button_in;  // invert PB to make PB_sync_0 active high
reg PB_sync_1;  always @(posedge clk) PB_sync_1 <= PB_sync_0;

// Next declare a 16-bits counter
reg [15:0] PB_cnt;
reg PB_state;

// When the push-button is pushed or released, we increment the counter
// The counter has to be maxed out before we decide that the push-button state has changed

wire PB_idle = (PB_state==PB_sync_1);
wire PB_cnt_max = &PB_cnt;	// true when all bits of PB_cnt are 1's

always @(posedge clk)
if(PB_idle)
    PB_cnt <= 0;  // nothing's going on
else
begin
    PB_cnt <= PB_cnt + 16'd1;  // something's going on, increment the counter
    if(PB_cnt_max) PB_state <= ~PB_state;  // if the counter is maxed out, PB changed!
end

assign button_out = ~PB_idle & PB_cnt_max & ~PB_state;

endmodule


