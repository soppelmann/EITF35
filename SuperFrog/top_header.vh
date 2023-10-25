
    // HEDGEHOG
    localparam H_CORDW = 16;  // signed coordinate width (bits)

        // screen dimensions (must match display_inst)
    localparam H_RES = 640;

    // colour parameters
    localparam H_CHANW = 4;         // colour channel width (bits)
    localparam H_COLRW = 3*H_CHANW;   // colour width: three channels (bits)
    localparam H_CIDXW = 4;         // colour index width (bits)
    localparam H_TRANS_INDX = 'h9;  // transparant colour index
    localparam H_PAL_FILE = "hedgehog_4b.mem";  // palette file

    // sprite parameters
    localparam H_SX_OFFS    =  3;  // horizontal screen offset (pixels): +1 for CLUT
    localparam H_SPR_WIDTH  = 32 ;  // bitmap width in pixels
    localparam H_SPR_HEIGHT = 20;  // bitmap height in pixels
    localparam H_SPR_SCALE  =  1;  // 2^2 = 4x scale
    localparam H_SPR_DRAWW  = H_SPR_WIDTH * 2**H_SPR_SCALE;  // draw width
    localparam H_SPR_SPX    =  2;  // horizontal speed (pixels/frame)
    localparam H_SPR_FILE   = "hedgehog.mem";  // bitmap file
    
    
    
    
    // Meteors
    localparam F_CORDW = 16;  // signed coordinate width (bits)

    // screen dimensions (must match display_inst)
    localparam F_H_RES = 640;

    // colour parameters
    localparam F_CHANW = 4;         // colour channel width (bits)
    localparam F_COLRW = 3*F_CHANW;   // colour width: three channels (bits)
    localparam F_CIDXW = 4;         // colour index width (bits)
    localparam F_TRANS_INDX = 'h9;  // transparant colour index
    localparam F_PAL_FILE = "meteor_palette.mem";  // palette file

    // sprite parameters
    localparam F_SX_OFFS    =  3;  // horizontal screen offset (pixels): +1 for CLUT
    localparam F_SPR_WIDTH  = 32;  // bitmap width in pixels
    localparam F_SPR_HEIGHT = 32;  // bitmap height in pixels
    localparam F_SPR_SCALE  =  2;  // 2^2 = 4x scale
    localparam F_SPR_DRAWW  = F_SPR_WIDTH * 2**F_SPR_SCALE;  // draw width
    localparam F_SPR_SPX    =  2;  // horizontal speed (pixels/frame)
    localparam F_SPR_FILE   = "meteor.mem";  // bitmap file

    // FROG
    
    
    // screen dimensions (must match display_inst)
    //localparam H_RES = 640;
    localparam CORDW = 16;  // signed coordinate width (bits)
    // colour parameters
    localparam CHANW = 4;         // colour channel width (bits)
    localparam COLRW = 3*CHANW;   // colour width: three channels (bits)
    localparam CIDXW = 4;         // colour index width (bits)
    localparam TRANS_INDX = 'hB;  // transparant colour index
    localparam PAL_FILE = "superfrog_palette.mem";  // palette file
    
    // sprite parameters
    localparam SX_OFFS    =  3;  // horizontal screen offset (pixels): +1 for CLUT
    localparam SPR_WIDTH  = 40;  // bitmap width in pixels
    localparam SPR_HEIGHT = 40;  // bitmap height in pixels
    localparam SPR_SCALE  =  1;  // 2^2 = 4x scale
    localparam SPR_DRAWW  = SPR_WIDTH * 2**SPR_SCALE;  // draw width
    localparam SPR_SPX    =  4;  // horizontal speed (pixels/frame)
    localparam SPR_FILE   = "superfrog.mem";  // bitmap file