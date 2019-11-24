`define Xilinx_vivado
`define PEArraySize_DF  		4   //x by x
`define WRAAddrSpace_DF 		16 //2^x
`define CameraDataInSize_DF 	128
`define InBufferSize   			16      //2^x*AyInFIFOWidth
`define FiBufferSize   			16      //2^x*AyFiFIFOWidth
`define AyInFIFOWidth  			128
`define AyFiFIFOWidth  			512

`define WRAInAddrWidth          12
`define WRAOutDataWidth         `InBuOutDaWidth
                                
`define InBuOutDaWidth          `PEArraySize_DF*16*8  //512;same as WRAOutDataWidth
`define NumBuLine               32 //1<<`NumBuLineDW      
`define NumBuLineDW             5    
`define InBuInDaWidthMax 	    128   //2*2(outsize)*4(PEArraySize_DF)*8(Datasize)

`define ram_addr_width			4

`define InTrInDaWidth			128
`define InTrOutDaWidth			128

`define BtBuDaWidth             `InBuOutDaWidth
`define GtBuDaWidth             `PEArraySize_DF*`PEArraySize_DF*16*8 //2048
`define GtInDSPWidth            `PEArraySize_DF*16*8
`define DSPOutWidth			    11       
`define DSPOutWidthA	        `DSPOutWidth*`PEArraySize_DF*16  //704
`define ChAcOutWidth            11
`define ChAcOutWidthA           `ChAcOutWidth*16 //176
`define ChAcNOutWidth           11
`define ChAcNOutWidthA          `ChAcNOutWidth*16 //176

`define OuTrDaWidth             32

`define InstrMemDepth           8
`define InstrLength             64




 