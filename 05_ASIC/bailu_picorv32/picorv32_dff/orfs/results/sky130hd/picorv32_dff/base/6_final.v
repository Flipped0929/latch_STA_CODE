module picorv32 (clk,
    mem_instr,
    mem_la_read,
    mem_la_write,
    mem_ready,
    mem_valid,
    pcpi_ready,
    pcpi_valid,
    pcpi_wait,
    pcpi_wr,
    resetn,
    trace_valid,
    trap,
    eoi,
    irq,
    mem_addr,
    mem_la_addr,
    mem_la_wdata,
    mem_la_wstrb,
    mem_rdata,
    mem_wdata,
    mem_wstrb,
    pcpi_insn,
    pcpi_rd,
    pcpi_rs1,
    pcpi_rs2,
    trace_data);
 input clk;
 output mem_instr;
 output mem_la_read;
 output mem_la_write;
 input mem_ready;
 output mem_valid;
 input pcpi_ready;
 output pcpi_valid;
 input pcpi_wait;
 input pcpi_wr;
 input resetn;
 output trace_valid;
 output trap;
 output [31:0] eoi;
 input [31:0] irq;
 output [31:0] mem_addr;
 output [31:0] mem_la_addr;
 output [31:0] mem_la_wdata;
 output [3:0] mem_la_wstrb;
 input [31:0] mem_rdata;
 output [31:0] mem_wdata;
 output [3:0] mem_wstrb;
 output [31:0] pcpi_insn;
 input [31:0] pcpi_rd;
 output [31:0] pcpi_rs1;
 output [31:0] pcpi_rs2;
 output [35:0] trace_data;

 wire _0000_;
 wire _0001_;
 wire _0002_;
 wire _0003_;
 wire _0004_;
 wire _0005_;
 wire _0006_;
 wire _0007_;
 wire _0008_;
 wire _0009_;
 wire _0010_;
 wire _0011_;
 wire _0012_;
 wire _0013_;
 wire _0014_;
 wire _0015_;
 wire _0016_;
 wire _0017_;
 wire _0018_;
 wire _0019_;
 wire _0020_;
 wire _0021_;
 wire _0022_;
 wire _0023_;
 wire _0024_;
 wire _0025_;
 wire _0026_;
 wire _0027_;
 wire _0028_;
 wire _0029_;
 wire _0030_;
 wire _0031_;
 wire _0032_;
 wire _0033_;
 wire _0034_;
 wire _0035_;
 wire _0036_;
 wire _0037_;
 wire _0038_;
 wire _0039_;
 wire _0040_;
 wire _0041_;
 wire _0042_;
 wire _0043_;
 wire _0044_;
 wire _0045_;
 wire _0046_;
 wire _0047_;
 wire _0048_;
 wire _0049_;
 wire _0050_;
 wire _0051_;
 wire _0052_;
 wire _0053_;
 wire _0054_;
 wire _0055_;
 wire _0056_;
 wire _0057_;
 wire _0058_;
 wire _0059_;
 wire _0060_;
 wire _0061_;
 wire _0062_;
 wire _0063_;
 wire _0064_;
 wire _0065_;
 wire _0066_;
 wire _0067_;
 wire _0068_;
 wire _0069_;
 wire _0070_;
 wire _0071_;
 wire _0072_;
 wire _0073_;
 wire _0074_;
 wire _0075_;
 wire _0076_;
 wire _0077_;
 wire _0078_;
 wire _0079_;
 wire _0080_;
 wire _0081_;
 wire _0082_;
 wire _0083_;
 wire _0084_;
 wire _0085_;
 wire _0086_;
 wire _0087_;
 wire _0088_;
 wire _0089_;
 wire _0090_;
 wire _0091_;
 wire _0092_;
 wire _0093_;
 wire _0094_;
 wire _0095_;
 wire _0096_;
 wire _0097_;
 wire _0098_;
 wire _0099_;
 wire _0100_;
 wire _0101_;
 wire _0102_;
 wire _0103_;
 wire _0104_;
 wire _0105_;
 wire _0106_;
 wire _0107_;
 wire _0108_;
 wire _0109_;
 wire _0110_;
 wire _0111_;
 wire _0112_;
 wire _0113_;
 wire _0114_;
 wire _0115_;
 wire _0116_;
 wire _0117_;
 wire _0118_;
 wire _0119_;
 wire _0120_;
 wire _0121_;
 wire _0122_;
 wire _0123_;
 wire _0124_;
 wire _0125_;
 wire _0126_;
 wire _0127_;
 wire _0128_;
 wire _0129_;
 wire _0130_;
 wire _0131_;
 wire _0132_;
 wire _0133_;
 wire _0134_;
 wire _0135_;
 wire _0136_;
 wire _0137_;
 wire _0138_;
 wire _0139_;
 wire _0140_;
 wire _0141_;
 wire _0142_;
 wire _0143_;
 wire _0144_;
 wire _0145_;
 wire _0146_;
 wire _0147_;
 wire _0148_;
 wire _0149_;
 wire _0150_;
 wire _0151_;
 wire _0152_;
 wire _0153_;
 wire _0154_;
 wire _0155_;
 wire _0156_;
 wire _0157_;
 wire _0158_;
 wire _0159_;
 wire _0160_;
 wire _0161_;
 wire _0162_;
 wire _0163_;
 wire _0164_;
 wire _0165_;
 wire _0166_;
 wire _0167_;
 wire _0168_;
 wire _0169_;
 wire _0170_;
 wire _0171_;
 wire _0172_;
 wire _0173_;
 wire _0174_;
 wire _0175_;
 wire _0176_;
 wire _0177_;
 wire _0178_;
 wire _0179_;
 wire _0180_;
 wire _0181_;
 wire _0182_;
 wire _0183_;
 wire _0184_;
 wire _0185_;
 wire _0186_;
 wire _0187_;
 wire _0188_;
 wire _0189_;
 wire _0190_;
 wire _0191_;
 wire _0192_;
 wire _0193_;
 wire _0194_;
 wire _0195_;
 wire _0196_;
 wire _0197_;
 wire _0198_;
 wire _0199_;
 wire _0200_;
 wire _0201_;
 wire _0202_;
 wire _0203_;
 wire _0204_;
 wire _0205_;
 wire _0206_;
 wire _0207_;
 wire _0208_;
 wire _0209_;
 wire _0210_;
 wire _0211_;
 wire _0212_;
 wire _0213_;
 wire _0214_;
 wire _0215_;
 wire _0216_;
 wire _0217_;
 wire _0218_;
 wire _0219_;
 wire _0220_;
 wire _0221_;
 wire _0222_;
 wire _0223_;
 wire _0224_;
 wire _0225_;
 wire _0226_;
 wire _0227_;
 wire _0228_;
 wire _0229_;
 wire _0230_;
 wire _0231_;
 wire _0232_;
 wire _0233_;
 wire _0234_;
 wire _0235_;
 wire _0236_;
 wire _0237_;
 wire _0238_;
 wire _0239_;
 wire _0240_;
 wire _0241_;
 wire _0242_;
 wire _0243_;
 wire _0244_;
 wire _0245_;
 wire _0246_;
 wire _0247_;
 wire _0248_;
 wire _0249_;
 wire _0250_;
 wire _0251_;
 wire _0252_;
 wire _0253_;
 wire _0254_;
 wire _0255_;
 wire _0256_;
 wire _0257_;
 wire _0258_;
 wire _0259_;
 wire _0260_;
 wire _0261_;
 wire _0262_;
 wire _0263_;
 wire _0264_;
 wire _0265_;
 wire _0266_;
 wire _0267_;
 wire _0268_;
 wire _0269_;
 wire _0270_;
 wire _0271_;
 wire _0272_;
 wire _0273_;
 wire _0274_;
 wire _0275_;
 wire _0276_;
 wire _0277_;
 wire _0278_;
 wire _0279_;
 wire _0280_;
 wire _0281_;
 wire _0282_;
 wire _0283_;
 wire _0284_;
 wire _0285_;
 wire _0286_;
 wire _0287_;
 wire _0288_;
 wire _0289_;
 wire _0290_;
 wire _0291_;
 wire _0292_;
 wire _0293_;
 wire _0294_;
 wire _0295_;
 wire _0296_;
 wire _0297_;
 wire _0298_;
 wire _0299_;
 wire _0300_;
 wire _0301_;
 wire _0302_;
 wire _0303_;
 wire _0304_;
 wire _0305_;
 wire _0306_;
 wire _0307_;
 wire _0308_;
 wire _0309_;
 wire _0310_;
 wire _0311_;
 wire _0312_;
 wire _0313_;
 wire _0314_;
 wire _0315_;
 wire _0316_;
 wire _0317_;
 wire _0318_;
 wire _0319_;
 wire _0320_;
 wire _0321_;
 wire _0322_;
 wire _0323_;
 wire _0324_;
 wire _0325_;
 wire _0326_;
 wire _0327_;
 wire _0328_;
 wire _0329_;
 wire _0330_;
 wire _0331_;
 wire _0332_;
 wire _0333_;
 wire _0334_;
 wire _0335_;
 wire _0336_;
 wire _0337_;
 wire _0338_;
 wire _0339_;
 wire _0340_;
 wire _0341_;
 wire _0342_;
 wire _0343_;
 wire _0344_;
 wire _0345_;
 wire _0346_;
 wire _0347_;
 wire _0348_;
 wire _0349_;
 wire _0350_;
 wire _0351_;
 wire _0352_;
 wire _0353_;
 wire _0354_;
 wire _0355_;
 wire _0356_;
 wire _0357_;
 wire _0358_;
 wire _0359_;
 wire _0360_;
 wire _0361_;
 wire _0362_;
 wire _0363_;
 wire _0364_;
 wire _0365_;
 wire _0366_;
 wire _0367_;
 wire _0368_;
 wire _0369_;
 wire _0370_;
 wire _0371_;
 wire _0372_;
 wire _0373_;
 wire _0374_;
 wire _0375_;
 wire _0376_;
 wire _0377_;
 wire _0378_;
 wire _0379_;
 wire _0380_;
 wire _0381_;
 wire _0382_;
 wire _0383_;
 wire _0384_;
 wire _0385_;
 wire _0386_;
 wire _0387_;
 wire _0388_;
 wire _0389_;
 wire _0390_;
 wire _0391_;
 wire _0392_;
 wire _0393_;
 wire _0394_;
 wire _0395_;
 wire _0396_;
 wire _0397_;
 wire _0398_;
 wire _0399_;
 wire _0400_;
 wire _0401_;
 wire _0402_;
 wire _0403_;
 wire _0404_;
 wire _0405_;
 wire _0406_;
 wire _0407_;
 wire _0408_;
 wire _0409_;
 wire _0410_;
 wire _0411_;
 wire _0412_;
 wire _0413_;
 wire _0414_;
 wire _0415_;
 wire _0416_;
 wire _0417_;
 wire _0418_;
 wire _0419_;
 wire _0420_;
 wire _0421_;
 wire _0422_;
 wire _0423_;
 wire _0424_;
 wire _0425_;
 wire _0426_;
 wire _0427_;
 wire _0428_;
 wire _0429_;
 wire _0430_;
 wire _0431_;
 wire _0432_;
 wire _0433_;
 wire _0434_;
 wire _0435_;
 wire _0436_;
 wire _0437_;
 wire _0438_;
 wire _0439_;
 wire _0440_;
 wire _0441_;
 wire _0442_;
 wire _0443_;
 wire _0444_;
 wire _0445_;
 wire _0446_;
 wire _0447_;
 wire _0448_;
 wire _0449_;
 wire _0450_;
 wire _0451_;
 wire _0452_;
 wire _0453_;
 wire _0454_;
 wire _0455_;
 wire _0456_;
 wire _0457_;
 wire _0458_;
 wire _0459_;
 wire _0460_;
 wire _0461_;
 wire _0462_;
 wire _0463_;
 wire _0464_;
 wire _0465_;
 wire _0466_;
 wire _0467_;
 wire _0468_;
 wire _0469_;
 wire _0470_;
 wire _0471_;
 wire _0472_;
 wire _0473_;
 wire _0474_;
 wire _0475_;
 wire _0476_;
 wire _0477_;
 wire _0478_;
 wire _0479_;
 wire _0480_;
 wire _0481_;
 wire _0482_;
 wire _0483_;
 wire _0484_;
 wire _0485_;
 wire _0486_;
 wire _0487_;
 wire _0488_;
 wire _0489_;
 wire _0490_;
 wire _0491_;
 wire _0492_;
 wire _0493_;
 wire _0494_;
 wire _0495_;
 wire _0496_;
 wire _0497_;
 wire _0498_;
 wire _0499_;
 wire _0500_;
 wire _0501_;
 wire _0502_;
 wire _0503_;
 wire _0504_;
 wire _0505_;
 wire _0506_;
 wire _0507_;
 wire _0508_;
 wire _0509_;
 wire _0510_;
 wire _0511_;
 wire _0512_;
 wire _0513_;
 wire _0514_;
 wire _0515_;
 wire _0516_;
 wire _0517_;
 wire _0518_;
 wire _0519_;
 wire _0520_;
 wire _0521_;
 wire _0522_;
 wire _0523_;
 wire _0524_;
 wire _0525_;
 wire _0526_;
 wire _0527_;
 wire _0528_;
 wire _0529_;
 wire _0530_;
 wire _0531_;
 wire _0532_;
 wire _0533_;
 wire _0534_;
 wire _0535_;
 wire _0536_;
 wire _0537_;
 wire _0538_;
 wire _0539_;
 wire _0540_;
 wire _0541_;
 wire _0542_;
 wire _0543_;
 wire _0544_;
 wire _0545_;
 wire _0546_;
 wire _0547_;
 wire _0548_;
 wire _0549_;
 wire _0550_;
 wire _0551_;
 wire _0552_;
 wire _0553_;
 wire _0554_;
 wire _0555_;
 wire _0556_;
 wire _0557_;
 wire _0558_;
 wire _0559_;
 wire _0560_;
 wire _0561_;
 wire _0562_;
 wire _0563_;
 wire _0564_;
 wire _0565_;
 wire _0566_;
 wire _0567_;
 wire _0568_;
 wire _0569_;
 wire _0570_;
 wire _0571_;
 wire _0572_;
 wire _0573_;
 wire _0574_;
 wire _0575_;
 wire _0576_;
 wire _0577_;
 wire _0578_;
 wire _0579_;
 wire _0580_;
 wire _0581_;
 wire _0582_;
 wire _0583_;
 wire _0584_;
 wire _0585_;
 wire _0586_;
 wire _0587_;
 wire _0588_;
 wire _0589_;
 wire _0590_;
 wire _0591_;
 wire _0592_;
 wire _0593_;
 wire _0594_;
 wire _0595_;
 wire _0596_;
 wire _0597_;
 wire _0598_;
 wire _0599_;
 wire _0600_;
 wire _0601_;
 wire _0602_;
 wire _0603_;
 wire _0604_;
 wire _0605_;
 wire _0606_;
 wire _0607_;
 wire _0608_;
 wire _0609_;
 wire _0610_;
 wire _0611_;
 wire _0612_;
 wire _0613_;
 wire _0614_;
 wire _0615_;
 wire _0616_;
 wire _0617_;
 wire _0618_;
 wire _0619_;
 wire _0620_;
 wire _0621_;
 wire _0622_;
 wire _0623_;
 wire _0624_;
 wire _0625_;
 wire _0626_;
 wire _0627_;
 wire _0628_;
 wire _0629_;
 wire _0630_;
 wire _0631_;
 wire _0632_;
 wire _0633_;
 wire _0634_;
 wire _0635_;
 wire _0636_;
 wire _0637_;
 wire _0638_;
 wire _0639_;
 wire _0640_;
 wire _0641_;
 wire _0642_;
 wire _0643_;
 wire _0644_;
 wire _0645_;
 wire _0646_;
 wire _0647_;
 wire _0648_;
 wire _0649_;
 wire _0650_;
 wire _0651_;
 wire _0652_;
 wire _0653_;
 wire _0654_;
 wire _0655_;
 wire _0656_;
 wire _0657_;
 wire _0658_;
 wire _0659_;
 wire _0660_;
 wire _0661_;
 wire _0662_;
 wire _0663_;
 wire _0664_;
 wire _0665_;
 wire _0666_;
 wire _0667_;
 wire _0668_;
 wire _0669_;
 wire _0670_;
 wire _0671_;
 wire _0672_;
 wire _0673_;
 wire _0674_;
 wire _0675_;
 wire _0676_;
 wire _0677_;
 wire _0678_;
 wire _0679_;
 wire _0680_;
 wire _0681_;
 wire _0682_;
 wire _0683_;
 wire _0684_;
 wire _0685_;
 wire _0686_;
 wire _0687_;
 wire _0688_;
 wire _0689_;
 wire _0690_;
 wire _0691_;
 wire _0692_;
 wire _0693_;
 wire _0694_;
 wire _0695_;
 wire _0696_;
 wire _0697_;
 wire _0698_;
 wire _0699_;
 wire _0700_;
 wire _0701_;
 wire _0702_;
 wire _0703_;
 wire _0704_;
 wire _0705_;
 wire _0706_;
 wire _0707_;
 wire _0708_;
 wire _0709_;
 wire _0710_;
 wire _0711_;
 wire _0712_;
 wire _0713_;
 wire _0714_;
 wire _0715_;
 wire _0716_;
 wire _0717_;
 wire _0718_;
 wire _0719_;
 wire _0720_;
 wire _0721_;
 wire _0722_;
 wire _0723_;
 wire _0724_;
 wire _0725_;
 wire _0726_;
 wire _0727_;
 wire _0728_;
 wire _0729_;
 wire _0730_;
 wire _0731_;
 wire _0732_;
 wire _0733_;
 wire _0734_;
 wire _0735_;
 wire _0736_;
 wire _0737_;
 wire _0738_;
 wire _0739_;
 wire _0740_;
 wire _0741_;
 wire _0742_;
 wire _0743_;
 wire _0744_;
 wire _0745_;
 wire _0746_;
 wire _0747_;
 wire _0748_;
 wire _0749_;
 wire _0750_;
 wire _0751_;
 wire _0752_;
 wire _0753_;
 wire _0754_;
 wire _0755_;
 wire _0756_;
 wire _0757_;
 wire _0758_;
 wire _0759_;
 wire _0760_;
 wire _0761_;
 wire _0762_;
 wire _0763_;
 wire _0764_;
 wire _0765_;
 wire _0766_;
 wire _0767_;
 wire _0768_;
 wire _0769_;
 wire _0770_;
 wire _0771_;
 wire _0772_;
 wire _0773_;
 wire _0774_;
 wire _0775_;
 wire _0776_;
 wire _0777_;
 wire _0778_;
 wire _0779_;
 wire _0780_;
 wire _0781_;
 wire _0782_;
 wire _0783_;
 wire _0784_;
 wire _0785_;
 wire _0786_;
 wire _0787_;
 wire _0788_;
 wire _0789_;
 wire _0790_;
 wire _0791_;
 wire _0792_;
 wire _0793_;
 wire _0794_;
 wire _0795_;
 wire _0796_;
 wire _0797_;
 wire _0798_;
 wire _0799_;
 wire _0800_;
 wire _0801_;
 wire _0802_;
 wire _0803_;
 wire _0804_;
 wire _0805_;
 wire _0806_;
 wire _0807_;
 wire _0808_;
 wire _0809_;
 wire _0810_;
 wire _0811_;
 wire _0812_;
 wire _0813_;
 wire _0814_;
 wire _0815_;
 wire _0816_;
 wire _0817_;
 wire _0818_;
 wire _0819_;
 wire _0820_;
 wire _0821_;
 wire _0822_;
 wire _0823_;
 wire _0824_;
 wire _0825_;
 wire _0826_;
 wire _0827_;
 wire _0828_;
 wire _0829_;
 wire _0830_;
 wire _0831_;
 wire _0832_;
 wire _0833_;
 wire _0834_;
 wire _0835_;
 wire _0836_;
 wire _0837_;
 wire _0838_;
 wire _0839_;
 wire _0840_;
 wire _0841_;
 wire _0842_;
 wire _0843_;
 wire _0844_;
 wire _0845_;
 wire _0846_;
 wire _0847_;
 wire _0848_;
 wire clknet_leaf_92_clk;
 wire _0850_;
 wire clknet_leaf_91_clk;
 wire clknet_leaf_90_clk;
 wire clknet_leaf_89_clk;
 wire _0854_;
 wire _0855_;
 wire clknet_leaf_88_clk;
 wire _0857_;
 wire _0858_;
 wire _0859_;
 wire _0860_;
 wire _0861_;
 wire clknet_leaf_87_clk;
 wire _0863_;
 wire clknet_leaf_86_clk;
 wire clknet_leaf_85_clk;
 wire clknet_leaf_84_clk;
 wire clknet_leaf_83_clk;
 wire clknet_leaf_82_clk;
 wire clknet_leaf_81_clk;
 wire clknet_leaf_80_clk;
 wire _0871_;
 wire _0872_;
 wire _0873_;
 wire _0874_;
 wire clknet_leaf_79_clk;
 wire clknet_leaf_78_clk;
 wire clknet_leaf_77_clk;
 wire _0878_;
 wire clknet_leaf_76_clk;
 wire clknet_leaf_75_clk;
 wire _0881_;
 wire _0882_;
 wire _0883_;
 wire _0884_;
 wire _0885_;
 wire _0886_;
 wire _0887_;
 wire _0888_;
 wire _0889_;
 wire _0890_;
 wire _0891_;
 wire _0892_;
 wire _0893_;
 wire _0894_;
 wire _0895_;
 wire _0896_;
 wire _0897_;
 wire _0898_;
 wire _0899_;
 wire _0900_;
 wire _0901_;
 wire _0902_;
 wire _0903_;
 wire _0904_;
 wire _0905_;
 wire _0906_;
 wire _0907_;
 wire _0908_;
 wire _0909_;
 wire _0910_;
 wire _0911_;
 wire _0912_;
 wire _0913_;
 wire _0914_;
 wire _0915_;
 wire _0916_;
 wire _0917_;
 wire _0918_;
 wire _0919_;
 wire _0920_;
 wire _0921_;
 wire _0922_;
 wire _0923_;
 wire _0924_;
 wire _0925_;
 wire _0926_;
 wire _0927_;
 wire _0928_;
 wire _0929_;
 wire _0930_;
 wire _0931_;
 wire _0932_;
 wire _0933_;
 wire _0934_;
 wire _0935_;
 wire _0936_;
 wire _0937_;
 wire _0938_;
 wire _0939_;
 wire _0940_;
 wire _0941_;
 wire _0942_;
 wire clknet_leaf_74_clk;
 wire clknet_leaf_73_clk;
 wire _0945_;
 wire clknet_leaf_72_clk;
 wire clknet_leaf_71_clk;
 wire clknet_leaf_70_clk;
 wire clknet_leaf_69_clk;
 wire _0950_;
 wire clknet_leaf_68_clk;
 wire _0952_;
 wire clknet_leaf_67_clk;
 wire _0954_;
 wire _0955_;
 wire _0956_;
 wire _0957_;
 wire _0958_;
 wire _0959_;
 wire _0960_;
 wire _0961_;
 wire clknet_leaf_66_clk;
 wire _0963_;
 wire _0964_;
 wire clknet_leaf_65_clk;
 wire _0966_;
 wire _0967_;
 wire _0968_;
 wire _0969_;
 wire _0970_;
 wire _0971_;
 wire _0972_;
 wire clknet_leaf_64_clk;
 wire _0974_;
 wire _0975_;
 wire clknet_leaf_63_clk;
 wire _0977_;
 wire clknet_leaf_62_clk;
 wire clknet_leaf_61_clk;
 wire _0980_;
 wire clknet_leaf_60_clk;
 wire _0982_;
 wire _0983_;
 wire _0984_;
 wire clknet_leaf_59_clk;
 wire _0986_;
 wire clknet_leaf_58_clk;
 wire _0988_;
 wire _0989_;
 wire _0990_;
 wire _0991_;
 wire _0992_;
 wire clknet_leaf_57_clk;
 wire clknet_leaf_56_clk;
 wire clknet_leaf_55_clk;
 wire clknet_leaf_54_clk;
 wire _0997_;
 wire clknet_leaf_53_clk;
 wire _0999_;
 wire _1000_;
 wire clknet_leaf_52_clk;
 wire _1002_;
 wire _1003_;
 wire _1004_;
 wire _1005_;
 wire clknet_leaf_51_clk;
 wire clknet_leaf_50_clk;
 wire clknet_leaf_49_clk;
 wire _1009_;
 wire clknet_leaf_48_clk;
 wire clknet_leaf_47_clk;
 wire _1012_;
 wire clknet_leaf_46_clk;
 wire clknet_leaf_45_clk;
 wire _1015_;
 wire _1016_;
 wire clknet_leaf_44_clk;
 wire clknet_leaf_43_clk;
 wire clknet_leaf_42_clk;
 wire _1020_;
 wire _1021_;
 wire clknet_leaf_41_clk;
 wire _1023_;
 wire clknet_leaf_40_clk;
 wire clknet_leaf_39_clk;
 wire _1026_;
 wire _1027_;
 wire _1028_;
 wire clknet_leaf_38_clk;
 wire _1030_;
 wire _1031_;
 wire _1032_;
 wire clknet_leaf_37_clk;
 wire clknet_leaf_36_clk;
 wire clknet_leaf_35_clk;
 wire clknet_leaf_34_clk;
 wire _1037_;
 wire clknet_leaf_33_clk;
 wire _1039_;
 wire _1040_;
 wire _1041_;
 wire _1042_;
 wire _1043_;
 wire _1044_;
 wire _1045_;
 wire clknet_leaf_32_clk;
 wire _1047_;
 wire _1048_;
 wire _1049_;
 wire _1050_;
 wire _1051_;
 wire _1052_;
 wire _1053_;
 wire _1054_;
 wire _1055_;
 wire clknet_leaf_31_clk;
 wire clknet_leaf_30_clk;
 wire _1058_;
 wire clknet_leaf_29_clk;
 wire clknet_leaf_28_clk;
 wire _1061_;
 wire _1062_;
 wire _1063_;
 wire _1064_;
 wire _1065_;
 wire _1066_;
 wire _1067_;
 wire _1068_;
 wire _1069_;
 wire _1070_;
 wire _1071_;
 wire _1072_;
 wire _1073_;
 wire _1074_;
 wire _1075_;
 wire _1076_;
 wire _1077_;
 wire _1078_;
 wire _1079_;
 wire _1080_;
 wire _1081_;
 wire _1082_;
 wire _1083_;
 wire _1084_;
 wire _1085_;
 wire _1086_;
 wire _1087_;
 wire _1088_;
 wire _1089_;
 wire _1090_;
 wire _1091_;
 wire _1092_;
 wire _1093_;
 wire _1094_;
 wire _1095_;
 wire _1096_;
 wire _1097_;
 wire _1098_;
 wire _1099_;
 wire _1100_;
 wire _1101_;
 wire _1102_;
 wire _1103_;
 wire _1104_;
 wire _1105_;
 wire _1106_;
 wire _1107_;
 wire _1108_;
 wire _1109_;
 wire _1110_;
 wire _1111_;
 wire _1112_;
 wire _1113_;
 wire _1114_;
 wire _1115_;
 wire _1116_;
 wire _1117_;
 wire _1118_;
 wire _1119_;
 wire _1120_;
 wire _1121_;
 wire _1122_;
 wire _1123_;
 wire _1124_;
 wire _1125_;
 wire _1126_;
 wire _1127_;
 wire _1128_;
 wire _1129_;
 wire _1130_;
 wire _1131_;
 wire clknet_leaf_27_clk;
 wire _1133_;
 wire _1134_;
 wire clknet_leaf_26_clk;
 wire _1136_;
 wire _1137_;
 wire _1138_;
 wire _1139_;
 wire clknet_leaf_25_clk;
 wire clknet_leaf_24_clk;
 wire clknet_leaf_23_clk;
 wire _1143_;
 wire _1144_;
 wire _1145_;
 wire _1146_;
 wire _1147_;
 wire _1148_;
 wire _1149_;
 wire _1150_;
 wire _1151_;
 wire _1152_;
 wire _1153_;
 wire _1154_;
 wire _1155_;
 wire _1156_;
 wire _1157_;
 wire _1158_;
 wire _1159_;
 wire _1160_;
 wire _1161_;
 wire _1162_;
 wire _1163_;
 wire _1164_;
 wire _1165_;
 wire _1166_;
 wire _1167_;
 wire _1168_;
 wire _1169_;
 wire _1170_;
 wire _1171_;
 wire _1172_;
 wire _1173_;
 wire _1174_;
 wire _1175_;
 wire _1176_;
 wire _1177_;
 wire _1178_;
 wire _1179_;
 wire _1180_;
 wire _1181_;
 wire _1182_;
 wire _1183_;
 wire _1184_;
 wire _1185_;
 wire _1186_;
 wire _1187_;
 wire _1188_;
 wire _1189_;
 wire _1190_;
 wire _1191_;
 wire _1192_;
 wire _1193_;
 wire _1194_;
 wire _1195_;
 wire _1196_;
 wire _1197_;
 wire _1198_;
 wire _1199_;
 wire _1200_;
 wire _1201_;
 wire _1202_;
 wire _1203_;
 wire _1204_;
 wire _1205_;
 wire _1206_;
 wire _1207_;
 wire _1208_;
 wire _1209_;
 wire _1210_;
 wire _1211_;
 wire _1212_;
 wire _1213_;
 wire _1214_;
 wire _1215_;
 wire _1216_;
 wire _1217_;
 wire _1218_;
 wire _1219_;
 wire _1220_;
 wire _1221_;
 wire _1222_;
 wire clknet_leaf_22_clk;
 wire _1224_;
 wire _1225_;
 wire _1226_;
 wire _1227_;
 wire _1228_;
 wire clknet_leaf_21_clk;
 wire clknet_leaf_20_clk;
 wire clknet_leaf_19_clk;
 wire _1232_;
 wire _1233_;
 wire _1234_;
 wire _1235_;
 wire _1236_;
 wire _1237_;
 wire _1238_;
 wire _1239_;
 wire _1240_;
 wire _1241_;
 wire _1242_;
 wire _1243_;
 wire _1244_;
 wire _1245_;
 wire _1246_;
 wire _1247_;
 wire _1248_;
 wire _1249_;
 wire _1250_;
 wire _1251_;
 wire _1252_;
 wire _1253_;
 wire _1254_;
 wire _1255_;
 wire _1256_;
 wire _1257_;
 wire _1258_;
 wire _1259_;
 wire _1260_;
 wire _1261_;
 wire _1262_;
 wire _1263_;
 wire _1264_;
 wire _1265_;
 wire _1266_;
 wire _1267_;
 wire _1268_;
 wire _1269_;
 wire _1270_;
 wire _1271_;
 wire _1272_;
 wire _1273_;
 wire _1274_;
 wire _1275_;
 wire _1276_;
 wire _1277_;
 wire _1278_;
 wire _1279_;
 wire _1280_;
 wire _1281_;
 wire _1282_;
 wire _1283_;
 wire _1284_;
 wire _1285_;
 wire _1286_;
 wire clknet_leaf_18_clk;
 wire clknet_leaf_17_clk;
 wire clknet_leaf_16_clk;
 wire clknet_leaf_15_clk;
 wire _1291_;
 wire _1292_;
 wire _1293_;
 wire _1294_;
 wire _1295_;
 wire clknet_leaf_14_clk;
 wire clknet_leaf_13_clk;
 wire clknet_leaf_12_clk;
 wire _1299_;
 wire _1300_;
 wire _1301_;
 wire _1302_;
 wire _1303_;
 wire _1304_;
 wire _1305_;
 wire _1306_;
 wire _1307_;
 wire _1308_;
 wire _1309_;
 wire _1310_;
 wire _1311_;
 wire _1312_;
 wire _1313_;
 wire _1314_;
 wire _1315_;
 wire _1316_;
 wire _1317_;
 wire _1318_;
 wire _1319_;
 wire _1320_;
 wire _1321_;
 wire _1322_;
 wire _1323_;
 wire _1324_;
 wire _1325_;
 wire _1326_;
 wire _1327_;
 wire _1328_;
 wire _1329_;
 wire _1330_;
 wire _1331_;
 wire _1332_;
 wire _1333_;
 wire _1334_;
 wire _1335_;
 wire _1336_;
 wire _1337_;
 wire _1338_;
 wire _1339_;
 wire _1340_;
 wire _1341_;
 wire _1342_;
 wire _1343_;
 wire _1344_;
 wire _1345_;
 wire _1346_;
 wire _1347_;
 wire _1348_;
 wire _1349_;
 wire _1350_;
 wire _1351_;
 wire _1352_;
 wire _1353_;
 wire _1354_;
 wire _1355_;
 wire _1356_;
 wire _1357_;
 wire _1358_;
 wire _1359_;
 wire _1360_;
 wire _1361_;
 wire _1362_;
 wire _1363_;
 wire _1364_;
 wire _1365_;
 wire _1366_;
 wire _1367_;
 wire _1368_;
 wire _1369_;
 wire _1370_;
 wire _1371_;
 wire _1372_;
 wire _1373_;
 wire _1374_;
 wire _1375_;
 wire _1376_;
 wire _1377_;
 wire _1378_;
 wire _1379_;
 wire _1380_;
 wire _1381_;
 wire _1382_;
 wire _1383_;
 wire _1384_;
 wire _1385_;
 wire _1386_;
 wire _1387_;
 wire _1388_;
 wire _1389_;
 wire _1390_;
 wire _1391_;
 wire _1392_;
 wire _1393_;
 wire _1394_;
 wire _1395_;
 wire _1396_;
 wire _1397_;
 wire _1398_;
 wire _1399_;
 wire _1400_;
 wire _1401_;
 wire _1402_;
 wire _1403_;
 wire _1404_;
 wire _1405_;
 wire _1406_;
 wire _1407_;
 wire _1408_;
 wire _1409_;
 wire _1410_;
 wire _1411_;
 wire _1412_;
 wire _1413_;
 wire _1414_;
 wire _1415_;
 wire _1416_;
 wire _1417_;
 wire _1418_;
 wire _1419_;
 wire _1420_;
 wire _1421_;
 wire _1422_;
 wire _1423_;
 wire _1424_;
 wire _1425_;
 wire _1426_;
 wire _1427_;
 wire _1428_;
 wire _1429_;
 wire _1430_;
 wire _1431_;
 wire _1432_;
 wire _1433_;
 wire _1434_;
 wire _1435_;
 wire _1436_;
 wire _1437_;
 wire _1438_;
 wire _1439_;
 wire _1440_;
 wire _1441_;
 wire _1442_;
 wire _1443_;
 wire _1444_;
 wire _1445_;
 wire _1446_;
 wire _1447_;
 wire _1448_;
 wire _1449_;
 wire _1450_;
 wire _1451_;
 wire _1452_;
 wire _1453_;
 wire _1454_;
 wire _1455_;
 wire _1456_;
 wire _1457_;
 wire _1458_;
 wire _1459_;
 wire clknet_leaf_11_clk;
 wire _1461_;
 wire _1462_;
 wire _1463_;
 wire _1464_;
 wire _1465_;
 wire _1466_;
 wire _1467_;
 wire _1468_;
 wire _1469_;
 wire _1470_;
 wire _1471_;
 wire _1472_;
 wire _1473_;
 wire _1474_;
 wire _1475_;
 wire _1476_;
 wire _1477_;
 wire _1478_;
 wire _1479_;
 wire _1480_;
 wire _1481_;
 wire _1482_;
 wire _1483_;
 wire _1484_;
 wire _1485_;
 wire _1486_;
 wire _1487_;
 wire _1488_;
 wire _1489_;
 wire _1490_;
 wire _1491_;
 wire _1492_;
 wire _1493_;
 wire _1494_;
 wire _1495_;
 wire _1496_;
 wire _1497_;
 wire _1498_;
 wire clknet_leaf_10_clk;
 wire clknet_leaf_9_clk;
 wire clknet_leaf_8_clk;
 wire _1502_;
 wire clknet_leaf_7_clk;
 wire _1504_;
 wire _1505_;
 wire _1506_;
 wire _1507_;
 wire _1508_;
 wire _1509_;
 wire _1510_;
 wire _1511_;
 wire _1512_;
 wire _1513_;
 wire _1514_;
 wire _1515_;
 wire _1516_;
 wire _1517_;
 wire _1518_;
 wire _1519_;
 wire _1520_;
 wire _1521_;
 wire _1522_;
 wire _1523_;
 wire _1524_;
 wire _1525_;
 wire _1526_;
 wire _1527_;
 wire _1528_;
 wire _1529_;
 wire _1530_;
 wire _1531_;
 wire _1532_;
 wire _1533_;
 wire _1534_;
 wire _1535_;
 wire clknet_leaf_6_clk;
 wire _1537_;
 wire _1538_;
 wire _1539_;
 wire _1540_;
 wire _1541_;
 wire clknet_leaf_5_clk;
 wire _1543_;
 wire clknet_leaf_4_clk;
 wire _1545_;
 wire _1546_;
 wire _1547_;
 wire _1548_;
 wire _1549_;
 wire _1550_;
 wire _1551_;
 wire _1552_;
 wire _1553_;
 wire _1554_;
 wire _1555_;
 wire _1556_;
 wire _1557_;
 wire _1558_;
 wire _1559_;
 wire _1560_;
 wire _1561_;
 wire _1562_;
 wire _1563_;
 wire _1564_;
 wire _1565_;
 wire _1566_;
 wire _1567_;
 wire _1568_;
 wire _1569_;
 wire _1570_;
 wire _1571_;
 wire _1572_;
 wire _1573_;
 wire clknet_leaf_3_clk;
 wire _1575_;
 wire _1576_;
 wire _1577_;
 wire _1578_;
 wire _1579_;
 wire _1580_;
 wire _1581_;
 wire _1582_;
 wire _1583_;
 wire _1584_;
 wire _1585_;
 wire _1586_;
 wire _1587_;
 wire _1588_;
 wire _1589_;
 wire _1590_;
 wire _1591_;
 wire _1592_;
 wire _1593_;
 wire _1594_;
 wire _1595_;
 wire _1596_;
 wire _1597_;
 wire _1598_;
 wire _1599_;
 wire _1600_;
 wire _1601_;
 wire _1602_;
 wire _1603_;
 wire _1604_;
 wire _1605_;
 wire _1606_;
 wire _1607_;
 wire _1608_;
 wire _1609_;
 wire _1610_;
 wire _1611_;
 wire clknet_leaf_2_clk;
 wire _1613_;
 wire net820;
 wire net819;
 wire _1616_;
 wire _1617_;
 wire _1618_;
 wire _1619_;
 wire _1620_;
 wire _1621_;
 wire _1622_;
 wire _1623_;
 wire _1624_;
 wire _1625_;
 wire _1626_;
 wire _1627_;
 wire _1628_;
 wire _1629_;
 wire _1630_;
 wire _1631_;
 wire _1632_;
 wire _1633_;
 wire _1634_;
 wire _1635_;
 wire _1636_;
 wire _1637_;
 wire _1638_;
 wire net812;
 wire net811;
 wire _1641_;
 wire _1642_;
 wire _1643_;
 wire _1644_;
 wire _1645_;
 wire _1646_;
 wire _1647_;
 wire _1648_;
 wire _1649_;
 wire _1650_;
 wire _1651_;
 wire _1652_;
 wire _1653_;
 wire _1654_;
 wire _1655_;
 wire _1656_;
 wire _1657_;
 wire _1658_;
 wire _1659_;
 wire _1660_;
 wire _1661_;
 wire _1662_;
 wire _1663_;
 wire _1664_;
 wire _1665_;
 wire net799;
 wire net798;
 wire net791;
 wire _1669_;
 wire _1670_;
 wire _1671_;
 wire net790;
 wire _1673_;
 wire net789;
 wire _1675_;
 wire _1676_;
 wire _1677_;
 wire _1678_;
 wire _1679_;
 wire _1680_;
 wire _1681_;
 wire net788;
 wire net787;
 wire net775;
 wire net772;
 wire net763;
 wire net762;
 wire _1688_;
 wire net761;
 wire net760;
 wire net759;
 wire net758;
 wire _1693_;
 wire net757;
 wire net756;
 wire _1696_;
 wire net755;
 wire net753;
 wire _1699_;
 wire net752;
 wire net751;
 wire net750;
 wire net749;
 wire _1704_;
 wire _1705_;
 wire net748;
 wire net747;
 wire net746;
 wire _1709_;
 wire net745;
 wire net739;
 wire _1712_;
 wire _1713_;
 wire net738;
 wire _1715_;
 wire net737;
 wire net736;
 wire net729;
 wire _1719_;
 wire _1720_;
 wire net728;
 wire _1722_;
 wire _1723_;
 wire _1724_;
 wire _1725_;
 wire net726;
 wire _1727_;
 wire _1728_;
 wire _1729_;
 wire _1730_;
 wire _1731_;
 wire _1732_;
 wire _1733_;
 wire _1734_;
 wire _1735_;
 wire _1736_;
 wire _1737_;
 wire _1738_;
 wire _1739_;
 wire _1740_;
 wire _1741_;
 wire _1742_;
 wire _1743_;
 wire _1744_;
 wire _1745_;
 wire _1746_;
 wire _1747_;
 wire _1748_;
 wire _1749_;
 wire _1750_;
 wire _1751_;
 wire _1752_;
 wire _1753_;
 wire _1754_;
 wire _1755_;
 wire _1756_;
 wire _1757_;
 wire _1758_;
 wire _1759_;
 wire _1760_;
 wire _1761_;
 wire _1762_;
 wire _1763_;
 wire net724;
 wire _1765_;
 wire _1766_;
 wire _1767_;
 wire _1768_;
 wire _1769_;
 wire net722;
 wire net720;
 wire _1772_;
 wire _1773_;
 wire _1774_;
 wire _1775_;
 wire _1776_;
 wire _1777_;
 wire _1778_;
 wire _1779_;
 wire _1780_;
 wire _1781_;
 wire _1782_;
 wire _1783_;
 wire _1784_;
 wire _1785_;
 wire _1786_;
 wire _1787_;
 wire _1788_;
 wire net719;
 wire _1790_;
 wire net715;
 wire net713;
 wire net712;
 wire net711;
 wire net652;
 wire _1796_;
 wire net650;
 wire net648;
 wire _1799_;
 wire net647;
 wire net646;
 wire _1802_;
 wire _1803_;
 wire net645;
 wire net644;
 wire net642;
 wire net641;
 wire _1808_;
 wire _1809_;
 wire net643;
 wire net639;
 wire _1812_;
 wire _1813_;
 wire _1814_;
 wire _1815_;
 wire _1816_;
 wire net640;
 wire _1818_;
 wire _1819_;
 wire _1820_;
 wire net826;
 wire net685;
 wire _1823_;
 wire net653;
 wire _1825_;
 wire _1826_;
 wire _1827_;
 wire _1828_;
 wire _1829_;
 wire _1830_;
 wire _1831_;
 wire _1832_;
 wire _1833_;
 wire _1834_;
 wire _1835_;
 wire _1836_;
 wire _1837_;
 wire _1838_;
 wire _1839_;
 wire _1840_;
 wire _1841_;
 wire _1842_;
 wire net651;
 wire _1844_;
 wire _1845_;
 wire _1846_;
 wire _1847_;
 wire net649;
 wire _1849_;
 wire _1850_;
 wire _1851_;
 wire net828;
 wire net827;
 wire _1854_;
 wire _1855_;
 wire _1856_;
 wire _1857_;
 wire net825;
 wire _1859_;
 wire _1860_;
 wire _1861_;
 wire net696;
 wire clknet_leaf_1_clk;
 wire _1864_;
 wire _1865_;
 wire _1866_;
 wire _1867_;
 wire _1868_;
 wire _1869_;
 wire _1870_;
 wire _1871_;
 wire net822;
 wire _1873_;
 wire net821;
 wire clknet_leaf_0_clk;
 wire net823;
 wire _1877_;
 wire net824;
 wire net813;
 wire _1880_;
 wire _1881_;
 wire _1882_;
 wire net807;
 wire net806;
 wire _1885_;
 wire net818;
 wire net817;
 wire _1888_;
 wire net803;
 wire net802;
 wire _1891_;
 wire net816;
 wire net815;
 wire _1894_;
 wire net814;
 wire net809;
 wire _1897_;
 wire _1898_;
 wire _1899_;
 wire _1900_;
 wire _1901_;
 wire net800;
 wire net808;
 wire net805;
 wire _1905_;
 wire _1906_;
 wire net804;
 wire _1908_;
 wire _1909_;
 wire net801;
 wire _1911_;
 wire net793;
 wire net792;
 wire net785;
 wire net783;
 wire _1916_;
 wire _1917_;
 wire net781;
 wire net778;
 wire _1920_;
 wire net777;
 wire net764;
 wire _1923_;
 wire net733;
 wire net732;
 wire _1926_;
 wire _1927_;
 wire net731;
 wire net730;
 wire _1930_;
 wire net727;
 wire net725;
 wire _1933_;
 wire _1934_;
 wire _1935_;
 wire _1936_;
 wire _1937_;
 wire _1938_;
 wire _1939_;
 wire _1940_;
 wire _1941_;
 wire _1942_;
 wire _1943_;
 wire _1944_;
 wire net742;
 wire _1946_;
 wire _1947_;
 wire _1948_;
 wire _1949_;
 wire _1950_;
 wire _1951_;
 wire _1952_;
 wire _1953_;
 wire _1954_;
 wire _1955_;
 wire _1956_;
 wire _1957_;
 wire _1958_;
 wire _1959_;
 wire _1960_;
 wire _1961_;
 wire _1962_;
 wire _1963_;
 wire _1964_;
 wire _1965_;
 wire _1966_;
 wire _1967_;
 wire _1968_;
 wire _1969_;
 wire _1970_;
 wire _1971_;
 wire _1972_;
 wire _1973_;
 wire _1974_;
 wire _1975_;
 wire _1976_;
 wire _1977_;
 wire _1978_;
 wire _1979_;
 wire _1980_;
 wire _1981_;
 wire _1982_;
 wire _1983_;
 wire _1984_;
 wire _1985_;
 wire _1986_;
 wire _1987_;
 wire net735;
 wire _1989_;
 wire _1990_;
 wire net734;
 wire _1992_;
 wire _1993_;
 wire _1994_;
 wire _1995_;
 wire _1996_;
 wire _1997_;
 wire _1998_;
 wire _1999_;
 wire _2000_;
 wire _2001_;
 wire _2002_;
 wire _2003_;
 wire _2004_;
 wire _2005_;
 wire _2006_;
 wire _2007_;
 wire _2008_;
 wire _2009_;
 wire _2010_;
 wire _2011_;
 wire _2012_;
 wire _2013_;
 wire _2014_;
 wire _2015_;
 wire _2016_;
 wire _2017_;
 wire _2018_;
 wire _2019_;
 wire _2020_;
 wire _2021_;
 wire _2022_;
 wire _2023_;
 wire _2024_;
 wire _2025_;
 wire _2026_;
 wire _2027_;
 wire _2028_;
 wire _2029_;
 wire _2030_;
 wire _2031_;
 wire _2032_;
 wire _2033_;
 wire _2034_;
 wire _2035_;
 wire _2036_;
 wire _2037_;
 wire _2038_;
 wire _2039_;
 wire _2040_;
 wire _2041_;
 wire _2042_;
 wire _2043_;
 wire _2044_;
 wire _2045_;
 wire _2046_;
 wire _2047_;
 wire _2048_;
 wire _2049_;
 wire _2050_;
 wire _2051_;
 wire _2052_;
 wire _2053_;
 wire _2054_;
 wire _2055_;
 wire _2056_;
 wire _2057_;
 wire _2058_;
 wire _2059_;
 wire _2060_;
 wire _2061_;
 wire _2062_;
 wire _2063_;
 wire _2064_;
 wire _2065_;
 wire _2066_;
 wire _2067_;
 wire _2068_;
 wire _2069_;
 wire _2070_;
 wire _2071_;
 wire net723;
 wire _2073_;
 wire _2074_;
 wire _2075_;
 wire _2076_;
 wire _2077_;
 wire _2078_;
 wire _2079_;
 wire _2080_;
 wire _2081_;
 wire _2082_;
 wire _2083_;
 wire _2084_;
 wire _2085_;
 wire _2086_;
 wire _2087_;
 wire _2088_;
 wire _2089_;
 wire _2090_;
 wire _2091_;
 wire _2092_;
 wire _2093_;
 wire _2094_;
 wire _2095_;
 wire _2096_;
 wire _2097_;
 wire _2098_;
 wire _2099_;
 wire _2100_;
 wire _2101_;
 wire _2102_;
 wire _2103_;
 wire _2104_;
 wire _2105_;
 wire _2106_;
 wire _2107_;
 wire _2108_;
 wire _2109_;
 wire _2110_;
 wire _2111_;
 wire _2112_;
 wire _2113_;
 wire _2114_;
 wire _2115_;
 wire _2116_;
 wire _2117_;
 wire _2118_;
 wire _2119_;
 wire _2120_;
 wire _2121_;
 wire _2122_;
 wire _2123_;
 wire _2124_;
 wire _2125_;
 wire _2126_;
 wire _2127_;
 wire _2128_;
 wire _2129_;
 wire _2130_;
 wire _2131_;
 wire _2132_;
 wire _2133_;
 wire _2134_;
 wire _2135_;
 wire _2136_;
 wire _2137_;
 wire _2138_;
 wire _2139_;
 wire _2140_;
 wire _2141_;
 wire _2142_;
 wire _2143_;
 wire _2144_;
 wire _2145_;
 wire _2146_;
 wire _2147_;
 wire _2148_;
 wire _2149_;
 wire _2150_;
 wire _2151_;
 wire _2152_;
 wire _2153_;
 wire _2154_;
 wire _2155_;
 wire _2156_;
 wire _2157_;
 wire _2158_;
 wire _2159_;
 wire _2160_;
 wire _2161_;
 wire _2162_;
 wire _2163_;
 wire _2164_;
 wire _2165_;
 wire _2166_;
 wire _2167_;
 wire _2168_;
 wire _2169_;
 wire _2170_;
 wire _2171_;
 wire _2172_;
 wire _2173_;
 wire _2174_;
 wire _2175_;
 wire _2176_;
 wire _2177_;
 wire _2178_;
 wire _2179_;
 wire _2180_;
 wire _2181_;
 wire _2182_;
 wire _2183_;
 wire _2184_;
 wire _2185_;
 wire _2186_;
 wire _2187_;
 wire _2188_;
 wire _2189_;
 wire _2190_;
 wire _2191_;
 wire _2192_;
 wire _2193_;
 wire _2194_;
 wire _2195_;
 wire _2196_;
 wire _2197_;
 wire _2198_;
 wire _2199_;
 wire _2200_;
 wire _2201_;
 wire _2202_;
 wire _2203_;
 wire _2204_;
 wire _2205_;
 wire _2206_;
 wire _2207_;
 wire _2208_;
 wire _2209_;
 wire _2210_;
 wire _2211_;
 wire _2212_;
 wire _2213_;
 wire _2214_;
 wire _2215_;
 wire _2216_;
 wire _2217_;
 wire _2218_;
 wire _2219_;
 wire _2220_;
 wire _2221_;
 wire _2222_;
 wire _2223_;
 wire _2224_;
 wire _2225_;
 wire _2226_;
 wire _2227_;
 wire _2228_;
 wire _2229_;
 wire _2230_;
 wire _2231_;
 wire _2232_;
 wire _2233_;
 wire _2234_;
 wire _2235_;
 wire _2236_;
 wire _2237_;
 wire _2238_;
 wire _2239_;
 wire _2240_;
 wire _2241_;
 wire _2242_;
 wire _2243_;
 wire _2244_;
 wire _2245_;
 wire _2246_;
 wire _2247_;
 wire _2248_;
 wire _2249_;
 wire _2250_;
 wire _2251_;
 wire _2252_;
 wire _2253_;
 wire _2254_;
 wire _2255_;
 wire net721;
 wire _2257_;
 wire _2258_;
 wire _2259_;
 wire _2260_;
 wire _2261_;
 wire _2262_;
 wire _2263_;
 wire _2264_;
 wire _2265_;
 wire _2266_;
 wire _2267_;
 wire _2268_;
 wire _2269_;
 wire _2270_;
 wire _2271_;
 wire _2272_;
 wire _2273_;
 wire _2274_;
 wire _2275_;
 wire _2276_;
 wire _2277_;
 wire _2278_;
 wire _2279_;
 wire _2280_;
 wire _2281_;
 wire _2282_;
 wire _2283_;
 wire _2284_;
 wire _2285_;
 wire _2286_;
 wire _2287_;
 wire _2288_;
 wire _2289_;
 wire _2290_;
 wire _2291_;
 wire _2292_;
 wire _2293_;
 wire _2294_;
 wire _2295_;
 wire _2296_;
 wire _2297_;
 wire _2298_;
 wire _2299_;
 wire _2300_;
 wire _2301_;
 wire _2302_;
 wire _2303_;
 wire _2304_;
 wire _2305_;
 wire _2306_;
 wire _2307_;
 wire _2308_;
 wire _2309_;
 wire _2310_;
 wire _2311_;
 wire _2312_;
 wire _2313_;
 wire _2314_;
 wire _2315_;
 wire _2316_;
 wire _2317_;
 wire _2318_;
 wire _2319_;
 wire _2320_;
 wire _2321_;
 wire _2322_;
 wire _2323_;
 wire _2324_;
 wire _2325_;
 wire _2326_;
 wire _2327_;
 wire _2328_;
 wire _2329_;
 wire _2330_;
 wire _2331_;
 wire _2332_;
 wire _2333_;
 wire _2334_;
 wire _2335_;
 wire _2336_;
 wire _2337_;
 wire _2338_;
 wire _2339_;
 wire _2340_;
 wire _2341_;
 wire _2342_;
 wire _2343_;
 wire _2344_;
 wire _2345_;
 wire _2346_;
 wire _2347_;
 wire _2348_;
 wire _2349_;
 wire _2350_;
 wire _2351_;
 wire _2352_;
 wire _2353_;
 wire _2354_;
 wire _2355_;
 wire _2356_;
 wire _2357_;
 wire _2358_;
 wire _2359_;
 wire _2360_;
 wire _2361_;
 wire _2362_;
 wire _2363_;
 wire _2364_;
 wire _2365_;
 wire _2366_;
 wire _2367_;
 wire _2368_;
 wire _2369_;
 wire _2370_;
 wire _2371_;
 wire _2372_;
 wire _2373_;
 wire _2374_;
 wire _2375_;
 wire _2376_;
 wire _2377_;
 wire _2378_;
 wire _2379_;
 wire _2380_;
 wire _2381_;
 wire _2382_;
 wire _2383_;
 wire _2384_;
 wire _2385_;
 wire _2386_;
 wire _2387_;
 wire _2388_;
 wire _2389_;
 wire _2390_;
 wire _2391_;
 wire _2392_;
 wire _2393_;
 wire _2394_;
 wire _2395_;
 wire _2396_;
 wire _2397_;
 wire _2398_;
 wire _2399_;
 wire _2400_;
 wire _2401_;
 wire _2402_;
 wire _2403_;
 wire _2404_;
 wire _2405_;
 wire _2406_;
 wire _2407_;
 wire _2408_;
 wire _2409_;
 wire net740;
 wire _2411_;
 wire _2412_;
 wire _2413_;
 wire _2414_;
 wire _2415_;
 wire _2416_;
 wire _2417_;
 wire _2418_;
 wire _2419_;
 wire _2420_;
 wire _2421_;
 wire _2422_;
 wire _2423_;
 wire _2424_;
 wire _2425_;
 wire _2426_;
 wire _2427_;
 wire _2428_;
 wire _2429_;
 wire _2430_;
 wire _2431_;
 wire _2432_;
 wire _2433_;
 wire _2434_;
 wire _2435_;
 wire _2436_;
 wire _2437_;
 wire _2438_;
 wire _2439_;
 wire _2440_;
 wire _2441_;
 wire _2442_;
 wire _2443_;
 wire _2444_;
 wire _2445_;
 wire _2446_;
 wire _2447_;
 wire _2448_;
 wire net718;
 wire net716;
 wire net714;
 wire net717;
 wire net741;
 wire net708;
 wire net705;
 wire _2456_;
 wire net699;
 wire net700;
 wire net707;
 wire _2460_;
 wire _2461_;
 wire net744;
 wire net704;
 wire net697;
 wire net743;
 wire net754;
 wire _2467_;
 wire net765;
 wire net766;
 wire net770;
 wire net767;
 wire _2472_;
 wire _2473_;
 wire _2474_;
 wire _2475_;
 wire _2476_;
 wire _2477_;
 wire net768;
 wire net688;
 wire _2480_;
 wire _2481_;
 wire _2482_;
 wire _2483_;
 wire _2484_;
 wire _2485_;
 wire net769;
 wire _2487_;
 wire net771;
 wire net773;
 wire _2490_;
 wire net774;
 wire net776;
 wire _2493_;
 wire net780;
 wire net779;
 wire _2496_;
 wire net706;
 wire net782;
 wire _2499_;
 wire net684;
 wire net683;
 wire _2502_;
 wire net682;
 wire net681;
 wire _2505_;
 wire net680;
 wire net679;
 wire _2508_;
 wire _2509_;
 wire _2510_;
 wire net784;
 wire net678;
 wire _2513_;
 wire net677;
 wire net676;
 wire _2516_;
 wire net786;
 wire _2518_;
 wire _2519_;
 wire _2520_;
 wire _2521_;
 wire _2522_;
 wire _2523_;
 wire _2524_;
 wire _2525_;
 wire _2526_;
 wire _2527_;
 wire _2528_;
 wire _2529_;
 wire _2530_;
 wire _2531_;
 wire _2532_;
 wire _2533_;
 wire net675;
 wire net797;
 wire _2536_;
 wire _2537_;
 wire _2538_;
 wire _2539_;
 wire _2540_;
 wire _2541_;
 wire _2542_;
 wire _2543_;
 wire _2544_;
 wire _2545_;
 wire _2546_;
 wire net674;
 wire net795;
 wire _2549_;
 wire _2550_;
 wire _2551_;
 wire _2552_;
 wire _2553_;
 wire _2554_;
 wire _2555_;
 wire _2556_;
 wire _2557_;
 wire _2558_;
 wire _2559_;
 wire _2560_;
 wire _2561_;
 wire _2562_;
 wire _2563_;
 wire _2564_;
 wire _2565_;
 wire _2566_;
 wire _2567_;
 wire net673;
 wire net794;
 wire _2570_;
 wire net672;
 wire net796;
 wire _2573_;
 wire _2574_;
 wire _2575_;
 wire _2576_;
 wire _2577_;
 wire _2578_;
 wire _2579_;
 wire _2580_;
 wire _2581_;
 wire net671;
 wire net670;
 wire _2584_;
 wire _2585_;
 wire _2586_;
 wire _2587_;
 wire _2588_;
 wire _2589_;
 wire _2590_;
 wire _2591_;
 wire _2592_;
 wire _2593_;
 wire _2594_;
 wire net810;
 wire net669;
 wire _2597_;
 wire _2598_;
 wire _2599_;
 wire _2600_;
 wire _2601_;
 wire _2602_;
 wire _2603_;
 wire _2604_;
 wire _2605_;
 wire _2606_;
 wire _2607_;
 wire _2608_;
 wire _2609_;
 wire _2610_;
 wire _2611_;
 wire _2612_;
 wire _2613_;
 wire _2614_;
 wire _2615_;
 wire net668;
 wire net667;
 wire _2618_;
 wire _2619_;
 wire _2620_;
 wire _2621_;
 wire _2622_;
 wire _2623_;
 wire _2624_;
 wire _2625_;
 wire _2626_;
 wire _2627_;
 wire _2628_;
 wire _2629_;
 wire net666;
 wire _2631_;
 wire _2632_;
 wire _2633_;
 wire _2634_;
 wire _2635_;
 wire _2636_;
 wire _2637_;
 wire net665;
 wire net664;
 wire _2640_;
 wire _2641_;
 wire _2642_;
 wire _2643_;
 wire net663;
 wire _2645_;
 wire _2646_;
 wire _2647_;
 wire _2648_;
 wire net687;
 wire net662;
 wire _2651_;
 wire net661;
 wire net660;
 wire _2654_;
 wire _2655_;
 wire _2656_;
 wire _2657_;
 wire _2658_;
 wire _2659_;
 wire net659;
 wire _2661_;
 wire _2662_;
 wire _2663_;
 wire _2664_;
 wire _2665_;
 wire _2666_;
 wire _2667_;
 wire _2668_;
 wire _2669_;
 wire _2670_;
 wire _2671_;
 wire _2672_;
 wire _2673_;
 wire _2674_;
 wire _2675_;
 wire _2676_;
 wire net658;
 wire net686;
 wire _2679_;
 wire _2680_;
 wire _2681_;
 wire _2682_;
 wire _2683_;
 wire _2684_;
 wire _2685_;
 wire _2686_;
 wire _2687_;
 wire _2688_;
 wire _2689_;
 wire net657;
 wire net656;
 wire _2692_;
 wire _2693_;
 wire _2694_;
 wire _2695_;
 wire _2696_;
 wire _2697_;
 wire _2698_;
 wire _2699_;
 wire _2700_;
 wire _2701_;
 wire _2702_;
 wire _2703_;
 wire _2704_;
 wire _2705_;
 wire _2706_;
 wire _2707_;
 wire _2708_;
 wire _2709_;
 wire _2710_;
 wire net654;
 wire net655;
 wire _2713_;
 wire net709;
 wire net695;
 wire _2716_;
 wire _2717_;
 wire _2718_;
 wire _2719_;
 wire _2720_;
 wire _2721_;
 wire _2722_;
 wire _2723_;
 wire _2724_;
 wire net690;
 wire net689;
 wire _2727_;
 wire _2728_;
 wire _2729_;
 wire _2730_;
 wire _2731_;
 wire _2732_;
 wire _2733_;
 wire _2734_;
 wire _2735_;
 wire _2736_;
 wire _2737_;
 wire net694;
 wire net691;
 wire _2740_;
 wire _2741_;
 wire _2742_;
 wire _2743_;
 wire _2744_;
 wire _2745_;
 wire _2746_;
 wire _2747_;
 wire _2748_;
 wire _2749_;
 wire _2750_;
 wire _2751_;
 wire _2752_;
 wire _2753_;
 wire _2754_;
 wire _2755_;
 wire _2756_;
 wire _2757_;
 wire _2758_;
 wire _2759_;
 wire _2760_;
 wire _2761_;
 wire _2762_;
 wire _2763_;
 wire _2764_;
 wire _2765_;
 wire _2766_;
 wire _2767_;
 wire _2768_;
 wire _2769_;
 wire _2770_;
 wire _2771_;
 wire _2772_;
 wire _2773_;
 wire _2774_;
 wire _2775_;
 wire _2776_;
 wire _2777_;
 wire _2778_;
 wire _2779_;
 wire _2780_;
 wire _2781_;
 wire net692;
 wire _2783_;
 wire _2784_;
 wire _2785_;
 wire _2786_;
 wire _2787_;
 wire _2788_;
 wire _2789_;
 wire _2790_;
 wire _2791_;
 wire _2792_;
 wire _2793_;
 wire _2794_;
 wire _2795_;
 wire _2796_;
 wire _2797_;
 wire _2798_;
 wire _2799_;
 wire _2800_;
 wire _2801_;
 wire _2802_;
 wire _2803_;
 wire _2804_;
 wire _2805_;
 wire _2806_;
 wire _2807_;
 wire _2808_;
 wire _2809_;
 wire _2810_;
 wire _2811_;
 wire _2812_;
 wire _2813_;
 wire _2814_;
 wire _2815_;
 wire _2816_;
 wire _2817_;
 wire _2818_;
 wire _2819_;
 wire _2820_;
 wire _2821_;
 wire _2822_;
 wire _2823_;
 wire _2824_;
 wire _2825_;
 wire _2826_;
 wire _2827_;
 wire _2828_;
 wire _2829_;
 wire _2830_;
 wire _2831_;
 wire _2832_;
 wire _2833_;
 wire _2834_;
 wire _2835_;
 wire _2836_;
 wire _2837_;
 wire _2838_;
 wire _2839_;
 wire _2840_;
 wire _2841_;
 wire _2842_;
 wire _2843_;
 wire net693;
 wire _2845_;
 wire _2846_;
 wire net703;
 wire net702;
 wire _2849_;
 wire net701;
 wire _2851_;
 wire _2852_;
 wire _2853_;
 wire _2854_;
 wire _2855_;
 wire _2856_;
 wire _2857_;
 wire _2858_;
 wire _2859_;
 wire _2860_;
 wire _2861_;
 wire _2862_;
 wire _2863_;
 wire _2864_;
 wire _2865_;
 wire _2866_;
 wire _2867_;
 wire _2868_;
 wire _2869_;
 wire _2870_;
 wire _2871_;
 wire _2872_;
 wire _2873_;
 wire _2874_;
 wire _2875_;
 wire _2876_;
 wire _2877_;
 wire _2878_;
 wire _2879_;
 wire _2880_;
 wire _2881_;
 wire _2882_;
 wire _2883_;
 wire _2884_;
 wire _2885_;
 wire _2886_;
 wire _2887_;
 wire _2888_;
 wire _2889_;
 wire _2890_;
 wire _2891_;
 wire _2892_;
 wire _2893_;
 wire _2894_;
 wire _2895_;
 wire _2896_;
 wire _2897_;
 wire _2898_;
 wire _2899_;
 wire _2900_;
 wire _2901_;
 wire _2902_;
 wire _2903_;
 wire _2904_;
 wire _2905_;
 wire _2906_;
 wire _2907_;
 wire _2908_;
 wire _2909_;
 wire _2910_;
 wire _2911_;
 wire _2912_;
 wire net698;
 wire net710;
 wire _2915_;
 wire _2916_;
 wire _2917_;
 wire _2918_;
 wire _2919_;
 wire _2920_;
 wire _2921_;
 wire _2922_;
 wire _2923_;
 wire _2924_;
 wire _2925_;
 wire _2926_;
 wire _2927_;
 wire _2928_;
 wire _2929_;
 wire _2930_;
 wire _2931_;
 wire _2932_;
 wire _2942_;
 wire _2943_;
 wire _2945_;
 wire _2946_;
 wire _2947_;
 wire _2949_;
 wire _2953_;
 wire _2954_;
 wire _2955_;
 wire _2956_;
 wire _2957_;
 wire _2958_;
 wire _2959_;
 wire _2960_;
 wire _2961_;
 wire _2962_;
 wire _2965_;
 wire _2967_;
 wire _2968_;
 wire _2969_;
 wire _2970_;
 wire _2971_;
 wire _2972_;
 wire _2973_;
 wire _2974_;
 wire _2975_;
 wire _2976_;
 wire _2977_;
 wire _2978_;
 wire _2979_;
 wire _2980_;
 wire _2981_;
 wire _2982_;
 wire _2983_;
 wire _2984_;
 wire _2986_;
 wire _2987_;
 wire _2988_;
 wire _2989_;
 wire _2990_;
 wire _2991_;
 wire _2992_;
 wire _2993_;
 wire _2994_;
 wire _2995_;
 wire _2996_;
 wire _2997_;
 wire _2998_;
 wire _2999_;
 wire _3000_;
 wire _3001_;
 wire _3002_;
 wire _3003_;
 wire _3005_;
 wire _3006_;
 wire _3007_;
 wire _3008_;
 wire _3009_;
 wire _3010_;
 wire _3011_;
 wire _3012_;
 wire _3013_;
 wire _3014_;
 wire _3015_;
 wire _3016_;
 wire _3018_;
 wire _3020_;
 wire _3021_;
 wire _3023_;
 wire _3024_;
 wire _3025_;
 wire _3026_;
 wire _3027_;
 wire _3028_;
 wire _3029_;
 wire _3030_;
 wire _3031_;
 wire _3032_;
 wire _3033_;
 wire _3034_;
 wire _3035_;
 wire _3036_;
 wire _3037_;
 wire _3038_;
 wire _3039_;
 wire _3040_;
 wire _3041_;
 wire _3042_;
 wire _3043_;
 wire _3044_;
 wire _3045_;
 wire _3046_;
 wire _3047_;
 wire _3048_;
 wire _3049_;
 wire _3050_;
 wire _3051_;
 wire _3052_;
 wire _3053_;
 wire _3054_;
 wire _3055_;
 wire _3056_;
 wire _3057_;
 wire _3058_;
 wire _3059_;
 wire _3064_;
 wire _3066_;
 wire _3067_;
 wire _3069_;
 wire _3070_;
 wire _3071_;
 wire _3072_;
 wire _3073_;
 wire _3074_;
 wire _3075_;
 wire _3076_;
 wire _3077_;
 wire _3078_;
 wire _3079_;
 wire _3080_;
 wire _3081_;
 wire _3082_;
 wire _3083_;
 wire _3084_;
 wire _3085_;
 wire _3086_;
 wire _3087_;
 wire _3088_;
 wire _3089_;
 wire _3091_;
 wire _3092_;
 wire _3093_;
 wire _3094_;
 wire _3095_;
 wire _3096_;
 wire _3097_;
 wire _3098_;
 wire _3099_;
 wire _3100_;
 wire _3101_;
 wire _3102_;
 wire _3103_;
 wire _3104_;
 wire _3105_;
 wire _3106_;
 wire _3107_;
 wire _3108_;
 wire _3109_;
 wire _3110_;
 wire _3111_;
 wire _3112_;
 wire _3113_;
 wire _3114_;
 wire _3115_;
 wire _3116_;
 wire _3117_;
 wire _3118_;
 wire _3119_;
 wire _3120_;
 wire _3121_;
 wire _3122_;
 wire _3123_;
 wire _3124_;
 wire _3126_;
 wire _3127_;
 wire _3128_;
 wire _3129_;
 wire _3130_;
 wire _3131_;
 wire _3132_;
 wire _3133_;
 wire _3134_;
 wire _3135_;
 wire _3136_;
 wire _3137_;
 wire _3138_;
 wire _3139_;
 wire _3140_;
 wire _3141_;
 wire _3142_;
 wire _3143_;
 wire _3144_;
 wire _3145_;
 wire _3146_;
 wire _3147_;
 wire _3148_;
 wire _3149_;
 wire _3150_;
 wire _3151_;
 wire _3152_;
 wire _3153_;
 wire _3154_;
 wire _3155_;
 wire _3156_;
 wire _3157_;
 wire _3158_;
 wire _3159_;
 wire _3160_;
 wire _3161_;
 wire _3162_;
 wire _3163_;
 wire _3164_;
 wire _3165_;
 wire _3166_;
 wire _3167_;
 wire _3168_;
 wire _3169_;
 wire _3170_;
 wire _3171_;
 wire _3172_;
 wire _3173_;
 wire _3174_;
 wire _3175_;
 wire _3179_;
 wire _3181_;
 wire _3182_;
 wire _3183_;
 wire _3184_;
 wire _3185_;
 wire _3186_;
 wire _3187_;
 wire _3188_;
 wire _3189_;
 wire _3190_;
 wire _3191_;
 wire _3192_;
 wire _3193_;
 wire _3195_;
 wire _3196_;
 wire _3197_;
 wire _3198_;
 wire _3199_;
 wire _3200_;
 wire _3201_;
 wire _3202_;
 wire _3203_;
 wire _3204_;
 wire _3205_;
 wire _3206_;
 wire _3207_;
 wire _3208_;
 wire _3209_;
 wire _3210_;
 wire _3212_;
 wire _3213_;
 wire _3214_;
 wire _3215_;
 wire _3216_;
 wire _3217_;
 wire _3218_;
 wire _3219_;
 wire _3220_;
 wire _3221_;
 wire _3222_;
 wire _3223_;
 wire _3224_;
 wire _3225_;
 wire _3226_;
 wire _3227_;
 wire _3228_;
 wire _3229_;
 wire _3230_;
 wire _3231_;
 wire _3232_;
 wire _3233_;
 wire _3234_;
 wire _3235_;
 wire _3236_;
 wire _3237_;
 wire _3238_;
 wire _3239_;
 wire _3240_;
 wire _3241_;
 wire _3242_;
 wire _3243_;
 wire _3244_;
 wire _3245_;
 wire _3246_;
 wire _3247_;
 wire _3248_;
 wire _3249_;
 wire _3250_;
 wire _3251_;
 wire _3252_;
 wire _3253_;
 wire _3254_;
 wire _3255_;
 wire _3256_;
 wire _3257_;
 wire _3258_;
 wire _3259_;
 wire _3260_;
 wire _3261_;
 wire _3262_;
 wire _3263_;
 wire _3264_;
 wire _3265_;
 wire _3267_;
 wire _3268_;
 wire _3269_;
 wire _3270_;
 wire _3271_;
 wire _3272_;
 wire _3273_;
 wire _3274_;
 wire _3275_;
 wire _3276_;
 wire _3277_;
 wire _3278_;
 wire _3279_;
 wire _3280_;
 wire _3281_;
 wire _3282_;
 wire _3283_;
 wire _3284_;
 wire _3285_;
 wire _3286_;
 wire _3287_;
 wire _3288_;
 wire _3289_;
 wire _3291_;
 wire _3292_;
 wire _3293_;
 wire _3294_;
 wire _3295_;
 wire _3296_;
 wire _3297_;
 wire _3298_;
 wire _3299_;
 wire _3300_;
 wire _3301_;
 wire _3302_;
 wire _3303_;
 wire _3304_;
 wire _3305_;
 wire _3306_;
 wire _3307_;
 wire _3308_;
 wire _3309_;
 wire _3310_;
 wire _3311_;
 wire _3312_;
 wire _3313_;
 wire _3314_;
 wire _3315_;
 wire _3316_;
 wire _3317_;
 wire _3318_;
 wire _3319_;
 wire _3320_;
 wire _3321_;
 wire _3322_;
 wire _3323_;
 wire _3324_;
 wire _3325_;
 wire _3326_;
 wire _3327_;
 wire _3328_;
 wire _3329_;
 wire _3330_;
 wire _3331_;
 wire _3332_;
 wire _3333_;
 wire _3334_;
 wire _3335_;
 wire _3336_;
 wire _3337_;
 wire _3338_;
 wire _3339_;
 wire _3340_;
 wire _3341_;
 wire _3342_;
 wire _3343_;
 wire _3344_;
 wire _3345_;
 wire _3346_;
 wire _3347_;
 wire _3348_;
 wire _3349_;
 wire _3350_;
 wire _3351_;
 wire _3352_;
 wire _3353_;
 wire _3354_;
 wire _3355_;
 wire _3356_;
 wire _3357_;
 wire _3358_;
 wire _3361_;
 wire _3363_;
 wire _3365_;
 wire _3367_;
 wire _3371_;
 wire _3372_;
 wire _3373_;
 wire _3374_;
 wire _3375_;
 wire _3376_;
 wire _3378_;
 wire _3379_;
 wire _3380_;
 wire _3381_;
 wire _3382_;
 wire _3383_;
 wire _3384_;
 wire _3385_;
 wire _3386_;
 wire _3387_;
 wire _3388_;
 wire _3389_;
 wire _3390_;
 wire _3391_;
 wire _3392_;
 wire _3393_;
 wire _3394_;
 wire _3395_;
 wire _3396_;
 wire _3397_;
 wire _3398_;
 wire _3399_;
 wire _3400_;
 wire _3401_;
 wire _3402_;
 wire _3403_;
 wire _3404_;
 wire _3405_;
 wire _3406_;
 wire _3407_;
 wire _3408_;
 wire _3409_;
 wire _3410_;
 wire _3411_;
 wire _3412_;
 wire _3415_;
 wire _3417_;
 wire _3418_;
 wire _3419_;
 wire _3420_;
 wire _3421_;
 wire _3422_;
 wire _3423_;
 wire _3424_;
 wire _3425_;
 wire _3426_;
 wire _3427_;
 wire _3428_;
 wire _3429_;
 wire _3430_;
 wire _3431_;
 wire _3432_;
 wire _3433_;
 wire _3434_;
 wire _3435_;
 wire _3436_;
 wire _3438_;
 wire _3439_;
 wire _3440_;
 wire _3442_;
 wire _3444_;
 wire _3445_;
 wire _3446_;
 wire _3447_;
 wire _3448_;
 wire _3449_;
 wire _3450_;
 wire _3451_;
 wire _3452_;
 wire _3453_;
 wire _3454_;
 wire _3455_;
 wire _3457_;
 wire _3458_;
 wire _3459_;
 wire _3460_;
 wire _3461_;
 wire _3462_;
 wire _3463_;
 wire _3464_;
 wire _3465_;
 wire _3466_;
 wire _3468_;
 wire _3469_;
 wire _3471_;
 wire _3473_;
 wire _3474_;
 wire _3475_;
 wire _3476_;
 wire _3477_;
 wire _3478_;
 wire _3479_;
 wire _3480_;
 wire _3481_;
 wire _3482_;
 wire _3483_;
 wire _3484_;
 wire _3485_;
 wire _3486_;
 wire _3487_;
 wire _3488_;
 wire _3489_;
 wire _3490_;
 wire _3491_;
 wire _3492_;
 wire _3493_;
 wire _3494_;
 wire _3495_;
 wire _3496_;
 wire _3497_;
 wire _3500_;
 wire _3502_;
 wire _3505_;
 wire _3506_;
 wire _3512_;
 wire _3513_;
 wire _3514_;
 wire _3515_;
 wire _3516_;
 wire _3517_;
 wire _3518_;
 wire _3519_;
 wire _3520_;
 wire _3521_;
 wire _3524_;
 wire _3525_;
 wire _3526_;
 wire _3527_;
 wire _3529_;
 wire _3530_;
 wire _3531_;
 wire _3532_;
 wire _3533_;
 wire _3534_;
 wire _3535_;
 wire _3536_;
 wire _3537_;
 wire _3538_;
 wire _3539_;
 wire _3540_;
 wire _3541_;
 wire _3542_;
 wire _3543_;
 wire _3544_;
 wire _3545_;
 wire _3546_;
 wire _3547_;
 wire _3548_;
 wire _3549_;
 wire _3550_;
 wire _3551_;
 wire _3552_;
 wire _3553_;
 wire _3554_;
 wire _3555_;
 wire _3556_;
 wire _3557_;
 wire _3558_;
 wire _3559_;
 wire _3560_;
 wire _3561_;
 wire _3563_;
 wire _3564_;
 wire _3565_;
 wire _3566_;
 wire _3567_;
 wire _3568_;
 wire _3569_;
 wire _3570_;
 wire _3571_;
 wire _3572_;
 wire _3573_;
 wire _3574_;
 wire _3575_;
 wire _3576_;
 wire _3577_;
 wire _3578_;
 wire _3580_;
 wire _3581_;
 wire _3582_;
 wire _3583_;
 wire _3584_;
 wire _3585_;
 wire _3587_;
 wire _3588_;
 wire _3589_;
 wire _3590_;
 wire _3591_;
 wire _3592_;
 wire _3593_;
 wire _3594_;
 wire _3595_;
 wire _3596_;
 wire _3597_;
 wire _3598_;
 wire _3599_;
 wire _3600_;
 wire _3601_;
 wire _3602_;
 wire _3603_;
 wire _3604_;
 wire _3605_;
 wire _3606_;
 wire _3607_;
 wire _3608_;
 wire _3609_;
 wire _3610_;
 wire _3611_;
 wire _3613_;
 wire _3614_;
 wire _3615_;
 wire _3616_;
 wire _3617_;
 wire _3618_;
 wire _3619_;
 wire _3620_;
 wire _3621_;
 wire _3622_;
 wire _3623_;
 wire _3624_;
 wire _3625_;
 wire _3626_;
 wire _3627_;
 wire _3628_;
 wire _3629_;
 wire _3630_;
 wire _3631_;
 wire _3632_;
 wire _3633_;
 wire _3634_;
 wire _3635_;
 wire _3636_;
 wire _3637_;
 wire _3638_;
 wire _3639_;
 wire _3640_;
 wire _3643_;
 wire _3644_;
 wire _3645_;
 wire _3646_;
 wire _3647_;
 wire _3649_;
 wire _3650_;
 wire _3651_;
 wire _3652_;
 wire _3653_;
 wire _3654_;
 wire _3655_;
 wire _3656_;
 wire _3657_;
 wire _3658_;
 wire _3659_;
 wire _3660_;
 wire _3661_;
 wire _3662_;
 wire _3663_;
 wire _3664_;
 wire _3665_;
 wire _3666_;
 wire _3667_;
 wire _3668_;
 wire _3669_;
 wire _3670_;
 wire _3672_;
 wire _3673_;
 wire _3674_;
 wire _3675_;
 wire _3677_;
 wire _3678_;
 wire _3679_;
 wire _3680_;
 wire _3681_;
 wire _3682_;
 wire _3683_;
 wire _3684_;
 wire _3685_;
 wire _3686_;
 wire _3687_;
 wire _3688_;
 wire _3689_;
 wire _3691_;
 wire _3692_;
 wire _3693_;
 wire _3694_;
 wire _3695_;
 wire _3696_;
 wire _3697_;
 wire _3698_;
 wire _3699_;
 wire _3700_;
 wire _3701_;
 wire _3702_;
 wire _3704_;
 wire _3705_;
 wire _3706_;
 wire _3707_;
 wire _3708_;
 wire _3709_;
 wire _3710_;
 wire _3711_;
 wire _3712_;
 wire _3713_;
 wire _3714_;
 wire _3715_;
 wire _3716_;
 wire _3719_;
 wire _3720_;
 wire _3721_;
 wire _3723_;
 wire _3724_;
 wire _3725_;
 wire _3726_;
 wire _3727_;
 wire _3728_;
 wire _3729_;
 wire _3730_;
 wire _3732_;
 wire _3733_;
 wire _3734_;
 wire _3736_;
 wire _3737_;
 wire _3738_;
 wire _3739_;
 wire _3740_;
 wire _3741_;
 wire _3742_;
 wire _3743_;
 wire _3744_;
 wire _3745_;
 wire _3746_;
 wire _3747_;
 wire _3748_;
 wire _3749_;
 wire _3750_;
 wire _3751_;
 wire _3752_;
 wire _3753_;
 wire _3754_;
 wire _3755_;
 wire _3756_;
 wire _3757_;
 wire _3758_;
 wire _3759_;
 wire _3760_;
 wire _3761_;
 wire _3762_;
 wire _3763_;
 wire _3764_;
 wire _3765_;
 wire _3766_;
 wire _3767_;
 wire _3768_;
 wire _3769_;
 wire _3770_;
 wire _3771_;
 wire _3772_;
 wire _3773_;
 wire _3774_;
 wire _3775_;
 wire _3776_;
 wire _3777_;
 wire _3778_;
 wire _3779_;
 wire _3780_;
 wire _3781_;
 wire _3782_;
 wire _3783_;
 wire _3785_;
 wire _3787_;
 wire _3790_;
 wire _3791_;
 wire _3792_;
 wire _3793_;
 wire _3794_;
 wire _3796_;
 wire _3797_;
 wire _3798_;
 wire _3799_;
 wire _3800_;
 wire _3802_;
 wire _3803_;
 wire _3805_;
 wire _3807_;
 wire _3808_;
 wire _3809_;
 wire _3810_;
 wire _3811_;
 wire _3812_;
 wire _3813_;
 wire _3814_;
 wire _3815_;
 wire _3816_;
 wire _3817_;
 wire _3818_;
 wire _3819_;
 wire _3820_;
 wire _3821_;
 wire _3822_;
 wire _3823_;
 wire _3824_;
 wire _3825_;
 wire _3826_;
 wire _3827_;
 wire _3828_;
 wire _3829_;
 wire _3830_;
 wire _3831_;
 wire _3832_;
 wire _3833_;
 wire _3834_;
 wire _3835_;
 wire _3836_;
 wire _3837_;
 wire _3838_;
 wire _3839_;
 wire _3840_;
 wire _3841_;
 wire _3842_;
 wire _3843_;
 wire _3844_;
 wire _3845_;
 wire _3846_;
 wire _3847_;
 wire _3848_;
 wire _3850_;
 wire _3851_;
 wire _3852_;
 wire _3853_;
 wire _3854_;
 wire _3855_;
 wire _3856_;
 wire _3858_;
 wire _3859_;
 wire _3860_;
 wire _3861_;
 wire _3862_;
 wire _3863_;
 wire _3864_;
 wire _3865_;
 wire _3866_;
 wire _3867_;
 wire _3868_;
 wire _3869_;
 wire _3870_;
 wire _3871_;
 wire _3872_;
 wire _3873_;
 wire _3874_;
 wire _3875_;
 wire _3876_;
 wire _3877_;
 wire _3878_;
 wire _3879_;
 wire _3880_;
 wire _3881_;
 wire _3882_;
 wire _3883_;
 wire _3884_;
 wire _3885_;
 wire _3886_;
 wire _3887_;
 wire _3888_;
 wire _3889_;
 wire _3890_;
 wire _3891_;
 wire _3892_;
 wire _3893_;
 wire _3894_;
 wire _3895_;
 wire _3896_;
 wire _3897_;
 wire _3898_;
 wire _3899_;
 wire _3900_;
 wire _3901_;
 wire _3902_;
 wire _3903_;
 wire _3904_;
 wire _3905_;
 wire _3906_;
 wire _3907_;
 wire _3908_;
 wire _3909_;
 wire _3911_;
 wire _3912_;
 wire _3913_;
 wire _3914_;
 wire _3915_;
 wire _3916_;
 wire _3917_;
 wire _3918_;
 wire _3919_;
 wire _3920_;
 wire _3921_;
 wire _3922_;
 wire _3923_;
 wire _3924_;
 wire _3925_;
 wire _3926_;
 wire _3928_;
 wire _3929_;
 wire _3930_;
 wire _3931_;
 wire _3932_;
 wire _3933_;
 wire _3934_;
 wire _3935_;
 wire _3936_;
 wire _3937_;
 wire _3938_;
 wire _3939_;
 wire _3940_;
 wire _3941_;
 wire _3942_;
 wire _3943_;
 wire _3944_;
 wire _3945_;
 wire _3946_;
 wire _3947_;
 wire _3948_;
 wire _3949_;
 wire _3950_;
 wire _3951_;
 wire _3952_;
 wire _3953_;
 wire _3954_;
 wire _3955_;
 wire _3956_;
 wire _3957_;
 wire _3958_;
 wire _3959_;
 wire _3960_;
 wire _3961_;
 wire _3962_;
 wire _3963_;
 wire _3964_;
 wire _3965_;
 wire _3966_;
 wire _3967_;
 wire _3968_;
 wire _3969_;
 wire _3971_;
 wire _3972_;
 wire _3973_;
 wire _3974_;
 wire _3975_;
 wire _3976_;
 wire _3977_;
 wire _3978_;
 wire _3979_;
 wire _3980_;
 wire _3981_;
 wire _3982_;
 wire _3983_;
 wire _3984_;
 wire _3985_;
 wire _3986_;
 wire _3987_;
 wire _3988_;
 wire _3990_;
 wire _3991_;
 wire _3992_;
 wire _3993_;
 wire _3994_;
 wire _3995_;
 wire _3996_;
 wire _3997_;
 wire _3998_;
 wire _3999_;
 wire _4000_;
 wire _4001_;
 wire _4002_;
 wire _4003_;
 wire _4004_;
 wire _4005_;
 wire _4006_;
 wire _4007_;
 wire _4008_;
 wire _4009_;
 wire _4010_;
 wire _4011_;
 wire _4012_;
 wire _4013_;
 wire _4014_;
 wire _4015_;
 wire _4016_;
 wire _4017_;
 wire _4018_;
 wire _4019_;
 wire _4020_;
 wire _4021_;
 wire _4022_;
 wire _4023_;
 wire _4024_;
 wire _4025_;
 wire _4026_;
 wire _4027_;
 wire _4028_;
 wire _4030_;
 wire _4031_;
 wire _4032_;
 wire _4033_;
 wire _4034_;
 wire _4035_;
 wire _4036_;
 wire _4037_;
 wire _4038_;
 wire _4039_;
 wire _4040_;
 wire _4042_;
 wire _4043_;
 wire _4044_;
 wire _4045_;
 wire _4046_;
 wire _4047_;
 wire _4048_;
 wire _4049_;
 wire _4050_;
 wire _4051_;
 wire _4052_;
 wire _4053_;
 wire _4054_;
 wire _4055_;
 wire _4056_;
 wire _4057_;
 wire _4058_;
 wire _4059_;
 wire _4060_;
 wire _4061_;
 wire _4062_;
 wire _4063_;
 wire _4064_;
 wire _4065_;
 wire _4066_;
 wire _4067_;
 wire _4068_;
 wire _4070_;
 wire _4071_;
 wire _4072_;
 wire _4073_;
 wire _4074_;
 wire _4075_;
 wire _4076_;
 wire _4077_;
 wire _4078_;
 wire _4079_;
 wire _4080_;
 wire _4081_;
 wire _4082_;
 wire _4083_;
 wire _4084_;
 wire _4085_;
 wire _4086_;
 wire _4087_;
 wire _4088_;
 wire _4089_;
 wire _4090_;
 wire _4091_;
 wire _4092_;
 wire _4093_;
 wire _4095_;
 wire _4096_;
 wire _4097_;
 wire _4098_;
 wire _4099_;
 wire _4100_;
 wire _4101_;
 wire _4102_;
 wire _4103_;
 wire _4104_;
 wire _4105_;
 wire _4106_;
 wire _4107_;
 wire _4108_;
 wire _4109_;
 wire _4110_;
 wire _4112_;
 wire _4113_;
 wire _4114_;
 wire _4115_;
 wire _4116_;
 wire _4117_;
 wire _4118_;
 wire _4119_;
 wire _4120_;
 wire _4121_;
 wire _4122_;
 wire _4123_;
 wire _4124_;
 wire _4125_;
 wire _4126_;
 wire _4127_;
 wire _4128_;
 wire _4129_;
 wire _4130_;
 wire _4131_;
 wire _4133_;
 wire _4134_;
 wire _4135_;
 wire _4136_;
 wire _4137_;
 wire _4138_;
 wire _4139_;
 wire _4140_;
 wire _4141_;
 wire _4142_;
 wire _4144_;
 wire _4145_;
 wire _4146_;
 wire _4147_;
 wire _4148_;
 wire _4149_;
 wire _4150_;
 wire _4151_;
 wire _4152_;
 wire _4153_;
 wire _4154_;
 wire _4155_;
 wire _4156_;
 wire _4157_;
 wire _4158_;
 wire _4159_;
 wire _4160_;
 wire _4161_;
 wire _4162_;
 wire _4163_;
 wire _4164_;
 wire _4166_;
 wire _4167_;
 wire _4168_;
 wire _4169_;
 wire _4170_;
 wire _4171_;
 wire _4172_;
 wire _4173_;
 wire _4174_;
 wire _4175_;
 wire _4176_;
 wire _4177_;
 wire _4178_;
 wire _4179_;
 wire _4180_;
 wire _4181_;
 wire _4182_;
 wire _4183_;
 wire _4184_;
 wire _4185_;
 wire _4186_;
 wire _4187_;
 wire _4188_;
 wire _4189_;
 wire _4190_;
 wire _4191_;
 wire _4193_;
 wire _4194_;
 wire _4195_;
 wire _4196_;
 wire _4197_;
 wire _4198_;
 wire _4199_;
 wire _4200_;
 wire _4202_;
 wire _4203_;
 wire _4204_;
 wire _4205_;
 wire _4206_;
 wire _4207_;
 wire _4208_;
 wire _4209_;
 wire _4210_;
 wire _4211_;
 wire _4212_;
 wire _4213_;
 wire _4214_;
 wire _4215_;
 wire _4216_;
 wire _4217_;
 wire _4218_;
 wire _4219_;
 wire _4220_;
 wire _4221_;
 wire _4222_;
 wire _4223_;
 wire _4224_;
 wire _4225_;
 wire _4226_;
 wire _4227_;
 wire _4228_;
 wire _4229_;
 wire _4231_;
 wire _4232_;
 wire _4233_;
 wire _4234_;
 wire _4235_;
 wire _4236_;
 wire _4237_;
 wire _4238_;
 wire _4239_;
 wire _4240_;
 wire _4241_;
 wire _4242_;
 wire _4243_;
 wire _4244_;
 wire _4245_;
 wire _4246_;
 wire _4247_;
 wire _4248_;
 wire _4249_;
 wire _4251_;
 wire _4252_;
 wire _4253_;
 wire _4254_;
 wire _4255_;
 wire _4256_;
 wire _4257_;
 wire _4258_;
 wire _4259_;
 wire _4260_;
 wire _4261_;
 wire _4262_;
 wire _4263_;
 wire _4264_;
 wire _4265_;
 wire _4266_;
 wire _4267_;
 wire _4268_;
 wire _4269_;
 wire _4270_;
 wire _4271_;
 wire _4272_;
 wire _4273_;
 wire _4274_;
 wire _4275_;
 wire _4276_;
 wire _4277_;
 wire _4278_;
 wire _4280_;
 wire _4281_;
 wire _4282_;
 wire _4283_;
 wire _4284_;
 wire _4285_;
 wire _4286_;
 wire _4287_;
 wire _4288_;
 wire _4289_;
 wire _4290_;
 wire _4291_;
 wire _4292_;
 wire _4293_;
 wire _4294_;
 wire _4295_;
 wire _4297_;
 wire _4298_;
 wire _4299_;
 wire _4300_;
 wire _4301_;
 wire _4302_;
 wire _4303_;
 wire _4304_;
 wire _4305_;
 wire _4306_;
 wire _4308_;
 wire _4309_;
 wire _4310_;
 wire _4311_;
 wire _4312_;
 wire _4313_;
 wire _4315_;
 wire _4316_;
 wire _4317_;
 wire _4318_;
 wire _4319_;
 wire _4320_;
 wire _4322_;
 wire _4323_;
 wire _4324_;
 wire _4325_;
 wire _4326_;
 wire _4327_;
 wire _4328_;
 wire _4329_;
 wire _4330_;
 wire _4331_;
 wire _4332_;
 wire _4333_;
 wire _4334_;
 wire _4335_;
 wire _4336_;
 wire _4338_;
 wire _4339_;
 wire _4340_;
 wire _4341_;
 wire _4342_;
 wire _4343_;
 wire _4344_;
 wire _4346_;
 wire _4347_;
 wire _4348_;
 wire _4349_;
 wire _4350_;
 wire _4351_;
 wire _4352_;
 wire _4353_;
 wire _4354_;
 wire _4355_;
 wire _4356_;
 wire _4357_;
 wire _4358_;
 wire _4359_;
 wire _4360_;
 wire _4361_;
 wire _4362_;
 wire _4363_;
 wire _4364_;
 wire _4366_;
 wire _4367_;
 wire _4368_;
 wire _4369_;
 wire _4370_;
 wire _4371_;
 wire _4372_;
 wire _4373_;
 wire _4374_;
 wire _4375_;
 wire _4376_;
 wire _4377_;
 wire _4378_;
 wire _4379_;
 wire _4380_;
 wire _4381_;
 wire _4382_;
 wire _4383_;
 wire _4384_;
 wire _4385_;
 wire _4386_;
 wire _4387_;
 wire _4388_;
 wire _4389_;
 wire _4390_;
 wire _4391_;
 wire _4392_;
 wire _4393_;
 wire _4394_;
 wire _4395_;
 wire _4396_;
 wire _4397_;
 wire _4398_;
 wire _4399_;
 wire _4400_;
 wire _4401_;
 wire _4402_;
 wire _4403_;
 wire _4404_;
 wire _4405_;
 wire _4406_;
 wire _4407_;
 wire _4408_;
 wire _4409_;
 wire _4410_;
 wire _4411_;
 wire _4412_;
 wire _4413_;
 wire _4414_;
 wire _4415_;
 wire _4416_;
 wire _4417_;
 wire _4418_;
 wire _4419_;
 wire _4420_;
 wire _4421_;
 wire _4422_;
 wire _4423_;
 wire _4424_;
 wire _4425_;
 wire _4426_;
 wire _4427_;
 wire _4428_;
 wire _4429_;
 wire _4430_;
 wire _4431_;
 wire _4432_;
 wire _4433_;
 wire _4434_;
 wire _4435_;
 wire _4436_;
 wire _4437_;
 wire _4438_;
 wire _4439_;
 wire _4440_;
 wire _4441_;
 wire _4442_;
 wire _4443_;
 wire _4444_;
 wire _4445_;
 wire _4446_;
 wire _4447_;
 wire _4448_;
 wire _4449_;
 wire _4450_;
 wire _4451_;
 wire _4452_;
 wire _4453_;
 wire _4454_;
 wire _4455_;
 wire _4456_;
 wire _4457_;
 wire _4458_;
 wire _4459_;
 wire _4460_;
 wire _4461_;
 wire _4462_;
 wire _4463_;
 wire _4464_;
 wire _4465_;
 wire _4466_;
 wire _4467_;
 wire _4468_;
 wire _4469_;
 wire _4470_;
 wire _4471_;
 wire _4472_;
 wire _4473_;
 wire _4474_;
 wire _4475_;
 wire _4476_;
 wire _4477_;
 wire _4478_;
 wire _4479_;
 wire _4480_;
 wire _4481_;
 wire _4482_;
 wire _4483_;
 wire _4484_;
 wire _4485_;
 wire _4486_;
 wire _4487_;
 wire _4488_;
 wire _4489_;
 wire _4490_;
 wire _4491_;
 wire _4492_;
 wire _4493_;
 wire _4494_;
 wire _4495_;
 wire _4496_;
 wire _4497_;
 wire _4498_;
 wire _4499_;
 wire _4500_;
 wire _4501_;
 wire _4502_;
 wire _4503_;
 wire _4504_;
 wire _4505_;
 wire _4506_;
 wire _4507_;
 wire _4508_;
 wire _4509_;
 wire _4510_;
 wire _4511_;
 wire _4512_;
 wire _4513_;
 wire _4514_;
 wire _4515_;
 wire _4516_;
 wire _4517_;
 wire _4518_;
 wire _4519_;
 wire _4520_;
 wire _4521_;
 wire _4522_;
 wire _4523_;
 wire _4524_;
 wire _4525_;
 wire _4526_;
 wire _4527_;
 wire _4528_;
 wire _4529_;
 wire _4530_;
 wire _4531_;
 wire _4532_;
 wire _4533_;
 wire _4534_;
 wire _4535_;
 wire _4536_;
 wire _4537_;
 wire _4538_;
 wire _4539_;
 wire _4540_;
 wire _4541_;
 wire _4542_;
 wire _4543_;
 wire _4544_;
 wire _4545_;
 wire _4546_;
 wire _4547_;
 wire _4548_;
 wire _4549_;
 wire _4550_;
 wire _4551_;
 wire _4552_;
 wire _4553_;
 wire _4554_;
 wire _4555_;
 wire _4556_;
 wire _4557_;
 wire _4558_;
 wire _4559_;
 wire _4560_;
 wire _4561_;
 wire _4562_;
 wire _4563_;
 wire _4564_;
 wire _4565_;
 wire _4566_;
 wire _4567_;
 wire _4568_;
 wire _4569_;
 wire _4570_;
 wire _4571_;
 wire _4572_;
 wire _4573_;
 wire _4574_;
 wire _4575_;
 wire _4576_;
 wire _4577_;
 wire _4578_;
 wire _4579_;
 wire _4580_;
 wire _4581_;
 wire _4582_;
 wire _4583_;
 wire _4584_;
 wire _4585_;
 wire _4586_;
 wire _4587_;
 wire _4588_;
 wire _4589_;
 wire _4590_;
 wire _4591_;
 wire _4592_;
 wire _4593_;
 wire _4594_;
 wire _4595_;
 wire _4596_;
 wire _4597_;
 wire _4598_;
 wire _4599_;
 wire _4600_;
 wire _4601_;
 wire _4602_;
 wire _4603_;
 wire _4604_;
 wire _4605_;
 wire _4606_;
 wire _4607_;
 wire _4608_;
 wire _4609_;
 wire _4610_;
 wire _4611_;
 wire _4612_;
 wire _4613_;
 wire _4614_;
 wire _4615_;
 wire _4616_;
 wire _4617_;
 wire _4618_;
 wire _4619_;
 wire _4620_;
 wire _4621_;
 wire _4622_;
 wire _4623_;
 wire _4624_;
 wire _4625_;
 wire _4626_;
 wire _4627_;
 wire _4628_;
 wire _4629_;
 wire _4630_;
 wire _4631_;
 wire _4632_;
 wire _4633_;
 wire _4634_;
 wire _4635_;
 wire _4636_;
 wire _4637_;
 wire _4638_;
 wire _4639_;
 wire _4640_;
 wire _4641_;
 wire _4642_;
 wire _4643_;
 wire _4644_;
 wire _4645_;
 wire _4646_;
 wire _4647_;
 wire _4648_;
 wire _4649_;
 wire _4650_;
 wire _4651_;
 wire _4652_;
 wire _4653_;
 wire _4654_;
 wire _4655_;
 wire _4656_;
 wire _4657_;
 wire _4658_;
 wire _4659_;
 wire _4660_;
 wire _4661_;
 wire _4662_;
 wire _4663_;
 wire _4664_;
 wire _4665_;
 wire _4666_;
 wire _4667_;
 wire _4668_;
 wire _4669_;
 wire _4670_;
 wire _4671_;
 wire _4672_;
 wire _4673_;
 wire _4674_;
 wire _4675_;
 wire _4676_;
 wire _4677_;
 wire _4678_;
 wire _4679_;
 wire _4680_;
 wire _4681_;
 wire _4682_;
 wire _4683_;
 wire _4684_;
 wire _4685_;
 wire _4686_;
 wire _4687_;
 wire _4688_;
 wire _4689_;
 wire _4690_;
 wire _4691_;
 wire _4692_;
 wire _4693_;
 wire _4694_;
 wire _4695_;
 wire _4696_;
 wire _4697_;
 wire _4698_;
 wire _4699_;
 wire _4700_;
 wire _4701_;
 wire _4702_;
 wire _4703_;
 wire _4704_;
 wire _4705_;
 wire _4706_;
 wire _4707_;
 wire _4708_;
 wire _4709_;
 wire _4710_;
 wire _4711_;
 wire _4712_;
 wire _4713_;
 wire _4714_;
 wire _4715_;
 wire _4716_;
 wire _4717_;
 wire _4718_;
 wire _4719_;
 wire _4720_;
 wire _4721_;
 wire _4722_;
 wire _4723_;
 wire _4724_;
 wire _4725_;
 wire _4726_;
 wire _4727_;
 wire _4728_;
 wire _4729_;
 wire _4730_;
 wire _4731_;
 wire _4732_;
 wire _4733_;
 wire _4734_;
 wire _4735_;
 wire _4736_;
 wire _4737_;
 wire _4738_;
 wire _4739_;
 wire _4740_;
 wire _4741_;
 wire _4742_;
 wire _4743_;
 wire _4744_;
 wire _4745_;
 wire _4746_;
 wire _4747_;
 wire _4748_;
 wire _4749_;
 wire _4750_;
 wire _4751_;
 wire _4752_;
 wire _4753_;
 wire _4754_;
 wire \alu_add_sub[0] ;
 wire \alu_out[0] ;
 wire \alu_out[10] ;
 wire \alu_out[11] ;
 wire \alu_out[12] ;
 wire \alu_out[13] ;
 wire \alu_out[14] ;
 wire \alu_out[15] ;
 wire \alu_out[16] ;
 wire \alu_out[17] ;
 wire \alu_out[18] ;
 wire \alu_out[19] ;
 wire \alu_out[1] ;
 wire \alu_out[20] ;
 wire \alu_out[21] ;
 wire \alu_out[22] ;
 wire \alu_out[23] ;
 wire \alu_out[24] ;
 wire \alu_out[25] ;
 wire \alu_out[26] ;
 wire \alu_out[27] ;
 wire \alu_out[28] ;
 wire \alu_out[29] ;
 wire \alu_out[2] ;
 wire \alu_out[30] ;
 wire \alu_out[31] ;
 wire \alu_out[3] ;
 wire \alu_out[4] ;
 wire \alu_out[5] ;
 wire \alu_out[6] ;
 wire \alu_out[7] ;
 wire \alu_out[8] ;
 wire \alu_out[9] ;
 wire \alu_out_q[0] ;
 wire \alu_out_q[10] ;
 wire \alu_out_q[11] ;
 wire \alu_out_q[12] ;
 wire \alu_out_q[13] ;
 wire \alu_out_q[14] ;
 wire \alu_out_q[15] ;
 wire \alu_out_q[16] ;
 wire \alu_out_q[17] ;
 wire \alu_out_q[18] ;
 wire \alu_out_q[19] ;
 wire \alu_out_q[1] ;
 wire \alu_out_q[20] ;
 wire \alu_out_q[21] ;
 wire \alu_out_q[22] ;
 wire \alu_out_q[23] ;
 wire \alu_out_q[24] ;
 wire \alu_out_q[25] ;
 wire \alu_out_q[26] ;
 wire \alu_out_q[27] ;
 wire \alu_out_q[28] ;
 wire \alu_out_q[29] ;
 wire \alu_out_q[2] ;
 wire \alu_out_q[30] ;
 wire \alu_out_q[31] ;
 wire \alu_out_q[3] ;
 wire \alu_out_q[4] ;
 wire \alu_out_q[5] ;
 wire \alu_out_q[6] ;
 wire \alu_out_q[7] ;
 wire \alu_out_q[8] ;
 wire \alu_out_q[9] ;
 wire \count_cycle[0] ;
 wire \count_cycle[10] ;
 wire \count_cycle[11] ;
 wire \count_cycle[12] ;
 wire \count_cycle[13] ;
 wire \count_cycle[14] ;
 wire \count_cycle[15] ;
 wire \count_cycle[16] ;
 wire \count_cycle[17] ;
 wire \count_cycle[18] ;
 wire \count_cycle[19] ;
 wire \count_cycle[1] ;
 wire \count_cycle[20] ;
 wire \count_cycle[21] ;
 wire \count_cycle[22] ;
 wire \count_cycle[23] ;
 wire \count_cycle[24] ;
 wire \count_cycle[25] ;
 wire \count_cycle[26] ;
 wire \count_cycle[27] ;
 wire \count_cycle[28] ;
 wire \count_cycle[29] ;
 wire \count_cycle[2] ;
 wire \count_cycle[30] ;
 wire \count_cycle[31] ;
 wire \count_cycle[32] ;
 wire \count_cycle[33] ;
 wire \count_cycle[34] ;
 wire \count_cycle[35] ;
 wire \count_cycle[36] ;
 wire \count_cycle[37] ;
 wire \count_cycle[38] ;
 wire \count_cycle[39] ;
 wire \count_cycle[3] ;
 wire \count_cycle[40] ;
 wire \count_cycle[41] ;
 wire \count_cycle[42] ;
 wire \count_cycle[43] ;
 wire \count_cycle[44] ;
 wire \count_cycle[45] ;
 wire \count_cycle[46] ;
 wire \count_cycle[47] ;
 wire \count_cycle[48] ;
 wire \count_cycle[49] ;
 wire \count_cycle[4] ;
 wire \count_cycle[50] ;
 wire \count_cycle[51] ;
 wire \count_cycle[52] ;
 wire \count_cycle[53] ;
 wire \count_cycle[54] ;
 wire \count_cycle[55] ;
 wire \count_cycle[56] ;
 wire \count_cycle[57] ;
 wire \count_cycle[58] ;
 wire \count_cycle[59] ;
 wire \count_cycle[5] ;
 wire \count_cycle[60] ;
 wire \count_cycle[61] ;
 wire \count_cycle[62] ;
 wire \count_cycle[63] ;
 wire \count_cycle[6] ;
 wire \count_cycle[7] ;
 wire \count_cycle[8] ;
 wire \count_cycle[9] ;
 wire \count_instr[0] ;
 wire \count_instr[10] ;
 wire \count_instr[11] ;
 wire \count_instr[12] ;
 wire \count_instr[13] ;
 wire \count_instr[14] ;
 wire \count_instr[15] ;
 wire \count_instr[16] ;
 wire \count_instr[17] ;
 wire \count_instr[18] ;
 wire \count_instr[19] ;
 wire \count_instr[1] ;
 wire \count_instr[20] ;
 wire \count_instr[21] ;
 wire \count_instr[22] ;
 wire \count_instr[23] ;
 wire \count_instr[24] ;
 wire \count_instr[25] ;
 wire \count_instr[26] ;
 wire \count_instr[27] ;
 wire \count_instr[28] ;
 wire \count_instr[29] ;
 wire \count_instr[2] ;
 wire \count_instr[30] ;
 wire \count_instr[31] ;
 wire \count_instr[32] ;
 wire \count_instr[33] ;
 wire \count_instr[34] ;
 wire \count_instr[35] ;
 wire \count_instr[36] ;
 wire \count_instr[37] ;
 wire \count_instr[38] ;
 wire \count_instr[39] ;
 wire \count_instr[3] ;
 wire \count_instr[40] ;
 wire \count_instr[41] ;
 wire \count_instr[42] ;
 wire \count_instr[43] ;
 wire \count_instr[44] ;
 wire \count_instr[45] ;
 wire \count_instr[46] ;
 wire \count_instr[47] ;
 wire \count_instr[48] ;
 wire \count_instr[49] ;
 wire \count_instr[4] ;
 wire \count_instr[50] ;
 wire \count_instr[51] ;
 wire \count_instr[52] ;
 wire \count_instr[53] ;
 wire \count_instr[54] ;
 wire \count_instr[55] ;
 wire \count_instr[56] ;
 wire \count_instr[57] ;
 wire \count_instr[58] ;
 wire \count_instr[59] ;
 wire \count_instr[5] ;
 wire \count_instr[60] ;
 wire \count_instr[61] ;
 wire \count_instr[62] ;
 wire \count_instr[63] ;
 wire \count_instr[6] ;
 wire \count_instr[7] ;
 wire \count_instr[8] ;
 wire \count_instr[9] ;
 wire \cpu_state[0] ;
 wire \cpu_state[1] ;
 wire \cpu_state[2] ;
 wire \cpu_state[3] ;
 wire \cpu_state[4] ;
 wire \cpu_state[5] ;
 wire \cpu_state[6] ;
 wire \cpuregs[0][0] ;
 wire \cpuregs[0][10] ;
 wire \cpuregs[0][11] ;
 wire \cpuregs[0][12] ;
 wire \cpuregs[0][13] ;
 wire \cpuregs[0][14] ;
 wire \cpuregs[0][15] ;
 wire \cpuregs[0][16] ;
 wire \cpuregs[0][17] ;
 wire \cpuregs[0][18] ;
 wire \cpuregs[0][19] ;
 wire \cpuregs[0][1] ;
 wire \cpuregs[0][20] ;
 wire \cpuregs[0][21] ;
 wire \cpuregs[0][22] ;
 wire \cpuregs[0][23] ;
 wire \cpuregs[0][24] ;
 wire \cpuregs[0][25] ;
 wire \cpuregs[0][26] ;
 wire \cpuregs[0][27] ;
 wire \cpuregs[0][28] ;
 wire \cpuregs[0][29] ;
 wire \cpuregs[0][2] ;
 wire \cpuregs[0][30] ;
 wire \cpuregs[0][31] ;
 wire \cpuregs[0][3] ;
 wire \cpuregs[0][4] ;
 wire \cpuregs[0][5] ;
 wire \cpuregs[0][6] ;
 wire \cpuregs[0][7] ;
 wire \cpuregs[0][8] ;
 wire \cpuregs[0][9] ;
 wire \cpuregs[10][0] ;
 wire \cpuregs[10][10] ;
 wire \cpuregs[10][11] ;
 wire \cpuregs[10][12] ;
 wire \cpuregs[10][13] ;
 wire \cpuregs[10][14] ;
 wire \cpuregs[10][15] ;
 wire \cpuregs[10][16] ;
 wire \cpuregs[10][17] ;
 wire \cpuregs[10][18] ;
 wire \cpuregs[10][19] ;
 wire \cpuregs[10][1] ;
 wire \cpuregs[10][20] ;
 wire \cpuregs[10][21] ;
 wire \cpuregs[10][22] ;
 wire \cpuregs[10][23] ;
 wire \cpuregs[10][24] ;
 wire \cpuregs[10][25] ;
 wire \cpuregs[10][26] ;
 wire \cpuregs[10][27] ;
 wire \cpuregs[10][28] ;
 wire \cpuregs[10][29] ;
 wire \cpuregs[10][2] ;
 wire \cpuregs[10][30] ;
 wire \cpuregs[10][31] ;
 wire \cpuregs[10][3] ;
 wire \cpuregs[10][4] ;
 wire \cpuregs[10][5] ;
 wire \cpuregs[10][6] ;
 wire \cpuregs[10][7] ;
 wire \cpuregs[10][8] ;
 wire \cpuregs[10][9] ;
 wire \cpuregs[11][0] ;
 wire \cpuregs[11][10] ;
 wire \cpuregs[11][11] ;
 wire \cpuregs[11][12] ;
 wire \cpuregs[11][13] ;
 wire \cpuregs[11][14] ;
 wire \cpuregs[11][15] ;
 wire \cpuregs[11][16] ;
 wire \cpuregs[11][17] ;
 wire \cpuregs[11][18] ;
 wire \cpuregs[11][19] ;
 wire \cpuregs[11][1] ;
 wire \cpuregs[11][20] ;
 wire \cpuregs[11][21] ;
 wire \cpuregs[11][22] ;
 wire \cpuregs[11][23] ;
 wire \cpuregs[11][24] ;
 wire \cpuregs[11][25] ;
 wire \cpuregs[11][26] ;
 wire \cpuregs[11][27] ;
 wire \cpuregs[11][28] ;
 wire \cpuregs[11][29] ;
 wire \cpuregs[11][2] ;
 wire \cpuregs[11][30] ;
 wire \cpuregs[11][31] ;
 wire \cpuregs[11][3] ;
 wire \cpuregs[11][4] ;
 wire \cpuregs[11][5] ;
 wire \cpuregs[11][6] ;
 wire \cpuregs[11][7] ;
 wire \cpuregs[11][8] ;
 wire \cpuregs[11][9] ;
 wire \cpuregs[12][0] ;
 wire \cpuregs[12][10] ;
 wire \cpuregs[12][11] ;
 wire \cpuregs[12][12] ;
 wire \cpuregs[12][13] ;
 wire \cpuregs[12][14] ;
 wire \cpuregs[12][15] ;
 wire \cpuregs[12][16] ;
 wire \cpuregs[12][17] ;
 wire \cpuregs[12][18] ;
 wire \cpuregs[12][19] ;
 wire \cpuregs[12][1] ;
 wire \cpuregs[12][20] ;
 wire \cpuregs[12][21] ;
 wire \cpuregs[12][22] ;
 wire \cpuregs[12][23] ;
 wire \cpuregs[12][24] ;
 wire \cpuregs[12][25] ;
 wire \cpuregs[12][26] ;
 wire \cpuregs[12][27] ;
 wire \cpuregs[12][28] ;
 wire \cpuregs[12][29] ;
 wire \cpuregs[12][2] ;
 wire \cpuregs[12][30] ;
 wire \cpuregs[12][31] ;
 wire \cpuregs[12][3] ;
 wire \cpuregs[12][4] ;
 wire \cpuregs[12][5] ;
 wire \cpuregs[12][6] ;
 wire \cpuregs[12][7] ;
 wire \cpuregs[12][8] ;
 wire \cpuregs[12][9] ;
 wire \cpuregs[13][0] ;
 wire \cpuregs[13][10] ;
 wire \cpuregs[13][11] ;
 wire \cpuregs[13][12] ;
 wire \cpuregs[13][13] ;
 wire \cpuregs[13][14] ;
 wire \cpuregs[13][15] ;
 wire \cpuregs[13][16] ;
 wire \cpuregs[13][17] ;
 wire \cpuregs[13][18] ;
 wire \cpuregs[13][19] ;
 wire \cpuregs[13][1] ;
 wire \cpuregs[13][20] ;
 wire \cpuregs[13][21] ;
 wire \cpuregs[13][22] ;
 wire \cpuregs[13][23] ;
 wire \cpuregs[13][24] ;
 wire \cpuregs[13][25] ;
 wire \cpuregs[13][26] ;
 wire \cpuregs[13][27] ;
 wire \cpuregs[13][28] ;
 wire \cpuregs[13][29] ;
 wire \cpuregs[13][2] ;
 wire \cpuregs[13][30] ;
 wire \cpuregs[13][31] ;
 wire \cpuregs[13][3] ;
 wire \cpuregs[13][4] ;
 wire \cpuregs[13][5] ;
 wire \cpuregs[13][6] ;
 wire \cpuregs[13][7] ;
 wire \cpuregs[13][8] ;
 wire \cpuregs[13][9] ;
 wire \cpuregs[14][0] ;
 wire \cpuregs[14][10] ;
 wire \cpuregs[14][11] ;
 wire \cpuregs[14][12] ;
 wire \cpuregs[14][13] ;
 wire \cpuregs[14][14] ;
 wire \cpuregs[14][15] ;
 wire \cpuregs[14][16] ;
 wire \cpuregs[14][17] ;
 wire \cpuregs[14][18] ;
 wire \cpuregs[14][19] ;
 wire \cpuregs[14][1] ;
 wire \cpuregs[14][20] ;
 wire \cpuregs[14][21] ;
 wire \cpuregs[14][22] ;
 wire \cpuregs[14][23] ;
 wire \cpuregs[14][24] ;
 wire \cpuregs[14][25] ;
 wire \cpuregs[14][26] ;
 wire \cpuregs[14][27] ;
 wire \cpuregs[14][28] ;
 wire \cpuregs[14][29] ;
 wire \cpuregs[14][2] ;
 wire \cpuregs[14][30] ;
 wire \cpuregs[14][31] ;
 wire \cpuregs[14][3] ;
 wire \cpuregs[14][4] ;
 wire \cpuregs[14][5] ;
 wire \cpuregs[14][6] ;
 wire \cpuregs[14][7] ;
 wire \cpuregs[14][8] ;
 wire \cpuregs[14][9] ;
 wire \cpuregs[15][0] ;
 wire \cpuregs[15][10] ;
 wire \cpuregs[15][11] ;
 wire \cpuregs[15][12] ;
 wire \cpuregs[15][13] ;
 wire \cpuregs[15][14] ;
 wire \cpuregs[15][15] ;
 wire \cpuregs[15][16] ;
 wire \cpuregs[15][17] ;
 wire \cpuregs[15][18] ;
 wire \cpuregs[15][19] ;
 wire \cpuregs[15][1] ;
 wire \cpuregs[15][20] ;
 wire \cpuregs[15][21] ;
 wire \cpuregs[15][22] ;
 wire \cpuregs[15][23] ;
 wire \cpuregs[15][24] ;
 wire \cpuregs[15][25] ;
 wire \cpuregs[15][26] ;
 wire \cpuregs[15][27] ;
 wire \cpuregs[15][28] ;
 wire \cpuregs[15][29] ;
 wire \cpuregs[15][2] ;
 wire \cpuregs[15][30] ;
 wire \cpuregs[15][31] ;
 wire \cpuregs[15][3] ;
 wire \cpuregs[15][4] ;
 wire \cpuregs[15][5] ;
 wire \cpuregs[15][6] ;
 wire \cpuregs[15][7] ;
 wire \cpuregs[15][8] ;
 wire \cpuregs[15][9] ;
 wire \cpuregs[16][0] ;
 wire \cpuregs[16][10] ;
 wire \cpuregs[16][11] ;
 wire \cpuregs[16][12] ;
 wire \cpuregs[16][13] ;
 wire \cpuregs[16][14] ;
 wire \cpuregs[16][15] ;
 wire \cpuregs[16][16] ;
 wire \cpuregs[16][17] ;
 wire \cpuregs[16][18] ;
 wire \cpuregs[16][19] ;
 wire \cpuregs[16][1] ;
 wire \cpuregs[16][20] ;
 wire \cpuregs[16][21] ;
 wire \cpuregs[16][22] ;
 wire \cpuregs[16][23] ;
 wire \cpuregs[16][24] ;
 wire \cpuregs[16][25] ;
 wire \cpuregs[16][26] ;
 wire \cpuregs[16][27] ;
 wire \cpuregs[16][28] ;
 wire \cpuregs[16][29] ;
 wire \cpuregs[16][2] ;
 wire \cpuregs[16][30] ;
 wire \cpuregs[16][31] ;
 wire \cpuregs[16][3] ;
 wire \cpuregs[16][4] ;
 wire \cpuregs[16][5] ;
 wire \cpuregs[16][6] ;
 wire \cpuregs[16][7] ;
 wire \cpuregs[16][8] ;
 wire \cpuregs[16][9] ;
 wire \cpuregs[17][0] ;
 wire \cpuregs[17][10] ;
 wire \cpuregs[17][11] ;
 wire \cpuregs[17][12] ;
 wire \cpuregs[17][13] ;
 wire \cpuregs[17][14] ;
 wire \cpuregs[17][15] ;
 wire \cpuregs[17][16] ;
 wire \cpuregs[17][17] ;
 wire \cpuregs[17][18] ;
 wire \cpuregs[17][19] ;
 wire \cpuregs[17][1] ;
 wire \cpuregs[17][20] ;
 wire \cpuregs[17][21] ;
 wire \cpuregs[17][22] ;
 wire \cpuregs[17][23] ;
 wire \cpuregs[17][24] ;
 wire \cpuregs[17][25] ;
 wire \cpuregs[17][26] ;
 wire \cpuregs[17][27] ;
 wire \cpuregs[17][28] ;
 wire \cpuregs[17][29] ;
 wire \cpuregs[17][2] ;
 wire \cpuregs[17][30] ;
 wire \cpuregs[17][31] ;
 wire \cpuregs[17][3] ;
 wire \cpuregs[17][4] ;
 wire \cpuregs[17][5] ;
 wire \cpuregs[17][6] ;
 wire \cpuregs[17][7] ;
 wire \cpuregs[17][8] ;
 wire \cpuregs[17][9] ;
 wire \cpuregs[18][0] ;
 wire \cpuregs[18][10] ;
 wire \cpuregs[18][11] ;
 wire \cpuregs[18][12] ;
 wire \cpuregs[18][13] ;
 wire \cpuregs[18][14] ;
 wire \cpuregs[18][15] ;
 wire \cpuregs[18][16] ;
 wire \cpuregs[18][17] ;
 wire \cpuregs[18][18] ;
 wire \cpuregs[18][19] ;
 wire \cpuregs[18][1] ;
 wire \cpuregs[18][20] ;
 wire \cpuregs[18][21] ;
 wire \cpuregs[18][22] ;
 wire \cpuregs[18][23] ;
 wire \cpuregs[18][24] ;
 wire \cpuregs[18][25] ;
 wire \cpuregs[18][26] ;
 wire \cpuregs[18][27] ;
 wire \cpuregs[18][28] ;
 wire \cpuregs[18][29] ;
 wire \cpuregs[18][2] ;
 wire \cpuregs[18][30] ;
 wire \cpuregs[18][31] ;
 wire \cpuregs[18][3] ;
 wire \cpuregs[18][4] ;
 wire \cpuregs[18][5] ;
 wire \cpuregs[18][6] ;
 wire \cpuregs[18][7] ;
 wire \cpuregs[18][8] ;
 wire \cpuregs[18][9] ;
 wire \cpuregs[19][0] ;
 wire \cpuregs[19][10] ;
 wire \cpuregs[19][11] ;
 wire \cpuregs[19][12] ;
 wire \cpuregs[19][13] ;
 wire \cpuregs[19][14] ;
 wire \cpuregs[19][15] ;
 wire \cpuregs[19][16] ;
 wire \cpuregs[19][17] ;
 wire \cpuregs[19][18] ;
 wire \cpuregs[19][19] ;
 wire \cpuregs[19][1] ;
 wire \cpuregs[19][20] ;
 wire \cpuregs[19][21] ;
 wire \cpuregs[19][22] ;
 wire \cpuregs[19][23] ;
 wire \cpuregs[19][24] ;
 wire \cpuregs[19][25] ;
 wire \cpuregs[19][26] ;
 wire \cpuregs[19][27] ;
 wire \cpuregs[19][28] ;
 wire \cpuregs[19][29] ;
 wire \cpuregs[19][2] ;
 wire \cpuregs[19][30] ;
 wire \cpuregs[19][31] ;
 wire \cpuregs[19][3] ;
 wire \cpuregs[19][4] ;
 wire \cpuregs[19][5] ;
 wire \cpuregs[19][6] ;
 wire \cpuregs[19][7] ;
 wire \cpuregs[19][8] ;
 wire \cpuregs[19][9] ;
 wire \cpuregs[1][0] ;
 wire \cpuregs[1][10] ;
 wire \cpuregs[1][11] ;
 wire \cpuregs[1][12] ;
 wire \cpuregs[1][13] ;
 wire \cpuregs[1][14] ;
 wire \cpuregs[1][15] ;
 wire \cpuregs[1][16] ;
 wire \cpuregs[1][17] ;
 wire \cpuregs[1][18] ;
 wire \cpuregs[1][19] ;
 wire \cpuregs[1][1] ;
 wire \cpuregs[1][20] ;
 wire \cpuregs[1][21] ;
 wire \cpuregs[1][22] ;
 wire \cpuregs[1][23] ;
 wire \cpuregs[1][24] ;
 wire \cpuregs[1][25] ;
 wire \cpuregs[1][26] ;
 wire \cpuregs[1][27] ;
 wire \cpuregs[1][28] ;
 wire \cpuregs[1][29] ;
 wire \cpuregs[1][2] ;
 wire \cpuregs[1][30] ;
 wire \cpuregs[1][31] ;
 wire \cpuregs[1][3] ;
 wire \cpuregs[1][4] ;
 wire \cpuregs[1][5] ;
 wire \cpuregs[1][6] ;
 wire \cpuregs[1][7] ;
 wire \cpuregs[1][8] ;
 wire \cpuregs[1][9] ;
 wire \cpuregs[20][0] ;
 wire \cpuregs[20][10] ;
 wire \cpuregs[20][11] ;
 wire \cpuregs[20][12] ;
 wire \cpuregs[20][13] ;
 wire \cpuregs[20][14] ;
 wire \cpuregs[20][15] ;
 wire \cpuregs[20][16] ;
 wire \cpuregs[20][17] ;
 wire \cpuregs[20][18] ;
 wire \cpuregs[20][19] ;
 wire \cpuregs[20][1] ;
 wire \cpuregs[20][20] ;
 wire \cpuregs[20][21] ;
 wire \cpuregs[20][22] ;
 wire \cpuregs[20][23] ;
 wire \cpuregs[20][24] ;
 wire \cpuregs[20][25] ;
 wire \cpuregs[20][26] ;
 wire \cpuregs[20][27] ;
 wire \cpuregs[20][28] ;
 wire \cpuregs[20][29] ;
 wire \cpuregs[20][2] ;
 wire \cpuregs[20][30] ;
 wire \cpuregs[20][31] ;
 wire \cpuregs[20][3] ;
 wire \cpuregs[20][4] ;
 wire \cpuregs[20][5] ;
 wire \cpuregs[20][6] ;
 wire \cpuregs[20][7] ;
 wire \cpuregs[20][8] ;
 wire \cpuregs[20][9] ;
 wire \cpuregs[21][0] ;
 wire \cpuregs[21][10] ;
 wire \cpuregs[21][11] ;
 wire \cpuregs[21][12] ;
 wire \cpuregs[21][13] ;
 wire \cpuregs[21][14] ;
 wire \cpuregs[21][15] ;
 wire \cpuregs[21][16] ;
 wire \cpuregs[21][17] ;
 wire \cpuregs[21][18] ;
 wire \cpuregs[21][19] ;
 wire \cpuregs[21][1] ;
 wire \cpuregs[21][20] ;
 wire \cpuregs[21][21] ;
 wire \cpuregs[21][22] ;
 wire \cpuregs[21][23] ;
 wire \cpuregs[21][24] ;
 wire \cpuregs[21][25] ;
 wire \cpuregs[21][26] ;
 wire \cpuregs[21][27] ;
 wire \cpuregs[21][28] ;
 wire \cpuregs[21][29] ;
 wire \cpuregs[21][2] ;
 wire \cpuregs[21][30] ;
 wire \cpuregs[21][31] ;
 wire \cpuregs[21][3] ;
 wire \cpuregs[21][4] ;
 wire \cpuregs[21][5] ;
 wire \cpuregs[21][6] ;
 wire \cpuregs[21][7] ;
 wire \cpuregs[21][8] ;
 wire \cpuregs[21][9] ;
 wire \cpuregs[22][0] ;
 wire \cpuregs[22][10] ;
 wire \cpuregs[22][11] ;
 wire \cpuregs[22][12] ;
 wire \cpuregs[22][13] ;
 wire \cpuregs[22][14] ;
 wire \cpuregs[22][15] ;
 wire \cpuregs[22][16] ;
 wire \cpuregs[22][17] ;
 wire \cpuregs[22][18] ;
 wire \cpuregs[22][19] ;
 wire \cpuregs[22][1] ;
 wire \cpuregs[22][20] ;
 wire \cpuregs[22][21] ;
 wire \cpuregs[22][22] ;
 wire \cpuregs[22][23] ;
 wire \cpuregs[22][24] ;
 wire \cpuregs[22][25] ;
 wire \cpuregs[22][26] ;
 wire \cpuregs[22][27] ;
 wire \cpuregs[22][28] ;
 wire \cpuregs[22][29] ;
 wire \cpuregs[22][2] ;
 wire \cpuregs[22][30] ;
 wire \cpuregs[22][31] ;
 wire \cpuregs[22][3] ;
 wire \cpuregs[22][4] ;
 wire \cpuregs[22][5] ;
 wire \cpuregs[22][6] ;
 wire \cpuregs[22][7] ;
 wire \cpuregs[22][8] ;
 wire \cpuregs[22][9] ;
 wire \cpuregs[23][0] ;
 wire \cpuregs[23][10] ;
 wire \cpuregs[23][11] ;
 wire \cpuregs[23][12] ;
 wire \cpuregs[23][13] ;
 wire \cpuregs[23][14] ;
 wire \cpuregs[23][15] ;
 wire \cpuregs[23][16] ;
 wire \cpuregs[23][17] ;
 wire \cpuregs[23][18] ;
 wire \cpuregs[23][19] ;
 wire \cpuregs[23][1] ;
 wire \cpuregs[23][20] ;
 wire \cpuregs[23][21] ;
 wire \cpuregs[23][22] ;
 wire \cpuregs[23][23] ;
 wire \cpuregs[23][24] ;
 wire \cpuregs[23][25] ;
 wire \cpuregs[23][26] ;
 wire \cpuregs[23][27] ;
 wire \cpuregs[23][28] ;
 wire \cpuregs[23][29] ;
 wire \cpuregs[23][2] ;
 wire \cpuregs[23][30] ;
 wire \cpuregs[23][31] ;
 wire \cpuregs[23][3] ;
 wire \cpuregs[23][4] ;
 wire \cpuregs[23][5] ;
 wire \cpuregs[23][6] ;
 wire \cpuregs[23][7] ;
 wire \cpuregs[23][8] ;
 wire \cpuregs[23][9] ;
 wire \cpuregs[24][0] ;
 wire \cpuregs[24][10] ;
 wire \cpuregs[24][11] ;
 wire \cpuregs[24][12] ;
 wire \cpuregs[24][13] ;
 wire \cpuregs[24][14] ;
 wire \cpuregs[24][15] ;
 wire \cpuregs[24][16] ;
 wire \cpuregs[24][17] ;
 wire \cpuregs[24][18] ;
 wire \cpuregs[24][19] ;
 wire \cpuregs[24][1] ;
 wire \cpuregs[24][20] ;
 wire \cpuregs[24][21] ;
 wire \cpuregs[24][22] ;
 wire \cpuregs[24][23] ;
 wire \cpuregs[24][24] ;
 wire \cpuregs[24][25] ;
 wire \cpuregs[24][26] ;
 wire \cpuregs[24][27] ;
 wire \cpuregs[24][28] ;
 wire \cpuregs[24][29] ;
 wire \cpuregs[24][2] ;
 wire \cpuregs[24][30] ;
 wire \cpuregs[24][31] ;
 wire \cpuregs[24][3] ;
 wire \cpuregs[24][4] ;
 wire \cpuregs[24][5] ;
 wire \cpuregs[24][6] ;
 wire \cpuregs[24][7] ;
 wire \cpuregs[24][8] ;
 wire \cpuregs[24][9] ;
 wire \cpuregs[25][0] ;
 wire \cpuregs[25][10] ;
 wire \cpuregs[25][11] ;
 wire \cpuregs[25][12] ;
 wire \cpuregs[25][13] ;
 wire \cpuregs[25][14] ;
 wire \cpuregs[25][15] ;
 wire \cpuregs[25][16] ;
 wire \cpuregs[25][17] ;
 wire \cpuregs[25][18] ;
 wire \cpuregs[25][19] ;
 wire \cpuregs[25][1] ;
 wire \cpuregs[25][20] ;
 wire \cpuregs[25][21] ;
 wire \cpuregs[25][22] ;
 wire \cpuregs[25][23] ;
 wire \cpuregs[25][24] ;
 wire \cpuregs[25][25] ;
 wire \cpuregs[25][26] ;
 wire \cpuregs[25][27] ;
 wire \cpuregs[25][28] ;
 wire \cpuregs[25][29] ;
 wire \cpuregs[25][2] ;
 wire \cpuregs[25][30] ;
 wire \cpuregs[25][31] ;
 wire \cpuregs[25][3] ;
 wire \cpuregs[25][4] ;
 wire \cpuregs[25][5] ;
 wire \cpuregs[25][6] ;
 wire \cpuregs[25][7] ;
 wire \cpuregs[25][8] ;
 wire \cpuregs[25][9] ;
 wire \cpuregs[26][0] ;
 wire \cpuregs[26][10] ;
 wire \cpuregs[26][11] ;
 wire \cpuregs[26][12] ;
 wire \cpuregs[26][13] ;
 wire \cpuregs[26][14] ;
 wire \cpuregs[26][15] ;
 wire \cpuregs[26][16] ;
 wire \cpuregs[26][17] ;
 wire \cpuregs[26][18] ;
 wire \cpuregs[26][19] ;
 wire \cpuregs[26][1] ;
 wire \cpuregs[26][20] ;
 wire \cpuregs[26][21] ;
 wire \cpuregs[26][22] ;
 wire \cpuregs[26][23] ;
 wire \cpuregs[26][24] ;
 wire \cpuregs[26][25] ;
 wire \cpuregs[26][26] ;
 wire \cpuregs[26][27] ;
 wire \cpuregs[26][28] ;
 wire \cpuregs[26][29] ;
 wire \cpuregs[26][2] ;
 wire \cpuregs[26][30] ;
 wire \cpuregs[26][31] ;
 wire \cpuregs[26][3] ;
 wire \cpuregs[26][4] ;
 wire \cpuregs[26][5] ;
 wire \cpuregs[26][6] ;
 wire \cpuregs[26][7] ;
 wire \cpuregs[26][8] ;
 wire \cpuregs[26][9] ;
 wire \cpuregs[27][0] ;
 wire \cpuregs[27][10] ;
 wire \cpuregs[27][11] ;
 wire \cpuregs[27][12] ;
 wire \cpuregs[27][13] ;
 wire \cpuregs[27][14] ;
 wire \cpuregs[27][15] ;
 wire \cpuregs[27][16] ;
 wire \cpuregs[27][17] ;
 wire \cpuregs[27][18] ;
 wire \cpuregs[27][19] ;
 wire \cpuregs[27][1] ;
 wire \cpuregs[27][20] ;
 wire \cpuregs[27][21] ;
 wire \cpuregs[27][22] ;
 wire \cpuregs[27][23] ;
 wire \cpuregs[27][24] ;
 wire \cpuregs[27][25] ;
 wire \cpuregs[27][26] ;
 wire \cpuregs[27][27] ;
 wire \cpuregs[27][28] ;
 wire \cpuregs[27][29] ;
 wire \cpuregs[27][2] ;
 wire \cpuregs[27][30] ;
 wire \cpuregs[27][31] ;
 wire \cpuregs[27][3] ;
 wire \cpuregs[27][4] ;
 wire \cpuregs[27][5] ;
 wire \cpuregs[27][6] ;
 wire \cpuregs[27][7] ;
 wire \cpuregs[27][8] ;
 wire \cpuregs[27][9] ;
 wire \cpuregs[28][0] ;
 wire \cpuregs[28][10] ;
 wire \cpuregs[28][11] ;
 wire \cpuregs[28][12] ;
 wire \cpuregs[28][13] ;
 wire \cpuregs[28][14] ;
 wire \cpuregs[28][15] ;
 wire \cpuregs[28][16] ;
 wire \cpuregs[28][17] ;
 wire \cpuregs[28][18] ;
 wire \cpuregs[28][19] ;
 wire \cpuregs[28][1] ;
 wire \cpuregs[28][20] ;
 wire \cpuregs[28][21] ;
 wire \cpuregs[28][22] ;
 wire \cpuregs[28][23] ;
 wire \cpuregs[28][24] ;
 wire \cpuregs[28][25] ;
 wire \cpuregs[28][26] ;
 wire \cpuregs[28][27] ;
 wire \cpuregs[28][28] ;
 wire \cpuregs[28][29] ;
 wire \cpuregs[28][2] ;
 wire \cpuregs[28][30] ;
 wire \cpuregs[28][31] ;
 wire \cpuregs[28][3] ;
 wire \cpuregs[28][4] ;
 wire \cpuregs[28][5] ;
 wire \cpuregs[28][6] ;
 wire \cpuregs[28][7] ;
 wire \cpuregs[28][8] ;
 wire \cpuregs[28][9] ;
 wire \cpuregs[29][0] ;
 wire \cpuregs[29][10] ;
 wire \cpuregs[29][11] ;
 wire \cpuregs[29][12] ;
 wire \cpuregs[29][13] ;
 wire \cpuregs[29][14] ;
 wire \cpuregs[29][15] ;
 wire \cpuregs[29][16] ;
 wire \cpuregs[29][17] ;
 wire \cpuregs[29][18] ;
 wire \cpuregs[29][19] ;
 wire \cpuregs[29][1] ;
 wire \cpuregs[29][20] ;
 wire \cpuregs[29][21] ;
 wire \cpuregs[29][22] ;
 wire \cpuregs[29][23] ;
 wire \cpuregs[29][24] ;
 wire \cpuregs[29][25] ;
 wire \cpuregs[29][26] ;
 wire \cpuregs[29][27] ;
 wire \cpuregs[29][28] ;
 wire \cpuregs[29][29] ;
 wire \cpuregs[29][2] ;
 wire \cpuregs[29][30] ;
 wire \cpuregs[29][31] ;
 wire \cpuregs[29][3] ;
 wire \cpuregs[29][4] ;
 wire \cpuregs[29][5] ;
 wire \cpuregs[29][6] ;
 wire \cpuregs[29][7] ;
 wire \cpuregs[29][8] ;
 wire \cpuregs[29][9] ;
 wire \cpuregs[2][0] ;
 wire \cpuregs[2][10] ;
 wire \cpuregs[2][11] ;
 wire \cpuregs[2][12] ;
 wire \cpuregs[2][13] ;
 wire \cpuregs[2][14] ;
 wire \cpuregs[2][15] ;
 wire \cpuregs[2][16] ;
 wire \cpuregs[2][17] ;
 wire \cpuregs[2][18] ;
 wire \cpuregs[2][19] ;
 wire \cpuregs[2][1] ;
 wire \cpuregs[2][20] ;
 wire \cpuregs[2][21] ;
 wire \cpuregs[2][22] ;
 wire \cpuregs[2][23] ;
 wire \cpuregs[2][24] ;
 wire \cpuregs[2][25] ;
 wire \cpuregs[2][26] ;
 wire \cpuregs[2][27] ;
 wire \cpuregs[2][28] ;
 wire \cpuregs[2][29] ;
 wire \cpuregs[2][2] ;
 wire \cpuregs[2][30] ;
 wire \cpuregs[2][31] ;
 wire \cpuregs[2][3] ;
 wire \cpuregs[2][4] ;
 wire \cpuregs[2][5] ;
 wire \cpuregs[2][6] ;
 wire \cpuregs[2][7] ;
 wire \cpuregs[2][8] ;
 wire \cpuregs[2][9] ;
 wire \cpuregs[30][0] ;
 wire \cpuregs[30][10] ;
 wire \cpuregs[30][11] ;
 wire \cpuregs[30][12] ;
 wire \cpuregs[30][13] ;
 wire \cpuregs[30][14] ;
 wire \cpuregs[30][15] ;
 wire \cpuregs[30][16] ;
 wire \cpuregs[30][17] ;
 wire \cpuregs[30][18] ;
 wire \cpuregs[30][19] ;
 wire \cpuregs[30][1] ;
 wire \cpuregs[30][20] ;
 wire \cpuregs[30][21] ;
 wire \cpuregs[30][22] ;
 wire \cpuregs[30][23] ;
 wire \cpuregs[30][24] ;
 wire \cpuregs[30][25] ;
 wire \cpuregs[30][26] ;
 wire \cpuregs[30][27] ;
 wire \cpuregs[30][28] ;
 wire \cpuregs[30][29] ;
 wire \cpuregs[30][2] ;
 wire \cpuregs[30][30] ;
 wire \cpuregs[30][31] ;
 wire \cpuregs[30][3] ;
 wire \cpuregs[30][4] ;
 wire \cpuregs[30][5] ;
 wire \cpuregs[30][6] ;
 wire \cpuregs[30][7] ;
 wire \cpuregs[30][8] ;
 wire \cpuregs[30][9] ;
 wire \cpuregs[31][0] ;
 wire \cpuregs[31][10] ;
 wire \cpuregs[31][11] ;
 wire \cpuregs[31][12] ;
 wire \cpuregs[31][13] ;
 wire \cpuregs[31][14] ;
 wire \cpuregs[31][15] ;
 wire \cpuregs[31][16] ;
 wire \cpuregs[31][17] ;
 wire \cpuregs[31][18] ;
 wire \cpuregs[31][19] ;
 wire \cpuregs[31][1] ;
 wire \cpuregs[31][20] ;
 wire \cpuregs[31][21] ;
 wire \cpuregs[31][22] ;
 wire \cpuregs[31][23] ;
 wire \cpuregs[31][24] ;
 wire \cpuregs[31][25] ;
 wire \cpuregs[31][26] ;
 wire \cpuregs[31][27] ;
 wire \cpuregs[31][28] ;
 wire \cpuregs[31][29] ;
 wire \cpuregs[31][2] ;
 wire \cpuregs[31][30] ;
 wire \cpuregs[31][31] ;
 wire \cpuregs[31][3] ;
 wire \cpuregs[31][4] ;
 wire \cpuregs[31][5] ;
 wire \cpuregs[31][6] ;
 wire \cpuregs[31][7] ;
 wire \cpuregs[31][8] ;
 wire \cpuregs[31][9] ;
 wire \cpuregs[3][0] ;
 wire \cpuregs[3][10] ;
 wire \cpuregs[3][11] ;
 wire \cpuregs[3][12] ;
 wire \cpuregs[3][13] ;
 wire \cpuregs[3][14] ;
 wire \cpuregs[3][15] ;
 wire \cpuregs[3][16] ;
 wire \cpuregs[3][17] ;
 wire \cpuregs[3][18] ;
 wire \cpuregs[3][19] ;
 wire \cpuregs[3][1] ;
 wire \cpuregs[3][20] ;
 wire \cpuregs[3][21] ;
 wire \cpuregs[3][22] ;
 wire \cpuregs[3][23] ;
 wire \cpuregs[3][24] ;
 wire \cpuregs[3][25] ;
 wire \cpuregs[3][26] ;
 wire \cpuregs[3][27] ;
 wire \cpuregs[3][28] ;
 wire \cpuregs[3][29] ;
 wire \cpuregs[3][2] ;
 wire \cpuregs[3][30] ;
 wire \cpuregs[3][31] ;
 wire \cpuregs[3][3] ;
 wire \cpuregs[3][4] ;
 wire \cpuregs[3][5] ;
 wire \cpuregs[3][6] ;
 wire \cpuregs[3][7] ;
 wire \cpuregs[3][8] ;
 wire \cpuregs[3][9] ;
 wire \cpuregs[4][0] ;
 wire \cpuregs[4][10] ;
 wire \cpuregs[4][11] ;
 wire \cpuregs[4][12] ;
 wire \cpuregs[4][13] ;
 wire \cpuregs[4][14] ;
 wire \cpuregs[4][15] ;
 wire \cpuregs[4][16] ;
 wire \cpuregs[4][17] ;
 wire \cpuregs[4][18] ;
 wire \cpuregs[4][19] ;
 wire \cpuregs[4][1] ;
 wire \cpuregs[4][20] ;
 wire \cpuregs[4][21] ;
 wire \cpuregs[4][22] ;
 wire \cpuregs[4][23] ;
 wire \cpuregs[4][24] ;
 wire \cpuregs[4][25] ;
 wire \cpuregs[4][26] ;
 wire \cpuregs[4][27] ;
 wire \cpuregs[4][28] ;
 wire \cpuregs[4][29] ;
 wire \cpuregs[4][2] ;
 wire \cpuregs[4][30] ;
 wire \cpuregs[4][31] ;
 wire \cpuregs[4][3] ;
 wire \cpuregs[4][4] ;
 wire \cpuregs[4][5] ;
 wire \cpuregs[4][6] ;
 wire \cpuregs[4][7] ;
 wire \cpuregs[4][8] ;
 wire \cpuregs[4][9] ;
 wire \cpuregs[5][0] ;
 wire \cpuregs[5][10] ;
 wire \cpuregs[5][11] ;
 wire \cpuregs[5][12] ;
 wire \cpuregs[5][13] ;
 wire \cpuregs[5][14] ;
 wire \cpuregs[5][15] ;
 wire \cpuregs[5][16] ;
 wire \cpuregs[5][17] ;
 wire \cpuregs[5][18] ;
 wire \cpuregs[5][19] ;
 wire \cpuregs[5][1] ;
 wire \cpuregs[5][20] ;
 wire \cpuregs[5][21] ;
 wire \cpuregs[5][22] ;
 wire \cpuregs[5][23] ;
 wire \cpuregs[5][24] ;
 wire \cpuregs[5][25] ;
 wire \cpuregs[5][26] ;
 wire \cpuregs[5][27] ;
 wire \cpuregs[5][28] ;
 wire \cpuregs[5][29] ;
 wire \cpuregs[5][2] ;
 wire \cpuregs[5][30] ;
 wire \cpuregs[5][31] ;
 wire \cpuregs[5][3] ;
 wire \cpuregs[5][4] ;
 wire \cpuregs[5][5] ;
 wire \cpuregs[5][6] ;
 wire \cpuregs[5][7] ;
 wire \cpuregs[5][8] ;
 wire \cpuregs[5][9] ;
 wire \cpuregs[6][0] ;
 wire \cpuregs[6][10] ;
 wire \cpuregs[6][11] ;
 wire \cpuregs[6][12] ;
 wire \cpuregs[6][13] ;
 wire \cpuregs[6][14] ;
 wire \cpuregs[6][15] ;
 wire \cpuregs[6][16] ;
 wire \cpuregs[6][17] ;
 wire \cpuregs[6][18] ;
 wire \cpuregs[6][19] ;
 wire \cpuregs[6][1] ;
 wire \cpuregs[6][20] ;
 wire \cpuregs[6][21] ;
 wire \cpuregs[6][22] ;
 wire \cpuregs[6][23] ;
 wire \cpuregs[6][24] ;
 wire \cpuregs[6][25] ;
 wire \cpuregs[6][26] ;
 wire \cpuregs[6][27] ;
 wire \cpuregs[6][28] ;
 wire \cpuregs[6][29] ;
 wire \cpuregs[6][2] ;
 wire \cpuregs[6][30] ;
 wire \cpuregs[6][31] ;
 wire \cpuregs[6][3] ;
 wire \cpuregs[6][4] ;
 wire \cpuregs[6][5] ;
 wire \cpuregs[6][6] ;
 wire \cpuregs[6][7] ;
 wire \cpuregs[6][8] ;
 wire \cpuregs[6][9] ;
 wire \cpuregs[7][0] ;
 wire \cpuregs[7][10] ;
 wire \cpuregs[7][11] ;
 wire \cpuregs[7][12] ;
 wire \cpuregs[7][13] ;
 wire \cpuregs[7][14] ;
 wire \cpuregs[7][15] ;
 wire \cpuregs[7][16] ;
 wire \cpuregs[7][17] ;
 wire \cpuregs[7][18] ;
 wire \cpuregs[7][19] ;
 wire \cpuregs[7][1] ;
 wire \cpuregs[7][20] ;
 wire \cpuregs[7][21] ;
 wire \cpuregs[7][22] ;
 wire \cpuregs[7][23] ;
 wire \cpuregs[7][24] ;
 wire \cpuregs[7][25] ;
 wire \cpuregs[7][26] ;
 wire \cpuregs[7][27] ;
 wire \cpuregs[7][28] ;
 wire \cpuregs[7][29] ;
 wire \cpuregs[7][2] ;
 wire \cpuregs[7][30] ;
 wire \cpuregs[7][31] ;
 wire \cpuregs[7][3] ;
 wire \cpuregs[7][4] ;
 wire \cpuregs[7][5] ;
 wire \cpuregs[7][6] ;
 wire \cpuregs[7][7] ;
 wire \cpuregs[7][8] ;
 wire \cpuregs[7][9] ;
 wire \cpuregs[8][0] ;
 wire \cpuregs[8][10] ;
 wire \cpuregs[8][11] ;
 wire \cpuregs[8][12] ;
 wire \cpuregs[8][13] ;
 wire \cpuregs[8][14] ;
 wire \cpuregs[8][15] ;
 wire \cpuregs[8][16] ;
 wire \cpuregs[8][17] ;
 wire \cpuregs[8][18] ;
 wire \cpuregs[8][19] ;
 wire \cpuregs[8][1] ;
 wire \cpuregs[8][20] ;
 wire \cpuregs[8][21] ;
 wire \cpuregs[8][22] ;
 wire \cpuregs[8][23] ;
 wire \cpuregs[8][24] ;
 wire \cpuregs[8][25] ;
 wire \cpuregs[8][26] ;
 wire \cpuregs[8][27] ;
 wire \cpuregs[8][28] ;
 wire \cpuregs[8][29] ;
 wire \cpuregs[8][2] ;
 wire \cpuregs[8][30] ;
 wire \cpuregs[8][31] ;
 wire \cpuregs[8][3] ;
 wire \cpuregs[8][4] ;
 wire \cpuregs[8][5] ;
 wire \cpuregs[8][6] ;
 wire \cpuregs[8][7] ;
 wire \cpuregs[8][8] ;
 wire \cpuregs[8][9] ;
 wire \cpuregs[9][0] ;
 wire \cpuregs[9][10] ;
 wire \cpuregs[9][11] ;
 wire \cpuregs[9][12] ;
 wire \cpuregs[9][13] ;
 wire \cpuregs[9][14] ;
 wire \cpuregs[9][15] ;
 wire \cpuregs[9][16] ;
 wire \cpuregs[9][17] ;
 wire \cpuregs[9][18] ;
 wire \cpuregs[9][19] ;
 wire \cpuregs[9][1] ;
 wire \cpuregs[9][20] ;
 wire \cpuregs[9][21] ;
 wire \cpuregs[9][22] ;
 wire \cpuregs[9][23] ;
 wire \cpuregs[9][24] ;
 wire \cpuregs[9][25] ;
 wire \cpuregs[9][26] ;
 wire \cpuregs[9][27] ;
 wire \cpuregs[9][28] ;
 wire \cpuregs[9][29] ;
 wire \cpuregs[9][2] ;
 wire \cpuregs[9][30] ;
 wire \cpuregs[9][31] ;
 wire \cpuregs[9][3] ;
 wire \cpuregs[9][4] ;
 wire \cpuregs[9][5] ;
 wire \cpuregs[9][6] ;
 wire \cpuregs[9][7] ;
 wire \cpuregs[9][8] ;
 wire \cpuregs[9][9] ;
 wire \cpuregs_wrdata[0] ;
 wire \cpuregs_wrdata[10] ;
 wire \cpuregs_wrdata[11] ;
 wire \cpuregs_wrdata[12] ;
 wire \cpuregs_wrdata[13] ;
 wire \cpuregs_wrdata[14] ;
 wire \cpuregs_wrdata[15] ;
 wire \cpuregs_wrdata[16] ;
 wire \cpuregs_wrdata[17] ;
 wire \cpuregs_wrdata[18] ;
 wire \cpuregs_wrdata[19] ;
 wire \cpuregs_wrdata[1] ;
 wire \cpuregs_wrdata[20] ;
 wire \cpuregs_wrdata[21] ;
 wire \cpuregs_wrdata[22] ;
 wire \cpuregs_wrdata[23] ;
 wire \cpuregs_wrdata[24] ;
 wire \cpuregs_wrdata[25] ;
 wire \cpuregs_wrdata[26] ;
 wire \cpuregs_wrdata[27] ;
 wire \cpuregs_wrdata[28] ;
 wire \cpuregs_wrdata[29] ;
 wire \cpuregs_wrdata[2] ;
 wire \cpuregs_wrdata[30] ;
 wire \cpuregs_wrdata[31] ;
 wire \cpuregs_wrdata[3] ;
 wire \cpuregs_wrdata[4] ;
 wire \cpuregs_wrdata[5] ;
 wire \cpuregs_wrdata[6] ;
 wire \cpuregs_wrdata[7] ;
 wire \cpuregs_wrdata[8] ;
 wire \cpuregs_wrdata[9] ;
 wire \decoded_imm[0] ;
 wire \decoded_imm[10] ;
 wire \decoded_imm[11] ;
 wire \decoded_imm[12] ;
 wire \decoded_imm[13] ;
 wire \decoded_imm[14] ;
 wire \decoded_imm[15] ;
 wire \decoded_imm[16] ;
 wire \decoded_imm[17] ;
 wire \decoded_imm[18] ;
 wire \decoded_imm[19] ;
 wire \decoded_imm[1] ;
 wire \decoded_imm[20] ;
 wire \decoded_imm[21] ;
 wire \decoded_imm[22] ;
 wire \decoded_imm[23] ;
 wire \decoded_imm[24] ;
 wire \decoded_imm[25] ;
 wire \decoded_imm[26] ;
 wire \decoded_imm[27] ;
 wire \decoded_imm[28] ;
 wire \decoded_imm[29] ;
 wire \decoded_imm[2] ;
 wire \decoded_imm[30] ;
 wire \decoded_imm[31] ;
 wire \decoded_imm[3] ;
 wire \decoded_imm[4] ;
 wire \decoded_imm[5] ;
 wire \decoded_imm[6] ;
 wire \decoded_imm[7] ;
 wire \decoded_imm[8] ;
 wire \decoded_imm[9] ;
 wire \decoded_imm_j[10] ;
 wire \decoded_imm_j[11] ;
 wire \decoded_imm_j[12] ;
 wire \decoded_imm_j[13] ;
 wire \decoded_imm_j[14] ;
 wire \decoded_imm_j[15] ;
 wire \decoded_imm_j[16] ;
 wire \decoded_imm_j[17] ;
 wire \decoded_imm_j[18] ;
 wire \decoded_imm_j[19] ;
 wire \decoded_imm_j[1] ;
 wire \decoded_imm_j[20] ;
 wire \decoded_imm_j[2] ;
 wire \decoded_imm_j[3] ;
 wire \decoded_imm_j[4] ;
 wire \decoded_imm_j[5] ;
 wire \decoded_imm_j[6] ;
 wire \decoded_imm_j[7] ;
 wire \decoded_imm_j[8] ;
 wire \decoded_imm_j[9] ;
 wire \decoded_rd[0] ;
 wire \decoded_rd[1] ;
 wire \decoded_rd[2] ;
 wire \decoded_rd[3] ;
 wire \decoded_rd[4] ;
 wire decoder_pseudo_trigger;
 wire decoder_trigger;
 wire instr_add;
 wire instr_addi;
 wire instr_and;
 wire instr_andi;
 wire instr_auipc;
 wire instr_beq;
 wire instr_bge;
 wire instr_bgeu;
 wire instr_blt;
 wire instr_bltu;
 wire instr_bne;
 wire instr_fence;
 wire instr_jal;
 wire instr_jalr;
 wire instr_lb;
 wire instr_lbu;
 wire instr_lh;
 wire instr_lhu;
 wire instr_lui;
 wire instr_lw;
 wire instr_or;
 wire instr_ori;
 wire instr_rdcycle;
 wire instr_rdcycleh;
 wire instr_rdinstr;
 wire instr_rdinstrh;
 wire instr_sb;
 wire instr_sh;
 wire instr_sll;
 wire instr_slli;
 wire instr_slt;
 wire instr_slti;
 wire instr_sltiu;
 wire instr_sltu;
 wire instr_sra;
 wire instr_srai;
 wire instr_srl;
 wire instr_srli;
 wire instr_sub;
 wire instr_sw;
 wire instr_xor;
 wire instr_xori;
 wire is_alu_reg_imm;
 wire is_alu_reg_reg;
 wire is_beq_bne_blt_bge_bltu_bgeu;
 wire is_compare;
 wire is_jalr_addi_slti_sltiu_xori_ori_andi;
 wire is_lb_lh_lw_lbu_lhu;
 wire is_lui_auipc_jal;
 wire is_sb_sh_sw;
 wire is_sll_srl_sra;
 wire is_slli_srli_srai;
 wire is_slti_blt_slt;
 wire is_sltiu_bltu_sltu;
 wire latched_branch;
 wire latched_is_lb;
 wire latched_is_lh;
 wire \latched_rd[0] ;
 wire \latched_rd[1] ;
 wire \latched_rd[2] ;
 wire \latched_rd[3] ;
 wire \latched_rd[4] ;
 wire latched_stalu;
 wire latched_store;
 wire net172;
 wire net173;
 wire net174;
 wire net175;
 wire net176;
 wire net177;
 wire net178;
 wire net179;
 wire net180;
 wire net181;
 wire net182;
 wire net183;
 wire net184;
 wire net185;
 wire net186;
 wire net187;
 wire net188;
 wire net189;
 wire net190;
 wire net191;
 wire net192;
 wire net193;
 wire net194;
 wire net195;
 wire net196;
 wire net197;
 wire net198;
 wire net199;
 wire net200;
 wire net201;
 wire mem_do_prefetch;
 wire mem_do_rdata;
 wire mem_do_rinst;
 wire mem_do_wdata;
 wire net202;
 wire net203;
 wire net204;
 wire net205;
 wire net206;
 wire net207;
 wire net208;
 wire net209;
 wire net210;
 wire net211;
 wire net212;
 wire net213;
 wire net214;
 wire net215;
 wire net216;
 wire net217;
 wire net218;
 wire net219;
 wire net220;
 wire net221;
 wire net222;
 wire net223;
 wire net224;
 wire net225;
 wire net226;
 wire net227;
 wire net228;
 wire net229;
 wire net230;
 wire net231;
 wire net232;
 wire net233;
 wire net234;
 wire net235;
 wire net236;
 wire net237;
 wire net238;
 wire net239;
 wire net240;
 wire net241;
 wire net242;
 wire net243;
 wire net244;
 wire net245;
 wire net246;
 wire net247;
 wire net248;
 wire net249;
 wire net250;
 wire net251;
 wire net252;
 wire net253;
 wire net254;
 wire net255;
 wire net256;
 wire net257;
 wire net258;
 wire net259;
 wire net260;
 wire net261;
 wire net262;
 wire net263;
 wire net264;
 wire net265;
 wire net266;
 wire net267;
 wire net268;
 wire net269;
 wire net270;
 wire net138;
 wire net139;
 wire net140;
 wire net141;
 wire net142;
 wire net143;
 wire net144;
 wire net145;
 wire net146;
 wire net147;
 wire net148;
 wire net149;
 wire net150;
 wire net151;
 wire net152;
 wire net153;
 wire net154;
 wire net155;
 wire net156;
 wire net157;
 wire net158;
 wire net159;
 wire net160;
 wire net161;
 wire net162;
 wire net163;
 wire net164;
 wire net165;
 wire net166;
 wire net167;
 wire net168;
 wire net169;
 wire \mem_rdata_latched[10] ;
 wire \mem_rdata_latched[11] ;
 wire \mem_rdata_latched[12] ;
 wire \mem_rdata_latched[13] ;
 wire \mem_rdata_latched[14] ;
 wire \mem_rdata_latched[15] ;
 wire \mem_rdata_latched[16] ;
 wire \mem_rdata_latched[17] ;
 wire \mem_rdata_latched[18] ;
 wire \mem_rdata_latched[19] ;
 wire \mem_rdata_latched[20] ;
 wire \mem_rdata_latched[21] ;
 wire \mem_rdata_latched[22] ;
 wire \mem_rdata_latched[23] ;
 wire \mem_rdata_latched[24] ;
 wire \mem_rdata_latched[25] ;
 wire \mem_rdata_latched[26] ;
 wire \mem_rdata_latched[27] ;
 wire \mem_rdata_latched[28] ;
 wire \mem_rdata_latched[29] ;
 wire \mem_rdata_latched[30] ;
 wire \mem_rdata_latched[31] ;
 wire \mem_rdata_latched[7] ;
 wire \mem_rdata_latched[8] ;
 wire \mem_rdata_latched[9] ;
 wire \mem_rdata_q[0] ;
 wire \mem_rdata_q[10] ;
 wire \mem_rdata_q[11] ;
 wire \mem_rdata_q[12] ;
 wire \mem_rdata_q[13] ;
 wire \mem_rdata_q[14] ;
 wire \mem_rdata_q[15] ;
 wire \mem_rdata_q[16] ;
 wire \mem_rdata_q[17] ;
 wire \mem_rdata_q[18] ;
 wire \mem_rdata_q[19] ;
 wire \mem_rdata_q[1] ;
 wire \mem_rdata_q[20] ;
 wire \mem_rdata_q[21] ;
 wire \mem_rdata_q[22] ;
 wire \mem_rdata_q[23] ;
 wire \mem_rdata_q[24] ;
 wire \mem_rdata_q[25] ;
 wire \mem_rdata_q[26] ;
 wire \mem_rdata_q[27] ;
 wire \mem_rdata_q[28] ;
 wire \mem_rdata_q[29] ;
 wire \mem_rdata_q[2] ;
 wire \mem_rdata_q[30] ;
 wire \mem_rdata_q[31] ;
 wire \mem_rdata_q[3] ;
 wire \mem_rdata_q[4] ;
 wire \mem_rdata_q[5] ;
 wire \mem_rdata_q[6] ;
 wire \mem_rdata_q[7] ;
 wire \mem_rdata_q[8] ;
 wire \mem_rdata_q[9] ;
 wire net170;
 wire \mem_state[0] ;
 wire \mem_state[1] ;
 wire net271;
 wire net272;
 wire net273;
 wire net274;
 wire net275;
 wire net276;
 wire net277;
 wire net278;
 wire net279;
 wire net280;
 wire net281;
 wire net282;
 wire net283;
 wire net284;
 wire net285;
 wire net286;
 wire net287;
 wire net288;
 wire net289;
 wire net290;
 wire net291;
 wire net292;
 wire net293;
 wire net294;
 wire net295;
 wire net296;
 wire net297;
 wire net298;
 wire net299;
 wire net300;
 wire net301;
 wire net302;
 wire net303;
 wire \mem_wordsize[0] ;
 wire \mem_wordsize[1] ;
 wire \mem_wordsize[2] ;
 wire net304;
 wire net305;
 wire net306;
 wire net307;
 wire net308;
 wire net309;
 wire net310;
 wire net311;
 wire net312;
 wire net313;
 wire net314;
 wire net315;
 wire net316;
 wire net317;
 wire net318;
 wire net319;
 wire net320;
 wire net321;
 wire net322;
 wire net323;
 wire net324;
 wire net325;
 wire net326;
 wire net327;
 wire net328;
 wire net329;
 wire net330;
 wire net331;
 wire net332;
 wire net333;
 wire net334;
 wire net335;
 wire net336;
 wire net337;
 wire net338;
 wire net339;
 wire net340;
 wire net341;
 wire net342;
 wire net343;
 wire net344;
 wire net345;
 wire net346;
 wire net347;
 wire net348;
 wire net349;
 wire net350;
 wire net351;
 wire net352;
 wire net353;
 wire net354;
 wire net355;
 wire net356;
 wire net357;
 wire net358;
 wire net359;
 wire net360;
 wire net361;
 wire net362;
 wire net363;
 wire \reg_next_pc[10] ;
 wire \reg_next_pc[11] ;
 wire \reg_next_pc[12] ;
 wire \reg_next_pc[13] ;
 wire \reg_next_pc[14] ;
 wire \reg_next_pc[15] ;
 wire \reg_next_pc[16] ;
 wire \reg_next_pc[17] ;
 wire \reg_next_pc[18] ;
 wire \reg_next_pc[19] ;
 wire \reg_next_pc[1] ;
 wire \reg_next_pc[20] ;
 wire \reg_next_pc[21] ;
 wire \reg_next_pc[22] ;
 wire \reg_next_pc[23] ;
 wire \reg_next_pc[24] ;
 wire \reg_next_pc[25] ;
 wire \reg_next_pc[26] ;
 wire \reg_next_pc[27] ;
 wire \reg_next_pc[28] ;
 wire \reg_next_pc[29] ;
 wire \reg_next_pc[2] ;
 wire \reg_next_pc[30] ;
 wire \reg_next_pc[31] ;
 wire \reg_next_pc[3] ;
 wire \reg_next_pc[4] ;
 wire \reg_next_pc[5] ;
 wire \reg_next_pc[6] ;
 wire \reg_next_pc[7] ;
 wire \reg_next_pc[8] ;
 wire \reg_next_pc[9] ;
 wire \reg_out[0] ;
 wire \reg_out[10] ;
 wire \reg_out[11] ;
 wire \reg_out[12] ;
 wire \reg_out[13] ;
 wire \reg_out[14] ;
 wire \reg_out[15] ;
 wire \reg_out[16] ;
 wire \reg_out[17] ;
 wire \reg_out[18] ;
 wire \reg_out[19] ;
 wire \reg_out[1] ;
 wire \reg_out[20] ;
 wire \reg_out[21] ;
 wire \reg_out[22] ;
 wire \reg_out[23] ;
 wire \reg_out[24] ;
 wire \reg_out[25] ;
 wire \reg_out[26] ;
 wire \reg_out[27] ;
 wire \reg_out[28] ;
 wire \reg_out[29] ;
 wire \reg_out[2] ;
 wire \reg_out[30] ;
 wire \reg_out[31] ;
 wire \reg_out[3] ;
 wire \reg_out[4] ;
 wire \reg_out[5] ;
 wire \reg_out[6] ;
 wire \reg_out[7] ;
 wire \reg_out[8] ;
 wire \reg_out[9] ;
 wire \reg_pc[10] ;
 wire \reg_pc[11] ;
 wire \reg_pc[12] ;
 wire \reg_pc[13] ;
 wire \reg_pc[14] ;
 wire \reg_pc[15] ;
 wire \reg_pc[16] ;
 wire \reg_pc[17] ;
 wire \reg_pc[18] ;
 wire \reg_pc[19] ;
 wire \reg_pc[1] ;
 wire \reg_pc[20] ;
 wire \reg_pc[21] ;
 wire \reg_pc[22] ;
 wire \reg_pc[23] ;
 wire \reg_pc[24] ;
 wire \reg_pc[25] ;
 wire \reg_pc[26] ;
 wire \reg_pc[27] ;
 wire \reg_pc[28] ;
 wire \reg_pc[29] ;
 wire \reg_pc[2] ;
 wire \reg_pc[30] ;
 wire \reg_pc[31] ;
 wire \reg_pc[3] ;
 wire \reg_pc[4] ;
 wire \reg_pc[5] ;
 wire \reg_pc[6] ;
 wire \reg_pc[7] ;
 wire \reg_pc[8] ;
 wire \reg_pc[9] ;
 wire \reg_sh[0] ;
 wire \reg_sh[1] ;
 wire \reg_sh[2] ;
 wire \reg_sh[3] ;
 wire \reg_sh[4] ;
 wire net171;
 wire net364;
 wire net106;
 wire net107;
 wire net108;
 wire net109;
 wire net110;
 wire net111;
 wire net112;
 wire net113;
 wire net114;
 wire net115;
 wire net116;
 wire net117;
 wire net118;
 wire net119;
 wire net120;
 wire net121;
 wire net122;
 wire net123;
 wire net124;
 wire net125;
 wire net126;
 wire net127;
 wire net128;
 wire net129;
 wire net130;
 wire net131;
 wire net132;
 wire net133;
 wire net134;
 wire net135;
 wire net136;
 wire net137;
 wire clknet_leaf_93_clk;
 wire clknet_leaf_94_clk;
 wire clknet_leaf_95_clk;
 wire clknet_leaf_96_clk;
 wire clknet_leaf_97_clk;
 wire clknet_leaf_98_clk;
 wire clknet_leaf_99_clk;
 wire clknet_leaf_100_clk;
 wire clknet_leaf_101_clk;
 wire clknet_leaf_102_clk;
 wire clknet_leaf_103_clk;
 wire clknet_leaf_104_clk;
 wire clknet_leaf_105_clk;
 wire clknet_leaf_106_clk;
 wire clknet_leaf_107_clk;
 wire clknet_leaf_108_clk;
 wire clknet_leaf_109_clk;
 wire clknet_leaf_110_clk;
 wire clknet_leaf_111_clk;
 wire clknet_leaf_112_clk;
 wire clknet_leaf_113_clk;
 wire clknet_leaf_114_clk;
 wire clknet_leaf_115_clk;
 wire clknet_leaf_116_clk;
 wire clknet_leaf_117_clk;
 wire clknet_leaf_118_clk;
 wire clknet_leaf_119_clk;
 wire clknet_leaf_120_clk;
 wire clknet_leaf_121_clk;
 wire clknet_leaf_122_clk;
 wire clknet_leaf_123_clk;
 wire clknet_leaf_124_clk;
 wire clknet_leaf_125_clk;
 wire clknet_leaf_126_clk;
 wire clknet_leaf_127_clk;
 wire clknet_leaf_128_clk;
 wire clknet_leaf_129_clk;
 wire clknet_leaf_130_clk;
 wire clknet_leaf_131_clk;
 wire clknet_leaf_132_clk;
 wire clknet_leaf_133_clk;
 wire clknet_leaf_134_clk;
 wire clknet_leaf_135_clk;
 wire clknet_leaf_136_clk;
 wire clknet_leaf_137_clk;
 wire clknet_leaf_138_clk;
 wire clknet_leaf_139_clk;
 wire clknet_leaf_140_clk;
 wire clknet_leaf_141_clk;
 wire clknet_leaf_142_clk;
 wire clknet_leaf_143_clk;
 wire clknet_leaf_144_clk;
 wire clknet_leaf_145_clk;
 wire clknet_leaf_146_clk;
 wire clknet_leaf_147_clk;
 wire clknet_leaf_148_clk;
 wire clknet_leaf_149_clk;
 wire clknet_leaf_150_clk;
 wire clknet_leaf_151_clk;
 wire clknet_leaf_152_clk;
 wire clknet_leaf_153_clk;
 wire clknet_leaf_154_clk;
 wire clknet_leaf_155_clk;
 wire clknet_leaf_156_clk;
 wire clknet_0_clk;
 wire clknet_4_0_0_clk;
 wire clknet_4_1_0_clk;
 wire clknet_4_2_0_clk;
 wire clknet_4_3_0_clk;
 wire clknet_4_4_0_clk;
 wire clknet_4_5_0_clk;
 wire clknet_4_6_0_clk;
 wire clknet_4_7_0_clk;
 wire clknet_4_8_0_clk;
 wire clknet_4_9_0_clk;
 wire clknet_4_10_0_clk;
 wire clknet_4_11_0_clk;
 wire clknet_4_12_0_clk;
 wire clknet_4_13_0_clk;
 wire clknet_4_14_0_clk;
 wire clknet_4_15_0_clk;
 wire net829;
 wire net830;
 wire net831;
 wire net832;
 wire net833;
 wire net834;
 wire net835;
 wire net836;
 wire net837;
 wire net838;
 wire net839;
 wire net840;
 wire net841;
 wire net842;
 wire net843;
 wire net844;
 wire net845;
 wire net846;
 wire net847;
 wire net848;
 wire net849;
 wire net850;
 wire net851;
 wire net852;
 wire net853;
 wire net854;
 wire net855;
 wire net856;
 wire net857;
 wire net858;
 wire net859;
 wire net860;
 wire net861;
 wire net862;
 wire net863;

 sky130_fd_sc_hd__clkinv_1 _4757_ (.A(decoder_trigger),
    .Y(_0850_));
 sky130_fd_sc_hd__nor2_1 _4758_ (.A(_0850_),
    .B(decoder_pseudo_trigger),
    .Y(_0797_));
 sky130_fd_sc_hd__nand2_1 _4762_ (.A(net271),
    .B(net170),
    .Y(_0854_));
 sky130_fd_sc_hd__o21bai_1 _4763_ (.A1(_0487_),
    .A2(net733),
    .B1_N(_0492_),
    .Y(_0855_));
 sky130_fd_sc_hd__nor2_1 _4765_ (.A(mem_do_rdata),
    .B(mem_do_wdata),
    .Y(_0857_));
 sky130_fd_sc_hd__nor3_1 _4766_ (.A(_0487_),
    .B(net733),
    .C(_0857_),
    .Y(_0858_));
 sky130_fd_sc_hd__a21oi_1 _4767_ (.A1(mem_do_rinst),
    .A2(_0855_),
    .B1(_0858_),
    .Y(_0859_));
 sky130_fd_sc_hd__inv_1 _4768_ (.A(net693),
    .Y(_0860_));
 sky130_fd_sc_hd__nand3_1 _4769_ (.A(mem_do_rinst),
    .B(net825),
    .C(_0860_),
    .Y(_0861_));
 sky130_fd_sc_hd__inv_1 _4771_ (.A(_0861_),
    .Y(_0815_));
 sky130_fd_sc_hd__nand2_1 _4772_ (.A(latched_store),
    .B(latched_branch),
    .Y(_0863_));
 sky130_fd_sc_hd__mux2i_1 _4780_ (.A0(\reg_out[1] ),
    .A1(\alu_out_q[1] ),
    .S(latched_stalu),
    .Y(_0871_));
 sky130_fd_sc_hd__nand2_1 _4781_ (.A(\reg_next_pc[1] ),
    .B(net732),
    .Y(_0872_));
 sky130_fd_sc_hd__o21ai_0 _4782_ (.A1(net732),
    .A2(_0871_),
    .B1(_0872_),
    .Y(_0084_));
 sky130_fd_sc_hd__mux2_1 _4783_ (.A0(\reg_out[2] ),
    .A1(\alu_out_q[2] ),
    .S(latched_stalu),
    .X(_0873_));
 sky130_fd_sc_hd__and2_1 _4784_ (.A(latched_store),
    .B(latched_branch),
    .X(_0874_));
 sky130_fd_sc_hd__mux2_4 _4787_ (.A0(\reg_next_pc[2] ),
    .A1(_0873_),
    .S(_0874_),
    .X(_0051_));
 sky130_fd_sc_hd__mux2i_1 _4789_ (.A0(\reg_out[3] ),
    .A1(\alu_out_q[3] ),
    .S(latched_stalu),
    .Y(_0878_));
 sky130_fd_sc_hd__a21oi_1 _4792_ (.A1(latched_store),
    .A2(latched_branch),
    .B1(\reg_next_pc[3] ),
    .Y(_0881_));
 sky130_fd_sc_hd__a21oi_4 _4793_ (.A1(_0874_),
    .A2(_0878_),
    .B1(_0881_),
    .Y(_0079_));
 sky130_fd_sc_hd__mux2i_1 _4794_ (.A0(\reg_out[4] ),
    .A1(\alu_out_q[4] ),
    .S(latched_stalu),
    .Y(_0882_));
 sky130_fd_sc_hd__a21oi_1 _4795_ (.A1(latched_store),
    .A2(latched_branch),
    .B1(\reg_next_pc[4] ),
    .Y(_0883_));
 sky130_fd_sc_hd__a21oi_4 _4796_ (.A1(_0874_),
    .A2(_0882_),
    .B1(_0883_),
    .Y(_0238_));
 sky130_fd_sc_hd__mux2_1 _4797_ (.A0(\reg_out[5] ),
    .A1(\alu_out_q[5] ),
    .S(latched_stalu),
    .X(_0884_));
 sky130_fd_sc_hd__nand2_1 _4798_ (.A(\reg_next_pc[5] ),
    .B(_0863_),
    .Y(_0885_));
 sky130_fd_sc_hd__a21boi_0 _4799_ (.A1(_0874_),
    .A2(_0884_),
    .B1_N(_0885_),
    .Y(_0886_));
 sky130_fd_sc_hd__clkinv_1 _4800_ (.A(_0886_),
    .Y(_0093_));
 sky130_fd_sc_hd__mux2_1 _4801_ (.A0(\reg_out[6] ),
    .A1(\alu_out_q[6] ),
    .S(latched_stalu),
    .X(_0887_));
 sky130_fd_sc_hd__mux2_4 _4802_ (.A0(\reg_next_pc[6] ),
    .A1(_0887_),
    .S(_0874_),
    .X(_0460_));
 sky130_fd_sc_hd__mux2_1 _4803_ (.A0(\reg_out[7] ),
    .A1(\alu_out_q[7] ),
    .S(latched_stalu),
    .X(_0888_));
 sky130_fd_sc_hd__mux2_4 _4804_ (.A0(\reg_next_pc[7] ),
    .A1(_0888_),
    .S(_0874_),
    .X(_0108_));
 sky130_fd_sc_hd__mux2_1 _4805_ (.A0(\reg_out[8] ),
    .A1(\alu_out_q[8] ),
    .S(latched_stalu),
    .X(_0889_));
 sky130_fd_sc_hd__nand2_1 _4806_ (.A(\reg_next_pc[8] ),
    .B(net732),
    .Y(_0890_));
 sky130_fd_sc_hd__a21boi_1 _4807_ (.A1(net731),
    .A2(_0889_),
    .B1_N(_0890_),
    .Y(_0891_));
 sky130_fd_sc_hd__inv_1 _4808_ (.A(_0891_),
    .Y(_0148_));
 sky130_fd_sc_hd__mux2_2 _4809_ (.A0(\reg_out[9] ),
    .A1(\alu_out_q[9] ),
    .S(latched_stalu),
    .X(_0892_));
 sky130_fd_sc_hd__mux2_4 _4810_ (.A0(\reg_next_pc[9] ),
    .A1(_0892_),
    .S(_0874_),
    .X(_0269_));
 sky130_fd_sc_hd__mux2_1 _4811_ (.A0(\reg_out[10] ),
    .A1(\alu_out_q[10] ),
    .S(latched_stalu),
    .X(_0893_));
 sky130_fd_sc_hd__nand2_1 _4812_ (.A(\reg_next_pc[10] ),
    .B(net732),
    .Y(_0894_));
 sky130_fd_sc_hd__a21boi_2 _4813_ (.A1(net731),
    .A2(_0893_),
    .B1_N(_0894_),
    .Y(_0895_));
 sky130_fd_sc_hd__inv_1 _4814_ (.A(_0895_),
    .Y(_0231_));
 sky130_fd_sc_hd__mux2_2 _4815_ (.A0(\reg_out[11] ),
    .A1(\alu_out_q[11] ),
    .S(latched_stalu),
    .X(_0896_));
 sky130_fd_sc_hd__mux2i_1 _4816_ (.A0(\reg_next_pc[11] ),
    .A1(_0896_),
    .S(net731),
    .Y(_0897_));
 sky130_fd_sc_hd__inv_1 _4817_ (.A(net711),
    .Y(_0076_));
 sky130_fd_sc_hd__mux2_2 _4818_ (.A0(\reg_out[12] ),
    .A1(\alu_out_q[12] ),
    .S(latched_stalu),
    .X(_0898_));
 sky130_fd_sc_hd__mux2i_1 _4819_ (.A0(\reg_next_pc[12] ),
    .A1(_0898_),
    .S(net731),
    .Y(_0899_));
 sky130_fd_sc_hd__inv_1 _4820_ (.A(_0899_),
    .Y(_0090_));
 sky130_fd_sc_hd__mux2_2 _4821_ (.A0(\reg_out[13] ),
    .A1(\alu_out_q[13] ),
    .S(latched_stalu),
    .X(_0900_));
 sky130_fd_sc_hd__mux2_2 _4822_ (.A0(\reg_next_pc[13] ),
    .A1(_0900_),
    .S(net731),
    .X(_0244_));
 sky130_fd_sc_hd__mux2_2 _4823_ (.A0(\reg_out[14] ),
    .A1(\alu_out_q[14] ),
    .S(latched_stalu),
    .X(_0901_));
 sky130_fd_sc_hd__mux2_2 _4824_ (.A0(\reg_next_pc[14] ),
    .A1(_0901_),
    .S(net731),
    .X(_0412_));
 sky130_fd_sc_hd__mux2_2 _4825_ (.A0(\reg_out[15] ),
    .A1(\alu_out_q[15] ),
    .S(latched_stalu),
    .X(_0902_));
 sky130_fd_sc_hd__nand2_1 _4826_ (.A(net731),
    .B(_0902_),
    .Y(_0903_));
 sky130_fd_sc_hd__nand2_1 _4827_ (.A(\reg_next_pc[15] ),
    .B(net732),
    .Y(_0904_));
 sky130_fd_sc_hd__nand2_1 _4828_ (.A(_0903_),
    .B(_0904_),
    .Y(_0103_));
 sky130_fd_sc_hd__mux2_2 _4829_ (.A0(\reg_out[16] ),
    .A1(\alu_out_q[16] ),
    .S(latched_stalu),
    .X(_0905_));
 sky130_fd_sc_hd__nand2_1 _4830_ (.A(net731),
    .B(_0905_),
    .Y(_0906_));
 sky130_fd_sc_hd__nand2_1 _4831_ (.A(\reg_next_pc[16] ),
    .B(net732),
    .Y(_0907_));
 sky130_fd_sc_hd__nand2_1 _4832_ (.A(_0906_),
    .B(_0907_),
    .Y(_0086_));
 sky130_fd_sc_hd__mux2_2 _4833_ (.A0(\reg_out[17] ),
    .A1(\alu_out_q[17] ),
    .S(latched_stalu),
    .X(_0908_));
 sky130_fd_sc_hd__nand2_1 _4834_ (.A(net731),
    .B(_0908_),
    .Y(_0909_));
 sky130_fd_sc_hd__nand2_1 _4835_ (.A(\reg_next_pc[17] ),
    .B(net732),
    .Y(_0910_));
 sky130_fd_sc_hd__nand2_1 _4836_ (.A(_0909_),
    .B(_0910_),
    .Y(_0415_));
 sky130_fd_sc_hd__mux2i_1 _4837_ (.A0(\reg_out[18] ),
    .A1(\alu_out_q[18] ),
    .S(latched_stalu),
    .Y(_0911_));
 sky130_fd_sc_hd__nand2_1 _4838_ (.A(\reg_next_pc[18] ),
    .B(net732),
    .Y(_0912_));
 sky130_fd_sc_hd__o21a_1 _4839_ (.A1(net732),
    .A2(_0911_),
    .B1(_0912_),
    .X(_0913_));
 sky130_fd_sc_hd__inv_1 _4840_ (.A(_0913_),
    .Y(_0235_));
 sky130_fd_sc_hd__mux2i_1 _4841_ (.A0(\reg_out[19] ),
    .A1(\alu_out_q[19] ),
    .S(latched_stalu),
    .Y(_0914_));
 sky130_fd_sc_hd__a21oi_1 _4842_ (.A1(latched_store),
    .A2(latched_branch),
    .B1(\reg_next_pc[19] ),
    .Y(_0915_));
 sky130_fd_sc_hd__a21oi_4 _4843_ (.A1(net731),
    .A2(_0914_),
    .B1(_0915_),
    .Y(_0216_));
 sky130_fd_sc_hd__mux2i_1 _4844_ (.A0(\reg_out[20] ),
    .A1(\alu_out_q[20] ),
    .S(latched_stalu),
    .Y(_0916_));
 sky130_fd_sc_hd__a21oi_1 _4845_ (.A1(latched_store),
    .A2(latched_branch),
    .B1(\reg_next_pc[20] ),
    .Y(_0917_));
 sky130_fd_sc_hd__a21oi_2 _4846_ (.A1(net731),
    .A2(_0916_),
    .B1(_0917_),
    .Y(_0069_));
 sky130_fd_sc_hd__mux2i_1 _4847_ (.A0(\reg_out[21] ),
    .A1(\alu_out_q[21] ),
    .S(latched_stalu),
    .Y(_0918_));
 sky130_fd_sc_hd__a21oi_1 _4848_ (.A1(latched_store),
    .A2(latched_branch),
    .B1(\reg_next_pc[21] ),
    .Y(_0919_));
 sky130_fd_sc_hd__a21oi_2 _4849_ (.A1(net731),
    .A2(_0918_),
    .B1(_0919_),
    .Y(_0221_));
 sky130_fd_sc_hd__mux2i_1 _4850_ (.A0(\reg_out[22] ),
    .A1(\alu_out_q[22] ),
    .S(latched_stalu),
    .Y(_0920_));
 sky130_fd_sc_hd__nand2_1 _4851_ (.A(\reg_next_pc[22] ),
    .B(net732),
    .Y(_0921_));
 sky130_fd_sc_hd__o21ai_1 _4852_ (.A1(net732),
    .A2(_0920_),
    .B1(_0921_),
    .Y(_0482_));
 sky130_fd_sc_hd__mux2_2 _4853_ (.A0(\reg_out[23] ),
    .A1(\alu_out_q[23] ),
    .S(latched_stalu),
    .X(_0922_));
 sky130_fd_sc_hd__nand2_1 _4854_ (.A(\reg_next_pc[23] ),
    .B(net732),
    .Y(_0923_));
 sky130_fd_sc_hd__a21boi_1 _4855_ (.A1(net731),
    .A2(_0922_),
    .B1_N(_0923_),
    .Y(_0924_));
 sky130_fd_sc_hd__inv_1 _4856_ (.A(_0924_),
    .Y(_0457_));
 sky130_fd_sc_hd__mux2_2 _4857_ (.A0(\reg_out[24] ),
    .A1(\alu_out_q[24] ),
    .S(latched_stalu),
    .X(_0925_));
 sky130_fd_sc_hd__nand2_1 _4858_ (.A(\reg_next_pc[24] ),
    .B(net732),
    .Y(_0926_));
 sky130_fd_sc_hd__a21boi_0 _4859_ (.A1(net731),
    .A2(_0925_),
    .B1_N(_0926_),
    .Y(_0927_));
 sky130_fd_sc_hd__inv_1 _4860_ (.A(_0927_),
    .Y(_0154_));
 sky130_fd_sc_hd__mux2i_1 _4861_ (.A0(\reg_out[25] ),
    .A1(\alu_out_q[25] ),
    .S(latched_stalu),
    .Y(_0928_));
 sky130_fd_sc_hd__a21oi_1 _4862_ (.A1(latched_store),
    .A2(latched_branch),
    .B1(\reg_next_pc[25] ),
    .Y(_0929_));
 sky130_fd_sc_hd__a21oi_2 _4863_ (.A1(net731),
    .A2(_0928_),
    .B1(_0929_),
    .Y(_0432_));
 sky130_fd_sc_hd__mux2i_1 _4864_ (.A0(\reg_out[26] ),
    .A1(\alu_out_q[26] ),
    .S(latched_stalu),
    .Y(_0930_));
 sky130_fd_sc_hd__a21oi_1 _4865_ (.A1(latched_store),
    .A2(latched_branch),
    .B1(\reg_next_pc[26] ),
    .Y(_0931_));
 sky130_fd_sc_hd__a21oi_2 _4866_ (.A1(net731),
    .A2(_0930_),
    .B1(_0931_),
    .Y(_0228_));
 sky130_fd_sc_hd__mux2i_1 _4867_ (.A0(\reg_out[27] ),
    .A1(\alu_out_q[27] ),
    .S(latched_stalu),
    .Y(_0932_));
 sky130_fd_sc_hd__nand2_1 _4868_ (.A(\reg_next_pc[27] ),
    .B(net732),
    .Y(_0933_));
 sky130_fd_sc_hd__o21a_1 _4869_ (.A1(net732),
    .A2(_0932_),
    .B1(_0933_),
    .X(_0934_));
 sky130_fd_sc_hd__inv_1 _4870_ (.A(_0934_),
    .Y(_0201_));
 sky130_fd_sc_hd__mux2i_1 _4871_ (.A0(\reg_out[28] ),
    .A1(\alu_out_q[28] ),
    .S(latched_stalu),
    .Y(_0935_));
 sky130_fd_sc_hd__nand2_1 _4872_ (.A(\reg_next_pc[28] ),
    .B(net732),
    .Y(_0936_));
 sky130_fd_sc_hd__o21ai_1 _4873_ (.A1(net732),
    .A2(_0935_),
    .B1(_0936_),
    .Y(_0470_));
 sky130_fd_sc_hd__mux2i_1 _4874_ (.A0(\reg_out[29] ),
    .A1(\alu_out_q[29] ),
    .S(latched_stalu),
    .Y(_0937_));
 sky130_fd_sc_hd__nand2_1 _4875_ (.A(\reg_next_pc[29] ),
    .B(net732),
    .Y(_0938_));
 sky130_fd_sc_hd__o21a_1 _4876_ (.A1(net732),
    .A2(_0937_),
    .B1(_0938_),
    .X(_0939_));
 sky130_fd_sc_hd__inv_1 _4877_ (.A(_0939_),
    .Y(_0073_));
 sky130_fd_sc_hd__mux2i_1 _4878_ (.A0(\reg_out[30] ),
    .A1(\alu_out_q[30] ),
    .S(latched_stalu),
    .Y(_0940_));
 sky130_fd_sc_hd__nand2_1 _4879_ (.A(\reg_next_pc[30] ),
    .B(net732),
    .Y(_0941_));
 sky130_fd_sc_hd__o21a_1 _4880_ (.A1(net732),
    .A2(_0940_),
    .B1(_0941_),
    .X(_0942_));
 sky130_fd_sc_hd__inv_1 _4881_ (.A(_0942_),
    .Y(_0151_));
 sky130_fd_sc_hd__inv_1 _4882_ (.A(net359),
    .Y(_0258_));
 sky130_fd_sc_hd__inv_1 _4883_ (.A(net357),
    .Y(_0273_));
 sky130_fd_sc_hd__inv_1 _4884_ (.A(net353),
    .Y(_0297_));
 sky130_fd_sc_hd__inv_1 _4885_ (.A(net234),
    .Y(_0444_));
 sky130_fd_sc_hd__inv_1 _4886_ (.A(\mem_state[1] ),
    .Y(_0486_));
 sky130_fd_sc_hd__inv_1 _4887_ (.A(net259),
    .Y(_0426_));
 sky130_fd_sc_hd__inv_1 _4888_ (.A(\reg_sh[3] ),
    .Y(_0097_));
 sky130_fd_sc_hd__inv_1 _4889_ (.A(net352),
    .Y(_0305_));
 sky130_fd_sc_hd__inv_1 _4890_ (.A(net737),
    .Y(_0388_));
 sky130_fd_sc_hd__inv_1 _4891_ (.A(net358),
    .Y(_0264_));
 sky130_fd_sc_hd__inv_1 _4892_ (.A(net261),
    .Y(_0406_));
 sky130_fd_sc_hd__inv_1 _4893_ (.A(net322),
    .Y(_0304_));
 sky130_fd_sc_hd__inv_1 _4894_ (.A(\reg_sh[2] ),
    .Y(_0096_));
 sky130_fd_sc_hd__inv_1 _4895_ (.A(net356),
    .Y(_0279_));
 sky130_fd_sc_hd__inv_1 _4896_ (.A(\reg_sh[1] ),
    .Y(_0116_));
 sky130_fd_sc_hd__inv_1 _4897_ (.A(net360),
    .Y(_0254_));
 sky130_fd_sc_hd__or2_2 _4900_ (.A(\mem_wordsize[2] ),
    .B(net766),
    .X(_0945_));
 sky130_fd_sc_hd__nand2_1 _4905_ (.A(net765),
    .B(net344),
    .Y(_0950_));
 sky130_fd_sc_hd__nand2_1 _4907_ (.A(net766),
    .B(net262),
    .Y(_0952_));
 sky130_fd_sc_hd__o211ai_1 _4908_ (.A1(_0254_),
    .A2(_0945_),
    .B1(_0950_),
    .C1(_0952_),
    .Y(net257));
 sky130_fd_sc_hd__a22oi_1 _4910_ (.A1(net261),
    .A2(net766),
    .B1(net343),
    .B2(net765),
    .Y(_0954_));
 sky130_fd_sc_hd__o21ai_0 _4911_ (.A1(_0258_),
    .A2(_0945_),
    .B1(_0954_),
    .Y(net255));
 sky130_fd_sc_hd__a22oi_1 _4912_ (.A1(net765),
    .A2(net342),
    .B1(net260),
    .B2(net766),
    .Y(_0955_));
 sky130_fd_sc_hd__o21ai_0 _4913_ (.A1(_0264_),
    .A2(_0945_),
    .B1(_0955_),
    .Y(net254));
 sky130_fd_sc_hd__a22oi_1 _4914_ (.A1(net259),
    .A2(net766),
    .B1(net341),
    .B2(net765),
    .Y(_0956_));
 sky130_fd_sc_hd__o21ai_0 _4915_ (.A1(_0273_),
    .A2(_0945_),
    .B1(_0956_),
    .Y(net253));
 sky130_fd_sc_hd__a22oi_1 _4916_ (.A1(net765),
    .A2(net340),
    .B1(net256),
    .B2(net766),
    .Y(_0957_));
 sky130_fd_sc_hd__o21ai_0 _4917_ (.A1(_0279_),
    .A2(_0945_),
    .B1(_0957_),
    .Y(net252));
 sky130_fd_sc_hd__inv_1 _4918_ (.A(net355),
    .Y(_0285_));
 sky130_fd_sc_hd__nand2_1 _4919_ (.A(net766),
    .B(net245),
    .Y(_0958_));
 sky130_fd_sc_hd__nand2_1 _4920_ (.A(net765),
    .B(net363),
    .Y(_0959_));
 sky130_fd_sc_hd__o211ai_1 _4921_ (.A1(_0285_),
    .A2(_0945_),
    .B1(_0958_),
    .C1(_0959_),
    .Y(net251));
 sky130_fd_sc_hd__inv_1 _4922_ (.A(net354),
    .Y(_0291_));
 sky130_fd_sc_hd__a22oi_1 _4923_ (.A1(net234),
    .A2(net766),
    .B1(net362),
    .B2(net765),
    .Y(_0960_));
 sky130_fd_sc_hd__o21ai_0 _4924_ (.A1(_0291_),
    .A2(_0945_),
    .B1(_0960_),
    .Y(net250));
 sky130_fd_sc_hd__inv_1 _4925_ (.A(net263),
    .Y(_0394_));
 sky130_fd_sc_hd__nor2_2 _4926_ (.A(net765),
    .B(net766),
    .Y(_0961_));
 sky130_fd_sc_hd__nand2_1 _4928_ (.A(net353),
    .B(_0961_),
    .Y(_0963_));
 sky130_fd_sc_hd__o21ai_0 _4929_ (.A1(_0394_),
    .A2(_0961_),
    .B1(_0963_),
    .Y(net249));
 sky130_fd_sc_hd__inv_1 _4930_ (.A(net262),
    .Y(_0400_));
 sky130_fd_sc_hd__nand2_1 _4931_ (.A(net352),
    .B(_0961_),
    .Y(_0964_));
 sky130_fd_sc_hd__o21ai_0 _4932_ (.A1(_0400_),
    .A2(_0961_),
    .B1(_0964_),
    .Y(net248));
 sky130_fd_sc_hd__nand2_1 _4934_ (.A(net351),
    .B(_0961_),
    .Y(_0966_));
 sky130_fd_sc_hd__o21ai_0 _4935_ (.A1(_0406_),
    .A2(_0961_),
    .B1(_0966_),
    .Y(net247));
 sky130_fd_sc_hd__inv_1 _4936_ (.A(net260),
    .Y(_0420_));
 sky130_fd_sc_hd__nand2_1 _4937_ (.A(net350),
    .B(_0961_),
    .Y(_0967_));
 sky130_fd_sc_hd__o21ai_0 _4938_ (.A1(_0420_),
    .A2(_0961_),
    .B1(_0967_),
    .Y(net246));
 sky130_fd_sc_hd__nand2_1 _4939_ (.A(net349),
    .B(_0961_),
    .Y(_0968_));
 sky130_fd_sc_hd__o21ai_0 _4940_ (.A1(_0426_),
    .A2(_0961_),
    .B1(_0968_),
    .Y(net244));
 sky130_fd_sc_hd__inv_1 _4941_ (.A(net256),
    .Y(_0435_));
 sky130_fd_sc_hd__nand2_1 _4942_ (.A(net348),
    .B(_0961_),
    .Y(_0969_));
 sky130_fd_sc_hd__o21ai_0 _4943_ (.A1(_0435_),
    .A2(_0961_),
    .B1(_0969_),
    .Y(net243));
 sky130_fd_sc_hd__inv_1 _4944_ (.A(net245),
    .Y(_0065_));
 sky130_fd_sc_hd__nand2_1 _4945_ (.A(net347),
    .B(_0961_),
    .Y(_0970_));
 sky130_fd_sc_hd__o21ai_0 _4946_ (.A1(_0065_),
    .A2(_0961_),
    .B1(_0970_),
    .Y(net242));
 sky130_fd_sc_hd__nand2_1 _4947_ (.A(net346),
    .B(_0961_),
    .Y(_0971_));
 sky130_fd_sc_hd__o21ai_0 _4948_ (.A1(_0444_),
    .A2(_0961_),
    .B1(_0971_),
    .Y(net241));
 sky130_fd_sc_hd__nand2b_1 _4949_ (.A_N(net765),
    .B(net766),
    .Y(_0972_));
 sky130_fd_sc_hd__a22o_1 _4951_ (.A1(net263),
    .A2(net766),
    .B1(_0972_),
    .B2(net345),
    .X(net240));
 sky130_fd_sc_hd__nand2_1 _4952_ (.A(net344),
    .B(_0972_),
    .Y(_0974_));
 sky130_fd_sc_hd__nand2_1 _4953_ (.A(_0952_),
    .B(_0974_),
    .Y(net239));
 sky130_fd_sc_hd__a22o_1 _4954_ (.A1(net261),
    .A2(net766),
    .B1(net343),
    .B2(_0972_),
    .X(net238));
 sky130_fd_sc_hd__a22o_1 _4955_ (.A1(net766),
    .A2(net260),
    .B1(_0972_),
    .B2(net342),
    .X(net237));
 sky130_fd_sc_hd__a22o_1 _4956_ (.A1(net259),
    .A2(net766),
    .B1(net341),
    .B2(_0972_),
    .X(net236));
 sky130_fd_sc_hd__inv_1 _4957_ (.A(net326),
    .Y(_0278_));
 sky130_fd_sc_hd__a22o_1 _4958_ (.A1(net766),
    .A2(net256),
    .B1(_0972_),
    .B2(net340),
    .X(net235));
 sky130_fd_sc_hd__inv_1 _4959_ (.A(net744),
    .Y(_0263_));
 sky130_fd_sc_hd__nand2_1 _4960_ (.A(net363),
    .B(_0972_),
    .Y(_0975_));
 sky130_fd_sc_hd__nand2_1 _4961_ (.A(_0958_),
    .B(_0975_),
    .Y(net265));
 sky130_fd_sc_hd__a22o_1 _4962_ (.A1(net234),
    .A2(net766),
    .B1(net362),
    .B2(_0972_),
    .X(net264));
 sky130_fd_sc_hd__clkinv_1 _4964_ (.A(net319),
    .Y(_0061_));
 sky130_fd_sc_hd__inv_1 _4965_ (.A(net308),
    .Y(_0445_));
 sky130_fd_sc_hd__nor2_1 _4966_ (.A(net765),
    .B(_0445_),
    .Y(_0977_));
 sky130_fd_sc_hd__o21ai_0 _4967_ (.A1(_0061_),
    .A2(_0977_),
    .B1(_0945_),
    .Y(net269));
 sky130_fd_sc_hd__nor2_1 _4970_ (.A(net765),
    .B(net764),
    .Y(_0980_));
 sky130_fd_sc_hd__o21ai_0 _4971_ (.A1(net753),
    .A2(_0980_),
    .B1(_0945_),
    .Y(net268));
 sky130_fd_sc_hd__o21ai_1 _4972_ (.A1(net753),
    .A2(_0977_),
    .B1(_0945_),
    .Y(net267));
 sky130_fd_sc_hd__inv_1 _4973_ (.A(net363),
    .Y(_0383_));
 sky130_fd_sc_hd__inv_1 _4974_ (.A(\reg_sh[0] ),
    .Y(_0115_));
 sky130_fd_sc_hd__inv_1 _4975_ (.A(net742),
    .Y(_0451_));
 sky130_fd_sc_hd__nand3_1 _4977_ (.A(mem_do_wdata),
    .B(_0487_),
    .C(net825),
    .Y(_0982_));
 sky130_fd_sc_hd__clkinv_1 _4978_ (.A(_0982_),
    .Y(net266));
 sky130_fd_sc_hd__nand2_1 _4979_ (.A(net700),
    .B(net266),
    .Y(_0983_));
 sky130_fd_sc_hd__nand2_1 _4980_ (.A(net306),
    .B(_0982_),
    .Y(_0984_));
 sky130_fd_sc_hd__or2_2 _4982_ (.A(mem_do_prefetch),
    .B(mem_do_rinst),
    .X(_0986_));
 sky130_fd_sc_hd__o21a_1 _4984_ (.A1(mem_do_rdata),
    .A2(_0986_),
    .B1(_0487_),
    .X(_0988_));
 sky130_fd_sc_hd__a21oi_1 _4985_ (.A1(_0983_),
    .A2(_0984_),
    .B1(_0988_),
    .Y(_4684_));
 sky130_fd_sc_hd__mux2i_1 _4986_ (.A0(net305),
    .A1(net710),
    .S(net266),
    .Y(_0989_));
 sky130_fd_sc_hd__nor2_1 _4987_ (.A(_0988_),
    .B(_0989_),
    .Y(_4683_));
 sky130_fd_sc_hd__nor2_1 _4988_ (.A(net304),
    .B(net266),
    .Y(_0990_));
 sky130_fd_sc_hd__nor2_1 _4989_ (.A(net699),
    .B(_0982_),
    .Y(_0991_));
 sky130_fd_sc_hd__nor3_1 _4990_ (.A(_0988_),
    .B(_0990_),
    .C(_0991_),
    .Y(_4682_));
 sky130_fd_sc_hd__inv_1 _4991_ (.A(net330),
    .Y(_0436_));
 sky130_fd_sc_hd__or3_1 _4992_ (.A(instr_jalr),
    .B(is_lb_lh_lw_lbu_lhu),
    .C(is_alu_reg_imm),
    .X(_0992_));
 sky130_fd_sc_hd__a22o_1 _4994_ (.A1(is_sb_sh_sw),
    .A2(\mem_rdata_q[7] ),
    .B1(_0992_),
    .B2(\mem_rdata_q[20] ),
    .X(_4681_));
 sky130_fd_sc_hd__or2_2 _4998_ (.A(instr_and),
    .B(instr_andi),
    .X(_0997_));
 sky130_fd_sc_hd__or2_2 _5000_ (.A(instr_or),
    .B(instr_ori),
    .X(_0999_));
 sky130_fd_sc_hd__or2_2 _5001_ (.A(instr_xor),
    .B(instr_xori),
    .X(_1000_));
 sky130_fd_sc_hd__nor3_1 _5003_ (.A(net728),
    .B(_0999_),
    .C(net727),
    .Y(_1002_));
 sky130_fd_sc_hd__nand2b_1 _5004_ (.A_N(is_compare),
    .B(_1002_),
    .Y(_1003_));
 sky130_fd_sc_hd__nor2_1 _5005_ (.A(net767),
    .B(net698),
    .Y(_1004_));
 sky130_fd_sc_hd__inv_1 _5006_ (.A(_0453_),
    .Y(_1005_));
 sky130_fd_sc_hd__nand3_1 _5010_ (.A(_0260_),
    .B(_0266_),
    .C(_0275_),
    .Y(_1009_));
 sky130_fd_sc_hd__inv_1 _5013_ (.A(_0313_),
    .Y(_1012_));
 sky130_fd_sc_hd__nand2_1 _5016_ (.A(_0319_),
    .B(_0325_),
    .Y(_1015_));
 sky130_fd_sc_hd__nor2_1 _5017_ (.A(_1012_),
    .B(_1015_),
    .Y(_1016_));
 sky130_fd_sc_hd__a21o_1 _5021_ (.A1(_0349_),
    .A2(_0357_),
    .B1(_0351_),
    .X(_1020_));
 sky130_fd_sc_hd__a21o_1 _5022_ (.A1(_0343_),
    .A2(_1020_),
    .B1(_0345_),
    .X(_1021_));
 sky130_fd_sc_hd__a211oi_1 _5024_ (.A1(_0067_),
    .A2(_0438_),
    .B1(_0431_),
    .C1(_0440_),
    .Y(_1023_));
 sky130_fd_sc_hd__o211ai_1 _5027_ (.A1(_0429_),
    .A2(_0431_),
    .B1(_0423_),
    .C1(_0409_),
    .Y(_1026_));
 sky130_fd_sc_hd__a21oi_1 _5028_ (.A1(_0409_),
    .A2(_0425_),
    .B1(_0411_),
    .Y(_1027_));
 sky130_fd_sc_hd__o21ai_1 _5029_ (.A1(_1023_),
    .A2(_1026_),
    .B1(_1027_),
    .Y(_1028_));
 sky130_fd_sc_hd__o21ai_0 _5031_ (.A1(_0403_),
    .A2(_0405_),
    .B1(_0397_),
    .Y(_1030_));
 sky130_fd_sc_hd__nand2b_1 _5032_ (.A_N(_0399_),
    .B(_1030_),
    .Y(_1031_));
 sky130_fd_sc_hd__o31ai_1 _5033_ (.A1(_0399_),
    .A2(_0405_),
    .A3(_1028_),
    .B1(_1031_),
    .Y(_1032_));
 sky130_fd_sc_hd__nand4_1 _5038_ (.A(_0391_),
    .B(_0385_),
    .C(_0373_),
    .D(_0379_),
    .Y(_1037_));
 sky130_fd_sc_hd__a22o_1 _5040_ (.A1(_0369_),
    .A2(_0361_),
    .B1(_0373_),
    .B2(_0381_),
    .X(_1039_));
 sky130_fd_sc_hd__inv_1 _5041_ (.A(_0373_),
    .Y(_1040_));
 sky130_fd_sc_hd__inv_1 _5042_ (.A(_0379_),
    .Y(_1041_));
 sky130_fd_sc_hd__a21oi_1 _5043_ (.A1(_0385_),
    .A2(_0393_),
    .B1(_0387_),
    .Y(_1042_));
 sky130_fd_sc_hd__nor3_1 _5044_ (.A(_1040_),
    .B(_1041_),
    .C(_1042_),
    .Y(_1043_));
 sky130_fd_sc_hd__nor4_1 _5045_ (.A(_0375_),
    .B(_0363_),
    .C(_1039_),
    .D(_1043_),
    .Y(_1044_));
 sky130_fd_sc_hd__o21ai_1 _5046_ (.A1(_1032_),
    .A2(_1037_),
    .B1(_1044_),
    .Y(_1045_));
 sky130_fd_sc_hd__and3_1 _5048_ (.A(_0343_),
    .B(_0349_),
    .C(_0355_),
    .X(_1047_));
 sky130_fd_sc_hd__o21ai_0 _5049_ (.A1(_0367_),
    .A2(_0369_),
    .B1(_0361_),
    .Y(_1048_));
 sky130_fd_sc_hd__nand2b_1 _5050_ (.A_N(_0363_),
    .B(_1048_),
    .Y(_1049_));
 sky130_fd_sc_hd__and3_1 _5051_ (.A(_0337_),
    .B(_1047_),
    .C(_1049_),
    .X(_1050_));
 sky130_fd_sc_hd__a221o_1 _5052_ (.A1(_0337_),
    .A2(_1021_),
    .B1(_1045_),
    .B2(_1050_),
    .C1(_0339_),
    .X(_1051_));
 sky130_fd_sc_hd__a21o_1 _5053_ (.A1(_0325_),
    .A2(_0333_),
    .B1(_0327_),
    .X(_1052_));
 sky130_fd_sc_hd__a21oi_1 _5054_ (.A1(_0319_),
    .A2(_1052_),
    .B1(_0321_),
    .Y(_1053_));
 sky130_fd_sc_hd__o21bai_1 _5055_ (.A1(_1012_),
    .A2(_1053_),
    .B1_N(_0315_),
    .Y(_1054_));
 sky130_fd_sc_hd__a31o_2 _5056_ (.A1(_0331_),
    .A2(_1016_),
    .A3(_1051_),
    .B1(_1054_),
    .X(_1055_));
 sky130_fd_sc_hd__nand2_1 _5059_ (.A(_0287_),
    .B(_0281_),
    .Y(_1058_));
 sky130_fd_sc_hd__nand2_1 _5062_ (.A(_0293_),
    .B(_0299_),
    .Y(_1061_));
 sky130_fd_sc_hd__nor2_1 _5063_ (.A(_1058_),
    .B(_1061_),
    .Y(_1062_));
 sky130_fd_sc_hd__a21o_1 _5064_ (.A1(_0299_),
    .A2(_0309_),
    .B1(_0301_),
    .X(_1063_));
 sky130_fd_sc_hd__a21oi_1 _5065_ (.A1(_0293_),
    .A2(_1063_),
    .B1(_0295_),
    .Y(_1064_));
 sky130_fd_sc_hd__a21oi_1 _5066_ (.A1(_0281_),
    .A2(_0289_),
    .B1(_0283_),
    .Y(_1065_));
 sky130_fd_sc_hd__o21ai_0 _5067_ (.A1(_1058_),
    .A2(_1064_),
    .B1(_1065_),
    .Y(_1066_));
 sky130_fd_sc_hd__a31oi_1 _5068_ (.A1(_0307_),
    .A2(_1055_),
    .A3(_1062_),
    .B1(_1066_),
    .Y(_1067_));
 sky130_fd_sc_hd__a21o_1 _5069_ (.A1(_0266_),
    .A2(_0277_),
    .B1(_0268_),
    .X(_1068_));
 sky130_fd_sc_hd__a21oi_1 _5070_ (.A1(_0260_),
    .A2(_1068_),
    .B1(_0262_),
    .Y(_1069_));
 sky130_fd_sc_hd__o21ai_1 _5071_ (.A1(_1009_),
    .A2(_1067_),
    .B1(_1069_),
    .Y(_1070_));
 sky130_fd_sc_hd__xnor2_1 _5072_ (.A(_1005_),
    .B(_1070_),
    .Y(_1071_));
 sky130_fd_sc_hd__inv_1 _5073_ (.A(_0266_),
    .Y(_1072_));
 sky130_fd_sc_hd__inv_1 _5074_ (.A(_0275_),
    .Y(_1073_));
 sky130_fd_sc_hd__inv_1 _5075_ (.A(_0281_),
    .Y(_1074_));
 sky130_fd_sc_hd__nand3_1 _5076_ (.A(_1072_),
    .B(_1073_),
    .C(_1074_),
    .Y(_1075_));
 sky130_fd_sc_hd__nor2b_1 _5077_ (.A(_0287_),
    .B_N(_0294_),
    .Y(_1076_));
 sky130_fd_sc_hd__nor2_1 _5078_ (.A(_0288_),
    .B(_1076_),
    .Y(_1077_));
 sky130_fd_sc_hd__a21oi_1 _5079_ (.A1(_1073_),
    .A2(_0282_),
    .B1(_0276_),
    .Y(_1078_));
 sky130_fd_sc_hd__o22ai_1 _5080_ (.A1(_1075_),
    .A2(_1077_),
    .B1(_1078_),
    .B2(_0266_),
    .Y(_1079_));
 sky130_fd_sc_hd__nor2_1 _5081_ (.A(_0267_),
    .B(_1079_),
    .Y(_1080_));
 sky130_fd_sc_hd__nor2_1 _5082_ (.A(_0256_),
    .B(_0261_),
    .Y(_1081_));
 sky130_fd_sc_hd__nand2_1 _5083_ (.A(_1080_),
    .B(_1081_),
    .Y(_1082_));
 sky130_fd_sc_hd__nor3_1 _5084_ (.A(_0266_),
    .B(_0275_),
    .C(_0281_),
    .Y(_1083_));
 sky130_fd_sc_hd__nand3b_1 _5085_ (.A_N(_0260_),
    .B(_1083_),
    .C(_0256_),
    .Y(_1084_));
 sky130_fd_sc_hd__nor2_1 _5086_ (.A(_0287_),
    .B(_0293_),
    .Y(_1085_));
 sky130_fd_sc_hd__nor4_1 _5087_ (.A(_0307_),
    .B(_0299_),
    .C(_0313_),
    .D(_0319_),
    .Y(_1086_));
 sky130_fd_sc_hd__nand2_1 _5088_ (.A(_1085_),
    .B(_1086_),
    .Y(_1087_));
 sky130_fd_sc_hd__nor2_1 _5089_ (.A(_0338_),
    .B(_0344_),
    .Y(_1088_));
 sky130_fd_sc_hd__inv_1 _5090_ (.A(_0429_),
    .Y(_1089_));
 sky130_fd_sc_hd__o21bai_1 _5091_ (.A1(_0063_),
    .A2(_0438_),
    .B1_N(_0439_),
    .Y(_1090_));
 sky130_fd_sc_hd__a21o_1 _5092_ (.A1(_1089_),
    .A2(_1090_),
    .B1(_0430_),
    .X(_1091_));
 sky130_fd_sc_hd__nor4_1 _5093_ (.A(_0423_),
    .B(_0397_),
    .C(_0403_),
    .D(_0409_),
    .Y(_1092_));
 sky130_fd_sc_hd__nor2b_1 _5094_ (.A(_0409_),
    .B_N(_0424_),
    .Y(_1093_));
 sky130_fd_sc_hd__nor2_1 _5095_ (.A(_0397_),
    .B(_0403_),
    .Y(_1094_));
 sky130_fd_sc_hd__o21a_1 _5096_ (.A1(_0410_),
    .A2(_1093_),
    .B1(_1094_),
    .X(_1095_));
 sky130_fd_sc_hd__nor2b_1 _5097_ (.A(_0397_),
    .B_N(_0404_),
    .Y(_1096_));
 sky130_fd_sc_hd__a2111oi_2 _5098_ (.A1(_1091_),
    .A2(_1092_),
    .B1(_1095_),
    .C1(_1096_),
    .D1(_0398_),
    .Y(_1097_));
 sky130_fd_sc_hd__nor2_1 _5099_ (.A(_0391_),
    .B(_0385_),
    .Y(_1098_));
 sky130_fd_sc_hd__or3_1 _5100_ (.A(_0367_),
    .B(_0373_),
    .C(_0379_),
    .X(_1099_));
 sky130_fd_sc_hd__nor4_1 _5101_ (.A(_0349_),
    .B(_0355_),
    .C(_0361_),
    .D(_1099_),
    .Y(_1100_));
 sky130_fd_sc_hd__nand3b_1 _5102_ (.A_N(_1097_),
    .B(_1098_),
    .C(_1100_),
    .Y(_1101_));
 sky130_fd_sc_hd__inv_1 _5103_ (.A(_0385_),
    .Y(_1102_));
 sky130_fd_sc_hd__a21o_1 _5104_ (.A1(_1102_),
    .A2(_0392_),
    .B1(_0386_),
    .X(_1103_));
 sky130_fd_sc_hd__nor2_1 _5105_ (.A(_0349_),
    .B(_0355_),
    .Y(_1104_));
 sky130_fd_sc_hd__a21oi_1 _5106_ (.A1(_0380_),
    .A2(_1040_),
    .B1(_0374_),
    .Y(_1105_));
 sky130_fd_sc_hd__inv_1 _5107_ (.A(_0361_),
    .Y(_1106_));
 sky130_fd_sc_hd__a21oi_1 _5108_ (.A1(_0368_),
    .A2(_1106_),
    .B1(_0362_),
    .Y(_1107_));
 sky130_fd_sc_hd__o31ai_1 _5109_ (.A1(_0367_),
    .A2(_0361_),
    .A3(_1105_),
    .B1(_1107_),
    .Y(_1108_));
 sky130_fd_sc_hd__inv_1 _5110_ (.A(_0349_),
    .Y(_1109_));
 sky130_fd_sc_hd__a21o_1 _5111_ (.A1(_0356_),
    .A2(_1109_),
    .B1(_0350_),
    .X(_1110_));
 sky130_fd_sc_hd__a221oi_1 _5112_ (.A1(_1100_),
    .A2(_1103_),
    .B1(_1104_),
    .B2(_1108_),
    .C1(_1110_),
    .Y(_1111_));
 sky130_fd_sc_hd__inv_1 _5113_ (.A(_0344_),
    .Y(_1112_));
 sky130_fd_sc_hd__a21oi_1 _5114_ (.A1(_1112_),
    .A2(_0343_),
    .B1(_0337_),
    .Y(_1113_));
 sky130_fd_sc_hd__nor2_1 _5115_ (.A(_0338_),
    .B(_1113_),
    .Y(_1114_));
 sky130_fd_sc_hd__a31o_2 _5116_ (.A1(_1088_),
    .A2(_1101_),
    .A3(_1111_),
    .B1(_1114_),
    .X(_1115_));
 sky130_fd_sc_hd__inv_1 _5117_ (.A(_0325_),
    .Y(_1116_));
 sky130_fd_sc_hd__a21oi_1 _5118_ (.A1(_0332_),
    .A2(_1116_),
    .B1(_0326_),
    .Y(_1117_));
 sky130_fd_sc_hd__o31a_1 _5119_ (.A1(_0325_),
    .A2(_0331_),
    .A3(_1115_),
    .B1(_1117_),
    .X(_1118_));
 sky130_fd_sc_hd__nor2b_1 _5120_ (.A(_0313_),
    .B_N(_0320_),
    .Y(_1119_));
 sky130_fd_sc_hd__nor2_1 _5121_ (.A(_0307_),
    .B(_0299_),
    .Y(_1120_));
 sky130_fd_sc_hd__o21ai_0 _5122_ (.A1(_0314_),
    .A2(_1119_),
    .B1(_1120_),
    .Y(_1121_));
 sky130_fd_sc_hd__inv_1 _5123_ (.A(_0299_),
    .Y(_1122_));
 sky130_fd_sc_hd__a21oi_1 _5124_ (.A1(_1122_),
    .A2(_0308_),
    .B1(_0300_),
    .Y(_1123_));
 sky130_fd_sc_hd__nand2_1 _5125_ (.A(_1121_),
    .B(_1123_),
    .Y(_1124_));
 sky130_fd_sc_hd__nand2_1 _5126_ (.A(_1085_),
    .B(_1124_),
    .Y(_1125_));
 sky130_fd_sc_hd__o21ai_1 _5127_ (.A1(_1087_),
    .A2(_1118_),
    .B1(_1125_),
    .Y(_1126_));
 sky130_fd_sc_hd__mux2i_1 _5128_ (.A0(_1082_),
    .A1(_1084_),
    .S(_1126_),
    .Y(_1127_));
 sky130_fd_sc_hd__a21oi_1 _5129_ (.A1(_1075_),
    .A2(_1080_),
    .B1(_0260_),
    .Y(_1128_));
 sky130_fd_sc_hd__nor2_1 _5130_ (.A(_0260_),
    .B(_1080_),
    .Y(_1129_));
 sky130_fd_sc_hd__o21ai_0 _5131_ (.A1(_0261_),
    .A2(_1129_),
    .B1(_0256_),
    .Y(_1130_));
 sky130_fd_sc_hd__clkinv_1 _5132_ (.A(instr_sub),
    .Y(_1131_));
 sky130_fd_sc_hd__nor2_1 _5134_ (.A(_1131_),
    .B(net698),
    .Y(_1133_));
 sky130_fd_sc_hd__o311ai_0 _5135_ (.A1(_0256_),
    .A2(_0261_),
    .A3(_1128_),
    .B1(_1130_),
    .C1(_1133_),
    .Y(_1134_));
 sky130_fd_sc_hd__nor2_2 _5137_ (.A(instr_or),
    .B(instr_ori),
    .Y(_1136_));
 sky130_fd_sc_hd__nor2_1 _5138_ (.A(_0452_),
    .B(net726),
    .Y(_1137_));
 sky130_fd_sc_hd__a221oi_1 _5139_ (.A1(_0454_),
    .A2(net728),
    .B1(net727),
    .B2(_0453_),
    .C1(_1137_),
    .Y(_1138_));
 sky130_fd_sc_hd__o21ai_0 _5140_ (.A1(_1127_),
    .A2(_1134_),
    .B1(_1138_),
    .Y(_1139_));
 sky130_fd_sc_hd__a21o_1 _5141_ (.A1(_1004_),
    .A2(_1071_),
    .B1(_1139_),
    .X(\alu_out[30] ));
 sky130_fd_sc_hd__inv_1 _5145_ (.A(_0267_),
    .Y(_1143_));
 sky130_fd_sc_hd__nor4_1 _5146_ (.A(_0319_),
    .B(_0325_),
    .C(_0331_),
    .D(_0337_),
    .Y(_1144_));
 sky130_fd_sc_hd__inv_1 _5147_ (.A(_0355_),
    .Y(_1145_));
 sky130_fd_sc_hd__a21oi_1 _5148_ (.A1(_0362_),
    .A2(_1145_),
    .B1(_0356_),
    .Y(_1146_));
 sky130_fd_sc_hd__nand2b_1 _5149_ (.A_N(_0343_),
    .B(_0350_),
    .Y(_1147_));
 sky130_fd_sc_hd__o311ai_0 _5150_ (.A1(_0343_),
    .A2(_0349_),
    .A3(_1146_),
    .B1(_1147_),
    .C1(_1112_),
    .Y(_1148_));
 sky130_fd_sc_hd__nor2_1 _5151_ (.A(_0325_),
    .B(_0331_),
    .Y(_1149_));
 sky130_fd_sc_hd__nand2_1 _5152_ (.A(_0338_),
    .B(_1149_),
    .Y(_1150_));
 sky130_fd_sc_hd__a21oi_1 _5153_ (.A1(_1117_),
    .A2(_1150_),
    .B1(_0319_),
    .Y(_1151_));
 sky130_fd_sc_hd__a211o_1 _5154_ (.A1(_1144_),
    .A2(_1148_),
    .B1(_0320_),
    .C1(_1151_),
    .X(_1152_));
 sky130_fd_sc_hd__nor4_1 _5155_ (.A(_0391_),
    .B(_0385_),
    .C(_0379_),
    .D(_0397_),
    .Y(_1153_));
 sky130_fd_sc_hd__inv_1 _5156_ (.A(_0424_),
    .Y(_1154_));
 sky130_fd_sc_hd__a21oi_1 _5157_ (.A1(_0423_),
    .A2(_1154_),
    .B1(_0409_),
    .Y(_1155_));
 sky130_fd_sc_hd__or3_1 _5158_ (.A(_0410_),
    .B(_0430_),
    .C(_0424_),
    .X(_1156_));
 sky130_fd_sc_hd__nor2_1 _5159_ (.A(_0062_),
    .B(_0241_),
    .Y(_1157_));
 sky130_fd_sc_hd__nand2b_1 _5160_ (.A_N(_0439_),
    .B(_0438_),
    .Y(_1158_));
 sky130_fd_sc_hd__o311a_1 _5161_ (.A1(_0442_),
    .A2(_0439_),
    .A3(_1157_),
    .B1(_1158_),
    .C1(_1089_),
    .X(_1159_));
 sky130_fd_sc_hd__inv_1 _5162_ (.A(_0403_),
    .Y(_1160_));
 sky130_fd_sc_hd__o221a_2 _5163_ (.A1(_0410_),
    .A2(_1155_),
    .B1(_1156_),
    .B2(_1159_),
    .C1(_1160_),
    .X(_1161_));
 sky130_fd_sc_hd__inv_1 _5164_ (.A(_0367_),
    .Y(_1162_));
 sky130_fd_sc_hd__a21o_1 _5165_ (.A1(_1162_),
    .A2(_0374_),
    .B1(_0368_),
    .X(_1163_));
 sky130_fd_sc_hd__nor2b_1 _5166_ (.A(_0391_),
    .B_N(_0398_),
    .Y(_1164_));
 sky130_fd_sc_hd__nor3_1 _5167_ (.A(_0386_),
    .B(_0392_),
    .C(_1164_),
    .Y(_1165_));
 sky130_fd_sc_hd__o21ai_0 _5168_ (.A1(_0386_),
    .A2(_1102_),
    .B1(_1041_),
    .Y(_1166_));
 sky130_fd_sc_hd__a21oi_1 _5169_ (.A1(_0404_),
    .A2(_1153_),
    .B1(_0380_),
    .Y(_1167_));
 sky130_fd_sc_hd__o21ai_0 _5170_ (.A1(_1165_),
    .A2(_1166_),
    .B1(_1167_),
    .Y(_1168_));
 sky130_fd_sc_hd__a211o_1 _5171_ (.A1(_1153_),
    .A2(_1161_),
    .B1(_1163_),
    .C1(_1168_),
    .X(_1169_));
 sky130_fd_sc_hd__nand2_1 _5172_ (.A(_1162_),
    .B(_1040_),
    .Y(_1170_));
 sky130_fd_sc_hd__a21oi_1 _5173_ (.A1(_1162_),
    .A2(_0374_),
    .B1(_0368_),
    .Y(_1171_));
 sky130_fd_sc_hd__nor4_1 _5174_ (.A(_0343_),
    .B(_0349_),
    .C(_0355_),
    .D(_0361_),
    .Y(_1172_));
 sky130_fd_sc_hd__nand2_1 _5175_ (.A(_1144_),
    .B(_1172_),
    .Y(_1173_));
 sky130_fd_sc_hd__a21oi_1 _5176_ (.A1(_1170_),
    .A2(_1171_),
    .B1(_1173_),
    .Y(_1174_));
 sky130_fd_sc_hd__and2_1 _5177_ (.A(_1012_),
    .B(_1174_),
    .X(_1175_));
 sky130_fd_sc_hd__or3_1 _5178_ (.A(_0300_),
    .B(_0308_),
    .C(_0314_),
    .X(_1176_));
 sky130_fd_sc_hd__a221oi_1 _5179_ (.A1(_1012_),
    .A2(_1152_),
    .B1(_1169_),
    .B2(_1175_),
    .C1(_1176_),
    .Y(_1177_));
 sky130_fd_sc_hd__nand2b_1 _5180_ (.A_N(_0300_),
    .B(_0307_),
    .Y(_1178_));
 sky130_fd_sc_hd__o22ai_1 _5181_ (.A1(_1122_),
    .A2(_0300_),
    .B1(_0308_),
    .B2(_1178_),
    .Y(_1179_));
 sky130_fd_sc_hd__nor4_1 _5182_ (.A(_0287_),
    .B(_0293_),
    .C(_1177_),
    .D(_1179_),
    .Y(_1180_));
 sky130_fd_sc_hd__o21ai_0 _5183_ (.A1(_1076_),
    .A2(_1180_),
    .B1(_1083_),
    .Y(_1181_));
 sky130_fd_sc_hd__a21oi_1 _5184_ (.A1(_1074_),
    .A2(_0288_),
    .B1(_0282_),
    .Y(_1182_));
 sky130_fd_sc_hd__nor2_1 _5185_ (.A(_0275_),
    .B(_1182_),
    .Y(_1183_));
 sky130_fd_sc_hd__o21ai_0 _5186_ (.A1(_0276_),
    .A2(_1183_),
    .B1(_1072_),
    .Y(_1184_));
 sky130_fd_sc_hd__a211oi_1 _5187_ (.A1(_0066_),
    .A2(_0241_),
    .B1(_0440_),
    .C1(_0443_),
    .Y(_1185_));
 sky130_fd_sc_hd__o21ai_0 _5188_ (.A1(_0438_),
    .A2(_0440_),
    .B1(_0429_),
    .Y(_1186_));
 sky130_fd_sc_hd__o21bai_1 _5189_ (.A1(_1185_),
    .A2(_1186_),
    .B1_N(_0431_),
    .Y(_1187_));
 sky130_fd_sc_hd__a211o_1 _5190_ (.A1(_0403_),
    .A2(_0411_),
    .B1(_0425_),
    .C1(_0405_),
    .X(_1188_));
 sky130_fd_sc_hd__inv_1 _5191_ (.A(_0405_),
    .Y(_1189_));
 sky130_fd_sc_hd__o21ai_0 _5192_ (.A1(_0409_),
    .A2(_0411_),
    .B1(_0403_),
    .Y(_1190_));
 sky130_fd_sc_hd__a2111oi_0 _5193_ (.A1(_0403_),
    .A2(_0411_),
    .B1(_0425_),
    .C1(_0405_),
    .D1(_0423_),
    .Y(_1191_));
 sky130_fd_sc_hd__a21oi_1 _5194_ (.A1(_1189_),
    .A2(_1190_),
    .B1(_1191_),
    .Y(_1192_));
 sky130_fd_sc_hd__nand2_1 _5195_ (.A(_0391_),
    .B(_0397_),
    .Y(_1193_));
 sky130_fd_sc_hd__nor3_1 _5196_ (.A(_1102_),
    .B(_1041_),
    .C(_1193_),
    .Y(_1194_));
 sky130_fd_sc_hd__o211ai_1 _5197_ (.A1(_1187_),
    .A2(_1188_),
    .B1(_1192_),
    .C1(_1194_),
    .Y(_1195_));
 sky130_fd_sc_hd__and2_1 _5198_ (.A(_0391_),
    .B(_0399_),
    .X(_1196_));
 sky130_fd_sc_hd__o211ai_1 _5199_ (.A1(_0393_),
    .A2(_1196_),
    .B1(_0385_),
    .C1(_0379_),
    .Y(_1197_));
 sky130_fd_sc_hd__a21oi_1 _5200_ (.A1(_0379_),
    .A2(_0387_),
    .B1(_0381_),
    .Y(_1198_));
 sky130_fd_sc_hd__and3_1 _5201_ (.A(_1195_),
    .B(_1197_),
    .C(_1198_),
    .X(_1199_));
 sky130_fd_sc_hd__and3_1 _5202_ (.A(_0367_),
    .B(_0361_),
    .C(_1047_),
    .X(_1200_));
 sky130_fd_sc_hd__nand4_1 _5203_ (.A(_0331_),
    .B(_0337_),
    .C(_0373_),
    .D(_1200_),
    .Y(_1201_));
 sky130_fd_sc_hd__a21o_1 _5204_ (.A1(_0367_),
    .A2(_0375_),
    .B1(_0369_),
    .X(_1202_));
 sky130_fd_sc_hd__a21oi_1 _5205_ (.A1(_0361_),
    .A2(_1202_),
    .B1(_0363_),
    .Y(_1203_));
 sky130_fd_sc_hd__nor3_1 _5206_ (.A(_0345_),
    .B(_0351_),
    .C(_0357_),
    .Y(_1204_));
 sky130_fd_sc_hd__o21ai_0 _5207_ (.A1(_1145_),
    .A2(_1203_),
    .B1(_1204_),
    .Y(_1205_));
 sky130_fd_sc_hd__nor3_1 _5208_ (.A(_0345_),
    .B(_0349_),
    .C(_0351_),
    .Y(_1206_));
 sky130_fd_sc_hd__nor2_1 _5209_ (.A(_0343_),
    .B(_0345_),
    .Y(_1207_));
 sky130_fd_sc_hd__nor2_1 _5210_ (.A(_1206_),
    .B(_1207_),
    .Y(_1208_));
 sky130_fd_sc_hd__nand4_1 _5211_ (.A(_0331_),
    .B(_0337_),
    .C(_1205_),
    .D(_1208_),
    .Y(_1209_));
 sky130_fd_sc_hd__a21oi_1 _5212_ (.A1(_0331_),
    .A2(_0339_),
    .B1(_0333_),
    .Y(_1210_));
 sky130_fd_sc_hd__o211ai_1 _5213_ (.A1(_1199_),
    .A2(_1201_),
    .B1(_1209_),
    .C1(_1210_),
    .Y(_1211_));
 sky130_fd_sc_hd__a21oi_1 _5214_ (.A1(_0319_),
    .A2(_0327_),
    .B1(_0321_),
    .Y(_1212_));
 sky130_fd_sc_hd__a21oi_1 _5215_ (.A1(_0307_),
    .A2(_0315_),
    .B1(_0309_),
    .Y(_1213_));
 sky130_fd_sc_hd__a21oi_1 _5216_ (.A1(_0293_),
    .A2(_0301_),
    .B1(_0295_),
    .Y(_1214_));
 sky130_fd_sc_hd__and2_1 _5217_ (.A(_1065_),
    .B(_1214_),
    .X(_1215_));
 sky130_fd_sc_hd__nand3_1 _5218_ (.A(_1212_),
    .B(_1213_),
    .C(_1215_),
    .Y(_1216_));
 sky130_fd_sc_hd__nand2_1 _5219_ (.A(_0307_),
    .B(_0313_),
    .Y(_1217_));
 sky130_fd_sc_hd__a21oi_1 _5220_ (.A1(_1015_),
    .A2(_1212_),
    .B1(_1217_),
    .Y(_1218_));
 sky130_fd_sc_hd__nand2b_1 _5221_ (.A_N(_1218_),
    .B(_1213_),
    .Y(_1219_));
 sky130_fd_sc_hd__nand3_1 _5222_ (.A(_0293_),
    .B(_0299_),
    .C(_1219_),
    .Y(_1220_));
 sky130_fd_sc_hd__a22oi_1 _5223_ (.A1(_1065_),
    .A2(_1058_),
    .B1(_1220_),
    .B2(_1215_),
    .Y(_1221_));
 sky130_fd_sc_hd__o21ai_0 _5224_ (.A1(_1211_),
    .A2(_1216_),
    .B1(_1221_),
    .Y(_1222_));
 sky130_fd_sc_hd__nor2b_1 _5226_ (.A(net767),
    .B_N(_0268_),
    .Y(_1224_));
 sky130_fd_sc_hd__a31oi_1 _5227_ (.A1(_1131_),
    .A2(_0266_),
    .A3(_0277_),
    .B1(_1224_),
    .Y(_1225_));
 sky130_fd_sc_hd__o41ai_1 _5228_ (.A1(net767),
    .A2(_1072_),
    .A3(_1073_),
    .A4(_1222_),
    .B1(_1225_),
    .Y(_1226_));
 sky130_fd_sc_hd__a41oi_1 _5229_ (.A1(net767),
    .A2(_1143_),
    .A3(_1181_),
    .A4(_1184_),
    .B1(_1226_),
    .Y(_1227_));
 sky130_fd_sc_hd__xor2_1 _5230_ (.A(_0260_),
    .B(_1227_),
    .X(_1228_));
 sky130_fd_sc_hd__nor2_1 _5234_ (.A(_0259_),
    .B(net726),
    .Y(_1232_));
 sky130_fd_sc_hd__a221oi_1 _5235_ (.A1(_0262_),
    .A2(net728),
    .B1(net727),
    .B2(_0260_),
    .C1(_1232_),
    .Y(_1233_));
 sky130_fd_sc_hd__o21ai_0 _5236_ (.A1(net698),
    .A2(_1228_),
    .B1(_1233_),
    .Y(\alu_out[29] ));
 sky130_fd_sc_hd__nor2_1 _5237_ (.A(net767),
    .B(_0277_),
    .Y(_1234_));
 sky130_fd_sc_hd__o31ai_1 _5238_ (.A1(_0325_),
    .A2(_0331_),
    .A3(_1115_),
    .B1(_1117_),
    .Y(_1235_));
 sky130_fd_sc_hd__nor3_1 _5239_ (.A(_0275_),
    .B(_0281_),
    .C(_1087_),
    .Y(_1236_));
 sky130_fd_sc_hd__nor2_1 _5240_ (.A(_0281_),
    .B(_1077_),
    .Y(_1237_));
 sky130_fd_sc_hd__a2111oi_0 _5241_ (.A1(_1121_),
    .A2(_1123_),
    .B1(_0287_),
    .C1(_0281_),
    .D1(_0293_),
    .Y(_1238_));
 sky130_fd_sc_hd__o31a_1 _5242_ (.A1(_0282_),
    .A2(_1237_),
    .A3(_1238_),
    .B1(_1073_),
    .X(_1239_));
 sky130_fd_sc_hd__o21ai_0 _5243_ (.A1(_0276_),
    .A2(_1239_),
    .B1(net767),
    .Y(_1240_));
 sky130_fd_sc_hd__o31ai_1 _5244_ (.A1(net767),
    .A2(_0275_),
    .A3(_0277_),
    .B1(_1240_),
    .Y(_1241_));
 sky130_fd_sc_hd__a31o_2 _5245_ (.A1(net767),
    .A2(_1235_),
    .A3(net689),
    .B1(_1241_),
    .X(_1242_));
 sky130_fd_sc_hd__nor3_1 _5246_ (.A(_0266_),
    .B(_1067_),
    .C(_1242_),
    .Y(_1243_));
 sky130_fd_sc_hd__a31oi_1 _5247_ (.A1(_0266_),
    .A2(_1067_),
    .A3(_1234_),
    .B1(_1243_),
    .Y(_1244_));
 sky130_fd_sc_hd__nor4_4 _5248_ (.A(is_compare),
    .B(net728),
    .C(_0999_),
    .D(net727),
    .Y(_1245_));
 sky130_fd_sc_hd__nand3_1 _5249_ (.A(_0266_),
    .B(net709),
    .C(_1242_),
    .Y(_1246_));
 sky130_fd_sc_hd__or4_1 _5250_ (.A(_0266_),
    .B(net698),
    .C(_1234_),
    .D(_1242_),
    .X(_1247_));
 sky130_fd_sc_hd__nor2_1 _5251_ (.A(_0265_),
    .B(net726),
    .Y(_1248_));
 sky130_fd_sc_hd__a221oi_1 _5252_ (.A1(_0268_),
    .A2(net728),
    .B1(net727),
    .B2(_0266_),
    .C1(_1248_),
    .Y(_1249_));
 sky130_fd_sc_hd__nand3_1 _5253_ (.A(_1246_),
    .B(_1247_),
    .C(_1249_),
    .Y(_1250_));
 sky130_fd_sc_hd__o21bai_1 _5254_ (.A1(net698),
    .A2(_1244_),
    .B1_N(_1250_),
    .Y(\alu_out[28] ));
 sky130_fd_sc_hd__o41ai_1 _5255_ (.A1(_0287_),
    .A2(_0293_),
    .A3(_1177_),
    .A4(_1179_),
    .B1(_1077_),
    .Y(_1251_));
 sky130_fd_sc_hd__a21oi_1 _5256_ (.A1(_1074_),
    .A2(_1251_),
    .B1(_0282_),
    .Y(_1252_));
 sky130_fd_sc_hd__nor2_1 _5257_ (.A(net767),
    .B(_1222_),
    .Y(_1253_));
 sky130_fd_sc_hd__a21oi_1 _5258_ (.A1(net767),
    .A2(_1252_),
    .B1(_1253_),
    .Y(_1254_));
 sky130_fd_sc_hd__xnor2_1 _5259_ (.A(_1073_),
    .B(_1254_),
    .Y(_1255_));
 sky130_fd_sc_hd__nor2_1 _5260_ (.A(_0274_),
    .B(net726),
    .Y(_1256_));
 sky130_fd_sc_hd__a221oi_1 _5261_ (.A1(_0277_),
    .A2(net728),
    .B1(net727),
    .B2(_0275_),
    .C1(_1256_),
    .Y(_1257_));
 sky130_fd_sc_hd__o21ai_0 _5262_ (.A1(net698),
    .A2(_1255_),
    .B1(_1257_),
    .Y(\alu_out[27] ));
 sky130_fd_sc_hd__nand2_1 _5263_ (.A(net767),
    .B(_1077_),
    .Y(_1258_));
 sky130_fd_sc_hd__nand2_1 _5264_ (.A(_0307_),
    .B(_0287_),
    .Y(_1259_));
 sky130_fd_sc_hd__nor2_1 _5265_ (.A(_1061_),
    .B(_1259_),
    .Y(_1260_));
 sky130_fd_sc_hd__inv_1 _5266_ (.A(_0287_),
    .Y(_1261_));
 sky130_fd_sc_hd__nor2_1 _5267_ (.A(_1261_),
    .B(_1064_),
    .Y(_1262_));
 sky130_fd_sc_hd__a211oi_1 _5268_ (.A1(_1055_),
    .A2(_1260_),
    .B1(_1262_),
    .C1(_0289_),
    .Y(_1263_));
 sky130_fd_sc_hd__o22ai_1 _5269_ (.A1(_1126_),
    .A2(_1258_),
    .B1(_1263_),
    .B2(net767),
    .Y(_1264_));
 sky130_fd_sc_hd__xnor2_1 _5270_ (.A(_0281_),
    .B(_1264_),
    .Y(_1265_));
 sky130_fd_sc_hd__nor2_1 _5271_ (.A(_0280_),
    .B(net726),
    .Y(_1266_));
 sky130_fd_sc_hd__a221oi_1 _5272_ (.A1(_0283_),
    .A2(net728),
    .B1(net727),
    .B2(_0281_),
    .C1(_1266_),
    .Y(_1267_));
 sky130_fd_sc_hd__o21ai_0 _5273_ (.A1(net698),
    .A2(_1265_),
    .B1(_1267_),
    .Y(\alu_out[26] ));
 sky130_fd_sc_hd__nand2_1 _5274_ (.A(_1212_),
    .B(_1213_),
    .Y(_1268_));
 sky130_fd_sc_hd__o21ai_0 _5275_ (.A1(_1268_),
    .A2(_1211_),
    .B1(_1219_),
    .Y(_1269_));
 sky130_fd_sc_hd__o21ai_0 _5276_ (.A1(_1061_),
    .A2(_1269_),
    .B1(_1214_),
    .Y(_1270_));
 sky130_fd_sc_hd__nor3_1 _5277_ (.A(_0293_),
    .B(_1177_),
    .C(_1179_),
    .Y(_1271_));
 sky130_fd_sc_hd__nor3_1 _5278_ (.A(_1131_),
    .B(_0294_),
    .C(_1271_),
    .Y(_1272_));
 sky130_fd_sc_hd__a21oi_1 _5279_ (.A1(_1131_),
    .A2(_1270_),
    .B1(_1272_),
    .Y(_1273_));
 sky130_fd_sc_hd__xnor2_1 _5280_ (.A(_1261_),
    .B(_1273_),
    .Y(_1274_));
 sky130_fd_sc_hd__nor2_1 _5281_ (.A(_0286_),
    .B(net726),
    .Y(_1275_));
 sky130_fd_sc_hd__a221oi_1 _5282_ (.A1(_0289_),
    .A2(net728),
    .B1(net727),
    .B2(_0287_),
    .C1(_1275_),
    .Y(_1276_));
 sky130_fd_sc_hd__o21ai_0 _5283_ (.A1(net698),
    .A2(_1274_),
    .B1(_1276_),
    .Y(\alu_out[25] ));
 sky130_fd_sc_hd__nand3_1 _5284_ (.A(net767),
    .B(_1086_),
    .C(_1149_),
    .Y(_1277_));
 sky130_fd_sc_hd__nor2b_1 _5285_ (.A(_1117_),
    .B_N(_1086_),
    .Y(_1278_));
 sky130_fd_sc_hd__o21ai_0 _5286_ (.A1(_1124_),
    .A2(_1278_),
    .B1(net767),
    .Y(_1279_));
 sky130_fd_sc_hd__o21ai_0 _5287_ (.A1(_1115_),
    .A2(_1277_),
    .B1(_1279_),
    .Y(_1280_));
 sky130_fd_sc_hd__a2111oi_0 _5288_ (.A1(_0307_),
    .A2(_1055_),
    .B1(_0301_),
    .C1(net767),
    .D1(_0309_),
    .Y(_1281_));
 sky130_fd_sc_hd__nor3_1 _5289_ (.A(net767),
    .B(_0299_),
    .C(_0301_),
    .Y(_1282_));
 sky130_fd_sc_hd__nor3_1 _5290_ (.A(_1280_),
    .B(_1281_),
    .C(_1282_),
    .Y(_1283_));
 sky130_fd_sc_hd__xnor2_1 _5291_ (.A(_0293_),
    .B(_1283_),
    .Y(_1284_));
 sky130_fd_sc_hd__nor2_1 _5292_ (.A(_0292_),
    .B(net726),
    .Y(_1285_));
 sky130_fd_sc_hd__a221oi_1 _5293_ (.A1(_0295_),
    .A2(net728),
    .B1(net727),
    .B2(_0293_),
    .C1(_1285_),
    .Y(_1286_));
 sky130_fd_sc_hd__o21ai_1 _5294_ (.A1(net698),
    .A2(_1284_),
    .B1(_1286_),
    .Y(\alu_out[24] ));
 sky130_fd_sc_hd__a221oi_1 _5299_ (.A1(_1012_),
    .A2(_1152_),
    .B1(_1169_),
    .B2(_1175_),
    .C1(_0314_),
    .Y(_1291_));
 sky130_fd_sc_hd__nor2_1 _5300_ (.A(_1131_),
    .B(_0308_),
    .Y(_1292_));
 sky130_fd_sc_hd__o21ai_0 _5301_ (.A1(_0307_),
    .A2(_1291_),
    .B1(_1292_),
    .Y(_1293_));
 sky130_fd_sc_hd__o21ai_0 _5302_ (.A1(net767),
    .A2(_1269_),
    .B1(_1293_),
    .Y(_1294_));
 sky130_fd_sc_hd__xnor2_1 _5303_ (.A(_0299_),
    .B(_1294_),
    .Y(_1295_));
 sky130_fd_sc_hd__a22oi_1 _5307_ (.A1(_0301_),
    .A2(net728),
    .B1(net727),
    .B2(_0299_),
    .Y(_1299_));
 sky130_fd_sc_hd__o221ai_1 _5308_ (.A1(_0298_),
    .A2(net726),
    .B1(net698),
    .B2(_1295_),
    .C1(_1299_),
    .Y(\alu_out[23] ));
 sky130_fd_sc_hd__nand2_1 _5309_ (.A(_1131_),
    .B(_1055_),
    .Y(_1300_));
 sky130_fd_sc_hd__nor3_1 _5310_ (.A(_1131_),
    .B(_0314_),
    .C(_0320_),
    .Y(_1301_));
 sky130_fd_sc_hd__o21ai_0 _5311_ (.A1(_0319_),
    .A2(_1118_),
    .B1(_1301_),
    .Y(_1302_));
 sky130_fd_sc_hd__o311ai_0 _5312_ (.A1(_1131_),
    .A2(_1012_),
    .A3(_0314_),
    .B1(_1300_),
    .C1(_1302_),
    .Y(_1303_));
 sky130_fd_sc_hd__xnor2_1 _5313_ (.A(_0307_),
    .B(_1303_),
    .Y(_1304_));
 sky130_fd_sc_hd__nor2_1 _5314_ (.A(_0306_),
    .B(net726),
    .Y(_1305_));
 sky130_fd_sc_hd__a221oi_1 _5315_ (.A1(_0309_),
    .A2(net728),
    .B1(net727),
    .B2(_0307_),
    .C1(_1305_),
    .Y(_1306_));
 sky130_fd_sc_hd__o21ai_0 _5316_ (.A1(net698),
    .A2(_1304_),
    .B1(_1306_),
    .Y(\alu_out[22] ));
 sky130_fd_sc_hd__nand3_1 _5317_ (.A(_0319_),
    .B(_0325_),
    .C(_1211_),
    .Y(_1307_));
 sky130_fd_sc_hd__a21oi_1 _5318_ (.A1(_1212_),
    .A2(_1307_),
    .B1(net767),
    .Y(_1308_));
 sky130_fd_sc_hd__a211oi_1 _5319_ (.A1(_1169_),
    .A2(_1174_),
    .B1(_1131_),
    .C1(_1152_),
    .Y(_1309_));
 sky130_fd_sc_hd__nor2_1 _5320_ (.A(_1308_),
    .B(_1309_),
    .Y(_1310_));
 sky130_fd_sc_hd__xnor2_1 _5321_ (.A(_1012_),
    .B(_1310_),
    .Y(_1311_));
 sky130_fd_sc_hd__nor2_1 _5322_ (.A(_0312_),
    .B(net726),
    .Y(_1312_));
 sky130_fd_sc_hd__a221oi_1 _5323_ (.A1(_0315_),
    .A2(net728),
    .B1(net727),
    .B2(_0313_),
    .C1(_1312_),
    .Y(_1313_));
 sky130_fd_sc_hd__o21ai_0 _5324_ (.A1(net698),
    .A2(_1311_),
    .B1(_1313_),
    .Y(\alu_out[21] ));
 sky130_fd_sc_hd__a21o_1 _5325_ (.A1(_0331_),
    .A2(_1051_),
    .B1(_0333_),
    .X(_1314_));
 sky130_fd_sc_hd__a211oi_1 _5326_ (.A1(_0325_),
    .A2(_1314_),
    .B1(_0327_),
    .C1(net767),
    .Y(_1315_));
 sky130_fd_sc_hd__a21oi_1 _5327_ (.A1(net767),
    .A2(_1235_),
    .B1(_1315_),
    .Y(_1316_));
 sky130_fd_sc_hd__xnor2_1 _5328_ (.A(_0319_),
    .B(_1316_),
    .Y(_1317_));
 sky130_fd_sc_hd__nor2_1 _5329_ (.A(_0318_),
    .B(net726),
    .Y(_1318_));
 sky130_fd_sc_hd__a221oi_1 _5330_ (.A1(_0321_),
    .A2(net728),
    .B1(net727),
    .B2(_0319_),
    .C1(_1318_),
    .Y(_1319_));
 sky130_fd_sc_hd__o21ai_0 _5331_ (.A1(net698),
    .A2(_1317_),
    .B1(_1319_),
    .Y(\alu_out[20] ));
 sky130_fd_sc_hd__inv_1 _5332_ (.A(_0331_),
    .Y(_1320_));
 sky130_fd_sc_hd__a21oi_1 _5333_ (.A1(_1153_),
    .A2(_1161_),
    .B1(_1168_),
    .Y(_1321_));
 sky130_fd_sc_hd__o21ai_0 _5334_ (.A1(_1170_),
    .A2(_1321_),
    .B1(_1171_),
    .Y(_1322_));
 sky130_fd_sc_hd__a21oi_1 _5335_ (.A1(_1172_),
    .A2(_1322_),
    .B1(_1148_),
    .Y(_1323_));
 sky130_fd_sc_hd__o21bai_1 _5336_ (.A1(_0337_),
    .A2(_1323_),
    .B1_N(_0338_),
    .Y(_1324_));
 sky130_fd_sc_hd__a211oi_1 _5337_ (.A1(_1320_),
    .A2(_1324_),
    .B1(_1131_),
    .C1(_0332_),
    .Y(_1325_));
 sky130_fd_sc_hd__and2_1 _5338_ (.A(_1131_),
    .B(_1211_),
    .X(_1326_));
 sky130_fd_sc_hd__nor3_1 _5339_ (.A(_0325_),
    .B(_1325_),
    .C(_1326_),
    .Y(_1327_));
 sky130_fd_sc_hd__o21a_1 _5340_ (.A1(_1325_),
    .A2(_1326_),
    .B1(_0325_),
    .X(_1328_));
 sky130_fd_sc_hd__nor2_1 _5341_ (.A(_0324_),
    .B(net726),
    .Y(_1329_));
 sky130_fd_sc_hd__a221oi_1 _5342_ (.A1(_0327_),
    .A2(net728),
    .B1(net727),
    .B2(_0325_),
    .C1(_1329_),
    .Y(_1330_));
 sky130_fd_sc_hd__o31ai_1 _5343_ (.A1(net698),
    .A2(_1327_),
    .A3(_1328_),
    .B1(_1330_),
    .Y(\alu_out[19] ));
 sky130_fd_sc_hd__mux2_2 _5344_ (.A0(_1115_),
    .A1(_1051_),
    .S(_1131_),
    .X(_1331_));
 sky130_fd_sc_hd__nor2_1 _5345_ (.A(net698),
    .B(_1331_),
    .Y(_1332_));
 sky130_fd_sc_hd__o21ai_0 _5346_ (.A1(net727),
    .A2(_1332_),
    .B1(_0331_),
    .Y(_1333_));
 sky130_fd_sc_hd__nand3_1 _5347_ (.A(_1320_),
    .B(net709),
    .C(_1331_),
    .Y(_1334_));
 sky130_fd_sc_hd__nand2_1 _5348_ (.A(_0333_),
    .B(net728),
    .Y(_1335_));
 sky130_fd_sc_hd__o2111ai_1 _5349_ (.A1(_0330_),
    .A2(net726),
    .B1(_1333_),
    .C1(_1334_),
    .D1(_1335_),
    .Y(\alu_out[18] ));
 sky130_fd_sc_hd__nand2_1 _5350_ (.A(_1205_),
    .B(_1208_),
    .Y(_1336_));
 sky130_fd_sc_hd__nand3_1 _5351_ (.A(_1195_),
    .B(_1197_),
    .C(_1198_),
    .Y(_1337_));
 sky130_fd_sc_hd__nand3_1 _5352_ (.A(_0373_),
    .B(_1337_),
    .C(_1200_),
    .Y(_1338_));
 sky130_fd_sc_hd__a21oi_1 _5353_ (.A1(_1336_),
    .A2(_1338_),
    .B1(net767),
    .Y(_1339_));
 sky130_fd_sc_hd__a21oi_1 _5354_ (.A1(net767),
    .A2(_1323_),
    .B1(_1339_),
    .Y(_1340_));
 sky130_fd_sc_hd__and2_1 _5355_ (.A(net709),
    .B(_1340_),
    .X(_1341_));
 sky130_fd_sc_hd__o21ai_0 _5356_ (.A1(net727),
    .A2(_1341_),
    .B1(_0337_),
    .Y(_1342_));
 sky130_fd_sc_hd__nor2_1 _5357_ (.A(_0336_),
    .B(net726),
    .Y(_1343_));
 sky130_fd_sc_hd__a21oi_1 _5358_ (.A1(_0339_),
    .A2(net728),
    .B1(_1343_),
    .Y(_1344_));
 sky130_fd_sc_hd__o311ai_1 _5359_ (.A1(_0337_),
    .A2(net698),
    .A3(_1340_),
    .B1(_1342_),
    .C1(_1344_),
    .Y(\alu_out[17] ));
 sky130_fd_sc_hd__a31o_2 _5360_ (.A1(_0355_),
    .A2(_1045_),
    .A3(_1049_),
    .B1(_0357_),
    .X(_1345_));
 sky130_fd_sc_hd__a21oi_1 _5361_ (.A1(_0349_),
    .A2(_1345_),
    .B1(_0351_),
    .Y(_1346_));
 sky130_fd_sc_hd__a21oi_1 _5362_ (.A1(_1101_),
    .A2(_1111_),
    .B1(_1131_),
    .Y(_1347_));
 sky130_fd_sc_hd__a21o_1 _5363_ (.A1(_1131_),
    .A2(_1346_),
    .B1(_1347_),
    .X(_1348_));
 sky130_fd_sc_hd__a21oi_1 _5364_ (.A1(net709),
    .A2(_1348_),
    .B1(net727),
    .Y(_1349_));
 sky130_fd_sc_hd__nand2b_1 _5365_ (.A_N(_1349_),
    .B(_0343_),
    .Y(_1350_));
 sky130_fd_sc_hd__nor2_1 _5366_ (.A(_0342_),
    .B(net726),
    .Y(_1351_));
 sky130_fd_sc_hd__a21oi_1 _5367_ (.A1(_0345_),
    .A2(net728),
    .B1(_1351_),
    .Y(_1352_));
 sky130_fd_sc_hd__o311ai_1 _5368_ (.A1(_0343_),
    .A2(net698),
    .A3(_1348_),
    .B1(_1350_),
    .C1(_1352_),
    .Y(\alu_out[16] ));
 sky130_fd_sc_hd__nand3_1 _5369_ (.A(_1145_),
    .B(_1106_),
    .C(_1322_),
    .Y(_1353_));
 sky130_fd_sc_hd__nand2_1 _5370_ (.A(_1146_),
    .B(_1353_),
    .Y(_1354_));
 sky130_fd_sc_hd__nor3_1 _5371_ (.A(net767),
    .B(_0355_),
    .C(_0357_),
    .Y(_1355_));
 sky130_fd_sc_hd__nor4_1 _5372_ (.A(net767),
    .B(_0357_),
    .C(_0361_),
    .D(_0363_),
    .Y(_1356_));
 sky130_fd_sc_hd__a21oi_1 _5373_ (.A1(_0373_),
    .A2(_1337_),
    .B1(_0375_),
    .Y(_1357_));
 sky130_fd_sc_hd__o21bai_1 _5374_ (.A1(_1162_),
    .A2(_1357_),
    .B1_N(_0369_),
    .Y(_1358_));
 sky130_fd_sc_hd__nor4_1 _5375_ (.A(net767),
    .B(_0357_),
    .C(_0363_),
    .D(_1358_),
    .Y(_1359_));
 sky130_fd_sc_hd__a2111oi_0 _5376_ (.A1(net767),
    .A2(_1354_),
    .B1(_1355_),
    .C1(_1356_),
    .D1(_1359_),
    .Y(_1360_));
 sky130_fd_sc_hd__xnor2_1 _5377_ (.A(_0349_),
    .B(_1360_),
    .Y(_1361_));
 sky130_fd_sc_hd__nor2_1 _5378_ (.A(_0348_),
    .B(net726),
    .Y(_1362_));
 sky130_fd_sc_hd__a221oi_1 _5379_ (.A1(_0351_),
    .A2(net728),
    .B1(net727),
    .B2(_0349_),
    .C1(_1362_),
    .Y(_1363_));
 sky130_fd_sc_hd__o21ai_0 _5380_ (.A1(net698),
    .A2(_1361_),
    .B1(_1363_),
    .Y(\alu_out[15] ));
 sky130_fd_sc_hd__nand2_1 _5381_ (.A(_1045_),
    .B(_1049_),
    .Y(_1364_));
 sky130_fd_sc_hd__a21oi_1 _5382_ (.A1(_1102_),
    .A2(_0392_),
    .B1(_0386_),
    .Y(_1365_));
 sky130_fd_sc_hd__nor2_1 _5383_ (.A(_0361_),
    .B(_1099_),
    .Y(_1366_));
 sky130_fd_sc_hd__o21ai_0 _5384_ (.A1(_1103_),
    .A2(_1098_),
    .B1(_1366_),
    .Y(_1367_));
 sky130_fd_sc_hd__a21oi_1 _5385_ (.A1(_1365_),
    .A2(_1097_),
    .B1(_1367_),
    .Y(_1368_));
 sky130_fd_sc_hd__or3_1 _5386_ (.A(_1131_),
    .B(_1108_),
    .C(_1368_),
    .X(_1369_));
 sky130_fd_sc_hd__o21ai_0 _5387_ (.A1(net767),
    .A2(_1364_),
    .B1(_1369_),
    .Y(_1370_));
 sky130_fd_sc_hd__xnor2_1 _5388_ (.A(_0355_),
    .B(_1370_),
    .Y(_1371_));
 sky130_fd_sc_hd__a22oi_1 _5389_ (.A1(_0357_),
    .A2(net728),
    .B1(net727),
    .B2(_0355_),
    .Y(_1372_));
 sky130_fd_sc_hd__o221ai_1 _5390_ (.A1(_0354_),
    .A2(net726),
    .B1(net698),
    .B2(_1371_),
    .C1(_1372_),
    .Y(\alu_out[14] ));
 sky130_fd_sc_hd__nor2_1 _5391_ (.A(_1131_),
    .B(_1322_),
    .Y(_1373_));
 sky130_fd_sc_hd__a21oi_1 _5392_ (.A1(_1131_),
    .A2(_1358_),
    .B1(_1373_),
    .Y(_1374_));
 sky130_fd_sc_hd__xnor2_1 _5393_ (.A(_1106_),
    .B(_1374_),
    .Y(_1375_));
 sky130_fd_sc_hd__nor2_1 _5394_ (.A(_0360_),
    .B(net726),
    .Y(_1376_));
 sky130_fd_sc_hd__a221oi_1 _5395_ (.A1(_0363_),
    .A2(net728),
    .B1(net727),
    .B2(_0361_),
    .C1(_1376_),
    .Y(_1377_));
 sky130_fd_sc_hd__o21ai_0 _5396_ (.A1(net698),
    .A2(_1375_),
    .B1(_1377_),
    .Y(\alu_out[13] ));
 sky130_fd_sc_hd__nand2_1 _5397_ (.A(_0391_),
    .B(_0385_),
    .Y(_1378_));
 sky130_fd_sc_hd__o21ai_0 _5398_ (.A1(_1032_),
    .A2(_1378_),
    .B1(_1042_),
    .Y(_1379_));
 sky130_fd_sc_hd__a21oi_1 _5399_ (.A1(_0379_),
    .A2(_1379_),
    .B1(_0381_),
    .Y(_1380_));
 sky130_fd_sc_hd__nor2_1 _5400_ (.A(_1040_),
    .B(_1380_),
    .Y(_1381_));
 sky130_fd_sc_hd__o31ai_1 _5401_ (.A1(_0391_),
    .A2(_0385_),
    .A3(_1097_),
    .B1(_1365_),
    .Y(_1382_));
 sky130_fd_sc_hd__a21oi_1 _5402_ (.A1(_1041_),
    .A2(_1382_),
    .B1(_0380_),
    .Y(_1383_));
 sky130_fd_sc_hd__nor2_1 _5403_ (.A(_0373_),
    .B(_1383_),
    .Y(_1384_));
 sky130_fd_sc_hd__o21ai_0 _5404_ (.A1(_0374_),
    .A2(_1384_),
    .B1(net767),
    .Y(_1385_));
 sky130_fd_sc_hd__o31ai_1 _5405_ (.A1(net767),
    .A2(_0375_),
    .A3(_1381_),
    .B1(_1385_),
    .Y(_1386_));
 sky130_fd_sc_hd__xnor2_1 _5406_ (.A(_1162_),
    .B(_1386_),
    .Y(_1387_));
 sky130_fd_sc_hd__nor2_1 _5407_ (.A(_0366_),
    .B(net726),
    .Y(_1388_));
 sky130_fd_sc_hd__a221oi_1 _5408_ (.A1(_0369_),
    .A2(net728),
    .B1(net727),
    .B2(_0367_),
    .C1(_1388_),
    .Y(_1389_));
 sky130_fd_sc_hd__o21ai_0 _5409_ (.A1(net698),
    .A2(_1387_),
    .B1(_1389_),
    .Y(\alu_out[12] ));
 sky130_fd_sc_hd__nand2_1 _5410_ (.A(_1131_),
    .B(_1199_),
    .Y(_1390_));
 sky130_fd_sc_hd__o21ai_0 _5411_ (.A1(_1131_),
    .A2(_1321_),
    .B1(_1390_),
    .Y(_1391_));
 sky130_fd_sc_hd__xnor2_1 _5412_ (.A(_1040_),
    .B(_1391_),
    .Y(_1392_));
 sky130_fd_sc_hd__a22oi_1 _5413_ (.A1(_0375_),
    .A2(net728),
    .B1(net727),
    .B2(_0373_),
    .Y(_1393_));
 sky130_fd_sc_hd__o221ai_1 _5414_ (.A1(_0372_),
    .A2(net726),
    .B1(net698),
    .B2(_1392_),
    .C1(_1393_),
    .Y(\alu_out[11] ));
 sky130_fd_sc_hd__nor2_1 _5415_ (.A(_1131_),
    .B(_1382_),
    .Y(_1394_));
 sky130_fd_sc_hd__a21oi_1 _5416_ (.A1(_1131_),
    .A2(_1379_),
    .B1(_1394_),
    .Y(_1395_));
 sky130_fd_sc_hd__xnor2_1 _5417_ (.A(_1041_),
    .B(_1395_),
    .Y(_1396_));
 sky130_fd_sc_hd__a22oi_1 _5418_ (.A1(_0381_),
    .A2(net728),
    .B1(net727),
    .B2(_0379_),
    .Y(_1397_));
 sky130_fd_sc_hd__o221ai_1 _5419_ (.A1(_0378_),
    .A2(net726),
    .B1(net698),
    .B2(_1396_),
    .C1(_1397_),
    .Y(\alu_out[10] ));
 sky130_fd_sc_hd__inv_1 _5420_ (.A(_0398_),
    .Y(_1398_));
 sky130_fd_sc_hd__o21bai_1 _5421_ (.A1(_0404_),
    .A2(_1161_),
    .B1_N(_0397_),
    .Y(_1399_));
 sky130_fd_sc_hd__a21oi_1 _5422_ (.A1(_1398_),
    .A2(_1399_),
    .B1(_0391_),
    .Y(_1400_));
 sky130_fd_sc_hd__nor2_1 _5423_ (.A(_0392_),
    .B(_1400_),
    .Y(_1401_));
 sky130_fd_sc_hd__o21a_1 _5424_ (.A1(_1187_),
    .A2(_1188_),
    .B1(_1192_),
    .X(_1402_));
 sky130_fd_sc_hd__a21o_1 _5425_ (.A1(_0397_),
    .A2(_1402_),
    .B1(_0399_),
    .X(_1403_));
 sky130_fd_sc_hd__a21oi_1 _5426_ (.A1(_0391_),
    .A2(_1403_),
    .B1(_0393_),
    .Y(_1404_));
 sky130_fd_sc_hd__nor2_1 _5427_ (.A(net767),
    .B(_1404_),
    .Y(_1405_));
 sky130_fd_sc_hd__a21oi_1 _5428_ (.A1(net767),
    .A2(_1401_),
    .B1(_1405_),
    .Y(_1406_));
 sky130_fd_sc_hd__a21oi_1 _5429_ (.A1(net709),
    .A2(_1406_),
    .B1(net727),
    .Y(_1407_));
 sky130_fd_sc_hd__nor2_1 _5430_ (.A(_0384_),
    .B(net726),
    .Y(_1408_));
 sky130_fd_sc_hd__nor3_1 _5431_ (.A(_0385_),
    .B(net698),
    .C(_1406_),
    .Y(_1409_));
 sky130_fd_sc_hd__a211oi_1 _5432_ (.A1(_0387_),
    .A2(net728),
    .B1(_1408_),
    .C1(_1409_),
    .Y(_1410_));
 sky130_fd_sc_hd__o21ai_0 _5433_ (.A1(_1102_),
    .A2(_1407_),
    .B1(_1410_),
    .Y(\alu_out[9] ));
 sky130_fd_sc_hd__nor2_1 _5434_ (.A(net767),
    .B(_1032_),
    .Y(_1411_));
 sky130_fd_sc_hd__a21oi_1 _5435_ (.A1(net767),
    .A2(_1097_),
    .B1(_1411_),
    .Y(_1412_));
 sky130_fd_sc_hd__a21oi_1 _5436_ (.A1(net709),
    .A2(_1412_),
    .B1(net727),
    .Y(_1413_));
 sky130_fd_sc_hd__nand2b_1 _5437_ (.A_N(_1413_),
    .B(_0391_),
    .Y(_1414_));
 sky130_fd_sc_hd__nor2_1 _5438_ (.A(_0390_),
    .B(net726),
    .Y(_1415_));
 sky130_fd_sc_hd__a21oi_1 _5439_ (.A1(_0393_),
    .A2(net728),
    .B1(_1415_),
    .Y(_1416_));
 sky130_fd_sc_hd__o311ai_0 _5440_ (.A1(_0391_),
    .A2(net698),
    .A3(_1412_),
    .B1(_1414_),
    .C1(_1416_),
    .Y(\alu_out[8] ));
 sky130_fd_sc_hd__nor3_1 _5441_ (.A(_1131_),
    .B(_0404_),
    .C(_1161_),
    .Y(_1417_));
 sky130_fd_sc_hd__a21oi_1 _5442_ (.A1(_1131_),
    .A2(_1402_),
    .B1(_1417_),
    .Y(_1418_));
 sky130_fd_sc_hd__xor2_1 _5443_ (.A(_0397_),
    .B(_1418_),
    .X(_1419_));
 sky130_fd_sc_hd__a22oi_1 _5444_ (.A1(_0399_),
    .A2(net728),
    .B1(net727),
    .B2(_0397_),
    .Y(_1420_));
 sky130_fd_sc_hd__o221ai_1 _5445_ (.A1(_0396_),
    .A2(net726),
    .B1(net698),
    .B2(_1419_),
    .C1(_1420_),
    .Y(\alu_out[7] ));
 sky130_fd_sc_hd__inv_1 _5446_ (.A(_0423_),
    .Y(_1421_));
 sky130_fd_sc_hd__a21oi_1 _5447_ (.A1(_1421_),
    .A2(_1091_),
    .B1(_0424_),
    .Y(_1422_));
 sky130_fd_sc_hd__nor2_1 _5448_ (.A(_0409_),
    .B(_1422_),
    .Y(_1423_));
 sky130_fd_sc_hd__o21ai_0 _5449_ (.A1(_0410_),
    .A2(_1423_),
    .B1(net767),
    .Y(_1424_));
 sky130_fd_sc_hd__o21ai_0 _5450_ (.A1(net767),
    .A2(_1028_),
    .B1(_1424_),
    .Y(_1425_));
 sky130_fd_sc_hd__xnor2_1 _5451_ (.A(_1160_),
    .B(_1425_),
    .Y(_1426_));
 sky130_fd_sc_hd__nor2_1 _5452_ (.A(_0402_),
    .B(net726),
    .Y(_1427_));
 sky130_fd_sc_hd__a221oi_1 _5453_ (.A1(_0405_),
    .A2(net728),
    .B1(net727),
    .B2(_0403_),
    .C1(_1427_),
    .Y(_1428_));
 sky130_fd_sc_hd__o21ai_0 _5454_ (.A1(net698),
    .A2(_1426_),
    .B1(_1428_),
    .Y(\alu_out[6] ));
 sky130_fd_sc_hd__a21oi_1 _5455_ (.A1(_0423_),
    .A2(_1187_),
    .B1(_0425_),
    .Y(_1429_));
 sky130_fd_sc_hd__o21ai_0 _5456_ (.A1(_0430_),
    .A2(_1159_),
    .B1(_1421_),
    .Y(_1430_));
 sky130_fd_sc_hd__a21oi_1 _5457_ (.A1(_1154_),
    .A2(_1430_),
    .B1(_1131_),
    .Y(_1431_));
 sky130_fd_sc_hd__a21oi_1 _5458_ (.A1(_1131_),
    .A2(_1429_),
    .B1(_1431_),
    .Y(_1432_));
 sky130_fd_sc_hd__nand2_1 _5459_ (.A(net709),
    .B(_1432_),
    .Y(_1433_));
 sky130_fd_sc_hd__nor2_1 _5460_ (.A(net698),
    .B(_1432_),
    .Y(_1434_));
 sky130_fd_sc_hd__o21ai_0 _5461_ (.A1(net727),
    .A2(_1434_),
    .B1(_0409_),
    .Y(_1435_));
 sky130_fd_sc_hd__nor2_1 _5462_ (.A(_0408_),
    .B(net726),
    .Y(_1436_));
 sky130_fd_sc_hd__a21oi_1 _5463_ (.A1(_0411_),
    .A2(net728),
    .B1(_1436_),
    .Y(_1437_));
 sky130_fd_sc_hd__o211ai_1 _5464_ (.A1(_0409_),
    .A2(_1433_),
    .B1(_1435_),
    .C1(_1437_),
    .Y(\alu_out[5] ));
 sky130_fd_sc_hd__a21oi_1 _5465_ (.A1(_0067_),
    .A2(_0438_),
    .B1(_0440_),
    .Y(_1438_));
 sky130_fd_sc_hd__nor2_1 _5466_ (.A(_1089_),
    .B(_1438_),
    .Y(_1439_));
 sky130_fd_sc_hd__nor3_1 _5467_ (.A(net767),
    .B(_0431_),
    .C(_1439_),
    .Y(_1440_));
 sky130_fd_sc_hd__a21oi_1 _5468_ (.A1(net767),
    .A2(_1091_),
    .B1(_1440_),
    .Y(_1441_));
 sky130_fd_sc_hd__xnor2_1 _5469_ (.A(_0423_),
    .B(_1441_),
    .Y(_1442_));
 sky130_fd_sc_hd__a22oi_1 _5470_ (.A1(_0425_),
    .A2(net728),
    .B1(net727),
    .B2(_0423_),
    .Y(_1443_));
 sky130_fd_sc_hd__o221ai_1 _5471_ (.A1(_0422_),
    .A2(net726),
    .B1(net698),
    .B2(_1442_),
    .C1(_1443_),
    .Y(\alu_out[4] ));
 sky130_fd_sc_hd__nor2_1 _5472_ (.A(_0442_),
    .B(_1157_),
    .Y(_1444_));
 sky130_fd_sc_hd__o21bai_1 _5473_ (.A1(_0438_),
    .A2(_1444_),
    .B1_N(_0439_),
    .Y(_1445_));
 sky130_fd_sc_hd__a21o_1 _5474_ (.A1(_0066_),
    .A2(_0241_),
    .B1(_0443_),
    .X(_1446_));
 sky130_fd_sc_hd__a211oi_1 _5475_ (.A1(_0438_),
    .A2(_1446_),
    .B1(_0440_),
    .C1(net767),
    .Y(_1447_));
 sky130_fd_sc_hd__a21oi_1 _5476_ (.A1(net767),
    .A2(_1445_),
    .B1(_1447_),
    .Y(_1448_));
 sky130_fd_sc_hd__xnor2_1 _5477_ (.A(_0429_),
    .B(_1448_),
    .Y(_1449_));
 sky130_fd_sc_hd__a22oi_1 _5478_ (.A1(_0431_),
    .A2(net728),
    .B1(net727),
    .B2(_0429_),
    .Y(_1450_));
 sky130_fd_sc_hd__o221ai_1 _5479_ (.A1(_0428_),
    .A2(net726),
    .B1(net698),
    .B2(_1449_),
    .C1(_1450_),
    .Y(\alu_out[3] ));
 sky130_fd_sc_hd__mux2i_1 _5480_ (.A0(_0067_),
    .A1(_0063_),
    .S(net767),
    .Y(_1451_));
 sky130_fd_sc_hd__xor2_1 _5481_ (.A(_0438_),
    .B(_1451_),
    .X(_1452_));
 sky130_fd_sc_hd__nor2_1 _5482_ (.A(_0437_),
    .B(net726),
    .Y(_1453_));
 sky130_fd_sc_hd__a221oi_1 _5483_ (.A1(_0440_),
    .A2(net728),
    .B1(net727),
    .B2(_0438_),
    .C1(_1453_),
    .Y(_1454_));
 sky130_fd_sc_hd__o21ai_0 _5484_ (.A1(net698),
    .A2(_1452_),
    .B1(_1454_),
    .Y(\alu_out[2] ));
 sky130_fd_sc_hd__nand2_1 _5485_ (.A(net767),
    .B(_0064_),
    .Y(_1455_));
 sky130_fd_sc_hd__o21ai_0 _5486_ (.A1(net767),
    .A2(_0068_),
    .B1(_1455_),
    .Y(_1456_));
 sky130_fd_sc_hd__a22oi_1 _5487_ (.A1(_0443_),
    .A2(net728),
    .B1(net727),
    .B2(_0241_),
    .Y(_1457_));
 sky130_fd_sc_hd__o21ai_0 _5488_ (.A1(_0441_),
    .A2(net726),
    .B1(_1457_),
    .Y(_1458_));
 sky130_fd_sc_hd__nor2_1 _5489_ (.A(net709),
    .B(_1458_),
    .Y(_1459_));
 sky130_fd_sc_hd__a21oi_1 _5490_ (.A1(net709),
    .A2(_1456_),
    .B1(_1459_),
    .Y(\alu_out[1] ));
 sky130_fd_sc_hd__o21a_1 _5492_ (.A1(_0356_),
    .A2(_1145_),
    .B1(_1109_),
    .X(_1461_));
 sky130_fd_sc_hd__inv_1 _5493_ (.A(_0475_),
    .Y(_1462_));
 sky130_fd_sc_hd__nor3b_1 _5494_ (.A(_0260_),
    .B(_0266_),
    .C_N(_0256_),
    .Y(_1463_));
 sky130_fd_sc_hd__nor2_1 _5495_ (.A(_0337_),
    .B(_0343_),
    .Y(_1464_));
 sky130_fd_sc_hd__nand3_1 _5496_ (.A(_1149_),
    .B(_1463_),
    .C(_1464_),
    .Y(_1465_));
 sky130_fd_sc_hd__nor2_1 _5497_ (.A(_1462_),
    .B(_1465_),
    .Y(_1466_));
 sky130_fd_sc_hd__o211a_1 _5498_ (.A1(_0350_),
    .A2(_1461_),
    .B1(_1466_),
    .C1(net689),
    .X(_1467_));
 sky130_fd_sc_hd__or3_1 _5499_ (.A(_0474_),
    .B(_1108_),
    .C(_1110_),
    .X(_1468_));
 sky130_fd_sc_hd__o22ai_1 _5500_ (.A1(_0474_),
    .A2(_1467_),
    .B1(_1468_),
    .B2(_1368_),
    .Y(_1469_));
 sky130_fd_sc_hd__nor2b_1 _5501_ (.A(_0260_),
    .B_N(_0267_),
    .Y(_1470_));
 sky130_fd_sc_hd__o21ai_0 _5502_ (.A1(_0261_),
    .A2(_1470_),
    .B1(_0256_),
    .Y(_1471_));
 sky130_fd_sc_hd__nand2b_1 _5503_ (.A_N(_0255_),
    .B(_1471_),
    .Y(_1472_));
 sky130_fd_sc_hd__nor2b_1 _5504_ (.A(_0337_),
    .B_N(_0344_),
    .Y(_1473_));
 sky130_fd_sc_hd__o21ai_0 _5505_ (.A1(_0338_),
    .A2(_1473_),
    .B1(_1149_),
    .Y(_1474_));
 sky130_fd_sc_hd__nand2_1 _5506_ (.A(_1117_),
    .B(_1474_),
    .Y(_1475_));
 sky130_fd_sc_hd__a211o_1 _5507_ (.A1(net689),
    .A2(_1475_),
    .B1(_1472_),
    .C1(_0276_),
    .X(_1476_));
 sky130_fd_sc_hd__o22ai_1 _5508_ (.A1(_1463_),
    .A2(_1472_),
    .B1(_1476_),
    .B2(_1239_),
    .Y(_1477_));
 sky130_fd_sc_hd__nand3_1 _5509_ (.A(_0475_),
    .B(net650),
    .C(_1477_),
    .Y(_1478_));
 sky130_fd_sc_hd__o21ai_0 _5510_ (.A1(_0475_),
    .A2(net650),
    .B1(_1478_),
    .Y(_1479_));
 sky130_fd_sc_hd__nor4_1 _5511_ (.A(\alu_add_sub[0] ),
    .B(_0241_),
    .C(_0438_),
    .D(_0429_),
    .Y(_1480_));
 sky130_fd_sc_hd__and3_1 _5512_ (.A(_1092_),
    .B(_1466_),
    .C(_1480_),
    .X(_1481_));
 sky130_fd_sc_hd__nand4_1 _5513_ (.A(_1100_),
    .B(_1098_),
    .C(net689),
    .D(_1481_),
    .Y(_1482_));
 sky130_fd_sc_hd__nor2_1 _5514_ (.A(instr_bge),
    .B(instr_bgeu),
    .Y(_1483_));
 sky130_fd_sc_hd__nor2_1 _5515_ (.A(is_slti_blt_slt),
    .B(is_sltiu_bltu_sltu),
    .Y(_1484_));
 sky130_fd_sc_hd__nand2_1 _5516_ (.A(_1483_),
    .B(_1484_),
    .Y(_1485_));
 sky130_fd_sc_hd__nor3_1 _5517_ (.A(instr_bne),
    .B(_1482_),
    .C(_1485_),
    .Y(_1486_));
 sky130_fd_sc_hd__a21o_1 _5518_ (.A1(instr_bne),
    .A2(_1482_),
    .B1(_1486_),
    .X(_1487_));
 sky130_fd_sc_hd__nand2_1 _5519_ (.A(net650),
    .B(_1477_),
    .Y(_1488_));
 sky130_fd_sc_hd__a211o_1 _5520_ (.A1(instr_bge),
    .A2(_0475_),
    .B1(net650),
    .C1(instr_bgeu),
    .X(_1489_));
 sky130_fd_sc_hd__nand2_1 _5521_ (.A(_0475_),
    .B(_1483_),
    .Y(_1490_));
 sky130_fd_sc_hd__nor3_1 _5522_ (.A(instr_bge),
    .B(_0475_),
    .C(is_sltiu_bltu_sltu),
    .Y(_1491_));
 sky130_fd_sc_hd__a2bb2oi_1 _5523_ (.A1_N(_1477_),
    .A2_N(_1490_),
    .B1(_1491_),
    .B2(net650),
    .Y(_1492_));
 sky130_fd_sc_hd__o311a_1 _5524_ (.A1(_1462_),
    .A2(is_sltiu_bltu_sltu),
    .A3(_1488_),
    .B1(_1489_),
    .C1(_1492_),
    .X(_1493_));
 sky130_fd_sc_hd__a211o_1 _5525_ (.A1(is_slti_blt_slt),
    .A2(_1479_),
    .B1(_1487_),
    .C1(_1493_),
    .X(_1494_));
 sky130_fd_sc_hd__nand2_1 _5526_ (.A(is_compare),
    .B(_1494_),
    .Y(_1495_));
 sky130_fd_sc_hd__nand2_1 _5527_ (.A(_0066_),
    .B(net728),
    .Y(_1496_));
 sky130_fd_sc_hd__o21ai_0 _5528_ (.A1(net727),
    .A2(net709),
    .B1(\alu_add_sub[0] ),
    .Y(_1497_));
 sky130_fd_sc_hd__o2111ai_1 _5529_ (.A1(_0446_),
    .A2(net726),
    .B1(_1495_),
    .C1(_1496_),
    .D1(_1497_),
    .Y(\alu_out[0] ));
 sky130_fd_sc_hd__nand2b_2 _5530_ (.A_N(latched_branch),
    .B(latched_store),
    .Y(_1498_));
 sky130_fd_sc_hd__and3_1 _5534_ (.A(\reg_pc[27] ),
    .B(\reg_pc[28] ),
    .C(\reg_pc[29] ),
    .X(_1502_));
 sky130_fd_sc_hd__and3_1 _5536_ (.A(net735),
    .B(\reg_pc[10] ),
    .C(\reg_pc[11] ),
    .X(_1504_));
 sky130_fd_sc_hd__and3_1 _5537_ (.A(\reg_pc[12] ),
    .B(\reg_pc[13] ),
    .C(_1504_),
    .X(_1505_));
 sky130_fd_sc_hd__and3_1 _5538_ (.A(\reg_pc[14] ),
    .B(\reg_pc[15] ),
    .C(_1505_),
    .X(_1506_));
 sky130_fd_sc_hd__nand3_1 _5539_ (.A(\reg_pc[4] ),
    .B(\reg_pc[5] ),
    .C(_0144_),
    .Y(_1507_));
 sky130_fd_sc_hd__nand3_1 _5540_ (.A(\reg_pc[6] ),
    .B(\reg_pc[7] ),
    .C(\reg_pc[8] ),
    .Y(_1508_));
 sky130_fd_sc_hd__nor2_1 _5541_ (.A(_1507_),
    .B(_1508_),
    .Y(_1509_));
 sky130_fd_sc_hd__nand4_1 _5542_ (.A(\reg_pc[16] ),
    .B(\reg_pc[17] ),
    .C(_1506_),
    .D(_1509_),
    .Y(_1510_));
 sky130_fd_sc_hd__and3_1 _5543_ (.A(\reg_pc[18] ),
    .B(\reg_pc[19] ),
    .C(\reg_pc[20] ),
    .X(_1511_));
 sky130_fd_sc_hd__nand4_1 _5544_ (.A(\reg_pc[21] ),
    .B(\reg_pc[22] ),
    .C(\reg_pc[23] ),
    .D(_1511_),
    .Y(_1512_));
 sky130_fd_sc_hd__nand3_1 _5545_ (.A(\reg_pc[24] ),
    .B(\reg_pc[25] ),
    .C(\reg_pc[26] ),
    .Y(_1513_));
 sky130_fd_sc_hd__nor3_1 _5546_ (.A(_1510_),
    .B(_1512_),
    .C(_1513_),
    .Y(_1514_));
 sky130_fd_sc_hd__nand2_1 _5547_ (.A(_1502_),
    .B(_1514_),
    .Y(_1515_));
 sky130_fd_sc_hd__xnor2_1 _5548_ (.A(\reg_pc[30] ),
    .B(_1515_),
    .Y(_1516_));
 sky130_fd_sc_hd__nand2_1 _5549_ (.A(_1498_),
    .B(_1516_),
    .Y(_1517_));
 sky130_fd_sc_hd__o21ai_2 _5550_ (.A1(_0940_),
    .A2(_1498_),
    .B1(_1517_),
    .Y(\cpuregs_wrdata[30] ));
 sky130_fd_sc_hd__nand4_1 _5551_ (.A(\reg_pc[14] ),
    .B(\reg_pc[15] ),
    .C(\reg_pc[16] ),
    .D(_1505_),
    .Y(_1518_));
 sky130_fd_sc_hd__and4_1 _5552_ (.A(\reg_pc[2] ),
    .B(\reg_pc[3] ),
    .C(\reg_pc[4] ),
    .D(\reg_pc[5] ),
    .X(_1519_));
 sky130_fd_sc_hd__nand2b_1 _5553_ (.A_N(_1508_),
    .B(_1519_),
    .Y(_1520_));
 sky130_fd_sc_hd__nor2_1 _5554_ (.A(_1518_),
    .B(_1520_),
    .Y(_1521_));
 sky130_fd_sc_hd__nand2_1 _5555_ (.A(\reg_pc[17] ),
    .B(_1521_),
    .Y(_1522_));
 sky130_fd_sc_hd__nor3_1 _5556_ (.A(_1512_),
    .B(_1513_),
    .C(_1522_),
    .Y(_1523_));
 sky130_fd_sc_hd__nand3_1 _5557_ (.A(\reg_pc[27] ),
    .B(\reg_pc[28] ),
    .C(_1523_),
    .Y(_1524_));
 sky130_fd_sc_hd__xnor2_1 _5558_ (.A(\reg_pc[29] ),
    .B(_1524_),
    .Y(_1525_));
 sky130_fd_sc_hd__nand2_1 _5559_ (.A(_1498_),
    .B(_1525_),
    .Y(_1526_));
 sky130_fd_sc_hd__o21ai_2 _5560_ (.A1(_0937_),
    .A2(_1498_),
    .B1(_1526_),
    .Y(\cpuregs_wrdata[29] ));
 sky130_fd_sc_hd__nand2_1 _5561_ (.A(\reg_pc[27] ),
    .B(_1514_),
    .Y(_1527_));
 sky130_fd_sc_hd__xnor2_1 _5562_ (.A(\reg_pc[28] ),
    .B(_1527_),
    .Y(_1528_));
 sky130_fd_sc_hd__nand2_1 _5563_ (.A(_1498_),
    .B(_1528_),
    .Y(_1529_));
 sky130_fd_sc_hd__o21ai_2 _5564_ (.A1(_0935_),
    .A2(_1498_),
    .B1(_1529_),
    .Y(\cpuregs_wrdata[28] ));
 sky130_fd_sc_hd__xor2_1 _5565_ (.A(\reg_pc[27] ),
    .B(_1523_),
    .X(_1530_));
 sky130_fd_sc_hd__nand2_1 _5566_ (.A(_1498_),
    .B(_1530_),
    .Y(_1531_));
 sky130_fd_sc_hd__o21ai_2 _5567_ (.A1(_0932_),
    .A2(_1498_),
    .B1(_1531_),
    .Y(\cpuregs_wrdata[27] ));
 sky130_fd_sc_hd__nor2_1 _5568_ (.A(_1510_),
    .B(_1512_),
    .Y(_1532_));
 sky130_fd_sc_hd__nand3_1 _5569_ (.A(\reg_pc[24] ),
    .B(\reg_pc[25] ),
    .C(_1532_),
    .Y(_1533_));
 sky130_fd_sc_hd__xnor2_1 _5570_ (.A(\reg_pc[26] ),
    .B(_1533_),
    .Y(_1534_));
 sky130_fd_sc_hd__nand2_1 _5571_ (.A(_1498_),
    .B(_1534_),
    .Y(_1535_));
 sky130_fd_sc_hd__o21ai_2 _5572_ (.A1(_0930_),
    .A2(_1498_),
    .B1(_1535_),
    .Y(\cpuregs_wrdata[26] ));
 sky130_fd_sc_hd__nor2_1 _5574_ (.A(_1512_),
    .B(_1522_),
    .Y(_1537_));
 sky130_fd_sc_hd__nand2_1 _5575_ (.A(\reg_pc[24] ),
    .B(_1537_),
    .Y(_1538_));
 sky130_fd_sc_hd__xnor2_1 _5576_ (.A(\reg_pc[25] ),
    .B(_1538_),
    .Y(_1539_));
 sky130_fd_sc_hd__nand2_1 _5577_ (.A(_1498_),
    .B(_1539_),
    .Y(_1540_));
 sky130_fd_sc_hd__o21ai_2 _5578_ (.A1(_0928_),
    .A2(_1498_),
    .B1(_1540_),
    .Y(\cpuregs_wrdata[25] ));
 sky130_fd_sc_hd__nor2b_4 _5579_ (.A(latched_branch),
    .B_N(latched_store),
    .Y(_1541_));
 sky130_fd_sc_hd__xnor2_1 _5581_ (.A(\reg_pc[24] ),
    .B(_1532_),
    .Y(_1543_));
 sky130_fd_sc_hd__nand2_1 _5583_ (.A(_0925_),
    .B(net725),
    .Y(_1545_));
 sky130_fd_sc_hd__o21ai_4 _5584_ (.A1(net725),
    .A2(_1543_),
    .B1(_1545_),
    .Y(\cpuregs_wrdata[24] ));
 sky130_fd_sc_hd__nand3_1 _5585_ (.A(\reg_pc[21] ),
    .B(\reg_pc[22] ),
    .C(_1511_),
    .Y(_1546_));
 sky130_fd_sc_hd__nor2_1 _5586_ (.A(_1546_),
    .B(_1522_),
    .Y(_1547_));
 sky130_fd_sc_hd__xnor2_1 _5587_ (.A(\reg_pc[23] ),
    .B(_1547_),
    .Y(_1548_));
 sky130_fd_sc_hd__nand2_1 _5588_ (.A(_0922_),
    .B(net725),
    .Y(_1549_));
 sky130_fd_sc_hd__o21ai_2 _5589_ (.A1(net725),
    .A2(_1548_),
    .B1(_1549_),
    .Y(\cpuregs_wrdata[23] ));
 sky130_fd_sc_hd__nand2_1 _5590_ (.A(\reg_pc[18] ),
    .B(\reg_pc[19] ),
    .Y(_1550_));
 sky130_fd_sc_hd__nand2_1 _5591_ (.A(\reg_pc[20] ),
    .B(\reg_pc[21] ),
    .Y(_1551_));
 sky130_fd_sc_hd__nor3_1 _5592_ (.A(_1510_),
    .B(_1550_),
    .C(_1551_),
    .Y(_1552_));
 sky130_fd_sc_hd__xor2_1 _5593_ (.A(\reg_pc[22] ),
    .B(_1552_),
    .X(_1553_));
 sky130_fd_sc_hd__nand2_1 _5594_ (.A(_1498_),
    .B(_1553_),
    .Y(_1554_));
 sky130_fd_sc_hd__o21ai_4 _5595_ (.A1(_0920_),
    .A2(_1498_),
    .B1(_1554_),
    .Y(\cpuregs_wrdata[22] ));
 sky130_fd_sc_hd__and3_1 _5596_ (.A(\reg_pc[17] ),
    .B(_1511_),
    .C(_1521_),
    .X(_1555_));
 sky130_fd_sc_hd__xor2_1 _5597_ (.A(\reg_pc[21] ),
    .B(_1555_),
    .X(_1556_));
 sky130_fd_sc_hd__nand2_1 _5598_ (.A(_1498_),
    .B(_1556_),
    .Y(_1557_));
 sky130_fd_sc_hd__o21ai_2 _5599_ (.A1(_0918_),
    .A2(_1498_),
    .B1(_1557_),
    .Y(\cpuregs_wrdata[21] ));
 sky130_fd_sc_hd__nor2_1 _5600_ (.A(_1510_),
    .B(_1550_),
    .Y(_1558_));
 sky130_fd_sc_hd__xor2_1 _5601_ (.A(\reg_pc[20] ),
    .B(_1558_),
    .X(_1559_));
 sky130_fd_sc_hd__nand2_1 _5602_ (.A(_1498_),
    .B(_1559_),
    .Y(_1560_));
 sky130_fd_sc_hd__o21ai_2 _5603_ (.A1(_0916_),
    .A2(_1498_),
    .B1(_1560_),
    .Y(\cpuregs_wrdata[20] ));
 sky130_fd_sc_hd__nand3_1 _5604_ (.A(\reg_pc[17] ),
    .B(\reg_pc[18] ),
    .C(_1521_),
    .Y(_1561_));
 sky130_fd_sc_hd__xor2_1 _5605_ (.A(\reg_pc[19] ),
    .B(_1561_),
    .X(_1562_));
 sky130_fd_sc_hd__mux2i_2 _5606_ (.A0(_0914_),
    .A1(_1562_),
    .S(_1498_),
    .Y(\cpuregs_wrdata[19] ));
 sky130_fd_sc_hd__xnor2_1 _5607_ (.A(\reg_pc[18] ),
    .B(_1510_),
    .Y(_1563_));
 sky130_fd_sc_hd__nand2_1 _5608_ (.A(_1498_),
    .B(_1563_),
    .Y(_1564_));
 sky130_fd_sc_hd__o21ai_2 _5609_ (.A1(_0911_),
    .A2(_1498_),
    .B1(_1564_),
    .Y(\cpuregs_wrdata[18] ));
 sky130_fd_sc_hd__xnor2_1 _5610_ (.A(\reg_pc[17] ),
    .B(_1521_),
    .Y(_1565_));
 sky130_fd_sc_hd__nand2_1 _5611_ (.A(_0908_),
    .B(net725),
    .Y(_1566_));
 sky130_fd_sc_hd__o21ai_2 _5612_ (.A1(net725),
    .A2(_1565_),
    .B1(_1566_),
    .Y(\cpuregs_wrdata[17] ));
 sky130_fd_sc_hd__nand2_1 _5613_ (.A(_1506_),
    .B(_1509_),
    .Y(_1567_));
 sky130_fd_sc_hd__xor2_1 _5614_ (.A(\reg_pc[16] ),
    .B(_1567_),
    .X(_1568_));
 sky130_fd_sc_hd__nand2_1 _5615_ (.A(_0905_),
    .B(net725),
    .Y(_1569_));
 sky130_fd_sc_hd__o21ai_4 _5616_ (.A1(net725),
    .A2(_1568_),
    .B1(_1569_),
    .Y(\cpuregs_wrdata[16] ));
 sky130_fd_sc_hd__nand2_1 _5617_ (.A(\reg_pc[14] ),
    .B(_1505_),
    .Y(_1570_));
 sky130_fd_sc_hd__nor2_1 _5618_ (.A(_1570_),
    .B(_1520_),
    .Y(_1571_));
 sky130_fd_sc_hd__xnor2_1 _5619_ (.A(\reg_pc[15] ),
    .B(_1571_),
    .Y(_1572_));
 sky130_fd_sc_hd__nand2_1 _5620_ (.A(_0902_),
    .B(net725),
    .Y(_1573_));
 sky130_fd_sc_hd__o21ai_4 _5621_ (.A1(net725),
    .A2(_1572_),
    .B1(_1573_),
    .Y(\cpuregs_wrdata[15] ));
 sky130_fd_sc_hd__nand2_1 _5623_ (.A(_1505_),
    .B(_1509_),
    .Y(_1575_));
 sky130_fd_sc_hd__xor2_1 _5624_ (.A(\reg_pc[14] ),
    .B(_1575_),
    .X(_1576_));
 sky130_fd_sc_hd__nand2_1 _5625_ (.A(_0901_),
    .B(net725),
    .Y(_1577_));
 sky130_fd_sc_hd__o21ai_4 _5626_ (.A1(net725),
    .A2(_1576_),
    .B1(_1577_),
    .Y(\cpuregs_wrdata[14] ));
 sky130_fd_sc_hd__nand2_1 _5627_ (.A(net735),
    .B(\reg_pc[10] ),
    .Y(_1578_));
 sky130_fd_sc_hd__nand2_1 _5628_ (.A(\reg_pc[11] ),
    .B(\reg_pc[12] ),
    .Y(_1579_));
 sky130_fd_sc_hd__nor3_1 _5629_ (.A(_1578_),
    .B(_1579_),
    .C(_1520_),
    .Y(_1580_));
 sky130_fd_sc_hd__xnor2_1 _5630_ (.A(\reg_pc[13] ),
    .B(_1580_),
    .Y(_1581_));
 sky130_fd_sc_hd__nand2_1 _5631_ (.A(_0900_),
    .B(net725),
    .Y(_1582_));
 sky130_fd_sc_hd__o21ai_4 _5632_ (.A1(net725),
    .A2(_1581_),
    .B1(_1582_),
    .Y(\cpuregs_wrdata[13] ));
 sky130_fd_sc_hd__nand2_1 _5633_ (.A(_1504_),
    .B(_1509_),
    .Y(_1583_));
 sky130_fd_sc_hd__xor2_1 _5634_ (.A(\reg_pc[12] ),
    .B(_1583_),
    .X(_1584_));
 sky130_fd_sc_hd__nand2_1 _5635_ (.A(_0898_),
    .B(net725),
    .Y(_1585_));
 sky130_fd_sc_hd__o21ai_2 _5636_ (.A1(net725),
    .A2(_1584_),
    .B1(_1585_),
    .Y(\cpuregs_wrdata[12] ));
 sky130_fd_sc_hd__nor2_1 _5637_ (.A(_1578_),
    .B(_1520_),
    .Y(_1586_));
 sky130_fd_sc_hd__xnor2_1 _5638_ (.A(\reg_pc[11] ),
    .B(_1586_),
    .Y(_1587_));
 sky130_fd_sc_hd__nand2_1 _5639_ (.A(_0896_),
    .B(net725),
    .Y(_1588_));
 sky130_fd_sc_hd__o21ai_4 _5640_ (.A1(net725),
    .A2(_1587_),
    .B1(_1588_),
    .Y(\cpuregs_wrdata[11] ));
 sky130_fd_sc_hd__nand2_1 _5641_ (.A(net735),
    .B(_1509_),
    .Y(_1589_));
 sky130_fd_sc_hd__xor2_1 _5642_ (.A(\reg_pc[10] ),
    .B(_1589_),
    .X(_1590_));
 sky130_fd_sc_hd__nand2_1 _5643_ (.A(_0893_),
    .B(net725),
    .Y(_1591_));
 sky130_fd_sc_hd__o21ai_4 _5644_ (.A1(net725),
    .A2(_1590_),
    .B1(_1591_),
    .Y(\cpuregs_wrdata[10] ));
 sky130_fd_sc_hd__xor2_1 _5645_ (.A(net735),
    .B(_1520_),
    .X(_1592_));
 sky130_fd_sc_hd__nand2_1 _5646_ (.A(_0892_),
    .B(net725),
    .Y(_1593_));
 sky130_fd_sc_hd__o21ai_4 _5647_ (.A1(net725),
    .A2(_1592_),
    .B1(_1593_),
    .Y(\cpuregs_wrdata[9] ));
 sky130_fd_sc_hd__nand2_1 _5648_ (.A(\reg_pc[6] ),
    .B(\reg_pc[7] ),
    .Y(_1594_));
 sky130_fd_sc_hd__nor2_1 _5649_ (.A(_1507_),
    .B(_1594_),
    .Y(_1595_));
 sky130_fd_sc_hd__xnor2_1 _5650_ (.A(\reg_pc[8] ),
    .B(_1595_),
    .Y(_1596_));
 sky130_fd_sc_hd__nand2_1 _5651_ (.A(_0889_),
    .B(net725),
    .Y(_1597_));
 sky130_fd_sc_hd__o21ai_4 _5652_ (.A1(net725),
    .A2(_1596_),
    .B1(_1597_),
    .Y(\cpuregs_wrdata[8] ));
 sky130_fd_sc_hd__nand2_1 _5653_ (.A(\reg_pc[6] ),
    .B(_1519_),
    .Y(_1598_));
 sky130_fd_sc_hd__xor2_1 _5654_ (.A(\reg_pc[7] ),
    .B(_1598_),
    .X(_1599_));
 sky130_fd_sc_hd__nand2_1 _5655_ (.A(_0888_),
    .B(net725),
    .Y(_1600_));
 sky130_fd_sc_hd__o21ai_4 _5656_ (.A1(net725),
    .A2(_1599_),
    .B1(_1600_),
    .Y(\cpuregs_wrdata[7] ));
 sky130_fd_sc_hd__xor2_1 _5657_ (.A(\reg_pc[6] ),
    .B(_1507_),
    .X(_1601_));
 sky130_fd_sc_hd__nand2_1 _5658_ (.A(_0887_),
    .B(net725),
    .Y(_1602_));
 sky130_fd_sc_hd__o21ai_4 _5659_ (.A1(net725),
    .A2(_1601_),
    .B1(_1602_),
    .Y(\cpuregs_wrdata[6] ));
 sky130_fd_sc_hd__nand3_1 _5660_ (.A(\reg_pc[2] ),
    .B(\reg_pc[3] ),
    .C(\reg_pc[4] ),
    .Y(_1603_));
 sky130_fd_sc_hd__xor2_1 _5661_ (.A(\reg_pc[5] ),
    .B(_1603_),
    .X(_1604_));
 sky130_fd_sc_hd__nand2_1 _5662_ (.A(_0884_),
    .B(net725),
    .Y(_1605_));
 sky130_fd_sc_hd__o21ai_4 _5663_ (.A1(net725),
    .A2(_1604_),
    .B1(_1605_),
    .Y(\cpuregs_wrdata[5] ));
 sky130_fd_sc_hd__xor2_1 _5664_ (.A(\reg_pc[4] ),
    .B(_0144_),
    .X(_1606_));
 sky130_fd_sc_hd__nand2_1 _5665_ (.A(_1498_),
    .B(_1606_),
    .Y(_1607_));
 sky130_fd_sc_hd__o21ai_4 _5666_ (.A1(_0882_),
    .A2(_1498_),
    .B1(_1607_),
    .Y(\cpuregs_wrdata[4] ));
 sky130_fd_sc_hd__nand2_1 _5667_ (.A(_0145_),
    .B(_1498_),
    .Y(_1608_));
 sky130_fd_sc_hd__o21ai_4 _5668_ (.A1(_0878_),
    .A2(_1498_),
    .B1(_1608_),
    .Y(\cpuregs_wrdata[3] ));
 sky130_fd_sc_hd__nor2_1 _5669_ (.A(_0873_),
    .B(_1498_),
    .Y(_1609_));
 sky130_fd_sc_hd__a21oi_4 _5670_ (.A1(\reg_pc[2] ),
    .A2(_1498_),
    .B1(_1609_),
    .Y(\cpuregs_wrdata[2] ));
 sky130_fd_sc_hd__nand2_1 _5671_ (.A(\reg_pc[1] ),
    .B(_1498_),
    .Y(_1610_));
 sky130_fd_sc_hd__o21ai_4 _5672_ (.A1(_0871_),
    .A2(_1498_),
    .B1(_1610_),
    .Y(\cpuregs_wrdata[1] ));
 sky130_fd_sc_hd__mux2i_1 _5673_ (.A0(\reg_out[0] ),
    .A1(\alu_out_q[0] ),
    .S(latched_stalu),
    .Y(_1611_));
 sky130_fd_sc_hd__nor2_4 _5674_ (.A(_1498_),
    .B(_1611_),
    .Y(\cpuregs_wrdata[0] ));
 sky130_fd_sc_hd__inv_1 _5675_ (.A(net325),
    .Y(_0284_));
 sky130_fd_sc_hd__inv_1 _5676_ (.A(net309),
    .Y(_0376_));
 sky130_fd_sc_hd__inv_1 _5677_ (.A(net341),
    .Y(_0371_));
 sky130_fd_sc_hd__inv_1 _5678_ (.A(\mem_state[0] ),
    .Y(_0485_));
 sky130_fd_sc_hd__inv_1 _5679_ (.A(net310),
    .Y(_0370_));
 sky130_fd_sc_hd__inv_1 _5680_ (.A(net342),
    .Y(_0365_));
 sky130_fd_sc_hd__inv_1 _5681_ (.A(net741),
    .Y(_0476_));
 sky130_fd_sc_hd__inv_1 _5682_ (.A(net311),
    .Y(_0364_));
 sky130_fd_sc_hd__nor2_2 _5684_ (.A(\cpu_state[5] ),
    .B(\cpu_state[6] ),
    .Y(_1613_));
 sky130_fd_sc_hd__inv_1 _5687_ (.A(_0133_),
    .Y(_1616_));
 sky130_fd_sc_hd__a21oi_1 _5688_ (.A1(_0131_),
    .A2(_0134_),
    .B1(_0130_),
    .Y(_1617_));
 sky130_fd_sc_hd__o21bai_1 _5689_ (.A1(_1616_),
    .A2(_1617_),
    .B1_N(_0132_),
    .Y(_1618_));
 sky130_fd_sc_hd__inv_1 _5690_ (.A(_0136_),
    .Y(_1619_));
 sky130_fd_sc_hd__inv_1 _5691_ (.A(_0186_),
    .Y(_1620_));
 sky130_fd_sc_hd__a21oi_1 _5692_ (.A1(_0190_),
    .A2(_0059_),
    .B1(_0189_),
    .Y(_1621_));
 sky130_fd_sc_hd__o21bai_1 _5693_ (.A1(_1620_),
    .A2(_1621_),
    .B1_N(_0185_),
    .Y(_1622_));
 sky130_fd_sc_hd__a21oi_1 _5694_ (.A1(_0188_),
    .A2(_1622_),
    .B1(_0187_),
    .Y(_1623_));
 sky130_fd_sc_hd__and3_1 _5695_ (.A(_0178_),
    .B(_0182_),
    .C(_0180_),
    .X(_1624_));
 sky130_fd_sc_hd__nand3_1 _5696_ (.A(_0176_),
    .B(_0184_),
    .C(_1624_),
    .Y(_1625_));
 sky130_fd_sc_hd__a21o_1 _5697_ (.A1(_0182_),
    .A2(_0179_),
    .B1(_0181_),
    .X(_1626_));
 sky130_fd_sc_hd__a21o_1 _5698_ (.A1(_0178_),
    .A2(_1626_),
    .B1(_0177_),
    .X(_1627_));
 sky130_fd_sc_hd__and3_1 _5699_ (.A(_0176_),
    .B(_0183_),
    .C(_1624_),
    .X(_1628_));
 sky130_fd_sc_hd__a21oi_1 _5700_ (.A1(_0176_),
    .A2(_1627_),
    .B1(_1628_),
    .Y(_1629_));
 sky130_fd_sc_hd__o21ai_0 _5701_ (.A1(_1623_),
    .A2(_1625_),
    .B1(_1629_),
    .Y(_1630_));
 sky130_fd_sc_hd__a21o_1 _5702_ (.A1(_0174_),
    .A2(_0171_),
    .B1(_0173_),
    .X(_1631_));
 sky130_fd_sc_hd__a21oi_1 _5703_ (.A1(_0205_),
    .A2(_1631_),
    .B1(_0204_),
    .Y(_1632_));
 sky130_fd_sc_hd__nor2_1 _5704_ (.A(_0169_),
    .B(_0175_),
    .Y(_1633_));
 sky130_fd_sc_hd__nand2_1 _5705_ (.A(_1632_),
    .B(_1633_),
    .Y(_1634_));
 sky130_fd_sc_hd__and3_1 _5706_ (.A(_0205_),
    .B(_0174_),
    .C(_0172_),
    .X(_1635_));
 sky130_fd_sc_hd__nor2_1 _5707_ (.A(_0169_),
    .B(_1635_),
    .Y(_1636_));
 sky130_fd_sc_hd__nand2_1 _5708_ (.A(_1632_),
    .B(_1636_),
    .Y(_1637_));
 sky130_fd_sc_hd__o221ai_1 _5709_ (.A1(_0170_),
    .A2(_0169_),
    .B1(_1630_),
    .B2(_1634_),
    .C1(_1637_),
    .Y(_1638_));
 sky130_fd_sc_hd__nand4_1 _5712_ (.A(_0196_),
    .B(_0166_),
    .C(_0162_),
    .D(_0200_),
    .Y(_1641_));
 sky130_fd_sc_hd__nand3_1 _5713_ (.A(_0198_),
    .B(_0164_),
    .C(_0168_),
    .Y(_1642_));
 sky130_fd_sc_hd__nor2_1 _5714_ (.A(_1641_),
    .B(_1642_),
    .Y(_1643_));
 sky130_fd_sc_hd__and3_1 _5715_ (.A(_0141_),
    .B(_0139_),
    .C(_0160_),
    .X(_1644_));
 sky130_fd_sc_hd__and2_1 _5716_ (.A(_0194_),
    .B(_1644_),
    .X(_1645_));
 sky130_fd_sc_hd__nand2_1 _5717_ (.A(_1643_),
    .B(_1645_),
    .Y(_1646_));
 sky130_fd_sc_hd__nand2_1 _5718_ (.A(_0193_),
    .B(_1644_),
    .Y(_1647_));
 sky130_fd_sc_hd__nand3_1 _5719_ (.A(_0196_),
    .B(_0166_),
    .C(_0162_),
    .Y(_1648_));
 sky130_fd_sc_hd__inv_1 _5720_ (.A(_0198_),
    .Y(_1649_));
 sky130_fd_sc_hd__a21oi_1 _5721_ (.A1(_0164_),
    .A2(_0167_),
    .B1(_0163_),
    .Y(_1650_));
 sky130_fd_sc_hd__inv_1 _5722_ (.A(_0197_),
    .Y(_1651_));
 sky130_fd_sc_hd__o21ai_0 _5723_ (.A1(_1649_),
    .A2(_1650_),
    .B1(_1651_),
    .Y(_1652_));
 sky130_fd_sc_hd__a21oi_1 _5724_ (.A1(_0200_),
    .A2(_1652_),
    .B1(_0199_),
    .Y(_1653_));
 sky130_fd_sc_hd__a21o_1 _5725_ (.A1(_0166_),
    .A2(_0161_),
    .B1(_0165_),
    .X(_1654_));
 sky130_fd_sc_hd__a21oi_1 _5726_ (.A1(_0196_),
    .A2(_1654_),
    .B1(_0195_),
    .Y(_1655_));
 sky130_fd_sc_hd__o21ai_0 _5727_ (.A1(_1648_),
    .A2(_1653_),
    .B1(_1655_),
    .Y(_1656_));
 sky130_fd_sc_hd__nand2_1 _5728_ (.A(_1656_),
    .B(_1645_),
    .Y(_1657_));
 sky130_fd_sc_hd__o211a_1 _5729_ (.A1(_1638_),
    .A2(_1646_),
    .B1(_1647_),
    .C1(_1657_),
    .X(_1658_));
 sky130_fd_sc_hd__a21o_1 _5730_ (.A1(_0139_),
    .A2(_0159_),
    .B1(_0138_),
    .X(_1659_));
 sky130_fd_sc_hd__a21oi_1 _5731_ (.A1(_0141_),
    .A2(_1659_),
    .B1(_0140_),
    .Y(_1660_));
 sky130_fd_sc_hd__o21ai_0 _5732_ (.A1(_0137_),
    .A2(_0136_),
    .B1(_0135_),
    .Y(_1661_));
 sky130_fd_sc_hd__a31oi_1 _5733_ (.A1(_1619_),
    .A2(_1658_),
    .A3(_1660_),
    .B1(_1661_),
    .Y(_1662_));
 sky130_fd_sc_hd__and3_1 _5734_ (.A(_0129_),
    .B(_0133_),
    .C(_0131_),
    .X(_1663_));
 sky130_fd_sc_hd__a221oi_1 _5735_ (.A1(_0129_),
    .A2(_1618_),
    .B1(_1662_),
    .B2(_1663_),
    .C1(_0128_),
    .Y(_1664_));
 sky130_fd_sc_hd__xor2_1 _5736_ (.A(_0127_),
    .B(_1664_),
    .X(_1665_));
 sky130_fd_sc_hd__nor2_1 _5740_ (.A(instr_srai),
    .B(instr_sra),
    .Y(_1669_));
 sky130_fd_sc_hd__nor2_1 _5741_ (.A(instr_srli),
    .B(instr_srl),
    .Y(_1670_));
 sky130_fd_sc_hd__nand2_1 _5742_ (.A(net723),
    .B(_1670_),
    .Y(_1671_));
 sky130_fd_sc_hd__a2111o_1 _5744_ (.A1(_0119_),
    .A2(_0101_),
    .B1(\reg_sh[3] ),
    .C1(\reg_sh[4] ),
    .D1(\reg_sh[2] ),
    .X(_1673_));
 sky130_fd_sc_hd__inv_1 _5746_ (.A(net743),
    .Y(_0257_));
 sky130_fd_sc_hd__nor2_1 _5747_ (.A(_0257_),
    .B(net697),
    .Y(_1675_));
 sky130_fd_sc_hd__a21oi_1 _5748_ (.A1(net746),
    .A2(net697),
    .B1(_1675_),
    .Y(_1676_));
 sky130_fd_sc_hd__o21ai_0 _5749_ (.A1(_1670_),
    .A2(net697),
    .B1(net723),
    .Y(_1677_));
 sky130_fd_sc_hd__nand2_1 _5750_ (.A(net741),
    .B(_1677_),
    .Y(_1678_));
 sky130_fd_sc_hd__o21ai_0 _5751_ (.A1(net708),
    .A2(_1676_),
    .B1(_1678_),
    .Y(_1679_));
 sky130_fd_sc_hd__or4_1 _5752_ (.A(\decoded_imm_j[18] ),
    .B(\decoded_imm_j[17] ),
    .C(\decoded_imm_j[16] ),
    .D(\decoded_imm_j[15] ),
    .X(_1680_));
 sky130_fd_sc_hd__o21bai_4 _5753_ (.A1(\decoded_imm_j[19] ),
    .A2(_1680_),
    .B1_N(is_lui_auipc_jal),
    .Y(_1681_));
 sky130_fd_sc_hd__mux4_2 _5760_ (.A0(\cpuregs[0][30] ),
    .A1(\cpuregs[1][30] ),
    .A2(\cpuregs[2][30] ),
    .A3(\cpuregs[3][30] ),
    .S0(net817),
    .S1(net811),
    .X(_1688_));
 sky130_fd_sc_hd__mux4_2 _5765_ (.A0(\cpuregs[4][30] ),
    .A1(\cpuregs[5][30] ),
    .A2(\cpuregs[6][30] ),
    .A3(\cpuregs[7][30] ),
    .S0(net820),
    .S1(net809),
    .X(_1693_));
 sky130_fd_sc_hd__mux4_2 _5768_ (.A0(\cpuregs[16][30] ),
    .A1(\cpuregs[17][30] ),
    .A2(\cpuregs[18][30] ),
    .A3(\cpuregs[19][30] ),
    .S0(net820),
    .S1(net809),
    .X(_1696_));
 sky130_fd_sc_hd__mux4_2 _5771_ (.A0(\cpuregs[20][30] ),
    .A1(\cpuregs[21][30] ),
    .A2(\cpuregs[22][30] ),
    .A3(\cpuregs[23][30] ),
    .S0(net817),
    .S1(net811),
    .X(_1699_));
 sky130_fd_sc_hd__mux4_2 _5776_ (.A0(_1688_),
    .A1(_1693_),
    .A2(_1696_),
    .A3(_1699_),
    .S0(net803),
    .S1(net800),
    .X(_1704_));
 sky130_fd_sc_hd__mux4_2 _5777_ (.A0(\cpuregs[8][30] ),
    .A1(\cpuregs[9][30] ),
    .A2(\cpuregs[10][30] ),
    .A3(\cpuregs[11][30] ),
    .S0(net817),
    .S1(net811),
    .X(_1705_));
 sky130_fd_sc_hd__mux4_2 _5781_ (.A0(\cpuregs[12][30] ),
    .A1(\cpuregs[13][30] ),
    .A2(\cpuregs[14][30] ),
    .A3(\cpuregs[15][30] ),
    .S0(net817),
    .S1(net811),
    .X(_1709_));
 sky130_fd_sc_hd__mux4_2 _5784_ (.A0(\cpuregs[24][30] ),
    .A1(\cpuregs[25][30] ),
    .A2(\cpuregs[26][30] ),
    .A3(\cpuregs[27][30] ),
    .S0(net819),
    .S1(net809),
    .X(_1712_));
 sky130_fd_sc_hd__mux4_2 _5785_ (.A0(\cpuregs[28][30] ),
    .A1(\cpuregs[29][30] ),
    .A2(\cpuregs[30][30] ),
    .A3(\cpuregs[31][30] ),
    .S0(net820),
    .S1(net809),
    .X(_1713_));
 sky130_fd_sc_hd__mux4_2 _5787_ (.A0(_1705_),
    .A1(_1709_),
    .A2(_1712_),
    .A3(_1713_),
    .S0(net803),
    .S1(net800),
    .X(_1715_));
 sky130_fd_sc_hd__mux2i_1 _5791_ (.A0(_1704_),
    .A1(_1715_),
    .S(_0044_),
    .Y(_1719_));
 sky130_fd_sc_hd__nor2b_2 _5792_ (.A(instr_lui),
    .B_N(is_lui_auipc_jal),
    .Y(_1720_));
 sky130_fd_sc_hd__nand2_1 _5794_ (.A(\reg_pc[30] ),
    .B(net722),
    .Y(_1722_));
 sky130_fd_sc_hd__o21ai_0 _5795_ (.A1(net707),
    .A2(_1719_),
    .B1(_1722_),
    .Y(_1723_));
 sky130_fd_sc_hd__or2_2 _5796_ (.A(\cpu_state[5] ),
    .B(\cpu_state[6] ),
    .X(_1724_));
 sky130_fd_sc_hd__nor2_1 _5797_ (.A(net774),
    .B(net721),
    .Y(_1725_));
 sky130_fd_sc_hd__a22oi_1 _5799_ (.A1(net774),
    .A2(_1679_),
    .B1(_1723_),
    .B2(_1725_),
    .Y(_1727_));
 sky130_fd_sc_hd__o21ai_0 _5800_ (.A1(net724),
    .A2(_1665_),
    .B1(_1727_),
    .Y(_4672_));
 sky130_fd_sc_hd__a21o_1 _5801_ (.A1(_0172_),
    .A2(_0175_),
    .B1(_0171_),
    .X(_1728_));
 sky130_fd_sc_hd__a21o_1 _5802_ (.A1(_0174_),
    .A2(_1728_),
    .B1(_0173_),
    .X(_1729_));
 sky130_fd_sc_hd__a21o_1 _5803_ (.A1(_0205_),
    .A2(_1729_),
    .B1(_0204_),
    .X(_1730_));
 sky130_fd_sc_hd__a21o_1 _5804_ (.A1(_0180_),
    .A2(_0183_),
    .B1(_0179_),
    .X(_1731_));
 sky130_fd_sc_hd__a21o_1 _5805_ (.A1(_0182_),
    .A2(_1731_),
    .B1(_0181_),
    .X(_1732_));
 sky130_fd_sc_hd__a21o_1 _5806_ (.A1(_0178_),
    .A2(_1732_),
    .B1(_0177_),
    .X(_1733_));
 sky130_fd_sc_hd__and3_1 _5807_ (.A(_0170_),
    .B(_0176_),
    .C(_1635_),
    .X(_1734_));
 sky130_fd_sc_hd__a22oi_1 _5808_ (.A1(_0170_),
    .A2(_1730_),
    .B1(_1733_),
    .B2(_1734_),
    .Y(_1735_));
 sky130_fd_sc_hd__a21o_1 _5809_ (.A1(_0102_),
    .A2(_0058_),
    .B1(_0192_),
    .X(_1736_));
 sky130_fd_sc_hd__a21oi_1 _5810_ (.A1(_0190_),
    .A2(_1736_),
    .B1(_0189_),
    .Y(_1737_));
 sky130_fd_sc_hd__nand3_1 _5811_ (.A(_0184_),
    .B(_0188_),
    .C(_1624_),
    .Y(_1738_));
 sky130_fd_sc_hd__nor3_1 _5812_ (.A(_1620_),
    .B(_1737_),
    .C(_1738_),
    .Y(_1739_));
 sky130_fd_sc_hd__nand4_1 _5813_ (.A(_0184_),
    .B(_0188_),
    .C(_0185_),
    .D(_1624_),
    .Y(_1740_));
 sky130_fd_sc_hd__nand3_1 _5814_ (.A(_0184_),
    .B(_0187_),
    .C(_1624_),
    .Y(_1741_));
 sky130_fd_sc_hd__nand2_1 _5815_ (.A(_1740_),
    .B(_1741_),
    .Y(_1742_));
 sky130_fd_sc_hd__o21ai_0 _5816_ (.A1(_1739_),
    .A2(_1742_),
    .B1(_1734_),
    .Y(_1743_));
 sky130_fd_sc_hd__nand2_1 _5817_ (.A(_1735_),
    .B(_1743_),
    .Y(_1744_));
 sky130_fd_sc_hd__a21o_1 _5818_ (.A1(_0168_),
    .A2(_0169_),
    .B1(_0167_),
    .X(_1745_));
 sky130_fd_sc_hd__a21o_1 _5819_ (.A1(_0164_),
    .A2(_1745_),
    .B1(_0163_),
    .X(_1746_));
 sky130_fd_sc_hd__a21oi_1 _5820_ (.A1(_0198_),
    .A2(_1746_),
    .B1(_0197_),
    .Y(_1747_));
 sky130_fd_sc_hd__a21o_1 _5821_ (.A1(_0162_),
    .A2(_0199_),
    .B1(_0161_),
    .X(_1748_));
 sky130_fd_sc_hd__a21o_1 _5822_ (.A1(_0166_),
    .A2(_1748_),
    .B1(_0165_),
    .X(_1749_));
 sky130_fd_sc_hd__a21oi_1 _5823_ (.A1(_0196_),
    .A2(_1749_),
    .B1(_0195_),
    .Y(_1750_));
 sky130_fd_sc_hd__o21ai_1 _5824_ (.A1(_1641_),
    .A2(_1747_),
    .B1(_1750_),
    .Y(_1751_));
 sky130_fd_sc_hd__nand2_1 _5825_ (.A(_1647_),
    .B(_1660_),
    .Y(_1752_));
 sky130_fd_sc_hd__a21o_1 _5826_ (.A1(_1645_),
    .A2(_1751_),
    .B1(_1752_),
    .X(_1753_));
 sky130_fd_sc_hd__a31oi_1 _5827_ (.A1(_1643_),
    .A2(_1645_),
    .A3(_1744_),
    .B1(_1753_),
    .Y(_1754_));
 sky130_fd_sc_hd__nand2_1 _5828_ (.A(_0135_),
    .B(_0137_),
    .Y(_1755_));
 sky130_fd_sc_hd__a21oi_1 _5829_ (.A1(_0135_),
    .A2(_0136_),
    .B1(_0134_),
    .Y(_1756_));
 sky130_fd_sc_hd__o21ai_1 _5830_ (.A1(_1754_),
    .A2(_1755_),
    .B1(_1756_),
    .Y(_1757_));
 sky130_fd_sc_hd__a21oi_1 _5831_ (.A1(_0131_),
    .A2(_1757_),
    .B1(_0130_),
    .Y(_1758_));
 sky130_fd_sc_hd__nor4_1 _5832_ (.A(_0129_),
    .B(_1616_),
    .C(net724),
    .D(_1758_),
    .Y(_1759_));
 sky130_fd_sc_hd__and4b_1 _5833_ (.A_N(_0132_),
    .B(net721),
    .C(_1758_),
    .D(_0129_),
    .X(_1760_));
 sky130_fd_sc_hd__nor2_1 _5834_ (.A(_0133_),
    .B(_0132_),
    .Y(_1761_));
 sky130_fd_sc_hd__mux2i_1 _5835_ (.A0(_0132_),
    .A1(_1761_),
    .S(_0129_),
    .Y(_1762_));
 sky130_fd_sc_hd__nor4_2 _5836_ (.A(instr_srli),
    .B(instr_srai),
    .C(instr_srl),
    .D(instr_sra),
    .Y(_1763_));
 sky130_fd_sc_hd__mux2i_1 _5838_ (.A0(net742),
    .A1(net744),
    .S(net720),
    .Y(_1765_));
 sky130_fd_sc_hd__a2111oi_4 _5839_ (.A1(_0119_),
    .A2(_0101_),
    .B1(\reg_sh[3] ),
    .C1(\reg_sh[4] ),
    .D1(\reg_sh[2] ),
    .Y(_1766_));
 sky130_fd_sc_hd__nor3_1 _5840_ (.A(_0476_),
    .B(net723),
    .C(net696),
    .Y(_1767_));
 sky130_fd_sc_hd__a31oi_1 _5841_ (.A1(net747),
    .A2(net720),
    .A3(net697),
    .B1(_1767_),
    .Y(_1768_));
 sky130_fd_sc_hd__o21ai_0 _5842_ (.A1(net697),
    .A2(_1765_),
    .B1(_1768_),
    .Y(_1769_));
 sky130_fd_sc_hd__mux4_2 _5845_ (.A0(\cpuregs[0][29] ),
    .A1(\cpuregs[1][29] ),
    .A2(\cpuregs[2][29] ),
    .A3(\cpuregs[3][29] ),
    .S0(net817),
    .S1(net811),
    .X(_1772_));
 sky130_fd_sc_hd__mux4_2 _5846_ (.A0(\cpuregs[4][29] ),
    .A1(\cpuregs[5][29] ),
    .A2(\cpuregs[6][29] ),
    .A3(\cpuregs[7][29] ),
    .S0(net817),
    .S1(net811),
    .X(_1773_));
 sky130_fd_sc_hd__mux4_2 _5847_ (.A0(\cpuregs[16][29] ),
    .A1(\cpuregs[17][29] ),
    .A2(\cpuregs[18][29] ),
    .A3(\cpuregs[19][29] ),
    .S0(net820),
    .S1(net809),
    .X(_1774_));
 sky130_fd_sc_hd__mux4_2 _5848_ (.A0(\cpuregs[20][29] ),
    .A1(\cpuregs[21][29] ),
    .A2(\cpuregs[22][29] ),
    .A3(\cpuregs[23][29] ),
    .S0(net817),
    .S1(net811),
    .X(_1775_));
 sky130_fd_sc_hd__mux4_2 _5849_ (.A0(_1772_),
    .A1(_1773_),
    .A2(_1774_),
    .A3(_1775_),
    .S0(net803),
    .S1(net800),
    .X(_1776_));
 sky130_fd_sc_hd__mux4_2 _5850_ (.A0(\cpuregs[8][29] ),
    .A1(\cpuregs[9][29] ),
    .A2(\cpuregs[10][29] ),
    .A3(\cpuregs[11][29] ),
    .S0(net817),
    .S1(net811),
    .X(_1777_));
 sky130_fd_sc_hd__mux4_2 _5851_ (.A0(\cpuregs[12][29] ),
    .A1(\cpuregs[13][29] ),
    .A2(\cpuregs[14][29] ),
    .A3(\cpuregs[15][29] ),
    .S0(net817),
    .S1(net811),
    .X(_1778_));
 sky130_fd_sc_hd__mux4_2 _5852_ (.A0(\cpuregs[24][29] ),
    .A1(\cpuregs[25][29] ),
    .A2(\cpuregs[26][29] ),
    .A3(\cpuregs[27][29] ),
    .S0(net819),
    .S1(net809),
    .X(_1779_));
 sky130_fd_sc_hd__mux4_2 _5853_ (.A0(\cpuregs[28][29] ),
    .A1(\cpuregs[29][29] ),
    .A2(\cpuregs[30][29] ),
    .A3(\cpuregs[31][29] ),
    .S0(net820),
    .S1(net809),
    .X(_1780_));
 sky130_fd_sc_hd__mux4_2 _5854_ (.A0(_1777_),
    .A1(_1778_),
    .A2(_1779_),
    .A3(_1780_),
    .S0(net803),
    .S1(net800),
    .X(_1781_));
 sky130_fd_sc_hd__mux2i_1 _5855_ (.A0(_1776_),
    .A1(_1781_),
    .S(_0044_),
    .Y(_1782_));
 sky130_fd_sc_hd__nand2_1 _5856_ (.A(\reg_pc[29] ),
    .B(net722),
    .Y(_1783_));
 sky130_fd_sc_hd__o21ai_0 _5857_ (.A1(net707),
    .A2(_1782_),
    .B1(_1783_),
    .Y(_1784_));
 sky130_fd_sc_hd__a22oi_1 _5858_ (.A1(net774),
    .A2(_1769_),
    .B1(_1784_),
    .B2(_1725_),
    .Y(_1785_));
 sky130_fd_sc_hd__o21ai_0 _5859_ (.A1(net724),
    .A2(_1762_),
    .B1(_1785_),
    .Y(_1786_));
 sky130_fd_sc_hd__or3_1 _5860_ (.A(_1759_),
    .B(_1760_),
    .C(_1786_),
    .X(_4670_));
 sky130_fd_sc_hd__nor4_1 _5861_ (.A(_1616_),
    .B(_0130_),
    .C(_0134_),
    .D(_1662_),
    .Y(_1787_));
 sky130_fd_sc_hd__o211a_1 _5862_ (.A1(_0134_),
    .A2(_1662_),
    .B1(_1616_),
    .C1(_0131_),
    .X(_1788_));
 sky130_fd_sc_hd__o21ai_0 _5864_ (.A1(_1787_),
    .A2(_1788_),
    .B1(net721),
    .Y(_1790_));
 sky130_fd_sc_hd__mux4_2 _5870_ (.A0(\cpuregs[0][28] ),
    .A1(\cpuregs[1][28] ),
    .A2(\cpuregs[2][28] ),
    .A3(\cpuregs[3][28] ),
    .S0(net817),
    .S1(net811),
    .X(_1796_));
 sky130_fd_sc_hd__mux4_2 _5873_ (.A0(\cpuregs[4][28] ),
    .A1(\cpuregs[5][28] ),
    .A2(\cpuregs[6][28] ),
    .A3(\cpuregs[7][28] ),
    .S0(net820),
    .S1(net811),
    .X(_1799_));
 sky130_fd_sc_hd__mux4_2 _5876_ (.A0(\cpuregs[16][28] ),
    .A1(\cpuregs[17][28] ),
    .A2(\cpuregs[18][28] ),
    .A3(\cpuregs[19][28] ),
    .S0(net817),
    .S1(net811),
    .X(_1802_));
 sky130_fd_sc_hd__mux4_2 _5877_ (.A0(\cpuregs[20][28] ),
    .A1(\cpuregs[21][28] ),
    .A2(\cpuregs[22][28] ),
    .A3(\cpuregs[23][28] ),
    .S0(net817),
    .S1(net811),
    .X(_1803_));
 sky130_fd_sc_hd__mux4_2 _5882_ (.A0(_1796_),
    .A1(_1799_),
    .A2(_1802_),
    .A3(_1803_),
    .S0(net803),
    .S1(net800),
    .X(_1808_));
 sky130_fd_sc_hd__mux4_2 _5883_ (.A0(\cpuregs[8][28] ),
    .A1(\cpuregs[9][28] ),
    .A2(\cpuregs[10][28] ),
    .A3(\cpuregs[11][28] ),
    .S0(net817),
    .S1(net811),
    .X(_1809_));
 sky130_fd_sc_hd__mux4_2 _5886_ (.A0(\cpuregs[12][28] ),
    .A1(\cpuregs[13][28] ),
    .A2(\cpuregs[14][28] ),
    .A3(\cpuregs[15][28] ),
    .S0(net820),
    .S1(net809),
    .X(_1812_));
 sky130_fd_sc_hd__mux4_2 _5887_ (.A0(\cpuregs[24][28] ),
    .A1(\cpuregs[25][28] ),
    .A2(\cpuregs[26][28] ),
    .A3(\cpuregs[27][28] ),
    .S0(net820),
    .S1(net811),
    .X(_1813_));
 sky130_fd_sc_hd__mux4_2 _5888_ (.A0(\cpuregs[28][28] ),
    .A1(\cpuregs[29][28] ),
    .A2(\cpuregs[30][28] ),
    .A3(\cpuregs[31][28] ),
    .S0(net817),
    .S1(net811),
    .X(_1814_));
 sky130_fd_sc_hd__mux4_2 _5889_ (.A0(_1809_),
    .A1(_1812_),
    .A2(_1813_),
    .A3(_1814_),
    .S0(net803),
    .S1(net800),
    .X(_1815_));
 sky130_fd_sc_hd__mux2i_1 _5890_ (.A0(_1808_),
    .A1(_1815_),
    .S(net802),
    .Y(_1816_));
 sky130_fd_sc_hd__nand2_1 _5892_ (.A(\reg_pc[28] ),
    .B(net722),
    .Y(_1818_));
 sky130_fd_sc_hd__o21ai_0 _5893_ (.A1(net707),
    .A2(_1816_),
    .B1(_1818_),
    .Y(_1819_));
 sky130_fd_sc_hd__nand2_1 _5894_ (.A(_1725_),
    .B(_1819_),
    .Y(_1820_));
 sky130_fd_sc_hd__mux2i_1 _5897_ (.A0(net743),
    .A1(net745),
    .S(net720),
    .Y(_1823_));
 sky130_fd_sc_hd__a31oi_1 _5899_ (.A1(net748),
    .A2(net720),
    .A3(net697),
    .B1(_1767_),
    .Y(_1825_));
 sky130_fd_sc_hd__o21ai_0 _5900_ (.A1(net697),
    .A2(_1823_),
    .B1(_1825_),
    .Y(_1826_));
 sky130_fd_sc_hd__nor2_1 _5901_ (.A(_0131_),
    .B(_0130_),
    .Y(_1827_));
 sky130_fd_sc_hd__mux2i_1 _5902_ (.A0(_0130_),
    .A1(_1827_),
    .S(_0133_),
    .Y(_1828_));
 sky130_fd_sc_hd__nor2_1 _5903_ (.A(net724),
    .B(_1828_),
    .Y(_1829_));
 sky130_fd_sc_hd__a21oi_1 _5904_ (.A1(net774),
    .A2(_1826_),
    .B1(_1829_),
    .Y(_1830_));
 sky130_fd_sc_hd__nand3_1 _5905_ (.A(_1790_),
    .B(_1820_),
    .C(_1830_),
    .Y(_4669_));
 sky130_fd_sc_hd__xnor2_1 _5906_ (.A(_0131_),
    .B(_1757_),
    .Y(_1831_));
 sky130_fd_sc_hd__mux4_2 _5907_ (.A0(net744),
    .A1(net741),
    .A2(net746),
    .A3(net749),
    .S0(net697),
    .S1(net720),
    .X(_1832_));
 sky130_fd_sc_hd__mux4_2 _5908_ (.A0(\cpuregs[0][27] ),
    .A1(\cpuregs[1][27] ),
    .A2(\cpuregs[2][27] ),
    .A3(\cpuregs[3][27] ),
    .S0(net820),
    .S1(net811),
    .X(_1833_));
 sky130_fd_sc_hd__mux4_2 _5909_ (.A0(\cpuregs[4][27] ),
    .A1(\cpuregs[5][27] ),
    .A2(\cpuregs[6][27] ),
    .A3(\cpuregs[7][27] ),
    .S0(net813),
    .S1(net812),
    .X(_1834_));
 sky130_fd_sc_hd__mux4_2 _5910_ (.A0(\cpuregs[16][27] ),
    .A1(\cpuregs[17][27] ),
    .A2(\cpuregs[18][27] ),
    .A3(\cpuregs[19][27] ),
    .S0(net820),
    .S1(net811),
    .X(_1835_));
 sky130_fd_sc_hd__mux4_2 _5911_ (.A0(\cpuregs[20][27] ),
    .A1(\cpuregs[21][27] ),
    .A2(\cpuregs[22][27] ),
    .A3(\cpuregs[23][27] ),
    .S0(net813),
    .S1(net812),
    .X(_1836_));
 sky130_fd_sc_hd__mux4_2 _5912_ (.A0(_1833_),
    .A1(_1834_),
    .A2(_1835_),
    .A3(_1836_),
    .S0(net803),
    .S1(net801),
    .X(_1837_));
 sky130_fd_sc_hd__mux4_2 _5913_ (.A0(\cpuregs[8][27] ),
    .A1(\cpuregs[9][27] ),
    .A2(\cpuregs[10][27] ),
    .A3(\cpuregs[11][27] ),
    .S0(net817),
    .S1(net811),
    .X(_1838_));
 sky130_fd_sc_hd__mux4_2 _5914_ (.A0(\cpuregs[12][27] ),
    .A1(\cpuregs[13][27] ),
    .A2(\cpuregs[14][27] ),
    .A3(\cpuregs[15][27] ),
    .S0(net814),
    .S1(net811),
    .X(_1839_));
 sky130_fd_sc_hd__mux4_2 _5915_ (.A0(\cpuregs[24][27] ),
    .A1(\cpuregs[25][27] ),
    .A2(\cpuregs[26][27] ),
    .A3(\cpuregs[27][27] ),
    .S0(net814),
    .S1(net811),
    .X(_1840_));
 sky130_fd_sc_hd__mux4_2 _5916_ (.A0(\cpuregs[28][27] ),
    .A1(\cpuregs[29][27] ),
    .A2(\cpuregs[30][27] ),
    .A3(\cpuregs[31][27] ),
    .S0(net820),
    .S1(net807),
    .X(_1841_));
 sky130_fd_sc_hd__mux4_2 _5917_ (.A0(_1838_),
    .A1(_1839_),
    .A2(_1840_),
    .A3(_1841_),
    .S0(net803),
    .S1(net800),
    .X(_1842_));
 sky130_fd_sc_hd__mux2i_1 _5919_ (.A0(_1837_),
    .A1(_1842_),
    .S(net802),
    .Y(_1844_));
 sky130_fd_sc_hd__nand2_1 _5920_ (.A(\reg_pc[27] ),
    .B(net722),
    .Y(_1845_));
 sky130_fd_sc_hd__o21ai_0 _5921_ (.A1(net707),
    .A2(_1844_),
    .B1(_1845_),
    .Y(_1846_));
 sky130_fd_sc_hd__a22oi_1 _5922_ (.A1(net774),
    .A2(_1832_),
    .B1(_1846_),
    .B2(_1725_),
    .Y(_1847_));
 sky130_fd_sc_hd__o21ai_0 _5923_ (.A1(net724),
    .A2(_1831_),
    .B1(_1847_),
    .Y(_4668_));
 sky130_fd_sc_hd__nand2_1 _5925_ (.A(_1658_),
    .B(_1660_),
    .Y(_1849_));
 sky130_fd_sc_hd__a211oi_1 _5926_ (.A1(_0137_),
    .A2(_1849_),
    .B1(_0136_),
    .C1(_0135_),
    .Y(_1850_));
 sky130_fd_sc_hd__mux4_2 _5927_ (.A0(net742),
    .A1(net745),
    .A2(net750),
    .A3(net747),
    .S0(net696),
    .S1(net720),
    .X(_1851_));
 sky130_fd_sc_hd__mux4_2 _5930_ (.A0(\cpuregs[0][26] ),
    .A1(\cpuregs[1][26] ),
    .A2(\cpuregs[2][26] ),
    .A3(\cpuregs[3][26] ),
    .S0(net817),
    .S1(net811),
    .X(_1854_));
 sky130_fd_sc_hd__mux4_2 _5931_ (.A0(\cpuregs[4][26] ),
    .A1(\cpuregs[5][26] ),
    .A2(\cpuregs[6][26] ),
    .A3(\cpuregs[7][26] ),
    .S0(net820),
    .S1(net811),
    .X(_1855_));
 sky130_fd_sc_hd__mux4_2 _5932_ (.A0(\cpuregs[16][26] ),
    .A1(\cpuregs[17][26] ),
    .A2(\cpuregs[18][26] ),
    .A3(\cpuregs[19][26] ),
    .S0(net817),
    .S1(net811),
    .X(_1856_));
 sky130_fd_sc_hd__mux4_2 _5933_ (.A0(\cpuregs[20][26] ),
    .A1(\cpuregs[21][26] ),
    .A2(\cpuregs[22][26] ),
    .A3(\cpuregs[23][26] ),
    .S0(net817),
    .S1(net811),
    .X(_1857_));
 sky130_fd_sc_hd__mux4_2 _5935_ (.A0(_1854_),
    .A1(_1855_),
    .A2(_1856_),
    .A3(_1857_),
    .S0(net805),
    .S1(net801),
    .X(_1859_));
 sky130_fd_sc_hd__mux4_2 _5936_ (.A0(\cpuregs[8][26] ),
    .A1(\cpuregs[9][26] ),
    .A2(\cpuregs[10][26] ),
    .A3(\cpuregs[11][26] ),
    .S0(net817),
    .S1(net811),
    .X(_1860_));
 sky130_fd_sc_hd__mux4_2 _5937_ (.A0(\cpuregs[12][26] ),
    .A1(\cpuregs[13][26] ),
    .A2(\cpuregs[14][26] ),
    .A3(\cpuregs[15][26] ),
    .S0(net817),
    .S1(net811),
    .X(_1861_));
 sky130_fd_sc_hd__mux4_2 _5940_ (.A0(\cpuregs[24][26] ),
    .A1(\cpuregs[25][26] ),
    .A2(\cpuregs[26][26] ),
    .A3(\cpuregs[27][26] ),
    .S0(net817),
    .S1(net811),
    .X(_1864_));
 sky130_fd_sc_hd__mux4_2 _5941_ (.A0(\cpuregs[28][26] ),
    .A1(\cpuregs[29][26] ),
    .A2(\cpuregs[30][26] ),
    .A3(\cpuregs[31][26] ),
    .S0(net817),
    .S1(net811),
    .X(_1865_));
 sky130_fd_sc_hd__mux4_2 _5942_ (.A0(_1860_),
    .A1(_1861_),
    .A2(_1864_),
    .A3(_1865_),
    .S0(net803),
    .S1(net800),
    .X(_1866_));
 sky130_fd_sc_hd__mux2i_1 _5943_ (.A0(_1859_),
    .A1(_1866_),
    .S(_0044_),
    .Y(_1867_));
 sky130_fd_sc_hd__nand2_1 _5944_ (.A(\reg_pc[26] ),
    .B(net722),
    .Y(_1868_));
 sky130_fd_sc_hd__o21ai_0 _5945_ (.A1(net707),
    .A2(_1867_),
    .B1(_1868_),
    .Y(_1869_));
 sky130_fd_sc_hd__a22oi_1 _5946_ (.A1(net774),
    .A2(_1851_),
    .B1(_1869_),
    .B2(_1725_),
    .Y(_1870_));
 sky130_fd_sc_hd__o31ai_1 _5947_ (.A1(net724),
    .A2(_1662_),
    .A3(_1850_),
    .B1(_1870_),
    .Y(_4667_));
 sky130_fd_sc_hd__xor2_1 _5948_ (.A(_0137_),
    .B(_1754_),
    .X(_1871_));
 sky130_fd_sc_hd__mux4_2 _5950_ (.A0(\cpuregs[0][25] ),
    .A1(\cpuregs[1][25] ),
    .A2(\cpuregs[2][25] ),
    .A3(\cpuregs[3][25] ),
    .S0(net820),
    .S1(net809),
    .X(_1873_));
 sky130_fd_sc_hd__mux4_2 _5954_ (.A0(\cpuregs[4][25] ),
    .A1(\cpuregs[5][25] ),
    .A2(\cpuregs[6][25] ),
    .A3(\cpuregs[7][25] ),
    .S0(net819),
    .S1(net809),
    .X(_1877_));
 sky130_fd_sc_hd__mux4_2 _5957_ (.A0(\cpuregs[16][25] ),
    .A1(\cpuregs[17][25] ),
    .A2(\cpuregs[18][25] ),
    .A3(\cpuregs[19][25] ),
    .S0(net817),
    .S1(net811),
    .X(_1880_));
 sky130_fd_sc_hd__mux4_2 _5958_ (.A0(\cpuregs[20][25] ),
    .A1(\cpuregs[21][25] ),
    .A2(\cpuregs[22][25] ),
    .A3(\cpuregs[23][25] ),
    .S0(net817),
    .S1(net811),
    .X(_1881_));
 sky130_fd_sc_hd__mux4_2 _5959_ (.A0(_1873_),
    .A1(_1877_),
    .A2(_1880_),
    .A3(_1881_),
    .S0(net803),
    .S1(net800),
    .X(_1882_));
 sky130_fd_sc_hd__mux4_2 _5962_ (.A0(\cpuregs[8][25] ),
    .A1(\cpuregs[9][25] ),
    .A2(\cpuregs[10][25] ),
    .A3(\cpuregs[11][25] ),
    .S0(net820),
    .S1(net809),
    .X(_1885_));
 sky130_fd_sc_hd__mux4_2 _5965_ (.A0(\cpuregs[12][25] ),
    .A1(\cpuregs[13][25] ),
    .A2(\cpuregs[14][25] ),
    .A3(\cpuregs[15][25] ),
    .S0(net820),
    .S1(net809),
    .X(_1888_));
 sky130_fd_sc_hd__mux4_2 _5968_ (.A0(\cpuregs[24][25] ),
    .A1(\cpuregs[25][25] ),
    .A2(\cpuregs[26][25] ),
    .A3(\cpuregs[27][25] ),
    .S0(net820),
    .S1(net809),
    .X(_1891_));
 sky130_fd_sc_hd__mux4_2 _5971_ (.A0(\cpuregs[28][25] ),
    .A1(\cpuregs[29][25] ),
    .A2(\cpuregs[30][25] ),
    .A3(\cpuregs[31][25] ),
    .S0(net814),
    .S1(net811),
    .X(_1894_));
 sky130_fd_sc_hd__mux4_2 _5974_ (.A0(_1885_),
    .A1(_1888_),
    .A2(_1891_),
    .A3(_1894_),
    .S0(net803),
    .S1(net800),
    .X(_1897_));
 sky130_fd_sc_hd__mux2i_1 _5975_ (.A0(_1882_),
    .A1(_1897_),
    .S(_0044_),
    .Y(_1898_));
 sky130_fd_sc_hd__nor2_1 _5976_ (.A(net707),
    .B(_1898_),
    .Y(_1899_));
 sky130_fd_sc_hd__a21oi_1 _5977_ (.A1(\reg_pc[25] ),
    .A2(net722),
    .B1(_1899_),
    .Y(_1900_));
 sky130_fd_sc_hd__or3_1 _5978_ (.A(net775),
    .B(\cpu_state[5] ),
    .C(\cpu_state[6] ),
    .X(_1901_));
 sky130_fd_sc_hd__nor2_1 _5982_ (.A(net751),
    .B(net708),
    .Y(_1905_));
 sky130_fd_sc_hd__a211oi_1 _5983_ (.A1(_0257_),
    .A2(net708),
    .B1(net696),
    .C1(_1905_),
    .Y(_1906_));
 sky130_fd_sc_hd__inv_1 _5984_ (.A(net324),
    .Y(_0290_));
 sky130_fd_sc_hd__nor2_1 _5986_ (.A(net746),
    .B(net720),
    .Y(_1908_));
 sky130_fd_sc_hd__a211oi_1 _5987_ (.A1(_0290_),
    .A2(net720),
    .B1(net697),
    .C1(_1908_),
    .Y(_1909_));
 sky130_fd_sc_hd__o21ai_0 _5989_ (.A1(_1906_),
    .A2(_1909_),
    .B1(net774),
    .Y(_1911_));
 sky130_fd_sc_hd__o221ai_1 _5990_ (.A1(net724),
    .A2(_1871_),
    .B1(_1900_),
    .B2(net719),
    .C1(_1911_),
    .Y(_4666_));
 sky130_fd_sc_hd__mux4_2 _5995_ (.A0(\cpuregs[0][24] ),
    .A1(\cpuregs[1][24] ),
    .A2(\cpuregs[2][24] ),
    .A3(\cpuregs[3][24] ),
    .S0(net818),
    .S1(net808),
    .X(_1916_));
 sky130_fd_sc_hd__mux4_2 _5996_ (.A0(\cpuregs[4][24] ),
    .A1(\cpuregs[5][24] ),
    .A2(\cpuregs[6][24] ),
    .A3(\cpuregs[7][24] ),
    .S0(net818),
    .S1(net808),
    .X(_1917_));
 sky130_fd_sc_hd__mux4_2 _5999_ (.A0(\cpuregs[16][24] ),
    .A1(\cpuregs[17][24] ),
    .A2(\cpuregs[18][24] ),
    .A3(\cpuregs[19][24] ),
    .S0(net819),
    .S1(net809),
    .X(_1920_));
 sky130_fd_sc_hd__mux4_2 _6002_ (.A0(\cpuregs[20][24] ),
    .A1(\cpuregs[21][24] ),
    .A2(\cpuregs[22][24] ),
    .A3(\cpuregs[23][24] ),
    .S0(net819),
    .S1(net809),
    .X(_1923_));
 sky130_fd_sc_hd__mux4_2 _6005_ (.A0(_1916_),
    .A1(_1917_),
    .A2(_1920_),
    .A3(_1923_),
    .S0(net803),
    .S1(net800),
    .X(_1926_));
 sky130_fd_sc_hd__mux4_2 _6006_ (.A0(\cpuregs[8][24] ),
    .A1(\cpuregs[9][24] ),
    .A2(\cpuregs[10][24] ),
    .A3(\cpuregs[11][24] ),
    .S0(net818),
    .S1(net808),
    .X(_1927_));
 sky130_fd_sc_hd__mux4_2 _6009_ (.A0(\cpuregs[12][24] ),
    .A1(\cpuregs[13][24] ),
    .A2(\cpuregs[14][24] ),
    .A3(\cpuregs[15][24] ),
    .S0(net818),
    .S1(net808),
    .X(_1930_));
 sky130_fd_sc_hd__mux4_2 _6012_ (.A0(\cpuregs[24][24] ),
    .A1(\cpuregs[25][24] ),
    .A2(\cpuregs[26][24] ),
    .A3(\cpuregs[27][24] ),
    .S0(net819),
    .S1(net809),
    .X(_1933_));
 sky130_fd_sc_hd__mux4_2 _6013_ (.A0(\cpuregs[28][24] ),
    .A1(\cpuregs[29][24] ),
    .A2(\cpuregs[30][24] ),
    .A3(\cpuregs[31][24] ),
    .S0(net818),
    .S1(net808),
    .X(_1934_));
 sky130_fd_sc_hd__mux4_2 _6014_ (.A0(_1927_),
    .A1(_1930_),
    .A2(_1933_),
    .A3(_1934_),
    .S0(net803),
    .S1(net800),
    .X(_1935_));
 sky130_fd_sc_hd__mux2i_1 _6015_ (.A0(_1926_),
    .A1(_1935_),
    .S(_0044_),
    .Y(_1936_));
 sky130_fd_sc_hd__nor2_1 _6016_ (.A(net707),
    .B(_1936_),
    .Y(_1937_));
 sky130_fd_sc_hd__a21oi_1 _6017_ (.A1(\reg_pc[24] ),
    .A2(net722),
    .B1(_1937_),
    .Y(_1938_));
 sky130_fd_sc_hd__nand2_1 _6018_ (.A(_0194_),
    .B(_1643_),
    .Y(_1939_));
 sky130_fd_sc_hd__a21oi_1 _6019_ (.A1(_0194_),
    .A2(_1656_),
    .B1(_0193_),
    .Y(_1940_));
 sky130_fd_sc_hd__o21ai_0 _6020_ (.A1(_1638_),
    .A2(_1939_),
    .B1(_1940_),
    .Y(_1941_));
 sky130_fd_sc_hd__a21o_1 _6021_ (.A1(_0160_),
    .A2(_1941_),
    .B1(_0159_),
    .X(_1942_));
 sky130_fd_sc_hd__a21oi_1 _6022_ (.A1(_0139_),
    .A2(_1942_),
    .B1(_0138_),
    .Y(_1943_));
 sky130_fd_sc_hd__xor2_1 _6023_ (.A(_0141_),
    .B(_1943_),
    .X(_1944_));
 sky130_fd_sc_hd__inv_1 _6024_ (.A(net323),
    .Y(_0296_));
 sky130_fd_sc_hd__nor2_1 _6026_ (.A(net747),
    .B(net720),
    .Y(_1946_));
 sky130_fd_sc_hd__a211oi_1 _6027_ (.A1(_0296_),
    .A2(net720),
    .B1(net697),
    .C1(_1946_),
    .Y(_1947_));
 sky130_fd_sc_hd__nor2_1 _6028_ (.A(net752),
    .B(net708),
    .Y(_1948_));
 sky130_fd_sc_hd__a211oi_1 _6029_ (.A1(_0263_),
    .A2(net708),
    .B1(net696),
    .C1(_1948_),
    .Y(_1949_));
 sky130_fd_sc_hd__o21ai_0 _6030_ (.A1(_1947_),
    .A2(_1949_),
    .B1(net774),
    .Y(_1950_));
 sky130_fd_sc_hd__o221ai_1 _6031_ (.A1(net719),
    .A2(_1938_),
    .B1(_1944_),
    .B2(net724),
    .C1(_1950_),
    .Y(_4665_));
 sky130_fd_sc_hd__a21oi_1 _6032_ (.A1(_1643_),
    .A2(_1744_),
    .B1(_1751_),
    .Y(_1951_));
 sky130_fd_sc_hd__nand2_1 _6033_ (.A(_0160_),
    .B(_0194_),
    .Y(_1952_));
 sky130_fd_sc_hd__a21oi_1 _6034_ (.A1(_0160_),
    .A2(_0193_),
    .B1(_0159_),
    .Y(_1953_));
 sky130_fd_sc_hd__o21ai_0 _6035_ (.A1(_1951_),
    .A2(_1952_),
    .B1(_1953_),
    .Y(_1954_));
 sky130_fd_sc_hd__xnor2_1 _6036_ (.A(_0139_),
    .B(_1954_),
    .Y(_1955_));
 sky130_fd_sc_hd__mux4_2 _6037_ (.A0(\cpuregs[0][23] ),
    .A1(\cpuregs[1][23] ),
    .A2(\cpuregs[2][23] ),
    .A3(\cpuregs[3][23] ),
    .S0(net815),
    .S1(net807),
    .X(_1956_));
 sky130_fd_sc_hd__mux4_2 _6038_ (.A0(\cpuregs[4][23] ),
    .A1(\cpuregs[5][23] ),
    .A2(\cpuregs[6][23] ),
    .A3(\cpuregs[7][23] ),
    .S0(net815),
    .S1(net807),
    .X(_1957_));
 sky130_fd_sc_hd__mux4_2 _6039_ (.A0(\cpuregs[16][23] ),
    .A1(\cpuregs[17][23] ),
    .A2(\cpuregs[18][23] ),
    .A3(\cpuregs[19][23] ),
    .S0(net816),
    .S1(net806),
    .X(_1958_));
 sky130_fd_sc_hd__mux4_2 _6040_ (.A0(\cpuregs[20][23] ),
    .A1(\cpuregs[21][23] ),
    .A2(\cpuregs[22][23] ),
    .A3(\cpuregs[23][23] ),
    .S0(net813),
    .S1(net806),
    .X(_1959_));
 sky130_fd_sc_hd__mux4_2 _6041_ (.A0(_1956_),
    .A1(_1957_),
    .A2(_1958_),
    .A3(_1959_),
    .S0(net804),
    .S1(net801),
    .X(_1960_));
 sky130_fd_sc_hd__mux4_2 _6042_ (.A0(\cpuregs[8][23] ),
    .A1(\cpuregs[9][23] ),
    .A2(\cpuregs[10][23] ),
    .A3(\cpuregs[11][23] ),
    .S0(net814),
    .S1(net810),
    .X(_1961_));
 sky130_fd_sc_hd__mux4_2 _6043_ (.A0(\cpuregs[12][23] ),
    .A1(\cpuregs[13][23] ),
    .A2(\cpuregs[14][23] ),
    .A3(\cpuregs[15][23] ),
    .S0(net814),
    .S1(net810),
    .X(_1962_));
 sky130_fd_sc_hd__mux4_2 _6044_ (.A0(\cpuregs[24][23] ),
    .A1(\cpuregs[25][23] ),
    .A2(\cpuregs[26][23] ),
    .A3(\cpuregs[27][23] ),
    .S0(net816),
    .S1(net806),
    .X(_1963_));
 sky130_fd_sc_hd__mux4_2 _6045_ (.A0(\cpuregs[28][23] ),
    .A1(\cpuregs[29][23] ),
    .A2(\cpuregs[30][23] ),
    .A3(\cpuregs[31][23] ),
    .S0(net813),
    .S1(net806),
    .X(_1964_));
 sky130_fd_sc_hd__mux4_2 _6046_ (.A0(_1961_),
    .A1(_1962_),
    .A2(_1963_),
    .A3(_1964_),
    .S0(net804),
    .S1(net801),
    .X(_1965_));
 sky130_fd_sc_hd__mux2i_1 _6047_ (.A0(_1960_),
    .A1(_1965_),
    .S(net802),
    .Y(_1966_));
 sky130_fd_sc_hd__nor2_1 _6048_ (.A(net707),
    .B(_1966_),
    .Y(_1967_));
 sky130_fd_sc_hd__a21oi_1 _6049_ (.A1(\reg_pc[23] ),
    .A2(net722),
    .B1(_1967_),
    .Y(_1968_));
 sky130_fd_sc_hd__nor2_1 _6050_ (.A(net748),
    .B(net720),
    .Y(_1969_));
 sky130_fd_sc_hd__a211oi_1 _6051_ (.A1(_0304_),
    .A2(net720),
    .B1(net697),
    .C1(_1969_),
    .Y(_1970_));
 sky130_fd_sc_hd__inv_1 _6052_ (.A(net327),
    .Y(_0272_));
 sky130_fd_sc_hd__nor2_1 _6053_ (.A(net754),
    .B(net708),
    .Y(_1971_));
 sky130_fd_sc_hd__a211oi_1 _6054_ (.A1(_0272_),
    .A2(net708),
    .B1(net696),
    .C1(_1971_),
    .Y(_1972_));
 sky130_fd_sc_hd__o21ai_0 _6055_ (.A1(_1970_),
    .A2(_1972_),
    .B1(net774),
    .Y(_1973_));
 sky130_fd_sc_hd__o221ai_1 _6056_ (.A1(net724),
    .A2(_1955_),
    .B1(_1968_),
    .B2(net719),
    .C1(_1973_),
    .Y(_4664_));
 sky130_fd_sc_hd__xnor2_1 _6057_ (.A(_0160_),
    .B(_1941_),
    .Y(_1974_));
 sky130_fd_sc_hd__mux4_2 _6058_ (.A0(\cpuregs[0][22] ),
    .A1(\cpuregs[1][22] ),
    .A2(\cpuregs[2][22] ),
    .A3(\cpuregs[3][22] ),
    .S0(net813),
    .S1(net806),
    .X(_1975_));
 sky130_fd_sc_hd__mux4_2 _6059_ (.A0(\cpuregs[4][22] ),
    .A1(\cpuregs[5][22] ),
    .A2(\cpuregs[6][22] ),
    .A3(\cpuregs[7][22] ),
    .S0(net813),
    .S1(net812),
    .X(_1976_));
 sky130_fd_sc_hd__mux4_2 _6060_ (.A0(\cpuregs[16][22] ),
    .A1(\cpuregs[17][22] ),
    .A2(\cpuregs[18][22] ),
    .A3(\cpuregs[19][22] ),
    .S0(net813),
    .S1(net806),
    .X(_1977_));
 sky130_fd_sc_hd__mux4_2 _6061_ (.A0(\cpuregs[20][22] ),
    .A1(\cpuregs[21][22] ),
    .A2(\cpuregs[22][22] ),
    .A3(\cpuregs[23][22] ),
    .S0(net813),
    .S1(net806),
    .X(_1978_));
 sky130_fd_sc_hd__mux4_2 _6062_ (.A0(_1975_),
    .A1(_1976_),
    .A2(_1977_),
    .A3(_1978_),
    .S0(net804),
    .S1(net801),
    .X(_1979_));
 sky130_fd_sc_hd__mux4_2 _6063_ (.A0(\cpuregs[8][22] ),
    .A1(\cpuregs[9][22] ),
    .A2(\cpuregs[10][22] ),
    .A3(\cpuregs[11][22] ),
    .S0(net820),
    .S1(net806),
    .X(_1980_));
 sky130_fd_sc_hd__mux4_2 _6064_ (.A0(\cpuregs[12][22] ),
    .A1(\cpuregs[13][22] ),
    .A2(\cpuregs[14][22] ),
    .A3(\cpuregs[15][22] ),
    .S0(net816),
    .S1(net807),
    .X(_1981_));
 sky130_fd_sc_hd__mux4_2 _6065_ (.A0(\cpuregs[24][22] ),
    .A1(\cpuregs[25][22] ),
    .A2(\cpuregs[26][22] ),
    .A3(\cpuregs[27][22] ),
    .S0(net820),
    .S1(net806),
    .X(_1982_));
 sky130_fd_sc_hd__mux4_2 _6066_ (.A0(\cpuregs[28][22] ),
    .A1(\cpuregs[29][22] ),
    .A2(\cpuregs[30][22] ),
    .A3(\cpuregs[31][22] ),
    .S0(net813),
    .S1(net806),
    .X(_1983_));
 sky130_fd_sc_hd__mux4_2 _6067_ (.A0(_1980_),
    .A1(_1981_),
    .A2(_1982_),
    .A3(_1983_),
    .S0(net804),
    .S1(net801),
    .X(_1984_));
 sky130_fd_sc_hd__mux2i_1 _6068_ (.A0(_1979_),
    .A1(_1984_),
    .S(net802),
    .Y(_1985_));
 sky130_fd_sc_hd__nor2_1 _6069_ (.A(net707),
    .B(_1985_),
    .Y(_1986_));
 sky130_fd_sc_hd__a21oi_1 _6070_ (.A1(\reg_pc[22] ),
    .A2(net722),
    .B1(_1986_),
    .Y(_1987_));
 sky130_fd_sc_hd__nor2_1 _6072_ (.A(net749),
    .B(net720),
    .Y(_1989_));
 sky130_fd_sc_hd__nor3_1 _6073_ (.A(net697),
    .B(_1905_),
    .C(_1989_),
    .Y(_1990_));
 sky130_fd_sc_hd__nor2_1 _6075_ (.A(net755),
    .B(net708),
    .Y(_1992_));
 sky130_fd_sc_hd__nor3_1 _6076_ (.A(net696),
    .B(_1908_),
    .C(_1992_),
    .Y(_1993_));
 sky130_fd_sc_hd__o21ai_0 _6077_ (.A1(_1990_),
    .A2(_1993_),
    .B1(net774),
    .Y(_1994_));
 sky130_fd_sc_hd__o221ai_1 _6078_ (.A1(net724),
    .A2(_1974_),
    .B1(_1987_),
    .B2(net719),
    .C1(_1994_),
    .Y(_4663_));
 sky130_fd_sc_hd__xor2_1 _6079_ (.A(_0194_),
    .B(_1951_),
    .X(_1995_));
 sky130_fd_sc_hd__mux4_2 _6080_ (.A0(\cpuregs[0][21] ),
    .A1(\cpuregs[1][21] ),
    .A2(\cpuregs[2][21] ),
    .A3(\cpuregs[3][21] ),
    .S0(net819),
    .S1(net810),
    .X(_1996_));
 sky130_fd_sc_hd__mux4_2 _6081_ (.A0(\cpuregs[4][21] ),
    .A1(\cpuregs[5][21] ),
    .A2(\cpuregs[6][21] ),
    .A3(\cpuregs[7][21] ),
    .S0(net814),
    .S1(net810),
    .X(_1997_));
 sky130_fd_sc_hd__mux4_2 _6082_ (.A0(\cpuregs[16][21] ),
    .A1(\cpuregs[17][21] ),
    .A2(\cpuregs[18][21] ),
    .A3(\cpuregs[19][21] ),
    .S0(net814),
    .S1(net810),
    .X(_1998_));
 sky130_fd_sc_hd__mux4_2 _6083_ (.A0(\cpuregs[20][21] ),
    .A1(\cpuregs[21][21] ),
    .A2(\cpuregs[22][21] ),
    .A3(\cpuregs[23][21] ),
    .S0(net814),
    .S1(net810),
    .X(_1999_));
 sky130_fd_sc_hd__mux4_2 _6084_ (.A0(_1996_),
    .A1(_1997_),
    .A2(_1998_),
    .A3(_1999_),
    .S0(net805),
    .S1(net800),
    .X(_2000_));
 sky130_fd_sc_hd__mux4_2 _6085_ (.A0(\cpuregs[8][21] ),
    .A1(\cpuregs[9][21] ),
    .A2(\cpuregs[10][21] ),
    .A3(\cpuregs[11][21] ),
    .S0(net819),
    .S1(net810),
    .X(_2001_));
 sky130_fd_sc_hd__mux4_2 _6086_ (.A0(\cpuregs[12][21] ),
    .A1(\cpuregs[13][21] ),
    .A2(\cpuregs[14][21] ),
    .A3(\cpuregs[15][21] ),
    .S0(net819),
    .S1(net810),
    .X(_2002_));
 sky130_fd_sc_hd__mux4_2 _6087_ (.A0(\cpuregs[24][21] ),
    .A1(\cpuregs[25][21] ),
    .A2(\cpuregs[26][21] ),
    .A3(\cpuregs[27][21] ),
    .S0(net814),
    .S1(net810),
    .X(_2003_));
 sky130_fd_sc_hd__mux4_2 _6088_ (.A0(\cpuregs[28][21] ),
    .A1(\cpuregs[29][21] ),
    .A2(\cpuregs[30][21] ),
    .A3(\cpuregs[31][21] ),
    .S0(net814),
    .S1(net810),
    .X(_2004_));
 sky130_fd_sc_hd__mux4_2 _6089_ (.A0(_2001_),
    .A1(_2002_),
    .A2(_2003_),
    .A3(_2004_),
    .S0(net805),
    .S1(net800),
    .X(_2005_));
 sky130_fd_sc_hd__mux2i_1 _6090_ (.A0(_2000_),
    .A1(_2005_),
    .S(_0044_),
    .Y(_2006_));
 sky130_fd_sc_hd__nor2_1 _6091_ (.A(net707),
    .B(_2006_),
    .Y(_2007_));
 sky130_fd_sc_hd__a21oi_1 _6092_ (.A1(\reg_pc[21] ),
    .A2(net722),
    .B1(_2007_),
    .Y(_2008_));
 sky130_fd_sc_hd__nor2_1 _6093_ (.A(net750),
    .B(net720),
    .Y(_2009_));
 sky130_fd_sc_hd__nor3_1 _6094_ (.A(net697),
    .B(_1948_),
    .C(_2009_),
    .Y(_2010_));
 sky130_fd_sc_hd__nor2_1 _6095_ (.A(net756),
    .B(net708),
    .Y(_2011_));
 sky130_fd_sc_hd__nor3_1 _6096_ (.A(net696),
    .B(_1946_),
    .C(_2011_),
    .Y(_2012_));
 sky130_fd_sc_hd__o21ai_0 _6097_ (.A1(_2010_),
    .A2(_2012_),
    .B1(net774),
    .Y(_2013_));
 sky130_fd_sc_hd__o221ai_1 _6098_ (.A1(net724),
    .A2(_1995_),
    .B1(_2008_),
    .B2(net719),
    .C1(_2013_),
    .Y(_4662_));
 sky130_fd_sc_hd__o221ai_1 _6099_ (.A1(_1649_),
    .A2(_1650_),
    .B1(_1638_),
    .B2(_1642_),
    .C1(_1651_),
    .Y(_2014_));
 sky130_fd_sc_hd__a21o_1 _6100_ (.A1(_0200_),
    .A2(_2014_),
    .B1(_0199_),
    .X(_2015_));
 sky130_fd_sc_hd__a21oi_1 _6101_ (.A1(_0162_),
    .A2(_2015_),
    .B1(_0161_),
    .Y(_2016_));
 sky130_fd_sc_hd__nor3b_1 _6102_ (.A(_0165_),
    .B(net724),
    .C_N(_0196_),
    .Y(_2017_));
 sky130_fd_sc_hd__nor2_1 _6103_ (.A(_0166_),
    .B(_0165_),
    .Y(_2018_));
 sky130_fd_sc_hd__mux2i_1 _6104_ (.A0(_0165_),
    .A1(_2018_),
    .S(_0196_),
    .Y(_2019_));
 sky130_fd_sc_hd__nor2_1 _6105_ (.A(net751),
    .B(net720),
    .Y(_2020_));
 sky130_fd_sc_hd__nor3_1 _6106_ (.A(net697),
    .B(_1971_),
    .C(_2020_),
    .Y(_2021_));
 sky130_fd_sc_hd__nor2_1 _6107_ (.A(net757),
    .B(net708),
    .Y(_2022_));
 sky130_fd_sc_hd__nor3_1 _6108_ (.A(net696),
    .B(_1969_),
    .C(_2022_),
    .Y(_2023_));
 sky130_fd_sc_hd__o21ai_0 _6109_ (.A1(_2021_),
    .A2(_2023_),
    .B1(net774),
    .Y(_2024_));
 sky130_fd_sc_hd__mux4_2 _6110_ (.A0(\cpuregs[0][20] ),
    .A1(\cpuregs[1][20] ),
    .A2(\cpuregs[2][20] ),
    .A3(\cpuregs[3][20] ),
    .S0(net819),
    .S1(net809),
    .X(_2025_));
 sky130_fd_sc_hd__mux4_2 _6111_ (.A0(\cpuregs[4][20] ),
    .A1(\cpuregs[5][20] ),
    .A2(\cpuregs[6][20] ),
    .A3(\cpuregs[7][20] ),
    .S0(net819),
    .S1(net810),
    .X(_2026_));
 sky130_fd_sc_hd__mux4_2 _6112_ (.A0(\cpuregs[16][20] ),
    .A1(\cpuregs[17][20] ),
    .A2(\cpuregs[18][20] ),
    .A3(\cpuregs[19][20] ),
    .S0(net819),
    .S1(net809),
    .X(_2027_));
 sky130_fd_sc_hd__mux4_2 _6113_ (.A0(\cpuregs[20][20] ),
    .A1(\cpuregs[21][20] ),
    .A2(\cpuregs[22][20] ),
    .A3(\cpuregs[23][20] ),
    .S0(net819),
    .S1(net809),
    .X(_2028_));
 sky130_fd_sc_hd__mux4_2 _6114_ (.A0(_2025_),
    .A1(_2026_),
    .A2(_2027_),
    .A3(_2028_),
    .S0(net805),
    .S1(net800),
    .X(_2029_));
 sky130_fd_sc_hd__mux4_2 _6115_ (.A0(\cpuregs[8][20] ),
    .A1(\cpuregs[9][20] ),
    .A2(\cpuregs[10][20] ),
    .A3(\cpuregs[11][20] ),
    .S0(net814),
    .S1(net810),
    .X(_2030_));
 sky130_fd_sc_hd__mux4_2 _6116_ (.A0(\cpuregs[12][20] ),
    .A1(\cpuregs[13][20] ),
    .A2(\cpuregs[14][20] ),
    .A3(\cpuregs[15][20] ),
    .S0(net814),
    .S1(net810),
    .X(_2031_));
 sky130_fd_sc_hd__mux4_2 _6117_ (.A0(\cpuregs[24][20] ),
    .A1(\cpuregs[25][20] ),
    .A2(\cpuregs[26][20] ),
    .A3(\cpuregs[27][20] ),
    .S0(net814),
    .S1(net810),
    .X(_2032_));
 sky130_fd_sc_hd__mux4_2 _6118_ (.A0(\cpuregs[28][20] ),
    .A1(\cpuregs[29][20] ),
    .A2(\cpuregs[30][20] ),
    .A3(\cpuregs[31][20] ),
    .S0(net814),
    .S1(net810),
    .X(_2033_));
 sky130_fd_sc_hd__mux4_2 _6119_ (.A0(_2030_),
    .A1(_2031_),
    .A2(_2032_),
    .A3(_2033_),
    .S0(net805),
    .S1(net800),
    .X(_2034_));
 sky130_fd_sc_hd__mux2i_1 _6120_ (.A0(_2029_),
    .A1(_2034_),
    .S(_0044_),
    .Y(_2035_));
 sky130_fd_sc_hd__nand2_1 _6121_ (.A(\reg_pc[20] ),
    .B(net722),
    .Y(_2036_));
 sky130_fd_sc_hd__o21ai_0 _6122_ (.A1(net707),
    .A2(_2035_),
    .B1(_2036_),
    .Y(_2037_));
 sky130_fd_sc_hd__nand2_1 _6123_ (.A(_1725_),
    .B(_2037_),
    .Y(_2038_));
 sky130_fd_sc_hd__o211ai_1 _6124_ (.A1(net724),
    .A2(_2019_),
    .B1(_2024_),
    .C1(_2038_),
    .Y(_2039_));
 sky130_fd_sc_hd__nor4b_1 _6125_ (.A(_0196_),
    .B(net724),
    .C(_2016_),
    .D_N(_0166_),
    .Y(_2040_));
 sky130_fd_sc_hd__a211o_1 _6126_ (.A1(_2016_),
    .A2(_2017_),
    .B1(_2039_),
    .C1(_2040_),
    .X(_4661_));
 sky130_fd_sc_hd__mux4_2 _6127_ (.A0(\cpuregs[0][19] ),
    .A1(\cpuregs[1][19] ),
    .A2(\cpuregs[2][19] ),
    .A3(\cpuregs[3][19] ),
    .S0(net820),
    .S1(net806),
    .X(_2041_));
 sky130_fd_sc_hd__mux4_2 _6128_ (.A0(\cpuregs[4][19] ),
    .A1(\cpuregs[5][19] ),
    .A2(\cpuregs[6][19] ),
    .A3(\cpuregs[7][19] ),
    .S0(net820),
    .S1(net806),
    .X(_2042_));
 sky130_fd_sc_hd__mux4_2 _6129_ (.A0(\cpuregs[16][19] ),
    .A1(\cpuregs[17][19] ),
    .A2(\cpuregs[18][19] ),
    .A3(\cpuregs[19][19] ),
    .S0(net820),
    .S1(net806),
    .X(_2043_));
 sky130_fd_sc_hd__mux4_2 _6130_ (.A0(\cpuregs[20][19] ),
    .A1(\cpuregs[21][19] ),
    .A2(\cpuregs[22][19] ),
    .A3(\cpuregs[23][19] ),
    .S0(net813),
    .S1(net806),
    .X(_2044_));
 sky130_fd_sc_hd__mux4_2 _6131_ (.A0(_2041_),
    .A1(_2042_),
    .A2(_2043_),
    .A3(_2044_),
    .S0(net804),
    .S1(net801),
    .X(_2045_));
 sky130_fd_sc_hd__mux4_2 _6132_ (.A0(\cpuregs[8][19] ),
    .A1(\cpuregs[9][19] ),
    .A2(\cpuregs[10][19] ),
    .A3(\cpuregs[11][19] ),
    .S0(net816),
    .S1(net807),
    .X(_2046_));
 sky130_fd_sc_hd__mux4_2 _6133_ (.A0(\cpuregs[12][19] ),
    .A1(\cpuregs[13][19] ),
    .A2(\cpuregs[14][19] ),
    .A3(\cpuregs[15][19] ),
    .S0(net820),
    .S1(net806),
    .X(_2047_));
 sky130_fd_sc_hd__mux4_2 _6134_ (.A0(\cpuregs[24][19] ),
    .A1(\cpuregs[25][19] ),
    .A2(\cpuregs[26][19] ),
    .A3(\cpuregs[27][19] ),
    .S0(net820),
    .S1(net806),
    .X(_2048_));
 sky130_fd_sc_hd__mux4_2 _6135_ (.A0(\cpuregs[28][19] ),
    .A1(\cpuregs[29][19] ),
    .A2(\cpuregs[30][19] ),
    .A3(\cpuregs[31][19] ),
    .S0(net813),
    .S1(net806),
    .X(_2049_));
 sky130_fd_sc_hd__mux4_2 _6136_ (.A0(_2046_),
    .A1(_2047_),
    .A2(_2048_),
    .A3(_2049_),
    .S0(net804),
    .S1(net801),
    .X(_2050_));
 sky130_fd_sc_hd__mux2i_1 _6137_ (.A0(_2045_),
    .A1(_2050_),
    .S(net802),
    .Y(_2051_));
 sky130_fd_sc_hd__nor2_1 _6138_ (.A(net707),
    .B(_2051_),
    .Y(_2052_));
 sky130_fd_sc_hd__a21oi_1 _6139_ (.A1(\reg_pc[19] ),
    .A2(net722),
    .B1(_2052_),
    .Y(_2053_));
 sky130_fd_sc_hd__nor2_1 _6140_ (.A(_0167_),
    .B(_0169_),
    .Y(_2054_));
 sky130_fd_sc_hd__o21ai_0 _6141_ (.A1(_0168_),
    .A2(_0167_),
    .B1(_0164_),
    .Y(_2055_));
 sky130_fd_sc_hd__a31oi_1 _6142_ (.A1(_1735_),
    .A2(_1743_),
    .A3(_2054_),
    .B1(_2055_),
    .Y(_2056_));
 sky130_fd_sc_hd__o211ai_1 _6143_ (.A1(_0163_),
    .A2(_2056_),
    .B1(_0200_),
    .C1(_0198_),
    .Y(_2057_));
 sky130_fd_sc_hd__a21oi_1 _6144_ (.A1(_0200_),
    .A2(_0197_),
    .B1(_0199_),
    .Y(_2058_));
 sky130_fd_sc_hd__nand2_1 _6145_ (.A(_2057_),
    .B(_2058_),
    .Y(_2059_));
 sky130_fd_sc_hd__a21oi_1 _6146_ (.A1(_0162_),
    .A2(_2059_),
    .B1(_0161_),
    .Y(_2060_));
 sky130_fd_sc_hd__xor2_1 _6147_ (.A(_0166_),
    .B(_2060_),
    .X(_2061_));
 sky130_fd_sc_hd__nor2_1 _6148_ (.A(net752),
    .B(net720),
    .Y(_2062_));
 sky130_fd_sc_hd__nor3_1 _6149_ (.A(net697),
    .B(_1992_),
    .C(_2062_),
    .Y(_2063_));
 sky130_fd_sc_hd__nor2_1 _6150_ (.A(net758),
    .B(net708),
    .Y(_2064_));
 sky130_fd_sc_hd__nor3_1 _6151_ (.A(net696),
    .B(_1989_),
    .C(_2064_),
    .Y(_2065_));
 sky130_fd_sc_hd__o21ai_0 _6152_ (.A1(_2063_),
    .A2(_2065_),
    .B1(net774),
    .Y(_2066_));
 sky130_fd_sc_hd__o221ai_1 _6153_ (.A1(net719),
    .A2(_2053_),
    .B1(_2061_),
    .B2(net724),
    .C1(_2066_),
    .Y(_4659_));
 sky130_fd_sc_hd__xnor2_1 _6154_ (.A(_0162_),
    .B(_2015_),
    .Y(_2067_));
 sky130_fd_sc_hd__nor2_1 _6155_ (.A(net754),
    .B(net720),
    .Y(_2068_));
 sky130_fd_sc_hd__nor3_1 _6156_ (.A(net697),
    .B(_2011_),
    .C(_2068_),
    .Y(_2069_));
 sky130_fd_sc_hd__nor2_1 _6157_ (.A(net759),
    .B(net708),
    .Y(_2070_));
 sky130_fd_sc_hd__nor3_1 _6158_ (.A(net696),
    .B(_2009_),
    .C(_2070_),
    .Y(_2071_));
 sky130_fd_sc_hd__o21ai_0 _6160_ (.A1(_2069_),
    .A2(_2071_),
    .B1(net774),
    .Y(_2073_));
 sky130_fd_sc_hd__mux4_2 _6161_ (.A0(\cpuregs[0][18] ),
    .A1(\cpuregs[1][18] ),
    .A2(\cpuregs[2][18] ),
    .A3(\cpuregs[3][18] ),
    .S0(net817),
    .S1(net811),
    .X(_2074_));
 sky130_fd_sc_hd__mux4_2 _6162_ (.A0(\cpuregs[4][18] ),
    .A1(\cpuregs[5][18] ),
    .A2(\cpuregs[6][18] ),
    .A3(\cpuregs[7][18] ),
    .S0(net817),
    .S1(net811),
    .X(_2075_));
 sky130_fd_sc_hd__mux4_2 _6163_ (.A0(\cpuregs[16][18] ),
    .A1(\cpuregs[17][18] ),
    .A2(\cpuregs[18][18] ),
    .A3(\cpuregs[19][18] ),
    .S0(net818),
    .S1(net808),
    .X(_2076_));
 sky130_fd_sc_hd__mux4_2 _6164_ (.A0(\cpuregs[20][18] ),
    .A1(\cpuregs[21][18] ),
    .A2(\cpuregs[22][18] ),
    .A3(\cpuregs[23][18] ),
    .S0(net818),
    .S1(net808),
    .X(_2077_));
 sky130_fd_sc_hd__mux4_2 _6165_ (.A0(_2074_),
    .A1(_2075_),
    .A2(_2076_),
    .A3(_2077_),
    .S0(net803),
    .S1(net800),
    .X(_2078_));
 sky130_fd_sc_hd__mux4_2 _6166_ (.A0(\cpuregs[8][18] ),
    .A1(\cpuregs[9][18] ),
    .A2(\cpuregs[10][18] ),
    .A3(\cpuregs[11][18] ),
    .S0(net817),
    .S1(net811),
    .X(_2079_));
 sky130_fd_sc_hd__mux4_2 _6167_ (.A0(\cpuregs[12][18] ),
    .A1(\cpuregs[13][18] ),
    .A2(\cpuregs[14][18] ),
    .A3(\cpuregs[15][18] ),
    .S0(net817),
    .S1(net811),
    .X(_2080_));
 sky130_fd_sc_hd__mux4_2 _6168_ (.A0(\cpuregs[24][18] ),
    .A1(\cpuregs[25][18] ),
    .A2(\cpuregs[26][18] ),
    .A3(\cpuregs[27][18] ),
    .S0(net819),
    .S1(net809),
    .X(_2081_));
 sky130_fd_sc_hd__mux4_2 _6169_ (.A0(\cpuregs[28][18] ),
    .A1(\cpuregs[29][18] ),
    .A2(\cpuregs[30][18] ),
    .A3(\cpuregs[31][18] ),
    .S0(net818),
    .S1(net808),
    .X(_2082_));
 sky130_fd_sc_hd__mux4_2 _6170_ (.A0(_2079_),
    .A1(_2080_),
    .A2(_2081_),
    .A3(_2082_),
    .S0(net803),
    .S1(net800),
    .X(_2083_));
 sky130_fd_sc_hd__mux2i_1 _6171_ (.A0(_2078_),
    .A1(_2083_),
    .S(_0044_),
    .Y(_2084_));
 sky130_fd_sc_hd__nand2_1 _6172_ (.A(\reg_pc[18] ),
    .B(net722),
    .Y(_2085_));
 sky130_fd_sc_hd__o21ai_0 _6173_ (.A1(net707),
    .A2(_2084_),
    .B1(_2085_),
    .Y(_2086_));
 sky130_fd_sc_hd__nand2_1 _6174_ (.A(_1725_),
    .B(_2086_),
    .Y(_2087_));
 sky130_fd_sc_hd__o211ai_1 _6175_ (.A1(net724),
    .A2(_2067_),
    .B1(_2073_),
    .C1(_2087_),
    .Y(_4658_));
 sky130_fd_sc_hd__o21ai_0 _6176_ (.A1(_0163_),
    .A2(_2056_),
    .B1(_0198_),
    .Y(_2088_));
 sky130_fd_sc_hd__nand2_1 _6177_ (.A(_1651_),
    .B(_2088_),
    .Y(_2089_));
 sky130_fd_sc_hd__xnor2_1 _6178_ (.A(_0200_),
    .B(_2089_),
    .Y(_2090_));
 sky130_fd_sc_hd__mux4_2 _6179_ (.A0(\cpuregs[0][17] ),
    .A1(\cpuregs[1][17] ),
    .A2(\cpuregs[2][17] ),
    .A3(\cpuregs[3][17] ),
    .S0(net816),
    .S1(net807),
    .X(_2091_));
 sky130_fd_sc_hd__mux4_2 _6180_ (.A0(\cpuregs[4][17] ),
    .A1(\cpuregs[5][17] ),
    .A2(\cpuregs[6][17] ),
    .A3(\cpuregs[7][17] ),
    .S0(net816),
    .S1(net806),
    .X(_2092_));
 sky130_fd_sc_hd__mux4_2 _6181_ (.A0(\cpuregs[16][17] ),
    .A1(\cpuregs[17][17] ),
    .A2(\cpuregs[18][17] ),
    .A3(\cpuregs[19][17] ),
    .S0(net816),
    .S1(net806),
    .X(_2093_));
 sky130_fd_sc_hd__mux4_2 _6182_ (.A0(\cpuregs[20][17] ),
    .A1(\cpuregs[21][17] ),
    .A2(\cpuregs[22][17] ),
    .A3(\cpuregs[23][17] ),
    .S0(net813),
    .S1(net806),
    .X(_2094_));
 sky130_fd_sc_hd__mux4_2 _6183_ (.A0(_2091_),
    .A1(_2092_),
    .A2(_2093_),
    .A3(_2094_),
    .S0(net804),
    .S1(net801),
    .X(_2095_));
 sky130_fd_sc_hd__mux4_2 _6184_ (.A0(\cpuregs[8][17] ),
    .A1(\cpuregs[9][17] ),
    .A2(\cpuregs[10][17] ),
    .A3(\cpuregs[11][17] ),
    .S0(net816),
    .S1(net807),
    .X(_2096_));
 sky130_fd_sc_hd__mux4_2 _6185_ (.A0(\cpuregs[12][17] ),
    .A1(\cpuregs[13][17] ),
    .A2(\cpuregs[14][17] ),
    .A3(\cpuregs[15][17] ),
    .S0(net816),
    .S1(net807),
    .X(_2097_));
 sky130_fd_sc_hd__mux4_2 _6186_ (.A0(\cpuregs[24][17] ),
    .A1(\cpuregs[25][17] ),
    .A2(\cpuregs[26][17] ),
    .A3(\cpuregs[27][17] ),
    .S0(net816),
    .S1(net806),
    .X(_2098_));
 sky130_fd_sc_hd__mux4_2 _6187_ (.A0(\cpuregs[28][17] ),
    .A1(\cpuregs[29][17] ),
    .A2(\cpuregs[30][17] ),
    .A3(\cpuregs[31][17] ),
    .S0(net813),
    .S1(net806),
    .X(_2099_));
 sky130_fd_sc_hd__mux4_2 _6188_ (.A0(_2096_),
    .A1(_2097_),
    .A2(_2098_),
    .A3(_2099_),
    .S0(net804),
    .S1(net801),
    .X(_2100_));
 sky130_fd_sc_hd__mux2i_1 _6189_ (.A0(_2095_),
    .A1(_2100_),
    .S(net802),
    .Y(_2101_));
 sky130_fd_sc_hd__nor2_1 _6190_ (.A(net707),
    .B(_2101_),
    .Y(_2102_));
 sky130_fd_sc_hd__a21oi_1 _6191_ (.A1(\reg_pc[17] ),
    .A2(net722),
    .B1(_2102_),
    .Y(_2103_));
 sky130_fd_sc_hd__nor2_1 _6192_ (.A(net755),
    .B(net720),
    .Y(_2104_));
 sky130_fd_sc_hd__nor3_1 _6193_ (.A(net697),
    .B(_2022_),
    .C(_2104_),
    .Y(_2105_));
 sky130_fd_sc_hd__nor2_1 _6194_ (.A(net760),
    .B(net708),
    .Y(_2106_));
 sky130_fd_sc_hd__nor3_1 _6195_ (.A(net696),
    .B(_2020_),
    .C(_2106_),
    .Y(_2107_));
 sky130_fd_sc_hd__o21ai_0 _6196_ (.A1(_2105_),
    .A2(_2107_),
    .B1(net774),
    .Y(_2108_));
 sky130_fd_sc_hd__o221ai_1 _6197_ (.A1(net724),
    .A2(_2090_),
    .B1(_2103_),
    .B2(net719),
    .C1(_2108_),
    .Y(_4657_));
 sky130_fd_sc_hd__inv_1 _6198_ (.A(_0168_),
    .Y(_2109_));
 sky130_fd_sc_hd__o21bai_1 _6199_ (.A1(_2109_),
    .A2(_1638_),
    .B1_N(_0167_),
    .Y(_2110_));
 sky130_fd_sc_hd__a21oi_1 _6200_ (.A1(_0164_),
    .A2(_2110_),
    .B1(_0163_),
    .Y(_2111_));
 sky130_fd_sc_hd__xnor2_1 _6201_ (.A(_1649_),
    .B(_2111_),
    .Y(_2112_));
 sky130_fd_sc_hd__nor2_1 _6202_ (.A(net756),
    .B(net720),
    .Y(_2113_));
 sky130_fd_sc_hd__nor3_1 _6203_ (.A(net697),
    .B(_2064_),
    .C(_2113_),
    .Y(_2114_));
 sky130_fd_sc_hd__nor2_1 _6204_ (.A(net761),
    .B(net708),
    .Y(_2115_));
 sky130_fd_sc_hd__nor3_1 _6205_ (.A(net696),
    .B(_2062_),
    .C(_2115_),
    .Y(_2116_));
 sky130_fd_sc_hd__o21ai_0 _6206_ (.A1(_2114_),
    .A2(_2116_),
    .B1(net774),
    .Y(_2117_));
 sky130_fd_sc_hd__mux4_2 _6207_ (.A0(\cpuregs[0][16] ),
    .A1(\cpuregs[1][16] ),
    .A2(\cpuregs[2][16] ),
    .A3(\cpuregs[3][16] ),
    .S0(net818),
    .S1(net808),
    .X(_2118_));
 sky130_fd_sc_hd__mux4_2 _6208_ (.A0(\cpuregs[4][16] ),
    .A1(\cpuregs[5][16] ),
    .A2(\cpuregs[6][16] ),
    .A3(\cpuregs[7][16] ),
    .S0(net818),
    .S1(net808),
    .X(_2119_));
 sky130_fd_sc_hd__mux4_2 _6209_ (.A0(\cpuregs[16][16] ),
    .A1(\cpuregs[17][16] ),
    .A2(\cpuregs[18][16] ),
    .A3(\cpuregs[19][16] ),
    .S0(net819),
    .S1(net809),
    .X(_2120_));
 sky130_fd_sc_hd__mux4_2 _6210_ (.A0(\cpuregs[20][16] ),
    .A1(\cpuregs[21][16] ),
    .A2(\cpuregs[22][16] ),
    .A3(\cpuregs[23][16] ),
    .S0(net819),
    .S1(net809),
    .X(_2121_));
 sky130_fd_sc_hd__mux4_2 _6211_ (.A0(_2118_),
    .A1(_2119_),
    .A2(_2120_),
    .A3(_2121_),
    .S0(net803),
    .S1(net800),
    .X(_2122_));
 sky130_fd_sc_hd__mux4_2 _6212_ (.A0(\cpuregs[8][16] ),
    .A1(\cpuregs[9][16] ),
    .A2(\cpuregs[10][16] ),
    .A3(\cpuregs[11][16] ),
    .S0(net818),
    .S1(net808),
    .X(_2123_));
 sky130_fd_sc_hd__mux4_2 _6213_ (.A0(\cpuregs[12][16] ),
    .A1(\cpuregs[13][16] ),
    .A2(\cpuregs[14][16] ),
    .A3(\cpuregs[15][16] ),
    .S0(net818),
    .S1(net808),
    .X(_2124_));
 sky130_fd_sc_hd__mux4_2 _6214_ (.A0(\cpuregs[24][16] ),
    .A1(\cpuregs[25][16] ),
    .A2(\cpuregs[26][16] ),
    .A3(\cpuregs[27][16] ),
    .S0(net819),
    .S1(net809),
    .X(_2125_));
 sky130_fd_sc_hd__mux4_2 _6215_ (.A0(\cpuregs[28][16] ),
    .A1(\cpuregs[29][16] ),
    .A2(\cpuregs[30][16] ),
    .A3(\cpuregs[31][16] ),
    .S0(net818),
    .S1(net808),
    .X(_2126_));
 sky130_fd_sc_hd__mux4_2 _6216_ (.A0(_2123_),
    .A1(_2124_),
    .A2(_2125_),
    .A3(_2126_),
    .S0(net803),
    .S1(net800),
    .X(_2127_));
 sky130_fd_sc_hd__mux2i_1 _6217_ (.A0(_2122_),
    .A1(_2127_),
    .S(_0044_),
    .Y(_2128_));
 sky130_fd_sc_hd__nand2_1 _6218_ (.A(\reg_pc[16] ),
    .B(net722),
    .Y(_2129_));
 sky130_fd_sc_hd__o21ai_0 _6219_ (.A1(net707),
    .A2(_2128_),
    .B1(_2129_),
    .Y(_2130_));
 sky130_fd_sc_hd__nand2_1 _6220_ (.A(_1725_),
    .B(_2130_),
    .Y(_2131_));
 sky130_fd_sc_hd__o211ai_1 _6221_ (.A1(net724),
    .A2(_2112_),
    .B1(_2117_),
    .C1(_2131_),
    .Y(_4656_));
 sky130_fd_sc_hd__mux4_2 _6222_ (.A0(\cpuregs[0][15] ),
    .A1(\cpuregs[1][15] ),
    .A2(\cpuregs[2][15] ),
    .A3(\cpuregs[3][15] ),
    .S0(net819),
    .S1(net810),
    .X(_2132_));
 sky130_fd_sc_hd__mux4_2 _6223_ (.A0(\cpuregs[4][15] ),
    .A1(\cpuregs[5][15] ),
    .A2(\cpuregs[6][15] ),
    .A3(\cpuregs[7][15] ),
    .S0(net819),
    .S1(net810),
    .X(_2133_));
 sky130_fd_sc_hd__mux4_2 _6224_ (.A0(\cpuregs[16][15] ),
    .A1(\cpuregs[17][15] ),
    .A2(\cpuregs[18][15] ),
    .A3(\cpuregs[19][15] ),
    .S0(net819),
    .S1(net810),
    .X(_2134_));
 sky130_fd_sc_hd__mux4_2 _6225_ (.A0(\cpuregs[20][15] ),
    .A1(\cpuregs[21][15] ),
    .A2(\cpuregs[22][15] ),
    .A3(\cpuregs[23][15] ),
    .S0(net819),
    .S1(net810),
    .X(_2135_));
 sky130_fd_sc_hd__mux4_2 _6226_ (.A0(_2132_),
    .A1(_2133_),
    .A2(_2134_),
    .A3(_2135_),
    .S0(net805),
    .S1(net800),
    .X(_2136_));
 sky130_fd_sc_hd__mux4_2 _6227_ (.A0(\cpuregs[8][15] ),
    .A1(\cpuregs[9][15] ),
    .A2(\cpuregs[10][15] ),
    .A3(\cpuregs[11][15] ),
    .S0(net819),
    .S1(net810),
    .X(_2137_));
 sky130_fd_sc_hd__mux4_2 _6228_ (.A0(\cpuregs[12][15] ),
    .A1(\cpuregs[13][15] ),
    .A2(\cpuregs[14][15] ),
    .A3(\cpuregs[15][15] ),
    .S0(net819),
    .S1(net810),
    .X(_2138_));
 sky130_fd_sc_hd__mux4_2 _6229_ (.A0(\cpuregs[24][15] ),
    .A1(\cpuregs[25][15] ),
    .A2(\cpuregs[26][15] ),
    .A3(\cpuregs[27][15] ),
    .S0(net819),
    .S1(net810),
    .X(_2139_));
 sky130_fd_sc_hd__mux4_2 _6230_ (.A0(\cpuregs[28][15] ),
    .A1(\cpuregs[29][15] ),
    .A2(\cpuregs[30][15] ),
    .A3(\cpuregs[31][15] ),
    .S0(net819),
    .S1(net810),
    .X(_2140_));
 sky130_fd_sc_hd__mux4_2 _6231_ (.A0(_2137_),
    .A1(_2138_),
    .A2(_2139_),
    .A3(_2140_),
    .S0(net805),
    .S1(net800),
    .X(_2141_));
 sky130_fd_sc_hd__mux2i_1 _6232_ (.A0(_2136_),
    .A1(_2141_),
    .S(_0044_),
    .Y(_2142_));
 sky130_fd_sc_hd__nor2_1 _6233_ (.A(net707),
    .B(_2142_),
    .Y(_2143_));
 sky130_fd_sc_hd__a21oi_1 _6234_ (.A1(\reg_pc[15] ),
    .A2(net722),
    .B1(_2143_),
    .Y(_2144_));
 sky130_fd_sc_hd__nor2_1 _6235_ (.A(net757),
    .B(net720),
    .Y(_2145_));
 sky130_fd_sc_hd__nor3_1 _6236_ (.A(net697),
    .B(_2070_),
    .C(_2145_),
    .Y(_2146_));
 sky130_fd_sc_hd__nor2_1 _6237_ (.A(net762),
    .B(net708),
    .Y(_2147_));
 sky130_fd_sc_hd__nor3_1 _6238_ (.A(net696),
    .B(_2068_),
    .C(_2147_),
    .Y(_2148_));
 sky130_fd_sc_hd__o21ai_0 _6239_ (.A1(_2146_),
    .A2(_2148_),
    .B1(net774),
    .Y(_2149_));
 sky130_fd_sc_hd__o21ai_0 _6240_ (.A1(_0169_),
    .A2(_1744_),
    .B1(_0168_),
    .Y(_2150_));
 sky130_fd_sc_hd__nor2_1 _6241_ (.A(_0164_),
    .B(_0167_),
    .Y(_2151_));
 sky130_fd_sc_hd__a211o_1 _6242_ (.A1(_2150_),
    .A2(_2151_),
    .B1(_2056_),
    .C1(net724),
    .X(_2152_));
 sky130_fd_sc_hd__o211ai_1 _6243_ (.A1(net719),
    .A2(_2144_),
    .B1(_2149_),
    .C1(_2152_),
    .Y(_4655_));
 sky130_fd_sc_hd__xnor2_1 _6244_ (.A(_2109_),
    .B(_1638_),
    .Y(_2153_));
 sky130_fd_sc_hd__mux4_2 _6245_ (.A0(\cpuregs[0][14] ),
    .A1(\cpuregs[1][14] ),
    .A2(\cpuregs[2][14] ),
    .A3(\cpuregs[3][14] ),
    .S0(net818),
    .S1(net808),
    .X(_2154_));
 sky130_fd_sc_hd__mux4_2 _6246_ (.A0(\cpuregs[4][14] ),
    .A1(\cpuregs[5][14] ),
    .A2(\cpuregs[6][14] ),
    .A3(\cpuregs[7][14] ),
    .S0(net818),
    .S1(net808),
    .X(_2155_));
 sky130_fd_sc_hd__mux4_2 _6247_ (.A0(\cpuregs[8][14] ),
    .A1(\cpuregs[9][14] ),
    .A2(\cpuregs[10][14] ),
    .A3(\cpuregs[11][14] ),
    .S0(net818),
    .S1(net808),
    .X(_2156_));
 sky130_fd_sc_hd__mux4_2 _6248_ (.A0(\cpuregs[12][14] ),
    .A1(\cpuregs[13][14] ),
    .A2(\cpuregs[14][14] ),
    .A3(\cpuregs[15][14] ),
    .S0(net818),
    .S1(net808),
    .X(_2157_));
 sky130_fd_sc_hd__mux4_2 _6249_ (.A0(_2154_),
    .A1(_2155_),
    .A2(_2156_),
    .A3(_2157_),
    .S0(net803),
    .S1(_0044_),
    .X(_2158_));
 sky130_fd_sc_hd__mux4_2 _6250_ (.A0(\cpuregs[16][14] ),
    .A1(\cpuregs[17][14] ),
    .A2(\cpuregs[18][14] ),
    .A3(\cpuregs[19][14] ),
    .S0(net819),
    .S1(net809),
    .X(_2159_));
 sky130_fd_sc_hd__mux4_2 _6251_ (.A0(\cpuregs[20][14] ),
    .A1(\cpuregs[21][14] ),
    .A2(\cpuregs[22][14] ),
    .A3(\cpuregs[23][14] ),
    .S0(net819),
    .S1(net809),
    .X(_2160_));
 sky130_fd_sc_hd__mux4_2 _6252_ (.A0(\cpuregs[24][14] ),
    .A1(\cpuregs[25][14] ),
    .A2(\cpuregs[26][14] ),
    .A3(\cpuregs[27][14] ),
    .S0(net819),
    .S1(net809),
    .X(_2161_));
 sky130_fd_sc_hd__mux4_2 _6253_ (.A0(\cpuregs[28][14] ),
    .A1(\cpuregs[29][14] ),
    .A2(\cpuregs[30][14] ),
    .A3(\cpuregs[31][14] ),
    .S0(net818),
    .S1(net808),
    .X(_2162_));
 sky130_fd_sc_hd__mux4_2 _6254_ (.A0(_2159_),
    .A1(_2160_),
    .A2(_2161_),
    .A3(_2162_),
    .S0(net803),
    .S1(_0044_),
    .X(_2163_));
 sky130_fd_sc_hd__mux2i_1 _6255_ (.A0(_2158_),
    .A1(_2163_),
    .S(net800),
    .Y(_2164_));
 sky130_fd_sc_hd__nor2_1 _6256_ (.A(net707),
    .B(_2164_),
    .Y(_2165_));
 sky130_fd_sc_hd__a21oi_1 _6257_ (.A1(\reg_pc[14] ),
    .A2(net722),
    .B1(_2165_),
    .Y(_2166_));
 sky130_fd_sc_hd__nor2_1 _6258_ (.A(net758),
    .B(net720),
    .Y(_2167_));
 sky130_fd_sc_hd__nor3_1 _6259_ (.A(net697),
    .B(_2106_),
    .C(_2167_),
    .Y(_2168_));
 sky130_fd_sc_hd__nor2_1 _6260_ (.A(net763),
    .B(net708),
    .Y(_2169_));
 sky130_fd_sc_hd__nor3_1 _6261_ (.A(net696),
    .B(_2104_),
    .C(_2169_),
    .Y(_2170_));
 sky130_fd_sc_hd__o21ai_0 _6262_ (.A1(_2168_),
    .A2(_2170_),
    .B1(net774),
    .Y(_2171_));
 sky130_fd_sc_hd__o221ai_1 _6263_ (.A1(net724),
    .A2(_2153_),
    .B1(_2166_),
    .B2(net719),
    .C1(_2171_),
    .Y(_4654_));
 sky130_fd_sc_hd__nor2_1 _6264_ (.A(_1739_),
    .B(_1742_),
    .Y(_2172_));
 sky130_fd_sc_hd__nand2b_1 _6265_ (.A_N(_1733_),
    .B(_2172_),
    .Y(_2173_));
 sky130_fd_sc_hd__and2_1 _6266_ (.A(_0176_),
    .B(_2173_),
    .X(_2174_));
 sky130_fd_sc_hd__a211oi_1 _6267_ (.A1(_1635_),
    .A2(_2174_),
    .B1(_1730_),
    .C1(_0170_),
    .Y(_2175_));
 sky130_fd_sc_hd__mux4_2 _6268_ (.A0(\cpuregs[0][13] ),
    .A1(\cpuregs[1][13] ),
    .A2(\cpuregs[2][13] ),
    .A3(\cpuregs[3][13] ),
    .S0(net818),
    .S1(net808),
    .X(_2176_));
 sky130_fd_sc_hd__mux4_2 _6269_ (.A0(\cpuregs[4][13] ),
    .A1(\cpuregs[5][13] ),
    .A2(\cpuregs[6][13] ),
    .A3(\cpuregs[7][13] ),
    .S0(net818),
    .S1(net808),
    .X(_2177_));
 sky130_fd_sc_hd__mux4_2 _6270_ (.A0(\cpuregs[8][13] ),
    .A1(\cpuregs[9][13] ),
    .A2(\cpuregs[10][13] ),
    .A3(\cpuregs[11][13] ),
    .S0(net818),
    .S1(net808),
    .X(_2178_));
 sky130_fd_sc_hd__mux4_2 _6271_ (.A0(\cpuregs[12][13] ),
    .A1(\cpuregs[13][13] ),
    .A2(\cpuregs[14][13] ),
    .A3(\cpuregs[15][13] ),
    .S0(net818),
    .S1(net808),
    .X(_2179_));
 sky130_fd_sc_hd__mux4_2 _6272_ (.A0(_2176_),
    .A1(_2177_),
    .A2(_2178_),
    .A3(_2179_),
    .S0(net803),
    .S1(_0044_),
    .X(_2180_));
 sky130_fd_sc_hd__mux4_2 _6273_ (.A0(\cpuregs[16][13] ),
    .A1(\cpuregs[17][13] ),
    .A2(\cpuregs[18][13] ),
    .A3(\cpuregs[19][13] ),
    .S0(net819),
    .S1(net809),
    .X(_2181_));
 sky130_fd_sc_hd__mux4_2 _6274_ (.A0(\cpuregs[20][13] ),
    .A1(\cpuregs[21][13] ),
    .A2(\cpuregs[22][13] ),
    .A3(\cpuregs[23][13] ),
    .S0(net819),
    .S1(net809),
    .X(_2182_));
 sky130_fd_sc_hd__mux4_2 _6275_ (.A0(\cpuregs[24][13] ),
    .A1(\cpuregs[25][13] ),
    .A2(\cpuregs[26][13] ),
    .A3(\cpuregs[27][13] ),
    .S0(net819),
    .S1(net809),
    .X(_2183_));
 sky130_fd_sc_hd__mux4_2 _6276_ (.A0(\cpuregs[28][13] ),
    .A1(\cpuregs[29][13] ),
    .A2(\cpuregs[30][13] ),
    .A3(\cpuregs[31][13] ),
    .S0(net819),
    .S1(net809),
    .X(_2184_));
 sky130_fd_sc_hd__mux4_2 _6277_ (.A0(_2181_),
    .A1(_2182_),
    .A2(_2183_),
    .A3(_2184_),
    .S0(net803),
    .S1(_0044_),
    .X(_2185_));
 sky130_fd_sc_hd__mux2i_1 _6278_ (.A0(_2180_),
    .A1(_2185_),
    .S(net800),
    .Y(_2186_));
 sky130_fd_sc_hd__nand2_1 _6279_ (.A(\reg_pc[13] ),
    .B(net722),
    .Y(_2187_));
 sky130_fd_sc_hd__o21ai_0 _6280_ (.A1(net707),
    .A2(_2186_),
    .B1(_2187_),
    .Y(_2188_));
 sky130_fd_sc_hd__nand2_1 _6281_ (.A(_1725_),
    .B(_2188_),
    .Y(_2189_));
 sky130_fd_sc_hd__nor2_1 _6282_ (.A(net759),
    .B(net720),
    .Y(_2190_));
 sky130_fd_sc_hd__nor3_1 _6283_ (.A(net697),
    .B(_2115_),
    .C(_2190_),
    .Y(_2191_));
 sky130_fd_sc_hd__nor2_1 _6284_ (.A(net736),
    .B(net708),
    .Y(_2192_));
 sky130_fd_sc_hd__nor3_1 _6285_ (.A(net696),
    .B(_2113_),
    .C(_2192_),
    .Y(_2193_));
 sky130_fd_sc_hd__o21ai_0 _6286_ (.A1(_2191_),
    .A2(_2193_),
    .B1(net774),
    .Y(_2194_));
 sky130_fd_sc_hd__o311ai_0 _6287_ (.A1(net724),
    .A2(_1744_),
    .A3(_2175_),
    .B1(_2189_),
    .C1(_2194_),
    .Y(_4653_));
 sky130_fd_sc_hd__o21ai_0 _6288_ (.A1(_0175_),
    .A2(_1630_),
    .B1(_0172_),
    .Y(_2195_));
 sky130_fd_sc_hd__nand2b_1 _6289_ (.A_N(_0171_),
    .B(_2195_),
    .Y(_2196_));
 sky130_fd_sc_hd__a21oi_1 _6290_ (.A1(_0174_),
    .A2(_2196_),
    .B1(_0173_),
    .Y(_2197_));
 sky130_fd_sc_hd__xor2_1 _6291_ (.A(_0205_),
    .B(_2197_),
    .X(_2198_));
 sky130_fd_sc_hd__mux4_2 _6292_ (.A0(\cpuregs[0][12] ),
    .A1(\cpuregs[1][12] ),
    .A2(\cpuregs[2][12] ),
    .A3(\cpuregs[3][12] ),
    .S0(net819),
    .S1(net809),
    .X(_2199_));
 sky130_fd_sc_hd__mux4_2 _6293_ (.A0(\cpuregs[4][12] ),
    .A1(\cpuregs[5][12] ),
    .A2(\cpuregs[6][12] ),
    .A3(\cpuregs[7][12] ),
    .S0(net819),
    .S1(net809),
    .X(_2200_));
 sky130_fd_sc_hd__mux4_2 _6294_ (.A0(\cpuregs[16][12] ),
    .A1(\cpuregs[17][12] ),
    .A2(\cpuregs[18][12] ),
    .A3(\cpuregs[19][12] ),
    .S0(net819),
    .S1(net809),
    .X(_2201_));
 sky130_fd_sc_hd__mux4_2 _6295_ (.A0(\cpuregs[20][12] ),
    .A1(\cpuregs[21][12] ),
    .A2(\cpuregs[22][12] ),
    .A3(\cpuregs[23][12] ),
    .S0(net819),
    .S1(net809),
    .X(_2202_));
 sky130_fd_sc_hd__mux4_2 _6296_ (.A0(_2199_),
    .A1(_2200_),
    .A2(_2201_),
    .A3(_2202_),
    .S0(net805),
    .S1(net800),
    .X(_2203_));
 sky130_fd_sc_hd__mux4_2 _6297_ (.A0(\cpuregs[8][12] ),
    .A1(\cpuregs[9][12] ),
    .A2(\cpuregs[10][12] ),
    .A3(\cpuregs[11][12] ),
    .S0(net819),
    .S1(net809),
    .X(_2204_));
 sky130_fd_sc_hd__mux4_2 _6298_ (.A0(\cpuregs[12][12] ),
    .A1(\cpuregs[13][12] ),
    .A2(\cpuregs[14][12] ),
    .A3(\cpuregs[15][12] ),
    .S0(net819),
    .S1(net809),
    .X(_2205_));
 sky130_fd_sc_hd__mux4_2 _6299_ (.A0(\cpuregs[24][12] ),
    .A1(\cpuregs[25][12] ),
    .A2(\cpuregs[26][12] ),
    .A3(\cpuregs[27][12] ),
    .S0(net819),
    .S1(net809),
    .X(_2206_));
 sky130_fd_sc_hd__mux4_2 _6300_ (.A0(\cpuregs[28][12] ),
    .A1(\cpuregs[29][12] ),
    .A2(\cpuregs[30][12] ),
    .A3(\cpuregs[31][12] ),
    .S0(net819),
    .S1(net809),
    .X(_2207_));
 sky130_fd_sc_hd__mux4_2 _6301_ (.A0(_2204_),
    .A1(_2205_),
    .A2(_2206_),
    .A3(_2207_),
    .S0(net805),
    .S1(net800),
    .X(_2208_));
 sky130_fd_sc_hd__mux2i_1 _6302_ (.A0(_2203_),
    .A1(_2208_),
    .S(_0044_),
    .Y(_2209_));
 sky130_fd_sc_hd__nor2_1 _6303_ (.A(net707),
    .B(_2209_),
    .Y(_2210_));
 sky130_fd_sc_hd__a21oi_1 _6304_ (.A1(\reg_pc[12] ),
    .A2(net722),
    .B1(_2210_),
    .Y(_2211_));
 sky130_fd_sc_hd__nor2_1 _6305_ (.A(net760),
    .B(net720),
    .Y(_2212_));
 sky130_fd_sc_hd__nor3_1 _6306_ (.A(net697),
    .B(_2147_),
    .C(_2212_),
    .Y(_2213_));
 sky130_fd_sc_hd__nor2_1 _6307_ (.A(net737),
    .B(net708),
    .Y(_2214_));
 sky130_fd_sc_hd__nor3_1 _6308_ (.A(net696),
    .B(_2145_),
    .C(_2214_),
    .Y(_2215_));
 sky130_fd_sc_hd__o21ai_0 _6309_ (.A1(_2213_),
    .A2(_2215_),
    .B1(net774),
    .Y(_2216_));
 sky130_fd_sc_hd__o221ai_1 _6310_ (.A1(net724),
    .A2(_2198_),
    .B1(_2211_),
    .B2(net719),
    .C1(_2216_),
    .Y(_4652_));
 sky130_fd_sc_hd__o21ai_0 _6311_ (.A1(_0175_),
    .A2(_2174_),
    .B1(_0172_),
    .Y(_2217_));
 sky130_fd_sc_hd__nand2b_1 _6312_ (.A_N(_0171_),
    .B(_2217_),
    .Y(_2218_));
 sky130_fd_sc_hd__xnor2_1 _6313_ (.A(_0174_),
    .B(_2218_),
    .Y(_2219_));
 sky130_fd_sc_hd__mux4_2 _6314_ (.A0(\cpuregs[0][11] ),
    .A1(\cpuregs[1][11] ),
    .A2(\cpuregs[2][11] ),
    .A3(\cpuregs[3][11] ),
    .S0(net818),
    .S1(net808),
    .X(_2220_));
 sky130_fd_sc_hd__mux4_2 _6315_ (.A0(\cpuregs[4][11] ),
    .A1(\cpuregs[5][11] ),
    .A2(\cpuregs[6][11] ),
    .A3(\cpuregs[7][11] ),
    .S0(net818),
    .S1(net808),
    .X(_2221_));
 sky130_fd_sc_hd__mux4_2 _6316_ (.A0(\cpuregs[16][11] ),
    .A1(\cpuregs[17][11] ),
    .A2(\cpuregs[18][11] ),
    .A3(\cpuregs[19][11] ),
    .S0(net819),
    .S1(net809),
    .X(_2222_));
 sky130_fd_sc_hd__mux4_2 _6317_ (.A0(\cpuregs[20][11] ),
    .A1(\cpuregs[21][11] ),
    .A2(\cpuregs[22][11] ),
    .A3(\cpuregs[23][11] ),
    .S0(net819),
    .S1(net809),
    .X(_2223_));
 sky130_fd_sc_hd__mux4_2 _6318_ (.A0(_2220_),
    .A1(_2221_),
    .A2(_2222_),
    .A3(_2223_),
    .S0(net803),
    .S1(net800),
    .X(_2224_));
 sky130_fd_sc_hd__mux4_2 _6319_ (.A0(\cpuregs[8][11] ),
    .A1(\cpuregs[9][11] ),
    .A2(\cpuregs[10][11] ),
    .A3(\cpuregs[11][11] ),
    .S0(net818),
    .S1(net808),
    .X(_2225_));
 sky130_fd_sc_hd__mux4_2 _6320_ (.A0(\cpuregs[12][11] ),
    .A1(\cpuregs[13][11] ),
    .A2(\cpuregs[14][11] ),
    .A3(\cpuregs[15][11] ),
    .S0(net819),
    .S1(net809),
    .X(_2226_));
 sky130_fd_sc_hd__mux4_2 _6321_ (.A0(\cpuregs[24][11] ),
    .A1(\cpuregs[25][11] ),
    .A2(\cpuregs[26][11] ),
    .A3(\cpuregs[27][11] ),
    .S0(net819),
    .S1(net809),
    .X(_2227_));
 sky130_fd_sc_hd__mux4_2 _6322_ (.A0(\cpuregs[28][11] ),
    .A1(\cpuregs[29][11] ),
    .A2(\cpuregs[30][11] ),
    .A3(\cpuregs[31][11] ),
    .S0(net818),
    .S1(net808),
    .X(_2228_));
 sky130_fd_sc_hd__mux4_2 _6323_ (.A0(_2225_),
    .A1(_2226_),
    .A2(_2227_),
    .A3(_2228_),
    .S0(net803),
    .S1(net800),
    .X(_2229_));
 sky130_fd_sc_hd__mux2i_1 _6324_ (.A0(_2224_),
    .A1(_2229_),
    .S(_0044_),
    .Y(_2230_));
 sky130_fd_sc_hd__nor2_1 _6325_ (.A(net707),
    .B(_2230_),
    .Y(_2231_));
 sky130_fd_sc_hd__a21oi_1 _6326_ (.A1(\reg_pc[11] ),
    .A2(net722),
    .B1(_2231_),
    .Y(_2232_));
 sky130_fd_sc_hd__nor2_1 _6327_ (.A(net761),
    .B(net720),
    .Y(_2233_));
 sky130_fd_sc_hd__nor3_1 _6328_ (.A(net697),
    .B(_2169_),
    .C(_2233_),
    .Y(_2234_));
 sky130_fd_sc_hd__nor2_1 _6329_ (.A(net337),
    .B(net708),
    .Y(_2235_));
 sky130_fd_sc_hd__nor3_1 _6330_ (.A(net696),
    .B(_2167_),
    .C(_2235_),
    .Y(_2236_));
 sky130_fd_sc_hd__o21ai_0 _6331_ (.A1(_2234_),
    .A2(_2236_),
    .B1(net774),
    .Y(_2237_));
 sky130_fd_sc_hd__o221ai_1 _6332_ (.A1(net724),
    .A2(_2219_),
    .B1(_2232_),
    .B2(net719),
    .C1(_2237_),
    .Y(_4651_));
 sky130_fd_sc_hd__or3_1 _6333_ (.A(_0172_),
    .B(_0175_),
    .C(_1630_),
    .X(_2238_));
 sky130_fd_sc_hd__mux4_2 _6334_ (.A0(\cpuregs[0][10] ),
    .A1(\cpuregs[1][10] ),
    .A2(\cpuregs[2][10] ),
    .A3(\cpuregs[3][10] ),
    .S0(net815),
    .S1(net807),
    .X(_2239_));
 sky130_fd_sc_hd__mux4_2 _6335_ (.A0(\cpuregs[4][10] ),
    .A1(\cpuregs[5][10] ),
    .A2(\cpuregs[6][10] ),
    .A3(\cpuregs[7][10] ),
    .S0(net815),
    .S1(net807),
    .X(_2240_));
 sky130_fd_sc_hd__mux4_2 _6336_ (.A0(\cpuregs[16][10] ),
    .A1(\cpuregs[17][10] ),
    .A2(\cpuregs[18][10] ),
    .A3(\cpuregs[19][10] ),
    .S0(net815),
    .S1(net807),
    .X(_2241_));
 sky130_fd_sc_hd__mux4_2 _6337_ (.A0(\cpuregs[20][10] ),
    .A1(\cpuregs[21][10] ),
    .A2(\cpuregs[22][10] ),
    .A3(\cpuregs[23][10] ),
    .S0(net816),
    .S1(net806),
    .X(_2242_));
 sky130_fd_sc_hd__mux4_2 _6338_ (.A0(_2239_),
    .A1(_2240_),
    .A2(_2241_),
    .A3(_2242_),
    .S0(net804),
    .S1(net801),
    .X(_2243_));
 sky130_fd_sc_hd__mux4_2 _6339_ (.A0(\cpuregs[8][10] ),
    .A1(\cpuregs[9][10] ),
    .A2(\cpuregs[10][10] ),
    .A3(\cpuregs[11][10] ),
    .S0(net815),
    .S1(net807),
    .X(_2244_));
 sky130_fd_sc_hd__mux4_2 _6340_ (.A0(\cpuregs[12][10] ),
    .A1(\cpuregs[13][10] ),
    .A2(\cpuregs[14][10] ),
    .A3(\cpuregs[15][10] ),
    .S0(net815),
    .S1(net807),
    .X(_2245_));
 sky130_fd_sc_hd__mux4_2 _6341_ (.A0(\cpuregs[24][10] ),
    .A1(\cpuregs[25][10] ),
    .A2(\cpuregs[26][10] ),
    .A3(\cpuregs[27][10] ),
    .S0(net815),
    .S1(net807),
    .X(_2246_));
 sky130_fd_sc_hd__mux4_2 _6342_ (.A0(\cpuregs[28][10] ),
    .A1(\cpuregs[29][10] ),
    .A2(\cpuregs[30][10] ),
    .A3(\cpuregs[31][10] ),
    .S0(net816),
    .S1(net806),
    .X(_2247_));
 sky130_fd_sc_hd__mux4_2 _6343_ (.A0(_2244_),
    .A1(_2245_),
    .A2(_2246_),
    .A3(_2247_),
    .S0(net804),
    .S1(net801),
    .X(_2248_));
 sky130_fd_sc_hd__mux2i_1 _6344_ (.A0(_2243_),
    .A1(_2248_),
    .S(net802),
    .Y(_2249_));
 sky130_fd_sc_hd__nor2_1 _6345_ (.A(net707),
    .B(_2249_),
    .Y(_2250_));
 sky130_fd_sc_hd__a21oi_1 _6346_ (.A1(\reg_pc[10] ),
    .A2(net722),
    .B1(_2250_),
    .Y(_2251_));
 sky130_fd_sc_hd__nor2_1 _6347_ (.A(net762),
    .B(net720),
    .Y(_2252_));
 sky130_fd_sc_hd__nor3_1 _6348_ (.A(net697),
    .B(_2192_),
    .C(_2252_),
    .Y(_2253_));
 sky130_fd_sc_hd__nor2_1 _6349_ (.A(net336),
    .B(net708),
    .Y(_2254_));
 sky130_fd_sc_hd__nor3_1 _6350_ (.A(net696),
    .B(_2190_),
    .C(_2254_),
    .Y(_2255_));
 sky130_fd_sc_hd__o21ai_0 _6352_ (.A1(_2253_),
    .A2(_2255_),
    .B1(net774),
    .Y(_2257_));
 sky130_fd_sc_hd__o21ai_0 _6353_ (.A1(net719),
    .A2(_2251_),
    .B1(_2257_),
    .Y(_2258_));
 sky130_fd_sc_hd__a31o_2 _6354_ (.A1(net721),
    .A2(_2195_),
    .A3(_2238_),
    .B1(_2258_),
    .X(_4650_));
 sky130_fd_sc_hd__nor2_1 _6355_ (.A(_0176_),
    .B(_2173_),
    .Y(_2259_));
 sky130_fd_sc_hd__mux4_2 _6356_ (.A0(\cpuregs[0][9] ),
    .A1(\cpuregs[1][9] ),
    .A2(\cpuregs[2][9] ),
    .A3(\cpuregs[3][9] ),
    .S0(net814),
    .S1(net810),
    .X(_2260_));
 sky130_fd_sc_hd__mux4_2 _6357_ (.A0(\cpuregs[4][9] ),
    .A1(\cpuregs[5][9] ),
    .A2(\cpuregs[6][9] ),
    .A3(\cpuregs[7][9] ),
    .S0(net814),
    .S1(net810),
    .X(_2261_));
 sky130_fd_sc_hd__mux4_2 _6358_ (.A0(\cpuregs[16][9] ),
    .A1(\cpuregs[17][9] ),
    .A2(\cpuregs[18][9] ),
    .A3(\cpuregs[19][9] ),
    .S0(net814),
    .S1(net810),
    .X(_2262_));
 sky130_fd_sc_hd__mux4_2 _6359_ (.A0(\cpuregs[20][9] ),
    .A1(\cpuregs[21][9] ),
    .A2(\cpuregs[22][9] ),
    .A3(\cpuregs[23][9] ),
    .S0(net814),
    .S1(net810),
    .X(_2263_));
 sky130_fd_sc_hd__mux4_2 _6360_ (.A0(_2260_),
    .A1(_2261_),
    .A2(_2262_),
    .A3(_2263_),
    .S0(net805),
    .S1(net800),
    .X(_2264_));
 sky130_fd_sc_hd__mux4_2 _6361_ (.A0(\cpuregs[8][9] ),
    .A1(\cpuregs[9][9] ),
    .A2(\cpuregs[10][9] ),
    .A3(\cpuregs[11][9] ),
    .S0(net814),
    .S1(net810),
    .X(_2265_));
 sky130_fd_sc_hd__mux4_2 _6362_ (.A0(\cpuregs[12][9] ),
    .A1(\cpuregs[13][9] ),
    .A2(\cpuregs[14][9] ),
    .A3(\cpuregs[15][9] ),
    .S0(net814),
    .S1(net810),
    .X(_2266_));
 sky130_fd_sc_hd__mux4_2 _6363_ (.A0(\cpuregs[24][9] ),
    .A1(\cpuregs[25][9] ),
    .A2(\cpuregs[26][9] ),
    .A3(\cpuregs[27][9] ),
    .S0(net814),
    .S1(net810),
    .X(_2267_));
 sky130_fd_sc_hd__mux4_2 _6364_ (.A0(\cpuregs[28][9] ),
    .A1(\cpuregs[29][9] ),
    .A2(\cpuregs[30][9] ),
    .A3(\cpuregs[31][9] ),
    .S0(net814),
    .S1(net810),
    .X(_2268_));
 sky130_fd_sc_hd__mux4_2 _6365_ (.A0(_2265_),
    .A1(_2266_),
    .A2(_2267_),
    .A3(_2268_),
    .S0(net805),
    .S1(net800),
    .X(_2269_));
 sky130_fd_sc_hd__mux2i_1 _6366_ (.A0(_2264_),
    .A1(_2269_),
    .S(_0044_),
    .Y(_2270_));
 sky130_fd_sc_hd__nand2_1 _6367_ (.A(net735),
    .B(net722),
    .Y(_2271_));
 sky130_fd_sc_hd__o21ai_0 _6368_ (.A1(net707),
    .A2(_2270_),
    .B1(_2271_),
    .Y(_2272_));
 sky130_fd_sc_hd__nand2_1 _6369_ (.A(_1725_),
    .B(_2272_),
    .Y(_2273_));
 sky130_fd_sc_hd__nor2_1 _6370_ (.A(net763),
    .B(net720),
    .Y(_2274_));
 sky130_fd_sc_hd__nor3_1 _6371_ (.A(net697),
    .B(_2214_),
    .C(_2274_),
    .Y(_2275_));
 sky130_fd_sc_hd__nor2_1 _6372_ (.A(net335),
    .B(net708),
    .Y(_2276_));
 sky130_fd_sc_hd__nor3_1 _6373_ (.A(net696),
    .B(_2212_),
    .C(_2276_),
    .Y(_2277_));
 sky130_fd_sc_hd__o21ai_0 _6374_ (.A1(_2275_),
    .A2(_2277_),
    .B1(net774),
    .Y(_2278_));
 sky130_fd_sc_hd__o311ai_0 _6375_ (.A1(net724),
    .A2(_2174_),
    .A3(_2259_),
    .B1(_2273_),
    .C1(_2278_),
    .Y(_4680_));
 sky130_fd_sc_hd__inv_1 _6376_ (.A(_0184_),
    .Y(_2279_));
 sky130_fd_sc_hd__nor2_1 _6377_ (.A(_2279_),
    .B(_1623_),
    .Y(_2280_));
 sky130_fd_sc_hd__o21ai_0 _6378_ (.A1(_0183_),
    .A2(_2280_),
    .B1(_0180_),
    .Y(_2281_));
 sky130_fd_sc_hd__nand2b_1 _6379_ (.A_N(_0179_),
    .B(_2281_),
    .Y(_2282_));
 sky130_fd_sc_hd__a21oi_1 _6380_ (.A1(_0182_),
    .A2(_2282_),
    .B1(_0181_),
    .Y(_2283_));
 sky130_fd_sc_hd__xor2_1 _6381_ (.A(_0178_),
    .B(_2283_),
    .X(_2284_));
 sky130_fd_sc_hd__mux4_2 _6382_ (.A0(\cpuregs[0][8] ),
    .A1(\cpuregs[1][8] ),
    .A2(\cpuregs[2][8] ),
    .A3(\cpuregs[3][8] ),
    .S0(net815),
    .S1(net807),
    .X(_2285_));
 sky130_fd_sc_hd__mux4_2 _6383_ (.A0(\cpuregs[4][8] ),
    .A1(\cpuregs[5][8] ),
    .A2(\cpuregs[6][8] ),
    .A3(\cpuregs[7][8] ),
    .S0(net815),
    .S1(net807),
    .X(_2286_));
 sky130_fd_sc_hd__mux4_2 _6384_ (.A0(\cpuregs[16][8] ),
    .A1(\cpuregs[17][8] ),
    .A2(\cpuregs[18][8] ),
    .A3(\cpuregs[19][8] ),
    .S0(net815),
    .S1(net807),
    .X(_2287_));
 sky130_fd_sc_hd__mux4_2 _6385_ (.A0(\cpuregs[20][8] ),
    .A1(\cpuregs[21][8] ),
    .A2(\cpuregs[22][8] ),
    .A3(\cpuregs[23][8] ),
    .S0(net816),
    .S1(net806),
    .X(_2288_));
 sky130_fd_sc_hd__mux4_2 _6386_ (.A0(_2285_),
    .A1(_2286_),
    .A2(_2287_),
    .A3(_2288_),
    .S0(net804),
    .S1(net801),
    .X(_2289_));
 sky130_fd_sc_hd__mux4_2 _6387_ (.A0(\cpuregs[8][8] ),
    .A1(\cpuregs[9][8] ),
    .A2(\cpuregs[10][8] ),
    .A3(\cpuregs[11][8] ),
    .S0(net815),
    .S1(net807),
    .X(_2290_));
 sky130_fd_sc_hd__mux4_2 _6388_ (.A0(\cpuregs[12][8] ),
    .A1(\cpuregs[13][8] ),
    .A2(\cpuregs[14][8] ),
    .A3(\cpuregs[15][8] ),
    .S0(net815),
    .S1(net807),
    .X(_2291_));
 sky130_fd_sc_hd__mux4_2 _6389_ (.A0(\cpuregs[24][8] ),
    .A1(\cpuregs[25][8] ),
    .A2(\cpuregs[26][8] ),
    .A3(\cpuregs[27][8] ),
    .S0(net815),
    .S1(net807),
    .X(_2292_));
 sky130_fd_sc_hd__mux4_2 _6390_ (.A0(\cpuregs[28][8] ),
    .A1(\cpuregs[29][8] ),
    .A2(\cpuregs[30][8] ),
    .A3(\cpuregs[31][8] ),
    .S0(net816),
    .S1(net806),
    .X(_2293_));
 sky130_fd_sc_hd__mux4_2 _6391_ (.A0(_2290_),
    .A1(_2291_),
    .A2(_2292_),
    .A3(_2293_),
    .S0(net804),
    .S1(net801),
    .X(_2294_));
 sky130_fd_sc_hd__mux2i_1 _6392_ (.A0(_2289_),
    .A1(_2294_),
    .S(net802),
    .Y(_2295_));
 sky130_fd_sc_hd__nor2_1 _6393_ (.A(net707),
    .B(_2295_),
    .Y(_2296_));
 sky130_fd_sc_hd__a21oi_1 _6394_ (.A1(\reg_pc[8] ),
    .A2(net722),
    .B1(_2296_),
    .Y(_2297_));
 sky130_fd_sc_hd__nor2_1 _6395_ (.A(net736),
    .B(net720),
    .Y(_2298_));
 sky130_fd_sc_hd__nor3_1 _6396_ (.A(net697),
    .B(_2235_),
    .C(_2298_),
    .Y(_2299_));
 sky130_fd_sc_hd__nor2_1 _6397_ (.A(net334),
    .B(net708),
    .Y(_2300_));
 sky130_fd_sc_hd__nor3_1 _6398_ (.A(net696),
    .B(_2233_),
    .C(_2300_),
    .Y(_2301_));
 sky130_fd_sc_hd__o21ai_0 _6399_ (.A1(_2299_),
    .A2(_2301_),
    .B1(net774),
    .Y(_2302_));
 sky130_fd_sc_hd__o221ai_1 _6400_ (.A1(net724),
    .A2(_2284_),
    .B1(_2297_),
    .B2(net719),
    .C1(_2302_),
    .Y(_4679_));
 sky130_fd_sc_hd__o21bai_1 _6401_ (.A1(_1620_),
    .A2(_1737_),
    .B1_N(_0185_),
    .Y(_2303_));
 sky130_fd_sc_hd__a21oi_1 _6402_ (.A1(_0188_),
    .A2(_2303_),
    .B1(_0187_),
    .Y(_2304_));
 sky130_fd_sc_hd__o21bai_1 _6403_ (.A1(_2279_),
    .A2(_2304_),
    .B1_N(_0183_),
    .Y(_2305_));
 sky130_fd_sc_hd__a21oi_1 _6404_ (.A1(_0180_),
    .A2(_2305_),
    .B1(_0179_),
    .Y(_2306_));
 sky130_fd_sc_hd__xor2_1 _6405_ (.A(_0182_),
    .B(_2306_),
    .X(_2307_));
 sky130_fd_sc_hd__mux4_2 _6406_ (.A0(\cpuregs[0][7] ),
    .A1(\cpuregs[1][7] ),
    .A2(\cpuregs[2][7] ),
    .A3(\cpuregs[3][7] ),
    .S0(net815),
    .S1(net807),
    .X(_2308_));
 sky130_fd_sc_hd__mux4_2 _6407_ (.A0(\cpuregs[4][7] ),
    .A1(\cpuregs[5][7] ),
    .A2(\cpuregs[6][7] ),
    .A3(\cpuregs[7][7] ),
    .S0(net815),
    .S1(net807),
    .X(_2309_));
 sky130_fd_sc_hd__mux4_2 _6408_ (.A0(\cpuregs[16][7] ),
    .A1(\cpuregs[17][7] ),
    .A2(\cpuregs[18][7] ),
    .A3(\cpuregs[19][7] ),
    .S0(net815),
    .S1(net807),
    .X(_2310_));
 sky130_fd_sc_hd__mux4_2 _6409_ (.A0(\cpuregs[20][7] ),
    .A1(\cpuregs[21][7] ),
    .A2(\cpuregs[22][7] ),
    .A3(\cpuregs[23][7] ),
    .S0(net815),
    .S1(net807),
    .X(_2311_));
 sky130_fd_sc_hd__mux4_2 _6410_ (.A0(_2308_),
    .A1(_2309_),
    .A2(_2310_),
    .A3(_2311_),
    .S0(net804),
    .S1(net801),
    .X(_2312_));
 sky130_fd_sc_hd__mux4_2 _6411_ (.A0(\cpuregs[8][7] ),
    .A1(\cpuregs[9][7] ),
    .A2(\cpuregs[10][7] ),
    .A3(\cpuregs[11][7] ),
    .S0(net815),
    .S1(net807),
    .X(_2313_));
 sky130_fd_sc_hd__mux4_2 _6412_ (.A0(\cpuregs[12][7] ),
    .A1(\cpuregs[13][7] ),
    .A2(\cpuregs[14][7] ),
    .A3(\cpuregs[15][7] ),
    .S0(net815),
    .S1(net807),
    .X(_2314_));
 sky130_fd_sc_hd__mux4_2 _6413_ (.A0(\cpuregs[24][7] ),
    .A1(\cpuregs[25][7] ),
    .A2(\cpuregs[26][7] ),
    .A3(\cpuregs[27][7] ),
    .S0(net815),
    .S1(net807),
    .X(_2315_));
 sky130_fd_sc_hd__mux4_2 _6414_ (.A0(\cpuregs[28][7] ),
    .A1(\cpuregs[29][7] ),
    .A2(\cpuregs[30][7] ),
    .A3(\cpuregs[31][7] ),
    .S0(net815),
    .S1(net807),
    .X(_2316_));
 sky130_fd_sc_hd__mux4_2 _6415_ (.A0(_2313_),
    .A1(_2314_),
    .A2(_2315_),
    .A3(_2316_),
    .S0(net804),
    .S1(net801),
    .X(_2317_));
 sky130_fd_sc_hd__mux2i_1 _6416_ (.A0(_2312_),
    .A1(_2317_),
    .S(net802),
    .Y(_2318_));
 sky130_fd_sc_hd__nor2_1 _6417_ (.A(net707),
    .B(_2318_),
    .Y(_2319_));
 sky130_fd_sc_hd__a21oi_1 _6418_ (.A1(\reg_pc[7] ),
    .A2(net722),
    .B1(_2319_),
    .Y(_2320_));
 sky130_fd_sc_hd__nor2_1 _6419_ (.A(net737),
    .B(net720),
    .Y(_2321_));
 sky130_fd_sc_hd__nor3_1 _6420_ (.A(net697),
    .B(_2254_),
    .C(_2321_),
    .Y(_2322_));
 sky130_fd_sc_hd__nor2_1 _6421_ (.A(net740),
    .B(net708),
    .Y(_2323_));
 sky130_fd_sc_hd__nor3_1 _6422_ (.A(net696),
    .B(_2252_),
    .C(_2323_),
    .Y(_2324_));
 sky130_fd_sc_hd__o21ai_0 _6423_ (.A1(_2322_),
    .A2(_2324_),
    .B1(net774),
    .Y(_2325_));
 sky130_fd_sc_hd__o221ai_1 _6424_ (.A1(net724),
    .A2(_2307_),
    .B1(_2320_),
    .B2(net719),
    .C1(_2325_),
    .Y(_4678_));
 sky130_fd_sc_hd__mux4_2 _6425_ (.A0(\cpuregs[0][6] ),
    .A1(\cpuregs[1][6] ),
    .A2(\cpuregs[2][6] ),
    .A3(\cpuregs[3][6] ),
    .S0(net814),
    .S1(net810),
    .X(_2326_));
 sky130_fd_sc_hd__mux4_2 _6426_ (.A0(\cpuregs[4][6] ),
    .A1(\cpuregs[5][6] ),
    .A2(\cpuregs[6][6] ),
    .A3(\cpuregs[7][6] ),
    .S0(net814),
    .S1(net810),
    .X(_2327_));
 sky130_fd_sc_hd__mux4_2 _6427_ (.A0(\cpuregs[16][6] ),
    .A1(\cpuregs[17][6] ),
    .A2(\cpuregs[18][6] ),
    .A3(\cpuregs[19][6] ),
    .S0(net814),
    .S1(net810),
    .X(_2328_));
 sky130_fd_sc_hd__mux4_2 _6428_ (.A0(\cpuregs[20][6] ),
    .A1(\cpuregs[21][6] ),
    .A2(\cpuregs[22][6] ),
    .A3(\cpuregs[23][6] ),
    .S0(net814),
    .S1(net810),
    .X(_2329_));
 sky130_fd_sc_hd__mux4_2 _6429_ (.A0(_2326_),
    .A1(_2327_),
    .A2(_2328_),
    .A3(_2329_),
    .S0(net805),
    .S1(net800),
    .X(_2330_));
 sky130_fd_sc_hd__mux4_2 _6430_ (.A0(\cpuregs[8][6] ),
    .A1(\cpuregs[9][6] ),
    .A2(\cpuregs[10][6] ),
    .A3(\cpuregs[11][6] ),
    .S0(net814),
    .S1(net810),
    .X(_2331_));
 sky130_fd_sc_hd__mux4_2 _6431_ (.A0(\cpuregs[12][6] ),
    .A1(\cpuregs[13][6] ),
    .A2(\cpuregs[14][6] ),
    .A3(\cpuregs[15][6] ),
    .S0(net814),
    .S1(net810),
    .X(_2332_));
 sky130_fd_sc_hd__mux4_2 _6432_ (.A0(\cpuregs[24][6] ),
    .A1(\cpuregs[25][6] ),
    .A2(\cpuregs[26][6] ),
    .A3(\cpuregs[27][6] ),
    .S0(net814),
    .S1(net810),
    .X(_2333_));
 sky130_fd_sc_hd__mux4_2 _6433_ (.A0(\cpuregs[28][6] ),
    .A1(\cpuregs[29][6] ),
    .A2(\cpuregs[30][6] ),
    .A3(\cpuregs[31][6] ),
    .S0(net814),
    .S1(net810),
    .X(_2334_));
 sky130_fd_sc_hd__mux4_2 _6434_ (.A0(_2331_),
    .A1(_2332_),
    .A2(_2333_),
    .A3(_2334_),
    .S0(net805),
    .S1(net800),
    .X(_2335_));
 sky130_fd_sc_hd__mux2i_1 _6435_ (.A0(_2330_),
    .A1(_2335_),
    .S(_0044_),
    .Y(_2336_));
 sky130_fd_sc_hd__nor2_1 _6436_ (.A(net707),
    .B(_2336_),
    .Y(_2337_));
 sky130_fd_sc_hd__a21oi_1 _6437_ (.A1(\reg_pc[6] ),
    .A2(net722),
    .B1(_2337_),
    .Y(_2338_));
 sky130_fd_sc_hd__nor2_1 _6438_ (.A(_0183_),
    .B(_2280_),
    .Y(_2339_));
 sky130_fd_sc_hd__xor2_1 _6439_ (.A(_0180_),
    .B(_2339_),
    .X(_2340_));
 sky130_fd_sc_hd__a211oi_1 _6440_ (.A1(_0436_),
    .A2(net720),
    .B1(net696),
    .C1(_2274_),
    .Y(_2341_));
 sky130_fd_sc_hd__inv_1 _6441_ (.A(net337),
    .Y(_0395_));
 sky130_fd_sc_hd__a211oi_1 _6442_ (.A1(_0395_),
    .A2(net708),
    .B1(net697),
    .C1(_2276_),
    .Y(_2342_));
 sky130_fd_sc_hd__o21ai_0 _6443_ (.A1(_2341_),
    .A2(_2342_),
    .B1(net774),
    .Y(_2343_));
 sky130_fd_sc_hd__o221ai_1 _6444_ (.A1(net719),
    .A2(_2338_),
    .B1(_2340_),
    .B2(net724),
    .C1(_2343_),
    .Y(_4677_));
 sky130_fd_sc_hd__mux4_2 _6445_ (.A0(\cpuregs[0][5] ),
    .A1(\cpuregs[1][5] ),
    .A2(\cpuregs[2][5] ),
    .A3(\cpuregs[3][5] ),
    .S0(net814),
    .S1(net810),
    .X(_2344_));
 sky130_fd_sc_hd__mux4_2 _6446_ (.A0(\cpuregs[4][5] ),
    .A1(\cpuregs[5][5] ),
    .A2(\cpuregs[6][5] ),
    .A3(\cpuregs[7][5] ),
    .S0(net814),
    .S1(net810),
    .X(_2345_));
 sky130_fd_sc_hd__mux4_2 _6447_ (.A0(\cpuregs[16][5] ),
    .A1(\cpuregs[17][5] ),
    .A2(\cpuregs[18][5] ),
    .A3(\cpuregs[19][5] ),
    .S0(net814),
    .S1(net810),
    .X(_2346_));
 sky130_fd_sc_hd__mux4_2 _6448_ (.A0(\cpuregs[20][5] ),
    .A1(\cpuregs[21][5] ),
    .A2(\cpuregs[22][5] ),
    .A3(\cpuregs[23][5] ),
    .S0(net814),
    .S1(net810),
    .X(_2347_));
 sky130_fd_sc_hd__mux4_2 _6449_ (.A0(_2344_),
    .A1(_2345_),
    .A2(_2346_),
    .A3(_2347_),
    .S0(net805),
    .S1(net800),
    .X(_2348_));
 sky130_fd_sc_hd__mux4_2 _6450_ (.A0(\cpuregs[8][5] ),
    .A1(\cpuregs[9][5] ),
    .A2(\cpuregs[10][5] ),
    .A3(\cpuregs[11][5] ),
    .S0(net814),
    .S1(net810),
    .X(_2349_));
 sky130_fd_sc_hd__mux4_2 _6451_ (.A0(\cpuregs[12][5] ),
    .A1(\cpuregs[13][5] ),
    .A2(\cpuregs[14][5] ),
    .A3(\cpuregs[15][5] ),
    .S0(net814),
    .S1(net810),
    .X(_2350_));
 sky130_fd_sc_hd__mux4_2 _6452_ (.A0(\cpuregs[24][5] ),
    .A1(\cpuregs[25][5] ),
    .A2(\cpuregs[26][5] ),
    .A3(\cpuregs[27][5] ),
    .S0(net814),
    .S1(net810),
    .X(_2351_));
 sky130_fd_sc_hd__mux4_2 _6453_ (.A0(\cpuregs[28][5] ),
    .A1(\cpuregs[29][5] ),
    .A2(\cpuregs[30][5] ),
    .A3(\cpuregs[31][5] ),
    .S0(net814),
    .S1(net810),
    .X(_2352_));
 sky130_fd_sc_hd__mux4_2 _6454_ (.A0(_2349_),
    .A1(_2350_),
    .A2(_2351_),
    .A3(_2352_),
    .S0(net805),
    .S1(net800),
    .X(_2353_));
 sky130_fd_sc_hd__mux2i_1 _6455_ (.A0(_2348_),
    .A1(_2353_),
    .S(_0044_),
    .Y(_2354_));
 sky130_fd_sc_hd__nor2_1 _6456_ (.A(net707),
    .B(_2354_),
    .Y(_2355_));
 sky130_fd_sc_hd__a21oi_1 _6457_ (.A1(\reg_pc[5] ),
    .A2(net722),
    .B1(_2355_),
    .Y(_2356_));
 sky130_fd_sc_hd__xnor2_1 _6458_ (.A(_2279_),
    .B(_2304_),
    .Y(_2357_));
 sky130_fd_sc_hd__a211oi_1 _6459_ (.A1(_0061_),
    .A2(net720),
    .B1(net696),
    .C1(_2298_),
    .Y(_2358_));
 sky130_fd_sc_hd__inv_1 _6460_ (.A(net336),
    .Y(_0401_));
 sky130_fd_sc_hd__a211oi_1 _6461_ (.A1(_0401_),
    .A2(net708),
    .B1(net697),
    .C1(_2300_),
    .Y(_2359_));
 sky130_fd_sc_hd__o21ai_0 _6462_ (.A1(_2358_),
    .A2(_2359_),
    .B1(net774),
    .Y(_2360_));
 sky130_fd_sc_hd__o221ai_1 _6463_ (.A1(net719),
    .A2(_2356_),
    .B1(_2357_),
    .B2(net724),
    .C1(_2360_),
    .Y(_4676_));
 sky130_fd_sc_hd__mux4_2 _6464_ (.A0(\cpuregs[0][4] ),
    .A1(\cpuregs[1][4] ),
    .A2(\cpuregs[2][4] ),
    .A3(\cpuregs[3][4] ),
    .S0(net815),
    .S1(net807),
    .X(_2361_));
 sky130_fd_sc_hd__mux4_2 _6465_ (.A0(\cpuregs[4][4] ),
    .A1(\cpuregs[5][4] ),
    .A2(\cpuregs[6][4] ),
    .A3(\cpuregs[7][4] ),
    .S0(net815),
    .S1(net807),
    .X(_2362_));
 sky130_fd_sc_hd__mux4_2 _6466_ (.A0(\cpuregs[16][4] ),
    .A1(\cpuregs[17][4] ),
    .A2(\cpuregs[18][4] ),
    .A3(\cpuregs[19][4] ),
    .S0(net816),
    .S1(net806),
    .X(_2363_));
 sky130_fd_sc_hd__mux4_2 _6467_ (.A0(\cpuregs[20][4] ),
    .A1(\cpuregs[21][4] ),
    .A2(\cpuregs[22][4] ),
    .A3(\cpuregs[23][4] ),
    .S0(net816),
    .S1(net806),
    .X(_2364_));
 sky130_fd_sc_hd__mux4_2 _6468_ (.A0(_2361_),
    .A1(_2362_),
    .A2(_2363_),
    .A3(_2364_),
    .S0(net804),
    .S1(net801),
    .X(_2365_));
 sky130_fd_sc_hd__mux4_2 _6469_ (.A0(\cpuregs[8][4] ),
    .A1(\cpuregs[9][4] ),
    .A2(\cpuregs[10][4] ),
    .A3(\cpuregs[11][4] ),
    .S0(net815),
    .S1(net807),
    .X(_2366_));
 sky130_fd_sc_hd__mux4_2 _6470_ (.A0(\cpuregs[12][4] ),
    .A1(\cpuregs[13][4] ),
    .A2(\cpuregs[14][4] ),
    .A3(\cpuregs[15][4] ),
    .S0(net815),
    .S1(net807),
    .X(_2367_));
 sky130_fd_sc_hd__mux4_2 _6471_ (.A0(\cpuregs[24][4] ),
    .A1(\cpuregs[25][4] ),
    .A2(\cpuregs[26][4] ),
    .A3(\cpuregs[27][4] ),
    .S0(net816),
    .S1(net806),
    .X(_2368_));
 sky130_fd_sc_hd__mux4_2 _6472_ (.A0(\cpuregs[28][4] ),
    .A1(\cpuregs[29][4] ),
    .A2(\cpuregs[30][4] ),
    .A3(\cpuregs[31][4] ),
    .S0(net816),
    .S1(net806),
    .X(_2369_));
 sky130_fd_sc_hd__mux4_2 _6473_ (.A0(_2366_),
    .A1(_2367_),
    .A2(_2368_),
    .A3(_2369_),
    .S0(net804),
    .S1(net801),
    .X(_2370_));
 sky130_fd_sc_hd__mux2i_1 _6474_ (.A0(_2365_),
    .A1(_2370_),
    .S(net802),
    .Y(_2371_));
 sky130_fd_sc_hd__nor2_1 _6475_ (.A(net707),
    .B(_2371_),
    .Y(_2372_));
 sky130_fd_sc_hd__a21oi_1 _6476_ (.A1(\reg_pc[4] ),
    .A2(net722),
    .B1(_2372_),
    .Y(_2373_));
 sky130_fd_sc_hd__xnor2_1 _6477_ (.A(_0188_),
    .B(_1622_),
    .Y(_2374_));
 sky130_fd_sc_hd__a211oi_1 _6478_ (.A1(_0445_),
    .A2(net720),
    .B1(net696),
    .C1(_2321_),
    .Y(_2375_));
 sky130_fd_sc_hd__inv_1 _6479_ (.A(net335),
    .Y(_0407_));
 sky130_fd_sc_hd__a211oi_1 _6480_ (.A1(_0407_),
    .A2(net708),
    .B1(net697),
    .C1(_2323_),
    .Y(_2376_));
 sky130_fd_sc_hd__o21ai_0 _6481_ (.A1(_2375_),
    .A2(_2376_),
    .B1(net774),
    .Y(_2377_));
 sky130_fd_sc_hd__o221ai_1 _6482_ (.A1(net719),
    .A2(_2373_),
    .B1(_2374_),
    .B2(net724),
    .C1(_2377_),
    .Y(_4675_));
 sky130_fd_sc_hd__mux4_2 _6483_ (.A0(\cpuregs[0][3] ),
    .A1(\cpuregs[1][3] ),
    .A2(\cpuregs[2][3] ),
    .A3(\cpuregs[3][3] ),
    .S0(net813),
    .S1(net806),
    .X(_2378_));
 sky130_fd_sc_hd__mux4_2 _6484_ (.A0(\cpuregs[4][3] ),
    .A1(\cpuregs[5][3] ),
    .A2(\cpuregs[6][3] ),
    .A3(\cpuregs[7][3] ),
    .S0(net813),
    .S1(net812),
    .X(_2379_));
 sky130_fd_sc_hd__mux4_2 _6485_ (.A0(\cpuregs[16][3] ),
    .A1(\cpuregs[17][3] ),
    .A2(\cpuregs[18][3] ),
    .A3(\cpuregs[19][3] ),
    .S0(net813),
    .S1(net806),
    .X(_2380_));
 sky130_fd_sc_hd__mux4_2 _6486_ (.A0(\cpuregs[20][3] ),
    .A1(\cpuregs[21][3] ),
    .A2(\cpuregs[22][3] ),
    .A3(\cpuregs[23][3] ),
    .S0(net813),
    .S1(net806),
    .X(_2381_));
 sky130_fd_sc_hd__mux4_2 _6487_ (.A0(_2378_),
    .A1(_2379_),
    .A2(_2380_),
    .A3(_2381_),
    .S0(net804),
    .S1(net801),
    .X(_2382_));
 sky130_fd_sc_hd__mux4_2 _6488_ (.A0(\cpuregs[8][3] ),
    .A1(\cpuregs[9][3] ),
    .A2(\cpuregs[10][3] ),
    .A3(\cpuregs[11][3] ),
    .S0(net820),
    .S1(net806),
    .X(_2383_));
 sky130_fd_sc_hd__mux4_2 _6489_ (.A0(\cpuregs[12][3] ),
    .A1(\cpuregs[13][3] ),
    .A2(\cpuregs[14][3] ),
    .A3(\cpuregs[15][3] ),
    .S0(net820),
    .S1(net806),
    .X(_2384_));
 sky130_fd_sc_hd__mux4_2 _6490_ (.A0(\cpuregs[24][3] ),
    .A1(\cpuregs[25][3] ),
    .A2(\cpuregs[26][3] ),
    .A3(\cpuregs[27][3] ),
    .S0(net820),
    .S1(net806),
    .X(_2385_));
 sky130_fd_sc_hd__mux4_2 _6491_ (.A0(\cpuregs[28][3] ),
    .A1(\cpuregs[29][3] ),
    .A2(\cpuregs[30][3] ),
    .A3(\cpuregs[31][3] ),
    .S0(net813),
    .S1(net806),
    .X(_2386_));
 sky130_fd_sc_hd__mux4_2 _6492_ (.A0(_2383_),
    .A1(_2384_),
    .A2(_2385_),
    .A3(_2386_),
    .S0(net804),
    .S1(net801),
    .X(_2387_));
 sky130_fd_sc_hd__mux2i_1 _6493_ (.A0(_2382_),
    .A1(_2387_),
    .S(net802),
    .Y(_2388_));
 sky130_fd_sc_hd__nor2_1 _6494_ (.A(net707),
    .B(_2388_),
    .Y(_2389_));
 sky130_fd_sc_hd__a21oi_1 _6495_ (.A1(\reg_pc[3] ),
    .A2(net722),
    .B1(_2389_),
    .Y(_2390_));
 sky130_fd_sc_hd__mux2i_1 _6496_ (.A0(net334),
    .A1(net330),
    .S(net720),
    .Y(_2391_));
 sky130_fd_sc_hd__nor2_1 _6497_ (.A(net720),
    .B(net696),
    .Y(_2392_));
 sky130_fd_sc_hd__nand2_1 _6498_ (.A(net738),
    .B(_2392_),
    .Y(_2393_));
 sky130_fd_sc_hd__o21ai_0 _6499_ (.A1(net697),
    .A2(_2391_),
    .B1(_2393_),
    .Y(_2394_));
 sky130_fd_sc_hd__xnor2_1 _6500_ (.A(_0186_),
    .B(_1737_),
    .Y(_2395_));
 sky130_fd_sc_hd__a22oi_1 _6501_ (.A1(net774),
    .A2(_2394_),
    .B1(_2395_),
    .B2(net721),
    .Y(_2396_));
 sky130_fd_sc_hd__o21ai_0 _6502_ (.A1(net719),
    .A2(_2390_),
    .B1(_2396_),
    .Y(_4674_));
 sky130_fd_sc_hd__mux4_2 _6503_ (.A0(\cpuregs[0][2] ),
    .A1(\cpuregs[1][2] ),
    .A2(\cpuregs[2][2] ),
    .A3(\cpuregs[3][2] ),
    .S0(net813),
    .S1(net806),
    .X(_2397_));
 sky130_fd_sc_hd__mux4_2 _6504_ (.A0(\cpuregs[4][2] ),
    .A1(\cpuregs[5][2] ),
    .A2(\cpuregs[6][2] ),
    .A3(\cpuregs[7][2] ),
    .S0(net813),
    .S1(net812),
    .X(_2398_));
 sky130_fd_sc_hd__mux4_2 _6505_ (.A0(\cpuregs[16][2] ),
    .A1(\cpuregs[17][2] ),
    .A2(\cpuregs[18][2] ),
    .A3(\cpuregs[19][2] ),
    .S0(net813),
    .S1(net806),
    .X(_2399_));
 sky130_fd_sc_hd__mux4_2 _6506_ (.A0(\cpuregs[20][2] ),
    .A1(\cpuregs[21][2] ),
    .A2(\cpuregs[22][2] ),
    .A3(\cpuregs[23][2] ),
    .S0(net813),
    .S1(net812),
    .X(_2400_));
 sky130_fd_sc_hd__mux4_2 _6507_ (.A0(_2397_),
    .A1(_2398_),
    .A2(_2399_),
    .A3(_2400_),
    .S0(net804),
    .S1(net801),
    .X(_2401_));
 sky130_fd_sc_hd__mux4_2 _6508_ (.A0(\cpuregs[8][2] ),
    .A1(\cpuregs[9][2] ),
    .A2(\cpuregs[10][2] ),
    .A3(\cpuregs[11][2] ),
    .S0(net820),
    .S1(net806),
    .X(_2402_));
 sky130_fd_sc_hd__mux4_2 _6509_ (.A0(\cpuregs[12][2] ),
    .A1(\cpuregs[13][2] ),
    .A2(\cpuregs[14][2] ),
    .A3(\cpuregs[15][2] ),
    .S0(net820),
    .S1(net806),
    .X(_2403_));
 sky130_fd_sc_hd__mux4_2 _6510_ (.A0(\cpuregs[24][2] ),
    .A1(\cpuregs[25][2] ),
    .A2(\cpuregs[26][2] ),
    .A3(\cpuregs[27][2] ),
    .S0(net820),
    .S1(net806),
    .X(_2404_));
 sky130_fd_sc_hd__mux4_2 _6511_ (.A0(\cpuregs[28][2] ),
    .A1(\cpuregs[29][2] ),
    .A2(\cpuregs[30][2] ),
    .A3(\cpuregs[31][2] ),
    .S0(net813),
    .S1(net806),
    .X(_2405_));
 sky130_fd_sc_hd__mux4_2 _6512_ (.A0(_2402_),
    .A1(_2403_),
    .A2(_2404_),
    .A3(_2405_),
    .S0(net804),
    .S1(net801),
    .X(_2406_));
 sky130_fd_sc_hd__mux2i_1 _6513_ (.A0(_2401_),
    .A1(_2406_),
    .S(net802),
    .Y(_2407_));
 sky130_fd_sc_hd__nor2_1 _6514_ (.A(net707),
    .B(_2407_),
    .Y(_2408_));
 sky130_fd_sc_hd__a21oi_1 _6515_ (.A1(\reg_pc[2] ),
    .A2(net722),
    .B1(_2408_),
    .Y(_2409_));
 sky130_fd_sc_hd__mux2i_1 _6517_ (.A0(net740),
    .A1(net753),
    .S(net720),
    .Y(_2411_));
 sky130_fd_sc_hd__nand2_1 _6518_ (.A(net739),
    .B(_2392_),
    .Y(_2412_));
 sky130_fd_sc_hd__o21ai_0 _6519_ (.A1(net697),
    .A2(_2411_),
    .B1(_2412_),
    .Y(_2413_));
 sky130_fd_sc_hd__xor2_1 _6520_ (.A(_0190_),
    .B(_0059_),
    .X(_2414_));
 sky130_fd_sc_hd__a22oi_1 _6521_ (.A1(net774),
    .A2(_2413_),
    .B1(_2414_),
    .B2(net721),
    .Y(_2415_));
 sky130_fd_sc_hd__o21ai_0 _6522_ (.A1(net719),
    .A2(_2409_),
    .B1(_2415_),
    .Y(_4671_));
 sky130_fd_sc_hd__mux4_2 _6523_ (.A0(\cpuregs[0][1] ),
    .A1(\cpuregs[1][1] ),
    .A2(\cpuregs[2][1] ),
    .A3(\cpuregs[3][1] ),
    .S0(net813),
    .S1(net812),
    .X(_2416_));
 sky130_fd_sc_hd__mux4_2 _6524_ (.A0(\cpuregs[4][1] ),
    .A1(\cpuregs[5][1] ),
    .A2(\cpuregs[6][1] ),
    .A3(\cpuregs[7][1] ),
    .S0(net813),
    .S1(net812),
    .X(_2417_));
 sky130_fd_sc_hd__mux4_2 _6525_ (.A0(\cpuregs[16][1] ),
    .A1(\cpuregs[17][1] ),
    .A2(\cpuregs[18][1] ),
    .A3(\cpuregs[19][1] ),
    .S0(net813),
    .S1(net806),
    .X(_2418_));
 sky130_fd_sc_hd__mux4_2 _6526_ (.A0(\cpuregs[20][1] ),
    .A1(\cpuregs[21][1] ),
    .A2(\cpuregs[22][1] ),
    .A3(\cpuregs[23][1] ),
    .S0(net813),
    .S1(net812),
    .X(_2419_));
 sky130_fd_sc_hd__mux4_2 _6527_ (.A0(_2416_),
    .A1(_2417_),
    .A2(_2418_),
    .A3(_2419_),
    .S0(net804),
    .S1(net801),
    .X(_2420_));
 sky130_fd_sc_hd__mux4_2 _6528_ (.A0(\cpuregs[8][1] ),
    .A1(\cpuregs[9][1] ),
    .A2(\cpuregs[10][1] ),
    .A3(\cpuregs[11][1] ),
    .S0(net816),
    .S1(net807),
    .X(_2421_));
 sky130_fd_sc_hd__mux4_2 _6529_ (.A0(\cpuregs[12][1] ),
    .A1(\cpuregs[13][1] ),
    .A2(\cpuregs[14][1] ),
    .A3(\cpuregs[15][1] ),
    .S0(net816),
    .S1(net807),
    .X(_2422_));
 sky130_fd_sc_hd__mux4_2 _6530_ (.A0(\cpuregs[24][1] ),
    .A1(\cpuregs[25][1] ),
    .A2(\cpuregs[26][1] ),
    .A3(\cpuregs[27][1] ),
    .S0(net820),
    .S1(net806),
    .X(_2423_));
 sky130_fd_sc_hd__mux4_2 _6531_ (.A0(\cpuregs[28][1] ),
    .A1(\cpuregs[29][1] ),
    .A2(\cpuregs[30][1] ),
    .A3(\cpuregs[31][1] ),
    .S0(net813),
    .S1(net806),
    .X(_2424_));
 sky130_fd_sc_hd__mux4_2 _6532_ (.A0(_2421_),
    .A1(_2422_),
    .A2(_2423_),
    .A3(_2424_),
    .S0(net804),
    .S1(net801),
    .X(_2425_));
 sky130_fd_sc_hd__mux2i_1 _6533_ (.A0(_2420_),
    .A1(_2425_),
    .S(net802),
    .Y(_2426_));
 sky130_fd_sc_hd__nor2_1 _6534_ (.A(net707),
    .B(_2426_),
    .Y(_2427_));
 sky130_fd_sc_hd__a21oi_1 _6535_ (.A1(\reg_pc[1] ),
    .A2(net722),
    .B1(_2427_),
    .Y(_2428_));
 sky130_fd_sc_hd__mux2i_1 _6536_ (.A0(net330),
    .A1(net764),
    .S(net720),
    .Y(_2429_));
 sky130_fd_sc_hd__nand2_1 _6537_ (.A(net335),
    .B(_2392_),
    .Y(_2430_));
 sky130_fd_sc_hd__o21ai_0 _6538_ (.A1(net697),
    .A2(_2429_),
    .B1(_2430_),
    .Y(_2431_));
 sky130_fd_sc_hd__a22oi_1 _6539_ (.A1(_0060_),
    .A2(net721),
    .B1(_2431_),
    .B2(net774),
    .Y(_2432_));
 sky130_fd_sc_hd__o21ai_0 _6540_ (.A1(net719),
    .A2(_2428_),
    .B1(_2432_),
    .Y(_4660_));
 sky130_fd_sc_hd__nor2_1 _6541_ (.A(_0061_),
    .B(net697),
    .Y(_2433_));
 sky130_fd_sc_hd__a21oi_1 _6542_ (.A1(net334),
    .A2(net697),
    .B1(_2433_),
    .Y(_2434_));
 sky130_fd_sc_hd__nand2_1 _6543_ (.A(net774),
    .B(net708),
    .Y(_2435_));
 sky130_fd_sc_hd__mux4_2 _6544_ (.A0(\cpuregs[0][0] ),
    .A1(\cpuregs[1][0] ),
    .A2(\cpuregs[2][0] ),
    .A3(\cpuregs[3][0] ),
    .S0(net814),
    .S1(net811),
    .X(_2436_));
 sky130_fd_sc_hd__mux4_2 _6545_ (.A0(\cpuregs[4][0] ),
    .A1(\cpuregs[5][0] ),
    .A2(\cpuregs[6][0] ),
    .A3(\cpuregs[7][0] ),
    .S0(net813),
    .S1(net812),
    .X(_2437_));
 sky130_fd_sc_hd__mux4_2 _6546_ (.A0(\cpuregs[8][0] ),
    .A1(\cpuregs[9][0] ),
    .A2(\cpuregs[10][0] ),
    .A3(\cpuregs[11][0] ),
    .S0(net814),
    .S1(net811),
    .X(_2438_));
 sky130_fd_sc_hd__mux4_2 _6547_ (.A0(\cpuregs[12][0] ),
    .A1(\cpuregs[13][0] ),
    .A2(\cpuregs[14][0] ),
    .A3(\cpuregs[15][0] ),
    .S0(net814),
    .S1(net811),
    .X(_2439_));
 sky130_fd_sc_hd__mux4_2 _6548_ (.A0(_2436_),
    .A1(_2437_),
    .A2(_2438_),
    .A3(_2439_),
    .S0(net803),
    .S1(net802),
    .X(_2440_));
 sky130_fd_sc_hd__mux4_2 _6549_ (.A0(\cpuregs[16][0] ),
    .A1(\cpuregs[17][0] ),
    .A2(\cpuregs[18][0] ),
    .A3(\cpuregs[19][0] ),
    .S0(net813),
    .S1(net806),
    .X(_2441_));
 sky130_fd_sc_hd__mux4_2 _6550_ (.A0(\cpuregs[20][0] ),
    .A1(\cpuregs[21][0] ),
    .A2(\cpuregs[22][0] ),
    .A3(\cpuregs[23][0] ),
    .S0(net813),
    .S1(net812),
    .X(_2442_));
 sky130_fd_sc_hd__mux4_2 _6551_ (.A0(\cpuregs[24][0] ),
    .A1(\cpuregs[25][0] ),
    .A2(\cpuregs[26][0] ),
    .A3(\cpuregs[27][0] ),
    .S0(net820),
    .S1(net806),
    .X(_2443_));
 sky130_fd_sc_hd__mux4_2 _6552_ (.A0(\cpuregs[28][0] ),
    .A1(\cpuregs[29][0] ),
    .A2(\cpuregs[30][0] ),
    .A3(\cpuregs[31][0] ),
    .S0(net813),
    .S1(net806),
    .X(_2444_));
 sky130_fd_sc_hd__mux4_2 _6553_ (.A0(_2441_),
    .A1(_2442_),
    .A2(_2443_),
    .A3(_2444_),
    .S0(net804),
    .S1(net802),
    .X(_2445_));
 sky130_fd_sc_hd__mux2i_1 _6554_ (.A0(_2440_),
    .A1(_2445_),
    .S(net800),
    .Y(_2446_));
 sky130_fd_sc_hd__nor3_1 _6555_ (.A(net707),
    .B(net719),
    .C(_2446_),
    .Y(_2447_));
 sky130_fd_sc_hd__a21oi_1 _6556_ (.A1(_0191_),
    .A2(net721),
    .B1(_2447_),
    .Y(_2448_));
 sky130_fd_sc_hd__o21ai_0 _6557_ (.A1(_2434_),
    .A2(_2435_),
    .B1(_2448_),
    .Y(_4649_));
 sky130_fd_sc_hd__mux4_2 _6565_ (.A0(\cpuregs[0][30] ),
    .A1(\cpuregs[1][30] ),
    .A2(\cpuregs[2][30] ),
    .A3(\cpuregs[3][30] ),
    .S0(net792),
    .S1(net785),
    .X(_2456_));
 sky130_fd_sc_hd__mux4_2 _6569_ (.A0(\cpuregs[8][30] ),
    .A1(\cpuregs[9][30] ),
    .A2(\cpuregs[10][30] ),
    .A3(\cpuregs[11][30] ),
    .S0(net792),
    .S1(net785),
    .X(_2460_));
 sky130_fd_sc_hd__mux4_2 _6570_ (.A0(\cpuregs[4][30] ),
    .A1(\cpuregs[5][30] ),
    .A2(\cpuregs[6][30] ),
    .A3(\cpuregs[7][30] ),
    .S0(net799),
    .S1(net788),
    .X(_2461_));
 sky130_fd_sc_hd__mux4_2 _6576_ (.A0(\cpuregs[12][30] ),
    .A1(\cpuregs[13][30] ),
    .A2(\cpuregs[14][30] ),
    .A3(\cpuregs[15][30] ),
    .S0(net792),
    .S1(net785),
    .X(_2467_));
 sky130_fd_sc_hd__mux4_2 _6581_ (.A0(_2456_),
    .A1(_2460_),
    .A2(_2461_),
    .A3(_2467_),
    .S0(net781),
    .S1(net783),
    .X(_2472_));
 sky130_fd_sc_hd__mux4_2 _6582_ (.A0(\cpuregs[16][30] ),
    .A1(\cpuregs[17][30] ),
    .A2(\cpuregs[18][30] ),
    .A3(\cpuregs[19][30] ),
    .S0(net799),
    .S1(net788),
    .X(_2473_));
 sky130_fd_sc_hd__mux4_2 _6583_ (.A0(\cpuregs[24][30] ),
    .A1(\cpuregs[25][30] ),
    .A2(\cpuregs[26][30] ),
    .A3(\cpuregs[27][30] ),
    .S0(net798),
    .S1(net787),
    .X(_2474_));
 sky130_fd_sc_hd__mux4_2 _6584_ (.A0(\cpuregs[20][30] ),
    .A1(\cpuregs[21][30] ),
    .A2(\cpuregs[22][30] ),
    .A3(\cpuregs[23][30] ),
    .S0(net792),
    .S1(net785),
    .X(_2475_));
 sky130_fd_sc_hd__mux4_2 _6585_ (.A0(\cpuregs[28][30] ),
    .A1(\cpuregs[29][30] ),
    .A2(\cpuregs[30][30] ),
    .A3(\cpuregs[31][30] ),
    .S0(net799),
    .S1(net788),
    .X(_2476_));
 sky130_fd_sc_hd__mux4_2 _6586_ (.A0(_2473_),
    .A1(_2474_),
    .A2(_2475_),
    .A3(_2476_),
    .S0(net781),
    .S1(net783),
    .X(_2477_));
 sky130_fd_sc_hd__mux2i_1 _6589_ (.A0(_2472_),
    .A1(_2477_),
    .S(net780),
    .Y(_2480_));
 sky130_fd_sc_hd__nor2_1 _6590_ (.A(is_lui_auipc_jal),
    .B(is_jalr_addi_slti_sltiu_xori_ori_andi),
    .Y(_2481_));
 sky130_fd_sc_hd__nor2_1 _6591_ (.A(\decoded_imm_j[2] ),
    .B(\decoded_imm_j[1] ),
    .Y(_2482_));
 sky130_fd_sc_hd__nor3_1 _6592_ (.A(\decoded_imm_j[11] ),
    .B(\decoded_imm_j[4] ),
    .C(\decoded_imm_j[3] ),
    .Y(_2483_));
 sky130_fd_sc_hd__nand2_1 _6593_ (.A(_2482_),
    .B(_2483_),
    .Y(_2484_));
 sky130_fd_sc_hd__nand2_2 _6594_ (.A(_2481_),
    .B(_2484_),
    .Y(_2485_));
 sky130_fd_sc_hd__or2_2 _6596_ (.A(is_lui_auipc_jal),
    .B(is_jalr_addi_slti_sltiu_xori_ori_andi),
    .X(_2487_));
 sky130_fd_sc_hd__nand2_1 _6599_ (.A(\decoded_imm[30] ),
    .B(net718),
    .Y(_2490_));
 sky130_fd_sc_hd__o21ai_0 _6600_ (.A1(_2480_),
    .A2(_2485_),
    .B1(_2490_),
    .Y(_4640_));
 sky130_fd_sc_hd__mux4_2 _6603_ (.A0(\cpuregs[0][29] ),
    .A1(\cpuregs[1][29] ),
    .A2(\cpuregs[2][29] ),
    .A3(\cpuregs[3][29] ),
    .S0(net792),
    .S1(net785),
    .X(_2493_));
 sky130_fd_sc_hd__mux4_2 _6606_ (.A0(\cpuregs[8][29] ),
    .A1(\cpuregs[9][29] ),
    .A2(\cpuregs[10][29] ),
    .A3(\cpuregs[11][29] ),
    .S0(net792),
    .S1(net785),
    .X(_2496_));
 sky130_fd_sc_hd__mux4_2 _6609_ (.A0(\cpuregs[4][29] ),
    .A1(\cpuregs[5][29] ),
    .A2(\cpuregs[6][29] ),
    .A3(\cpuregs[7][29] ),
    .S0(net792),
    .S1(net785),
    .X(_2499_));
 sky130_fd_sc_hd__mux4_2 _6612_ (.A0(\cpuregs[12][29] ),
    .A1(\cpuregs[13][29] ),
    .A2(\cpuregs[14][29] ),
    .A3(\cpuregs[15][29] ),
    .S0(net792),
    .S1(net785),
    .X(_2502_));
 sky130_fd_sc_hd__mux4_2 _6615_ (.A0(_2493_),
    .A1(_2496_),
    .A2(_2499_),
    .A3(_2502_),
    .S0(net781),
    .S1(net783),
    .X(_2505_));
 sky130_fd_sc_hd__mux4_2 _6618_ (.A0(\cpuregs[16][29] ),
    .A1(\cpuregs[17][29] ),
    .A2(\cpuregs[18][29] ),
    .A3(\cpuregs[19][29] ),
    .S0(net799),
    .S1(net788),
    .X(_2508_));
 sky130_fd_sc_hd__mux4_2 _6619_ (.A0(\cpuregs[24][29] ),
    .A1(\cpuregs[25][29] ),
    .A2(\cpuregs[26][29] ),
    .A3(\cpuregs[27][29] ),
    .S0(net798),
    .S1(net787),
    .X(_2509_));
 sky130_fd_sc_hd__mux4_2 _6620_ (.A0(\cpuregs[20][29] ),
    .A1(\cpuregs[21][29] ),
    .A2(\cpuregs[22][29] ),
    .A3(\cpuregs[23][29] ),
    .S0(net792),
    .S1(net785),
    .X(_2510_));
 sky130_fd_sc_hd__mux4_2 _6623_ (.A0(\cpuregs[28][29] ),
    .A1(\cpuregs[29][29] ),
    .A2(\cpuregs[30][29] ),
    .A3(\cpuregs[31][29] ),
    .S0(net799),
    .S1(net788),
    .X(_2513_));
 sky130_fd_sc_hd__mux4_2 _6626_ (.A0(_2508_),
    .A1(_2509_),
    .A2(_2510_),
    .A3(_2513_),
    .S0(net781),
    .S1(net783),
    .X(_2516_));
 sky130_fd_sc_hd__mux2i_1 _6628_ (.A0(_2505_),
    .A1(_2516_),
    .S(net780),
    .Y(_2518_));
 sky130_fd_sc_hd__nand2_1 _6629_ (.A(\decoded_imm[29] ),
    .B(net718),
    .Y(_2519_));
 sky130_fd_sc_hd__o21ai_0 _6630_ (.A1(_2485_),
    .A2(_2518_),
    .B1(_2519_),
    .Y(_4638_));
 sky130_fd_sc_hd__mux4_2 _6631_ (.A0(\cpuregs[0][28] ),
    .A1(\cpuregs[1][28] ),
    .A2(\cpuregs[2][28] ),
    .A3(\cpuregs[3][28] ),
    .S0(_0046_),
    .S1(net788),
    .X(_2520_));
 sky130_fd_sc_hd__mux4_2 _6632_ (.A0(\cpuregs[8][28] ),
    .A1(\cpuregs[9][28] ),
    .A2(\cpuregs[10][28] ),
    .A3(\cpuregs[11][28] ),
    .S0(_0046_),
    .S1(net788),
    .X(_2521_));
 sky130_fd_sc_hd__mux4_2 _6633_ (.A0(\cpuregs[4][28] ),
    .A1(\cpuregs[5][28] ),
    .A2(\cpuregs[6][28] ),
    .A3(\cpuregs[7][28] ),
    .S0(net794),
    .S1(net791),
    .X(_2522_));
 sky130_fd_sc_hd__mux4_2 _6634_ (.A0(\cpuregs[12][28] ),
    .A1(\cpuregs[13][28] ),
    .A2(\cpuregs[14][28] ),
    .A3(\cpuregs[15][28] ),
    .S0(net797),
    .S1(net788),
    .X(_2523_));
 sky130_fd_sc_hd__mux4_2 _6635_ (.A0(_2520_),
    .A1(_2521_),
    .A2(_2522_),
    .A3(_2523_),
    .S0(net781),
    .S1(net784),
    .X(_2524_));
 sky130_fd_sc_hd__mux4_2 _6636_ (.A0(\cpuregs[16][28] ),
    .A1(\cpuregs[17][28] ),
    .A2(\cpuregs[18][28] ),
    .A3(\cpuregs[19][28] ),
    .S0(_0046_),
    .S1(net785),
    .X(_2525_));
 sky130_fd_sc_hd__mux4_2 _6637_ (.A0(\cpuregs[24][28] ),
    .A1(\cpuregs[25][28] ),
    .A2(\cpuregs[26][28] ),
    .A3(\cpuregs[27][28] ),
    .S0(net796),
    .S1(net788),
    .X(_2526_));
 sky130_fd_sc_hd__mux4_2 _6638_ (.A0(\cpuregs[20][28] ),
    .A1(\cpuregs[21][28] ),
    .A2(\cpuregs[22][28] ),
    .A3(\cpuregs[23][28] ),
    .S0(net794),
    .S1(net785),
    .X(_2527_));
 sky130_fd_sc_hd__mux4_2 _6639_ (.A0(\cpuregs[28][28] ),
    .A1(\cpuregs[29][28] ),
    .A2(\cpuregs[30][28] ),
    .A3(\cpuregs[31][28] ),
    .S0(_0046_),
    .S1(net788),
    .X(_2528_));
 sky130_fd_sc_hd__mux4_2 _6640_ (.A0(_2525_),
    .A1(_2526_),
    .A2(_2527_),
    .A3(_2528_),
    .S0(net781),
    .S1(net784),
    .X(_2529_));
 sky130_fd_sc_hd__mux2i_1 _6641_ (.A0(_2524_),
    .A1(_2529_),
    .S(net780),
    .Y(_2530_));
 sky130_fd_sc_hd__nand2_1 _6642_ (.A(\decoded_imm[28] ),
    .B(net718),
    .Y(_2531_));
 sky130_fd_sc_hd__o21ai_0 _6643_ (.A1(_2485_),
    .A2(_2530_),
    .B1(_2531_),
    .Y(_4637_));
 sky130_fd_sc_hd__mux4_2 _6644_ (.A0(\cpuregs[0][27] ),
    .A1(\cpuregs[1][27] ),
    .A2(\cpuregs[2][27] ),
    .A3(\cpuregs[3][27] ),
    .S0(net794),
    .S1(net791),
    .X(_2532_));
 sky130_fd_sc_hd__mux4_2 _6645_ (.A0(\cpuregs[8][27] ),
    .A1(\cpuregs[9][27] ),
    .A2(\cpuregs[10][27] ),
    .A3(\cpuregs[11][27] ),
    .S0(net796),
    .S1(net788),
    .X(_2533_));
 sky130_fd_sc_hd__mux4_2 _6648_ (.A0(\cpuregs[4][27] ),
    .A1(\cpuregs[5][27] ),
    .A2(\cpuregs[6][27] ),
    .A3(\cpuregs[7][27] ),
    .S0(net794),
    .S1(net791),
    .X(_2536_));
 sky130_fd_sc_hd__mux4_2 _6649_ (.A0(\cpuregs[12][27] ),
    .A1(\cpuregs[13][27] ),
    .A2(\cpuregs[14][27] ),
    .A3(\cpuregs[15][27] ),
    .S0(net797),
    .S1(net786),
    .X(_2537_));
 sky130_fd_sc_hd__mux4_2 _6650_ (.A0(_2532_),
    .A1(_2533_),
    .A2(_2536_),
    .A3(_2537_),
    .S0(net781),
    .S1(net784),
    .X(_2538_));
 sky130_fd_sc_hd__mux4_2 _6651_ (.A0(\cpuregs[16][27] ),
    .A1(\cpuregs[17][27] ),
    .A2(\cpuregs[18][27] ),
    .A3(\cpuregs[19][27] ),
    .S0(net794),
    .S1(net790),
    .X(_2539_));
 sky130_fd_sc_hd__mux4_2 _6652_ (.A0(\cpuregs[24][27] ),
    .A1(\cpuregs[25][27] ),
    .A2(\cpuregs[26][27] ),
    .A3(\cpuregs[27][27] ),
    .S0(net796),
    .S1(net790),
    .X(_2540_));
 sky130_fd_sc_hd__mux4_2 _6653_ (.A0(\cpuregs[20][27] ),
    .A1(\cpuregs[21][27] ),
    .A2(\cpuregs[22][27] ),
    .A3(\cpuregs[23][27] ),
    .S0(net794),
    .S1(net791),
    .X(_2541_));
 sky130_fd_sc_hd__mux4_2 _6654_ (.A0(\cpuregs[28][27] ),
    .A1(\cpuregs[29][27] ),
    .A2(\cpuregs[30][27] ),
    .A3(\cpuregs[31][27] ),
    .S0(net794),
    .S1(net790),
    .X(_2542_));
 sky130_fd_sc_hd__mux4_2 _6655_ (.A0(_2539_),
    .A1(_2540_),
    .A2(_2541_),
    .A3(_2542_),
    .S0(net782),
    .S1(net784),
    .X(_2543_));
 sky130_fd_sc_hd__mux2i_1 _6656_ (.A0(_2538_),
    .A1(_2543_),
    .S(net780),
    .Y(_2544_));
 sky130_fd_sc_hd__nand2_1 _6657_ (.A(\decoded_imm[27] ),
    .B(net718),
    .Y(_2545_));
 sky130_fd_sc_hd__o21ai_0 _6658_ (.A1(_2485_),
    .A2(_2544_),
    .B1(_2545_),
    .Y(_4636_));
 sky130_fd_sc_hd__mux4_2 _6659_ (.A0(\cpuregs[0][26] ),
    .A1(\cpuregs[1][26] ),
    .A2(\cpuregs[2][26] ),
    .A3(\cpuregs[3][26] ),
    .S0(_0046_),
    .S1(net785),
    .X(_2546_));
 sky130_fd_sc_hd__mux4_2 _6662_ (.A0(\cpuregs[8][26] ),
    .A1(\cpuregs[9][26] ),
    .A2(\cpuregs[10][26] ),
    .A3(\cpuregs[11][26] ),
    .S0(net793),
    .S1(net785),
    .X(_2549_));
 sky130_fd_sc_hd__mux4_2 _6663_ (.A0(\cpuregs[4][26] ),
    .A1(\cpuregs[5][26] ),
    .A2(\cpuregs[6][26] ),
    .A3(\cpuregs[7][26] ),
    .S0(net794),
    .S1(net791),
    .X(_2550_));
 sky130_fd_sc_hd__mux4_2 _6664_ (.A0(\cpuregs[12][26] ),
    .A1(\cpuregs[13][26] ),
    .A2(\cpuregs[14][26] ),
    .A3(\cpuregs[15][26] ),
    .S0(net793),
    .S1(net785),
    .X(_2551_));
 sky130_fd_sc_hd__mux4_2 _6665_ (.A0(_2546_),
    .A1(_2549_),
    .A2(_2550_),
    .A3(_2551_),
    .S0(net781),
    .S1(net783),
    .X(_2552_));
 sky130_fd_sc_hd__mux4_2 _6666_ (.A0(\cpuregs[16][26] ),
    .A1(\cpuregs[17][26] ),
    .A2(\cpuregs[18][26] ),
    .A3(\cpuregs[19][26] ),
    .S0(net793),
    .S1(net785),
    .X(_2553_));
 sky130_fd_sc_hd__mux4_2 _6667_ (.A0(\cpuregs[24][26] ),
    .A1(\cpuregs[25][26] ),
    .A2(\cpuregs[26][26] ),
    .A3(\cpuregs[27][26] ),
    .S0(net793),
    .S1(net785),
    .X(_2554_));
 sky130_fd_sc_hd__mux4_2 _6668_ (.A0(\cpuregs[20][26] ),
    .A1(\cpuregs[21][26] ),
    .A2(\cpuregs[22][26] ),
    .A3(\cpuregs[23][26] ),
    .S0(net793),
    .S1(net785),
    .X(_2555_));
 sky130_fd_sc_hd__mux4_2 _6669_ (.A0(\cpuregs[28][26] ),
    .A1(\cpuregs[29][26] ),
    .A2(\cpuregs[30][26] ),
    .A3(\cpuregs[31][26] ),
    .S0(net793),
    .S1(net785),
    .X(_2556_));
 sky130_fd_sc_hd__mux4_2 _6670_ (.A0(_2553_),
    .A1(_2554_),
    .A2(_2555_),
    .A3(_2556_),
    .S0(net781),
    .S1(net783),
    .X(_2557_));
 sky130_fd_sc_hd__mux2i_1 _6671_ (.A0(_2552_),
    .A1(_2557_),
    .S(net780),
    .Y(_2558_));
 sky130_fd_sc_hd__nand2_1 _6672_ (.A(\decoded_imm[26] ),
    .B(net718),
    .Y(_2559_));
 sky130_fd_sc_hd__o21ai_0 _6673_ (.A1(_2485_),
    .A2(_2558_),
    .B1(_2559_),
    .Y(_4635_));
 sky130_fd_sc_hd__mux4_2 _6674_ (.A0(\cpuregs[0][25] ),
    .A1(\cpuregs[1][25] ),
    .A2(\cpuregs[2][25] ),
    .A3(\cpuregs[3][25] ),
    .S0(net799),
    .S1(net788),
    .X(_2560_));
 sky130_fd_sc_hd__mux4_2 _6675_ (.A0(\cpuregs[8][25] ),
    .A1(\cpuregs[9][25] ),
    .A2(\cpuregs[10][25] ),
    .A3(\cpuregs[11][25] ),
    .S0(net799),
    .S1(net788),
    .X(_2561_));
 sky130_fd_sc_hd__mux4_2 _6676_ (.A0(\cpuregs[4][25] ),
    .A1(\cpuregs[5][25] ),
    .A2(\cpuregs[6][25] ),
    .A3(\cpuregs[7][25] ),
    .S0(net799),
    .S1(net788),
    .X(_2562_));
 sky130_fd_sc_hd__mux4_2 _6677_ (.A0(\cpuregs[12][25] ),
    .A1(\cpuregs[13][25] ),
    .A2(\cpuregs[14][25] ),
    .A3(\cpuregs[15][25] ),
    .S0(net799),
    .S1(net788),
    .X(_2563_));
 sky130_fd_sc_hd__mux4_2 _6678_ (.A0(_2560_),
    .A1(_2561_),
    .A2(_2562_),
    .A3(_2563_),
    .S0(net781),
    .S1(net783),
    .X(_2564_));
 sky130_fd_sc_hd__mux4_2 _6679_ (.A0(\cpuregs[16][25] ),
    .A1(\cpuregs[17][25] ),
    .A2(\cpuregs[18][25] ),
    .A3(\cpuregs[19][25] ),
    .S0(net792),
    .S1(net785),
    .X(_2565_));
 sky130_fd_sc_hd__mux4_2 _6680_ (.A0(\cpuregs[24][25] ),
    .A1(\cpuregs[25][25] ),
    .A2(\cpuregs[26][25] ),
    .A3(\cpuregs[27][25] ),
    .S0(net799),
    .S1(net788),
    .X(_2566_));
 sky130_fd_sc_hd__mux4_2 _6681_ (.A0(\cpuregs[20][25] ),
    .A1(\cpuregs[21][25] ),
    .A2(\cpuregs[22][25] ),
    .A3(\cpuregs[23][25] ),
    .S0(net792),
    .S1(net785),
    .X(_2567_));
 sky130_fd_sc_hd__mux4_2 _6684_ (.A0(\cpuregs[28][25] ),
    .A1(\cpuregs[29][25] ),
    .A2(\cpuregs[30][25] ),
    .A3(\cpuregs[31][25] ),
    .S0(net797),
    .S1(net786),
    .X(_2570_));
 sky130_fd_sc_hd__mux4_2 _6687_ (.A0(_2565_),
    .A1(_2566_),
    .A2(_2567_),
    .A3(_2570_),
    .S0(net781),
    .S1(net783),
    .X(_2573_));
 sky130_fd_sc_hd__mux2i_1 _6688_ (.A0(_2564_),
    .A1(_2573_),
    .S(net780),
    .Y(_2574_));
 sky130_fd_sc_hd__nand2_1 _6689_ (.A(\decoded_imm[25] ),
    .B(net718),
    .Y(_2575_));
 sky130_fd_sc_hd__o21ai_0 _6690_ (.A1(_2485_),
    .A2(_2574_),
    .B1(_2575_),
    .Y(_4634_));
 sky130_fd_sc_hd__mux4_2 _6691_ (.A0(\cpuregs[0][24] ),
    .A1(\cpuregs[1][24] ),
    .A2(\cpuregs[2][24] ),
    .A3(\cpuregs[3][24] ),
    .S0(net792),
    .S1(net785),
    .X(_2576_));
 sky130_fd_sc_hd__mux4_2 _6692_ (.A0(\cpuregs[8][24] ),
    .A1(\cpuregs[9][24] ),
    .A2(\cpuregs[10][24] ),
    .A3(\cpuregs[11][24] ),
    .S0(net792),
    .S1(net785),
    .X(_2577_));
 sky130_fd_sc_hd__mux4_2 _6693_ (.A0(\cpuregs[4][24] ),
    .A1(\cpuregs[5][24] ),
    .A2(\cpuregs[6][24] ),
    .A3(\cpuregs[7][24] ),
    .S0(net792),
    .S1(net785),
    .X(_2578_));
 sky130_fd_sc_hd__mux4_2 _6694_ (.A0(\cpuregs[12][24] ),
    .A1(\cpuregs[13][24] ),
    .A2(\cpuregs[14][24] ),
    .A3(\cpuregs[15][24] ),
    .S0(net792),
    .S1(net785),
    .X(_2579_));
 sky130_fd_sc_hd__mux4_2 _6695_ (.A0(_2576_),
    .A1(_2577_),
    .A2(_2578_),
    .A3(_2579_),
    .S0(net781),
    .S1(net783),
    .X(_2580_));
 sky130_fd_sc_hd__mux4_2 _6696_ (.A0(\cpuregs[16][24] ),
    .A1(\cpuregs[17][24] ),
    .A2(\cpuregs[18][24] ),
    .A3(\cpuregs[19][24] ),
    .S0(net798),
    .S1(net787),
    .X(_2581_));
 sky130_fd_sc_hd__mux4_2 _6699_ (.A0(\cpuregs[24][24] ),
    .A1(\cpuregs[25][24] ),
    .A2(\cpuregs[26][24] ),
    .A3(\cpuregs[27][24] ),
    .S0(net798),
    .S1(net787),
    .X(_2584_));
 sky130_fd_sc_hd__mux4_2 _6700_ (.A0(\cpuregs[20][24] ),
    .A1(\cpuregs[21][24] ),
    .A2(\cpuregs[22][24] ),
    .A3(\cpuregs[23][24] ),
    .S0(net798),
    .S1(net787),
    .X(_2585_));
 sky130_fd_sc_hd__mux4_2 _6701_ (.A0(\cpuregs[28][24] ),
    .A1(\cpuregs[29][24] ),
    .A2(\cpuregs[30][24] ),
    .A3(\cpuregs[31][24] ),
    .S0(net798),
    .S1(net787),
    .X(_2586_));
 sky130_fd_sc_hd__mux4_2 _6702_ (.A0(_2581_),
    .A1(_2584_),
    .A2(_2585_),
    .A3(_2586_),
    .S0(net781),
    .S1(net783),
    .X(_2587_));
 sky130_fd_sc_hd__mux2i_1 _6703_ (.A0(_2580_),
    .A1(_2587_),
    .S(net780),
    .Y(_2588_));
 sky130_fd_sc_hd__nand2_1 _6704_ (.A(\decoded_imm[24] ),
    .B(net718),
    .Y(_2589_));
 sky130_fd_sc_hd__o21ai_0 _6705_ (.A1(_2485_),
    .A2(_2588_),
    .B1(_2589_),
    .Y(_4633_));
 sky130_fd_sc_hd__mux4_2 _6706_ (.A0(\cpuregs[0][23] ),
    .A1(\cpuregs[1][23] ),
    .A2(\cpuregs[2][23] ),
    .A3(\cpuregs[3][23] ),
    .S0(net795),
    .S1(net789),
    .X(_2590_));
 sky130_fd_sc_hd__mux4_2 _6707_ (.A0(\cpuregs[8][23] ),
    .A1(\cpuregs[9][23] ),
    .A2(\cpuregs[10][23] ),
    .A3(\cpuregs[11][23] ),
    .S0(net795),
    .S1(net789),
    .X(_2591_));
 sky130_fd_sc_hd__mux4_2 _6708_ (.A0(\cpuregs[4][23] ),
    .A1(\cpuregs[5][23] ),
    .A2(\cpuregs[6][23] ),
    .A3(\cpuregs[7][23] ),
    .S0(net795),
    .S1(net789),
    .X(_2592_));
 sky130_fd_sc_hd__mux4_2 _6709_ (.A0(\cpuregs[12][23] ),
    .A1(\cpuregs[13][23] ),
    .A2(\cpuregs[14][23] ),
    .A3(\cpuregs[15][23] ),
    .S0(net795),
    .S1(net789),
    .X(_2593_));
 sky130_fd_sc_hd__mux4_2 _6710_ (.A0(_2590_),
    .A1(_2591_),
    .A2(_2592_),
    .A3(_2593_),
    .S0(net782),
    .S1(net784),
    .X(_2594_));
 sky130_fd_sc_hd__mux4_2 _6713_ (.A0(\cpuregs[16][23] ),
    .A1(\cpuregs[17][23] ),
    .A2(\cpuregs[18][23] ),
    .A3(\cpuregs[19][23] ),
    .S0(net795),
    .S1(net789),
    .X(_2597_));
 sky130_fd_sc_hd__mux4_2 _6714_ (.A0(\cpuregs[24][23] ),
    .A1(\cpuregs[25][23] ),
    .A2(\cpuregs[26][23] ),
    .A3(\cpuregs[27][23] ),
    .S0(net795),
    .S1(net789),
    .X(_2598_));
 sky130_fd_sc_hd__mux4_2 _6715_ (.A0(\cpuregs[20][23] ),
    .A1(\cpuregs[21][23] ),
    .A2(\cpuregs[22][23] ),
    .A3(\cpuregs[23][23] ),
    .S0(net795),
    .S1(net789),
    .X(_2599_));
 sky130_fd_sc_hd__mux4_2 _6716_ (.A0(\cpuregs[28][23] ),
    .A1(\cpuregs[29][23] ),
    .A2(\cpuregs[30][23] ),
    .A3(\cpuregs[31][23] ),
    .S0(net795),
    .S1(net789),
    .X(_2600_));
 sky130_fd_sc_hd__mux4_2 _6717_ (.A0(_2597_),
    .A1(_2598_),
    .A2(_2599_),
    .A3(_2600_),
    .S0(net782),
    .S1(net784),
    .X(_2601_));
 sky130_fd_sc_hd__mux2i_1 _6718_ (.A0(_2594_),
    .A1(_2601_),
    .S(net780),
    .Y(_2602_));
 sky130_fd_sc_hd__nand2_1 _6719_ (.A(\decoded_imm[23] ),
    .B(net718),
    .Y(_2603_));
 sky130_fd_sc_hd__o21ai_0 _6720_ (.A1(_2485_),
    .A2(_2602_),
    .B1(_2603_),
    .Y(_4632_));
 sky130_fd_sc_hd__mux4_2 _6721_ (.A0(\cpuregs[0][22] ),
    .A1(\cpuregs[1][22] ),
    .A2(\cpuregs[2][22] ),
    .A3(\cpuregs[3][22] ),
    .S0(net794),
    .S1(net790),
    .X(_2604_));
 sky130_fd_sc_hd__mux4_2 _6722_ (.A0(\cpuregs[8][22] ),
    .A1(\cpuregs[9][22] ),
    .A2(\cpuregs[10][22] ),
    .A3(\cpuregs[11][22] ),
    .S0(net796),
    .S1(net790),
    .X(_2605_));
 sky130_fd_sc_hd__mux4_2 _6723_ (.A0(\cpuregs[4][22] ),
    .A1(\cpuregs[5][22] ),
    .A2(\cpuregs[6][22] ),
    .A3(\cpuregs[7][22] ),
    .S0(net794),
    .S1(net791),
    .X(_2606_));
 sky130_fd_sc_hd__mux4_2 _6724_ (.A0(\cpuregs[12][22] ),
    .A1(\cpuregs[13][22] ),
    .A2(\cpuregs[14][22] ),
    .A3(\cpuregs[15][22] ),
    .S0(net796),
    .S1(net789),
    .X(_2607_));
 sky130_fd_sc_hd__mux4_2 _6725_ (.A0(_2604_),
    .A1(_2605_),
    .A2(_2606_),
    .A3(_2607_),
    .S0(net782),
    .S1(net784),
    .X(_2608_));
 sky130_fd_sc_hd__mux4_2 _6726_ (.A0(\cpuregs[16][22] ),
    .A1(\cpuregs[17][22] ),
    .A2(\cpuregs[18][22] ),
    .A3(\cpuregs[19][22] ),
    .S0(net794),
    .S1(net790),
    .X(_2609_));
 sky130_fd_sc_hd__mux4_2 _6727_ (.A0(\cpuregs[24][22] ),
    .A1(\cpuregs[25][22] ),
    .A2(\cpuregs[26][22] ),
    .A3(\cpuregs[27][22] ),
    .S0(net796),
    .S1(net790),
    .X(_2610_));
 sky130_fd_sc_hd__mux4_2 _6728_ (.A0(\cpuregs[20][22] ),
    .A1(\cpuregs[21][22] ),
    .A2(\cpuregs[22][22] ),
    .A3(\cpuregs[23][22] ),
    .S0(net794),
    .S1(net790),
    .X(_2611_));
 sky130_fd_sc_hd__mux4_2 _6729_ (.A0(\cpuregs[28][22] ),
    .A1(\cpuregs[29][22] ),
    .A2(\cpuregs[30][22] ),
    .A3(\cpuregs[31][22] ),
    .S0(net794),
    .S1(net790),
    .X(_2612_));
 sky130_fd_sc_hd__mux4_2 _6730_ (.A0(_2609_),
    .A1(_2610_),
    .A2(_2611_),
    .A3(_2612_),
    .S0(net782),
    .S1(net784),
    .X(_2613_));
 sky130_fd_sc_hd__mux2i_1 _6731_ (.A0(_2608_),
    .A1(_2613_),
    .S(net780),
    .Y(_2614_));
 sky130_fd_sc_hd__nand2_1 _6732_ (.A(\decoded_imm[22] ),
    .B(net718),
    .Y(_2615_));
 sky130_fd_sc_hd__o21ai_0 _6733_ (.A1(_2485_),
    .A2(_2614_),
    .B1(_2615_),
    .Y(_4631_));
 sky130_fd_sc_hd__mux4_2 _6736_ (.A0(\cpuregs[0][21] ),
    .A1(\cpuregs[1][21] ),
    .A2(\cpuregs[2][21] ),
    .A3(\cpuregs[3][21] ),
    .S0(net799),
    .S1(net788),
    .X(_2618_));
 sky130_fd_sc_hd__mux4_2 _6737_ (.A0(\cpuregs[8][21] ),
    .A1(\cpuregs[9][21] ),
    .A2(\cpuregs[10][21] ),
    .A3(\cpuregs[11][21] ),
    .S0(net799),
    .S1(net788),
    .X(_2619_));
 sky130_fd_sc_hd__mux4_2 _6738_ (.A0(\cpuregs[4][21] ),
    .A1(\cpuregs[5][21] ),
    .A2(\cpuregs[6][21] ),
    .A3(\cpuregs[7][21] ),
    .S0(net799),
    .S1(net788),
    .X(_2620_));
 sky130_fd_sc_hd__mux4_2 _6739_ (.A0(\cpuregs[12][21] ),
    .A1(\cpuregs[13][21] ),
    .A2(\cpuregs[14][21] ),
    .A3(\cpuregs[15][21] ),
    .S0(net799),
    .S1(net788),
    .X(_2621_));
 sky130_fd_sc_hd__mux4_2 _6740_ (.A0(_2618_),
    .A1(_2619_),
    .A2(_2620_),
    .A3(_2621_),
    .S0(net781),
    .S1(net783),
    .X(_2622_));
 sky130_fd_sc_hd__mux4_2 _6741_ (.A0(\cpuregs[16][21] ),
    .A1(\cpuregs[17][21] ),
    .A2(\cpuregs[18][21] ),
    .A3(\cpuregs[19][21] ),
    .S0(net797),
    .S1(net786),
    .X(_2623_));
 sky130_fd_sc_hd__mux4_2 _6742_ (.A0(\cpuregs[24][21] ),
    .A1(\cpuregs[25][21] ),
    .A2(\cpuregs[26][21] ),
    .A3(\cpuregs[27][21] ),
    .S0(net797),
    .S1(net786),
    .X(_2624_));
 sky130_fd_sc_hd__mux4_2 _6743_ (.A0(\cpuregs[20][21] ),
    .A1(\cpuregs[21][21] ),
    .A2(\cpuregs[22][21] ),
    .A3(\cpuregs[23][21] ),
    .S0(net797),
    .S1(net786),
    .X(_2625_));
 sky130_fd_sc_hd__mux4_2 _6744_ (.A0(\cpuregs[28][21] ),
    .A1(\cpuregs[29][21] ),
    .A2(\cpuregs[30][21] ),
    .A3(\cpuregs[31][21] ),
    .S0(net797),
    .S1(net786),
    .X(_2626_));
 sky130_fd_sc_hd__mux4_2 _6745_ (.A0(_2623_),
    .A1(_2624_),
    .A2(_2625_),
    .A3(_2626_),
    .S0(net781),
    .S1(net783),
    .X(_2627_));
 sky130_fd_sc_hd__mux2i_1 _6746_ (.A0(_2622_),
    .A1(_2627_),
    .S(net780),
    .Y(_2628_));
 sky130_fd_sc_hd__nand2_1 _6747_ (.A(\decoded_imm[21] ),
    .B(net718),
    .Y(_2629_));
 sky130_fd_sc_hd__o21ai_0 _6748_ (.A1(_2485_),
    .A2(_2628_),
    .B1(_2629_),
    .Y(_4630_));
 sky130_fd_sc_hd__mux4_2 _6750_ (.A0(\cpuregs[0][20] ),
    .A1(\cpuregs[1][20] ),
    .A2(\cpuregs[2][20] ),
    .A3(\cpuregs[3][20] ),
    .S0(net799),
    .S1(net788),
    .X(_2631_));
 sky130_fd_sc_hd__mux4_2 _6751_ (.A0(\cpuregs[8][20] ),
    .A1(\cpuregs[9][20] ),
    .A2(\cpuregs[10][20] ),
    .A3(\cpuregs[11][20] ),
    .S0(net797),
    .S1(net786),
    .X(_2632_));
 sky130_fd_sc_hd__mux4_2 _6752_ (.A0(\cpuregs[4][20] ),
    .A1(\cpuregs[5][20] ),
    .A2(\cpuregs[6][20] ),
    .A3(\cpuregs[7][20] ),
    .S0(net799),
    .S1(net788),
    .X(_2633_));
 sky130_fd_sc_hd__mux4_2 _6753_ (.A0(\cpuregs[12][20] ),
    .A1(\cpuregs[13][20] ),
    .A2(\cpuregs[14][20] ),
    .A3(\cpuregs[15][20] ),
    .S0(net797),
    .S1(net786),
    .X(_2634_));
 sky130_fd_sc_hd__mux4_2 _6754_ (.A0(_2631_),
    .A1(_2632_),
    .A2(_2633_),
    .A3(_2634_),
    .S0(net781),
    .S1(net783),
    .X(_2635_));
 sky130_fd_sc_hd__mux4_2 _6755_ (.A0(\cpuregs[16][20] ),
    .A1(\cpuregs[17][20] ),
    .A2(\cpuregs[18][20] ),
    .A3(\cpuregs[19][20] ),
    .S0(net798),
    .S1(net788),
    .X(_2636_));
 sky130_fd_sc_hd__mux4_2 _6756_ (.A0(\cpuregs[24][20] ),
    .A1(\cpuregs[25][20] ),
    .A2(\cpuregs[26][20] ),
    .A3(\cpuregs[27][20] ),
    .S0(net797),
    .S1(net786),
    .X(_2637_));
 sky130_fd_sc_hd__mux4_2 _6759_ (.A0(\cpuregs[20][20] ),
    .A1(\cpuregs[21][20] ),
    .A2(\cpuregs[22][20] ),
    .A3(\cpuregs[23][20] ),
    .S0(net799),
    .S1(net788),
    .X(_2640_));
 sky130_fd_sc_hd__mux4_2 _6760_ (.A0(\cpuregs[28][20] ),
    .A1(\cpuregs[29][20] ),
    .A2(\cpuregs[30][20] ),
    .A3(\cpuregs[31][20] ),
    .S0(net797),
    .S1(net786),
    .X(_2641_));
 sky130_fd_sc_hd__mux4_2 _6761_ (.A0(_2636_),
    .A1(_2637_),
    .A2(_2640_),
    .A3(_2641_),
    .S0(net781),
    .S1(net783),
    .X(_2642_));
 sky130_fd_sc_hd__mux2i_1 _6762_ (.A0(_2635_),
    .A1(_2642_),
    .S(net780),
    .Y(_2643_));
 sky130_fd_sc_hd__nand2_1 _6764_ (.A(\decoded_imm[20] ),
    .B(net718),
    .Y(_2645_));
 sky130_fd_sc_hd__o21ai_0 _6765_ (.A1(_2485_),
    .A2(_2643_),
    .B1(_2645_),
    .Y(_4629_));
 sky130_fd_sc_hd__mux4_2 _6766_ (.A0(\cpuregs[0][19] ),
    .A1(\cpuregs[1][19] ),
    .A2(\cpuregs[2][19] ),
    .A3(\cpuregs[3][19] ),
    .S0(net796),
    .S1(net789),
    .X(_2646_));
 sky130_fd_sc_hd__mux4_2 _6767_ (.A0(\cpuregs[8][19] ),
    .A1(\cpuregs[9][19] ),
    .A2(\cpuregs[10][19] ),
    .A3(\cpuregs[11][19] ),
    .S0(net795),
    .S1(net789),
    .X(_2647_));
 sky130_fd_sc_hd__mux4_2 _6768_ (.A0(\cpuregs[4][19] ),
    .A1(\cpuregs[5][19] ),
    .A2(\cpuregs[6][19] ),
    .A3(\cpuregs[7][19] ),
    .S0(net796),
    .S1(net790),
    .X(_2648_));
 sky130_fd_sc_hd__mux4_2 _6771_ (.A0(\cpuregs[12][19] ),
    .A1(\cpuregs[13][19] ),
    .A2(\cpuregs[14][19] ),
    .A3(\cpuregs[15][19] ),
    .S0(net796),
    .S1(net790),
    .X(_2651_));
 sky130_fd_sc_hd__mux4_2 _6774_ (.A0(_2646_),
    .A1(_2647_),
    .A2(_2648_),
    .A3(_2651_),
    .S0(net782),
    .S1(net784),
    .X(_2654_));
 sky130_fd_sc_hd__mux4_2 _6775_ (.A0(\cpuregs[16][19] ),
    .A1(\cpuregs[17][19] ),
    .A2(\cpuregs[18][19] ),
    .A3(\cpuregs[19][19] ),
    .S0(net796),
    .S1(net790),
    .X(_2655_));
 sky130_fd_sc_hd__mux4_2 _6776_ (.A0(\cpuregs[24][19] ),
    .A1(\cpuregs[25][19] ),
    .A2(\cpuregs[26][19] ),
    .A3(\cpuregs[27][19] ),
    .S0(net796),
    .S1(net790),
    .X(_2656_));
 sky130_fd_sc_hd__mux4_2 _6777_ (.A0(\cpuregs[20][19] ),
    .A1(\cpuregs[21][19] ),
    .A2(\cpuregs[22][19] ),
    .A3(\cpuregs[23][19] ),
    .S0(net796),
    .S1(net790),
    .X(_2657_));
 sky130_fd_sc_hd__mux4_2 _6778_ (.A0(\cpuregs[28][19] ),
    .A1(\cpuregs[29][19] ),
    .A2(\cpuregs[30][19] ),
    .A3(\cpuregs[31][19] ),
    .S0(net796),
    .S1(net790),
    .X(_2658_));
 sky130_fd_sc_hd__mux4_2 _6779_ (.A0(_2655_),
    .A1(_2656_),
    .A2(_2657_),
    .A3(_2658_),
    .S0(net782),
    .S1(net784),
    .X(_2659_));
 sky130_fd_sc_hd__mux2i_1 _6781_ (.A0(_2654_),
    .A1(_2659_),
    .S(net780),
    .Y(_2661_));
 sky130_fd_sc_hd__nand2_1 _6782_ (.A(\decoded_imm[19] ),
    .B(net718),
    .Y(_2662_));
 sky130_fd_sc_hd__o21ai_0 _6783_ (.A1(_2485_),
    .A2(_2661_),
    .B1(_2662_),
    .Y(_4627_));
 sky130_fd_sc_hd__mux4_2 _6784_ (.A0(\cpuregs[0][18] ),
    .A1(\cpuregs[1][18] ),
    .A2(\cpuregs[2][18] ),
    .A3(\cpuregs[3][18] ),
    .S0(net792),
    .S1(net785),
    .X(_2663_));
 sky130_fd_sc_hd__mux4_2 _6785_ (.A0(\cpuregs[8][18] ),
    .A1(\cpuregs[9][18] ),
    .A2(\cpuregs[10][18] ),
    .A3(\cpuregs[11][18] ),
    .S0(net792),
    .S1(net785),
    .X(_2664_));
 sky130_fd_sc_hd__mux4_2 _6786_ (.A0(\cpuregs[4][18] ),
    .A1(\cpuregs[5][18] ),
    .A2(\cpuregs[6][18] ),
    .A3(\cpuregs[7][18] ),
    .S0(net792),
    .S1(net785),
    .X(_2665_));
 sky130_fd_sc_hd__mux4_2 _6787_ (.A0(\cpuregs[12][18] ),
    .A1(\cpuregs[13][18] ),
    .A2(\cpuregs[14][18] ),
    .A3(\cpuregs[15][18] ),
    .S0(net792),
    .S1(net785),
    .X(_2666_));
 sky130_fd_sc_hd__mux4_2 _6788_ (.A0(_2663_),
    .A1(_2664_),
    .A2(_2665_),
    .A3(_2666_),
    .S0(net781),
    .S1(net783),
    .X(_2667_));
 sky130_fd_sc_hd__mux4_2 _6789_ (.A0(\cpuregs[16][18] ),
    .A1(\cpuregs[17][18] ),
    .A2(\cpuregs[18][18] ),
    .A3(\cpuregs[19][18] ),
    .S0(net798),
    .S1(net787),
    .X(_2668_));
 sky130_fd_sc_hd__mux4_2 _6790_ (.A0(\cpuregs[24][18] ),
    .A1(\cpuregs[25][18] ),
    .A2(\cpuregs[26][18] ),
    .A3(\cpuregs[27][18] ),
    .S0(net798),
    .S1(net787),
    .X(_2669_));
 sky130_fd_sc_hd__mux4_2 _6791_ (.A0(\cpuregs[20][18] ),
    .A1(\cpuregs[21][18] ),
    .A2(\cpuregs[22][18] ),
    .A3(\cpuregs[23][18] ),
    .S0(net798),
    .S1(net787),
    .X(_2670_));
 sky130_fd_sc_hd__mux4_2 _6792_ (.A0(\cpuregs[28][18] ),
    .A1(\cpuregs[29][18] ),
    .A2(\cpuregs[30][18] ),
    .A3(\cpuregs[31][18] ),
    .S0(net798),
    .S1(net787),
    .X(_2671_));
 sky130_fd_sc_hd__mux4_2 _6793_ (.A0(_2668_),
    .A1(_2669_),
    .A2(_2670_),
    .A3(_2671_),
    .S0(net781),
    .S1(net783),
    .X(_2672_));
 sky130_fd_sc_hd__mux2i_1 _6794_ (.A0(_2667_),
    .A1(_2672_),
    .S(net780),
    .Y(_2673_));
 sky130_fd_sc_hd__nand2_1 _6795_ (.A(\decoded_imm[18] ),
    .B(net718),
    .Y(_2674_));
 sky130_fd_sc_hd__o21ai_0 _6796_ (.A1(_2485_),
    .A2(_2673_),
    .B1(_2674_),
    .Y(_4626_));
 sky130_fd_sc_hd__mux4_2 _6797_ (.A0(\cpuregs[0][17] ),
    .A1(\cpuregs[1][17] ),
    .A2(\cpuregs[2][17] ),
    .A3(\cpuregs[3][17] ),
    .S0(net795),
    .S1(net789),
    .X(_2675_));
 sky130_fd_sc_hd__mux4_2 _6798_ (.A0(\cpuregs[8][17] ),
    .A1(\cpuregs[9][17] ),
    .A2(\cpuregs[10][17] ),
    .A3(\cpuregs[11][17] ),
    .S0(net795),
    .S1(net789),
    .X(_2676_));
 sky130_fd_sc_hd__mux4_2 _6801_ (.A0(\cpuregs[4][17] ),
    .A1(\cpuregs[5][17] ),
    .A2(\cpuregs[6][17] ),
    .A3(\cpuregs[7][17] ),
    .S0(net795),
    .S1(net789),
    .X(_2679_));
 sky130_fd_sc_hd__mux4_2 _6802_ (.A0(\cpuregs[12][17] ),
    .A1(\cpuregs[13][17] ),
    .A2(\cpuregs[14][17] ),
    .A3(\cpuregs[15][17] ),
    .S0(net795),
    .S1(net789),
    .X(_2680_));
 sky130_fd_sc_hd__mux4_2 _6803_ (.A0(_2675_),
    .A1(_2676_),
    .A2(_2679_),
    .A3(_2680_),
    .S0(net782),
    .S1(net784),
    .X(_2681_));
 sky130_fd_sc_hd__mux4_2 _6804_ (.A0(\cpuregs[16][17] ),
    .A1(\cpuregs[17][17] ),
    .A2(\cpuregs[18][17] ),
    .A3(\cpuregs[19][17] ),
    .S0(net795),
    .S1(net789),
    .X(_2682_));
 sky130_fd_sc_hd__mux4_2 _6805_ (.A0(\cpuregs[24][17] ),
    .A1(\cpuregs[25][17] ),
    .A2(\cpuregs[26][17] ),
    .A3(\cpuregs[27][17] ),
    .S0(net795),
    .S1(net789),
    .X(_2683_));
 sky130_fd_sc_hd__mux4_2 _6806_ (.A0(\cpuregs[20][17] ),
    .A1(\cpuregs[21][17] ),
    .A2(\cpuregs[22][17] ),
    .A3(\cpuregs[23][17] ),
    .S0(net795),
    .S1(net790),
    .X(_2684_));
 sky130_fd_sc_hd__mux4_2 _6807_ (.A0(\cpuregs[28][17] ),
    .A1(\cpuregs[29][17] ),
    .A2(\cpuregs[30][17] ),
    .A3(\cpuregs[31][17] ),
    .S0(net795),
    .S1(net790),
    .X(_2685_));
 sky130_fd_sc_hd__mux4_2 _6808_ (.A0(_2682_),
    .A1(_2683_),
    .A2(_2684_),
    .A3(_2685_),
    .S0(net782),
    .S1(net784),
    .X(_2686_));
 sky130_fd_sc_hd__mux2i_1 _6809_ (.A0(_2681_),
    .A1(_2686_),
    .S(net780),
    .Y(_2687_));
 sky130_fd_sc_hd__nand2_1 _6810_ (.A(\decoded_imm[17] ),
    .B(net718),
    .Y(_2688_));
 sky130_fd_sc_hd__o21ai_0 _6811_ (.A1(_2485_),
    .A2(_2687_),
    .B1(_2688_),
    .Y(_4625_));
 sky130_fd_sc_hd__mux4_2 _6812_ (.A0(\cpuregs[0][16] ),
    .A1(\cpuregs[1][16] ),
    .A2(\cpuregs[2][16] ),
    .A3(\cpuregs[3][16] ),
    .S0(net792),
    .S1(net785),
    .X(_2689_));
 sky130_fd_sc_hd__mux4_2 _6815_ (.A0(\cpuregs[8][16] ),
    .A1(\cpuregs[9][16] ),
    .A2(\cpuregs[10][16] ),
    .A3(\cpuregs[11][16] ),
    .S0(net792),
    .S1(net785),
    .X(_2692_));
 sky130_fd_sc_hd__mux4_2 _6816_ (.A0(\cpuregs[4][16] ),
    .A1(\cpuregs[5][16] ),
    .A2(\cpuregs[6][16] ),
    .A3(\cpuregs[7][16] ),
    .S0(net792),
    .S1(net785),
    .X(_2693_));
 sky130_fd_sc_hd__mux4_2 _6817_ (.A0(\cpuregs[12][16] ),
    .A1(\cpuregs[13][16] ),
    .A2(\cpuregs[14][16] ),
    .A3(\cpuregs[15][16] ),
    .S0(net792),
    .S1(net785),
    .X(_2694_));
 sky130_fd_sc_hd__mux4_2 _6818_ (.A0(_2689_),
    .A1(_2692_),
    .A2(_2693_),
    .A3(_2694_),
    .S0(net781),
    .S1(net783),
    .X(_2695_));
 sky130_fd_sc_hd__mux4_2 _6819_ (.A0(\cpuregs[16][16] ),
    .A1(\cpuregs[17][16] ),
    .A2(\cpuregs[18][16] ),
    .A3(\cpuregs[19][16] ),
    .S0(net798),
    .S1(net787),
    .X(_2696_));
 sky130_fd_sc_hd__mux4_2 _6820_ (.A0(\cpuregs[24][16] ),
    .A1(\cpuregs[25][16] ),
    .A2(\cpuregs[26][16] ),
    .A3(\cpuregs[27][16] ),
    .S0(net798),
    .S1(net787),
    .X(_2697_));
 sky130_fd_sc_hd__mux4_2 _6821_ (.A0(\cpuregs[20][16] ),
    .A1(\cpuregs[21][16] ),
    .A2(\cpuregs[22][16] ),
    .A3(\cpuregs[23][16] ),
    .S0(net798),
    .S1(net787),
    .X(_2698_));
 sky130_fd_sc_hd__mux4_2 _6822_ (.A0(\cpuregs[28][16] ),
    .A1(\cpuregs[29][16] ),
    .A2(\cpuregs[30][16] ),
    .A3(\cpuregs[31][16] ),
    .S0(net798),
    .S1(net787),
    .X(_2699_));
 sky130_fd_sc_hd__mux4_2 _6823_ (.A0(_2696_),
    .A1(_2697_),
    .A2(_2698_),
    .A3(_2699_),
    .S0(net781),
    .S1(net783),
    .X(_2700_));
 sky130_fd_sc_hd__mux2i_1 _6824_ (.A0(_2695_),
    .A1(_2700_),
    .S(net780),
    .Y(_2701_));
 sky130_fd_sc_hd__nand2_1 _6825_ (.A(\decoded_imm[16] ),
    .B(net718),
    .Y(_2702_));
 sky130_fd_sc_hd__o21ai_0 _6826_ (.A1(_2485_),
    .A2(_2701_),
    .B1(_2702_),
    .Y(_4624_));
 sky130_fd_sc_hd__mux4_2 _6827_ (.A0(\cpuregs[0][15] ),
    .A1(\cpuregs[1][15] ),
    .A2(\cpuregs[2][15] ),
    .A3(\cpuregs[3][15] ),
    .S0(net799),
    .S1(net788),
    .X(_2703_));
 sky130_fd_sc_hd__mux4_2 _6828_ (.A0(\cpuregs[8][15] ),
    .A1(\cpuregs[9][15] ),
    .A2(\cpuregs[10][15] ),
    .A3(\cpuregs[11][15] ),
    .S0(net799),
    .S1(net788),
    .X(_2704_));
 sky130_fd_sc_hd__mux4_2 _6829_ (.A0(\cpuregs[4][15] ),
    .A1(\cpuregs[5][15] ),
    .A2(\cpuregs[6][15] ),
    .A3(\cpuregs[7][15] ),
    .S0(net799),
    .S1(net788),
    .X(_2705_));
 sky130_fd_sc_hd__mux4_2 _6830_ (.A0(\cpuregs[12][15] ),
    .A1(\cpuregs[13][15] ),
    .A2(\cpuregs[14][15] ),
    .A3(\cpuregs[15][15] ),
    .S0(net799),
    .S1(net788),
    .X(_2706_));
 sky130_fd_sc_hd__mux4_2 _6831_ (.A0(_2703_),
    .A1(_2704_),
    .A2(_2705_),
    .A3(_2706_),
    .S0(net781),
    .S1(net783),
    .X(_2707_));
 sky130_fd_sc_hd__mux4_2 _6832_ (.A0(\cpuregs[16][15] ),
    .A1(\cpuregs[17][15] ),
    .A2(\cpuregs[18][15] ),
    .A3(\cpuregs[19][15] ),
    .S0(net799),
    .S1(net788),
    .X(_2708_));
 sky130_fd_sc_hd__mux4_2 _6833_ (.A0(\cpuregs[24][15] ),
    .A1(\cpuregs[25][15] ),
    .A2(\cpuregs[26][15] ),
    .A3(\cpuregs[27][15] ),
    .S0(net799),
    .S1(net788),
    .X(_2709_));
 sky130_fd_sc_hd__mux4_2 _6834_ (.A0(\cpuregs[20][15] ),
    .A1(\cpuregs[21][15] ),
    .A2(\cpuregs[22][15] ),
    .A3(\cpuregs[23][15] ),
    .S0(net799),
    .S1(net788),
    .X(_2710_));
 sky130_fd_sc_hd__mux4_2 _6837_ (.A0(\cpuregs[28][15] ),
    .A1(\cpuregs[29][15] ),
    .A2(\cpuregs[30][15] ),
    .A3(\cpuregs[31][15] ),
    .S0(net799),
    .S1(net788),
    .X(_2713_));
 sky130_fd_sc_hd__mux4_2 _6840_ (.A0(_2708_),
    .A1(_2709_),
    .A2(_2710_),
    .A3(_2713_),
    .S0(net781),
    .S1(net783),
    .X(_2716_));
 sky130_fd_sc_hd__mux2i_1 _6841_ (.A0(_2707_),
    .A1(_2716_),
    .S(net780),
    .Y(_2717_));
 sky130_fd_sc_hd__nand2_1 _6842_ (.A(\decoded_imm[15] ),
    .B(net718),
    .Y(_2718_));
 sky130_fd_sc_hd__o21ai_0 _6843_ (.A1(_2485_),
    .A2(_2717_),
    .B1(_2718_),
    .Y(_4623_));
 sky130_fd_sc_hd__mux4_2 _6844_ (.A0(\cpuregs[0][14] ),
    .A1(\cpuregs[1][14] ),
    .A2(\cpuregs[2][14] ),
    .A3(\cpuregs[3][14] ),
    .S0(net792),
    .S1(net785),
    .X(_2719_));
 sky130_fd_sc_hd__mux4_2 _6845_ (.A0(\cpuregs[8][14] ),
    .A1(\cpuregs[9][14] ),
    .A2(\cpuregs[10][14] ),
    .A3(\cpuregs[11][14] ),
    .S0(net792),
    .S1(net785),
    .X(_2720_));
 sky130_fd_sc_hd__mux4_2 _6846_ (.A0(\cpuregs[4][14] ),
    .A1(\cpuregs[5][14] ),
    .A2(\cpuregs[6][14] ),
    .A3(\cpuregs[7][14] ),
    .S0(net792),
    .S1(net785),
    .X(_2721_));
 sky130_fd_sc_hd__mux4_2 _6847_ (.A0(\cpuregs[12][14] ),
    .A1(\cpuregs[13][14] ),
    .A2(\cpuregs[14][14] ),
    .A3(\cpuregs[15][14] ),
    .S0(net792),
    .S1(net785),
    .X(_2722_));
 sky130_fd_sc_hd__mux4_2 _6848_ (.A0(_2719_),
    .A1(_2720_),
    .A2(_2721_),
    .A3(_2722_),
    .S0(net781),
    .S1(net783),
    .X(_2723_));
 sky130_fd_sc_hd__mux4_2 _6849_ (.A0(\cpuregs[16][14] ),
    .A1(\cpuregs[17][14] ),
    .A2(\cpuregs[18][14] ),
    .A3(\cpuregs[19][14] ),
    .S0(net798),
    .S1(net787),
    .X(_2724_));
 sky130_fd_sc_hd__mux4_2 _6852_ (.A0(\cpuregs[24][14] ),
    .A1(\cpuregs[25][14] ),
    .A2(\cpuregs[26][14] ),
    .A3(\cpuregs[27][14] ),
    .S0(net798),
    .S1(net787),
    .X(_2727_));
 sky130_fd_sc_hd__mux4_2 _6853_ (.A0(\cpuregs[20][14] ),
    .A1(\cpuregs[21][14] ),
    .A2(\cpuregs[22][14] ),
    .A3(\cpuregs[23][14] ),
    .S0(net798),
    .S1(net787),
    .X(_2728_));
 sky130_fd_sc_hd__mux4_2 _6854_ (.A0(\cpuregs[28][14] ),
    .A1(\cpuregs[29][14] ),
    .A2(\cpuregs[30][14] ),
    .A3(\cpuregs[31][14] ),
    .S0(net798),
    .S1(net787),
    .X(_2729_));
 sky130_fd_sc_hd__mux4_2 _6855_ (.A0(_2724_),
    .A1(_2727_),
    .A2(_2728_),
    .A3(_2729_),
    .S0(net781),
    .S1(net783),
    .X(_2730_));
 sky130_fd_sc_hd__mux2i_1 _6856_ (.A0(_2723_),
    .A1(_2730_),
    .S(net780),
    .Y(_2731_));
 sky130_fd_sc_hd__nand2_1 _6857_ (.A(\decoded_imm[14] ),
    .B(net718),
    .Y(_2732_));
 sky130_fd_sc_hd__o21ai_0 _6858_ (.A1(_2485_),
    .A2(_2731_),
    .B1(_2732_),
    .Y(_4622_));
 sky130_fd_sc_hd__mux4_2 _6859_ (.A0(\cpuregs[0][13] ),
    .A1(\cpuregs[1][13] ),
    .A2(\cpuregs[2][13] ),
    .A3(\cpuregs[3][13] ),
    .S0(net792),
    .S1(net785),
    .X(_2733_));
 sky130_fd_sc_hd__mux4_2 _6860_ (.A0(\cpuregs[8][13] ),
    .A1(\cpuregs[9][13] ),
    .A2(\cpuregs[10][13] ),
    .A3(\cpuregs[11][13] ),
    .S0(net792),
    .S1(net785),
    .X(_2734_));
 sky130_fd_sc_hd__mux4_2 _6861_ (.A0(\cpuregs[4][13] ),
    .A1(\cpuregs[5][13] ),
    .A2(\cpuregs[6][13] ),
    .A3(\cpuregs[7][13] ),
    .S0(net792),
    .S1(net785),
    .X(_2735_));
 sky130_fd_sc_hd__mux4_2 _6862_ (.A0(\cpuregs[12][13] ),
    .A1(\cpuregs[13][13] ),
    .A2(\cpuregs[14][13] ),
    .A3(\cpuregs[15][13] ),
    .S0(net792),
    .S1(net785),
    .X(_2736_));
 sky130_fd_sc_hd__mux4_2 _6863_ (.A0(_2733_),
    .A1(_2734_),
    .A2(_2735_),
    .A3(_2736_),
    .S0(net781),
    .S1(net783),
    .X(_2737_));
 sky130_fd_sc_hd__mux4_2 _6866_ (.A0(\cpuregs[16][13] ),
    .A1(\cpuregs[17][13] ),
    .A2(\cpuregs[18][13] ),
    .A3(\cpuregs[19][13] ),
    .S0(net798),
    .S1(net787),
    .X(_2740_));
 sky130_fd_sc_hd__mux4_2 _6867_ (.A0(\cpuregs[24][13] ),
    .A1(\cpuregs[25][13] ),
    .A2(\cpuregs[26][13] ),
    .A3(\cpuregs[27][13] ),
    .S0(net798),
    .S1(net787),
    .X(_2741_));
 sky130_fd_sc_hd__mux4_2 _6868_ (.A0(\cpuregs[20][13] ),
    .A1(\cpuregs[21][13] ),
    .A2(\cpuregs[22][13] ),
    .A3(\cpuregs[23][13] ),
    .S0(net798),
    .S1(net787),
    .X(_2742_));
 sky130_fd_sc_hd__mux4_2 _6869_ (.A0(\cpuregs[28][13] ),
    .A1(\cpuregs[29][13] ),
    .A2(\cpuregs[30][13] ),
    .A3(\cpuregs[31][13] ),
    .S0(net798),
    .S1(net787),
    .X(_2743_));
 sky130_fd_sc_hd__mux4_2 _6870_ (.A0(_2740_),
    .A1(_2741_),
    .A2(_2742_),
    .A3(_2743_),
    .S0(net781),
    .S1(net783),
    .X(_2744_));
 sky130_fd_sc_hd__mux2i_1 _6871_ (.A0(_2737_),
    .A1(_2744_),
    .S(net780),
    .Y(_2745_));
 sky130_fd_sc_hd__nand2_1 _6872_ (.A(\decoded_imm[13] ),
    .B(net718),
    .Y(_2746_));
 sky130_fd_sc_hd__o21ai_0 _6873_ (.A1(_2485_),
    .A2(_2745_),
    .B1(_2746_),
    .Y(_4621_));
 sky130_fd_sc_hd__mux4_2 _6874_ (.A0(\cpuregs[0][12] ),
    .A1(\cpuregs[1][12] ),
    .A2(\cpuregs[2][12] ),
    .A3(\cpuregs[3][12] ),
    .S0(net798),
    .S1(net787),
    .X(_2747_));
 sky130_fd_sc_hd__mux4_2 _6875_ (.A0(\cpuregs[8][12] ),
    .A1(\cpuregs[9][12] ),
    .A2(\cpuregs[10][12] ),
    .A3(\cpuregs[11][12] ),
    .S0(net798),
    .S1(net787),
    .X(_2748_));
 sky130_fd_sc_hd__mux4_2 _6876_ (.A0(\cpuregs[4][12] ),
    .A1(\cpuregs[5][12] ),
    .A2(\cpuregs[6][12] ),
    .A3(\cpuregs[7][12] ),
    .S0(net798),
    .S1(net787),
    .X(_2749_));
 sky130_fd_sc_hd__mux4_2 _6877_ (.A0(\cpuregs[12][12] ),
    .A1(\cpuregs[13][12] ),
    .A2(\cpuregs[14][12] ),
    .A3(\cpuregs[15][12] ),
    .S0(net798),
    .S1(net787),
    .X(_2750_));
 sky130_fd_sc_hd__mux4_2 _6878_ (.A0(_2747_),
    .A1(_2748_),
    .A2(_2749_),
    .A3(_2750_),
    .S0(net781),
    .S1(net783),
    .X(_2751_));
 sky130_fd_sc_hd__mux4_2 _6879_ (.A0(\cpuregs[16][12] ),
    .A1(\cpuregs[17][12] ),
    .A2(\cpuregs[18][12] ),
    .A3(\cpuregs[19][12] ),
    .S0(net798),
    .S1(net787),
    .X(_2752_));
 sky130_fd_sc_hd__mux4_2 _6880_ (.A0(\cpuregs[24][12] ),
    .A1(\cpuregs[25][12] ),
    .A2(\cpuregs[26][12] ),
    .A3(\cpuregs[27][12] ),
    .S0(net798),
    .S1(net787),
    .X(_2753_));
 sky130_fd_sc_hd__mux4_2 _6881_ (.A0(\cpuregs[20][12] ),
    .A1(\cpuregs[21][12] ),
    .A2(\cpuregs[22][12] ),
    .A3(\cpuregs[23][12] ),
    .S0(net798),
    .S1(net787),
    .X(_2754_));
 sky130_fd_sc_hd__mux4_2 _6882_ (.A0(\cpuregs[28][12] ),
    .A1(\cpuregs[29][12] ),
    .A2(\cpuregs[30][12] ),
    .A3(\cpuregs[31][12] ),
    .S0(net798),
    .S1(net787),
    .X(_2755_));
 sky130_fd_sc_hd__mux4_2 _6883_ (.A0(_2752_),
    .A1(_2753_),
    .A2(_2754_),
    .A3(_2755_),
    .S0(net781),
    .S1(net783),
    .X(_2756_));
 sky130_fd_sc_hd__mux2i_1 _6884_ (.A0(_2751_),
    .A1(_2756_),
    .S(net780),
    .Y(_2757_));
 sky130_fd_sc_hd__nand2_1 _6885_ (.A(\decoded_imm[12] ),
    .B(net718),
    .Y(_2758_));
 sky130_fd_sc_hd__o21ai_0 _6886_ (.A1(_2485_),
    .A2(_2757_),
    .B1(_2758_),
    .Y(_4620_));
 sky130_fd_sc_hd__mux4_2 _6887_ (.A0(\cpuregs[0][11] ),
    .A1(\cpuregs[1][11] ),
    .A2(\cpuregs[2][11] ),
    .A3(\cpuregs[3][11] ),
    .S0(net792),
    .S1(net785),
    .X(_2759_));
 sky130_fd_sc_hd__mux4_2 _6888_ (.A0(\cpuregs[8][11] ),
    .A1(\cpuregs[9][11] ),
    .A2(\cpuregs[10][11] ),
    .A3(\cpuregs[11][11] ),
    .S0(net798),
    .S1(net787),
    .X(_2760_));
 sky130_fd_sc_hd__mux4_2 _6889_ (.A0(\cpuregs[4][11] ),
    .A1(\cpuregs[5][11] ),
    .A2(\cpuregs[6][11] ),
    .A3(\cpuregs[7][11] ),
    .S0(net792),
    .S1(net785),
    .X(_2761_));
 sky130_fd_sc_hd__mux4_2 _6890_ (.A0(\cpuregs[12][11] ),
    .A1(\cpuregs[13][11] ),
    .A2(\cpuregs[14][11] ),
    .A3(\cpuregs[15][11] ),
    .S0(net798),
    .S1(net787),
    .X(_2762_));
 sky130_fd_sc_hd__mux4_2 _6891_ (.A0(_2759_),
    .A1(_2760_),
    .A2(_2761_),
    .A3(_2762_),
    .S0(net781),
    .S1(net783),
    .X(_2763_));
 sky130_fd_sc_hd__mux4_2 _6892_ (.A0(\cpuregs[16][11] ),
    .A1(\cpuregs[17][11] ),
    .A2(\cpuregs[18][11] ),
    .A3(\cpuregs[19][11] ),
    .S0(net798),
    .S1(net787),
    .X(_2764_));
 sky130_fd_sc_hd__mux4_2 _6893_ (.A0(\cpuregs[24][11] ),
    .A1(\cpuregs[25][11] ),
    .A2(\cpuregs[26][11] ),
    .A3(\cpuregs[27][11] ),
    .S0(net798),
    .S1(net787),
    .X(_2765_));
 sky130_fd_sc_hd__mux4_2 _6894_ (.A0(\cpuregs[20][11] ),
    .A1(\cpuregs[21][11] ),
    .A2(\cpuregs[22][11] ),
    .A3(\cpuregs[23][11] ),
    .S0(net798),
    .S1(net787),
    .X(_2766_));
 sky130_fd_sc_hd__mux4_2 _6895_ (.A0(\cpuregs[28][11] ),
    .A1(\cpuregs[29][11] ),
    .A2(\cpuregs[30][11] ),
    .A3(\cpuregs[31][11] ),
    .S0(net798),
    .S1(net787),
    .X(_2767_));
 sky130_fd_sc_hd__mux4_2 _6896_ (.A0(_2764_),
    .A1(_2765_),
    .A2(_2766_),
    .A3(_2767_),
    .S0(net781),
    .S1(net783),
    .X(_2768_));
 sky130_fd_sc_hd__mux2i_1 _6897_ (.A0(_2763_),
    .A1(_2768_),
    .S(net780),
    .Y(_2769_));
 sky130_fd_sc_hd__nand2_1 _6898_ (.A(\decoded_imm[11] ),
    .B(net718),
    .Y(_2770_));
 sky130_fd_sc_hd__o21ai_0 _6899_ (.A1(_2485_),
    .A2(_2769_),
    .B1(_2770_),
    .Y(_4619_));
 sky130_fd_sc_hd__mux4_2 _6900_ (.A0(\cpuregs[0][10] ),
    .A1(\cpuregs[1][10] ),
    .A2(\cpuregs[2][10] ),
    .A3(\cpuregs[3][10] ),
    .S0(net795),
    .S1(net789),
    .X(_2771_));
 sky130_fd_sc_hd__mux4_2 _6901_ (.A0(\cpuregs[8][10] ),
    .A1(\cpuregs[9][10] ),
    .A2(\cpuregs[10][10] ),
    .A3(\cpuregs[11][10] ),
    .S0(net795),
    .S1(net789),
    .X(_2772_));
 sky130_fd_sc_hd__mux4_2 _6902_ (.A0(\cpuregs[4][10] ),
    .A1(\cpuregs[5][10] ),
    .A2(\cpuregs[6][10] ),
    .A3(\cpuregs[7][10] ),
    .S0(net795),
    .S1(net789),
    .X(_2773_));
 sky130_fd_sc_hd__mux4_2 _6903_ (.A0(\cpuregs[12][10] ),
    .A1(\cpuregs[13][10] ),
    .A2(\cpuregs[14][10] ),
    .A3(\cpuregs[15][10] ),
    .S0(net795),
    .S1(net789),
    .X(_2774_));
 sky130_fd_sc_hd__mux4_2 _6904_ (.A0(_2771_),
    .A1(_2772_),
    .A2(_2773_),
    .A3(_2774_),
    .S0(net782),
    .S1(net784),
    .X(_2775_));
 sky130_fd_sc_hd__mux4_2 _6905_ (.A0(\cpuregs[16][10] ),
    .A1(\cpuregs[17][10] ),
    .A2(\cpuregs[18][10] ),
    .A3(\cpuregs[19][10] ),
    .S0(net795),
    .S1(net789),
    .X(_2776_));
 sky130_fd_sc_hd__mux4_2 _6906_ (.A0(\cpuregs[24][10] ),
    .A1(\cpuregs[25][10] ),
    .A2(\cpuregs[26][10] ),
    .A3(\cpuregs[27][10] ),
    .S0(net795),
    .S1(net789),
    .X(_2777_));
 sky130_fd_sc_hd__mux4_2 _6907_ (.A0(\cpuregs[20][10] ),
    .A1(\cpuregs[21][10] ),
    .A2(\cpuregs[22][10] ),
    .A3(\cpuregs[23][10] ),
    .S0(net795),
    .S1(net789),
    .X(_2778_));
 sky130_fd_sc_hd__mux4_2 _6908_ (.A0(\cpuregs[28][10] ),
    .A1(\cpuregs[29][10] ),
    .A2(\cpuregs[30][10] ),
    .A3(\cpuregs[31][10] ),
    .S0(net795),
    .S1(net789),
    .X(_2779_));
 sky130_fd_sc_hd__mux4_2 _6909_ (.A0(_2776_),
    .A1(_2777_),
    .A2(_2778_),
    .A3(_2779_),
    .S0(net782),
    .S1(net784),
    .X(_2780_));
 sky130_fd_sc_hd__mux2i_1 _6910_ (.A0(_2775_),
    .A1(_2780_),
    .S(net780),
    .Y(_2781_));
 sky130_fd_sc_hd__nand2_1 _6912_ (.A(\decoded_imm[10] ),
    .B(net718),
    .Y(_2783_));
 sky130_fd_sc_hd__o21ai_0 _6913_ (.A1(_2485_),
    .A2(_2781_),
    .B1(_2783_),
    .Y(_4618_));
 sky130_fd_sc_hd__mux4_2 _6914_ (.A0(\cpuregs[0][9] ),
    .A1(\cpuregs[1][9] ),
    .A2(\cpuregs[2][9] ),
    .A3(\cpuregs[3][9] ),
    .S0(net797),
    .S1(net786),
    .X(_2784_));
 sky130_fd_sc_hd__mux4_2 _6915_ (.A0(\cpuregs[8][9] ),
    .A1(\cpuregs[9][9] ),
    .A2(\cpuregs[10][9] ),
    .A3(\cpuregs[11][9] ),
    .S0(net797),
    .S1(net786),
    .X(_2785_));
 sky130_fd_sc_hd__mux4_2 _6916_ (.A0(\cpuregs[4][9] ),
    .A1(\cpuregs[5][9] ),
    .A2(\cpuregs[6][9] ),
    .A3(\cpuregs[7][9] ),
    .S0(net797),
    .S1(net786),
    .X(_2786_));
 sky130_fd_sc_hd__mux4_2 _6917_ (.A0(\cpuregs[12][9] ),
    .A1(\cpuregs[13][9] ),
    .A2(\cpuregs[14][9] ),
    .A3(\cpuregs[15][9] ),
    .S0(net797),
    .S1(net786),
    .X(_2787_));
 sky130_fd_sc_hd__mux4_2 _6918_ (.A0(_2784_),
    .A1(_2785_),
    .A2(_2786_),
    .A3(_2787_),
    .S0(net782),
    .S1(net783),
    .X(_2788_));
 sky130_fd_sc_hd__mux4_2 _6919_ (.A0(\cpuregs[16][9] ),
    .A1(\cpuregs[17][9] ),
    .A2(\cpuregs[18][9] ),
    .A3(\cpuregs[19][9] ),
    .S0(net797),
    .S1(net786),
    .X(_2789_));
 sky130_fd_sc_hd__mux4_2 _6920_ (.A0(\cpuregs[24][9] ),
    .A1(\cpuregs[25][9] ),
    .A2(\cpuregs[26][9] ),
    .A3(\cpuregs[27][9] ),
    .S0(net797),
    .S1(net786),
    .X(_2790_));
 sky130_fd_sc_hd__mux4_2 _6921_ (.A0(\cpuregs[20][9] ),
    .A1(\cpuregs[21][9] ),
    .A2(\cpuregs[22][9] ),
    .A3(\cpuregs[23][9] ),
    .S0(net797),
    .S1(net786),
    .X(_2791_));
 sky130_fd_sc_hd__mux4_2 _6922_ (.A0(\cpuregs[28][9] ),
    .A1(\cpuregs[29][9] ),
    .A2(\cpuregs[30][9] ),
    .A3(\cpuregs[31][9] ),
    .S0(net797),
    .S1(net786),
    .X(_2792_));
 sky130_fd_sc_hd__mux4_2 _6923_ (.A0(_2789_),
    .A1(_2790_),
    .A2(_2791_),
    .A3(_2792_),
    .S0(net782),
    .S1(net783),
    .X(_2793_));
 sky130_fd_sc_hd__mux2i_1 _6924_ (.A0(_2788_),
    .A1(_2793_),
    .S(net780),
    .Y(_2794_));
 sky130_fd_sc_hd__nand2_1 _6925_ (.A(\decoded_imm[9] ),
    .B(net718),
    .Y(_2795_));
 sky130_fd_sc_hd__o21ai_0 _6926_ (.A1(_2485_),
    .A2(_2794_),
    .B1(_2795_),
    .Y(_4648_));
 sky130_fd_sc_hd__mux4_2 _6927_ (.A0(\cpuregs[0][8] ),
    .A1(\cpuregs[1][8] ),
    .A2(\cpuregs[2][8] ),
    .A3(\cpuregs[3][8] ),
    .S0(net795),
    .S1(net789),
    .X(_2796_));
 sky130_fd_sc_hd__mux4_2 _6928_ (.A0(\cpuregs[8][8] ),
    .A1(\cpuregs[9][8] ),
    .A2(\cpuregs[10][8] ),
    .A3(\cpuregs[11][8] ),
    .S0(net795),
    .S1(net789),
    .X(_2797_));
 sky130_fd_sc_hd__mux4_2 _6929_ (.A0(\cpuregs[4][8] ),
    .A1(\cpuregs[5][8] ),
    .A2(\cpuregs[6][8] ),
    .A3(\cpuregs[7][8] ),
    .S0(net795),
    .S1(net789),
    .X(_2798_));
 sky130_fd_sc_hd__mux4_2 _6930_ (.A0(\cpuregs[12][8] ),
    .A1(\cpuregs[13][8] ),
    .A2(\cpuregs[14][8] ),
    .A3(\cpuregs[15][8] ),
    .S0(net795),
    .S1(net789),
    .X(_2799_));
 sky130_fd_sc_hd__mux4_2 _6931_ (.A0(_2796_),
    .A1(_2797_),
    .A2(_2798_),
    .A3(_2799_),
    .S0(net782),
    .S1(net784),
    .X(_2800_));
 sky130_fd_sc_hd__mux4_2 _6932_ (.A0(\cpuregs[16][8] ),
    .A1(\cpuregs[17][8] ),
    .A2(\cpuregs[18][8] ),
    .A3(\cpuregs[19][8] ),
    .S0(net795),
    .S1(net789),
    .X(_2801_));
 sky130_fd_sc_hd__mux4_2 _6933_ (.A0(\cpuregs[24][8] ),
    .A1(\cpuregs[25][8] ),
    .A2(\cpuregs[26][8] ),
    .A3(\cpuregs[27][8] ),
    .S0(net795),
    .S1(net789),
    .X(_2802_));
 sky130_fd_sc_hd__mux4_2 _6934_ (.A0(\cpuregs[20][8] ),
    .A1(\cpuregs[21][8] ),
    .A2(\cpuregs[22][8] ),
    .A3(\cpuregs[23][8] ),
    .S0(net795),
    .S1(net789),
    .X(_2803_));
 sky130_fd_sc_hd__mux4_2 _6935_ (.A0(\cpuregs[28][8] ),
    .A1(\cpuregs[29][8] ),
    .A2(\cpuregs[30][8] ),
    .A3(\cpuregs[31][8] ),
    .S0(net795),
    .S1(net789),
    .X(_2804_));
 sky130_fd_sc_hd__mux4_2 _6936_ (.A0(_2801_),
    .A1(_2802_),
    .A2(_2803_),
    .A3(_2804_),
    .S0(net782),
    .S1(net784),
    .X(_2805_));
 sky130_fd_sc_hd__mux2i_1 _6937_ (.A0(_2800_),
    .A1(_2805_),
    .S(net780),
    .Y(_2806_));
 sky130_fd_sc_hd__nand2_1 _6938_ (.A(\decoded_imm[8] ),
    .B(net718),
    .Y(_2807_));
 sky130_fd_sc_hd__o21ai_0 _6939_ (.A1(_2485_),
    .A2(_2806_),
    .B1(_2807_),
    .Y(_4647_));
 sky130_fd_sc_hd__mux4_2 _6940_ (.A0(\cpuregs[0][7] ),
    .A1(\cpuregs[1][7] ),
    .A2(\cpuregs[2][7] ),
    .A3(\cpuregs[3][7] ),
    .S0(net795),
    .S1(net789),
    .X(_2808_));
 sky130_fd_sc_hd__mux4_2 _6941_ (.A0(\cpuregs[8][7] ),
    .A1(\cpuregs[9][7] ),
    .A2(\cpuregs[10][7] ),
    .A3(\cpuregs[11][7] ),
    .S0(net795),
    .S1(net789),
    .X(_2809_));
 sky130_fd_sc_hd__mux4_2 _6942_ (.A0(\cpuregs[4][7] ),
    .A1(\cpuregs[5][7] ),
    .A2(\cpuregs[6][7] ),
    .A3(\cpuregs[7][7] ),
    .S0(net795),
    .S1(net789),
    .X(_2810_));
 sky130_fd_sc_hd__mux4_2 _6943_ (.A0(\cpuregs[12][7] ),
    .A1(\cpuregs[13][7] ),
    .A2(\cpuregs[14][7] ),
    .A3(\cpuregs[15][7] ),
    .S0(net795),
    .S1(net789),
    .X(_2811_));
 sky130_fd_sc_hd__mux4_2 _6944_ (.A0(_2808_),
    .A1(_2809_),
    .A2(_2810_),
    .A3(_2811_),
    .S0(net782),
    .S1(net784),
    .X(_2812_));
 sky130_fd_sc_hd__mux4_2 _6945_ (.A0(\cpuregs[16][7] ),
    .A1(\cpuregs[17][7] ),
    .A2(\cpuregs[18][7] ),
    .A3(\cpuregs[19][7] ),
    .S0(net795),
    .S1(net789),
    .X(_2813_));
 sky130_fd_sc_hd__mux4_2 _6946_ (.A0(\cpuregs[24][7] ),
    .A1(\cpuregs[25][7] ),
    .A2(\cpuregs[26][7] ),
    .A3(\cpuregs[27][7] ),
    .S0(net795),
    .S1(net789),
    .X(_2814_));
 sky130_fd_sc_hd__mux4_2 _6947_ (.A0(\cpuregs[20][7] ),
    .A1(\cpuregs[21][7] ),
    .A2(\cpuregs[22][7] ),
    .A3(\cpuregs[23][7] ),
    .S0(net795),
    .S1(net789),
    .X(_2815_));
 sky130_fd_sc_hd__mux4_2 _6948_ (.A0(\cpuregs[28][7] ),
    .A1(\cpuregs[29][7] ),
    .A2(\cpuregs[30][7] ),
    .A3(\cpuregs[31][7] ),
    .S0(net795),
    .S1(net789),
    .X(_2816_));
 sky130_fd_sc_hd__mux4_2 _6949_ (.A0(_2813_),
    .A1(_2814_),
    .A2(_2815_),
    .A3(_2816_),
    .S0(net782),
    .S1(net784),
    .X(_2817_));
 sky130_fd_sc_hd__mux2i_1 _6950_ (.A0(_2812_),
    .A1(_2817_),
    .S(net780),
    .Y(_2818_));
 sky130_fd_sc_hd__nand2_1 _6951_ (.A(\decoded_imm[7] ),
    .B(net718),
    .Y(_2819_));
 sky130_fd_sc_hd__o21ai_0 _6952_ (.A1(_2485_),
    .A2(_2818_),
    .B1(_2819_),
    .Y(_4646_));
 sky130_fd_sc_hd__mux4_2 _6953_ (.A0(\cpuregs[0][6] ),
    .A1(\cpuregs[1][6] ),
    .A2(\cpuregs[2][6] ),
    .A3(\cpuregs[3][6] ),
    .S0(net797),
    .S1(net786),
    .X(_2820_));
 sky130_fd_sc_hd__mux4_2 _6954_ (.A0(\cpuregs[8][6] ),
    .A1(\cpuregs[9][6] ),
    .A2(\cpuregs[10][6] ),
    .A3(\cpuregs[11][6] ),
    .S0(net797),
    .S1(net786),
    .X(_2821_));
 sky130_fd_sc_hd__mux4_2 _6955_ (.A0(\cpuregs[4][6] ),
    .A1(\cpuregs[5][6] ),
    .A2(\cpuregs[6][6] ),
    .A3(\cpuregs[7][6] ),
    .S0(net797),
    .S1(net786),
    .X(_2822_));
 sky130_fd_sc_hd__mux4_2 _6956_ (.A0(\cpuregs[12][6] ),
    .A1(\cpuregs[13][6] ),
    .A2(\cpuregs[14][6] ),
    .A3(\cpuregs[15][6] ),
    .S0(net797),
    .S1(net786),
    .X(_2823_));
 sky130_fd_sc_hd__mux4_2 _6957_ (.A0(_2820_),
    .A1(_2821_),
    .A2(_2822_),
    .A3(_2823_),
    .S0(net781),
    .S1(net783),
    .X(_2824_));
 sky130_fd_sc_hd__mux4_2 _6958_ (.A0(\cpuregs[16][6] ),
    .A1(\cpuregs[17][6] ),
    .A2(\cpuregs[18][6] ),
    .A3(\cpuregs[19][6] ),
    .S0(net797),
    .S1(net786),
    .X(_2825_));
 sky130_fd_sc_hd__mux4_2 _6959_ (.A0(\cpuregs[24][6] ),
    .A1(\cpuregs[25][6] ),
    .A2(\cpuregs[26][6] ),
    .A3(\cpuregs[27][6] ),
    .S0(net797),
    .S1(net786),
    .X(_2826_));
 sky130_fd_sc_hd__mux4_2 _6960_ (.A0(\cpuregs[20][6] ),
    .A1(\cpuregs[21][6] ),
    .A2(\cpuregs[22][6] ),
    .A3(\cpuregs[23][6] ),
    .S0(net797),
    .S1(net786),
    .X(_2827_));
 sky130_fd_sc_hd__mux4_2 _6961_ (.A0(\cpuregs[28][6] ),
    .A1(\cpuregs[29][6] ),
    .A2(\cpuregs[30][6] ),
    .A3(\cpuregs[31][6] ),
    .S0(net797),
    .S1(net786),
    .X(_2828_));
 sky130_fd_sc_hd__mux4_2 _6962_ (.A0(_2825_),
    .A1(_2826_),
    .A2(_2827_),
    .A3(_2828_),
    .S0(net781),
    .S1(net783),
    .X(_2829_));
 sky130_fd_sc_hd__mux2i_1 _6963_ (.A0(_2824_),
    .A1(_2829_),
    .S(net780),
    .Y(_2830_));
 sky130_fd_sc_hd__nand2_1 _6964_ (.A(\decoded_imm[6] ),
    .B(net718),
    .Y(_2831_));
 sky130_fd_sc_hd__o21ai_0 _6965_ (.A1(_2485_),
    .A2(_2830_),
    .B1(_2831_),
    .Y(_4645_));
 sky130_fd_sc_hd__mux4_2 _6966_ (.A0(\cpuregs[0][5] ),
    .A1(\cpuregs[1][5] ),
    .A2(\cpuregs[2][5] ),
    .A3(\cpuregs[3][5] ),
    .S0(net797),
    .S1(net786),
    .X(_2832_));
 sky130_fd_sc_hd__mux4_2 _6967_ (.A0(\cpuregs[8][5] ),
    .A1(\cpuregs[9][5] ),
    .A2(\cpuregs[10][5] ),
    .A3(\cpuregs[11][5] ),
    .S0(net797),
    .S1(net786),
    .X(_2833_));
 sky130_fd_sc_hd__mux4_2 _6968_ (.A0(\cpuregs[4][5] ),
    .A1(\cpuregs[5][5] ),
    .A2(\cpuregs[6][5] ),
    .A3(\cpuregs[7][5] ),
    .S0(net797),
    .S1(net786),
    .X(_2834_));
 sky130_fd_sc_hd__mux4_2 _6969_ (.A0(\cpuregs[12][5] ),
    .A1(\cpuregs[13][5] ),
    .A2(\cpuregs[14][5] ),
    .A3(\cpuregs[15][5] ),
    .S0(net797),
    .S1(net786),
    .X(_2835_));
 sky130_fd_sc_hd__mux4_2 _6970_ (.A0(_2832_),
    .A1(_2833_),
    .A2(_2834_),
    .A3(_2835_),
    .S0(net781),
    .S1(net783),
    .X(_2836_));
 sky130_fd_sc_hd__mux4_2 _6971_ (.A0(\cpuregs[16][5] ),
    .A1(\cpuregs[17][5] ),
    .A2(\cpuregs[18][5] ),
    .A3(\cpuregs[19][5] ),
    .S0(net797),
    .S1(net786),
    .X(_2837_));
 sky130_fd_sc_hd__mux4_2 _6972_ (.A0(\cpuregs[24][5] ),
    .A1(\cpuregs[25][5] ),
    .A2(\cpuregs[26][5] ),
    .A3(\cpuregs[27][5] ),
    .S0(net797),
    .S1(net786),
    .X(_2838_));
 sky130_fd_sc_hd__mux4_2 _6973_ (.A0(\cpuregs[20][5] ),
    .A1(\cpuregs[21][5] ),
    .A2(\cpuregs[22][5] ),
    .A3(\cpuregs[23][5] ),
    .S0(net797),
    .S1(net786),
    .X(_2839_));
 sky130_fd_sc_hd__mux4_2 _6974_ (.A0(\cpuregs[28][5] ),
    .A1(\cpuregs[29][5] ),
    .A2(\cpuregs[30][5] ),
    .A3(\cpuregs[31][5] ),
    .S0(net797),
    .S1(net786),
    .X(_2840_));
 sky130_fd_sc_hd__mux4_2 _6975_ (.A0(_2837_),
    .A1(_2838_),
    .A2(_2839_),
    .A3(_2840_),
    .S0(net781),
    .S1(net783),
    .X(_2841_));
 sky130_fd_sc_hd__mux2i_1 _6976_ (.A0(_2836_),
    .A1(_2841_),
    .S(net780),
    .Y(_2842_));
 sky130_fd_sc_hd__nand2_1 _6977_ (.A(\decoded_imm[5] ),
    .B(net718),
    .Y(_2843_));
 sky130_fd_sc_hd__o21ai_0 _6978_ (.A1(_2485_),
    .A2(_2842_),
    .B1(_2843_),
    .Y(_4644_));
 sky130_fd_sc_hd__mux4_2 _6980_ (.A0(\cpuregs[0][4] ),
    .A1(\cpuregs[1][4] ),
    .A2(\cpuregs[2][4] ),
    .A3(\cpuregs[3][4] ),
    .S0(net795),
    .S1(net789),
    .X(_2845_));
 sky130_fd_sc_hd__mux4_2 _6981_ (.A0(\cpuregs[8][4] ),
    .A1(\cpuregs[9][4] ),
    .A2(\cpuregs[10][4] ),
    .A3(\cpuregs[11][4] ),
    .S0(net795),
    .S1(net789),
    .X(_2846_));
 sky130_fd_sc_hd__mux4_2 _6984_ (.A0(\cpuregs[4][4] ),
    .A1(\cpuregs[5][4] ),
    .A2(\cpuregs[6][4] ),
    .A3(\cpuregs[7][4] ),
    .S0(net795),
    .S1(net789),
    .X(_2849_));
 sky130_fd_sc_hd__mux4_2 _6986_ (.A0(\cpuregs[12][4] ),
    .A1(\cpuregs[13][4] ),
    .A2(\cpuregs[14][4] ),
    .A3(\cpuregs[15][4] ),
    .S0(net795),
    .S1(net789),
    .X(_2851_));
 sky130_fd_sc_hd__mux4_2 _6987_ (.A0(_2845_),
    .A1(_2846_),
    .A2(_2849_),
    .A3(_2851_),
    .S0(net782),
    .S1(net784),
    .X(_2852_));
 sky130_fd_sc_hd__mux4_2 _6988_ (.A0(\cpuregs[16][4] ),
    .A1(\cpuregs[17][4] ),
    .A2(\cpuregs[18][4] ),
    .A3(\cpuregs[19][4] ),
    .S0(net795),
    .S1(net789),
    .X(_2853_));
 sky130_fd_sc_hd__mux4_2 _6989_ (.A0(\cpuregs[24][4] ),
    .A1(\cpuregs[25][4] ),
    .A2(\cpuregs[26][4] ),
    .A3(\cpuregs[27][4] ),
    .S0(net795),
    .S1(net789),
    .X(_2854_));
 sky130_fd_sc_hd__mux4_2 _6990_ (.A0(\cpuregs[20][4] ),
    .A1(\cpuregs[21][4] ),
    .A2(\cpuregs[22][4] ),
    .A3(\cpuregs[23][4] ),
    .S0(net795),
    .S1(net789),
    .X(_2855_));
 sky130_fd_sc_hd__mux4_2 _6991_ (.A0(\cpuregs[28][4] ),
    .A1(\cpuregs[29][4] ),
    .A2(\cpuregs[30][4] ),
    .A3(\cpuregs[31][4] ),
    .S0(net795),
    .S1(net789),
    .X(_2856_));
 sky130_fd_sc_hd__mux4_2 _6992_ (.A0(_2853_),
    .A1(_2854_),
    .A2(_2855_),
    .A3(_2856_),
    .S0(net782),
    .S1(net784),
    .X(_2857_));
 sky130_fd_sc_hd__mux2_2 _6993_ (.A0(_2852_),
    .A1(_2857_),
    .S(net780),
    .X(_2858_));
 sky130_fd_sc_hd__nand2_1 _6994_ (.A(_2484_),
    .B(_2858_),
    .Y(_2859_));
 sky130_fd_sc_hd__nand2_1 _6995_ (.A(\decoded_imm[4] ),
    .B(net718),
    .Y(_2860_));
 sky130_fd_sc_hd__o21ai_0 _6996_ (.A1(net718),
    .A2(_2859_),
    .B1(_2860_),
    .Y(_4643_));
 sky130_fd_sc_hd__mux4_2 _6997_ (.A0(\cpuregs[0][3] ),
    .A1(\cpuregs[1][3] ),
    .A2(\cpuregs[2][3] ),
    .A3(\cpuregs[3][3] ),
    .S0(net794),
    .S1(net790),
    .X(_2861_));
 sky130_fd_sc_hd__mux4_2 _6998_ (.A0(\cpuregs[8][3] ),
    .A1(\cpuregs[9][3] ),
    .A2(\cpuregs[10][3] ),
    .A3(\cpuregs[11][3] ),
    .S0(net796),
    .S1(net790),
    .X(_2862_));
 sky130_fd_sc_hd__mux4_2 _6999_ (.A0(\cpuregs[4][3] ),
    .A1(\cpuregs[5][3] ),
    .A2(\cpuregs[6][3] ),
    .A3(\cpuregs[7][3] ),
    .S0(net794),
    .S1(net791),
    .X(_2863_));
 sky130_fd_sc_hd__mux4_2 _7000_ (.A0(\cpuregs[12][3] ),
    .A1(\cpuregs[13][3] ),
    .A2(\cpuregs[14][3] ),
    .A3(\cpuregs[15][3] ),
    .S0(net796),
    .S1(net790),
    .X(_2864_));
 sky130_fd_sc_hd__mux4_2 _7001_ (.A0(_2861_),
    .A1(_2862_),
    .A2(_2863_),
    .A3(_2864_),
    .S0(net782),
    .S1(net784),
    .X(_2865_));
 sky130_fd_sc_hd__mux4_2 _7002_ (.A0(\cpuregs[16][3] ),
    .A1(\cpuregs[17][3] ),
    .A2(\cpuregs[18][3] ),
    .A3(\cpuregs[19][3] ),
    .S0(net794),
    .S1(net790),
    .X(_2866_));
 sky130_fd_sc_hd__mux4_2 _7003_ (.A0(\cpuregs[24][3] ),
    .A1(\cpuregs[25][3] ),
    .A2(\cpuregs[26][3] ),
    .A3(\cpuregs[27][3] ),
    .S0(net796),
    .S1(net790),
    .X(_2867_));
 sky130_fd_sc_hd__mux4_2 _7004_ (.A0(\cpuregs[20][3] ),
    .A1(\cpuregs[21][3] ),
    .A2(\cpuregs[22][3] ),
    .A3(\cpuregs[23][3] ),
    .S0(net794),
    .S1(net790),
    .X(_2868_));
 sky130_fd_sc_hd__mux4_2 _7005_ (.A0(\cpuregs[28][3] ),
    .A1(\cpuregs[29][3] ),
    .A2(\cpuregs[30][3] ),
    .A3(\cpuregs[31][3] ),
    .S0(net794),
    .S1(net790),
    .X(_2869_));
 sky130_fd_sc_hd__mux4_2 _7006_ (.A0(_2866_),
    .A1(_2867_),
    .A2(_2868_),
    .A3(_2869_),
    .S0(net782),
    .S1(net784),
    .X(_2870_));
 sky130_fd_sc_hd__mux2_2 _7007_ (.A0(_2865_),
    .A1(_2870_),
    .S(net780),
    .X(_2871_));
 sky130_fd_sc_hd__nand2_1 _7008_ (.A(_2484_),
    .B(_2871_),
    .Y(_2872_));
 sky130_fd_sc_hd__nand2_1 _7009_ (.A(\decoded_imm[3] ),
    .B(net718),
    .Y(_2873_));
 sky130_fd_sc_hd__o21ai_0 _7010_ (.A1(net718),
    .A2(_2872_),
    .B1(_2873_),
    .Y(_4642_));
 sky130_fd_sc_hd__mux4_2 _7011_ (.A0(\cpuregs[0][2] ),
    .A1(\cpuregs[1][2] ),
    .A2(\cpuregs[2][2] ),
    .A3(\cpuregs[3][2] ),
    .S0(net794),
    .S1(net790),
    .X(_2874_));
 sky130_fd_sc_hd__mux4_2 _7012_ (.A0(\cpuregs[8][2] ),
    .A1(\cpuregs[9][2] ),
    .A2(\cpuregs[10][2] ),
    .A3(\cpuregs[11][2] ),
    .S0(net796),
    .S1(net790),
    .X(_2875_));
 sky130_fd_sc_hd__mux4_2 _7013_ (.A0(\cpuregs[4][2] ),
    .A1(\cpuregs[5][2] ),
    .A2(\cpuregs[6][2] ),
    .A3(\cpuregs[7][2] ),
    .S0(net794),
    .S1(net791),
    .X(_2876_));
 sky130_fd_sc_hd__mux4_2 _7014_ (.A0(\cpuregs[12][2] ),
    .A1(\cpuregs[13][2] ),
    .A2(\cpuregs[14][2] ),
    .A3(\cpuregs[15][2] ),
    .S0(net796),
    .S1(net790),
    .X(_2877_));
 sky130_fd_sc_hd__mux4_2 _7015_ (.A0(_2874_),
    .A1(_2875_),
    .A2(_2876_),
    .A3(_2877_),
    .S0(net782),
    .S1(net784),
    .X(_2878_));
 sky130_fd_sc_hd__mux4_2 _7016_ (.A0(\cpuregs[16][2] ),
    .A1(\cpuregs[17][2] ),
    .A2(\cpuregs[18][2] ),
    .A3(\cpuregs[19][2] ),
    .S0(net794),
    .S1(net790),
    .X(_2879_));
 sky130_fd_sc_hd__mux4_2 _7017_ (.A0(\cpuregs[24][2] ),
    .A1(\cpuregs[25][2] ),
    .A2(\cpuregs[26][2] ),
    .A3(\cpuregs[27][2] ),
    .S0(net796),
    .S1(net790),
    .X(_2880_));
 sky130_fd_sc_hd__mux4_2 _7018_ (.A0(\cpuregs[20][2] ),
    .A1(\cpuregs[21][2] ),
    .A2(\cpuregs[22][2] ),
    .A3(\cpuregs[23][2] ),
    .S0(net794),
    .S1(net791),
    .X(_2881_));
 sky130_fd_sc_hd__mux4_2 _7019_ (.A0(\cpuregs[28][2] ),
    .A1(\cpuregs[29][2] ),
    .A2(\cpuregs[30][2] ),
    .A3(\cpuregs[31][2] ),
    .S0(net794),
    .S1(net790),
    .X(_2882_));
 sky130_fd_sc_hd__mux4_2 _7020_ (.A0(_2879_),
    .A1(_2880_),
    .A2(_2881_),
    .A3(_2882_),
    .S0(net782),
    .S1(net784),
    .X(_2883_));
 sky130_fd_sc_hd__mux2_2 _7021_ (.A0(_2878_),
    .A1(_2883_),
    .S(net780),
    .X(_2884_));
 sky130_fd_sc_hd__nand2_1 _7022_ (.A(_2484_),
    .B(_2884_),
    .Y(_2885_));
 sky130_fd_sc_hd__nand2_1 _7023_ (.A(\decoded_imm[2] ),
    .B(net718),
    .Y(_2886_));
 sky130_fd_sc_hd__o21ai_0 _7024_ (.A1(net718),
    .A2(_2885_),
    .B1(_2886_),
    .Y(_4639_));
 sky130_fd_sc_hd__mux4_2 _7025_ (.A0(\cpuregs[0][1] ),
    .A1(\cpuregs[1][1] ),
    .A2(\cpuregs[2][1] ),
    .A3(\cpuregs[3][1] ),
    .S0(net794),
    .S1(net790),
    .X(_2887_));
 sky130_fd_sc_hd__mux4_2 _7026_ (.A0(\cpuregs[8][1] ),
    .A1(\cpuregs[9][1] ),
    .A2(\cpuregs[10][1] ),
    .A3(\cpuregs[11][1] ),
    .S0(net796),
    .S1(net790),
    .X(_2888_));
 sky130_fd_sc_hd__mux4_2 _7027_ (.A0(\cpuregs[4][1] ),
    .A1(\cpuregs[5][1] ),
    .A2(\cpuregs[6][1] ),
    .A3(\cpuregs[7][1] ),
    .S0(net794),
    .S1(net791),
    .X(_2889_));
 sky130_fd_sc_hd__mux4_2 _7028_ (.A0(\cpuregs[12][1] ),
    .A1(\cpuregs[13][1] ),
    .A2(\cpuregs[14][1] ),
    .A3(\cpuregs[15][1] ),
    .S0(net796),
    .S1(net790),
    .X(_2890_));
 sky130_fd_sc_hd__mux4_2 _7029_ (.A0(_2887_),
    .A1(_2888_),
    .A2(_2889_),
    .A3(_2890_),
    .S0(net782),
    .S1(net784),
    .X(_2891_));
 sky130_fd_sc_hd__mux4_2 _7030_ (.A0(\cpuregs[16][1] ),
    .A1(\cpuregs[17][1] ),
    .A2(\cpuregs[18][1] ),
    .A3(\cpuregs[19][1] ),
    .S0(net794),
    .S1(net790),
    .X(_2892_));
 sky130_fd_sc_hd__mux4_2 _7031_ (.A0(\cpuregs[24][1] ),
    .A1(\cpuregs[25][1] ),
    .A2(\cpuregs[26][1] ),
    .A3(\cpuregs[27][1] ),
    .S0(net796),
    .S1(net790),
    .X(_2893_));
 sky130_fd_sc_hd__mux4_2 _7032_ (.A0(\cpuregs[20][1] ),
    .A1(\cpuregs[21][1] ),
    .A2(\cpuregs[22][1] ),
    .A3(\cpuregs[23][1] ),
    .S0(net794),
    .S1(net791),
    .X(_2894_));
 sky130_fd_sc_hd__mux4_2 _7033_ (.A0(\cpuregs[28][1] ),
    .A1(\cpuregs[29][1] ),
    .A2(\cpuregs[30][1] ),
    .A3(\cpuregs[31][1] ),
    .S0(net794),
    .S1(net790),
    .X(_2895_));
 sky130_fd_sc_hd__mux4_2 _7034_ (.A0(_2892_),
    .A1(_2893_),
    .A2(_2894_),
    .A3(_2895_),
    .S0(net782),
    .S1(net784),
    .X(_2896_));
 sky130_fd_sc_hd__mux2_2 _7035_ (.A0(_2891_),
    .A1(_2896_),
    .S(net780),
    .X(_2897_));
 sky130_fd_sc_hd__nand2_1 _7036_ (.A(_2484_),
    .B(_2897_),
    .Y(_2898_));
 sky130_fd_sc_hd__nand2_1 _7037_ (.A(\decoded_imm[1] ),
    .B(net718),
    .Y(_2899_));
 sky130_fd_sc_hd__o21ai_0 _7038_ (.A1(net718),
    .A2(_2898_),
    .B1(_2899_),
    .Y(_4628_));
 sky130_fd_sc_hd__mux4_2 _7039_ (.A0(\cpuregs[0][0] ),
    .A1(\cpuregs[1][0] ),
    .A2(\cpuregs[2][0] ),
    .A3(\cpuregs[3][0] ),
    .S0(net794),
    .S1(net790),
    .X(_2900_));
 sky130_fd_sc_hd__mux4_2 _7040_ (.A0(\cpuregs[8][0] ),
    .A1(\cpuregs[9][0] ),
    .A2(\cpuregs[10][0] ),
    .A3(\cpuregs[11][0] ),
    .S0(net794),
    .S1(net790),
    .X(_2901_));
 sky130_fd_sc_hd__mux4_2 _7041_ (.A0(\cpuregs[4][0] ),
    .A1(\cpuregs[5][0] ),
    .A2(\cpuregs[6][0] ),
    .A3(\cpuregs[7][0] ),
    .S0(net794),
    .S1(net791),
    .X(_2902_));
 sky130_fd_sc_hd__mux4_2 _7042_ (.A0(\cpuregs[12][0] ),
    .A1(\cpuregs[13][0] ),
    .A2(\cpuregs[14][0] ),
    .A3(\cpuregs[15][0] ),
    .S0(net797),
    .S1(net786),
    .X(_2903_));
 sky130_fd_sc_hd__mux4_2 _7043_ (.A0(_2900_),
    .A1(_2901_),
    .A2(_2902_),
    .A3(_2903_),
    .S0(net782),
    .S1(net784),
    .X(_2904_));
 sky130_fd_sc_hd__mux4_2 _7044_ (.A0(\cpuregs[16][0] ),
    .A1(\cpuregs[17][0] ),
    .A2(\cpuregs[18][0] ),
    .A3(\cpuregs[19][0] ),
    .S0(net794),
    .S1(net790),
    .X(_2905_));
 sky130_fd_sc_hd__mux4_2 _7045_ (.A0(\cpuregs[24][0] ),
    .A1(\cpuregs[25][0] ),
    .A2(\cpuregs[26][0] ),
    .A3(\cpuregs[27][0] ),
    .S0(net796),
    .S1(net790),
    .X(_2906_));
 sky130_fd_sc_hd__mux4_2 _7046_ (.A0(\cpuregs[20][0] ),
    .A1(\cpuregs[21][0] ),
    .A2(\cpuregs[22][0] ),
    .A3(\cpuregs[23][0] ),
    .S0(net794),
    .S1(net791),
    .X(_2907_));
 sky130_fd_sc_hd__mux4_2 _7047_ (.A0(\cpuregs[28][0] ),
    .A1(\cpuregs[29][0] ),
    .A2(\cpuregs[30][0] ),
    .A3(\cpuregs[31][0] ),
    .S0(net794),
    .S1(net790),
    .X(_2908_));
 sky130_fd_sc_hd__mux4_2 _7048_ (.A0(_2905_),
    .A1(_2906_),
    .A2(_2907_),
    .A3(_2908_),
    .S0(net782),
    .S1(net784),
    .X(_2909_));
 sky130_fd_sc_hd__mux2_2 _7049_ (.A0(_2904_),
    .A1(_2909_),
    .S(net780),
    .X(_2910_));
 sky130_fd_sc_hd__nand2_1 _7050_ (.A(_2484_),
    .B(_2910_),
    .Y(_2911_));
 sky130_fd_sc_hd__nand2_1 _7051_ (.A(\decoded_imm[0] ),
    .B(net718),
    .Y(_2912_));
 sky130_fd_sc_hd__o21ai_0 _7052_ (.A1(net718),
    .A2(_2911_),
    .B1(_2912_),
    .Y(_4617_));
 sky130_fd_sc_hd__nor2_1 _7055_ (.A(is_slli_srli_srai),
    .B(_2872_),
    .Y(_2915_));
 sky130_fd_sc_hd__a21oi_1 _7056_ (.A1(\decoded_imm_j[3] ),
    .A2(is_slli_srli_srai),
    .B1(_2915_),
    .Y(_2916_));
 sky130_fd_sc_hd__nor3_1 _7057_ (.A(\reg_sh[2] ),
    .B(\reg_sh[1] ),
    .C(\reg_sh[0] ),
    .Y(_2917_));
 sky130_fd_sc_hd__xnor2_1 _7058_ (.A(_0097_),
    .B(_2917_),
    .Y(_2918_));
 sky130_fd_sc_hd__nand2_1 _7059_ (.A(_0099_),
    .B(_1673_),
    .Y(_2919_));
 sky130_fd_sc_hd__o211ai_1 _7060_ (.A1(_1673_),
    .A2(_2918_),
    .B1(_2919_),
    .C1(net775),
    .Y(_2920_));
 sky130_fd_sc_hd__o21ai_0 _7061_ (.A1(net775),
    .A2(_2916_),
    .B1(_2920_),
    .Y(_0039_));
 sky130_fd_sc_hd__nor2_1 _7062_ (.A(is_slli_srli_srai),
    .B(_2885_),
    .Y(_2921_));
 sky130_fd_sc_hd__a21oi_1 _7063_ (.A1(\decoded_imm_j[2] ),
    .A2(is_slli_srli_srai),
    .B1(_2921_),
    .Y(_2922_));
 sky130_fd_sc_hd__nor2_1 _7064_ (.A(_0117_),
    .B(net697),
    .Y(_2923_));
 sky130_fd_sc_hd__nor2_1 _7065_ (.A(\reg_sh[2] ),
    .B(_2923_),
    .Y(_2924_));
 sky130_fd_sc_hd__nand2_1 _7066_ (.A(net775),
    .B(_2924_),
    .Y(_2925_));
 sky130_fd_sc_hd__o21ai_0 _7067_ (.A1(net775),
    .A2(_2922_),
    .B1(_2925_),
    .Y(_0038_));
 sky130_fd_sc_hd__nor2_1 _7068_ (.A(is_slli_srli_srai),
    .B(_2898_),
    .Y(_2926_));
 sky130_fd_sc_hd__a21oi_1 _7069_ (.A1(\decoded_imm_j[1] ),
    .A2(is_slli_srli_srai),
    .B1(_2926_),
    .Y(_2927_));
 sky130_fd_sc_hd__nor2_1 _7070_ (.A(_0118_),
    .B(_1673_),
    .Y(_2928_));
 sky130_fd_sc_hd__nand2_1 _7071_ (.A(net775),
    .B(_2928_),
    .Y(_2929_));
 sky130_fd_sc_hd__o21ai_0 _7072_ (.A1(net775),
    .A2(_2927_),
    .B1(_2929_),
    .Y(_0037_));
 sky130_fd_sc_hd__nor2_1 _7073_ (.A(is_slli_srli_srai),
    .B(_2911_),
    .Y(_2930_));
 sky130_fd_sc_hd__a21oi_1 _7074_ (.A1(\decoded_imm_j[11] ),
    .A2(is_slli_srli_srai),
    .B1(_2930_),
    .Y(_2931_));
 sky130_fd_sc_hd__nand3_1 _7075_ (.A(_0115_),
    .B(net775),
    .C(net696),
    .Y(_2932_));
 sky130_fd_sc_hd__o21ai_0 _7076_ (.A1(net775),
    .A2(_2931_),
    .B1(_2932_),
    .Y(_0036_));
 sky130_fd_sc_hd__a222oi_1 _7086_ (.A1(\count_instr[30] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[62] ),
    .C1(\count_cycle[62] ),
    .C2(net770),
    .Y(_2942_));
 sky130_fd_sc_hd__nor3_2 _7087_ (.A(net770),
    .B(net769),
    .C(net768),
    .Y(_2943_));
 sky130_fd_sc_hd__nand2_1 _7089_ (.A(\count_cycle[30] ),
    .B(net717),
    .Y(_2945_));
 sky130_fd_sc_hd__nand2_1 _7090_ (.A(_2942_),
    .B(_2945_),
    .Y(_2946_));
 sky130_fd_sc_hd__nor3_2 _7091_ (.A(net776),
    .B(net775),
    .C(net777),
    .Y(_2947_));
 sky130_fd_sc_hd__a221oi_1 _7093_ (.A1(net742),
    .A2(net775),
    .B1(net777),
    .B2(_2946_),
    .C1(net716),
    .Y(_2949_));
 sky130_fd_sc_hd__a211oi_1 _7097_ (.A1(_0089_),
    .A2(_0055_),
    .B1(_0212_),
    .C1(_0253_),
    .Y(_2953_));
 sky130_fd_sc_hd__o21ai_0 _7098_ (.A1(_0213_),
    .A2(_0212_),
    .B1(_0450_),
    .Y(_2954_));
 sky130_fd_sc_hd__a2111oi_0 _7099_ (.A1(_0419_),
    .A2(_0082_),
    .B1(_0249_),
    .C1(_0449_),
    .D1(_0418_),
    .Y(_2955_));
 sky130_fd_sc_hd__o21ai_0 _7100_ (.A1(_2953_),
    .A2(_2954_),
    .B1(_2955_),
    .Y(_2956_));
 sky130_fd_sc_hd__o211ai_1 _7101_ (.A1(_0250_),
    .A2(_0249_),
    .B1(_0419_),
    .C1(_0083_),
    .Y(_2957_));
 sky130_fd_sc_hd__a21oi_1 _7102_ (.A1(_0419_),
    .A2(_0082_),
    .B1(_0418_),
    .Y(_2958_));
 sky130_fd_sc_hd__nand2_1 _7103_ (.A(_2957_),
    .B(_2958_),
    .Y(_2959_));
 sky130_fd_sc_hd__and3_1 _7104_ (.A(_0112_),
    .B(_0107_),
    .C(_0114_),
    .X(_2960_));
 sky130_fd_sc_hd__a21o_1 _7105_ (.A1(_0107_),
    .A2(_0113_),
    .B1(_0106_),
    .X(_2961_));
 sky130_fd_sc_hd__a32oi_1 _7106_ (.A1(_2956_),
    .A2(_2959_),
    .A3(_2960_),
    .B1(_2961_),
    .B2(_0112_),
    .Y(_2962_));
 sky130_fd_sc_hd__nand2_1 _7109_ (.A(_0121_),
    .B(_0469_),
    .Y(_2965_));
 sky130_fd_sc_hd__nand2_1 _7111_ (.A(_0158_),
    .B(_0225_),
    .Y(_2967_));
 sky130_fd_sc_hd__nor2_1 _7112_ (.A(_2965_),
    .B(_2967_),
    .Y(_2968_));
 sky130_fd_sc_hd__nand4_1 _7113_ (.A(_0448_),
    .B(_0125_),
    .C(_0209_),
    .D(_2968_),
    .Y(_2969_));
 sky130_fd_sc_hd__a21oi_1 _7114_ (.A1(_0209_),
    .A2(_0111_),
    .B1(_0208_),
    .Y(_2970_));
 sky130_fd_sc_hd__nand2_1 _7115_ (.A(_0448_),
    .B(_0125_),
    .Y(_2971_));
 sky130_fd_sc_hd__a21oi_1 _7116_ (.A1(_0448_),
    .A2(_0124_),
    .B1(_0447_),
    .Y(_2972_));
 sky130_fd_sc_hd__o21ai_0 _7117_ (.A1(_2970_),
    .A2(_2971_),
    .B1(_2972_),
    .Y(_2973_));
 sky130_fd_sc_hd__a21oi_1 _7118_ (.A1(_0158_),
    .A2(_0224_),
    .B1(_0157_),
    .Y(_2974_));
 sky130_fd_sc_hd__a21oi_1 _7119_ (.A1(_0121_),
    .A2(_0468_),
    .B1(_0120_),
    .Y(_2975_));
 sky130_fd_sc_hd__o21ai_0 _7120_ (.A1(_2965_),
    .A2(_2974_),
    .B1(_2975_),
    .Y(_2976_));
 sky130_fd_sc_hd__a21oi_1 _7121_ (.A1(_2968_),
    .A2(_2973_),
    .B1(_2976_),
    .Y(_2977_));
 sky130_fd_sc_hd__o21ai_0 _7122_ (.A1(_2962_),
    .A2(_2969_),
    .B1(_2977_),
    .Y(_2978_));
 sky130_fd_sc_hd__inv_1 _7123_ (.A(_0143_),
    .Y(_2979_));
 sky130_fd_sc_hd__a21oi_1 _7124_ (.A1(_0466_),
    .A2(_0219_),
    .B1(_0465_),
    .Y(_2980_));
 sky130_fd_sc_hd__inv_1 _7125_ (.A(_0142_),
    .Y(_2981_));
 sky130_fd_sc_hd__o21ai_0 _7126_ (.A1(_2979_),
    .A2(_2980_),
    .B1(_2981_),
    .Y(_2982_));
 sky130_fd_sc_hd__a41oi_1 _7127_ (.A1(_0143_),
    .A2(_0466_),
    .A3(_0220_),
    .A4(_2978_),
    .B1(_2982_),
    .Y(_2983_));
 sky130_fd_sc_hd__nand2_1 _7128_ (.A(_0207_),
    .B(_0215_),
    .Y(_2984_));
 sky130_fd_sc_hd__nand2_1 _7130_ (.A(_0211_),
    .B(_0248_),
    .Y(_2986_));
 sky130_fd_sc_hd__nor2_1 _7131_ (.A(_2984_),
    .B(_2986_),
    .Y(_2987_));
 sky130_fd_sc_hd__nand2_1 _7132_ (.A(_0123_),
    .B(_2987_),
    .Y(_2988_));
 sky130_fd_sc_hd__nand2_1 _7133_ (.A(_0211_),
    .B(_0247_),
    .Y(_2989_));
 sky130_fd_sc_hd__a21o_1 _7134_ (.A1(_0215_),
    .A2(_0210_),
    .B1(_0214_),
    .X(_2990_));
 sky130_fd_sc_hd__a21oi_1 _7135_ (.A1(_0207_),
    .A2(_2990_),
    .B1(_0206_),
    .Y(_2991_));
 sky130_fd_sc_hd__o21ai_0 _7136_ (.A1(_2984_),
    .A2(_2989_),
    .B1(_2991_),
    .Y(_2992_));
 sky130_fd_sc_hd__nand2_1 _7137_ (.A(_0123_),
    .B(_2992_),
    .Y(_2993_));
 sky130_fd_sc_hd__nor3_1 _7138_ (.A(_0146_),
    .B(_0251_),
    .C(_0122_),
    .Y(_2994_));
 sky130_fd_sc_hd__o211ai_1 _7139_ (.A1(_2983_),
    .A2(_2988_),
    .B1(_2993_),
    .C1(_2994_),
    .Y(_2995_));
 sky130_fd_sc_hd__nor3_1 _7140_ (.A(_0252_),
    .B(_0146_),
    .C(_0251_),
    .Y(_2996_));
 sky130_fd_sc_hd__nor2_1 _7141_ (.A(_0147_),
    .B(_0146_),
    .Y(_2997_));
 sky130_fd_sc_hd__nor2_1 _7142_ (.A(_2996_),
    .B(_2997_),
    .Y(_2998_));
 sky130_fd_sc_hd__a21o_1 _7143_ (.A1(_0456_),
    .A2(_0302_),
    .B1(_0455_),
    .X(_2999_));
 sky130_fd_sc_hd__a41oi_1 _7144_ (.A1(_0456_),
    .A2(_0303_),
    .A3(_2995_),
    .A4(_2998_),
    .B1(_2999_),
    .Y(_3000_));
 sky130_fd_sc_hd__xnor2_1 _7145_ (.A(_0464_),
    .B(_3000_),
    .Y(_3001_));
 sky130_fd_sc_hd__nand2_1 _7146_ (.A(net776),
    .B(_3001_),
    .Y(_3002_));
 sky130_fd_sc_hd__nor3_2 _7147_ (.A(latched_is_lh),
    .B(latched_is_lb),
    .C(_0945_),
    .Y(_3003_));
 sky130_fd_sc_hd__mux2_2 _7149_ (.A0(net144),
    .A1(net162),
    .S(net753),
    .X(_3005_));
 sky130_fd_sc_hd__a22o_1 _7150_ (.A1(net144),
    .A2(net730),
    .B1(_3005_),
    .B2(net765),
    .X(_3006_));
 sky130_fd_sc_hd__o21ai_0 _7151_ (.A1(net753),
    .A2(net764),
    .B1(_0945_),
    .Y(_3007_));
 sky130_fd_sc_hd__mux2_2 _7152_ (.A0(net167),
    .A1(net153),
    .S(net753),
    .X(_3008_));
 sky130_fd_sc_hd__a22oi_1 _7153_ (.A1(net167),
    .A2(_3007_),
    .B1(_3008_),
    .B2(net765),
    .Y(_3009_));
 sky130_fd_sc_hd__mux2i_1 _7154_ (.A0(net153),
    .A1(net162),
    .S(net764),
    .Y(_3010_));
 sky130_fd_sc_hd__nand3_1 _7155_ (.A(_0061_),
    .B(net144),
    .C(net764),
    .Y(_3011_));
 sky130_fd_sc_hd__o21ai_0 _7156_ (.A1(_0061_),
    .A2(_3010_),
    .B1(_3011_),
    .Y(_3012_));
 sky130_fd_sc_hd__nand2_1 _7157_ (.A(net766),
    .B(_3012_),
    .Y(_3013_));
 sky130_fd_sc_hd__nand2_1 _7158_ (.A(_3009_),
    .B(_3013_),
    .Y(_3014_));
 sky130_fd_sc_hd__or3_1 _7159_ (.A(net776),
    .B(net775),
    .C(\cpu_state[2] ),
    .X(_3015_));
 sky130_fd_sc_hd__a21o_1 _7160_ (.A1(latched_is_lb),
    .A2(_3014_),
    .B1(_3015_),
    .X(_3016_));
 sky130_fd_sc_hd__a21o_1 _7162_ (.A1(latched_is_lh),
    .A2(_3006_),
    .B1(_3016_),
    .X(_3018_));
 sky130_fd_sc_hd__a21oi_1 _7164_ (.A1(net826),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3020_));
 sky130_fd_sc_hd__a21oi_1 _7165_ (.A1(_2949_),
    .A2(_3002_),
    .B1(_3020_),
    .Y(_0027_));
 sky130_fd_sc_hd__inv_1 _7166_ (.A(net776),
    .Y(_3021_));
 sky130_fd_sc_hd__o21a_1 _7168_ (.A1(_0158_),
    .A2(_0157_),
    .B1(_0469_),
    .X(_3023_));
 sky130_fd_sc_hd__nor2_1 _7169_ (.A(_0468_),
    .B(_3023_),
    .Y(_3024_));
 sky130_fd_sc_hd__and4_1 _7170_ (.A(_0143_),
    .B(_0466_),
    .C(_0220_),
    .D(_0121_),
    .X(_3025_));
 sky130_fd_sc_hd__and3_1 _7171_ (.A(_0211_),
    .B(_0248_),
    .C(_3025_),
    .X(_3026_));
 sky130_fd_sc_hd__nor3b_1 _7172_ (.A(_2984_),
    .B(_3024_),
    .C_N(_3026_),
    .Y(_3027_));
 sky130_fd_sc_hd__inv_1 _7173_ (.A(_0107_),
    .Y(_3028_));
 sky130_fd_sc_hd__o211ai_1 _7174_ (.A1(_0112_),
    .A2(_0111_),
    .B1(_0125_),
    .C1(_0209_),
    .Y(_3029_));
 sky130_fd_sc_hd__a21o_1 _7175_ (.A1(_0213_),
    .A2(_0056_),
    .B1(_0212_),
    .X(_3030_));
 sky130_fd_sc_hd__a21o_1 _7176_ (.A1(_0450_),
    .A2(_3030_),
    .B1(_0449_),
    .X(_3031_));
 sky130_fd_sc_hd__a2111o_1 _7177_ (.A1(_0250_),
    .A2(_3031_),
    .B1(_0249_),
    .C1(_0082_),
    .D1(_0418_),
    .X(_3032_));
 sky130_fd_sc_hd__nor3_1 _7178_ (.A(_0083_),
    .B(_0418_),
    .C(_0082_),
    .Y(_3033_));
 sky130_fd_sc_hd__nor2_1 _7179_ (.A(_0419_),
    .B(_0418_),
    .Y(_3034_));
 sky130_fd_sc_hd__nor2_1 _7180_ (.A(_3033_),
    .B(_3034_),
    .Y(_3035_));
 sky130_fd_sc_hd__a31oi_1 _7181_ (.A1(_0114_),
    .A2(_3032_),
    .A3(_3035_),
    .B1(_0113_),
    .Y(_3036_));
 sky130_fd_sc_hd__a21o_1 _7182_ (.A1(_0112_),
    .A2(_0106_),
    .B1(_0111_),
    .X(_3037_));
 sky130_fd_sc_hd__a21o_1 _7183_ (.A1(_0209_),
    .A2(_3037_),
    .B1(_0208_),
    .X(_3038_));
 sky130_fd_sc_hd__a21oi_1 _7184_ (.A1(_0125_),
    .A2(_3038_),
    .B1(_0124_),
    .Y(_3039_));
 sky130_fd_sc_hd__o31ai_1 _7185_ (.A1(_3028_),
    .A2(_3029_),
    .A3(_3036_),
    .B1(_3039_),
    .Y(_3040_));
 sky130_fd_sc_hd__a21o_1 _7186_ (.A1(_0220_),
    .A2(_0120_),
    .B1(_0219_),
    .X(_3041_));
 sky130_fd_sc_hd__a21oi_1 _7187_ (.A1(_0466_),
    .A2(_3041_),
    .B1(_0465_),
    .Y(_3042_));
 sky130_fd_sc_hd__nor2_1 _7188_ (.A(_2979_),
    .B(_3042_),
    .Y(_3043_));
 sky130_fd_sc_hd__nor3_1 _7189_ (.A(_0248_),
    .B(_0210_),
    .C(_0247_),
    .Y(_3044_));
 sky130_fd_sc_hd__nor2_1 _7190_ (.A(_0211_),
    .B(_0210_),
    .Y(_3045_));
 sky130_fd_sc_hd__nor2_1 _7191_ (.A(_3044_),
    .B(_3045_),
    .Y(_3046_));
 sky130_fd_sc_hd__o41ai_1 _7192_ (.A1(_0210_),
    .A2(_0247_),
    .A3(_0142_),
    .A4(_3043_),
    .B1(_3046_),
    .Y(_3047_));
 sky130_fd_sc_hd__nand2_1 _7193_ (.A(_0225_),
    .B(_0447_),
    .Y(_3048_));
 sky130_fd_sc_hd__a211oi_1 _7194_ (.A1(_0469_),
    .A2(_0157_),
    .B1(_0224_),
    .C1(_0468_),
    .Y(_3049_));
 sky130_fd_sc_hd__nand2_1 _7195_ (.A(_3048_),
    .B(_3049_),
    .Y(_3050_));
 sky130_fd_sc_hd__a221oi_1 _7196_ (.A1(_0207_),
    .A2(_0214_),
    .B1(_3027_),
    .B2(_3050_),
    .C1(_0206_),
    .Y(_3051_));
 sky130_fd_sc_hd__o21ai_0 _7197_ (.A1(_2984_),
    .A2(_3047_),
    .B1(_3051_),
    .Y(_3052_));
 sky130_fd_sc_hd__a41o_1 _7198_ (.A1(_0225_),
    .A2(_0448_),
    .A3(_3027_),
    .A4(_3040_),
    .B1(_3052_),
    .X(_3053_));
 sky130_fd_sc_hd__and3_1 _7199_ (.A(_0303_),
    .B(_0147_),
    .C(_0252_),
    .X(_3054_));
 sky130_fd_sc_hd__a21o_1 _7200_ (.A1(_0252_),
    .A2(_0122_),
    .B1(_0251_),
    .X(_3055_));
 sky130_fd_sc_hd__a21oi_1 _7201_ (.A1(_0147_),
    .A2(_3055_),
    .B1(_0146_),
    .Y(_3056_));
 sky130_fd_sc_hd__nor2b_1 _7202_ (.A(_3056_),
    .B_N(_0303_),
    .Y(_3057_));
 sky130_fd_sc_hd__a311oi_2 _7203_ (.A1(_0123_),
    .A2(_3053_),
    .A3(_3054_),
    .B1(_3057_),
    .C1(_0302_),
    .Y(_3058_));
 sky130_fd_sc_hd__xor2_1 _7204_ (.A(_0456_),
    .B(_3058_),
    .X(_3059_));
 sky130_fd_sc_hd__a222oi_1 _7209_ (.A1(\count_instr[29] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[61] ),
    .C1(\count_cycle[61] ),
    .C2(net770),
    .Y(_3064_));
 sky130_fd_sc_hd__nand2_1 _7211_ (.A(\count_cycle[29] ),
    .B(net717),
    .Y(_3066_));
 sky130_fd_sc_hd__nand2_1 _7212_ (.A(_3064_),
    .B(_3066_),
    .Y(_3067_));
 sky130_fd_sc_hd__a221oi_1 _7214_ (.A1(net743),
    .A2(net775),
    .B1(net777),
    .B2(_3067_),
    .C1(net716),
    .Y(_3069_));
 sky130_fd_sc_hd__a21oi_1 _7215_ (.A1(net159),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3070_));
 sky130_fd_sc_hd__o22ai_1 _7216_ (.A1(_3021_),
    .A2(_3059_),
    .B1(_3069_),
    .B2(_3070_),
    .Y(_0025_));
 sky130_fd_sc_hd__a222oi_1 _7217_ (.A1(\count_instr[28] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[60] ),
    .C1(\count_cycle[60] ),
    .C2(net770),
    .Y(_3071_));
 sky130_fd_sc_hd__nand2_1 _7218_ (.A(\count_cycle[28] ),
    .B(net717),
    .Y(_3072_));
 sky130_fd_sc_hd__nand2_1 _7219_ (.A(_3071_),
    .B(_3072_),
    .Y(_3073_));
 sky130_fd_sc_hd__a221oi_1 _7220_ (.A1(net744),
    .A2(net775),
    .B1(net777),
    .B2(_3073_),
    .C1(net716),
    .Y(_3074_));
 sky130_fd_sc_hd__nand2_1 _7221_ (.A(_2995_),
    .B(_2998_),
    .Y(_3075_));
 sky130_fd_sc_hd__xnor2_1 _7222_ (.A(_0303_),
    .B(_3075_),
    .Y(_3076_));
 sky130_fd_sc_hd__nand2_1 _7223_ (.A(net776),
    .B(_3076_),
    .Y(_3077_));
 sky130_fd_sc_hd__a21oi_1 _7224_ (.A1(net158),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3078_));
 sky130_fd_sc_hd__a21oi_1 _7225_ (.A1(_3074_),
    .A2(_3077_),
    .B1(_3078_),
    .Y(_0024_));
 sky130_fd_sc_hd__a31oi_1 _7226_ (.A1(_0252_),
    .A2(_0123_),
    .A3(_3053_),
    .B1(_3055_),
    .Y(_3079_));
 sky130_fd_sc_hd__xor2_1 _7227_ (.A(_0147_),
    .B(_3079_),
    .X(_3080_));
 sky130_fd_sc_hd__a222oi_1 _7228_ (.A1(\count_instr[27] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[59] ),
    .C1(\count_cycle[59] ),
    .C2(net770),
    .Y(_3081_));
 sky130_fd_sc_hd__nand2_1 _7229_ (.A(\count_cycle[27] ),
    .B(net717),
    .Y(_3082_));
 sky130_fd_sc_hd__nand2_1 _7230_ (.A(_3081_),
    .B(_3082_),
    .Y(_3083_));
 sky130_fd_sc_hd__a221oi_1 _7231_ (.A1(net745),
    .A2(net775),
    .B1(net777),
    .B2(_3083_),
    .C1(net716),
    .Y(_3084_));
 sky130_fd_sc_hd__a21oi_1 _7232_ (.A1(net157),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3085_));
 sky130_fd_sc_hd__o22ai_1 _7233_ (.A1(_3021_),
    .A2(_3080_),
    .B1(_3084_),
    .B2(_3085_),
    .Y(_0023_));
 sky130_fd_sc_hd__a222oi_1 _7234_ (.A1(\count_instr[26] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[58] ),
    .C1(\count_cycle[58] ),
    .C2(net770),
    .Y(_3086_));
 sky130_fd_sc_hd__nand2_1 _7235_ (.A(\count_cycle[26] ),
    .B(net717),
    .Y(_3087_));
 sky130_fd_sc_hd__nand2_1 _7236_ (.A(_3086_),
    .B(_3087_),
    .Y(_3088_));
 sky130_fd_sc_hd__a221oi_1 _7237_ (.A1(net746),
    .A2(net775),
    .B1(net777),
    .B2(_3088_),
    .C1(net716),
    .Y(_3089_));
 sky130_fd_sc_hd__o21ai_0 _7239_ (.A1(_2983_),
    .A2(_2988_),
    .B1(_2993_),
    .Y(_3091_));
 sky130_fd_sc_hd__o21ai_0 _7240_ (.A1(_0122_),
    .A2(_3091_),
    .B1(_0252_),
    .Y(_3092_));
 sky130_fd_sc_hd__or3_1 _7241_ (.A(_0252_),
    .B(_0122_),
    .C(_3091_),
    .X(_3093_));
 sky130_fd_sc_hd__nand3_1 _7242_ (.A(net776),
    .B(_3092_),
    .C(_3093_),
    .Y(_3094_));
 sky130_fd_sc_hd__a21oi_1 _7243_ (.A1(net156),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3095_));
 sky130_fd_sc_hd__a21oi_1 _7244_ (.A1(_3089_),
    .A2(_3094_),
    .B1(_3095_),
    .Y(_0022_));
 sky130_fd_sc_hd__a222oi_1 _7245_ (.A1(\count_instr[25] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[57] ),
    .C1(\count_cycle[57] ),
    .C2(net770),
    .Y(_3096_));
 sky130_fd_sc_hd__nand2_1 _7246_ (.A(\count_cycle[25] ),
    .B(net717),
    .Y(_3097_));
 sky130_fd_sc_hd__nand2_1 _7247_ (.A(_3096_),
    .B(_3097_),
    .Y(_3098_));
 sky130_fd_sc_hd__a221oi_1 _7248_ (.A1(net747),
    .A2(net775),
    .B1(net777),
    .B2(_3098_),
    .C1(net716),
    .Y(_3099_));
 sky130_fd_sc_hd__xor2_1 _7249_ (.A(_0123_),
    .B(_3053_),
    .X(_3100_));
 sky130_fd_sc_hd__nand2_1 _7250_ (.A(net776),
    .B(_3100_),
    .Y(_3101_));
 sky130_fd_sc_hd__a21oi_1 _7251_ (.A1(net827),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3102_));
 sky130_fd_sc_hd__a21oi_1 _7252_ (.A1(_3099_),
    .A2(_3101_),
    .B1(_3102_),
    .Y(_0021_));
 sky130_fd_sc_hd__nor2_1 _7253_ (.A(_3021_),
    .B(_0207_),
    .Y(_3103_));
 sky130_fd_sc_hd__nand2_1 _7254_ (.A(net776),
    .B(_0207_),
    .Y(_3104_));
 sky130_fd_sc_hd__nor2_1 _7255_ (.A(_0214_),
    .B(_3104_),
    .Y(_3105_));
 sky130_fd_sc_hd__nand3_1 _7256_ (.A(_0248_),
    .B(_0469_),
    .C(_3025_),
    .Y(_3106_));
 sky130_fd_sc_hd__inv_1 _7257_ (.A(_0225_),
    .Y(_3107_));
 sky130_fd_sc_hd__a32o_1 _7258_ (.A1(_2956_),
    .A2(_2959_),
    .A3(_2960_),
    .B1(_2961_),
    .B2(_0112_),
    .X(_3108_));
 sky130_fd_sc_hd__a41oi_1 _7259_ (.A1(_0448_),
    .A2(_0125_),
    .A3(_0209_),
    .A4(_3108_),
    .B1(_2973_),
    .Y(_3109_));
 sky130_fd_sc_hd__o21bai_1 _7260_ (.A1(_3107_),
    .A2(_3109_),
    .B1_N(_0224_),
    .Y(_3110_));
 sky130_fd_sc_hd__a21oi_1 _7261_ (.A1(_0158_),
    .A2(_3110_),
    .B1(_0157_),
    .Y(_3111_));
 sky130_fd_sc_hd__inv_1 _7262_ (.A(_0220_),
    .Y(_3112_));
 sky130_fd_sc_hd__o21bai_1 _7263_ (.A1(_3112_),
    .A2(_2975_),
    .B1_N(_0219_),
    .Y(_3113_));
 sky130_fd_sc_hd__a21o_1 _7264_ (.A1(_0466_),
    .A2(_3113_),
    .B1(_0465_),
    .X(_3114_));
 sky130_fd_sc_hd__nand2_1 _7265_ (.A(_0143_),
    .B(_3114_),
    .Y(_3115_));
 sky130_fd_sc_hd__nand2_1 _7266_ (.A(_2981_),
    .B(_3115_),
    .Y(_3116_));
 sky130_fd_sc_hd__a211oi_1 _7267_ (.A1(_0248_),
    .A2(_3116_),
    .B1(_0247_),
    .C1(_0210_),
    .Y(_3117_));
 sky130_fd_sc_hd__o21ai_0 _7268_ (.A1(_3106_),
    .A2(_3111_),
    .B1(_3117_),
    .Y(_3118_));
 sky130_fd_sc_hd__nand3b_1 _7269_ (.A_N(_3045_),
    .B(_3118_),
    .C(_0215_),
    .Y(_3119_));
 sky130_fd_sc_hd__mux2i_1 _7270_ (.A0(_3103_),
    .A1(_3105_),
    .S(_3119_),
    .Y(_3120_));
 sky130_fd_sc_hd__a21oi_1 _7271_ (.A1(net154),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3121_));
 sky130_fd_sc_hd__a222oi_1 _7272_ (.A1(\count_instr[24] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[56] ),
    .C1(\count_cycle[56] ),
    .C2(net770),
    .Y(_3122_));
 sky130_fd_sc_hd__nand2_1 _7273_ (.A(\count_cycle[24] ),
    .B(net717),
    .Y(_3123_));
 sky130_fd_sc_hd__nand2_1 _7274_ (.A(_3122_),
    .B(_3123_),
    .Y(_3124_));
 sky130_fd_sc_hd__a221oi_1 _7276_ (.A1(net748),
    .A2(net775),
    .B1(net777),
    .B2(_3124_),
    .C1(net716),
    .Y(_3126_));
 sky130_fd_sc_hd__a2bb2oi_1 _7277_ (.A1_N(_3121_),
    .A2_N(_3126_),
    .B1(_3103_),
    .B2(_0214_),
    .Y(_3127_));
 sky130_fd_sc_hd__nand2_1 _7278_ (.A(_3120_),
    .B(_3127_),
    .Y(_0020_));
 sky130_fd_sc_hd__nand2_1 _7279_ (.A(_0225_),
    .B(_0448_),
    .Y(_3128_));
 sky130_fd_sc_hd__nor2_1 _7280_ (.A(_3024_),
    .B(_3128_),
    .Y(_3129_));
 sky130_fd_sc_hd__a21oi_1 _7281_ (.A1(_3048_),
    .A2(_3049_),
    .B1(_3024_),
    .Y(_3130_));
 sky130_fd_sc_hd__a21o_1 _7282_ (.A1(_3040_),
    .A2(_3129_),
    .B1(_3130_),
    .X(_3131_));
 sky130_fd_sc_hd__a21boi_0 _7283_ (.A1(_3026_),
    .A2(_3131_),
    .B1_N(_3047_),
    .Y(_3132_));
 sky130_fd_sc_hd__xor2_1 _7284_ (.A(_0215_),
    .B(_3132_),
    .X(_3133_));
 sky130_fd_sc_hd__a222oi_1 _7285_ (.A1(\count_instr[23] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[55] ),
    .C1(\count_cycle[55] ),
    .C2(net770),
    .Y(_3134_));
 sky130_fd_sc_hd__nand2_1 _7286_ (.A(\count_cycle[23] ),
    .B(net717),
    .Y(_3135_));
 sky130_fd_sc_hd__nand2_1 _7287_ (.A(_3134_),
    .B(_3135_),
    .Y(_3136_));
 sky130_fd_sc_hd__a221oi_1 _7288_ (.A1(net749),
    .A2(net775),
    .B1(net777),
    .B2(_3136_),
    .C1(net716),
    .Y(_3137_));
 sky130_fd_sc_hd__a21oi_1 _7289_ (.A1(net153),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3138_));
 sky130_fd_sc_hd__o22ai_1 _7290_ (.A1(_3021_),
    .A2(_3133_),
    .B1(_3137_),
    .B2(_3138_),
    .Y(_0019_));
 sky130_fd_sc_hd__inv_1 _7291_ (.A(_2983_),
    .Y(_3139_));
 sky130_fd_sc_hd__a21oi_1 _7292_ (.A1(_0248_),
    .A2(_3139_),
    .B1(_0247_),
    .Y(_3140_));
 sky130_fd_sc_hd__xnor2_1 _7293_ (.A(_0211_),
    .B(_3140_),
    .Y(_3141_));
 sky130_fd_sc_hd__nand2_1 _7294_ (.A(net776),
    .B(_3141_),
    .Y(_3142_));
 sky130_fd_sc_hd__a222oi_1 _7295_ (.A1(\count_instr[22] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[54] ),
    .C1(\count_cycle[54] ),
    .C2(net770),
    .Y(_3143_));
 sky130_fd_sc_hd__nand2_1 _7296_ (.A(\count_cycle[22] ),
    .B(net717),
    .Y(_3144_));
 sky130_fd_sc_hd__nand2_1 _7297_ (.A(_3143_),
    .B(_3144_),
    .Y(_3145_));
 sky130_fd_sc_hd__a221oi_1 _7298_ (.A1(net750),
    .A2(net775),
    .B1(net777),
    .B2(_3145_),
    .C1(net716),
    .Y(_3146_));
 sky130_fd_sc_hd__a21oi_1 _7299_ (.A1(net152),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3147_));
 sky130_fd_sc_hd__a21oi_1 _7300_ (.A1(_3142_),
    .A2(_3146_),
    .B1(_3147_),
    .Y(_0018_));
 sky130_fd_sc_hd__o21ai_0 _7301_ (.A1(_2979_),
    .A2(_3042_),
    .B1(_2981_),
    .Y(_3148_));
 sky130_fd_sc_hd__a21oi_1 _7302_ (.A1(_3025_),
    .A2(_3131_),
    .B1(_3148_),
    .Y(_3149_));
 sky130_fd_sc_hd__xor2_1 _7303_ (.A(_0248_),
    .B(_3149_),
    .X(_3150_));
 sky130_fd_sc_hd__a222oi_1 _7304_ (.A1(\count_instr[21] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[53] ),
    .C1(\count_cycle[53] ),
    .C2(net770),
    .Y(_3151_));
 sky130_fd_sc_hd__nand2_1 _7305_ (.A(\count_cycle[21] ),
    .B(net717),
    .Y(_3152_));
 sky130_fd_sc_hd__nand2_1 _7306_ (.A(_3151_),
    .B(_3152_),
    .Y(_3153_));
 sky130_fd_sc_hd__a221oi_1 _7307_ (.A1(net751),
    .A2(net775),
    .B1(net777),
    .B2(_3153_),
    .C1(net716),
    .Y(_3154_));
 sky130_fd_sc_hd__a21oi_1 _7308_ (.A1(net151),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3155_));
 sky130_fd_sc_hd__o22ai_1 _7309_ (.A1(_3021_),
    .A2(_3150_),
    .B1(_3154_),
    .B2(_3155_),
    .Y(_0017_));
 sky130_fd_sc_hd__nand4_1 _7310_ (.A(_0466_),
    .B(_0220_),
    .C(_0121_),
    .D(_0469_),
    .Y(_3156_));
 sky130_fd_sc_hd__o21bai_1 _7311_ (.A1(_3111_),
    .A2(_3156_),
    .B1_N(_3114_),
    .Y(_3157_));
 sky130_fd_sc_hd__xnor2_1 _7312_ (.A(_0143_),
    .B(_3157_),
    .Y(_3158_));
 sky130_fd_sc_hd__a222oi_1 _7313_ (.A1(\count_instr[20] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[52] ),
    .C1(\count_cycle[52] ),
    .C2(net770),
    .Y(_3159_));
 sky130_fd_sc_hd__nand2_1 _7314_ (.A(\count_cycle[20] ),
    .B(net717),
    .Y(_3160_));
 sky130_fd_sc_hd__nand2_1 _7315_ (.A(_3159_),
    .B(_3160_),
    .Y(_3161_));
 sky130_fd_sc_hd__a221oi_1 _7316_ (.A1(net752),
    .A2(net775),
    .B1(net777),
    .B2(_3161_),
    .C1(net716),
    .Y(_3162_));
 sky130_fd_sc_hd__a21oi_1 _7317_ (.A1(net150),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3163_));
 sky130_fd_sc_hd__o22ai_1 _7318_ (.A1(_3021_),
    .A2(_3158_),
    .B1(_3162_),
    .B2(_3163_),
    .Y(_0016_));
 sky130_fd_sc_hd__nor2_1 _7319_ (.A(_3021_),
    .B(_0466_),
    .Y(_3164_));
 sky130_fd_sc_hd__a21oi_1 _7320_ (.A1(_0121_),
    .A2(_3131_),
    .B1(_0120_),
    .Y(_3165_));
 sky130_fd_sc_hd__nand2_1 _7321_ (.A(net776),
    .B(_0466_),
    .Y(_3166_));
 sky130_fd_sc_hd__nor2_1 _7322_ (.A(_0219_),
    .B(_3166_),
    .Y(_3167_));
 sky130_fd_sc_hd__o21ai_0 _7323_ (.A1(_3112_),
    .A2(_3165_),
    .B1(_3167_),
    .Y(_3168_));
 sky130_fd_sc_hd__o41ai_1 _7324_ (.A1(_3021_),
    .A2(_0466_),
    .A3(_3112_),
    .A4(_3165_),
    .B1(_3168_),
    .Y(_3169_));
 sky130_fd_sc_hd__a21oi_1 _7325_ (.A1(net148),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3170_));
 sky130_fd_sc_hd__a222oi_1 _7326_ (.A1(\count_instr[19] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[51] ),
    .C1(\count_cycle[51] ),
    .C2(net770),
    .Y(_3171_));
 sky130_fd_sc_hd__nand2_1 _7327_ (.A(\count_cycle[19] ),
    .B(net717),
    .Y(_3172_));
 sky130_fd_sc_hd__nand2_1 _7328_ (.A(_3171_),
    .B(_3172_),
    .Y(_3173_));
 sky130_fd_sc_hd__a221oi_1 _7329_ (.A1(net754),
    .A2(net775),
    .B1(net777),
    .B2(_3173_),
    .C1(net716),
    .Y(_3174_));
 sky130_fd_sc_hd__nor2_1 _7330_ (.A(_3170_),
    .B(_3174_),
    .Y(_3175_));
 sky130_fd_sc_hd__a211o_1 _7331_ (.A1(_0219_),
    .A2(_3164_),
    .B1(_3169_),
    .C1(_3175_),
    .X(_0014_));
 sky130_fd_sc_hd__a222oi_1 _7335_ (.A1(\count_instr[18] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[50] ),
    .C1(\count_cycle[50] ),
    .C2(net770),
    .Y(_3179_));
 sky130_fd_sc_hd__nand2_1 _7337_ (.A(\count_cycle[18] ),
    .B(net717),
    .Y(_3181_));
 sky130_fd_sc_hd__nand2_1 _7338_ (.A(_3179_),
    .B(_3181_),
    .Y(_3182_));
 sky130_fd_sc_hd__a221oi_1 _7339_ (.A1(net755),
    .A2(net775),
    .B1(net777),
    .B2(_3182_),
    .C1(net716),
    .Y(_3183_));
 sky130_fd_sc_hd__xnor2_1 _7340_ (.A(_3112_),
    .B(_2978_),
    .Y(_3184_));
 sky130_fd_sc_hd__nand2_1 _7341_ (.A(net776),
    .B(_3184_),
    .Y(_3185_));
 sky130_fd_sc_hd__a21oi_1 _7342_ (.A1(net147),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3186_));
 sky130_fd_sc_hd__a21oi_1 _7343_ (.A1(_3183_),
    .A2(_3185_),
    .B1(_3186_),
    .Y(_0013_));
 sky130_fd_sc_hd__a222oi_1 _7344_ (.A1(\count_instr[17] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[49] ),
    .C1(\count_cycle[49] ),
    .C2(net770),
    .Y(_3187_));
 sky130_fd_sc_hd__nand2_1 _7345_ (.A(\count_cycle[17] ),
    .B(net717),
    .Y(_3188_));
 sky130_fd_sc_hd__nand2_1 _7346_ (.A(_3187_),
    .B(_3188_),
    .Y(_3189_));
 sky130_fd_sc_hd__a221oi_1 _7347_ (.A1(net756),
    .A2(net775),
    .B1(net777),
    .B2(_3189_),
    .C1(net716),
    .Y(_3190_));
 sky130_fd_sc_hd__xor2_1 _7348_ (.A(_0121_),
    .B(_3131_),
    .X(_3191_));
 sky130_fd_sc_hd__nand2_1 _7349_ (.A(net776),
    .B(_3191_),
    .Y(_3192_));
 sky130_fd_sc_hd__a21oi_1 _7350_ (.A1(net146),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3193_));
 sky130_fd_sc_hd__a21oi_1 _7351_ (.A1(_3190_),
    .A2(_3192_),
    .B1(_3193_),
    .Y(_0012_));
 sky130_fd_sc_hd__a222oi_1 _7353_ (.A1(\count_instr[16] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[48] ),
    .C1(\count_cycle[48] ),
    .C2(net770),
    .Y(_3195_));
 sky130_fd_sc_hd__nand2_1 _7354_ (.A(\count_cycle[16] ),
    .B(net717),
    .Y(_3196_));
 sky130_fd_sc_hd__nand2_1 _7355_ (.A(_3195_),
    .B(_3196_),
    .Y(_3197_));
 sky130_fd_sc_hd__a221oi_1 _7356_ (.A1(net757),
    .A2(net775),
    .B1(net777),
    .B2(_3197_),
    .C1(net716),
    .Y(_3198_));
 sky130_fd_sc_hd__xnor2_1 _7357_ (.A(_0469_),
    .B(_3111_),
    .Y(_3199_));
 sky130_fd_sc_hd__nand2_1 _7358_ (.A(net776),
    .B(_3199_),
    .Y(_3200_));
 sky130_fd_sc_hd__a21oi_1 _7359_ (.A1(net145),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_3201_));
 sky130_fd_sc_hd__a21oi_1 _7360_ (.A1(_3198_),
    .A2(_3200_),
    .B1(_3201_),
    .Y(_0011_));
 sky130_fd_sc_hd__a21o_1 _7361_ (.A1(_0448_),
    .A2(_3040_),
    .B1(_0447_),
    .X(_3202_));
 sky130_fd_sc_hd__a21oi_1 _7362_ (.A1(_0225_),
    .A2(_3202_),
    .B1(_0224_),
    .Y(_3203_));
 sky130_fd_sc_hd__xnor2_1 _7363_ (.A(_0158_),
    .B(_3203_),
    .Y(_3204_));
 sky130_fd_sc_hd__nand2_1 _7364_ (.A(net776),
    .B(_3204_),
    .Y(_3205_));
 sky130_fd_sc_hd__a222oi_1 _7365_ (.A1(\count_instr[15] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[47] ),
    .C1(\count_cycle[47] ),
    .C2(net770),
    .Y(_3206_));
 sky130_fd_sc_hd__nand2_1 _7366_ (.A(\count_cycle[15] ),
    .B(net717),
    .Y(_3207_));
 sky130_fd_sc_hd__nand2_1 _7367_ (.A(_3206_),
    .B(_3207_),
    .Y(_3208_));
 sky130_fd_sc_hd__a221oi_1 _7368_ (.A1(net758),
    .A2(net775),
    .B1(net777),
    .B2(_3208_),
    .C1(net716),
    .Y(_3209_));
 sky130_fd_sc_hd__nand2b_1 _7369_ (.A_N(latched_is_lh),
    .B(latched_is_lb),
    .Y(_3210_));
 sky130_fd_sc_hd__a21oi_1 _7371_ (.A1(_3006_),
    .A2(_3210_),
    .B1(_3016_),
    .Y(_3212_));
 sky130_fd_sc_hd__a21oi_1 _7372_ (.A1(_3205_),
    .A2(_3209_),
    .B1(_3212_),
    .Y(_0010_));
 sky130_fd_sc_hd__a222oi_1 _7373_ (.A1(\count_instr[14] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[46] ),
    .C1(\count_cycle[46] ),
    .C2(net770),
    .Y(_3213_));
 sky130_fd_sc_hd__nand2_1 _7374_ (.A(\count_cycle[14] ),
    .B(net717),
    .Y(_3214_));
 sky130_fd_sc_hd__nand2_1 _7375_ (.A(_3213_),
    .B(_3214_),
    .Y(_3215_));
 sky130_fd_sc_hd__a221oi_1 _7376_ (.A1(net759),
    .A2(net775),
    .B1(net777),
    .B2(_3215_),
    .C1(net716),
    .Y(_3216_));
 sky130_fd_sc_hd__xnor2_1 _7377_ (.A(_0225_),
    .B(_3109_),
    .Y(_3217_));
 sky130_fd_sc_hd__nand2_1 _7378_ (.A(net776),
    .B(_3217_),
    .Y(_3218_));
 sky130_fd_sc_hd__mux2_2 _7379_ (.A0(net143),
    .A1(net826),
    .S(net753),
    .X(_3219_));
 sky130_fd_sc_hd__a22o_1 _7380_ (.A1(net143),
    .A2(net730),
    .B1(_3219_),
    .B2(net765),
    .X(_3220_));
 sky130_fd_sc_hd__a21oi_1 _7381_ (.A1(_3210_),
    .A2(_3220_),
    .B1(_3016_),
    .Y(_3221_));
 sky130_fd_sc_hd__a21oi_1 _7382_ (.A1(_3216_),
    .A2(_3218_),
    .B1(_3221_),
    .Y(_0009_));
 sky130_fd_sc_hd__a222oi_1 _7383_ (.A1(\count_instr[13] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[45] ),
    .C1(\count_cycle[45] ),
    .C2(net770),
    .Y(_3222_));
 sky130_fd_sc_hd__nand2_1 _7384_ (.A(\count_cycle[13] ),
    .B(net717),
    .Y(_3223_));
 sky130_fd_sc_hd__nand2_1 _7385_ (.A(_3222_),
    .B(_3223_),
    .Y(_3224_));
 sky130_fd_sc_hd__a221oi_1 _7386_ (.A1(net760),
    .A2(net775),
    .B1(net777),
    .B2(_3224_),
    .C1(net716),
    .Y(_3225_));
 sky130_fd_sc_hd__xor2_1 _7387_ (.A(_0448_),
    .B(_3040_),
    .X(_3226_));
 sky130_fd_sc_hd__nand2_1 _7388_ (.A(net776),
    .B(_3226_),
    .Y(_3227_));
 sky130_fd_sc_hd__mux2_2 _7389_ (.A0(net142),
    .A1(net159),
    .S(net753),
    .X(_3228_));
 sky130_fd_sc_hd__a22o_1 _7390_ (.A1(net142),
    .A2(net730),
    .B1(_3228_),
    .B2(net765),
    .X(_3229_));
 sky130_fd_sc_hd__a21oi_1 _7391_ (.A1(_3210_),
    .A2(_3229_),
    .B1(_3016_),
    .Y(_3230_));
 sky130_fd_sc_hd__a21oi_1 _7392_ (.A1(_3225_),
    .A2(_3227_),
    .B1(_3230_),
    .Y(_0008_));
 sky130_fd_sc_hd__a222oi_1 _7393_ (.A1(\count_instr[12] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[44] ),
    .C1(\count_cycle[44] ),
    .C2(net770),
    .Y(_3231_));
 sky130_fd_sc_hd__nand2_1 _7394_ (.A(\count_cycle[12] ),
    .B(net717),
    .Y(_3232_));
 sky130_fd_sc_hd__nand2_1 _7395_ (.A(_3231_),
    .B(_3232_),
    .Y(_3233_));
 sky130_fd_sc_hd__a221oi_1 _7396_ (.A1(net761),
    .A2(net775),
    .B1(net777),
    .B2(_3233_),
    .C1(net716),
    .Y(_3234_));
 sky130_fd_sc_hd__o21ai_0 _7397_ (.A1(_0111_),
    .A2(_3108_),
    .B1(_0209_),
    .Y(_3235_));
 sky130_fd_sc_hd__nand2b_1 _7398_ (.A_N(_0208_),
    .B(_3235_),
    .Y(_3236_));
 sky130_fd_sc_hd__xor2_1 _7399_ (.A(_0125_),
    .B(_3236_),
    .X(_3237_));
 sky130_fd_sc_hd__nand2_1 _7400_ (.A(net776),
    .B(_3237_),
    .Y(_3238_));
 sky130_fd_sc_hd__mux2_2 _7401_ (.A0(net141),
    .A1(net158),
    .S(net753),
    .X(_3239_));
 sky130_fd_sc_hd__a22o_1 _7402_ (.A1(net141),
    .A2(net730),
    .B1(_3239_),
    .B2(net765),
    .X(_3240_));
 sky130_fd_sc_hd__a21oi_1 _7403_ (.A1(_3210_),
    .A2(_3240_),
    .B1(_3016_),
    .Y(_3241_));
 sky130_fd_sc_hd__a21oi_1 _7404_ (.A1(_3234_),
    .A2(_3238_),
    .B1(_3241_),
    .Y(_0007_));
 sky130_fd_sc_hd__a222oi_1 _7405_ (.A1(\count_instr[11] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[43] ),
    .C1(\count_cycle[43] ),
    .C2(net770),
    .Y(_3242_));
 sky130_fd_sc_hd__nand2_1 _7406_ (.A(\count_cycle[11] ),
    .B(net717),
    .Y(_3243_));
 sky130_fd_sc_hd__nand2_1 _7407_ (.A(_3242_),
    .B(_3243_),
    .Y(_3244_));
 sky130_fd_sc_hd__a221oi_1 _7408_ (.A1(net762),
    .A2(net775),
    .B1(net777),
    .B2(_3244_),
    .C1(net716),
    .Y(_3245_));
 sky130_fd_sc_hd__o21bai_1 _7409_ (.A1(_3028_),
    .A2(_3036_),
    .B1_N(_0106_),
    .Y(_3246_));
 sky130_fd_sc_hd__a21oi_1 _7410_ (.A1(_0112_),
    .A2(_3246_),
    .B1(_0111_),
    .Y(_3247_));
 sky130_fd_sc_hd__xnor2_1 _7411_ (.A(_0209_),
    .B(_3247_),
    .Y(_3248_));
 sky130_fd_sc_hd__nand2_1 _7412_ (.A(net776),
    .B(_3248_),
    .Y(_3249_));
 sky130_fd_sc_hd__mux2_2 _7413_ (.A0(net140),
    .A1(net157),
    .S(net753),
    .X(_3250_));
 sky130_fd_sc_hd__a22o_1 _7414_ (.A1(net140),
    .A2(net730),
    .B1(_3250_),
    .B2(net765),
    .X(_3251_));
 sky130_fd_sc_hd__a21oi_1 _7415_ (.A1(_3210_),
    .A2(_3251_),
    .B1(_3016_),
    .Y(_3252_));
 sky130_fd_sc_hd__a21oi_1 _7416_ (.A1(_3245_),
    .A2(_3249_),
    .B1(_3252_),
    .Y(_0006_));
 sky130_fd_sc_hd__nand2_1 _7417_ (.A(_0107_),
    .B(_0114_),
    .Y(_3253_));
 sky130_fd_sc_hd__nand2_1 _7418_ (.A(_2956_),
    .B(_2959_),
    .Y(_3254_));
 sky130_fd_sc_hd__nor2_1 _7419_ (.A(_0112_),
    .B(_2961_),
    .Y(_3255_));
 sky130_fd_sc_hd__o21ai_0 _7420_ (.A1(_3253_),
    .A2(_3254_),
    .B1(_3255_),
    .Y(_3256_));
 sky130_fd_sc_hd__nand3_1 _7421_ (.A(net776),
    .B(_2962_),
    .C(_3256_),
    .Y(_3257_));
 sky130_fd_sc_hd__a222oi_1 _7422_ (.A1(\count_instr[10] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[42] ),
    .C1(\count_cycle[42] ),
    .C2(net770),
    .Y(_3258_));
 sky130_fd_sc_hd__nand2_1 _7423_ (.A(\count_cycle[10] ),
    .B(net717),
    .Y(_3259_));
 sky130_fd_sc_hd__nand2_1 _7424_ (.A(_3258_),
    .B(_3259_),
    .Y(_3260_));
 sky130_fd_sc_hd__a221oi_1 _7425_ (.A1(net763),
    .A2(net775),
    .B1(net777),
    .B2(_3260_),
    .C1(net716),
    .Y(_3261_));
 sky130_fd_sc_hd__mux2_2 _7426_ (.A0(net139),
    .A1(net156),
    .S(net753),
    .X(_3262_));
 sky130_fd_sc_hd__a22o_1 _7427_ (.A1(net139),
    .A2(net730),
    .B1(_3262_),
    .B2(net765),
    .X(_3263_));
 sky130_fd_sc_hd__a21oi_1 _7428_ (.A1(_3210_),
    .A2(_3263_),
    .B1(_3016_),
    .Y(_3264_));
 sky130_fd_sc_hd__a21oi_1 _7429_ (.A1(_3257_),
    .A2(_3261_),
    .B1(_3264_),
    .Y(_0005_));
 sky130_fd_sc_hd__a222oi_1 _7430_ (.A1(\count_instr[9] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[41] ),
    .C1(\count_cycle[41] ),
    .C2(net770),
    .Y(_3265_));
 sky130_fd_sc_hd__nand2_1 _7432_ (.A(\count_cycle[9] ),
    .B(net717),
    .Y(_3267_));
 sky130_fd_sc_hd__nand2_1 _7433_ (.A(_3265_),
    .B(_3267_),
    .Y(_3268_));
 sky130_fd_sc_hd__a221oi_1 _7434_ (.A1(net736),
    .A2(net775),
    .B1(net777),
    .B2(_3268_),
    .C1(net716),
    .Y(_3269_));
 sky130_fd_sc_hd__xnor2_1 _7435_ (.A(_0107_),
    .B(_3036_),
    .Y(_3270_));
 sky130_fd_sc_hd__nand2_1 _7436_ (.A(net776),
    .B(_3270_),
    .Y(_3271_));
 sky130_fd_sc_hd__mux2_2 _7437_ (.A0(net169),
    .A1(net827),
    .S(net753),
    .X(_3272_));
 sky130_fd_sc_hd__a22o_1 _7438_ (.A1(net169),
    .A2(net730),
    .B1(_3272_),
    .B2(net765),
    .X(_3273_));
 sky130_fd_sc_hd__a21oi_1 _7439_ (.A1(_3210_),
    .A2(_3273_),
    .B1(_3016_),
    .Y(_3274_));
 sky130_fd_sc_hd__a21oi_1 _7440_ (.A1(_3269_),
    .A2(_3271_),
    .B1(_3274_),
    .Y(_0035_));
 sky130_fd_sc_hd__a222oi_1 _7441_ (.A1(\count_instr[8] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[40] ),
    .C1(\count_cycle[40] ),
    .C2(net770),
    .Y(_3275_));
 sky130_fd_sc_hd__nand2_1 _7442_ (.A(\count_cycle[8] ),
    .B(net717),
    .Y(_3276_));
 sky130_fd_sc_hd__nand2_1 _7443_ (.A(_3275_),
    .B(_3276_),
    .Y(_3277_));
 sky130_fd_sc_hd__a221oi_1 _7444_ (.A1(net737),
    .A2(net775),
    .B1(net777),
    .B2(_3277_),
    .C1(net716),
    .Y(_3278_));
 sky130_fd_sc_hd__xnor2_1 _7445_ (.A(_0114_),
    .B(_3254_),
    .Y(_3279_));
 sky130_fd_sc_hd__nand2_1 _7446_ (.A(net776),
    .B(_3279_),
    .Y(_3280_));
 sky130_fd_sc_hd__mux2_2 _7447_ (.A0(net168),
    .A1(net154),
    .S(net753),
    .X(_3281_));
 sky130_fd_sc_hd__a22o_1 _7448_ (.A1(net168),
    .A2(net730),
    .B1(_3281_),
    .B2(net765),
    .X(_3282_));
 sky130_fd_sc_hd__a21oi_1 _7449_ (.A1(_3210_),
    .A2(_3282_),
    .B1(_3016_),
    .Y(_3283_));
 sky130_fd_sc_hd__a21oi_1 _7450_ (.A1(_3278_),
    .A2(_3280_),
    .B1(_3283_),
    .Y(_0034_));
 sky130_fd_sc_hd__a21o_1 _7451_ (.A1(_0250_),
    .A2(_3031_),
    .B1(_0249_),
    .X(_3284_));
 sky130_fd_sc_hd__a21oi_1 _7452_ (.A1(_0083_),
    .A2(_3284_),
    .B1(_0082_),
    .Y(_3285_));
 sky130_fd_sc_hd__xor2_1 _7453_ (.A(_0419_),
    .B(_3285_),
    .X(_3286_));
 sky130_fd_sc_hd__a222oi_1 _7454_ (.A1(\count_instr[7] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[39] ),
    .C1(\count_cycle[39] ),
    .C2(net770),
    .Y(_3287_));
 sky130_fd_sc_hd__nand2_1 _7455_ (.A(\count_cycle[7] ),
    .B(net717),
    .Y(_3288_));
 sky130_fd_sc_hd__nand2_1 _7456_ (.A(_3287_),
    .B(_3288_),
    .Y(_3289_));
 sky130_fd_sc_hd__a222oi_1 _7458_ (.A1(net738),
    .A2(net775),
    .B1(net716),
    .B2(_3014_),
    .C1(_3289_),
    .C2(net777),
    .Y(_3291_));
 sky130_fd_sc_hd__o21ai_0 _7459_ (.A1(_3021_),
    .A2(_3286_),
    .B1(_3291_),
    .Y(_0033_));
 sky130_fd_sc_hd__a21oi_1 _7460_ (.A1(_0089_),
    .A2(_0055_),
    .B1(_0253_),
    .Y(_3292_));
 sky130_fd_sc_hd__nor2b_1 _7461_ (.A(_3292_),
    .B_N(_0213_),
    .Y(_3293_));
 sky130_fd_sc_hd__o21ai_0 _7462_ (.A1(_0212_),
    .A2(_3293_),
    .B1(_0450_),
    .Y(_3294_));
 sky130_fd_sc_hd__nand2b_1 _7463_ (.A_N(_0449_),
    .B(_3294_),
    .Y(_3295_));
 sky130_fd_sc_hd__a21oi_1 _7464_ (.A1(_0250_),
    .A2(_3295_),
    .B1(_0249_),
    .Y(_3296_));
 sky130_fd_sc_hd__xnor2_1 _7465_ (.A(_0083_),
    .B(_3296_),
    .Y(_3297_));
 sky130_fd_sc_hd__nand2_1 _7466_ (.A(net776),
    .B(_3297_),
    .Y(_3298_));
 sky130_fd_sc_hd__a222oi_1 _7467_ (.A1(\count_instr[6] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[38] ),
    .C1(\count_cycle[38] ),
    .C2(net770),
    .Y(_3299_));
 sky130_fd_sc_hd__nand2_1 _7468_ (.A(\count_cycle[6] ),
    .B(net717),
    .Y(_3300_));
 sky130_fd_sc_hd__nand2_1 _7469_ (.A(_3299_),
    .B(_3300_),
    .Y(_3301_));
 sky130_fd_sc_hd__a221oi_1 _7470_ (.A1(net739),
    .A2(net775),
    .B1(net777),
    .B2(_3301_),
    .C1(net716),
    .Y(_3302_));
 sky130_fd_sc_hd__a21oi_1 _7471_ (.A1(net766),
    .A2(_0445_),
    .B1(net765),
    .Y(_3303_));
 sky130_fd_sc_hd__nor2_1 _7472_ (.A(_0061_),
    .B(_3303_),
    .Y(_3304_));
 sky130_fd_sc_hd__nand3_1 _7473_ (.A(net766),
    .B(net764),
    .C(_3219_),
    .Y(_3305_));
 sky130_fd_sc_hd__nand2_1 _7474_ (.A(net716),
    .B(_3305_),
    .Y(_3306_));
 sky130_fd_sc_hd__a221oi_1 _7475_ (.A1(net166),
    .A2(net699),
    .B1(_3304_),
    .B2(net152),
    .C1(_3306_),
    .Y(_3307_));
 sky130_fd_sc_hd__a21oi_1 _7476_ (.A1(_3298_),
    .A2(_3302_),
    .B1(_3307_),
    .Y(_0032_));
 sky130_fd_sc_hd__a222oi_1 _7477_ (.A1(\count_instr[5] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[37] ),
    .C1(\count_cycle[37] ),
    .C2(net770),
    .Y(_3308_));
 sky130_fd_sc_hd__nand2_1 _7478_ (.A(\count_cycle[5] ),
    .B(net717),
    .Y(_3309_));
 sky130_fd_sc_hd__nand2_1 _7479_ (.A(_3308_),
    .B(_3309_),
    .Y(_3310_));
 sky130_fd_sc_hd__a221oi_1 _7480_ (.A1(net335),
    .A2(net774),
    .B1(net777),
    .B2(_3310_),
    .C1(net716),
    .Y(_3311_));
 sky130_fd_sc_hd__xor2_1 _7481_ (.A(_0250_),
    .B(_3031_),
    .X(_3312_));
 sky130_fd_sc_hd__nand2_1 _7482_ (.A(net776),
    .B(_3312_),
    .Y(_3313_));
 sky130_fd_sc_hd__mux4_2 _7483_ (.A0(net165),
    .A1(net142),
    .A2(net151),
    .A3(net159),
    .S0(net764),
    .S1(net753),
    .X(_3314_));
 sky130_fd_sc_hd__mux2_2 _7484_ (.A0(net165),
    .A1(net151),
    .S(net753),
    .X(_3315_));
 sky130_fd_sc_hd__a221o_1 _7485_ (.A1(net165),
    .A2(net730),
    .B1(_3315_),
    .B2(net765),
    .C1(_3015_),
    .X(_3316_));
 sky130_fd_sc_hd__a21oi_1 _7486_ (.A1(\mem_wordsize[1] ),
    .A2(_3314_),
    .B1(_3316_),
    .Y(_3317_));
 sky130_fd_sc_hd__a21oi_1 _7487_ (.A1(_3311_),
    .A2(_3313_),
    .B1(_3317_),
    .Y(_0031_));
 sky130_fd_sc_hd__a21oi_1 _7488_ (.A1(net334),
    .A2(net774),
    .B1(net716),
    .Y(_3318_));
 sky130_fd_sc_hd__or3_1 _7489_ (.A(_0450_),
    .B(_0212_),
    .C(_3293_),
    .X(_3319_));
 sky130_fd_sc_hd__a222oi_1 _7490_ (.A1(\count_instr[4] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[36] ),
    .C1(\count_cycle[36] ),
    .C2(net770),
    .Y(_3320_));
 sky130_fd_sc_hd__nand2_1 _7491_ (.A(\count_cycle[4] ),
    .B(net717),
    .Y(_3321_));
 sky130_fd_sc_hd__nand2_1 _7492_ (.A(_3320_),
    .B(_3321_),
    .Y(_3322_));
 sky130_fd_sc_hd__a32oi_1 _7493_ (.A1(net776),
    .A2(_3294_),
    .A3(_3319_),
    .B1(_3322_),
    .B2(net777),
    .Y(_3323_));
 sky130_fd_sc_hd__nand3_1 _7494_ (.A(\mem_wordsize[1] ),
    .B(net764),
    .C(_3239_),
    .Y(_3324_));
 sky130_fd_sc_hd__nand2_1 _7495_ (.A(net716),
    .B(_3324_),
    .Y(_3325_));
 sky130_fd_sc_hd__a221oi_1 _7496_ (.A1(net164),
    .A2(net699),
    .B1(_3304_),
    .B2(net150),
    .C1(_3325_),
    .Y(_3326_));
 sky130_fd_sc_hd__a21oi_1 _7497_ (.A1(_3318_),
    .A2(_3323_),
    .B1(_3326_),
    .Y(_0030_));
 sky130_fd_sc_hd__a22o_1 _7498_ (.A1(net163),
    .A2(net699),
    .B1(_3304_),
    .B2(net148),
    .X(_3327_));
 sky130_fd_sc_hd__a31oi_1 _7499_ (.A1(\mem_wordsize[1] ),
    .A2(net764),
    .A3(_3250_),
    .B1(_3327_),
    .Y(_3328_));
 sky130_fd_sc_hd__a222oi_1 _7500_ (.A1(\count_instr[3] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[35] ),
    .C1(\count_cycle[35] ),
    .C2(net770),
    .Y(_3329_));
 sky130_fd_sc_hd__nand2_1 _7501_ (.A(\count_cycle[3] ),
    .B(net717),
    .Y(_3330_));
 sky130_fd_sc_hd__nand2_1 _7502_ (.A(_3329_),
    .B(_3330_),
    .Y(_3331_));
 sky130_fd_sc_hd__xor2_1 _7503_ (.A(_0213_),
    .B(_0056_),
    .X(_3332_));
 sky130_fd_sc_hd__a222oi_1 _7504_ (.A1(net740),
    .A2(net775),
    .B1(net777),
    .B2(_3331_),
    .C1(_3332_),
    .C2(net776),
    .Y(_3333_));
 sky130_fd_sc_hd__o21ai_0 _7505_ (.A1(_3015_),
    .A2(_3328_),
    .B1(_3333_),
    .Y(_0029_));
 sky130_fd_sc_hd__a22o_1 _7506_ (.A1(net160),
    .A2(net699),
    .B1(_3304_),
    .B2(net147),
    .X(_3334_));
 sky130_fd_sc_hd__a31oi_1 _7507_ (.A1(\mem_wordsize[1] ),
    .A2(net764),
    .A3(_3262_),
    .B1(_3334_),
    .Y(_3335_));
 sky130_fd_sc_hd__a222oi_1 _7508_ (.A1(\count_instr[2] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[34] ),
    .C1(\count_cycle[34] ),
    .C2(net770),
    .Y(_3336_));
 sky130_fd_sc_hd__nand2_1 _7509_ (.A(\count_cycle[2] ),
    .B(net717),
    .Y(_3337_));
 sky130_fd_sc_hd__nand2_1 _7510_ (.A(_3336_),
    .B(_3337_),
    .Y(_3338_));
 sky130_fd_sc_hd__a222oi_1 _7511_ (.A1(net330),
    .A2(net775),
    .B1(net777),
    .B2(_3338_),
    .C1(_0057_),
    .C2(net776),
    .Y(_3339_));
 sky130_fd_sc_hd__o21ai_0 _7512_ (.A1(_3015_),
    .A2(_3335_),
    .B1(_3339_),
    .Y(_0026_));
 sky130_fd_sc_hd__o21ai_0 _7513_ (.A1(net828),
    .A2(_0945_),
    .B1(net716),
    .Y(_3340_));
 sky130_fd_sc_hd__nor2_1 _7514_ (.A(net753),
    .B(_0977_),
    .Y(_3341_));
 sky130_fd_sc_hd__a32oi_1 _7515_ (.A1(net766),
    .A2(net764),
    .A3(_3272_),
    .B1(_3341_),
    .B2(net828),
    .Y(_3342_));
 sky130_fd_sc_hd__nand2_1 _7516_ (.A(_0945_),
    .B(_3342_),
    .Y(_3343_));
 sky130_fd_sc_hd__a21oi_1 _7517_ (.A1(net146),
    .A2(_3304_),
    .B1(_3343_),
    .Y(_3344_));
 sky130_fd_sc_hd__a222oi_1 _7518_ (.A1(\count_instr[1] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[33] ),
    .C1(\count_cycle[33] ),
    .C2(net770),
    .Y(_3345_));
 sky130_fd_sc_hd__nand2_1 _7519_ (.A(\count_cycle[1] ),
    .B(net717),
    .Y(_3346_));
 sky130_fd_sc_hd__nand2_1 _7520_ (.A(_3345_),
    .B(_3346_),
    .Y(_3347_));
 sky130_fd_sc_hd__a222oi_1 _7521_ (.A1(net753),
    .A2(net775),
    .B1(net777),
    .B2(_3347_),
    .C1(_0467_),
    .C2(net776),
    .Y(_3348_));
 sky130_fd_sc_hd__o21ai_0 _7522_ (.A1(_3340_),
    .A2(_3344_),
    .B1(_3348_),
    .Y(_0015_));
 sky130_fd_sc_hd__a22o_1 _7523_ (.A1(net138),
    .A2(net699),
    .B1(_3304_),
    .B2(net145),
    .X(_3349_));
 sky130_fd_sc_hd__a31oi_1 _7524_ (.A1(\mem_wordsize[1] ),
    .A2(net764),
    .A3(_3281_),
    .B1(_3349_),
    .Y(_3350_));
 sky130_fd_sc_hd__a222oi_1 _7525_ (.A1(\count_instr[0] ),
    .A2(net769),
    .B1(net768),
    .B2(\count_instr[32] ),
    .C1(\count_cycle[32] ),
    .C2(net770),
    .Y(_3351_));
 sky130_fd_sc_hd__nand2_1 _7526_ (.A(\count_cycle[0] ),
    .B(net717),
    .Y(_3352_));
 sky130_fd_sc_hd__nand2_1 _7527_ (.A(_3351_),
    .B(_3352_),
    .Y(_3353_));
 sky130_fd_sc_hd__a222oi_1 _7528_ (.A1(net764),
    .A2(net775),
    .B1(net777),
    .B2(_3353_),
    .C1(\decoded_imm[0] ),
    .C2(net776),
    .Y(_3354_));
 sky130_fd_sc_hd__o21ai_0 _7529_ (.A1(_3015_),
    .A2(_3350_),
    .B1(_3354_),
    .Y(_0004_));
 sky130_fd_sc_hd__inv_1 _7530_ (.A(net343),
    .Y(_0359_));
 sky130_fd_sc_hd__inv_1 _7531_ (.A(net312),
    .Y(_0358_));
 sky130_fd_sc_hd__inv_1 _7532_ (.A(net344),
    .Y(_0353_));
 sky130_fd_sc_hd__inv_1 _7533_ (.A(net313),
    .Y(_0352_));
 sky130_fd_sc_hd__inv_1 _7534_ (.A(net345),
    .Y(_0347_));
 sky130_fd_sc_hd__inv_1 _7535_ (.A(net314),
    .Y(_0346_));
 sky130_fd_sc_hd__inv_1 _7536_ (.A(net736),
    .Y(_0382_));
 sky130_fd_sc_hd__inv_1 _7537_ (.A(net321),
    .Y(_0310_));
 sky130_fd_sc_hd__inv_1 _7538_ (.A(net361),
    .Y(_0473_));
 sky130_fd_sc_hd__inv_1 _7539_ (.A(\mem_rdata_q[14] ),
    .Y(_3355_));
 sky130_fd_sc_hd__clkinv_1 _7540_ (.A(net733),
    .Y(_3356_));
 sky130_fd_sc_hd__nand2_1 _7541_ (.A(net143),
    .B(_3356_),
    .Y(_3357_));
 sky130_fd_sc_hd__o21ai_0 _7542_ (.A1(_3355_),
    .A2(_3356_),
    .B1(_3357_),
    .Y(\mem_rdata_latched[14] ));
 sky130_fd_sc_hd__nand2_1 _7543_ (.A(net141),
    .B(net706),
    .Y(_3358_));
 sky130_fd_sc_hd__nand2_1 _7546_ (.A(\mem_rdata_q[12] ),
    .B(net733),
    .Y(_3361_));
 sky130_fd_sc_hd__nand2_1 _7547_ (.A(_3358_),
    .B(_3361_),
    .Y(\mem_rdata_latched[12] ));
 sky130_fd_sc_hd__nand2_1 _7549_ (.A(net142),
    .B(net706),
    .Y(_3363_));
 sky130_fd_sc_hd__nand2_1 _7551_ (.A(\mem_rdata_q[13] ),
    .B(net733),
    .Y(_3365_));
 sky130_fd_sc_hd__nand2_1 _7552_ (.A(_3363_),
    .B(_3365_),
    .Y(\mem_rdata_latched[13] ));
 sky130_fd_sc_hd__nand2_1 _7555_ (.A(net826),
    .B(net706),
    .Y(_3367_));
 sky130_fd_sc_hd__nand2_1 _7559_ (.A(\mem_rdata_q[30] ),
    .B(net733),
    .Y(_3371_));
 sky130_fd_sc_hd__nand2_1 _7560_ (.A(_3367_),
    .B(_3371_),
    .Y(\mem_rdata_latched[30] ));
 sky130_fd_sc_hd__nand2_1 _7561_ (.A(net159),
    .B(net706),
    .Y(_3372_));
 sky130_fd_sc_hd__nand2_1 _7562_ (.A(\mem_rdata_q[29] ),
    .B(net733),
    .Y(_3373_));
 sky130_fd_sc_hd__nand2_1 _7563_ (.A(_3372_),
    .B(_3373_),
    .Y(\mem_rdata_latched[29] ));
 sky130_fd_sc_hd__nand2_1 _7564_ (.A(net158),
    .B(net706),
    .Y(_3374_));
 sky130_fd_sc_hd__nand2_1 _7565_ (.A(\mem_rdata_q[28] ),
    .B(net733),
    .Y(_3375_));
 sky130_fd_sc_hd__nand2_1 _7566_ (.A(_3374_),
    .B(_3375_),
    .Y(\mem_rdata_latched[28] ));
 sky130_fd_sc_hd__nand2_1 _7567_ (.A(net157),
    .B(net706),
    .Y(_3376_));
 sky130_fd_sc_hd__nand2_1 _7569_ (.A(\mem_rdata_q[27] ),
    .B(net733),
    .Y(_3378_));
 sky130_fd_sc_hd__nand2_1 _7570_ (.A(_3376_),
    .B(_3378_),
    .Y(\mem_rdata_latched[27] ));
 sky130_fd_sc_hd__nand2_1 _7571_ (.A(net156),
    .B(net706),
    .Y(_3379_));
 sky130_fd_sc_hd__nand2_1 _7572_ (.A(\mem_rdata_q[26] ),
    .B(net733),
    .Y(_3380_));
 sky130_fd_sc_hd__nand2_1 _7573_ (.A(_3379_),
    .B(_3380_),
    .Y(\mem_rdata_latched[26] ));
 sky130_fd_sc_hd__nand2_1 _7574_ (.A(net827),
    .B(net706),
    .Y(_3381_));
 sky130_fd_sc_hd__nand2_1 _7575_ (.A(\mem_rdata_q[25] ),
    .B(net733),
    .Y(_3382_));
 sky130_fd_sc_hd__nand2_1 _7576_ (.A(_3381_),
    .B(_3382_),
    .Y(\mem_rdata_latched[25] ));
 sky130_fd_sc_hd__nand2_1 _7577_ (.A(net154),
    .B(net706),
    .Y(_3383_));
 sky130_fd_sc_hd__nand2_1 _7578_ (.A(\mem_rdata_q[24] ),
    .B(net733),
    .Y(_3384_));
 sky130_fd_sc_hd__nand2_1 _7579_ (.A(_3383_),
    .B(_3384_),
    .Y(\mem_rdata_latched[24] ));
 sky130_fd_sc_hd__nand2_1 _7580_ (.A(net153),
    .B(net706),
    .Y(_3385_));
 sky130_fd_sc_hd__nand2_1 _7581_ (.A(\mem_rdata_q[23] ),
    .B(net733),
    .Y(_3386_));
 sky130_fd_sc_hd__nand2_1 _7582_ (.A(_3385_),
    .B(_3386_),
    .Y(\mem_rdata_latched[23] ));
 sky130_fd_sc_hd__nand2_1 _7583_ (.A(net152),
    .B(net706),
    .Y(_3387_));
 sky130_fd_sc_hd__nand2_1 _7584_ (.A(\mem_rdata_q[22] ),
    .B(net733),
    .Y(_3388_));
 sky130_fd_sc_hd__nand2_1 _7585_ (.A(_3387_),
    .B(_3388_),
    .Y(\mem_rdata_latched[22] ));
 sky130_fd_sc_hd__nand2_1 _7586_ (.A(net151),
    .B(net706),
    .Y(_3389_));
 sky130_fd_sc_hd__nand2_1 _7587_ (.A(\mem_rdata_q[21] ),
    .B(net733),
    .Y(_3390_));
 sky130_fd_sc_hd__nand2_1 _7588_ (.A(_3389_),
    .B(_3390_),
    .Y(\mem_rdata_latched[21] ));
 sky130_fd_sc_hd__nand2_1 _7589_ (.A(net150),
    .B(net706),
    .Y(_3391_));
 sky130_fd_sc_hd__nand2_1 _7590_ (.A(\mem_rdata_q[20] ),
    .B(net733),
    .Y(_3392_));
 sky130_fd_sc_hd__nand2_1 _7591_ (.A(_3391_),
    .B(_3392_),
    .Y(\mem_rdata_latched[20] ));
 sky130_fd_sc_hd__nand2_1 _7592_ (.A(net148),
    .B(net706),
    .Y(_3393_));
 sky130_fd_sc_hd__nand2_1 _7593_ (.A(\mem_rdata_q[19] ),
    .B(net733),
    .Y(_3394_));
 sky130_fd_sc_hd__nand2_1 _7594_ (.A(_3393_),
    .B(_3394_),
    .Y(\mem_rdata_latched[19] ));
 sky130_fd_sc_hd__nand2_1 _7595_ (.A(net147),
    .B(net706),
    .Y(_3395_));
 sky130_fd_sc_hd__nand2_1 _7596_ (.A(\mem_rdata_q[18] ),
    .B(net733),
    .Y(_3396_));
 sky130_fd_sc_hd__nand2_1 _7597_ (.A(_3395_),
    .B(_3396_),
    .Y(\mem_rdata_latched[18] ));
 sky130_fd_sc_hd__nand2_1 _7598_ (.A(net146),
    .B(net706),
    .Y(_3397_));
 sky130_fd_sc_hd__nand2_1 _7599_ (.A(\mem_rdata_q[17] ),
    .B(net733),
    .Y(_3398_));
 sky130_fd_sc_hd__nand2_1 _7600_ (.A(_3397_),
    .B(_3398_),
    .Y(\mem_rdata_latched[17] ));
 sky130_fd_sc_hd__nand2_1 _7601_ (.A(net145),
    .B(net706),
    .Y(_3399_));
 sky130_fd_sc_hd__nand2_1 _7602_ (.A(\mem_rdata_q[16] ),
    .B(net733),
    .Y(_3400_));
 sky130_fd_sc_hd__nand2_1 _7603_ (.A(_3399_),
    .B(_3400_),
    .Y(\mem_rdata_latched[16] ));
 sky130_fd_sc_hd__nand2_1 _7604_ (.A(net144),
    .B(net706),
    .Y(_3401_));
 sky130_fd_sc_hd__nand2_1 _7605_ (.A(\mem_rdata_q[15] ),
    .B(net733),
    .Y(_3402_));
 sky130_fd_sc_hd__nand2_1 _7606_ (.A(_3401_),
    .B(_3402_),
    .Y(\mem_rdata_latched[15] ));
 sky130_fd_sc_hd__nand2_1 _7607_ (.A(net140),
    .B(net706),
    .Y(_3403_));
 sky130_fd_sc_hd__nand2_1 _7608_ (.A(\mem_rdata_q[11] ),
    .B(net733),
    .Y(_3404_));
 sky130_fd_sc_hd__nand2_1 _7609_ (.A(_3403_),
    .B(_3404_),
    .Y(\mem_rdata_latched[11] ));
 sky130_fd_sc_hd__nand2_1 _7610_ (.A(net139),
    .B(net706),
    .Y(_3405_));
 sky130_fd_sc_hd__nand2_1 _7611_ (.A(\mem_rdata_q[10] ),
    .B(net733),
    .Y(_3406_));
 sky130_fd_sc_hd__nand2_1 _7612_ (.A(_3405_),
    .B(_3406_),
    .Y(\mem_rdata_latched[10] ));
 sky130_fd_sc_hd__nand2_1 _7613_ (.A(net169),
    .B(net706),
    .Y(_3407_));
 sky130_fd_sc_hd__nand2_1 _7614_ (.A(\mem_rdata_q[9] ),
    .B(net733),
    .Y(_3408_));
 sky130_fd_sc_hd__nand2_1 _7615_ (.A(_3407_),
    .B(_3408_),
    .Y(\mem_rdata_latched[9] ));
 sky130_fd_sc_hd__nand2_1 _7616_ (.A(net168),
    .B(net706),
    .Y(_3409_));
 sky130_fd_sc_hd__nand2_1 _7617_ (.A(\mem_rdata_q[8] ),
    .B(net733),
    .Y(_3410_));
 sky130_fd_sc_hd__nand2_1 _7618_ (.A(_3409_),
    .B(_3410_),
    .Y(\mem_rdata_latched[8] ));
 sky130_fd_sc_hd__nand2_1 _7619_ (.A(net167),
    .B(net706),
    .Y(_3411_));
 sky130_fd_sc_hd__nand2_1 _7620_ (.A(\mem_rdata_q[7] ),
    .B(net733),
    .Y(_3412_));
 sky130_fd_sc_hd__nand2_1 _7621_ (.A(_3411_),
    .B(_3412_),
    .Y(\mem_rdata_latched[7] ));
 sky130_fd_sc_hd__nand2_1 _7624_ (.A(\reg_out[30] ),
    .B(net731),
    .Y(_3415_));
 sky130_fd_sc_hd__nor2_1 _7626_ (.A(net742),
    .B(net729),
    .Y(_3417_));
 sky130_fd_sc_hd__a31oi_1 _7627_ (.A1(_0941_),
    .A2(net729),
    .A3(_3415_),
    .B1(_3417_),
    .Y(net224));
 sky130_fd_sc_hd__nand2_1 _7628_ (.A(\reg_out[29] ),
    .B(net731),
    .Y(_3418_));
 sky130_fd_sc_hd__nor2_1 _7629_ (.A(net743),
    .B(net729),
    .Y(_3419_));
 sky130_fd_sc_hd__a31oi_1 _7630_ (.A1(_0938_),
    .A2(net729),
    .A3(_3418_),
    .B1(_3419_),
    .Y(net222));
 sky130_fd_sc_hd__nand2_1 _7631_ (.A(\reg_out[28] ),
    .B(net731),
    .Y(_3420_));
 sky130_fd_sc_hd__nor2_1 _7632_ (.A(net744),
    .B(net729),
    .Y(_3421_));
 sky130_fd_sc_hd__a31oi_1 _7633_ (.A1(_0936_),
    .A2(net729),
    .A3(_3420_),
    .B1(_3421_),
    .Y(net221));
 sky130_fd_sc_hd__nand2_1 _7634_ (.A(\reg_out[27] ),
    .B(net731),
    .Y(_3422_));
 sky130_fd_sc_hd__nor2_1 _7635_ (.A(net745),
    .B(net729),
    .Y(_3423_));
 sky130_fd_sc_hd__a31oi_1 _7636_ (.A1(_0933_),
    .A2(net729),
    .A3(_3422_),
    .B1(_3423_),
    .Y(net220));
 sky130_fd_sc_hd__nand2_1 _7637_ (.A(\reg_next_pc[26] ),
    .B(net732),
    .Y(_3424_));
 sky130_fd_sc_hd__nand2_1 _7638_ (.A(\reg_out[26] ),
    .B(net731),
    .Y(_3425_));
 sky130_fd_sc_hd__nor2_1 _7639_ (.A(net746),
    .B(net729),
    .Y(_3426_));
 sky130_fd_sc_hd__a31oi_1 _7640_ (.A1(_3424_),
    .A2(net729),
    .A3(_3425_),
    .B1(_3426_),
    .Y(net219));
 sky130_fd_sc_hd__nand2_1 _7641_ (.A(\reg_next_pc[25] ),
    .B(net732),
    .Y(_3427_));
 sky130_fd_sc_hd__nand2_1 _7642_ (.A(\reg_out[25] ),
    .B(net731),
    .Y(_3428_));
 sky130_fd_sc_hd__nor2_1 _7643_ (.A(net747),
    .B(net729),
    .Y(_3429_));
 sky130_fd_sc_hd__a31oi_1 _7644_ (.A1(_3427_),
    .A2(net729),
    .A3(_3428_),
    .B1(_3429_),
    .Y(net218));
 sky130_fd_sc_hd__nand2_1 _7645_ (.A(\reg_out[24] ),
    .B(net731),
    .Y(_3430_));
 sky130_fd_sc_hd__nor2_1 _7646_ (.A(net748),
    .B(net729),
    .Y(_3431_));
 sky130_fd_sc_hd__a31oi_1 _7647_ (.A1(_0926_),
    .A2(net729),
    .A3(_3430_),
    .B1(_3431_),
    .Y(net217));
 sky130_fd_sc_hd__nand2_1 _7648_ (.A(\reg_out[23] ),
    .B(net731),
    .Y(_3432_));
 sky130_fd_sc_hd__nor2_1 _7649_ (.A(net749),
    .B(net729),
    .Y(_3433_));
 sky130_fd_sc_hd__a31oi_1 _7650_ (.A1(_0923_),
    .A2(net729),
    .A3(_3432_),
    .B1(_3433_),
    .Y(net216));
 sky130_fd_sc_hd__nand2_1 _7651_ (.A(\reg_out[22] ),
    .B(net731),
    .Y(_3434_));
 sky130_fd_sc_hd__nor2_1 _7652_ (.A(net750),
    .B(net729),
    .Y(_3435_));
 sky130_fd_sc_hd__a31oi_1 _7653_ (.A1(_0921_),
    .A2(net729),
    .A3(_3434_),
    .B1(_3435_),
    .Y(net215));
 sky130_fd_sc_hd__nand2_1 _7654_ (.A(\reg_next_pc[21] ),
    .B(net732),
    .Y(_3436_));
 sky130_fd_sc_hd__nand2_1 _7656_ (.A(\reg_out[21] ),
    .B(net731),
    .Y(_3438_));
 sky130_fd_sc_hd__nor2_1 _7657_ (.A(net751),
    .B(net729),
    .Y(_3439_));
 sky130_fd_sc_hd__a31oi_1 _7658_ (.A1(_3436_),
    .A2(net729),
    .A3(_3438_),
    .B1(_3439_),
    .Y(net214));
 sky130_fd_sc_hd__nand2_1 _7659_ (.A(\reg_next_pc[20] ),
    .B(net732),
    .Y(_3440_));
 sky130_fd_sc_hd__nand2_1 _7661_ (.A(\reg_out[20] ),
    .B(net731),
    .Y(_3442_));
 sky130_fd_sc_hd__nor2_1 _7663_ (.A(net752),
    .B(net729),
    .Y(_3444_));
 sky130_fd_sc_hd__a31oi_1 _7664_ (.A1(_3440_),
    .A2(net729),
    .A3(_3442_),
    .B1(_3444_),
    .Y(net213));
 sky130_fd_sc_hd__nand2_1 _7665_ (.A(\reg_next_pc[19] ),
    .B(net732),
    .Y(_3445_));
 sky130_fd_sc_hd__nand2_1 _7666_ (.A(\reg_out[19] ),
    .B(net731),
    .Y(_3446_));
 sky130_fd_sc_hd__nor2_1 _7667_ (.A(net754),
    .B(net729),
    .Y(_3447_));
 sky130_fd_sc_hd__a31oi_1 _7668_ (.A1(_3445_),
    .A2(net729),
    .A3(_3446_),
    .B1(_3447_),
    .Y(net212));
 sky130_fd_sc_hd__nand2_1 _7669_ (.A(\reg_out[18] ),
    .B(net731),
    .Y(_3448_));
 sky130_fd_sc_hd__nor2_1 _7670_ (.A(net755),
    .B(net729),
    .Y(_3449_));
 sky130_fd_sc_hd__a31oi_1 _7671_ (.A1(_0912_),
    .A2(net729),
    .A3(_3448_),
    .B1(_3449_),
    .Y(net211));
 sky130_fd_sc_hd__nand2_1 _7672_ (.A(\reg_out[17] ),
    .B(net731),
    .Y(_3450_));
 sky130_fd_sc_hd__nor2_1 _7673_ (.A(net756),
    .B(net729),
    .Y(_3451_));
 sky130_fd_sc_hd__a31oi_1 _7674_ (.A1(_0910_),
    .A2(net729),
    .A3(_3450_),
    .B1(_3451_),
    .Y(net210));
 sky130_fd_sc_hd__nand2_1 _7675_ (.A(\reg_out[16] ),
    .B(net731),
    .Y(_3452_));
 sky130_fd_sc_hd__nor2_1 _7676_ (.A(net757),
    .B(net729),
    .Y(_3453_));
 sky130_fd_sc_hd__a31oi_1 _7677_ (.A1(_0907_),
    .A2(net729),
    .A3(_3452_),
    .B1(_3453_),
    .Y(net209));
 sky130_fd_sc_hd__nand2_1 _7678_ (.A(\reg_out[15] ),
    .B(net731),
    .Y(_3454_));
 sky130_fd_sc_hd__nor2_1 _7679_ (.A(net758),
    .B(_0986_),
    .Y(_3455_));
 sky130_fd_sc_hd__a31oi_1 _7680_ (.A1(_0904_),
    .A2(_0986_),
    .A3(_3454_),
    .B1(_3455_),
    .Y(net208));
 sky130_fd_sc_hd__nand2_1 _7682_ (.A(\reg_next_pc[14] ),
    .B(net732),
    .Y(_3457_));
 sky130_fd_sc_hd__nand2_1 _7683_ (.A(\reg_out[14] ),
    .B(net731),
    .Y(_3458_));
 sky130_fd_sc_hd__nor2_1 _7684_ (.A(net759),
    .B(_0986_),
    .Y(_3459_));
 sky130_fd_sc_hd__a31oi_1 _7685_ (.A1(_3457_),
    .A2(_0986_),
    .A3(_3458_),
    .B1(_3459_),
    .Y(net207));
 sky130_fd_sc_hd__nand2_1 _7686_ (.A(\reg_next_pc[13] ),
    .B(net732),
    .Y(_3460_));
 sky130_fd_sc_hd__nand2_1 _7687_ (.A(\reg_out[13] ),
    .B(net731),
    .Y(_3461_));
 sky130_fd_sc_hd__nor2_1 _7688_ (.A(net760),
    .B(_0986_),
    .Y(_3462_));
 sky130_fd_sc_hd__a31oi_1 _7689_ (.A1(_3460_),
    .A2(_0986_),
    .A3(_3461_),
    .B1(_3462_),
    .Y(net206));
 sky130_fd_sc_hd__nand2_1 _7690_ (.A(\reg_next_pc[12] ),
    .B(net732),
    .Y(_3463_));
 sky130_fd_sc_hd__nand2_1 _7691_ (.A(\reg_out[12] ),
    .B(net731),
    .Y(_3464_));
 sky130_fd_sc_hd__nor2_1 _7692_ (.A(net761),
    .B(net729),
    .Y(_3465_));
 sky130_fd_sc_hd__a31oi_1 _7693_ (.A1(_3463_),
    .A2(net729),
    .A3(_3464_),
    .B1(_3465_),
    .Y(net205));
 sky130_fd_sc_hd__nand2_1 _7694_ (.A(\reg_next_pc[11] ),
    .B(net732),
    .Y(_3466_));
 sky130_fd_sc_hd__nand2_1 _7696_ (.A(\reg_out[11] ),
    .B(net731),
    .Y(_3468_));
 sky130_fd_sc_hd__nor2_1 _7697_ (.A(net762),
    .B(_0986_),
    .Y(_3469_));
 sky130_fd_sc_hd__a31oi_1 _7698_ (.A1(_3466_),
    .A2(_0986_),
    .A3(_3468_),
    .B1(_3469_),
    .Y(net204));
 sky130_fd_sc_hd__nand2_1 _7700_ (.A(\reg_out[10] ),
    .B(net731),
    .Y(_3471_));
 sky130_fd_sc_hd__nor2_1 _7702_ (.A(net763),
    .B(_0986_),
    .Y(_3473_));
 sky130_fd_sc_hd__a31oi_1 _7703_ (.A1(_0894_),
    .A2(_0986_),
    .A3(_3471_),
    .B1(_3473_),
    .Y(net203));
 sky130_fd_sc_hd__nand2_1 _7704_ (.A(\reg_next_pc[9] ),
    .B(net732),
    .Y(_3474_));
 sky130_fd_sc_hd__nand2_1 _7705_ (.A(\reg_out[9] ),
    .B(net731),
    .Y(_3475_));
 sky130_fd_sc_hd__nor2_1 _7706_ (.A(net736),
    .B(_0986_),
    .Y(_3476_));
 sky130_fd_sc_hd__a31oi_1 _7707_ (.A1(_3474_),
    .A2(_0986_),
    .A3(_3475_),
    .B1(_3476_),
    .Y(net232));
 sky130_fd_sc_hd__nand2_1 _7708_ (.A(\reg_out[8] ),
    .B(net731),
    .Y(_3477_));
 sky130_fd_sc_hd__nor2_1 _7709_ (.A(net737),
    .B(_0986_),
    .Y(_3478_));
 sky130_fd_sc_hd__a31oi_1 _7710_ (.A1(_0890_),
    .A2(_0986_),
    .A3(_3477_),
    .B1(_3478_),
    .Y(net231));
 sky130_fd_sc_hd__nand2_1 _7711_ (.A(\reg_next_pc[7] ),
    .B(net732),
    .Y(_3479_));
 sky130_fd_sc_hd__nand2_1 _7712_ (.A(\reg_out[7] ),
    .B(net731),
    .Y(_3480_));
 sky130_fd_sc_hd__nor2_1 _7713_ (.A(net738),
    .B(_0986_),
    .Y(_3481_));
 sky130_fd_sc_hd__a31oi_1 _7714_ (.A1(_3479_),
    .A2(_0986_),
    .A3(_3480_),
    .B1(_3481_),
    .Y(net230));
 sky130_fd_sc_hd__nand2_1 _7715_ (.A(\reg_next_pc[6] ),
    .B(net732),
    .Y(_3482_));
 sky130_fd_sc_hd__nand2_1 _7716_ (.A(\reg_out[6] ),
    .B(net731),
    .Y(_3483_));
 sky130_fd_sc_hd__nor2_1 _7717_ (.A(net739),
    .B(_0986_),
    .Y(_3484_));
 sky130_fd_sc_hd__a31oi_1 _7718_ (.A1(_3482_),
    .A2(_0986_),
    .A3(_3483_),
    .B1(_3484_),
    .Y(net229));
 sky130_fd_sc_hd__nand2_1 _7719_ (.A(\reg_out[5] ),
    .B(_0874_),
    .Y(_3485_));
 sky130_fd_sc_hd__nor2_1 _7720_ (.A(net335),
    .B(_0986_),
    .Y(_3486_));
 sky130_fd_sc_hd__a31oi_1 _7721_ (.A1(_0885_),
    .A2(_0986_),
    .A3(_3485_),
    .B1(_3486_),
    .Y(net228));
 sky130_fd_sc_hd__nand2_1 _7722_ (.A(\reg_next_pc[4] ),
    .B(_0863_),
    .Y(_3487_));
 sky130_fd_sc_hd__nand2_1 _7723_ (.A(\reg_out[4] ),
    .B(net731),
    .Y(_3488_));
 sky130_fd_sc_hd__nor2_1 _7724_ (.A(net334),
    .B(_0986_),
    .Y(_3489_));
 sky130_fd_sc_hd__a31oi_1 _7725_ (.A1(_3487_),
    .A2(_0986_),
    .A3(_3488_),
    .B1(_3489_),
    .Y(net227));
 sky130_fd_sc_hd__nand2_1 _7726_ (.A(\reg_next_pc[3] ),
    .B(net732),
    .Y(_3490_));
 sky130_fd_sc_hd__nand2_1 _7727_ (.A(\reg_out[3] ),
    .B(_0874_),
    .Y(_3491_));
 sky130_fd_sc_hd__nor2_1 _7728_ (.A(net740),
    .B(net729),
    .Y(_3492_));
 sky130_fd_sc_hd__a31oi_1 _7729_ (.A1(_3490_),
    .A2(net729),
    .A3(_3491_),
    .B1(_3492_),
    .Y(net226));
 sky130_fd_sc_hd__nand2_1 _7730_ (.A(\reg_next_pc[2] ),
    .B(net732),
    .Y(_3493_));
 sky130_fd_sc_hd__nand2_1 _7731_ (.A(\reg_out[2] ),
    .B(_0874_),
    .Y(_3494_));
 sky130_fd_sc_hd__nor2_1 _7732_ (.A(net330),
    .B(_0986_),
    .Y(_3495_));
 sky130_fd_sc_hd__a31oi_1 _7733_ (.A1(_3493_),
    .A2(_0986_),
    .A3(_3494_),
    .B1(_3495_),
    .Y(net223));
 sky130_fd_sc_hd__inv_1 _7734_ (.A(net351),
    .Y(_0311_));
 sky130_fd_sc_hd__inv_1 _7735_ (.A(net315),
    .Y(_0340_));
 sky130_fd_sc_hd__inv_1 _7736_ (.A(net347),
    .Y(_0335_));
 sky130_fd_sc_hd__inv_1 _7737_ (.A(net316),
    .Y(_0334_));
 sky130_fd_sc_hd__inv_1 _7738_ (.A(net348),
    .Y(_0329_));
 sky130_fd_sc_hd__inv_1 _7739_ (.A(net317),
    .Y(_0328_));
 sky130_fd_sc_hd__inv_1 _7740_ (.A(net340),
    .Y(_0377_));
 sky130_fd_sc_hd__inv_1 _7741_ (.A(net349),
    .Y(_0323_));
 sky130_fd_sc_hd__nand2b_1 _7742_ (.A_N(net364),
    .B(net825),
    .Y(_3496_));
 sky130_fd_sc_hd__inv_1 _7743_ (.A(_3496_),
    .Y(_0513_));
 sky130_fd_sc_hd__or2_2 _7744_ (.A(instr_lui),
    .B(instr_auipc),
    .X(_3497_));
 sky130_fd_sc_hd__or3_1 _7747_ (.A(is_beq_bne_blt_bge_bltu_bgeu),
    .B(is_sb_sh_sw),
    .C(_0992_),
    .X(_3500_));
 sky130_fd_sc_hd__and2_1 _7749_ (.A(\mem_rdata_q[31] ),
    .B(_3500_),
    .X(_3502_));
 sky130_fd_sc_hd__nand2_1 _7752_ (.A(\decoded_imm_j[20] ),
    .B(net772),
    .Y(_3505_));
 sky130_fd_sc_hd__nand2b_1 _7753_ (.A_N(_3502_),
    .B(_3505_),
    .Y(_3506_));
 sky130_fd_sc_hd__a21o_1 _7755_ (.A1(\mem_rdata_q[30] ),
    .A2(_3497_),
    .B1(_3506_),
    .X(_0524_));
 sky130_fd_sc_hd__a21o_1 _7756_ (.A1(\mem_rdata_q[29] ),
    .A2(_3497_),
    .B1(_3506_),
    .X(_0525_));
 sky130_fd_sc_hd__a21o_1 _7757_ (.A1(\mem_rdata_q[28] ),
    .A2(_3497_),
    .B1(_3506_),
    .X(_0526_));
 sky130_fd_sc_hd__a21o_1 _7758_ (.A1(\mem_rdata_q[27] ),
    .A2(_3497_),
    .B1(_3506_),
    .X(_0527_));
 sky130_fd_sc_hd__a21o_1 _7759_ (.A1(\mem_rdata_q[26] ),
    .A2(_3497_),
    .B1(_3506_),
    .X(_0528_));
 sky130_fd_sc_hd__a21o_1 _7760_ (.A1(\mem_rdata_q[25] ),
    .A2(_3497_),
    .B1(_3506_),
    .X(_0529_));
 sky130_fd_sc_hd__a21o_1 _7761_ (.A1(\mem_rdata_q[24] ),
    .A2(_3497_),
    .B1(_3506_),
    .X(_0530_));
 sky130_fd_sc_hd__a21o_1 _7762_ (.A1(\mem_rdata_q[23] ),
    .A2(_3497_),
    .B1(_3506_),
    .X(_0531_));
 sky130_fd_sc_hd__a21o_1 _7763_ (.A1(\mem_rdata_q[22] ),
    .A2(_3497_),
    .B1(_3506_),
    .X(_0532_));
 sky130_fd_sc_hd__a21o_1 _7764_ (.A1(\mem_rdata_q[21] ),
    .A2(_3497_),
    .B1(_3506_),
    .X(_0533_));
 sky130_fd_sc_hd__a21o_1 _7766_ (.A1(\mem_rdata_q[20] ),
    .A2(_3497_),
    .B1(_3506_),
    .X(_0534_));
 sky130_fd_sc_hd__a221o_1 _7768_ (.A1(net772),
    .A2(\decoded_imm_j[19] ),
    .B1(\mem_rdata_q[19] ),
    .B2(_3497_),
    .C1(_3502_),
    .X(_0535_));
 sky130_fd_sc_hd__a221o_1 _7769_ (.A1(net772),
    .A2(\decoded_imm_j[18] ),
    .B1(\mem_rdata_q[18] ),
    .B2(_3497_),
    .C1(_3502_),
    .X(_0536_));
 sky130_fd_sc_hd__a221o_1 _7770_ (.A1(net772),
    .A2(\decoded_imm_j[17] ),
    .B1(\mem_rdata_q[17] ),
    .B2(_3497_),
    .C1(_3502_),
    .X(_0537_));
 sky130_fd_sc_hd__a221o_1 _7771_ (.A1(net772),
    .A2(\decoded_imm_j[16] ),
    .B1(\mem_rdata_q[16] ),
    .B2(_3497_),
    .C1(_3502_),
    .X(_0538_));
 sky130_fd_sc_hd__a221o_1 _7772_ (.A1(net772),
    .A2(\decoded_imm_j[15] ),
    .B1(\mem_rdata_q[15] ),
    .B2(_3497_),
    .C1(_3502_),
    .X(_0539_));
 sky130_fd_sc_hd__a221o_1 _7774_ (.A1(net772),
    .A2(\decoded_imm_j[14] ),
    .B1(\mem_rdata_q[14] ),
    .B2(_3497_),
    .C1(_3502_),
    .X(_0540_));
 sky130_fd_sc_hd__a221o_1 _7775_ (.A1(net772),
    .A2(\decoded_imm_j[13] ),
    .B1(\mem_rdata_q[13] ),
    .B2(_3497_),
    .C1(_3502_),
    .X(_0541_));
 sky130_fd_sc_hd__a221o_1 _7776_ (.A1(net772),
    .A2(\decoded_imm_j[12] ),
    .B1(\mem_rdata_q[12] ),
    .B2(_3497_),
    .C1(_3502_),
    .X(_0542_));
 sky130_fd_sc_hd__a22oi_1 _7778_ (.A1(net772),
    .A2(\decoded_imm_j[11] ),
    .B1(\mem_rdata_q[7] ),
    .B2(is_beq_bne_blt_bge_bltu_bgeu),
    .Y(_3512_));
 sky130_fd_sc_hd__o21ai_0 _7779_ (.A1(is_sb_sh_sw),
    .A2(_0992_),
    .B1(\mem_rdata_q[31] ),
    .Y(_3513_));
 sky130_fd_sc_hd__nand2_1 _7780_ (.A(_3512_),
    .B(_3513_),
    .Y(_0543_));
 sky130_fd_sc_hd__a22o_1 _7781_ (.A1(net772),
    .A2(\decoded_imm_j[10] ),
    .B1(_3500_),
    .B2(\mem_rdata_q[30] ),
    .X(_0544_));
 sky130_fd_sc_hd__a22o_1 _7782_ (.A1(net772),
    .A2(\decoded_imm_j[9] ),
    .B1(_3500_),
    .B2(\mem_rdata_q[29] ),
    .X(_0545_));
 sky130_fd_sc_hd__a22o_1 _7783_ (.A1(net772),
    .A2(\decoded_imm_j[8] ),
    .B1(_3500_),
    .B2(\mem_rdata_q[28] ),
    .X(_0546_));
 sky130_fd_sc_hd__a22o_1 _7784_ (.A1(net772),
    .A2(\decoded_imm_j[7] ),
    .B1(_3500_),
    .B2(\mem_rdata_q[27] ),
    .X(_0547_));
 sky130_fd_sc_hd__a22o_1 _7785_ (.A1(net772),
    .A2(\decoded_imm_j[6] ),
    .B1(_3500_),
    .B2(\mem_rdata_q[26] ),
    .X(_0548_));
 sky130_fd_sc_hd__a22o_1 _7786_ (.A1(net772),
    .A2(\decoded_imm_j[5] ),
    .B1(_3500_),
    .B2(\mem_rdata_q[25] ),
    .X(_0549_));
 sky130_fd_sc_hd__inv_1 _7787_ (.A(is_beq_bne_blt_bge_bltu_bgeu),
    .Y(_3514_));
 sky130_fd_sc_hd__inv_1 _7788_ (.A(is_sb_sh_sw),
    .Y(_3515_));
 sky130_fd_sc_hd__nand2_1 _7789_ (.A(_3514_),
    .B(_3515_),
    .Y(_3516_));
 sky130_fd_sc_hd__a222oi_1 _7790_ (.A1(net772),
    .A2(\decoded_imm_j[4] ),
    .B1(\mem_rdata_q[11] ),
    .B2(_3516_),
    .C1(_0992_),
    .C2(\mem_rdata_q[24] ),
    .Y(_3517_));
 sky130_fd_sc_hd__inv_1 _7791_ (.A(_3517_),
    .Y(_0550_));
 sky130_fd_sc_hd__a222oi_1 _7792_ (.A1(net772),
    .A2(\decoded_imm_j[3] ),
    .B1(\mem_rdata_q[10] ),
    .B2(_3516_),
    .C1(_0992_),
    .C2(\mem_rdata_q[23] ),
    .Y(_3518_));
 sky130_fd_sc_hd__inv_1 _7793_ (.A(_3518_),
    .Y(_0551_));
 sky130_fd_sc_hd__a222oi_1 _7794_ (.A1(net772),
    .A2(\decoded_imm_j[2] ),
    .B1(\mem_rdata_q[9] ),
    .B2(_3516_),
    .C1(_0992_),
    .C2(\mem_rdata_q[22] ),
    .Y(_3519_));
 sky130_fd_sc_hd__inv_1 _7795_ (.A(_3519_),
    .Y(_0552_));
 sky130_fd_sc_hd__a222oi_1 _7796_ (.A1(net772),
    .A2(\decoded_imm_j[1] ),
    .B1(\mem_rdata_q[8] ),
    .B2(_3516_),
    .C1(_0992_),
    .C2(\mem_rdata_q[21] ),
    .Y(_3520_));
 sky130_fd_sc_hd__inv_1 _7797_ (.A(_3520_),
    .Y(_0553_));
 sky130_fd_sc_hd__inv_2 _7798_ (.A(net825),
    .Y(_3521_));
 sky130_fd_sc_hd__and3_1 _7801_ (.A(\count_instr[50] ),
    .B(\count_instr[51] ),
    .C(\count_instr[52] ),
    .X(_3524_));
 sky130_fd_sc_hd__nand4_1 _7802_ (.A(\count_instr[53] ),
    .B(\count_instr[54] ),
    .C(\count_instr[55] ),
    .D(_3524_),
    .Y(_3525_));
 sky130_fd_sc_hd__and3_1 _7803_ (.A(\count_instr[45] ),
    .B(\count_instr[46] ),
    .C(\count_instr[47] ),
    .X(_3526_));
 sky130_fd_sc_hd__and3_1 _7804_ (.A(\count_instr[48] ),
    .B(\count_instr[49] ),
    .C(_3526_),
    .X(_3527_));
 sky130_fd_sc_hd__nand2_1 _7806_ (.A(\count_instr[56] ),
    .B(_3527_),
    .Y(_3529_));
 sky130_fd_sc_hd__nor2_1 _7807_ (.A(_3525_),
    .B(_3529_),
    .Y(_3530_));
 sky130_fd_sc_hd__and3_1 _7808_ (.A(\count_instr[57] ),
    .B(\count_instr[58] ),
    .C(\count_instr[59] ),
    .X(_3531_));
 sky130_fd_sc_hd__and2_1 _7809_ (.A(\count_instr[60] ),
    .B(_3531_),
    .X(_3532_));
 sky130_fd_sc_hd__and3_1 _7810_ (.A(\count_instr[61] ),
    .B(_3530_),
    .C(_3532_),
    .X(_3533_));
 sky130_fd_sc_hd__inv_1 _7811_ (.A(\count_instr[12] ),
    .Y(_3534_));
 sky130_fd_sc_hd__and4_1 _7812_ (.A(\count_instr[6] ),
    .B(\count_instr[7] ),
    .C(\count_instr[8] ),
    .D(\count_instr[9] ),
    .X(_3535_));
 sky130_fd_sc_hd__nand3_2 _7813_ (.A(\count_instr[10] ),
    .B(\count_instr[11] ),
    .C(_3535_),
    .Y(_3536_));
 sky130_fd_sc_hd__nand2_1 _7814_ (.A(net779),
    .B(net773),
    .Y(_3537_));
 sky130_fd_sc_hd__nand4_1 _7815_ (.A(\count_instr[2] ),
    .B(\count_instr[3] ),
    .C(\count_instr[4] ),
    .D(\count_instr[5] ),
    .Y(_3538_));
 sky130_fd_sc_hd__nor4_4 _7816_ (.A(_3534_),
    .B(_3536_),
    .C(_3537_),
    .D(_3538_),
    .Y(_3539_));
 sky130_fd_sc_hd__inv_1 _7817_ (.A(\count_instr[20] ),
    .Y(_3540_));
 sky130_fd_sc_hd__inv_1 _7818_ (.A(\count_instr[21] ),
    .Y(_3541_));
 sky130_fd_sc_hd__inv_1 _7819_ (.A(\count_instr[16] ),
    .Y(_3542_));
 sky130_fd_sc_hd__nand3_1 _7820_ (.A(\count_instr[13] ),
    .B(\count_instr[14] ),
    .C(\count_instr[15] ),
    .Y(_3543_));
 sky130_fd_sc_hd__nor2_1 _7821_ (.A(_3542_),
    .B(_3543_),
    .Y(_3544_));
 sky130_fd_sc_hd__nand4_1 _7822_ (.A(\count_instr[17] ),
    .B(\count_instr[18] ),
    .C(\count_instr[19] ),
    .D(_3544_),
    .Y(_3545_));
 sky130_fd_sc_hd__nor3_1 _7823_ (.A(_3540_),
    .B(_3541_),
    .C(_3545_),
    .Y(_3546_));
 sky130_fd_sc_hd__inv_1 _7824_ (.A(\count_instr[35] ),
    .Y(_3547_));
 sky130_fd_sc_hd__and4_1 _7825_ (.A(\count_instr[28] ),
    .B(\count_instr[29] ),
    .C(\count_instr[30] ),
    .D(\count_instr[31] ),
    .X(_3548_));
 sky130_fd_sc_hd__nand4_1 _7826_ (.A(\count_instr[32] ),
    .B(\count_instr[33] ),
    .C(\count_instr[34] ),
    .D(_3548_),
    .Y(_3549_));
 sky130_fd_sc_hd__and4_1 _7827_ (.A(\count_instr[22] ),
    .B(\count_instr[23] ),
    .C(\count_instr[24] ),
    .D(\count_instr[25] ),
    .X(_3550_));
 sky130_fd_sc_hd__nand3_1 _7828_ (.A(\count_instr[26] ),
    .B(\count_instr[27] ),
    .C(_3550_),
    .Y(_3551_));
 sky130_fd_sc_hd__nor3_1 _7829_ (.A(_3547_),
    .B(_3549_),
    .C(_3551_),
    .Y(_3552_));
 sky130_fd_sc_hd__nand4_1 _7830_ (.A(_0242_),
    .B(_3539_),
    .C(_3546_),
    .D(_3552_),
    .Y(_3553_));
 sky130_fd_sc_hd__and3_1 _7831_ (.A(\count_instr[36] ),
    .B(\count_instr[37] ),
    .C(\count_instr[38] ),
    .X(_3554_));
 sky130_fd_sc_hd__nand3_1 _7832_ (.A(\count_instr[39] ),
    .B(\count_instr[40] ),
    .C(_3554_),
    .Y(_3555_));
 sky130_fd_sc_hd__or2_1 _7833_ (.A(_3553_),
    .B(_3555_),
    .X(_3556_));
 sky130_fd_sc_hd__nand4_1 _7834_ (.A(\count_instr[41] ),
    .B(\count_instr[42] ),
    .C(\count_instr[43] ),
    .D(\count_instr[44] ),
    .Y(_3557_));
 sky130_fd_sc_hd__nor2_4 _7835_ (.A(_3556_),
    .B(_3557_),
    .Y(_3558_));
 sky130_fd_sc_hd__nand2_1 _7836_ (.A(_3533_),
    .B(_3558_),
    .Y(_3559_));
 sky130_fd_sc_hd__xor2_1 _7837_ (.A(\count_instr[62] ),
    .B(_3559_),
    .X(_3560_));
 sky130_fd_sc_hd__nor2_1 _7838_ (.A(net824),
    .B(_3560_),
    .Y(_0554_));
 sky130_fd_sc_hd__and3_1 _7839_ (.A(\count_instr[0] ),
    .B(\count_instr[1] ),
    .C(_3539_),
    .X(_3561_));
 sky130_fd_sc_hd__and3_1 _7841_ (.A(_3546_),
    .B(_3552_),
    .C(_3561_),
    .X(_3563_));
 sky130_fd_sc_hd__nand2b_2 _7842_ (.A_N(_3555_),
    .B(_3563_),
    .Y(_3564_));
 sky130_fd_sc_hd__nor2_4 _7843_ (.A(_3557_),
    .B(_3564_),
    .Y(_3565_));
 sky130_fd_sc_hd__and3_1 _7844_ (.A(_3530_),
    .B(_3532_),
    .C(_3565_),
    .X(_3566_));
 sky130_fd_sc_hd__xnor2_1 _7845_ (.A(\count_instr[61] ),
    .B(_3566_),
    .Y(_3567_));
 sky130_fd_sc_hd__nor2_1 _7846_ (.A(net824),
    .B(_3567_),
    .Y(_0555_));
 sky130_fd_sc_hd__nand3_1 _7847_ (.A(_3530_),
    .B(_3531_),
    .C(_3558_),
    .Y(_3568_));
 sky130_fd_sc_hd__xor2_1 _7848_ (.A(\count_instr[60] ),
    .B(_3568_),
    .X(_3569_));
 sky130_fd_sc_hd__nor2_1 _7849_ (.A(net824),
    .B(_3569_),
    .Y(_0556_));
 sky130_fd_sc_hd__nand4_1 _7850_ (.A(\count_instr[57] ),
    .B(\count_instr[58] ),
    .C(_3530_),
    .D(_3565_),
    .Y(_3570_));
 sky130_fd_sc_hd__xor2_1 _7851_ (.A(\count_instr[59] ),
    .B(_3570_),
    .X(_3571_));
 sky130_fd_sc_hd__nor2_1 _7852_ (.A(net824),
    .B(_3571_),
    .Y(_0557_));
 sky130_fd_sc_hd__nand3_1 _7853_ (.A(\count_instr[57] ),
    .B(_3530_),
    .C(_3558_),
    .Y(_3572_));
 sky130_fd_sc_hd__xor2_1 _7854_ (.A(\count_instr[58] ),
    .B(_3572_),
    .X(_3573_));
 sky130_fd_sc_hd__nor2_1 _7855_ (.A(net824),
    .B(_3573_),
    .Y(_0558_));
 sky130_fd_sc_hd__nand2_1 _7856_ (.A(_3530_),
    .B(_3565_),
    .Y(_3574_));
 sky130_fd_sc_hd__xor2_1 _7857_ (.A(\count_instr[57] ),
    .B(_3574_),
    .X(_3575_));
 sky130_fd_sc_hd__nor2_1 _7858_ (.A(net824),
    .B(_3575_),
    .Y(_0559_));
 sky130_fd_sc_hd__nand2_1 _7859_ (.A(_3527_),
    .B(_3558_),
    .Y(_3576_));
 sky130_fd_sc_hd__o21ai_0 _7860_ (.A1(_3525_),
    .A2(_3576_),
    .B1(\count_instr[56] ),
    .Y(_3577_));
 sky130_fd_sc_hd__or3_1 _7861_ (.A(\count_instr[56] ),
    .B(_3525_),
    .C(_3576_),
    .X(_3578_));
 sky130_fd_sc_hd__a21oi_1 _7863_ (.A1(_3577_),
    .A2(_3578_),
    .B1(net824),
    .Y(_0560_));
 sky130_fd_sc_hd__nand3_1 _7864_ (.A(\count_instr[53] ),
    .B(\count_instr[54] ),
    .C(_3524_),
    .Y(_3580_));
 sky130_fd_sc_hd__nand2_1 _7865_ (.A(_3527_),
    .B(_3565_),
    .Y(_3581_));
 sky130_fd_sc_hd__o21ai_0 _7866_ (.A1(_3580_),
    .A2(_3581_),
    .B1(\count_instr[55] ),
    .Y(_3582_));
 sky130_fd_sc_hd__or3_1 _7867_ (.A(\count_instr[55] ),
    .B(_3580_),
    .C(_3581_),
    .X(_3583_));
 sky130_fd_sc_hd__a21oi_1 _7868_ (.A1(_3582_),
    .A2(_3583_),
    .B1(net824),
    .Y(_0561_));
 sky130_fd_sc_hd__nand4_1 _7869_ (.A(\count_instr[53] ),
    .B(_3524_),
    .C(_3527_),
    .D(_3558_),
    .Y(_3584_));
 sky130_fd_sc_hd__xor2_1 _7870_ (.A(\count_instr[54] ),
    .B(_3584_),
    .X(_3585_));
 sky130_fd_sc_hd__nor2_1 _7871_ (.A(net824),
    .B(_3585_),
    .Y(_0562_));
 sky130_fd_sc_hd__nand3_1 _7873_ (.A(_3524_),
    .B(_3527_),
    .C(_3565_),
    .Y(_3587_));
 sky130_fd_sc_hd__xor2_1 _7874_ (.A(\count_instr[53] ),
    .B(_3587_),
    .X(_3588_));
 sky130_fd_sc_hd__nor2_1 _7875_ (.A(net824),
    .B(_3588_),
    .Y(_0563_));
 sky130_fd_sc_hd__nand4_1 _7876_ (.A(\count_instr[50] ),
    .B(\count_instr[51] ),
    .C(_3527_),
    .D(_3558_),
    .Y(_3589_));
 sky130_fd_sc_hd__xor2_1 _7877_ (.A(\count_instr[52] ),
    .B(_3589_),
    .X(_3590_));
 sky130_fd_sc_hd__nor2_1 _7878_ (.A(net822),
    .B(_3590_),
    .Y(_0564_));
 sky130_fd_sc_hd__nand3_1 _7879_ (.A(\count_instr[50] ),
    .B(_3527_),
    .C(_3565_),
    .Y(_3591_));
 sky130_fd_sc_hd__xor2_1 _7880_ (.A(\count_instr[51] ),
    .B(_3591_),
    .X(_3592_));
 sky130_fd_sc_hd__nor2_1 _7881_ (.A(net822),
    .B(_3592_),
    .Y(_0565_));
 sky130_fd_sc_hd__xor2_1 _7882_ (.A(\count_instr[50] ),
    .B(_3576_),
    .X(_3593_));
 sky130_fd_sc_hd__nor2_1 _7883_ (.A(net822),
    .B(_3593_),
    .Y(_0566_));
 sky130_fd_sc_hd__nand3_1 _7884_ (.A(\count_instr[48] ),
    .B(_3526_),
    .C(_3565_),
    .Y(_3594_));
 sky130_fd_sc_hd__xor2_1 _7885_ (.A(\count_instr[49] ),
    .B(_3594_),
    .X(_3595_));
 sky130_fd_sc_hd__nor2_1 _7886_ (.A(net822),
    .B(_3595_),
    .Y(_0567_));
 sky130_fd_sc_hd__nand2_1 _7887_ (.A(_3526_),
    .B(_3558_),
    .Y(_3596_));
 sky130_fd_sc_hd__xor2_1 _7888_ (.A(\count_instr[48] ),
    .B(_3596_),
    .X(_3597_));
 sky130_fd_sc_hd__nor2_1 _7889_ (.A(net822),
    .B(_3597_),
    .Y(_0568_));
 sky130_fd_sc_hd__nand3_1 _7890_ (.A(\count_instr[45] ),
    .B(\count_instr[46] ),
    .C(_3565_),
    .Y(_3598_));
 sky130_fd_sc_hd__xor2_1 _7891_ (.A(\count_instr[47] ),
    .B(_3598_),
    .X(_3599_));
 sky130_fd_sc_hd__nor2_1 _7892_ (.A(net822),
    .B(_3599_),
    .Y(_0569_));
 sky130_fd_sc_hd__nand2_1 _7893_ (.A(\count_instr[45] ),
    .B(_3558_),
    .Y(_3600_));
 sky130_fd_sc_hd__xor2_1 _7894_ (.A(\count_instr[46] ),
    .B(_3600_),
    .X(_3601_));
 sky130_fd_sc_hd__nor2_1 _7895_ (.A(net822),
    .B(_3601_),
    .Y(_0570_));
 sky130_fd_sc_hd__xnor2_1 _7896_ (.A(\count_instr[45] ),
    .B(_3565_),
    .Y(_3602_));
 sky130_fd_sc_hd__nor2_1 _7897_ (.A(net822),
    .B(_3602_),
    .Y(_0571_));
 sky130_fd_sc_hd__nand3_1 _7898_ (.A(\count_instr[41] ),
    .B(\count_instr[42] ),
    .C(\count_instr[43] ),
    .Y(_3603_));
 sky130_fd_sc_hd__o21ai_0 _7899_ (.A1(_3556_),
    .A2(_3603_),
    .B1(\count_instr[44] ),
    .Y(_3604_));
 sky130_fd_sc_hd__or3_1 _7900_ (.A(\count_instr[44] ),
    .B(_3556_),
    .C(_3603_),
    .X(_3605_));
 sky130_fd_sc_hd__a21oi_1 _7901_ (.A1(_3604_),
    .A2(_3605_),
    .B1(net821),
    .Y(_0572_));
 sky130_fd_sc_hd__nand2_1 _7902_ (.A(\count_instr[41] ),
    .B(\count_instr[42] ),
    .Y(_3606_));
 sky130_fd_sc_hd__o21ai_0 _7903_ (.A1(_3606_),
    .A2(_3564_),
    .B1(\count_instr[43] ),
    .Y(_3607_));
 sky130_fd_sc_hd__or3_1 _7904_ (.A(\count_instr[43] ),
    .B(_3606_),
    .C(_3564_),
    .X(_3608_));
 sky130_fd_sc_hd__a21oi_1 _7905_ (.A1(_3607_),
    .A2(_3608_),
    .B1(net821),
    .Y(_0573_));
 sky130_fd_sc_hd__inv_1 _7906_ (.A(\count_instr[41] ),
    .Y(_3609_));
 sky130_fd_sc_hd__nor2_1 _7907_ (.A(_3609_),
    .B(_3556_),
    .Y(_3610_));
 sky130_fd_sc_hd__xnor2_1 _7908_ (.A(\count_instr[42] ),
    .B(_3610_),
    .Y(_3611_));
 sky130_fd_sc_hd__nor2_1 _7909_ (.A(net821),
    .B(_3611_),
    .Y(_0574_));
 sky130_fd_sc_hd__xor2_1 _7911_ (.A(\count_instr[41] ),
    .B(_3564_),
    .X(_3613_));
 sky130_fd_sc_hd__nor2_1 _7912_ (.A(net821),
    .B(_3613_),
    .Y(_0575_));
 sky130_fd_sc_hd__nand2_1 _7913_ (.A(\count_instr[39] ),
    .B(_3554_),
    .Y(_3614_));
 sky130_fd_sc_hd__o21ai_0 _7914_ (.A1(_3553_),
    .A2(_3614_),
    .B1(\count_instr[40] ),
    .Y(_3615_));
 sky130_fd_sc_hd__or3_1 _7915_ (.A(\count_instr[40] ),
    .B(_3553_),
    .C(_3614_),
    .X(_3616_));
 sky130_fd_sc_hd__a21oi_1 _7916_ (.A1(_3615_),
    .A2(_3616_),
    .B1(net821),
    .Y(_0576_));
 sky130_fd_sc_hd__nand2_1 _7917_ (.A(_3554_),
    .B(_3563_),
    .Y(_3617_));
 sky130_fd_sc_hd__xor2_1 _7918_ (.A(\count_instr[39] ),
    .B(_3617_),
    .X(_3618_));
 sky130_fd_sc_hd__nor2_1 _7919_ (.A(net821),
    .B(_3618_),
    .Y(_0577_));
 sky130_fd_sc_hd__nand2_1 _7920_ (.A(\count_instr[36] ),
    .B(\count_instr[37] ),
    .Y(_3619_));
 sky130_fd_sc_hd__nor2_1 _7921_ (.A(_3553_),
    .B(_3619_),
    .Y(_3620_));
 sky130_fd_sc_hd__xnor2_1 _7922_ (.A(\count_instr[38] ),
    .B(_3620_),
    .Y(_3621_));
 sky130_fd_sc_hd__nor2_1 _7923_ (.A(net821),
    .B(_3621_),
    .Y(_0578_));
 sky130_fd_sc_hd__nand2_1 _7924_ (.A(\count_instr[36] ),
    .B(_3563_),
    .Y(_3622_));
 sky130_fd_sc_hd__xor2_1 _7925_ (.A(\count_instr[37] ),
    .B(_3622_),
    .X(_3623_));
 sky130_fd_sc_hd__nor2_1 _7926_ (.A(net821),
    .B(_3623_),
    .Y(_0579_));
 sky130_fd_sc_hd__xor2_1 _7927_ (.A(\count_instr[36] ),
    .B(_3553_),
    .X(_3624_));
 sky130_fd_sc_hd__nor2_1 _7928_ (.A(net821),
    .B(_3624_),
    .Y(_0580_));
 sky130_fd_sc_hd__nor2_1 _7929_ (.A(_3540_),
    .B(_3545_),
    .Y(_3625_));
 sky130_fd_sc_hd__nand2_1 _7930_ (.A(\count_instr[21] ),
    .B(_3625_),
    .Y(_3626_));
 sky130_fd_sc_hd__nand3_1 _7931_ (.A(\count_instr[0] ),
    .B(\count_instr[1] ),
    .C(_3539_),
    .Y(_3627_));
 sky130_fd_sc_hd__nor4_1 _7932_ (.A(_3626_),
    .B(_3549_),
    .C(_3551_),
    .D(_3627_),
    .Y(_3628_));
 sky130_fd_sc_hd__xnor2_1 _7933_ (.A(\count_instr[35] ),
    .B(_3628_),
    .Y(_3629_));
 sky130_fd_sc_hd__nor2_1 _7934_ (.A(net822),
    .B(_3629_),
    .Y(_0581_));
 sky130_fd_sc_hd__nand2_1 _7935_ (.A(_0242_),
    .B(_3539_),
    .Y(_3630_));
 sky130_fd_sc_hd__nor3_1 _7936_ (.A(_3630_),
    .B(_3626_),
    .C(_3551_),
    .Y(_3631_));
 sky130_fd_sc_hd__nand4_1 _7937_ (.A(\count_instr[32] ),
    .B(\count_instr[33] ),
    .C(_3548_),
    .D(_3631_),
    .Y(_3632_));
 sky130_fd_sc_hd__xor2_1 _7938_ (.A(\count_instr[34] ),
    .B(_3632_),
    .X(_3633_));
 sky130_fd_sc_hd__nor2_1 _7939_ (.A(net822),
    .B(_3633_),
    .Y(_0582_));
 sky130_fd_sc_hd__nor3_1 _7940_ (.A(_3626_),
    .B(_3551_),
    .C(_3627_),
    .Y(_3634_));
 sky130_fd_sc_hd__nand3_1 _7941_ (.A(\count_instr[32] ),
    .B(_3548_),
    .C(_3634_),
    .Y(_3635_));
 sky130_fd_sc_hd__xor2_1 _7942_ (.A(\count_instr[33] ),
    .B(_3635_),
    .X(_3636_));
 sky130_fd_sc_hd__nor2_1 _7943_ (.A(net822),
    .B(_3636_),
    .Y(_0583_));
 sky130_fd_sc_hd__nand2_1 _7944_ (.A(_3548_),
    .B(_3631_),
    .Y(_3637_));
 sky130_fd_sc_hd__xor2_1 _7945_ (.A(\count_instr[32] ),
    .B(_3637_),
    .X(_3638_));
 sky130_fd_sc_hd__nor2_1 _7946_ (.A(net822),
    .B(_3638_),
    .Y(_0584_));
 sky130_fd_sc_hd__nand4_1 _7947_ (.A(\count_instr[28] ),
    .B(\count_instr[29] ),
    .C(\count_instr[30] ),
    .D(_3634_),
    .Y(_3639_));
 sky130_fd_sc_hd__xor2_1 _7948_ (.A(\count_instr[31] ),
    .B(_3639_),
    .X(_3640_));
 sky130_fd_sc_hd__nor2_1 _7949_ (.A(net824),
    .B(_3640_),
    .Y(_0585_));
 sky130_fd_sc_hd__and3_1 _7952_ (.A(\count_instr[28] ),
    .B(\count_instr[29] ),
    .C(_3631_),
    .X(_3643_));
 sky130_fd_sc_hd__xnor2_1 _7953_ (.A(\count_instr[30] ),
    .B(_3643_),
    .Y(_3644_));
 sky130_fd_sc_hd__nor2_1 _7954_ (.A(net824),
    .B(_3644_),
    .Y(_0586_));
 sky130_fd_sc_hd__nand2_1 _7955_ (.A(\count_instr[28] ),
    .B(_3634_),
    .Y(_3645_));
 sky130_fd_sc_hd__xor2_1 _7956_ (.A(\count_instr[29] ),
    .B(_3645_),
    .X(_3646_));
 sky130_fd_sc_hd__nor2_1 _7957_ (.A(net824),
    .B(_3646_),
    .Y(_0587_));
 sky130_fd_sc_hd__xnor2_1 _7958_ (.A(\count_instr[28] ),
    .B(_3631_),
    .Y(_3647_));
 sky130_fd_sc_hd__nor2_1 _7959_ (.A(net824),
    .B(_3647_),
    .Y(_0588_));
 sky130_fd_sc_hd__nor2_1 _7961_ (.A(_3626_),
    .B(_3627_),
    .Y(_3649_));
 sky130_fd_sc_hd__nand3_1 _7962_ (.A(\count_instr[26] ),
    .B(_3550_),
    .C(_3649_),
    .Y(_3650_));
 sky130_fd_sc_hd__xnor2_1 _7963_ (.A(\count_instr[27] ),
    .B(_3650_),
    .Y(_3651_));
 sky130_fd_sc_hd__and2_1 _7964_ (.A(net825),
    .B(_3651_),
    .X(_0589_));
 sky130_fd_sc_hd__nor2_1 _7965_ (.A(_3630_),
    .B(_3626_),
    .Y(_3652_));
 sky130_fd_sc_hd__nand2_1 _7966_ (.A(_3550_),
    .B(_3652_),
    .Y(_3653_));
 sky130_fd_sc_hd__xor2_1 _7967_ (.A(\count_instr[26] ),
    .B(_3653_),
    .X(_3654_));
 sky130_fd_sc_hd__nor2_1 _7968_ (.A(net824),
    .B(_3654_),
    .Y(_0590_));
 sky130_fd_sc_hd__and4_1 _7969_ (.A(\count_instr[22] ),
    .B(\count_instr[23] ),
    .C(\count_instr[24] ),
    .D(_3649_),
    .X(_3655_));
 sky130_fd_sc_hd__xnor2_1 _7970_ (.A(\count_instr[25] ),
    .B(_3655_),
    .Y(_3656_));
 sky130_fd_sc_hd__nor2_1 _7971_ (.A(net824),
    .B(_3656_),
    .Y(_0591_));
 sky130_fd_sc_hd__and3_1 _7972_ (.A(\count_instr[22] ),
    .B(\count_instr[23] ),
    .C(_3652_),
    .X(_3657_));
 sky130_fd_sc_hd__xnor2_1 _7973_ (.A(\count_instr[24] ),
    .B(_3657_),
    .Y(_3658_));
 sky130_fd_sc_hd__nor2_1 _7974_ (.A(net824),
    .B(_3658_),
    .Y(_0592_));
 sky130_fd_sc_hd__nand2_1 _7975_ (.A(\count_instr[22] ),
    .B(_3649_),
    .Y(_3659_));
 sky130_fd_sc_hd__xor2_1 _7976_ (.A(\count_instr[23] ),
    .B(_3659_),
    .X(_3660_));
 sky130_fd_sc_hd__nor2_1 _7977_ (.A(net824),
    .B(_3660_),
    .Y(_0593_));
 sky130_fd_sc_hd__xnor2_1 _7978_ (.A(\count_instr[22] ),
    .B(_3652_),
    .Y(_3661_));
 sky130_fd_sc_hd__nor2_1 _7979_ (.A(net824),
    .B(_3661_),
    .Y(_0594_));
 sky130_fd_sc_hd__nand2_1 _7980_ (.A(_3625_),
    .B(_3561_),
    .Y(_3662_));
 sky130_fd_sc_hd__xnor2_1 _7981_ (.A(_3541_),
    .B(_3662_),
    .Y(_3663_));
 sky130_fd_sc_hd__nor2_1 _7982_ (.A(net822),
    .B(_3663_),
    .Y(_0595_));
 sky130_fd_sc_hd__o21ai_0 _7983_ (.A1(_3630_),
    .A2(_3545_),
    .B1(\count_instr[20] ),
    .Y(_3664_));
 sky130_fd_sc_hd__or3_1 _7984_ (.A(\count_instr[20] ),
    .B(_3630_),
    .C(_3545_),
    .X(_3665_));
 sky130_fd_sc_hd__a21oi_1 _7985_ (.A1(_3664_),
    .A2(_3665_),
    .B1(net822),
    .Y(_0596_));
 sky130_fd_sc_hd__nand4_1 _7986_ (.A(\count_instr[17] ),
    .B(\count_instr[18] ),
    .C(_3544_),
    .D(_3561_),
    .Y(_3666_));
 sky130_fd_sc_hd__xor2_1 _7987_ (.A(\count_instr[19] ),
    .B(_3666_),
    .X(_3667_));
 sky130_fd_sc_hd__nor2_1 _7988_ (.A(net822),
    .B(_3667_),
    .Y(_0597_));
 sky130_fd_sc_hd__nand2_1 _7989_ (.A(\count_instr[17] ),
    .B(_3544_),
    .Y(_3668_));
 sky130_fd_sc_hd__o21ai_0 _7990_ (.A1(_3630_),
    .A2(_3668_),
    .B1(\count_instr[18] ),
    .Y(_3669_));
 sky130_fd_sc_hd__or3_1 _7991_ (.A(\count_instr[18] ),
    .B(_3630_),
    .C(_3668_),
    .X(_3670_));
 sky130_fd_sc_hd__a21oi_1 _7992_ (.A1(_3669_),
    .A2(_3670_),
    .B1(net822),
    .Y(_0598_));
 sky130_fd_sc_hd__nand2_1 _7994_ (.A(_3544_),
    .B(_3561_),
    .Y(_3672_));
 sky130_fd_sc_hd__xor2_1 _7995_ (.A(\count_instr[17] ),
    .B(_3672_),
    .X(_3673_));
 sky130_fd_sc_hd__nor2_1 _7996_ (.A(net822),
    .B(_3673_),
    .Y(_0599_));
 sky130_fd_sc_hd__o21ai_0 _7997_ (.A1(_3630_),
    .A2(_3543_),
    .B1(\count_instr[16] ),
    .Y(_3674_));
 sky130_fd_sc_hd__or3_1 _7998_ (.A(\count_instr[16] ),
    .B(_3630_),
    .C(_3543_),
    .X(_3675_));
 sky130_fd_sc_hd__a21oi_1 _7999_ (.A1(_3674_),
    .A2(_3675_),
    .B1(net822),
    .Y(_0600_));
 sky130_fd_sc_hd__nand3_1 _8001_ (.A(\count_instr[13] ),
    .B(\count_instr[14] ),
    .C(_3561_),
    .Y(_3677_));
 sky130_fd_sc_hd__xnor2_1 _8002_ (.A(\count_instr[15] ),
    .B(_3677_),
    .Y(_3678_));
 sky130_fd_sc_hd__and2_1 _8003_ (.A(net825),
    .B(_3678_),
    .X(_0601_));
 sky130_fd_sc_hd__nand3_1 _8004_ (.A(\count_instr[13] ),
    .B(_0242_),
    .C(_3539_),
    .Y(_3679_));
 sky130_fd_sc_hd__xor2_1 _8005_ (.A(\count_instr[14] ),
    .B(_3679_),
    .X(_3680_));
 sky130_fd_sc_hd__nor2_1 _8006_ (.A(net822),
    .B(_3680_),
    .Y(_0602_));
 sky130_fd_sc_hd__xnor2_1 _8007_ (.A(\count_instr[13] ),
    .B(_3561_),
    .Y(_3681_));
 sky130_fd_sc_hd__nor2_1 _8008_ (.A(net822),
    .B(_3681_),
    .Y(_0603_));
 sky130_fd_sc_hd__nor2_1 _8009_ (.A(_3537_),
    .B(_3538_),
    .Y(_3682_));
 sky130_fd_sc_hd__nand2_1 _8010_ (.A(_0242_),
    .B(_3682_),
    .Y(_3683_));
 sky130_fd_sc_hd__o21ai_0 _8011_ (.A1(_3536_),
    .A2(_3683_),
    .B1(\count_instr[12] ),
    .Y(_3684_));
 sky130_fd_sc_hd__or3_1 _8012_ (.A(\count_instr[12] ),
    .B(_3536_),
    .C(_3683_),
    .X(_3685_));
 sky130_fd_sc_hd__a21oi_1 _8013_ (.A1(_3684_),
    .A2(_3685_),
    .B1(net821),
    .Y(_0604_));
 sky130_fd_sc_hd__nand2_1 _8014_ (.A(\count_instr[10] ),
    .B(_3535_),
    .Y(_3686_));
 sky130_fd_sc_hd__nand3_1 _8015_ (.A(\count_instr[0] ),
    .B(\count_instr[1] ),
    .C(_3682_),
    .Y(_3687_));
 sky130_fd_sc_hd__o21ai_0 _8016_ (.A1(_3686_),
    .A2(_3687_),
    .B1(\count_instr[11] ),
    .Y(_3688_));
 sky130_fd_sc_hd__or3_1 _8017_ (.A(\count_instr[11] ),
    .B(_3686_),
    .C(_3687_),
    .X(_3689_));
 sky130_fd_sc_hd__a21oi_1 _8019_ (.A1(_3688_),
    .A2(_3689_),
    .B1(net821),
    .Y(_0605_));
 sky130_fd_sc_hd__nand3_1 _8020_ (.A(_0242_),
    .B(_3535_),
    .C(_3682_),
    .Y(_3691_));
 sky130_fd_sc_hd__xor2_1 _8021_ (.A(\count_instr[10] ),
    .B(_3691_),
    .X(_3692_));
 sky130_fd_sc_hd__nor2_1 _8022_ (.A(net821),
    .B(_3692_),
    .Y(_0606_));
 sky130_fd_sc_hd__nand3_1 _8023_ (.A(\count_instr[6] ),
    .B(\count_instr[7] ),
    .C(\count_instr[8] ),
    .Y(_3693_));
 sky130_fd_sc_hd__o21ai_0 _8024_ (.A1(_3693_),
    .A2(_3687_),
    .B1(\count_instr[9] ),
    .Y(_3694_));
 sky130_fd_sc_hd__or3_1 _8025_ (.A(\count_instr[9] ),
    .B(_3693_),
    .C(_3687_),
    .X(_3695_));
 sky130_fd_sc_hd__a21oi_1 _8026_ (.A1(_3694_),
    .A2(_3695_),
    .B1(net821),
    .Y(_0607_));
 sky130_fd_sc_hd__nand2_1 _8027_ (.A(\count_instr[6] ),
    .B(\count_instr[7] ),
    .Y(_3696_));
 sky130_fd_sc_hd__o21ai_0 _8028_ (.A1(_3696_),
    .A2(_3683_),
    .B1(\count_instr[8] ),
    .Y(_3697_));
 sky130_fd_sc_hd__or3_1 _8029_ (.A(\count_instr[8] ),
    .B(_3696_),
    .C(_3683_),
    .X(_3698_));
 sky130_fd_sc_hd__a21oi_1 _8030_ (.A1(_3697_),
    .A2(_3698_),
    .B1(net821),
    .Y(_0608_));
 sky130_fd_sc_hd__nand4_1 _8031_ (.A(\count_instr[0] ),
    .B(\count_instr[1] ),
    .C(\count_instr[6] ),
    .D(_3682_),
    .Y(_3699_));
 sky130_fd_sc_hd__xor2_1 _8032_ (.A(\count_instr[7] ),
    .B(_3699_),
    .X(_3700_));
 sky130_fd_sc_hd__nor2_1 _8033_ (.A(net821),
    .B(_3700_),
    .Y(_0609_));
 sky130_fd_sc_hd__xor2_1 _8034_ (.A(\count_instr[6] ),
    .B(_3683_),
    .X(_3701_));
 sky130_fd_sc_hd__nor2_1 _8035_ (.A(net821),
    .B(_3701_),
    .Y(_0610_));
 sky130_fd_sc_hd__nand2_1 _8036_ (.A(\count_instr[3] ),
    .B(\count_instr[4] ),
    .Y(_3702_));
 sky130_fd_sc_hd__inv_1 _8038_ (.A(net779),
    .Y(_3704_));
 sky130_fd_sc_hd__nor2_1 _8039_ (.A(net715),
    .B(net734),
    .Y(_3705_));
 sky130_fd_sc_hd__nand4_1 _8040_ (.A(\count_instr[0] ),
    .B(\count_instr[1] ),
    .C(\count_instr[2] ),
    .D(_3705_),
    .Y(_3706_));
 sky130_fd_sc_hd__o21ai_0 _8041_ (.A1(_3702_),
    .A2(_3706_),
    .B1(\count_instr[5] ),
    .Y(_3707_));
 sky130_fd_sc_hd__or3_1 _8042_ (.A(\count_instr[5] ),
    .B(_3702_),
    .C(_3706_),
    .X(_3708_));
 sky130_fd_sc_hd__a21oi_1 _8043_ (.A1(_3707_),
    .A2(_3708_),
    .B1(net821),
    .Y(_0611_));
 sky130_fd_sc_hd__nand4_1 _8044_ (.A(\count_instr[2] ),
    .B(\count_instr[3] ),
    .C(_0242_),
    .D(_3705_),
    .Y(_3709_));
 sky130_fd_sc_hd__xor2_1 _8045_ (.A(\count_instr[4] ),
    .B(_3709_),
    .X(_3710_));
 sky130_fd_sc_hd__nor2_1 _8046_ (.A(net821),
    .B(_3710_),
    .Y(_0612_));
 sky130_fd_sc_hd__xor2_1 _8047_ (.A(\count_instr[3] ),
    .B(_3706_),
    .X(_3711_));
 sky130_fd_sc_hd__nor2_1 _8048_ (.A(net821),
    .B(_3711_),
    .Y(_0613_));
 sky130_fd_sc_hd__nand2_1 _8049_ (.A(_0242_),
    .B(_3705_),
    .Y(_3712_));
 sky130_fd_sc_hd__xor2_1 _8050_ (.A(\count_instr[2] ),
    .B(_3712_),
    .X(_3713_));
 sky130_fd_sc_hd__nor2_1 _8051_ (.A(net821),
    .B(_3713_),
    .Y(_0614_));
 sky130_fd_sc_hd__nand2_1 _8052_ (.A(_0243_),
    .B(_3705_),
    .Y(_3714_));
 sky130_fd_sc_hd__nand2_1 _8053_ (.A(\count_instr[1] ),
    .B(_3537_),
    .Y(_3715_));
 sky130_fd_sc_hd__a21oi_1 _8054_ (.A1(_3714_),
    .A2(_3715_),
    .B1(net821),
    .Y(_0615_));
 sky130_fd_sc_hd__xor2_1 _8055_ (.A(\count_instr[0] ),
    .B(_3537_),
    .X(_3716_));
 sky130_fd_sc_hd__nor2_1 _8056_ (.A(net821),
    .B(_3716_),
    .Y(_0616_));
 sky130_fd_sc_hd__o21ai_0 _8059_ (.A1(net778),
    .A2(\reg_next_pc[30] ),
    .B1(net825),
    .Y(_3719_));
 sky130_fd_sc_hd__inv_1 _8060_ (.A(net771),
    .Y(_3720_));
 sky130_fd_sc_hd__nor2_1 _8061_ (.A(_3720_),
    .B(net734),
    .Y(_3721_));
 sky130_fd_sc_hd__nand2b_1 _8063_ (.A_N(_0074_),
    .B(_0153_),
    .Y(_3723_));
 sky130_fd_sc_hd__inv_1 _8064_ (.A(_0075_),
    .Y(_3724_));
 sky130_fd_sc_hd__a21o_1 _8065_ (.A1(_0459_),
    .A2(_0483_),
    .B1(_0458_),
    .X(_3725_));
 sky130_fd_sc_hd__a21o_1 _8066_ (.A1(_0156_),
    .A2(_3725_),
    .B1(_0155_),
    .X(_3726_));
 sky130_fd_sc_hd__a21o_1 _8067_ (.A1(_0434_),
    .A2(_3726_),
    .B1(_0433_),
    .X(_3727_));
 sky130_fd_sc_hd__a21o_1 _8068_ (.A1(_0230_),
    .A2(_3727_),
    .B1(_0229_),
    .X(_3728_));
 sky130_fd_sc_hd__a21o_1 _8069_ (.A1(_0203_),
    .A2(_3728_),
    .B1(_0202_),
    .X(_3729_));
 sky130_fd_sc_hd__a21oi_1 _8070_ (.A1(_0472_),
    .A2(_3729_),
    .B1(_0471_),
    .Y(_3730_));
 sky130_fd_sc_hd__a21o_1 _8072_ (.A1(_0105_),
    .A2(_0413_),
    .B1(_0104_),
    .X(_3732_));
 sky130_fd_sc_hd__a21o_1 _8073_ (.A1(_0088_),
    .A2(_3732_),
    .B1(_0087_),
    .X(_3733_));
 sky130_fd_sc_hd__a2111oi_0 _8074_ (.A1(_0417_),
    .A2(_3733_),
    .B1(_0416_),
    .C1(_0236_),
    .D1(_0217_),
    .Y(_3734_));
 sky130_fd_sc_hd__nor3_1 _8076_ (.A(_0237_),
    .B(_0217_),
    .C(_0236_),
    .Y(_3736_));
 sky130_fd_sc_hd__nor2_1 _8077_ (.A(_0218_),
    .B(_0217_),
    .Y(_3737_));
 sky130_fd_sc_hd__nor3_1 _8078_ (.A(_3734_),
    .B(_3736_),
    .C(_3737_),
    .Y(_3738_));
 sky130_fd_sc_hd__nand3_1 _8079_ (.A(_0088_),
    .B(_0105_),
    .C(_0414_),
    .Y(_3739_));
 sky130_fd_sc_hd__nand3_1 _8080_ (.A(_0218_),
    .B(_0237_),
    .C(_0417_),
    .Y(_3740_));
 sky130_fd_sc_hd__or2_2 _8081_ (.A(_3739_),
    .B(_3740_),
    .X(_3741_));
 sky130_fd_sc_hd__inv_1 _8082_ (.A(_0246_),
    .Y(_3742_));
 sky130_fd_sc_hd__a21oi_1 _8083_ (.A1(_0092_),
    .A2(_0077_),
    .B1(_0091_),
    .Y(_3743_));
 sky130_fd_sc_hd__a21o_1 _8084_ (.A1(_0271_),
    .A2(_0149_),
    .B1(_0270_),
    .X(_3744_));
 sky130_fd_sc_hd__a21oi_1 _8085_ (.A1(_0233_),
    .A2(_3744_),
    .B1(_0232_),
    .Y(_3745_));
 sky130_fd_sc_hd__nand3_1 _8086_ (.A(_0246_),
    .B(_0092_),
    .C(_0078_),
    .Y(_3746_));
 sky130_fd_sc_hd__inv_1 _8087_ (.A(_0245_),
    .Y(_3747_));
 sky130_fd_sc_hd__o221ai_1 _8088_ (.A1(_3742_),
    .A2(_3743_),
    .B1(_3745_),
    .B2(_3746_),
    .C1(_3747_),
    .Y(_3748_));
 sky130_fd_sc_hd__nor2b_1 _8089_ (.A(_3741_),
    .B_N(_3748_),
    .Y(_3749_));
 sky130_fd_sc_hd__nand4_1 _8090_ (.A(_0246_),
    .B(_0092_),
    .C(_0078_),
    .D(_0233_),
    .Y(_3750_));
 sky130_fd_sc_hd__inv_1 _8091_ (.A(_3750_),
    .Y(_3751_));
 sky130_fd_sc_hd__a21o_1 _8092_ (.A1(_0072_),
    .A2(_0052_),
    .B1(_0234_),
    .X(_3752_));
 sky130_fd_sc_hd__a211oi_1 _8093_ (.A1(_0227_),
    .A2(_3752_),
    .B1(_0226_),
    .C1(_0239_),
    .Y(_3753_));
 sky130_fd_sc_hd__o21ai_0 _8094_ (.A1(_0240_),
    .A2(_0239_),
    .B1(_0095_),
    .Y(_3754_));
 sky130_fd_sc_hd__nor3_1 _8095_ (.A(_0109_),
    .B(_0461_),
    .C(_0094_),
    .Y(_3755_));
 sky130_fd_sc_hd__o21ai_0 _8096_ (.A1(_3753_),
    .A2(_3754_),
    .B1(_3755_),
    .Y(_3756_));
 sky130_fd_sc_hd__nor3_1 _8097_ (.A(_0462_),
    .B(_0109_),
    .C(_0461_),
    .Y(_3757_));
 sky130_fd_sc_hd__nor2_1 _8098_ (.A(_0110_),
    .B(_0109_),
    .Y(_3758_));
 sky130_fd_sc_hd__nand2_1 _8099_ (.A(_0271_),
    .B(_0150_),
    .Y(_3759_));
 sky130_fd_sc_hd__nor3_1 _8100_ (.A(_3757_),
    .B(_3758_),
    .C(_3759_),
    .Y(_3760_));
 sky130_fd_sc_hd__and4b_1 _8101_ (.A_N(_3741_),
    .B(_3751_),
    .C(_3756_),
    .D(_3760_),
    .X(_3761_));
 sky130_fd_sc_hd__o311a_1 _8102_ (.A1(_3738_),
    .A2(_3749_),
    .A3(_3761_),
    .B1(_0071_),
    .C1(_0223_),
    .X(_3762_));
 sky130_fd_sc_hd__a21oi_1 _8103_ (.A1(_0223_),
    .A2(_0070_),
    .B1(_0222_),
    .Y(_3763_));
 sky130_fd_sc_hd__inv_1 _8104_ (.A(_3763_),
    .Y(_3764_));
 sky130_fd_sc_hd__and3_1 _8105_ (.A(_0156_),
    .B(_0459_),
    .C(_0484_),
    .X(_3765_));
 sky130_fd_sc_hd__o211ai_1 _8106_ (.A1(_3762_),
    .A2(_3764_),
    .B1(_3765_),
    .C1(_0434_),
    .Y(_3766_));
 sky130_fd_sc_hd__nand4_1 _8107_ (.A(_0075_),
    .B(_0472_),
    .C(_0203_),
    .D(_0230_),
    .Y(_3767_));
 sky130_fd_sc_hd__o22ai_1 _8108_ (.A1(_3724_),
    .A2(_3730_),
    .B1(_3766_),
    .B2(_3767_),
    .Y(_3768_));
 sky130_fd_sc_hd__mux2i_1 _8109_ (.A0(_3723_),
    .A1(_0153_),
    .S(_3768_),
    .Y(_3769_));
 sky130_fd_sc_hd__and4_1 _8110_ (.A(_0457_),
    .B(_0154_),
    .C(_0432_),
    .D(_0228_),
    .X(_3770_));
 sky130_fd_sc_hd__nand3_1 _8111_ (.A(_0201_),
    .B(_0470_),
    .C(_3770_),
    .Y(_3771_));
 sky130_fd_sc_hd__nor2_1 _8112_ (.A(_0939_),
    .B(_3771_),
    .Y(_3772_));
 sky130_fd_sc_hd__and3_1 _8113_ (.A(_0216_),
    .B(_0069_),
    .C(_0221_),
    .X(_3773_));
 sky130_fd_sc_hd__nand2_2 _8114_ (.A(net702),
    .B(_3773_),
    .Y(_3774_));
 sky130_fd_sc_hd__and4bb_1 _8115_ (.A_N(net711),
    .B_N(_0899_),
    .C(_0244_),
    .D(_0412_),
    .X(_3775_));
 sky130_fd_sc_hd__nand4_1 _8116_ (.A(_0103_),
    .B(_0086_),
    .C(_0415_),
    .D(_3775_),
    .Y(_3776_));
 sky130_fd_sc_hd__nand2_1 _8117_ (.A(_0080_),
    .B(_0238_),
    .Y(_3777_));
 sky130_fd_sc_hd__nand3_4 _8118_ (.A(_0093_),
    .B(_0460_),
    .C(_0108_),
    .Y(_3778_));
 sky130_fd_sc_hd__nand3_2 _8119_ (.A(_0148_),
    .B(_0269_),
    .C(_0231_),
    .Y(_3779_));
 sky130_fd_sc_hd__nor3_4 _8120_ (.A(_3777_),
    .B(_3778_),
    .C(_3779_),
    .Y(_3780_));
 sky130_fd_sc_hd__nor4b_4 _8121_ (.A(_0913_),
    .B(_3774_),
    .C(_3776_),
    .D_N(_3780_),
    .Y(_3781_));
 sky130_fd_sc_hd__nand2_1 _8122_ (.A(_3772_),
    .B(_3781_),
    .Y(_3782_));
 sky130_fd_sc_hd__nand2_1 _8123_ (.A(_0151_),
    .B(_3782_),
    .Y(_3783_));
 sky130_fd_sc_hd__nand4_1 _8125_ (.A(net773),
    .B(_0942_),
    .C(_3772_),
    .D(_3781_),
    .Y(_3785_));
 sky130_fd_sc_hd__a21oi_1 _8127_ (.A1(_3783_),
    .A2(_3785_),
    .B1(net771),
    .Y(_3787_));
 sky130_fd_sc_hd__nand2_1 _8130_ (.A(net771),
    .B(net773),
    .Y(_3790_));
 sky130_fd_sc_hd__inv_1 _8131_ (.A(_0153_),
    .Y(_3791_));
 sky130_fd_sc_hd__nand2_1 _8132_ (.A(_3791_),
    .B(_0074_),
    .Y(_3792_));
 sky130_fd_sc_hd__o221ai_1 _8133_ (.A1(net773),
    .A2(_0942_),
    .B1(_3790_),
    .B2(_3792_),
    .C1(net778),
    .Y(_3793_));
 sky130_fd_sc_hd__a211oi_1 _8134_ (.A1(_3721_),
    .A2(_3769_),
    .B1(_3787_),
    .C1(_3793_),
    .Y(_3794_));
 sky130_fd_sc_hd__nor2_1 _8135_ (.A(_3719_),
    .B(_3794_),
    .Y(_0617_));
 sky130_fd_sc_hd__nand2_1 _8137_ (.A(net773),
    .B(_0939_),
    .Y(_3796_));
 sky130_fd_sc_hd__nand3_4 _8138_ (.A(_0051_),
    .B(_0079_),
    .C(_0238_),
    .Y(_3797_));
 sky130_fd_sc_hd__or4_4 _8139_ (.A(_0913_),
    .B(_3778_),
    .C(_3779_),
    .D(_3797_),
    .X(_3798_));
 sky130_fd_sc_hd__nor4_1 _8140_ (.A(_3771_),
    .B(_3774_),
    .C(_3776_),
    .D(_3798_),
    .Y(_3799_));
 sky130_fd_sc_hd__mux2i_1 _8141_ (.A0(_0939_),
    .A1(_3796_),
    .S(_3799_),
    .Y(_3800_));
 sky130_fd_sc_hd__a221oi_1 _8143_ (.A1(net734),
    .A2(_0073_),
    .B1(_3800_),
    .B2(_3720_),
    .C1(net715),
    .Y(_3802_));
 sky130_fd_sc_hd__o21ai_0 _8144_ (.A1(net778),
    .A2(\reg_next_pc[29] ),
    .B1(net825),
    .Y(_3803_));
 sky130_fd_sc_hd__nor2_1 _8146_ (.A(_3704_),
    .B(_3521_),
    .Y(_3805_));
 sky130_fd_sc_hd__o211ai_1 _8148_ (.A1(net773),
    .A2(_0073_),
    .B1(net704),
    .C1(net771),
    .Y(_3807_));
 sky130_fd_sc_hd__nand2_1 _8149_ (.A(_0472_),
    .B(_0203_),
    .Y(_3808_));
 sky130_fd_sc_hd__nand2_1 _8150_ (.A(_0223_),
    .B(_3765_),
    .Y(_3809_));
 sky130_fd_sc_hd__inv_1 _8151_ (.A(_0236_),
    .Y(_3810_));
 sky130_fd_sc_hd__o21ai_0 _8152_ (.A1(_0417_),
    .A2(_0416_),
    .B1(_0237_),
    .Y(_3811_));
 sky130_fd_sc_hd__nand2_1 _8153_ (.A(_0071_),
    .B(_0218_),
    .Y(_3812_));
 sky130_fd_sc_hd__a21oi_1 _8154_ (.A1(_3810_),
    .A2(_3811_),
    .B1(_3812_),
    .Y(_3813_));
 sky130_fd_sc_hd__nand2_1 _8155_ (.A(_0271_),
    .B(_0149_),
    .Y(_3814_));
 sky130_fd_sc_hd__o31ai_1 _8156_ (.A1(_3757_),
    .A2(_3758_),
    .A3(_3759_),
    .B1(_3814_),
    .Y(_3815_));
 sky130_fd_sc_hd__a21oi_1 _8157_ (.A1(_0227_),
    .A2(_0053_),
    .B1(_0226_),
    .Y(_3816_));
 sky130_fd_sc_hd__nand2_1 _8158_ (.A(_0095_),
    .B(_0240_),
    .Y(_3817_));
 sky130_fd_sc_hd__nand2_1 _8159_ (.A(_0095_),
    .B(_0239_),
    .Y(_3818_));
 sky130_fd_sc_hd__a2111oi_0 _8160_ (.A1(_0271_),
    .A2(_0149_),
    .B1(_0109_),
    .C1(_0461_),
    .D1(_0094_),
    .Y(_3819_));
 sky130_fd_sc_hd__o211ai_1 _8161_ (.A1(_3816_),
    .A2(_3817_),
    .B1(_3818_),
    .C1(_3819_),
    .Y(_3820_));
 sky130_fd_sc_hd__nor2_1 _8162_ (.A(_3739_),
    .B(_3750_),
    .Y(_3821_));
 sky130_fd_sc_hd__nand3_1 _8163_ (.A(_3815_),
    .B(_3820_),
    .C(_3821_),
    .Y(_3822_));
 sky130_fd_sc_hd__a21o_1 _8164_ (.A1(_0414_),
    .A2(_0245_),
    .B1(_0413_),
    .X(_3823_));
 sky130_fd_sc_hd__a21o_1 _8165_ (.A1(_0105_),
    .A2(_3823_),
    .B1(_0104_),
    .X(_3824_));
 sky130_fd_sc_hd__nand2_1 _8166_ (.A(_0092_),
    .B(_0078_),
    .Y(_3825_));
 sky130_fd_sc_hd__a21oi_1 _8167_ (.A1(_0233_),
    .A2(_0270_),
    .B1(_0232_),
    .Y(_3826_));
 sky130_fd_sc_hd__o21ai_0 _8168_ (.A1(_3825_),
    .A2(_3826_),
    .B1(_3743_),
    .Y(_3827_));
 sky130_fd_sc_hd__nor2_1 _8169_ (.A(_3742_),
    .B(_3739_),
    .Y(_3828_));
 sky130_fd_sc_hd__a221oi_2 _8170_ (.A1(_0088_),
    .A2(_3824_),
    .B1(_3827_),
    .B2(_3828_),
    .C1(_0087_),
    .Y(_3829_));
 sky130_fd_sc_hd__a21oi_1 _8171_ (.A1(_0237_),
    .A2(_0416_),
    .B1(_0236_),
    .Y(_3830_));
 sky130_fd_sc_hd__nand3_1 _8172_ (.A(_3822_),
    .B(_3829_),
    .C(_3830_),
    .Y(_3831_));
 sky130_fd_sc_hd__a221oi_2 _8173_ (.A1(_0071_),
    .A2(_0217_),
    .B1(_3813_),
    .B2(_3831_),
    .C1(_0070_),
    .Y(_3832_));
 sky130_fd_sc_hd__a21o_1 _8174_ (.A1(_0484_),
    .A2(_0222_),
    .B1(_0483_),
    .X(_3833_));
 sky130_fd_sc_hd__a21o_1 _8175_ (.A1(_0459_),
    .A2(_3833_),
    .B1(_0458_),
    .X(_3834_));
 sky130_fd_sc_hd__a21oi_1 _8176_ (.A1(_0156_),
    .A2(_3834_),
    .B1(_0155_),
    .Y(_3835_));
 sky130_fd_sc_hd__nor2_1 _8177_ (.A(_0229_),
    .B(_0433_),
    .Y(_3836_));
 sky130_fd_sc_hd__o211ai_1 _8178_ (.A1(_3809_),
    .A2(_3832_),
    .B1(_3835_),
    .C1(_3836_),
    .Y(_3837_));
 sky130_fd_sc_hd__nor3_1 _8179_ (.A(_0434_),
    .B(_0229_),
    .C(_0433_),
    .Y(_3838_));
 sky130_fd_sc_hd__nor2_1 _8180_ (.A(_0230_),
    .B(_0229_),
    .Y(_3839_));
 sky130_fd_sc_hd__nor2_1 _8181_ (.A(_3838_),
    .B(_3839_),
    .Y(_3840_));
 sky130_fd_sc_hd__nand2_1 _8182_ (.A(_3837_),
    .B(_3840_),
    .Y(_3841_));
 sky130_fd_sc_hd__a21oi_1 _8183_ (.A1(_0472_),
    .A2(_0202_),
    .B1(_0471_),
    .Y(_3842_));
 sky130_fd_sc_hd__o21ai_0 _8184_ (.A1(_3808_),
    .A2(_3841_),
    .B1(_3842_),
    .Y(_3843_));
 sky130_fd_sc_hd__xnor2_1 _8185_ (.A(_0075_),
    .B(_3843_),
    .Y(_3844_));
 sky130_fd_sc_hd__o22ai_1 _8186_ (.A1(_3802_),
    .A2(_3803_),
    .B1(_3807_),
    .B2(_3844_),
    .Y(_0618_));
 sky130_fd_sc_hd__and3_1 _8187_ (.A(_0201_),
    .B(_3770_),
    .C(_3781_),
    .X(_3845_));
 sky130_fd_sc_hd__nand3_1 _8188_ (.A(net773),
    .B(_0470_),
    .C(_3845_),
    .Y(_3846_));
 sky130_fd_sc_hd__o21a_1 _8189_ (.A1(_0470_),
    .A2(_3845_),
    .B1(_3846_),
    .X(_3847_));
 sky130_fd_sc_hd__o221ai_1 _8190_ (.A1(net773),
    .A2(_0470_),
    .B1(_3847_),
    .B2(net771),
    .C1(net704),
    .Y(_3848_));
 sky130_fd_sc_hd__nor3_1 _8192_ (.A(_0202_),
    .B(_0229_),
    .C(_3727_),
    .Y(_3850_));
 sky130_fd_sc_hd__or3_1 _8193_ (.A(_0230_),
    .B(_0202_),
    .C(_0229_),
    .X(_3851_));
 sky130_fd_sc_hd__o21ai_0 _8194_ (.A1(_0203_),
    .A2(_0202_),
    .B1(_3851_),
    .Y(_3852_));
 sky130_fd_sc_hd__a21oi_1 _8195_ (.A1(_3766_),
    .A2(_3850_),
    .B1(_3852_),
    .Y(_3853_));
 sky130_fd_sc_hd__xor2_1 _8196_ (.A(_0472_),
    .B(_3853_),
    .X(_3854_));
 sky130_fd_sc_hd__nor2_1 _8197_ (.A(_3790_),
    .B(_3854_),
    .Y(_3855_));
 sky130_fd_sc_hd__nor2_2 _8198_ (.A(net779),
    .B(net824),
    .Y(_3856_));
 sky130_fd_sc_hd__nand2_1 _8200_ (.A(\reg_next_pc[28] ),
    .B(net714),
    .Y(_3858_));
 sky130_fd_sc_hd__o21ai_1 _8201_ (.A1(_3848_),
    .A2(_3855_),
    .B1(_3858_),
    .Y(_0619_));
 sky130_fd_sc_hd__xnor2_1 _8202_ (.A(_0203_),
    .B(_3841_),
    .Y(_3859_));
 sky130_fd_sc_hd__nor3_4 _8203_ (.A(_3774_),
    .B(_3776_),
    .C(_3798_),
    .Y(_3860_));
 sky130_fd_sc_hd__and4_1 _8204_ (.A(net773),
    .B(_0934_),
    .C(_3770_),
    .D(_3860_),
    .X(_3861_));
 sky130_fd_sc_hd__a21oi_1 _8205_ (.A1(_3770_),
    .A2(_3860_),
    .B1(_0934_),
    .Y(_3862_));
 sky130_fd_sc_hd__nor2_1 _8206_ (.A(_3861_),
    .B(_3862_),
    .Y(_3863_));
 sky130_fd_sc_hd__o221ai_1 _8207_ (.A1(net773),
    .A2(_0934_),
    .B1(_3863_),
    .B2(net771),
    .C1(net778),
    .Y(_3864_));
 sky130_fd_sc_hd__a21oi_1 _8208_ (.A1(_3721_),
    .A2(_3859_),
    .B1(_3864_),
    .Y(_3865_));
 sky130_fd_sc_hd__o21ai_0 _8209_ (.A1(net778),
    .A2(\reg_next_pc[27] ),
    .B1(net825),
    .Y(_3866_));
 sky130_fd_sc_hd__nor2_1 _8210_ (.A(_3865_),
    .B(_3866_),
    .Y(_0620_));
 sky130_fd_sc_hd__and3_1 _8211_ (.A(_0457_),
    .B(_0154_),
    .C(_0432_),
    .X(_3867_));
 sky130_fd_sc_hd__a21oi_1 _8212_ (.A1(_3867_),
    .A2(_3781_),
    .B1(_0228_),
    .Y(_3868_));
 sky130_fd_sc_hd__a31oi_1 _8213_ (.A1(net773),
    .A2(_3770_),
    .A3(_3781_),
    .B1(_3868_),
    .Y(_3869_));
 sky130_fd_sc_hd__o221ai_1 _8214_ (.A1(net773),
    .A2(_0228_),
    .B1(_3869_),
    .B2(net771),
    .C1(net704),
    .Y(_3870_));
 sky130_fd_sc_hd__nand2b_1 _8215_ (.A_N(_3727_),
    .B(_3766_),
    .Y(_3871_));
 sky130_fd_sc_hd__xor2_1 _8216_ (.A(_0230_),
    .B(_3871_),
    .X(_3872_));
 sky130_fd_sc_hd__nor2_1 _8217_ (.A(_3790_),
    .B(_3872_),
    .Y(_3873_));
 sky130_fd_sc_hd__nand2_1 _8218_ (.A(\reg_next_pc[26] ),
    .B(net714),
    .Y(_3874_));
 sky130_fd_sc_hd__o21ai_0 _8219_ (.A1(_3870_),
    .A2(_3873_),
    .B1(_3874_),
    .Y(_0621_));
 sky130_fd_sc_hd__o21ai_0 _8220_ (.A1(_3809_),
    .A2(_3832_),
    .B1(_3835_),
    .Y(_3875_));
 sky130_fd_sc_hd__xor2_1 _8221_ (.A(_0434_),
    .B(_3875_),
    .X(_3876_));
 sky130_fd_sc_hd__nor2_1 _8222_ (.A(_3790_),
    .B(_3876_),
    .Y(_3877_));
 sky130_fd_sc_hd__nor2_1 _8223_ (.A(net701),
    .B(_0927_),
    .Y(_3878_));
 sky130_fd_sc_hd__a21oi_1 _8224_ (.A1(_3878_),
    .A2(_3860_),
    .B1(_0432_),
    .Y(_3879_));
 sky130_fd_sc_hd__a31oi_1 _8225_ (.A1(net773),
    .A2(_3867_),
    .A3(_3860_),
    .B1(_3879_),
    .Y(_3880_));
 sky130_fd_sc_hd__o221ai_1 _8226_ (.A1(net773),
    .A2(_0432_),
    .B1(_3880_),
    .B2(net771),
    .C1(net704),
    .Y(_3881_));
 sky130_fd_sc_hd__nand2_1 _8227_ (.A(\reg_next_pc[25] ),
    .B(net714),
    .Y(_3882_));
 sky130_fd_sc_hd__o21ai_0 _8228_ (.A1(_3877_),
    .A2(_3881_),
    .B1(_3882_),
    .Y(_0622_));
 sky130_fd_sc_hd__a21oi_1 _8229_ (.A1(\reg_next_pc[24] ),
    .A2(net714),
    .B1(_3790_),
    .Y(_3883_));
 sky130_fd_sc_hd__or2_2 _8230_ (.A(_0156_),
    .B(_0458_),
    .X(_3884_));
 sky130_fd_sc_hd__nand2_1 _8231_ (.A(_0156_),
    .B(_0459_),
    .Y(_3885_));
 sky130_fd_sc_hd__o21ai_0 _8232_ (.A1(_3762_),
    .A2(_3764_),
    .B1(_0484_),
    .Y(_3886_));
 sky130_fd_sc_hd__nand2b_1 _8233_ (.A_N(_0483_),
    .B(_3886_),
    .Y(_3887_));
 sky130_fd_sc_hd__mux2i_1 _8234_ (.A0(_3884_),
    .A1(_3885_),
    .S(_3887_),
    .Y(_3888_));
 sky130_fd_sc_hd__nand2_1 _8235_ (.A(_3720_),
    .B(net773),
    .Y(_3889_));
 sky130_fd_sc_hd__a21oi_1 _8236_ (.A1(\reg_next_pc[24] ),
    .A2(net714),
    .B1(_3889_),
    .Y(_3890_));
 sky130_fd_sc_hd__a21oi_1 _8237_ (.A1(net715),
    .A2(\reg_next_pc[24] ),
    .B1(_3705_),
    .Y(_3891_));
 sky130_fd_sc_hd__nor2_1 _8238_ (.A(net701),
    .B(_3891_),
    .Y(_3892_));
 sky130_fd_sc_hd__o21ai_0 _8239_ (.A1(_3890_),
    .A2(_3891_),
    .B1(_0927_),
    .Y(_3893_));
 sky130_fd_sc_hd__a21oi_1 _8240_ (.A1(_3781_),
    .A2(_3892_),
    .B1(_3893_),
    .Y(_3894_));
 sky130_fd_sc_hd__nand2_1 _8241_ (.A(_0156_),
    .B(_0458_),
    .Y(_3895_));
 sky130_fd_sc_hd__o21ai_0 _8242_ (.A1(_0459_),
    .A2(_3884_),
    .B1(_3895_),
    .Y(_3896_));
 sky130_fd_sc_hd__o21ai_0 _8243_ (.A1(net779),
    .A2(\reg_next_pc[24] ),
    .B1(net825),
    .Y(_3897_));
 sky130_fd_sc_hd__a21o_1 _8244_ (.A1(_3883_),
    .A2(_3896_),
    .B1(_3897_),
    .X(_3898_));
 sky130_fd_sc_hd__a311o_1 _8245_ (.A1(_3878_),
    .A2(_3781_),
    .A3(_3890_),
    .B1(_3894_),
    .C1(_3898_),
    .X(_3899_));
 sky130_fd_sc_hd__a21oi_1 _8246_ (.A1(_3883_),
    .A2(_3888_),
    .B1(_3899_),
    .Y(_0623_));
 sky130_fd_sc_hd__a21oi_1 _8247_ (.A1(net773),
    .A2(_3860_),
    .B1(net701),
    .Y(_3900_));
 sky130_fd_sc_hd__a211oi_1 _8248_ (.A1(net701),
    .A2(_3860_),
    .B1(_3900_),
    .C1(net771),
    .Y(_3901_));
 sky130_fd_sc_hd__o21ai_0 _8249_ (.A1(net773),
    .A2(_0457_),
    .B1(net704),
    .Y(_3902_));
 sky130_fd_sc_hd__nand2_1 _8250_ (.A(_0484_),
    .B(_0223_),
    .Y(_3903_));
 sky130_fd_sc_hd__o21bai_1 _8251_ (.A1(_3903_),
    .A2(_3832_),
    .B1_N(_3833_),
    .Y(_3904_));
 sky130_fd_sc_hd__xor2_1 _8252_ (.A(_0459_),
    .B(_3904_),
    .X(_3905_));
 sky130_fd_sc_hd__nor2_1 _8253_ (.A(_3790_),
    .B(_3905_),
    .Y(_3906_));
 sky130_fd_sc_hd__nand2_1 _8254_ (.A(\reg_next_pc[23] ),
    .B(net714),
    .Y(_3907_));
 sky130_fd_sc_hd__o31ai_1 _8255_ (.A1(_3901_),
    .A2(_3902_),
    .A3(_3906_),
    .B1(_3907_),
    .Y(_0624_));
 sky130_fd_sc_hd__and2_4 _8256_ (.A(_0103_),
    .B(_3775_),
    .X(_3908_));
 sky130_fd_sc_hd__and3_1 _8257_ (.A(_0086_),
    .B(_0415_),
    .C(_3908_),
    .X(_3909_));
 sky130_fd_sc_hd__nor4_1 _8259_ (.A(_0913_),
    .B(_3777_),
    .C(_3778_),
    .D(_3779_),
    .Y(_3911_));
 sky130_fd_sc_hd__a31oi_1 _8260_ (.A1(_3773_),
    .A2(_3909_),
    .A3(_3911_),
    .B1(net702),
    .Y(_3912_));
 sky130_fd_sc_hd__a21oi_1 _8261_ (.A1(net773),
    .A2(_3781_),
    .B1(_3912_),
    .Y(_3913_));
 sky130_fd_sc_hd__o221ai_1 _8262_ (.A1(net773),
    .A2(net702),
    .B1(_3913_),
    .B2(net771),
    .C1(net704),
    .Y(_3914_));
 sky130_fd_sc_hd__or3_1 _8263_ (.A(_0484_),
    .B(_3762_),
    .C(_3764_),
    .X(_3915_));
 sky130_fd_sc_hd__a21oi_1 _8264_ (.A1(_3886_),
    .A2(_3915_),
    .B1(_3790_),
    .Y(_3916_));
 sky130_fd_sc_hd__nand2_1 _8265_ (.A(\reg_next_pc[22] ),
    .B(net714),
    .Y(_3917_));
 sky130_fd_sc_hd__o21ai_0 _8266_ (.A1(_3914_),
    .A2(_3916_),
    .B1(_3917_),
    .Y(_0625_));
 sky130_fd_sc_hd__nand2_1 _8267_ (.A(_0148_),
    .B(_0269_),
    .Y(_3918_));
 sky130_fd_sc_hd__nor4_2 _8268_ (.A(_0895_),
    .B(_3778_),
    .C(_3918_),
    .D(_3797_),
    .Y(_3919_));
 sky130_fd_sc_hd__and3_1 _8269_ (.A(_0235_),
    .B(_3909_),
    .C(_3919_),
    .X(_3920_));
 sky130_fd_sc_hd__a31oi_1 _8270_ (.A1(_0216_),
    .A2(_0069_),
    .A3(_3920_),
    .B1(_0221_),
    .Y(_3921_));
 sky130_fd_sc_hd__a31oi_1 _8271_ (.A1(net773),
    .A2(_3773_),
    .A3(_3920_),
    .B1(_3921_),
    .Y(_3922_));
 sky130_fd_sc_hd__o221ai_1 _8272_ (.A1(net773),
    .A2(_0221_),
    .B1(_3922_),
    .B2(net771),
    .C1(net704),
    .Y(_3923_));
 sky130_fd_sc_hd__xnor2_1 _8273_ (.A(_0223_),
    .B(_3832_),
    .Y(_3924_));
 sky130_fd_sc_hd__nor2_1 _8274_ (.A(_3790_),
    .B(_3924_),
    .Y(_3925_));
 sky130_fd_sc_hd__nand2_1 _8275_ (.A(\reg_next_pc[21] ),
    .B(net714),
    .Y(_3926_));
 sky130_fd_sc_hd__o21ai_1 _8276_ (.A1(_3923_),
    .A2(_3925_),
    .B1(_3926_),
    .Y(_0626_));
 sky130_fd_sc_hd__nand2_1 _8278_ (.A(net773),
    .B(_0069_),
    .Y(_3928_));
 sky130_fd_sc_hd__nand3_1 _8279_ (.A(_0216_),
    .B(_3909_),
    .C(_3911_),
    .Y(_3929_));
 sky130_fd_sc_hd__mux2_2 _8280_ (.A0(_3928_),
    .A1(_0069_),
    .S(_3929_),
    .X(_3930_));
 sky130_fd_sc_hd__or3_1 _8281_ (.A(_3738_),
    .B(_3749_),
    .C(_3761_),
    .X(_3931_));
 sky130_fd_sc_hd__xnor2_1 _8282_ (.A(_0071_),
    .B(_3931_),
    .Y(_3932_));
 sky130_fd_sc_hd__nand2_1 _8283_ (.A(_3721_),
    .B(_3932_),
    .Y(_3933_));
 sky130_fd_sc_hd__o221ai_1 _8284_ (.A1(net773),
    .A2(_0069_),
    .B1(_3930_),
    .B2(net771),
    .C1(_3933_),
    .Y(_3934_));
 sky130_fd_sc_hd__o21ai_0 _8285_ (.A1(net778),
    .A2(\reg_next_pc[20] ),
    .B1(net825),
    .Y(_3935_));
 sky130_fd_sc_hd__a21oi_1 _8286_ (.A1(net778),
    .A2(_3934_),
    .B1(_3935_),
    .Y(_0627_));
 sky130_fd_sc_hd__inv_1 _8287_ (.A(_0237_),
    .Y(_3936_));
 sky130_fd_sc_hd__nand2_1 _8288_ (.A(_3822_),
    .B(_3829_),
    .Y(_3937_));
 sky130_fd_sc_hd__a21oi_1 _8289_ (.A1(_0417_),
    .A2(_3937_),
    .B1(_0416_),
    .Y(_3938_));
 sky130_fd_sc_hd__o21ai_0 _8290_ (.A1(_3936_),
    .A2(_3938_),
    .B1(_3810_),
    .Y(_3939_));
 sky130_fd_sc_hd__xor2_1 _8291_ (.A(_0218_),
    .B(_3939_),
    .X(_3940_));
 sky130_fd_sc_hd__nor2_1 _8292_ (.A(net734),
    .B(_0216_),
    .Y(_3941_));
 sky130_fd_sc_hd__mux2i_1 _8293_ (.A0(_0216_),
    .A1(_3941_),
    .S(_3920_),
    .Y(_3942_));
 sky130_fd_sc_hd__a21oi_1 _8294_ (.A1(net734),
    .A2(_0216_),
    .B1(net715),
    .Y(_3943_));
 sky130_fd_sc_hd__o21ai_0 _8295_ (.A1(net771),
    .A2(_3942_),
    .B1(_3943_),
    .Y(_3944_));
 sky130_fd_sc_hd__a21oi_1 _8296_ (.A1(_3721_),
    .A2(_3940_),
    .B1(_3944_),
    .Y(_3945_));
 sky130_fd_sc_hd__o21ai_0 _8297_ (.A1(net778),
    .A2(\reg_next_pc[19] ),
    .B1(net825),
    .Y(_3946_));
 sky130_fd_sc_hd__nor2_1 _8298_ (.A(_3945_),
    .B(_3946_),
    .Y(_0628_));
 sky130_fd_sc_hd__nor2_1 _8299_ (.A(_0417_),
    .B(_0416_),
    .Y(_3947_));
 sky130_fd_sc_hd__a21oi_1 _8300_ (.A1(_0417_),
    .A2(_0087_),
    .B1(_0416_),
    .Y(_3948_));
 sky130_fd_sc_hd__nand2_1 _8301_ (.A(_0237_),
    .B(_3948_),
    .Y(_3949_));
 sky130_fd_sc_hd__o21ai_0 _8302_ (.A1(_0237_),
    .A2(_3947_),
    .B1(_3949_),
    .Y(_3950_));
 sky130_fd_sc_hd__o21ai_0 _8303_ (.A1(_3790_),
    .A2(_3950_),
    .B1(net704),
    .Y(_3951_));
 sky130_fd_sc_hd__nand2_1 _8304_ (.A(_0105_),
    .B(_0414_),
    .Y(_3952_));
 sky130_fd_sc_hd__a31oi_1 _8305_ (.A1(_3751_),
    .A2(_3756_),
    .A3(_3760_),
    .B1(_3748_),
    .Y(_3953_));
 sky130_fd_sc_hd__o21bai_1 _8306_ (.A1(_3952_),
    .A2(_3953_),
    .B1_N(_3732_),
    .Y(_3954_));
 sky130_fd_sc_hd__and2_1 _8307_ (.A(_0088_),
    .B(_3954_),
    .X(_3955_));
 sky130_fd_sc_hd__nor4_1 _8308_ (.A(_0237_),
    .B(_0416_),
    .C(_0087_),
    .D(_3955_),
    .Y(_3956_));
 sky130_fd_sc_hd__a31oi_1 _8309_ (.A1(_0237_),
    .A2(_0417_),
    .A3(_3955_),
    .B1(_3956_),
    .Y(_3957_));
 sky130_fd_sc_hd__and3_1 _8310_ (.A(net773),
    .B(_0913_),
    .C(_3780_),
    .X(_3958_));
 sky130_fd_sc_hd__a21oi_1 _8311_ (.A1(_3909_),
    .A2(_3780_),
    .B1(_0913_),
    .Y(_3959_));
 sky130_fd_sc_hd__a21oi_1 _8312_ (.A1(_3909_),
    .A2(_3958_),
    .B1(_3959_),
    .Y(_3960_));
 sky130_fd_sc_hd__o22ai_1 _8313_ (.A1(net773),
    .A2(_0913_),
    .B1(_3960_),
    .B2(net771),
    .Y(_3961_));
 sky130_fd_sc_hd__a21oi_1 _8314_ (.A1(_3721_),
    .A2(_3957_),
    .B1(_3961_),
    .Y(_3962_));
 sky130_fd_sc_hd__nand2_1 _8315_ (.A(\reg_next_pc[18] ),
    .B(net714),
    .Y(_3963_));
 sky130_fd_sc_hd__o21ai_0 _8316_ (.A1(_3951_),
    .A2(_3962_),
    .B1(_3963_),
    .Y(_0629_));
 sky130_fd_sc_hd__xor2_1 _8317_ (.A(_0417_),
    .B(_3937_),
    .X(_3964_));
 sky130_fd_sc_hd__and2_1 _8318_ (.A(net773),
    .B(_3919_),
    .X(_3965_));
 sky130_fd_sc_hd__a31oi_1 _8319_ (.A1(_0086_),
    .A2(_3908_),
    .A3(_3919_),
    .B1(_0415_),
    .Y(_3966_));
 sky130_fd_sc_hd__a21oi_1 _8320_ (.A1(_3909_),
    .A2(_3965_),
    .B1(_3966_),
    .Y(_3967_));
 sky130_fd_sc_hd__a31oi_1 _8321_ (.A1(net734),
    .A2(_0909_),
    .A3(_0910_),
    .B1(net715),
    .Y(_3968_));
 sky130_fd_sc_hd__o221ai_1 _8322_ (.A1(_3790_),
    .A2(_3964_),
    .B1(_3967_),
    .B2(net771),
    .C1(_3968_),
    .Y(_3969_));
 sky130_fd_sc_hd__nand2_1 _8324_ (.A(net715),
    .B(\reg_next_pc[17] ),
    .Y(_3971_));
 sky130_fd_sc_hd__a21oi_1 _8325_ (.A1(_3969_),
    .A2(_3971_),
    .B1(net823),
    .Y(_0630_));
 sky130_fd_sc_hd__a21oi_1 _8326_ (.A1(_3908_),
    .A2(_3780_),
    .B1(_0086_),
    .Y(_3972_));
 sky130_fd_sc_hd__and4_1 _8327_ (.A(net773),
    .B(_0086_),
    .C(_3908_),
    .D(_3780_),
    .X(_3973_));
 sky130_fd_sc_hd__nor2_1 _8328_ (.A(_3972_),
    .B(_3973_),
    .Y(_3974_));
 sky130_fd_sc_hd__o221ai_1 _8329_ (.A1(net773),
    .A2(_0086_),
    .B1(_3974_),
    .B2(net771),
    .C1(net704),
    .Y(_3975_));
 sky130_fd_sc_hd__nor2_1 _8330_ (.A(_0088_),
    .B(_3954_),
    .Y(_3976_));
 sky130_fd_sc_hd__o21a_1 _8331_ (.A1(_3955_),
    .A2(_3976_),
    .B1(_3721_),
    .X(_3977_));
 sky130_fd_sc_hd__nand2_1 _8332_ (.A(\reg_next_pc[16] ),
    .B(net714),
    .Y(_3978_));
 sky130_fd_sc_hd__o21ai_0 _8333_ (.A1(_3975_),
    .A2(_3977_),
    .B1(_3978_),
    .Y(_0631_));
 sky130_fd_sc_hd__a21oi_1 _8334_ (.A1(_3775_),
    .A2(_3919_),
    .B1(_0103_),
    .Y(_3979_));
 sky130_fd_sc_hd__a21oi_1 _8335_ (.A1(_3908_),
    .A2(_3965_),
    .B1(_3979_),
    .Y(_3980_));
 sky130_fd_sc_hd__o221ai_1 _8336_ (.A1(net773),
    .A2(_0103_),
    .B1(_3980_),
    .B2(net771),
    .C1(net704),
    .Y(_3981_));
 sky130_fd_sc_hd__nand2_1 _8337_ (.A(_3815_),
    .B(_3820_),
    .Y(_3982_));
 sky130_fd_sc_hd__a21oi_1 _8338_ (.A1(_0246_),
    .A2(_3827_),
    .B1(_0245_),
    .Y(_3983_));
 sky130_fd_sc_hd__o21ai_0 _8339_ (.A1(_3750_),
    .A2(_3982_),
    .B1(_3983_),
    .Y(_3984_));
 sky130_fd_sc_hd__a21oi_1 _8340_ (.A1(_0414_),
    .A2(_3984_),
    .B1(_0413_),
    .Y(_3985_));
 sky130_fd_sc_hd__xnor2_1 _8341_ (.A(_0105_),
    .B(_3985_),
    .Y(_3986_));
 sky130_fd_sc_hd__nor2_1 _8342_ (.A(_3790_),
    .B(_3986_),
    .Y(_3987_));
 sky130_fd_sc_hd__nand2_1 _8343_ (.A(\reg_next_pc[15] ),
    .B(net714),
    .Y(_3988_));
 sky130_fd_sc_hd__o21ai_0 _8344_ (.A1(_3981_),
    .A2(_3987_),
    .B1(_3988_),
    .Y(_0632_));
 sky130_fd_sc_hd__xor2_1 _8346_ (.A(_0414_),
    .B(_3953_),
    .X(_3990_));
 sky130_fd_sc_hd__nor2_1 _8347_ (.A(net711),
    .B(_0899_),
    .Y(_3991_));
 sky130_fd_sc_hd__a31oi_1 _8348_ (.A1(_0244_),
    .A2(_3991_),
    .A3(_3780_),
    .B1(_0412_),
    .Y(_3992_));
 sky130_fd_sc_hd__a31oi_1 _8349_ (.A1(net773),
    .A2(_3775_),
    .A3(_3780_),
    .B1(_3992_),
    .Y(_3993_));
 sky130_fd_sc_hd__o22ai_1 _8350_ (.A1(net773),
    .A2(_0412_),
    .B1(_3993_),
    .B2(net771),
    .Y(_3994_));
 sky130_fd_sc_hd__a21oi_1 _8351_ (.A1(net705),
    .A2(_3990_),
    .B1(_3994_),
    .Y(_3995_));
 sky130_fd_sc_hd__mux2i_1 _8352_ (.A0(\reg_next_pc[14] ),
    .A1(_3995_),
    .S(net778),
    .Y(_3996_));
 sky130_fd_sc_hd__nor2_1 _8353_ (.A(net823),
    .B(_3996_),
    .Y(_0633_));
 sky130_fd_sc_hd__a21oi_1 _8354_ (.A1(_3991_),
    .A2(_3919_),
    .B1(_0244_),
    .Y(_3997_));
 sky130_fd_sc_hd__a31oi_1 _8355_ (.A1(_0244_),
    .A2(_3991_),
    .A3(_3965_),
    .B1(_3997_),
    .Y(_3998_));
 sky130_fd_sc_hd__o221ai_1 _8356_ (.A1(net773),
    .A2(_0244_),
    .B1(_3998_),
    .B2(net771),
    .C1(net704),
    .Y(_3999_));
 sky130_fd_sc_hd__nand2b_1 _8357_ (.A_N(_0270_),
    .B(_3982_),
    .Y(_4000_));
 sky130_fd_sc_hd__a21oi_1 _8358_ (.A1(_0233_),
    .A2(_4000_),
    .B1(_0232_),
    .Y(_4001_));
 sky130_fd_sc_hd__o21ai_0 _8359_ (.A1(_3825_),
    .A2(_4001_),
    .B1(_3743_),
    .Y(_4002_));
 sky130_fd_sc_hd__xnor2_1 _8360_ (.A(_3742_),
    .B(_4002_),
    .Y(_4003_));
 sky130_fd_sc_hd__nor2_1 _8361_ (.A(_3790_),
    .B(_4003_),
    .Y(_4004_));
 sky130_fd_sc_hd__nand2_1 _8362_ (.A(\reg_next_pc[13] ),
    .B(net714),
    .Y(_4005_));
 sky130_fd_sc_hd__o21ai_0 _8363_ (.A1(_3999_),
    .A2(_4004_),
    .B1(_4005_),
    .Y(_0634_));
 sky130_fd_sc_hd__nand2_1 _8364_ (.A(net773),
    .B(_0899_),
    .Y(_4006_));
 sky130_fd_sc_hd__nand2_1 _8365_ (.A(_0076_),
    .B(_3780_),
    .Y(_4007_));
 sky130_fd_sc_hd__mux2i_1 _8366_ (.A0(_4006_),
    .A1(_0899_),
    .S(_4007_),
    .Y(_4008_));
 sky130_fd_sc_hd__nand3_1 _8367_ (.A(_0233_),
    .B(_3756_),
    .C(_3760_),
    .Y(_4009_));
 sky130_fd_sc_hd__nand2_1 _8368_ (.A(_3745_),
    .B(_4009_),
    .Y(_4010_));
 sky130_fd_sc_hd__a21oi_1 _8369_ (.A1(_0078_),
    .A2(_4010_),
    .B1(_0077_),
    .Y(_4011_));
 sky130_fd_sc_hd__xnor2_1 _8370_ (.A(_0092_),
    .B(_4011_),
    .Y(_4012_));
 sky130_fd_sc_hd__o21ai_0 _8371_ (.A1(net773),
    .A2(_0899_),
    .B1(net778),
    .Y(_4013_));
 sky130_fd_sc_hd__a221oi_1 _8372_ (.A1(_3720_),
    .A2(_4008_),
    .B1(_4012_),
    .B2(net705),
    .C1(_4013_),
    .Y(_4014_));
 sky130_fd_sc_hd__o21ai_0 _8373_ (.A1(net778),
    .A2(\reg_next_pc[12] ),
    .B1(net825),
    .Y(_4015_));
 sky130_fd_sc_hd__nor2_1 _8374_ (.A(_4014_),
    .B(_4015_),
    .Y(_0635_));
 sky130_fd_sc_hd__xnor2_1 _8375_ (.A(_0078_),
    .B(_4001_),
    .Y(_4016_));
 sky130_fd_sc_hd__nor2_1 _8376_ (.A(net711),
    .B(_3919_),
    .Y(_4017_));
 sky130_fd_sc_hd__a21oi_1 _8377_ (.A1(net711),
    .A2(_3965_),
    .B1(_4017_),
    .Y(_4018_));
 sky130_fd_sc_hd__o22ai_1 _8378_ (.A1(net773),
    .A2(net711),
    .B1(_4018_),
    .B2(net771),
    .Y(_4019_));
 sky130_fd_sc_hd__a21oi_1 _8379_ (.A1(net705),
    .A2(_4016_),
    .B1(_4019_),
    .Y(_4020_));
 sky130_fd_sc_hd__o21ai_0 _8380_ (.A1(net778),
    .A2(\reg_next_pc[11] ),
    .B1(net825),
    .Y(_4021_));
 sky130_fd_sc_hd__a21oi_1 _8381_ (.A1(net778),
    .A2(_4020_),
    .B1(_4021_),
    .Y(_0636_));
 sky130_fd_sc_hd__nor2_1 _8382_ (.A(net778),
    .B(\reg_next_pc[10] ),
    .Y(_4022_));
 sky130_fd_sc_hd__a21oi_1 _8383_ (.A1(_3756_),
    .A2(_3760_),
    .B1(_3744_),
    .Y(_4023_));
 sky130_fd_sc_hd__xnor2_1 _8384_ (.A(_0233_),
    .B(_4023_),
    .Y(_4024_));
 sky130_fd_sc_hd__nor2_1 _8385_ (.A(net734),
    .B(_0231_),
    .Y(_4025_));
 sky130_fd_sc_hd__nor3_1 _8386_ (.A(_3777_),
    .B(_3778_),
    .C(_3918_),
    .Y(_4026_));
 sky130_fd_sc_hd__mux2i_1 _8387_ (.A0(_0231_),
    .A1(_4025_),
    .S(_4026_),
    .Y(_4027_));
 sky130_fd_sc_hd__o22ai_1 _8388_ (.A1(net773),
    .A2(_0895_),
    .B1(_4027_),
    .B2(net771),
    .Y(_4028_));
 sky130_fd_sc_hd__a211oi_1 _8390_ (.A1(net705),
    .A2(_4024_),
    .B1(_4028_),
    .C1(net715),
    .Y(_4030_));
 sky130_fd_sc_hd__nor3_1 _8391_ (.A(net823),
    .B(_4022_),
    .C(_4030_),
    .Y(_0637_));
 sky130_fd_sc_hd__nor3_1 _8392_ (.A(_0891_),
    .B(_3778_),
    .C(_3797_),
    .Y(_4031_));
 sky130_fd_sc_hd__nand3_1 _8393_ (.A(net773),
    .B(_0269_),
    .C(_4031_),
    .Y(_4032_));
 sky130_fd_sc_hd__o21ai_0 _8394_ (.A1(_0269_),
    .A2(_4031_),
    .B1(_4032_),
    .Y(_4033_));
 sky130_fd_sc_hd__nor2_1 _8395_ (.A(_3757_),
    .B(_3758_),
    .Y(_4034_));
 sky130_fd_sc_hd__o21ai_0 _8396_ (.A1(_3816_),
    .A2(_3817_),
    .B1(_3818_),
    .Y(_4035_));
 sky130_fd_sc_hd__nand2b_1 _8397_ (.A_N(_4035_),
    .B(_3755_),
    .Y(_4036_));
 sky130_fd_sc_hd__a311oi_1 _8398_ (.A1(_0150_),
    .A2(_4034_),
    .A3(_4036_),
    .B1(_0149_),
    .C1(_0271_),
    .Y(_4037_));
 sky130_fd_sc_hd__a21oi_1 _8399_ (.A1(_3815_),
    .A2(_3820_),
    .B1(_4037_),
    .Y(_4038_));
 sky130_fd_sc_hd__o22ai_1 _8400_ (.A1(net773),
    .A2(_0269_),
    .B1(_3790_),
    .B2(_4038_),
    .Y(_4039_));
 sky130_fd_sc_hd__a21oi_1 _8401_ (.A1(_3720_),
    .A2(_4033_),
    .B1(_4039_),
    .Y(_4040_));
 sky130_fd_sc_hd__mux2i_1 _8403_ (.A0(\reg_next_pc[9] ),
    .A1(_4040_),
    .S(net778),
    .Y(_4042_));
 sky130_fd_sc_hd__nor2_1 _8404_ (.A(net823),
    .B(_4042_),
    .Y(_0638_));
 sky130_fd_sc_hd__nand2_1 _8405_ (.A(_3756_),
    .B(_4034_),
    .Y(_4043_));
 sky130_fd_sc_hd__xor2_1 _8406_ (.A(_0150_),
    .B(_4043_),
    .X(_4044_));
 sky130_fd_sc_hd__nor2_1 _8407_ (.A(_3790_),
    .B(_4044_),
    .Y(_4045_));
 sky130_fd_sc_hd__or4_1 _8408_ (.A(net734),
    .B(_0148_),
    .C(_3777_),
    .D(_3778_),
    .X(_4046_));
 sky130_fd_sc_hd__o21ai_0 _8409_ (.A1(_3777_),
    .A2(_3778_),
    .B1(_0148_),
    .Y(_4047_));
 sky130_fd_sc_hd__a21oi_1 _8410_ (.A1(_4046_),
    .A2(_4047_),
    .B1(net771),
    .Y(_4048_));
 sky130_fd_sc_hd__a2111oi_0 _8411_ (.A1(net734),
    .A2(_0148_),
    .B1(_4045_),
    .C1(_4048_),
    .D1(net715),
    .Y(_4049_));
 sky130_fd_sc_hd__o21ai_0 _8412_ (.A1(net778),
    .A2(\reg_next_pc[8] ),
    .B1(net825),
    .Y(_4050_));
 sky130_fd_sc_hd__nor2_1 _8413_ (.A(_4049_),
    .B(_4050_),
    .Y(_0639_));
 sky130_fd_sc_hd__o21ai_0 _8414_ (.A1(_0094_),
    .A2(_4035_),
    .B1(_0462_),
    .Y(_4051_));
 sky130_fd_sc_hd__nand2b_1 _8415_ (.A_N(_0461_),
    .B(_4051_),
    .Y(_4052_));
 sky130_fd_sc_hd__xnor2_1 _8416_ (.A(_0110_),
    .B(_4052_),
    .Y(_4053_));
 sky130_fd_sc_hd__nor2_1 _8417_ (.A(_3778_),
    .B(_3797_),
    .Y(_4054_));
 sky130_fd_sc_hd__inv_1 _8418_ (.A(_3797_),
    .Y(_4055_));
 sky130_fd_sc_hd__a31oi_1 _8419_ (.A1(_0093_),
    .A2(_0460_),
    .A3(_4055_),
    .B1(_0108_),
    .Y(_4056_));
 sky130_fd_sc_hd__a21oi_1 _8420_ (.A1(net773),
    .A2(_4054_),
    .B1(_4056_),
    .Y(_4057_));
 sky130_fd_sc_hd__o22ai_1 _8421_ (.A1(net773),
    .A2(_0108_),
    .B1(_4057_),
    .B2(net771),
    .Y(_4058_));
 sky130_fd_sc_hd__a21oi_1 _8422_ (.A1(net705),
    .A2(_4053_),
    .B1(_4058_),
    .Y(_4059_));
 sky130_fd_sc_hd__mux2i_1 _8423_ (.A0(\reg_next_pc[7] ),
    .A1(_4059_),
    .S(net778),
    .Y(_4060_));
 sky130_fd_sc_hd__nor2_1 _8424_ (.A(net823),
    .B(_4060_),
    .Y(_0640_));
 sky130_fd_sc_hd__o21bai_1 _8425_ (.A1(_3753_),
    .A2(_3754_),
    .B1_N(_0094_),
    .Y(_4061_));
 sky130_fd_sc_hd__xnor2_1 _8426_ (.A(_0462_),
    .B(_4061_),
    .Y(_4062_));
 sky130_fd_sc_hd__nor2_1 _8427_ (.A(_0886_),
    .B(_3777_),
    .Y(_4063_));
 sky130_fd_sc_hd__nand3_1 _8428_ (.A(net773),
    .B(_0460_),
    .C(_4063_),
    .Y(_4064_));
 sky130_fd_sc_hd__o21ai_0 _8429_ (.A1(_0460_),
    .A2(_4063_),
    .B1(_4064_),
    .Y(_4065_));
 sky130_fd_sc_hd__nor2_1 _8430_ (.A(net773),
    .B(_0460_),
    .Y(_4066_));
 sky130_fd_sc_hd__a221oi_1 _8431_ (.A1(net705),
    .A2(_4062_),
    .B1(_4065_),
    .B2(_3720_),
    .C1(_4066_),
    .Y(_4067_));
 sky130_fd_sc_hd__mux2i_1 _8432_ (.A0(\reg_next_pc[6] ),
    .A1(_4067_),
    .S(net778),
    .Y(_4068_));
 sky130_fd_sc_hd__nor2_1 _8433_ (.A(net823),
    .B(_4068_),
    .Y(_0641_));
 sky130_fd_sc_hd__nor2b_1 _8435_ (.A(_3816_),
    .B_N(_0240_),
    .Y(_4070_));
 sky130_fd_sc_hd__nor3_1 _8436_ (.A(_0095_),
    .B(_0239_),
    .C(_4070_),
    .Y(_4071_));
 sky130_fd_sc_hd__a21oi_1 _8437_ (.A1(net734),
    .A2(_0093_),
    .B1(net715),
    .Y(_4072_));
 sky130_fd_sc_hd__o31ai_1 _8438_ (.A1(_3790_),
    .A2(_4035_),
    .A3(_4071_),
    .B1(_4072_),
    .Y(_4073_));
 sky130_fd_sc_hd__nor3_1 _8439_ (.A(net734),
    .B(_0093_),
    .C(_3797_),
    .Y(_4074_));
 sky130_fd_sc_hd__a21oi_1 _8440_ (.A1(_0093_),
    .A2(_3797_),
    .B1(_4074_),
    .Y(_4075_));
 sky130_fd_sc_hd__nor2_1 _8441_ (.A(net771),
    .B(_4075_),
    .Y(_4076_));
 sky130_fd_sc_hd__o221a_2 _8442_ (.A1(net778),
    .A2(\reg_next_pc[5] ),
    .B1(_4073_),
    .B2(_4076_),
    .C1(net825),
    .X(_0642_));
 sky130_fd_sc_hd__nand3_1 _8443_ (.A(_0080_),
    .B(net773),
    .C(_0238_),
    .Y(_4077_));
 sky130_fd_sc_hd__o21ai_0 _8444_ (.A1(_0080_),
    .A2(_0238_),
    .B1(_4077_),
    .Y(_4078_));
 sky130_fd_sc_hd__a21oi_1 _8445_ (.A1(_0227_),
    .A2(_3752_),
    .B1(_0226_),
    .Y(_4079_));
 sky130_fd_sc_hd__xnor2_1 _8446_ (.A(_0240_),
    .B(_4079_),
    .Y(_4080_));
 sky130_fd_sc_hd__o22ai_1 _8447_ (.A1(net773),
    .A2(_0238_),
    .B1(_3790_),
    .B2(_4080_),
    .Y(_4081_));
 sky130_fd_sc_hd__a211oi_1 _8448_ (.A1(_3720_),
    .A2(_4078_),
    .B1(_4081_),
    .C1(net715),
    .Y(_4082_));
 sky130_fd_sc_hd__a21oi_1 _8449_ (.A1(net715),
    .A2(\reg_next_pc[4] ),
    .B1(_4082_),
    .Y(_4083_));
 sky130_fd_sc_hd__nor2_1 _8450_ (.A(net823),
    .B(_4083_),
    .Y(_0643_));
 sky130_fd_sc_hd__nand2_1 _8451_ (.A(net734),
    .B(_0079_),
    .Y(_4084_));
 sky130_fd_sc_hd__xnor2_1 _8452_ (.A(_0227_),
    .B(_0053_),
    .Y(_4085_));
 sky130_fd_sc_hd__nand2_1 _8453_ (.A(net772),
    .B(_4085_),
    .Y(_4086_));
 sky130_fd_sc_hd__o211ai_1 _8454_ (.A1(net772),
    .A2(_0081_),
    .B1(_4086_),
    .C1(net773),
    .Y(_4087_));
 sky130_fd_sc_hd__nor2_1 _8455_ (.A(net778),
    .B(\reg_next_pc[3] ),
    .Y(_4088_));
 sky130_fd_sc_hd__a311oi_1 _8456_ (.A1(net778),
    .A2(_4084_),
    .A3(_4087_),
    .B1(_4088_),
    .C1(net823),
    .Y(_0644_));
 sky130_fd_sc_hd__nor2_1 _8457_ (.A(_0051_),
    .B(_3889_),
    .Y(_4089_));
 sky130_fd_sc_hd__a221o_1 _8458_ (.A1(net734),
    .A2(_0051_),
    .B1(net705),
    .B2(_0054_),
    .C1(_4089_),
    .X(_4090_));
 sky130_fd_sc_hd__mux2i_1 _8459_ (.A0(\reg_next_pc[2] ),
    .A1(_4090_),
    .S(net778),
    .Y(_4091_));
 sky130_fd_sc_hd__nor2_1 _8460_ (.A(net823),
    .B(_4091_),
    .Y(_0645_));
 sky130_fd_sc_hd__nand2_1 _8461_ (.A(net778),
    .B(net825),
    .Y(_4092_));
 sky130_fd_sc_hd__mux2i_1 _8462_ (.A0(_0085_),
    .A1(_0084_),
    .S(_3790_),
    .Y(_4093_));
 sky130_fd_sc_hd__nand2_1 _8464_ (.A(\reg_next_pc[1] ),
    .B(net714),
    .Y(_4095_));
 sky130_fd_sc_hd__o21ai_0 _8465_ (.A1(_4092_),
    .A2(_4093_),
    .B1(_4095_),
    .Y(_0646_));
 sky130_fd_sc_hd__and3_1 _8466_ (.A(\count_cycle[60] ),
    .B(\count_cycle[61] ),
    .C(\count_cycle[59] ),
    .X(_4096_));
 sky130_fd_sc_hd__nand2_1 _8467_ (.A(_0480_),
    .B(\count_cycle[2] ),
    .Y(_4097_));
 sky130_fd_sc_hd__nand4_1 _8468_ (.A(\count_cycle[3] ),
    .B(\count_cycle[6] ),
    .C(\count_cycle[5] ),
    .D(\count_cycle[4] ),
    .Y(_4098_));
 sky130_fd_sc_hd__nand2_1 _8469_ (.A(\count_cycle[8] ),
    .B(\count_cycle[7] ),
    .Y(_4099_));
 sky130_fd_sc_hd__nor3_2 _8470_ (.A(_4097_),
    .B(_4098_),
    .C(_4099_),
    .Y(_4100_));
 sky130_fd_sc_hd__and3_1 _8471_ (.A(\count_cycle[10] ),
    .B(\count_cycle[12] ),
    .C(\count_cycle[11] ),
    .X(_4101_));
 sky130_fd_sc_hd__and4_1 _8472_ (.A(\count_cycle[14] ),
    .B(\count_cycle[13] ),
    .C(\count_cycle[9] ),
    .D(_4101_),
    .X(_4102_));
 sky130_fd_sc_hd__nand3_1 _8473_ (.A(\count_cycle[15] ),
    .B(_4100_),
    .C(_4102_),
    .Y(_4103_));
 sky130_fd_sc_hd__and4_1 _8474_ (.A(\count_cycle[31] ),
    .B(\count_cycle[30] ),
    .C(\count_cycle[29] ),
    .D(\count_cycle[28] ),
    .X(_4104_));
 sky130_fd_sc_hd__and4_1 _8475_ (.A(\count_cycle[34] ),
    .B(\count_cycle[33] ),
    .C(\count_cycle[32] ),
    .D(_4104_),
    .X(_4105_));
 sky130_fd_sc_hd__nand3_1 _8476_ (.A(\count_cycle[36] ),
    .B(\count_cycle[35] ),
    .C(_4105_),
    .Y(_4106_));
 sky130_fd_sc_hd__and4_1 _8477_ (.A(\count_cycle[19] ),
    .B(\count_cycle[18] ),
    .C(\count_cycle[17] ),
    .D(\count_cycle[16] ),
    .X(_4107_));
 sky130_fd_sc_hd__and3_1 _8478_ (.A(\count_cycle[20] ),
    .B(\count_cycle[21] ),
    .C(_4107_),
    .X(_4108_));
 sky130_fd_sc_hd__nand3_1 _8479_ (.A(\count_cycle[23] ),
    .B(\count_cycle[22] ),
    .C(_4108_),
    .Y(_4109_));
 sky130_fd_sc_hd__and4_1 _8480_ (.A(\count_cycle[27] ),
    .B(\count_cycle[26] ),
    .C(\count_cycle[25] ),
    .D(\count_cycle[24] ),
    .X(_4110_));
 sky130_fd_sc_hd__nand2_1 _8482_ (.A(\count_cycle[37] ),
    .B(_4110_),
    .Y(_4112_));
 sky130_fd_sc_hd__nor4_4 _8483_ (.A(_4103_),
    .B(_4106_),
    .C(_4109_),
    .D(_4112_),
    .Y(_4113_));
 sky130_fd_sc_hd__inv_1 _8484_ (.A(\count_cycle[45] ),
    .Y(_4114_));
 sky130_fd_sc_hd__and4_1 _8485_ (.A(\count_cycle[41] ),
    .B(\count_cycle[40] ),
    .C(\count_cycle[39] ),
    .D(\count_cycle[38] ),
    .X(_4115_));
 sky130_fd_sc_hd__nand4_1 _8486_ (.A(\count_cycle[44] ),
    .B(\count_cycle[42] ),
    .C(\count_cycle[43] ),
    .D(_4115_),
    .Y(_4116_));
 sky130_fd_sc_hd__nor2_1 _8487_ (.A(_4114_),
    .B(_4116_),
    .Y(_4117_));
 sky130_fd_sc_hd__and4_1 _8488_ (.A(\count_cycle[48] ),
    .B(\count_cycle[47] ),
    .C(\count_cycle[46] ),
    .D(_4117_),
    .X(_4118_));
 sky130_fd_sc_hd__and3_1 _8489_ (.A(\count_cycle[51] ),
    .B(\count_cycle[49] ),
    .C(\count_cycle[50] ),
    .X(_4119_));
 sky130_fd_sc_hd__and3_1 _8490_ (.A(\count_cycle[52] ),
    .B(\count_cycle[53] ),
    .C(_4119_),
    .X(_4120_));
 sky130_fd_sc_hd__nand3_1 _8491_ (.A(_4113_),
    .B(_4118_),
    .C(_4120_),
    .Y(_4121_));
 sky130_fd_sc_hd__and3_1 _8492_ (.A(\count_cycle[54] ),
    .B(\count_cycle[56] ),
    .C(\count_cycle[55] ),
    .X(_4122_));
 sky130_fd_sc_hd__nand3_1 _8493_ (.A(\count_cycle[57] ),
    .B(\count_cycle[58] ),
    .C(_4122_),
    .Y(_4123_));
 sky130_fd_sc_hd__nor2_1 _8494_ (.A(_4121_),
    .B(_4123_),
    .Y(_4124_));
 sky130_fd_sc_hd__nand2_1 _8495_ (.A(_4096_),
    .B(_4124_),
    .Y(_4125_));
 sky130_fd_sc_hd__xor2_1 _8496_ (.A(\count_cycle[62] ),
    .B(_4125_),
    .X(_4126_));
 sky130_fd_sc_hd__nor2_1 _8497_ (.A(net824),
    .B(_4126_),
    .Y(_0647_));
 sky130_fd_sc_hd__nand3_1 _8498_ (.A(\count_cycle[0] ),
    .B(\count_cycle[2] ),
    .C(\count_cycle[1] ),
    .Y(_4127_));
 sky130_fd_sc_hd__nor3_2 _8499_ (.A(_4098_),
    .B(_4099_),
    .C(_4127_),
    .Y(_4128_));
 sky130_fd_sc_hd__nand3_1 _8500_ (.A(\count_cycle[15] ),
    .B(_4102_),
    .C(_4128_),
    .Y(_4129_));
 sky130_fd_sc_hd__nor4_2 _8501_ (.A(_4106_),
    .B(_4109_),
    .C(_4112_),
    .D(_4129_),
    .Y(_4130_));
 sky130_fd_sc_hd__and2_1 _8502_ (.A(_4118_),
    .B(_4130_),
    .X(_4131_));
 sky130_fd_sc_hd__nand2_1 _8504_ (.A(_4120_),
    .B(_4131_),
    .Y(_4133_));
 sky130_fd_sc_hd__nor2_1 _8505_ (.A(_4123_),
    .B(_4133_),
    .Y(_4134_));
 sky130_fd_sc_hd__nand3_1 _8506_ (.A(\count_cycle[60] ),
    .B(\count_cycle[59] ),
    .C(_4134_),
    .Y(_4135_));
 sky130_fd_sc_hd__xor2_1 _8507_ (.A(\count_cycle[61] ),
    .B(_4135_),
    .X(_4136_));
 sky130_fd_sc_hd__nor2_1 _8508_ (.A(net824),
    .B(_4136_),
    .Y(_0648_));
 sky130_fd_sc_hd__nand2_1 _8509_ (.A(\count_cycle[59] ),
    .B(_4124_),
    .Y(_4137_));
 sky130_fd_sc_hd__xor2_1 _8510_ (.A(\count_cycle[60] ),
    .B(_4137_),
    .X(_4138_));
 sky130_fd_sc_hd__nor2_1 _8511_ (.A(net824),
    .B(_4138_),
    .Y(_0649_));
 sky130_fd_sc_hd__xnor2_1 _8512_ (.A(\count_cycle[59] ),
    .B(_4134_),
    .Y(_4139_));
 sky130_fd_sc_hd__nor2_1 _8513_ (.A(net824),
    .B(_4139_),
    .Y(_0650_));
 sky130_fd_sc_hd__nand2_1 _8514_ (.A(\count_cycle[57] ),
    .B(_4122_),
    .Y(_4140_));
 sky130_fd_sc_hd__o21ai_0 _8515_ (.A1(_4121_),
    .A2(_4140_),
    .B1(\count_cycle[58] ),
    .Y(_4141_));
 sky130_fd_sc_hd__or3_1 _8516_ (.A(\count_cycle[58] ),
    .B(_4121_),
    .C(_4140_),
    .X(_4142_));
 sky130_fd_sc_hd__a21oi_1 _8517_ (.A1(_4141_),
    .A2(_4142_),
    .B1(net824),
    .Y(_0651_));
 sky130_fd_sc_hd__nand3_1 _8519_ (.A(_4120_),
    .B(_4122_),
    .C(_4131_),
    .Y(_4144_));
 sky130_fd_sc_hd__xor2_1 _8520_ (.A(\count_cycle[57] ),
    .B(_4144_),
    .X(_4145_));
 sky130_fd_sc_hd__nor2_1 _8521_ (.A(net824),
    .B(_4145_),
    .Y(_0652_));
 sky130_fd_sc_hd__nand2_1 _8522_ (.A(\count_cycle[54] ),
    .B(\count_cycle[55] ),
    .Y(_4146_));
 sky130_fd_sc_hd__o21ai_0 _8523_ (.A1(_4121_),
    .A2(_4146_),
    .B1(\count_cycle[56] ),
    .Y(_4147_));
 sky130_fd_sc_hd__or3_1 _8524_ (.A(\count_cycle[56] ),
    .B(_4121_),
    .C(_4146_),
    .X(_4148_));
 sky130_fd_sc_hd__a21oi_1 _8525_ (.A1(_4147_),
    .A2(_4148_),
    .B1(net824),
    .Y(_0653_));
 sky130_fd_sc_hd__nand3_1 _8526_ (.A(\count_cycle[54] ),
    .B(_4120_),
    .C(_4131_),
    .Y(_4149_));
 sky130_fd_sc_hd__xor2_1 _8527_ (.A(\count_cycle[55] ),
    .B(_4149_),
    .X(_4150_));
 sky130_fd_sc_hd__nor2_1 _8528_ (.A(net824),
    .B(_4150_),
    .Y(_0654_));
 sky130_fd_sc_hd__xor2_1 _8529_ (.A(\count_cycle[54] ),
    .B(_4121_),
    .X(_4151_));
 sky130_fd_sc_hd__nor2_1 _8530_ (.A(net824),
    .B(_4151_),
    .Y(_0655_));
 sky130_fd_sc_hd__nand3_1 _8531_ (.A(\count_cycle[52] ),
    .B(_4119_),
    .C(_4131_),
    .Y(_4152_));
 sky130_fd_sc_hd__xor2_1 _8532_ (.A(\count_cycle[53] ),
    .B(_4152_),
    .X(_4153_));
 sky130_fd_sc_hd__nor2_1 _8533_ (.A(net822),
    .B(_4153_),
    .Y(_0656_));
 sky130_fd_sc_hd__nand3_1 _8534_ (.A(_4113_),
    .B(_4118_),
    .C(_4119_),
    .Y(_4154_));
 sky130_fd_sc_hd__xor2_1 _8535_ (.A(\count_cycle[52] ),
    .B(_4154_),
    .X(_4155_));
 sky130_fd_sc_hd__nor2_1 _8536_ (.A(net822),
    .B(_4155_),
    .Y(_0657_));
 sky130_fd_sc_hd__nand3_1 _8537_ (.A(\count_cycle[49] ),
    .B(\count_cycle[50] ),
    .C(_4131_),
    .Y(_4156_));
 sky130_fd_sc_hd__xor2_1 _8538_ (.A(\count_cycle[51] ),
    .B(_4156_),
    .X(_4157_));
 sky130_fd_sc_hd__nor2_1 _8539_ (.A(net822),
    .B(_4157_),
    .Y(_0658_));
 sky130_fd_sc_hd__nand3_1 _8540_ (.A(\count_cycle[49] ),
    .B(_4113_),
    .C(_4118_),
    .Y(_4158_));
 sky130_fd_sc_hd__xor2_1 _8541_ (.A(\count_cycle[50] ),
    .B(_4158_),
    .X(_4159_));
 sky130_fd_sc_hd__nor2_1 _8542_ (.A(net822),
    .B(_4159_),
    .Y(_0659_));
 sky130_fd_sc_hd__xnor2_1 _8543_ (.A(\count_cycle[49] ),
    .B(_4131_),
    .Y(_4160_));
 sky130_fd_sc_hd__nor2_1 _8544_ (.A(net822),
    .B(_4160_),
    .Y(_0660_));
 sky130_fd_sc_hd__nand4_1 _8545_ (.A(\count_cycle[47] ),
    .B(\count_cycle[46] ),
    .C(_4113_),
    .D(_4117_),
    .Y(_4161_));
 sky130_fd_sc_hd__xor2_1 _8546_ (.A(\count_cycle[48] ),
    .B(_4161_),
    .X(_4162_));
 sky130_fd_sc_hd__nor2_1 _8547_ (.A(net821),
    .B(_4162_),
    .Y(_0661_));
 sky130_fd_sc_hd__nand3_1 _8548_ (.A(\count_cycle[46] ),
    .B(_4117_),
    .C(_4130_),
    .Y(_4163_));
 sky130_fd_sc_hd__xor2_1 _8549_ (.A(\count_cycle[47] ),
    .B(_4163_),
    .X(_4164_));
 sky130_fd_sc_hd__nor2_1 _8550_ (.A(net821),
    .B(_4164_),
    .Y(_0662_));
 sky130_fd_sc_hd__nand2_1 _8552_ (.A(_4113_),
    .B(_4117_),
    .Y(_4166_));
 sky130_fd_sc_hd__xor2_1 _8553_ (.A(\count_cycle[46] ),
    .B(_4166_),
    .X(_4167_));
 sky130_fd_sc_hd__nor2_1 _8554_ (.A(net821),
    .B(_4167_),
    .Y(_0663_));
 sky130_fd_sc_hd__nor2b_1 _8555_ (.A(_4116_),
    .B_N(_4130_),
    .Y(_4168_));
 sky130_fd_sc_hd__xnor2_1 _8556_ (.A(\count_cycle[45] ),
    .B(_4168_),
    .Y(_4169_));
 sky130_fd_sc_hd__nor2_1 _8557_ (.A(net821),
    .B(_4169_),
    .Y(_0664_));
 sky130_fd_sc_hd__nand4_1 _8558_ (.A(\count_cycle[42] ),
    .B(\count_cycle[43] ),
    .C(_4113_),
    .D(_4115_),
    .Y(_4170_));
 sky130_fd_sc_hd__xor2_1 _8559_ (.A(\count_cycle[44] ),
    .B(_4170_),
    .X(_4171_));
 sky130_fd_sc_hd__nor2_1 _8560_ (.A(net821),
    .B(_4171_),
    .Y(_0665_));
 sky130_fd_sc_hd__nand3_1 _8561_ (.A(\count_cycle[42] ),
    .B(_4115_),
    .C(_4130_),
    .Y(_4172_));
 sky130_fd_sc_hd__xor2_1 _8562_ (.A(\count_cycle[43] ),
    .B(_4172_),
    .X(_4173_));
 sky130_fd_sc_hd__nor2_1 _8563_ (.A(net821),
    .B(_4173_),
    .Y(_0666_));
 sky130_fd_sc_hd__nand2_1 _8564_ (.A(_4113_),
    .B(_4115_),
    .Y(_4174_));
 sky130_fd_sc_hd__xor2_1 _8565_ (.A(\count_cycle[42] ),
    .B(_4174_),
    .X(_4175_));
 sky130_fd_sc_hd__nor2_1 _8566_ (.A(net821),
    .B(_4175_),
    .Y(_0667_));
 sky130_fd_sc_hd__nand4_1 _8567_ (.A(\count_cycle[40] ),
    .B(\count_cycle[39] ),
    .C(\count_cycle[38] ),
    .D(_4130_),
    .Y(_4176_));
 sky130_fd_sc_hd__xor2_1 _8568_ (.A(\count_cycle[41] ),
    .B(_4176_),
    .X(_4177_));
 sky130_fd_sc_hd__nor2_1 _8569_ (.A(net821),
    .B(_4177_),
    .Y(_0668_));
 sky130_fd_sc_hd__nand3_1 _8570_ (.A(\count_cycle[39] ),
    .B(\count_cycle[38] ),
    .C(_4113_),
    .Y(_4178_));
 sky130_fd_sc_hd__xor2_1 _8571_ (.A(\count_cycle[40] ),
    .B(_4178_),
    .X(_4179_));
 sky130_fd_sc_hd__nor2_1 _8572_ (.A(net821),
    .B(_4179_),
    .Y(_0669_));
 sky130_fd_sc_hd__nand2_1 _8573_ (.A(\count_cycle[38] ),
    .B(_4130_),
    .Y(_4180_));
 sky130_fd_sc_hd__xor2_1 _8574_ (.A(\count_cycle[39] ),
    .B(_4180_),
    .X(_4181_));
 sky130_fd_sc_hd__nor2_1 _8575_ (.A(net821),
    .B(_4181_),
    .Y(_0670_));
 sky130_fd_sc_hd__xnor2_1 _8576_ (.A(\count_cycle[38] ),
    .B(_4113_),
    .Y(_4182_));
 sky130_fd_sc_hd__nor2_1 _8577_ (.A(net821),
    .B(_4182_),
    .Y(_0671_));
 sky130_fd_sc_hd__nor2_1 _8578_ (.A(_4109_),
    .B(_4129_),
    .Y(_4183_));
 sky130_fd_sc_hd__nand2_1 _8579_ (.A(_4110_),
    .B(_4183_),
    .Y(_4184_));
 sky130_fd_sc_hd__nor2_1 _8580_ (.A(_4106_),
    .B(_4184_),
    .Y(_4185_));
 sky130_fd_sc_hd__xnor2_1 _8581_ (.A(\count_cycle[37] ),
    .B(_4185_),
    .Y(_4186_));
 sky130_fd_sc_hd__nor2_1 _8582_ (.A(net822),
    .B(_4186_),
    .Y(_0672_));
 sky130_fd_sc_hd__nand2_1 _8583_ (.A(\count_cycle[35] ),
    .B(_4105_),
    .Y(_4187_));
 sky130_fd_sc_hd__nor2_1 _8584_ (.A(_4103_),
    .B(_4109_),
    .Y(_4188_));
 sky130_fd_sc_hd__nand2_1 _8585_ (.A(_4110_),
    .B(_4188_),
    .Y(_4189_));
 sky130_fd_sc_hd__o21ai_0 _8586_ (.A1(_4187_),
    .A2(_4189_),
    .B1(\count_cycle[36] ),
    .Y(_4190_));
 sky130_fd_sc_hd__or3_1 _8587_ (.A(\count_cycle[36] ),
    .B(_4187_),
    .C(_4189_),
    .X(_4191_));
 sky130_fd_sc_hd__a21oi_1 _8588_ (.A1(_4190_),
    .A2(_4191_),
    .B1(net822),
    .Y(_0673_));
 sky130_fd_sc_hd__and3_1 _8590_ (.A(_4105_),
    .B(_4110_),
    .C(_4183_),
    .X(_4193_));
 sky130_fd_sc_hd__xnor2_1 _8591_ (.A(\count_cycle[35] ),
    .B(_4193_),
    .Y(_4194_));
 sky130_fd_sc_hd__nor2_1 _8592_ (.A(net822),
    .B(_4194_),
    .Y(_0674_));
 sky130_fd_sc_hd__nand3_1 _8593_ (.A(\count_cycle[33] ),
    .B(\count_cycle[32] ),
    .C(_4104_),
    .Y(_4195_));
 sky130_fd_sc_hd__o21ai_0 _8594_ (.A1(_4195_),
    .A2(_4189_),
    .B1(\count_cycle[34] ),
    .Y(_4196_));
 sky130_fd_sc_hd__or3_1 _8595_ (.A(\count_cycle[34] ),
    .B(_4195_),
    .C(_4189_),
    .X(_4197_));
 sky130_fd_sc_hd__a21oi_1 _8596_ (.A1(_4196_),
    .A2(_4197_),
    .B1(net822),
    .Y(_0675_));
 sky130_fd_sc_hd__nand2_1 _8597_ (.A(\count_cycle[32] ),
    .B(_4104_),
    .Y(_4198_));
 sky130_fd_sc_hd__o21ai_0 _8598_ (.A1(_4198_),
    .A2(_4184_),
    .B1(\count_cycle[33] ),
    .Y(_4199_));
 sky130_fd_sc_hd__or3_1 _8599_ (.A(\count_cycle[33] ),
    .B(_4198_),
    .C(_4184_),
    .X(_4200_));
 sky130_fd_sc_hd__a21oi_1 _8601_ (.A1(_4199_),
    .A2(_4200_),
    .B1(net822),
    .Y(_0676_));
 sky130_fd_sc_hd__nand3_1 _8602_ (.A(_4104_),
    .B(_4110_),
    .C(_4188_),
    .Y(_4202_));
 sky130_fd_sc_hd__xor2_1 _8603_ (.A(\count_cycle[32] ),
    .B(_4202_),
    .X(_4203_));
 sky130_fd_sc_hd__nor2_1 _8604_ (.A(net822),
    .B(_4203_),
    .Y(_0677_));
 sky130_fd_sc_hd__nand3_1 _8605_ (.A(\count_cycle[30] ),
    .B(\count_cycle[29] ),
    .C(\count_cycle[28] ),
    .Y(_4204_));
 sky130_fd_sc_hd__o21ai_0 _8606_ (.A1(_4204_),
    .A2(_4184_),
    .B1(\count_cycle[31] ),
    .Y(_4205_));
 sky130_fd_sc_hd__or3_1 _8607_ (.A(\count_cycle[31] ),
    .B(_4204_),
    .C(_4184_),
    .X(_4206_));
 sky130_fd_sc_hd__a21oi_1 _8608_ (.A1(_4205_),
    .A2(_4206_),
    .B1(net824),
    .Y(_0678_));
 sky130_fd_sc_hd__nand2_1 _8609_ (.A(\count_cycle[29] ),
    .B(\count_cycle[28] ),
    .Y(_4207_));
 sky130_fd_sc_hd__o21ai_0 _8610_ (.A1(_4207_),
    .A2(_4189_),
    .B1(\count_cycle[30] ),
    .Y(_4208_));
 sky130_fd_sc_hd__or3_1 _8611_ (.A(\count_cycle[30] ),
    .B(_4207_),
    .C(_4189_),
    .X(_4209_));
 sky130_fd_sc_hd__a21oi_1 _8612_ (.A1(_4208_),
    .A2(_4209_),
    .B1(net824),
    .Y(_0679_));
 sky130_fd_sc_hd__nand3_1 _8613_ (.A(\count_cycle[28] ),
    .B(_4110_),
    .C(_4183_),
    .Y(_4210_));
 sky130_fd_sc_hd__xor2_1 _8614_ (.A(\count_cycle[29] ),
    .B(_4210_),
    .X(_4211_));
 sky130_fd_sc_hd__nor2_1 _8615_ (.A(net824),
    .B(_4211_),
    .Y(_0680_));
 sky130_fd_sc_hd__xor2_1 _8616_ (.A(\count_cycle[28] ),
    .B(_4189_),
    .X(_4212_));
 sky130_fd_sc_hd__nor2_1 _8617_ (.A(net824),
    .B(_4212_),
    .Y(_0681_));
 sky130_fd_sc_hd__nand4_1 _8618_ (.A(\count_cycle[26] ),
    .B(\count_cycle[25] ),
    .C(\count_cycle[24] ),
    .D(_4183_),
    .Y(_4213_));
 sky130_fd_sc_hd__xnor2_1 _8619_ (.A(\count_cycle[27] ),
    .B(_4213_),
    .Y(_4214_));
 sky130_fd_sc_hd__and2_1 _8620_ (.A(net825),
    .B(_4214_),
    .X(_0682_));
 sky130_fd_sc_hd__nand3_1 _8621_ (.A(\count_cycle[25] ),
    .B(\count_cycle[24] ),
    .C(_4188_),
    .Y(_4215_));
 sky130_fd_sc_hd__xor2_1 _8622_ (.A(\count_cycle[26] ),
    .B(_4215_),
    .X(_4216_));
 sky130_fd_sc_hd__nor2_1 _8623_ (.A(net822),
    .B(_4216_),
    .Y(_0683_));
 sky130_fd_sc_hd__nand2_1 _8624_ (.A(\count_cycle[24] ),
    .B(_4183_),
    .Y(_4217_));
 sky130_fd_sc_hd__xnor2_1 _8625_ (.A(\count_cycle[25] ),
    .B(_4217_),
    .Y(_4218_));
 sky130_fd_sc_hd__and2_1 _8626_ (.A(net825),
    .B(_4218_),
    .X(_0684_));
 sky130_fd_sc_hd__xnor2_1 _8627_ (.A(\count_cycle[24] ),
    .B(_4188_),
    .Y(_4219_));
 sky130_fd_sc_hd__nor2_1 _8628_ (.A(net822),
    .B(_4219_),
    .Y(_0685_));
 sky130_fd_sc_hd__and3_1 _8629_ (.A(\count_cycle[15] ),
    .B(_4102_),
    .C(_4128_),
    .X(_4220_));
 sky130_fd_sc_hd__and3_1 _8630_ (.A(\count_cycle[22] ),
    .B(_4108_),
    .C(_4220_),
    .X(_4221_));
 sky130_fd_sc_hd__xnor2_1 _8631_ (.A(\count_cycle[23] ),
    .B(_4221_),
    .Y(_4222_));
 sky130_fd_sc_hd__nor2_1 _8632_ (.A(net821),
    .B(_4222_),
    .Y(_0686_));
 sky130_fd_sc_hd__and3_1 _8633_ (.A(\count_cycle[15] ),
    .B(_4100_),
    .C(_4102_),
    .X(_4223_));
 sky130_fd_sc_hd__nand2_1 _8634_ (.A(_4223_),
    .B(_4108_),
    .Y(_4224_));
 sky130_fd_sc_hd__xor2_1 _8635_ (.A(\count_cycle[22] ),
    .B(_4224_),
    .X(_4225_));
 sky130_fd_sc_hd__nor2_1 _8636_ (.A(net821),
    .B(_4225_),
    .Y(_0687_));
 sky130_fd_sc_hd__nand3_1 _8637_ (.A(\count_cycle[20] ),
    .B(_4107_),
    .C(_4220_),
    .Y(_4226_));
 sky130_fd_sc_hd__xor2_1 _8638_ (.A(\count_cycle[21] ),
    .B(_4226_),
    .X(_4227_));
 sky130_fd_sc_hd__nor2_1 _8639_ (.A(net821),
    .B(_4227_),
    .Y(_0688_));
 sky130_fd_sc_hd__nand2_1 _8640_ (.A(_4223_),
    .B(_4107_),
    .Y(_4228_));
 sky130_fd_sc_hd__xor2_1 _8641_ (.A(\count_cycle[20] ),
    .B(_4228_),
    .X(_4229_));
 sky130_fd_sc_hd__nor2_1 _8642_ (.A(net821),
    .B(_4229_),
    .Y(_0689_));
 sky130_fd_sc_hd__nand4_1 _8644_ (.A(\count_cycle[18] ),
    .B(\count_cycle[17] ),
    .C(\count_cycle[16] ),
    .D(_4220_),
    .Y(_4231_));
 sky130_fd_sc_hd__xor2_1 _8645_ (.A(\count_cycle[19] ),
    .B(_4231_),
    .X(_4232_));
 sky130_fd_sc_hd__nor2_1 _8646_ (.A(net821),
    .B(_4232_),
    .Y(_0690_));
 sky130_fd_sc_hd__nand3_1 _8647_ (.A(\count_cycle[17] ),
    .B(\count_cycle[16] ),
    .C(_4223_),
    .Y(_4233_));
 sky130_fd_sc_hd__xor2_1 _8648_ (.A(\count_cycle[18] ),
    .B(_4233_),
    .X(_4234_));
 sky130_fd_sc_hd__nor2_1 _8649_ (.A(net821),
    .B(_4234_),
    .Y(_0691_));
 sky130_fd_sc_hd__nand2_1 _8650_ (.A(\count_cycle[16] ),
    .B(_4220_),
    .Y(_4235_));
 sky130_fd_sc_hd__xor2_1 _8651_ (.A(\count_cycle[17] ),
    .B(_4235_),
    .X(_4236_));
 sky130_fd_sc_hd__nor2_1 _8652_ (.A(net821),
    .B(_4236_),
    .Y(_0692_));
 sky130_fd_sc_hd__xnor2_1 _8653_ (.A(\count_cycle[16] ),
    .B(_4223_),
    .Y(_4237_));
 sky130_fd_sc_hd__nor2_1 _8654_ (.A(net821),
    .B(_4237_),
    .Y(_0693_));
 sky130_fd_sc_hd__nand2_1 _8655_ (.A(_4102_),
    .B(_4128_),
    .Y(_4238_));
 sky130_fd_sc_hd__xor2_1 _8656_ (.A(\count_cycle[15] ),
    .B(_4238_),
    .X(_4239_));
 sky130_fd_sc_hd__nor2_1 _8657_ (.A(net821),
    .B(_4239_),
    .Y(_0694_));
 sky130_fd_sc_hd__nand4_1 _8658_ (.A(\count_cycle[13] ),
    .B(\count_cycle[9] ),
    .C(_4100_),
    .D(_4101_),
    .Y(_4240_));
 sky130_fd_sc_hd__xor2_1 _8659_ (.A(\count_cycle[14] ),
    .B(_4240_),
    .X(_4241_));
 sky130_fd_sc_hd__nor2_1 _8660_ (.A(net821),
    .B(_4241_),
    .Y(_0695_));
 sky130_fd_sc_hd__nand3_1 _8661_ (.A(\count_cycle[9] ),
    .B(_4101_),
    .C(_4128_),
    .Y(_4242_));
 sky130_fd_sc_hd__xor2_1 _8662_ (.A(\count_cycle[13] ),
    .B(_4242_),
    .X(_4243_));
 sky130_fd_sc_hd__nor2_1 _8663_ (.A(net821),
    .B(_4243_),
    .Y(_0696_));
 sky130_fd_sc_hd__nand4_1 _8664_ (.A(\count_cycle[10] ),
    .B(\count_cycle[11] ),
    .C(\count_cycle[9] ),
    .D(_4100_),
    .Y(_4244_));
 sky130_fd_sc_hd__xor2_1 _8665_ (.A(\count_cycle[12] ),
    .B(_4244_),
    .X(_4245_));
 sky130_fd_sc_hd__nor2_1 _8666_ (.A(net821),
    .B(_4245_),
    .Y(_0697_));
 sky130_fd_sc_hd__nand3_1 _8667_ (.A(\count_cycle[10] ),
    .B(\count_cycle[9] ),
    .C(_4128_),
    .Y(_4246_));
 sky130_fd_sc_hd__xor2_1 _8668_ (.A(\count_cycle[11] ),
    .B(_4246_),
    .X(_4247_));
 sky130_fd_sc_hd__nor2_1 _8669_ (.A(net821),
    .B(_4247_),
    .Y(_0698_));
 sky130_fd_sc_hd__nand2_1 _8670_ (.A(\count_cycle[9] ),
    .B(_4100_),
    .Y(_4248_));
 sky130_fd_sc_hd__xor2_1 _8671_ (.A(\count_cycle[10] ),
    .B(_4248_),
    .X(_4249_));
 sky130_fd_sc_hd__nor2_1 _8672_ (.A(net821),
    .B(_4249_),
    .Y(_0699_));
 sky130_fd_sc_hd__xnor2_1 _8674_ (.A(\count_cycle[9] ),
    .B(_4128_),
    .Y(_4251_));
 sky130_fd_sc_hd__nor2_1 _8675_ (.A(net821),
    .B(_4251_),
    .Y(_0700_));
 sky130_fd_sc_hd__nand3_1 _8676_ (.A(_0480_),
    .B(\count_cycle[7] ),
    .C(\count_cycle[2] ),
    .Y(_4252_));
 sky130_fd_sc_hd__o21ai_0 _8677_ (.A1(_4098_),
    .A2(_4252_),
    .B1(\count_cycle[8] ),
    .Y(_4253_));
 sky130_fd_sc_hd__or3_1 _8678_ (.A(\count_cycle[8] ),
    .B(_4098_),
    .C(_4252_),
    .X(_4254_));
 sky130_fd_sc_hd__a21oi_1 _8679_ (.A1(_4253_),
    .A2(_4254_),
    .B1(net823),
    .Y(_0701_));
 sky130_fd_sc_hd__o21ai_0 _8680_ (.A1(_4098_),
    .A2(_4127_),
    .B1(\count_cycle[7] ),
    .Y(_4255_));
 sky130_fd_sc_hd__or3_1 _8681_ (.A(\count_cycle[7] ),
    .B(_4098_),
    .C(_4127_),
    .X(_4256_));
 sky130_fd_sc_hd__a21oi_1 _8682_ (.A1(_4255_),
    .A2(_4256_),
    .B1(net823),
    .Y(_0702_));
 sky130_fd_sc_hd__nand3_1 _8683_ (.A(\count_cycle[3] ),
    .B(\count_cycle[5] ),
    .C(\count_cycle[4] ),
    .Y(_4257_));
 sky130_fd_sc_hd__o21ai_0 _8684_ (.A1(_4097_),
    .A2(_4257_),
    .B1(\count_cycle[6] ),
    .Y(_4258_));
 sky130_fd_sc_hd__or3_1 _8685_ (.A(\count_cycle[6] ),
    .B(_4097_),
    .C(_4257_),
    .X(_4259_));
 sky130_fd_sc_hd__a21oi_1 _8686_ (.A1(_4258_),
    .A2(_4259_),
    .B1(net823),
    .Y(_0703_));
 sky130_fd_sc_hd__nand2_1 _8687_ (.A(\count_cycle[3] ),
    .B(\count_cycle[4] ),
    .Y(_4260_));
 sky130_fd_sc_hd__o21ai_0 _8688_ (.A1(_4260_),
    .A2(_4127_),
    .B1(\count_cycle[5] ),
    .Y(_4261_));
 sky130_fd_sc_hd__or3_1 _8689_ (.A(\count_cycle[5] ),
    .B(_4260_),
    .C(_4127_),
    .X(_4262_));
 sky130_fd_sc_hd__a21oi_1 _8690_ (.A1(_4261_),
    .A2(_4262_),
    .B1(net823),
    .Y(_0704_));
 sky130_fd_sc_hd__nand3_1 _8691_ (.A(_0480_),
    .B(\count_cycle[3] ),
    .C(\count_cycle[2] ),
    .Y(_4263_));
 sky130_fd_sc_hd__xor2_1 _8692_ (.A(\count_cycle[4] ),
    .B(_4263_),
    .X(_4264_));
 sky130_fd_sc_hd__nor2_1 _8693_ (.A(net823),
    .B(_4264_),
    .Y(_0705_));
 sky130_fd_sc_hd__xor2_1 _8694_ (.A(\count_cycle[3] ),
    .B(_4127_),
    .X(_4265_));
 sky130_fd_sc_hd__nor2_1 _8695_ (.A(net823),
    .B(_4265_),
    .Y(_0706_));
 sky130_fd_sc_hd__xnor2_1 _8696_ (.A(_0480_),
    .B(\count_cycle[2] ),
    .Y(_4266_));
 sky130_fd_sc_hd__nor2_1 _8697_ (.A(net823),
    .B(_4266_),
    .Y(_0707_));
 sky130_fd_sc_hd__and2_1 _8698_ (.A(net825),
    .B(_0481_),
    .X(_0708_));
 sky130_fd_sc_hd__nor2_1 _8699_ (.A(\count_cycle[0] ),
    .B(net823),
    .Y(_0709_));
 sky130_fd_sc_hd__nand2_1 _8700_ (.A(\reg_pc[30] ),
    .B(net714),
    .Y(_4267_));
 sky130_fd_sc_hd__o21ai_0 _8701_ (.A1(_0942_),
    .A2(_4092_),
    .B1(_4267_),
    .Y(_0710_));
 sky130_fd_sc_hd__nand2_1 _8702_ (.A(\reg_pc[29] ),
    .B(net714),
    .Y(_4268_));
 sky130_fd_sc_hd__o21ai_0 _8703_ (.A1(_0939_),
    .A2(_4092_),
    .B1(_4268_),
    .Y(_0711_));
 sky130_fd_sc_hd__a22o_1 _8704_ (.A1(_0470_),
    .A2(net704),
    .B1(net714),
    .B2(\reg_pc[28] ),
    .X(_0712_));
 sky130_fd_sc_hd__nand2_1 _8705_ (.A(\reg_pc[27] ),
    .B(net714),
    .Y(_4269_));
 sky130_fd_sc_hd__o21ai_0 _8706_ (.A1(_0934_),
    .A2(_4092_),
    .B1(_4269_),
    .Y(_0713_));
 sky130_fd_sc_hd__a22o_1 _8707_ (.A1(_0228_),
    .A2(net704),
    .B1(net714),
    .B2(\reg_pc[26] ),
    .X(_0714_));
 sky130_fd_sc_hd__mux2i_1 _8708_ (.A0(\reg_pc[25] ),
    .A1(_0432_),
    .S(net778),
    .Y(_4270_));
 sky130_fd_sc_hd__nor2_1 _8709_ (.A(net823),
    .B(_4270_),
    .Y(_0715_));
 sky130_fd_sc_hd__nor2_1 _8710_ (.A(net715),
    .B(_0927_),
    .Y(_4271_));
 sky130_fd_sc_hd__a21oi_1 _8711_ (.A1(net715),
    .A2(\reg_pc[24] ),
    .B1(_4271_),
    .Y(_4272_));
 sky130_fd_sc_hd__nor2_1 _8712_ (.A(net823),
    .B(_4272_),
    .Y(_0716_));
 sky130_fd_sc_hd__nor2_1 _8713_ (.A(net715),
    .B(net701),
    .Y(_4273_));
 sky130_fd_sc_hd__a21oi_1 _8714_ (.A1(net715),
    .A2(\reg_pc[23] ),
    .B1(_4273_),
    .Y(_4274_));
 sky130_fd_sc_hd__nor2_1 _8715_ (.A(net823),
    .B(_4274_),
    .Y(_0717_));
 sky130_fd_sc_hd__a22o_1 _8716_ (.A1(net702),
    .A2(net704),
    .B1(net714),
    .B2(\reg_pc[22] ),
    .X(_0718_));
 sky130_fd_sc_hd__mux2i_1 _8717_ (.A0(\reg_pc[21] ),
    .A1(_0221_),
    .S(net778),
    .Y(_4275_));
 sky130_fd_sc_hd__nor2_1 _8718_ (.A(net823),
    .B(_4275_),
    .Y(_0719_));
 sky130_fd_sc_hd__mux2i_1 _8719_ (.A0(\reg_pc[20] ),
    .A1(_0069_),
    .S(net778),
    .Y(_4276_));
 sky130_fd_sc_hd__nor2_1 _8720_ (.A(net823),
    .B(_4276_),
    .Y(_0720_));
 sky130_fd_sc_hd__mux2i_1 _8721_ (.A0(\reg_pc[19] ),
    .A1(_0216_),
    .S(net778),
    .Y(_4277_));
 sky130_fd_sc_hd__nor2_1 _8722_ (.A(net823),
    .B(_4277_),
    .Y(_0721_));
 sky130_fd_sc_hd__nand2_1 _8723_ (.A(\reg_pc[18] ),
    .B(net714),
    .Y(_4278_));
 sky130_fd_sc_hd__o21ai_0 _8724_ (.A1(_0913_),
    .A2(_4092_),
    .B1(_4278_),
    .Y(_0722_));
 sky130_fd_sc_hd__a21oi_1 _8726_ (.A1(_0909_),
    .A2(_0910_),
    .B1(net715),
    .Y(_4280_));
 sky130_fd_sc_hd__a21oi_1 _8727_ (.A1(net715),
    .A2(\reg_pc[17] ),
    .B1(_4280_),
    .Y(_4281_));
 sky130_fd_sc_hd__nor2_1 _8728_ (.A(net823),
    .B(_4281_),
    .Y(_0723_));
 sky130_fd_sc_hd__mux2i_1 _8729_ (.A0(\reg_pc[16] ),
    .A1(_0086_),
    .S(net778),
    .Y(_4282_));
 sky130_fd_sc_hd__nor2_1 _8730_ (.A(net823),
    .B(_4282_),
    .Y(_0724_));
 sky130_fd_sc_hd__mux2i_1 _8731_ (.A0(\reg_pc[15] ),
    .A1(_0103_),
    .S(net778),
    .Y(_4283_));
 sky130_fd_sc_hd__nor2_1 _8732_ (.A(net823),
    .B(_4283_),
    .Y(_0725_));
 sky130_fd_sc_hd__mux2i_1 _8733_ (.A0(\reg_pc[14] ),
    .A1(_0412_),
    .S(net778),
    .Y(_4284_));
 sky130_fd_sc_hd__nor2_1 _8734_ (.A(net823),
    .B(_4284_),
    .Y(_0726_));
 sky130_fd_sc_hd__mux2i_1 _8735_ (.A0(\reg_pc[13] ),
    .A1(_0244_),
    .S(net778),
    .Y(_4285_));
 sky130_fd_sc_hd__nor2_1 _8736_ (.A(net823),
    .B(_4285_),
    .Y(_0727_));
 sky130_fd_sc_hd__nand2_1 _8737_ (.A(net778),
    .B(_0090_),
    .Y(_4286_));
 sky130_fd_sc_hd__nand2_1 _8738_ (.A(net715),
    .B(\reg_pc[12] ),
    .Y(_4287_));
 sky130_fd_sc_hd__a21oi_1 _8739_ (.A1(_4286_),
    .A2(_4287_),
    .B1(net823),
    .Y(_0728_));
 sky130_fd_sc_hd__nor2_1 _8740_ (.A(net715),
    .B(net711),
    .Y(_4288_));
 sky130_fd_sc_hd__a21oi_1 _8741_ (.A1(net715),
    .A2(\reg_pc[11] ),
    .B1(_4288_),
    .Y(_4289_));
 sky130_fd_sc_hd__nor2_1 _8742_ (.A(net823),
    .B(_4289_),
    .Y(_0729_));
 sky130_fd_sc_hd__nor2_1 _8743_ (.A(net715),
    .B(_0895_),
    .Y(_4290_));
 sky130_fd_sc_hd__a21oi_1 _8744_ (.A1(net715),
    .A2(\reg_pc[10] ),
    .B1(_4290_),
    .Y(_4291_));
 sky130_fd_sc_hd__nor2_1 _8745_ (.A(net823),
    .B(_4291_),
    .Y(_0730_));
 sky130_fd_sc_hd__mux2i_1 _8746_ (.A0(net735),
    .A1(_0269_),
    .S(net778),
    .Y(_4292_));
 sky130_fd_sc_hd__nor2_1 _8747_ (.A(net823),
    .B(_4292_),
    .Y(_0731_));
 sky130_fd_sc_hd__nor2_1 _8748_ (.A(net715),
    .B(_0891_),
    .Y(_4293_));
 sky130_fd_sc_hd__a21oi_1 _8749_ (.A1(net715),
    .A2(\reg_pc[8] ),
    .B1(_4293_),
    .Y(_4294_));
 sky130_fd_sc_hd__nor2_1 _8750_ (.A(net823),
    .B(_4294_),
    .Y(_0732_));
 sky130_fd_sc_hd__mux2i_1 _8751_ (.A0(\reg_pc[7] ),
    .A1(_0108_),
    .S(net778),
    .Y(_4295_));
 sky130_fd_sc_hd__nor2_1 _8752_ (.A(net823),
    .B(_4295_),
    .Y(_0733_));
 sky130_fd_sc_hd__mux2i_1 _8754_ (.A0(\reg_pc[6] ),
    .A1(_0460_),
    .S(net778),
    .Y(_4297_));
 sky130_fd_sc_hd__nor2_1 _8755_ (.A(net823),
    .B(_4297_),
    .Y(_0734_));
 sky130_fd_sc_hd__nor2_1 _8756_ (.A(net715),
    .B(_0886_),
    .Y(_4298_));
 sky130_fd_sc_hd__a21oi_1 _8757_ (.A1(net715),
    .A2(\reg_pc[5] ),
    .B1(_4298_),
    .Y(_4299_));
 sky130_fd_sc_hd__nor2_1 _8758_ (.A(net823),
    .B(_4299_),
    .Y(_0735_));
 sky130_fd_sc_hd__mux2i_1 _8759_ (.A0(\reg_pc[4] ),
    .A1(_0238_),
    .S(net778),
    .Y(_4300_));
 sky130_fd_sc_hd__nor2_1 _8760_ (.A(net823),
    .B(_4300_),
    .Y(_0736_));
 sky130_fd_sc_hd__mux2i_1 _8761_ (.A0(\reg_pc[3] ),
    .A1(_0079_),
    .S(net778),
    .Y(_4301_));
 sky130_fd_sc_hd__nor2_1 _8762_ (.A(net823),
    .B(_4301_),
    .Y(_0737_));
 sky130_fd_sc_hd__mux2i_1 _8763_ (.A0(\reg_pc[2] ),
    .A1(_0051_),
    .S(net778),
    .Y(_4302_));
 sky130_fd_sc_hd__nor2_1 _8764_ (.A(net823),
    .B(_4302_),
    .Y(_0738_));
 sky130_fd_sc_hd__a22o_1 _8765_ (.A1(_0084_),
    .A2(net704),
    .B1(net714),
    .B2(\reg_pc[1] ),
    .X(_0739_));
 sky130_fd_sc_hd__inv_1 _8766_ (.A(net754),
    .Y(_0322_));
 sky130_fd_sc_hd__inv_1 _8767_ (.A(net362),
    .Y(_0389_));
 sky130_fd_sc_hd__inv_1 _8768_ (.A(net346),
    .Y(_0341_));
 sky130_fd_sc_hd__inv_1 _8769_ (.A(net350),
    .Y(_0317_));
 sky130_fd_sc_hd__inv_1 _8770_ (.A(net740),
    .Y(_0427_));
 sky130_fd_sc_hd__mux2_2 _8771_ (.A0(\mem_rdata_latched[18] ),
    .A1(\decoded_imm_j[18] ),
    .S(_0861_),
    .X(_0517_));
 sky130_fd_sc_hd__mux2_2 _8772_ (.A0(\mem_rdata_latched[17] ),
    .A1(\decoded_imm_j[17] ),
    .S(_0861_),
    .X(_0516_));
 sky130_fd_sc_hd__mux2_2 _8773_ (.A0(\mem_rdata_latched[16] ),
    .A1(\decoded_imm_j[16] ),
    .S(_0861_),
    .X(_0515_));
 sky130_fd_sc_hd__mux2_2 _8774_ (.A0(\mem_rdata_latched[15] ),
    .A1(\decoded_imm_j[15] ),
    .S(_0861_),
    .X(_0514_));
 sky130_fd_sc_hd__mux2_2 _8775_ (.A0(\mem_rdata_latched[23] ),
    .A1(\decoded_imm_j[3] ),
    .S(_0861_),
    .X(_0522_));
 sky130_fd_sc_hd__mux2_2 _8776_ (.A0(\mem_rdata_latched[22] ),
    .A1(\decoded_imm_j[2] ),
    .S(_0861_),
    .X(_0521_));
 sky130_fd_sc_hd__mux2_2 _8777_ (.A0(\mem_rdata_latched[21] ),
    .A1(\decoded_imm_j[1] ),
    .S(_0861_),
    .X(_0520_));
 sky130_fd_sc_hd__mux2_2 _8778_ (.A0(\mem_rdata_latched[20] ),
    .A1(\decoded_imm_j[11] ),
    .S(_0861_),
    .X(_0519_));
 sky130_fd_sc_hd__nor2_1 _8779_ (.A(mem_do_rinst),
    .B(mem_do_rdata),
    .Y(_4303_));
 sky130_fd_sc_hd__nand2_1 _8780_ (.A(_0490_),
    .B(_4303_),
    .Y(_4304_));
 sky130_fd_sc_hd__mux2_2 _8781_ (.A0(_4304_),
    .A1(mem_do_wdata),
    .S(_0487_),
    .X(_4305_));
 sky130_fd_sc_hd__nor2_1 _8782_ (.A(_3496_),
    .B(_4305_),
    .Y(_0740_));
 sky130_fd_sc_hd__and2_1 _8783_ (.A(net779),
    .B(\decoded_rd[3] ),
    .X(_0741_));
 sky130_fd_sc_hd__and2_1 _8784_ (.A(net779),
    .B(\decoded_rd[2] ),
    .X(_0742_));
 sky130_fd_sc_hd__and2_1 _8785_ (.A(net779),
    .B(\decoded_rd[1] ),
    .X(_0743_));
 sky130_fd_sc_hd__and2_1 _8786_ (.A(net779),
    .B(\decoded_rd[0] ),
    .X(_0744_));
 sky130_fd_sc_hd__or2_2 _8787_ (.A(\latched_rd[0] ),
    .B(\latched_rd[1] ),
    .X(_4306_));
 sky130_fd_sc_hd__inv_1 _8789_ (.A(\latched_rd[2] ),
    .Y(_4308_));
 sky130_fd_sc_hd__o21ai_0 _8790_ (.A1(latched_store),
    .A2(latched_branch),
    .B1(net704),
    .Y(_4309_));
 sky130_fd_sc_hd__nor2_1 _8791_ (.A(_4308_),
    .B(net695),
    .Y(_4310_));
 sky130_fd_sc_hd__nor2b_1 _8792_ (.A(\latched_rd[3] ),
    .B_N(\latched_rd[4] ),
    .Y(_4311_));
 sky130_fd_sc_hd__nand2_1 _8793_ (.A(_4310_),
    .B(_4311_),
    .Y(_4312_));
 sky130_fd_sc_hd__nor2_4 _8794_ (.A(_4306_),
    .B(_4312_),
    .Y(_0829_));
 sky130_fd_sc_hd__nand2b_1 _8795_ (.A_N(\latched_rd[0] ),
    .B(\latched_rd[1] ),
    .Y(_4313_));
 sky130_fd_sc_hd__nor3_1 _8797_ (.A(\latched_rd[4] ),
    .B(\latched_rd[3] ),
    .C(_4306_),
    .Y(_4315_));
 sky130_fd_sc_hd__nor3_1 _8798_ (.A(\latched_rd[2] ),
    .B(net695),
    .C(_4315_),
    .Y(_4316_));
 sky130_fd_sc_hd__nand3_1 _8799_ (.A(\latched_rd[4] ),
    .B(\latched_rd[3] ),
    .C(_4316_),
    .Y(_4317_));
 sky130_fd_sc_hd__nor2_4 _8800_ (.A(_4313_),
    .B(_4317_),
    .Y(_0835_));
 sky130_fd_sc_hd__nand2_1 _8801_ (.A(\latched_rd[0] ),
    .B(\latched_rd[1] ),
    .Y(_4318_));
 sky130_fd_sc_hd__nand2_1 _8802_ (.A(_4311_),
    .B(_4316_),
    .Y(_4319_));
 sky130_fd_sc_hd__nor2_4 _8803_ (.A(_4318_),
    .B(_4319_),
    .Y(_0827_));
 sky130_fd_sc_hd__nor2_4 _8804_ (.A(_4313_),
    .B(_4319_),
    .Y(_0826_));
 sky130_fd_sc_hd__nand2b_1 _8805_ (.A_N(\latched_rd[1] ),
    .B(\latched_rd[0] ),
    .Y(_4320_));
 sky130_fd_sc_hd__nor2_4 _8807_ (.A(_4319_),
    .B(_4320_),
    .Y(_0825_));
 sky130_fd_sc_hd__nor2_4 _8808_ (.A(_4317_),
    .B(_4320_),
    .Y(_0834_));
 sky130_fd_sc_hd__nor2_4 _8809_ (.A(_4306_),
    .B(_4319_),
    .Y(_0824_));
 sky130_fd_sc_hd__nand3_1 _8810_ (.A(\latched_rd[4] ),
    .B(\latched_rd[3] ),
    .C(_4310_),
    .Y(_4322_));
 sky130_fd_sc_hd__nor2_4 _8811_ (.A(_4318_),
    .B(_4322_),
    .Y(_0841_));
 sky130_fd_sc_hd__nor2b_1 _8812_ (.A(\latched_rd[4] ),
    .B_N(\latched_rd[3] ),
    .Y(_4323_));
 sky130_fd_sc_hd__nand2_1 _8813_ (.A(_4310_),
    .B(_4323_),
    .Y(_4324_));
 sky130_fd_sc_hd__nor2_4 _8814_ (.A(_4318_),
    .B(_4324_),
    .Y(_0823_));
 sky130_fd_sc_hd__nor2_4 _8815_ (.A(_4313_),
    .B(_4324_),
    .Y(_0822_));
 sky130_fd_sc_hd__nor2_4 _8816_ (.A(_4306_),
    .B(_4317_),
    .Y(_0833_));
 sky130_fd_sc_hd__nor2_4 _8817_ (.A(_4320_),
    .B(_4324_),
    .Y(_0821_));
 sky130_fd_sc_hd__nor2_4 _8818_ (.A(_4306_),
    .B(_4324_),
    .Y(_0820_));
 sky130_fd_sc_hd__nand2_1 _8819_ (.A(_4316_),
    .B(_4323_),
    .Y(_4325_));
 sky130_fd_sc_hd__nor2_4 _8820_ (.A(_4318_),
    .B(_4325_),
    .Y(_0819_));
 sky130_fd_sc_hd__nor2_4 _8821_ (.A(_4313_),
    .B(_4325_),
    .Y(_0818_));
 sky130_fd_sc_hd__nor2_4 _8822_ (.A(_4320_),
    .B(_4325_),
    .Y(_0848_));
 sky130_fd_sc_hd__nor2_4 _8823_ (.A(_4312_),
    .B(_4318_),
    .Y(_0832_));
 sky130_fd_sc_hd__nor2_4 _8824_ (.A(_4306_),
    .B(_4325_),
    .Y(_0847_));
 sky130_fd_sc_hd__nor2_1 _8825_ (.A(\latched_rd[4] ),
    .B(\latched_rd[3] ),
    .Y(_4326_));
 sky130_fd_sc_hd__nand2_1 _8826_ (.A(_4310_),
    .B(_4326_),
    .Y(_4327_));
 sky130_fd_sc_hd__nor2_4 _8827_ (.A(_4318_),
    .B(_4327_),
    .Y(_0846_));
 sky130_fd_sc_hd__nor2_4 _8828_ (.A(_4317_),
    .B(_4318_),
    .Y(_0836_));
 sky130_fd_sc_hd__nor2_4 _8829_ (.A(_4313_),
    .B(_4327_),
    .Y(_0845_));
 sky130_fd_sc_hd__nor2_4 _8830_ (.A(_4312_),
    .B(_4313_),
    .Y(_0831_));
 sky130_fd_sc_hd__nor2_4 _8831_ (.A(_4320_),
    .B(_4327_),
    .Y(_0844_));
 sky130_fd_sc_hd__nor2_4 _8832_ (.A(_4306_),
    .B(_4327_),
    .Y(_0843_));
 sky130_fd_sc_hd__nor2_4 _8833_ (.A(_4320_),
    .B(_4322_),
    .Y(_0838_));
 sky130_fd_sc_hd__nand2_1 _8834_ (.A(_4326_),
    .B(_4316_),
    .Y(_4328_));
 sky130_fd_sc_hd__nor2_4 _8835_ (.A(_4318_),
    .B(_4328_),
    .Y(_0842_));
 sky130_fd_sc_hd__nor2_4 _8836_ (.A(_4312_),
    .B(_4320_),
    .Y(_0830_));
 sky130_fd_sc_hd__nor2_4 _8837_ (.A(_4313_),
    .B(_4328_),
    .Y(_0839_));
 sky130_fd_sc_hd__nor2_4 _8838_ (.A(_4313_),
    .B(_4322_),
    .Y(_0840_));
 sky130_fd_sc_hd__nor2_4 _8839_ (.A(_4320_),
    .B(_4328_),
    .Y(_0828_));
 sky130_fd_sc_hd__nor2_4 _8840_ (.A(_4306_),
    .B(_4322_),
    .Y(_0837_));
 sky130_fd_sc_hd__nand2_1 _8841_ (.A(net775),
    .B(_1673_),
    .Y(_0503_));
 sky130_fd_sc_hd__nor2_1 _8842_ (.A(\mem_rdata_q[14] ),
    .B(\mem_rdata_q[12] ),
    .Y(_4329_));
 sky130_fd_sc_hd__nand2_1 _8843_ (.A(\mem_rdata_q[13] ),
    .B(_4329_),
    .Y(_4330_));
 sky130_fd_sc_hd__or4_1 _8844_ (.A(\mem_rdata_q[29] ),
    .B(\mem_rdata_q[28] ),
    .C(\mem_rdata_q[26] ),
    .D(\mem_rdata_q[25] ),
    .X(_4331_));
 sky130_fd_sc_hd__or3_1 _8845_ (.A(\mem_rdata_q[31] ),
    .B(\mem_rdata_q[27] ),
    .C(_4331_),
    .X(_4332_));
 sky130_fd_sc_hd__nor2_1 _8846_ (.A(\mem_rdata_q[30] ),
    .B(_4332_),
    .Y(_4333_));
 sky130_fd_sc_hd__and3_1 _8847_ (.A(net825),
    .B(is_alu_reg_reg),
    .C(net713),
    .X(_4334_));
 sky130_fd_sc_hd__nand2_1 _8848_ (.A(_4333_),
    .B(_4334_),
    .Y(_4335_));
 sky130_fd_sc_hd__nor2_1 _8849_ (.A(net824),
    .B(_0797_),
    .Y(_4336_));
 sky130_fd_sc_hd__nand2_1 _8851_ (.A(instr_slt),
    .B(net694),
    .Y(_4338_));
 sky130_fd_sc_hd__o21ai_0 _8852_ (.A1(_4330_),
    .A2(_4335_),
    .B1(_4338_),
    .Y(_0745_));
 sky130_fd_sc_hd__o21ai_0 _8853_ (.A1(_0850_),
    .A2(decoder_pseudo_trigger),
    .B1(instr_sll),
    .Y(_4339_));
 sky130_fd_sc_hd__nand2b_1 _8854_ (.A_N(\mem_rdata_q[13] ),
    .B(\mem_rdata_q[12] ),
    .Y(_4340_));
 sky130_fd_sc_hd__nand2b_1 _8855_ (.A_N(_4340_),
    .B(_3355_),
    .Y(_4341_));
 sky130_fd_sc_hd__nor3_1 _8856_ (.A(\mem_rdata_q[30] ),
    .B(_4332_),
    .C(_4341_),
    .Y(_4342_));
 sky130_fd_sc_hd__nand3_1 _8857_ (.A(is_alu_reg_reg),
    .B(net712),
    .C(_4342_),
    .Y(_4343_));
 sky130_fd_sc_hd__a21oi_1 _8858_ (.A1(_4339_),
    .A2(_4343_),
    .B1(net823),
    .Y(_0746_));
 sky130_fd_sc_hd__or3_1 _8859_ (.A(\mem_rdata_q[14] ),
    .B(\mem_rdata_q[13] ),
    .C(\mem_rdata_q[12] ),
    .X(_4344_));
 sky130_fd_sc_hd__nor3_1 _8861_ (.A(\mem_rdata_q[31] ),
    .B(\mem_rdata_q[27] ),
    .C(_4331_),
    .Y(_4346_));
 sky130_fd_sc_hd__nand3_1 _8862_ (.A(\mem_rdata_q[30] ),
    .B(_4346_),
    .C(_4334_),
    .Y(_4347_));
 sky130_fd_sc_hd__nand2_1 _8863_ (.A(instr_sub),
    .B(_4336_),
    .Y(_4348_));
 sky130_fd_sc_hd__o21ai_0 _8864_ (.A1(_4344_),
    .A2(_4347_),
    .B1(_4348_),
    .Y(_0747_));
 sky130_fd_sc_hd__nand2_1 _8865_ (.A(instr_add),
    .B(net694),
    .Y(_4349_));
 sky130_fd_sc_hd__o21ai_0 _8866_ (.A1(_4335_),
    .A2(_4344_),
    .B1(_4349_),
    .Y(_0748_));
 sky130_fd_sc_hd__nor2_1 _8867_ (.A(mem_do_prefetch),
    .B(mem_do_rinst),
    .Y(_4350_));
 sky130_fd_sc_hd__nor2_1 _8868_ (.A(mem_do_wdata),
    .B(_4350_),
    .Y(_0749_));
 sky130_fd_sc_hd__nand3_1 _8869_ (.A(net825),
    .B(is_alu_reg_imm),
    .C(net713),
    .Y(_4351_));
 sky130_fd_sc_hd__nand3_1 _8870_ (.A(\mem_rdata_q[14] ),
    .B(\mem_rdata_q[13] ),
    .C(\mem_rdata_q[12] ),
    .Y(_4352_));
 sky130_fd_sc_hd__nand2_1 _8871_ (.A(instr_andi),
    .B(net694),
    .Y(_4353_));
 sky130_fd_sc_hd__o21ai_0 _8872_ (.A1(_4351_),
    .A2(_4352_),
    .B1(_4353_),
    .Y(_0750_));
 sky130_fd_sc_hd__nand3b_1 _8873_ (.A_N(\mem_rdata_q[12] ),
    .B(\mem_rdata_q[13] ),
    .C(\mem_rdata_q[14] ),
    .Y(_4354_));
 sky130_fd_sc_hd__nand2_1 _8874_ (.A(instr_ori),
    .B(_4336_),
    .Y(_4355_));
 sky130_fd_sc_hd__o21ai_0 _8875_ (.A1(_4351_),
    .A2(_4354_),
    .B1(_4355_),
    .Y(_0751_));
 sky130_fd_sc_hd__nor3_1 _8876_ (.A(_3355_),
    .B(\mem_rdata_q[13] ),
    .C(\mem_rdata_q[12] ),
    .Y(_4356_));
 sky130_fd_sc_hd__inv_1 _8877_ (.A(_4356_),
    .Y(_4357_));
 sky130_fd_sc_hd__nand2_1 _8878_ (.A(instr_xori),
    .B(net694),
    .Y(_4358_));
 sky130_fd_sc_hd__o21ai_0 _8879_ (.A1(_4351_),
    .A2(_4357_),
    .B1(_4358_),
    .Y(_0752_));
 sky130_fd_sc_hd__nand3_1 _8880_ (.A(_3355_),
    .B(\mem_rdata_q[13] ),
    .C(\mem_rdata_q[12] ),
    .Y(_4359_));
 sky130_fd_sc_hd__nand2_1 _8881_ (.A(instr_sltiu),
    .B(net694),
    .Y(_4360_));
 sky130_fd_sc_hd__o21ai_0 _8882_ (.A1(_4351_),
    .A2(_4359_),
    .B1(_4360_),
    .Y(_0753_));
 sky130_fd_sc_hd__nand2_1 _8883_ (.A(instr_slti),
    .B(net694),
    .Y(_4361_));
 sky130_fd_sc_hd__o21ai_0 _8884_ (.A1(_4330_),
    .A2(_4351_),
    .B1(_4361_),
    .Y(_0754_));
 sky130_fd_sc_hd__nand2_1 _8885_ (.A(instr_addi),
    .B(net694),
    .Y(_4362_));
 sky130_fd_sc_hd__o21ai_0 _8886_ (.A1(_4344_),
    .A2(_4351_),
    .B1(_4362_),
    .Y(_0755_));
 sky130_fd_sc_hd__nand3_1 _8887_ (.A(is_beq_bne_blt_bge_bltu_bgeu),
    .B(net825),
    .C(net713),
    .Y(_4363_));
 sky130_fd_sc_hd__nand2_1 _8888_ (.A(instr_bgeu),
    .B(net694),
    .Y(_4364_));
 sky130_fd_sc_hd__o21ai_0 _8889_ (.A1(_4352_),
    .A2(_4363_),
    .B1(_4364_),
    .Y(_0756_));
 sky130_fd_sc_hd__nand2_1 _8891_ (.A(instr_bltu),
    .B(net694),
    .Y(_4366_));
 sky130_fd_sc_hd__o21ai_0 _8892_ (.A1(_4354_),
    .A2(_4363_),
    .B1(_4366_),
    .Y(_0757_));
 sky130_fd_sc_hd__or2_2 _8893_ (.A(_3355_),
    .B(_4340_),
    .X(_4367_));
 sky130_fd_sc_hd__nand2_1 _8894_ (.A(instr_bge),
    .B(_4336_),
    .Y(_4368_));
 sky130_fd_sc_hd__o21ai_0 _8895_ (.A1(_4363_),
    .A2(_4367_),
    .B1(_4368_),
    .Y(_0758_));
 sky130_fd_sc_hd__nand2_1 _8896_ (.A(instr_blt),
    .B(net694),
    .Y(_4369_));
 sky130_fd_sc_hd__o21ai_0 _8897_ (.A1(_4357_),
    .A2(_4363_),
    .B1(_4369_),
    .Y(_0759_));
 sky130_fd_sc_hd__nand2_1 _8898_ (.A(instr_bne),
    .B(_4336_),
    .Y(_4370_));
 sky130_fd_sc_hd__o21ai_0 _8899_ (.A1(_4341_),
    .A2(_4363_),
    .B1(_4370_),
    .Y(_0760_));
 sky130_fd_sc_hd__mux2i_1 _8900_ (.A0(\reg_out[31] ),
    .A1(\alu_out_q[31] ),
    .S(latched_stalu),
    .Y(_4371_));
 sky130_fd_sc_hd__nand2_1 _8901_ (.A(\reg_next_pc[31] ),
    .B(net732),
    .Y(_4372_));
 sky130_fd_sc_hd__o21a_1 _8902_ (.A1(net732),
    .A2(_4371_),
    .B1(_4372_),
    .X(_4373_));
 sky130_fd_sc_hd__nand2_1 _8903_ (.A(\reg_pc[31] ),
    .B(net714),
    .Y(_4374_));
 sky130_fd_sc_hd__o21ai_0 _8904_ (.A1(_4092_),
    .A2(_4373_),
    .B1(_4374_),
    .Y(_0761_));
 sky130_fd_sc_hd__and2_1 _8905_ (.A(net779),
    .B(\decoded_rd[4] ),
    .X(_0762_));
 sky130_fd_sc_hd__nand2_1 _8906_ (.A(net825),
    .B(_0860_),
    .Y(_4375_));
 sky130_fd_sc_hd__a21oi_1 _8907_ (.A1(mem_do_prefetch),
    .A2(_4375_),
    .B1(mem_do_rdata),
    .Y(_4376_));
 sky130_fd_sc_hd__mux2i_1 _8908_ (.A0(net779),
    .A1(_4376_),
    .S(\cpu_state[6] ),
    .Y(_4377_));
 sky130_fd_sc_hd__a32oi_1 _8909_ (.A1(instr_lb),
    .A2(\cpu_state[6] ),
    .A3(_4376_),
    .B1(_4377_),
    .B2(latched_is_lb),
    .Y(_4378_));
 sky130_fd_sc_hd__nor2_1 _8910_ (.A(net823),
    .B(_4378_),
    .Y(_0763_));
 sky130_fd_sc_hd__a32oi_1 _8911_ (.A1(instr_lh),
    .A2(\cpu_state[6] ),
    .A3(_4376_),
    .B1(_4377_),
    .B2(latched_is_lh),
    .Y(_4379_));
 sky130_fd_sc_hd__nor2_1 _8912_ (.A(net823),
    .B(_4379_),
    .Y(_0764_));
 sky130_fd_sc_hd__nand3_1 _8913_ (.A(\count_instr[62] ),
    .B(_3533_),
    .C(_3565_),
    .Y(_4380_));
 sky130_fd_sc_hd__xor2_1 _8914_ (.A(\count_instr[63] ),
    .B(_4380_),
    .X(_4381_));
 sky130_fd_sc_hd__nor2_1 _8915_ (.A(net824),
    .B(_4381_),
    .Y(_0765_));
 sky130_fd_sc_hd__nor2_1 _8916_ (.A(is_beq_bne_blt_bge_bltu_bgeu),
    .B(instr_jalr),
    .Y(_4382_));
 sky130_fd_sc_hd__nor2_1 _8917_ (.A(_3021_),
    .B(_4382_),
    .Y(_4383_));
 sky130_fd_sc_hd__o21ai_0 _8918_ (.A1(_3514_),
    .A2(_1494_),
    .B1(_4383_),
    .Y(_4384_));
 sky130_fd_sc_hd__a21oi_1 _8919_ (.A1(_3021_),
    .A2(latched_branch),
    .B1(net778),
    .Y(_4385_));
 sky130_fd_sc_hd__a221oi_1 _8920_ (.A1(net778),
    .A2(_3790_),
    .B1(_4384_),
    .B2(_4385_),
    .C1(net823),
    .Y(_0766_));
 sky130_fd_sc_hd__nand2_1 _8921_ (.A(net778),
    .B(_3021_),
    .Y(_4386_));
 sky130_fd_sc_hd__nor2_1 _8922_ (.A(is_beq_bne_blt_bge_bltu_bgeu),
    .B(_3021_),
    .Y(_4387_));
 sky130_fd_sc_hd__a21oi_1 _8923_ (.A1(latched_stalu),
    .A2(_4386_),
    .B1(_4387_),
    .Y(_4388_));
 sky130_fd_sc_hd__nor2_1 _8924_ (.A(net823),
    .B(_4388_),
    .Y(_0767_));
 sky130_fd_sc_hd__or3_1 _8925_ (.A(net770),
    .B(net769),
    .C(net768),
    .X(_4389_));
 sky130_fd_sc_hd__nor2_1 _8926_ (.A(instr_rdcycle),
    .B(_4389_),
    .Y(_4390_));
 sky130_fd_sc_hd__nor3_1 _8927_ (.A(net779),
    .B(\cpu_state[6] ),
    .C(_3015_),
    .Y(_4391_));
 sky130_fd_sc_hd__a21oi_1 _8928_ (.A1(net777),
    .A2(_4390_),
    .B1(_4391_),
    .Y(_4392_));
 sky130_fd_sc_hd__nand2_1 _8929_ (.A(is_beq_bne_blt_bge_bltu_bgeu),
    .B(net776),
    .Y(_4393_));
 sky130_fd_sc_hd__nand2_1 _8930_ (.A(_4386_),
    .B(_4393_),
    .Y(_4394_));
 sky130_fd_sc_hd__nand3_1 _8931_ (.A(is_beq_bne_blt_bge_bltu_bgeu),
    .B(net776),
    .C(_1494_),
    .Y(_4395_));
 sky130_fd_sc_hd__nor2_1 _8932_ (.A(latched_store),
    .B(_4392_),
    .Y(_4396_));
 sky130_fd_sc_hd__a311oi_1 _8933_ (.A1(_4392_),
    .A2(_4394_),
    .A3(_4395_),
    .B1(_4396_),
    .C1(net823),
    .Y(_0768_));
 sky130_fd_sc_hd__nor3_1 _8934_ (.A(mem_do_prefetch),
    .B(_4375_),
    .C(net724),
    .Y(_0769_));
 sky130_fd_sc_hd__nand2_1 _8935_ (.A(mem_do_prefetch),
    .B(net693),
    .Y(_4397_));
 sky130_fd_sc_hd__nand2_1 _8936_ (.A(net825),
    .B(_4397_),
    .Y(_4398_));
 sky130_fd_sc_hd__nor3b_1 _8937_ (.A(_4398_),
    .B(mem_do_wdata),
    .C_N(\cpu_state[5] ),
    .Y(_4399_));
 sky130_fd_sc_hd__a31o_2 _8938_ (.A1(mem_do_wdata),
    .A2(net825),
    .A3(net693),
    .B1(_4399_),
    .X(_0770_));
 sky130_fd_sc_hd__nand2_1 _8939_ (.A(mem_do_prefetch),
    .B(_4375_),
    .Y(_4400_));
 sky130_fd_sc_hd__nor2_1 _8940_ (.A(\cpu_state[5] ),
    .B(\cpu_state[0] ),
    .Y(_4401_));
 sky130_fd_sc_hd__nand4_1 _8941_ (.A(net716),
    .B(net714),
    .C(_4400_),
    .D(_4401_),
    .Y(_4402_));
 sky130_fd_sc_hd__nand3_1 _8942_ (.A(mem_do_rdata),
    .B(net825),
    .C(net693),
    .Y(_4403_));
 sky130_fd_sc_hd__o21ai_0 _8943_ (.A1(mem_do_rdata),
    .A2(_4402_),
    .B1(_4403_),
    .Y(_0771_));
 sky130_fd_sc_hd__inv_1 _8944_ (.A(net777),
    .Y(_4404_));
 sky130_fd_sc_hd__inv_1 _8945_ (.A(is_lb_lh_lw_lbu_lhu),
    .Y(_4405_));
 sky130_fd_sc_hd__nor2_1 _8946_ (.A(instr_sll),
    .B(instr_slli),
    .Y(_4406_));
 sky130_fd_sc_hd__nor4_1 _8947_ (.A(instr_fence),
    .B(instr_blt),
    .C(instr_sub),
    .D(instr_jalr),
    .Y(_4407_));
 sky130_fd_sc_hd__nor4_1 _8948_ (.A(instr_beq),
    .B(instr_bltu),
    .C(instr_addi),
    .D(instr_add),
    .Y(_4408_));
 sky130_fd_sc_hd__nand4_1 _8949_ (.A(net720),
    .B(_4406_),
    .C(_4407_),
    .D(_4408_),
    .Y(_4409_));
 sky130_fd_sc_hd__nor3_1 _8950_ (.A(instr_bne),
    .B(instr_bge),
    .C(instr_bgeu),
    .Y(_4410_));
 sky130_fd_sc_hd__nor3_1 _8951_ (.A(instr_sb),
    .B(instr_sw),
    .C(instr_sh),
    .Y(_4411_));
 sky130_fd_sc_hd__nor2_1 _8952_ (.A(net772),
    .B(_3497_),
    .Y(_4412_));
 sky130_fd_sc_hd__nor4_1 _8953_ (.A(instr_sltu),
    .B(instr_slti),
    .C(instr_sltiu),
    .D(instr_slt),
    .Y(_4413_));
 sky130_fd_sc_hd__nand4_1 _8954_ (.A(_4410_),
    .B(_4411_),
    .C(_4412_),
    .D(_4413_),
    .Y(_4414_));
 sky130_fd_sc_hd__or4_1 _8955_ (.A(instr_lh),
    .B(instr_lb),
    .C(instr_lbu),
    .D(instr_lhu),
    .X(_4415_));
 sky130_fd_sc_hd__nor2_1 _8956_ (.A(instr_lw),
    .B(_4415_),
    .Y(_4416_));
 sky130_fd_sc_hd__nand3_1 _8957_ (.A(_1002_),
    .B(_4390_),
    .C(_4416_),
    .Y(_4417_));
 sky130_fd_sc_hd__nor3_1 _8958_ (.A(_4409_),
    .B(_4414_),
    .C(_4417_),
    .Y(_4418_));
 sky130_fd_sc_hd__nor2_1 _8959_ (.A(_4405_),
    .B(_4418_),
    .Y(_4419_));
 sky130_fd_sc_hd__a21oi_1 _8960_ (.A1(is_sb_sh_sw),
    .A2(_2481_),
    .B1(_4419_),
    .Y(_4420_));
 sky130_fd_sc_hd__o21ai_0 _8961_ (.A1(net715),
    .A2(net777),
    .B1(mem_do_prefetch),
    .Y(_4421_));
 sky130_fd_sc_hd__nand2_1 _8962_ (.A(net779),
    .B(_3889_),
    .Y(_4422_));
 sky130_fd_sc_hd__o211ai_1 _8963_ (.A1(_4404_),
    .A2(_4420_),
    .B1(_4421_),
    .C1(_4422_),
    .Y(_4423_));
 sky130_fd_sc_hd__nand3b_1 _8964_ (.A_N(\reg_sh[4] ),
    .B(_0117_),
    .C(_0098_),
    .Y(_4424_));
 sky130_fd_sc_hd__nor2_1 _8965_ (.A(is_slli_srli_srai),
    .B(_4418_),
    .Y(_4425_));
 sky130_fd_sc_hd__nor2_1 _8966_ (.A(is_lb_lh_lw_lbu_lhu),
    .B(net718),
    .Y(_4426_));
 sky130_fd_sc_hd__nand2_1 _8967_ (.A(is_sll_srl_sra),
    .B(_4426_),
    .Y(_4427_));
 sky130_fd_sc_hd__nand3_1 _8968_ (.A(_4390_),
    .B(_4425_),
    .C(_4427_),
    .Y(_4428_));
 sky130_fd_sc_hd__nor3_1 _8969_ (.A(net779),
    .B(\cpu_state[4] ),
    .C(net777),
    .Y(_4429_));
 sky130_fd_sc_hd__a221oi_1 _8970_ (.A1(\cpu_state[4] ),
    .A2(_4424_),
    .B1(_4428_),
    .B2(net777),
    .C1(_4429_),
    .Y(_4430_));
 sky130_fd_sc_hd__mux2_2 _8971_ (.A0(mem_do_rinst),
    .A1(_4423_),
    .S(_4430_),
    .X(_4431_));
 sky130_fd_sc_hd__nand2_1 _8972_ (.A(net693),
    .B(_4431_),
    .Y(_4432_));
 sky130_fd_sc_hd__a21oi_1 _8973_ (.A1(_4395_),
    .A2(_4432_),
    .B1(net823),
    .Y(_0772_));
 sky130_fd_sc_hd__nor2_1 _8974_ (.A(_3889_),
    .B(_4092_),
    .Y(_4433_));
 sky130_fd_sc_hd__nor2_1 _8975_ (.A(mem_do_prefetch),
    .B(_4433_),
    .Y(_4434_));
 sky130_fd_sc_hd__a2111oi_0 _8976_ (.A1(instr_jalr),
    .A2(_4433_),
    .B1(_4434_),
    .C1(net824),
    .D1(_0860_),
    .Y(_0773_));
 sky130_fd_sc_hd__mux2_2 _8977_ (.A0(\mem_rdata_latched[19] ),
    .A1(\decoded_imm_j[19] ),
    .S(_0861_),
    .X(_0518_));
 sky130_fd_sc_hd__mux2_2 _8978_ (.A0(\mem_rdata_latched[24] ),
    .A1(\decoded_imm_j[4] ),
    .S(_0861_),
    .X(_0523_));
 sky130_fd_sc_hd__nor3b_1 _8979_ (.A(_4398_),
    .B(mem_do_rdata),
    .C_N(\cpu_state[6] ),
    .Y(_4435_));
 sky130_fd_sc_hd__a221oi_1 _8980_ (.A1(instr_sw),
    .A2(_4399_),
    .B1(_4435_),
    .B2(instr_lw),
    .C1(net704),
    .Y(_4436_));
 sky130_fd_sc_hd__a221oi_1 _8981_ (.A1(mem_do_wdata),
    .A2(\cpu_state[5] ),
    .B1(\cpu_state[6] ),
    .B2(mem_do_rdata),
    .C1(net824),
    .Y(_4437_));
 sky130_fd_sc_hd__a21boi_0 _8982_ (.A1(net715),
    .A2(_1613_),
    .B1_N(_4437_),
    .Y(_4438_));
 sky130_fd_sc_hd__o21ai_0 _8983_ (.A1(_1613_),
    .A2(_4397_),
    .B1(_4438_),
    .Y(_4439_));
 sky130_fd_sc_hd__a221o_1 _8984_ (.A1(_4399_),
    .A2(_4411_),
    .B1(_4416_),
    .B2(_4435_),
    .C1(_4439_),
    .X(_4440_));
 sky130_fd_sc_hd__nand2_1 _8985_ (.A(\mem_wordsize[0] ),
    .B(_4440_),
    .Y(_4441_));
 sky130_fd_sc_hd__nand2_1 _8986_ (.A(_4436_),
    .B(_4441_),
    .Y(_0493_));
 sky130_fd_sc_hd__o21a_1 _8987_ (.A1(instr_lb),
    .A2(instr_lbu),
    .B1(_4435_),
    .X(_4442_));
 sky130_fd_sc_hd__a221o_1 _8988_ (.A1(instr_sb),
    .A2(_4399_),
    .B1(_4440_),
    .B2(\mem_wordsize[1] ),
    .C1(_4442_),
    .X(_0494_));
 sky130_fd_sc_hd__o21a_1 _8989_ (.A1(instr_lh),
    .A2(instr_lhu),
    .B1(_4435_),
    .X(_4443_));
 sky130_fd_sc_hd__a221o_1 _8990_ (.A1(instr_sh),
    .A2(_4399_),
    .B1(_4440_),
    .B2(net765),
    .C1(_4443_),
    .X(_0495_));
 sky130_fd_sc_hd__inv_1 _8991_ (.A(\cpu_state[0] ),
    .Y(_4444_));
 sky130_fd_sc_hd__nand2_1 _8992_ (.A(net777),
    .B(_4418_),
    .Y(_4445_));
 sky130_fd_sc_hd__o21ai_0 _8993_ (.A1(net765),
    .A2(\mem_wordsize[0] ),
    .B1(net764),
    .Y(_4446_));
 sky130_fd_sc_hd__nand2_1 _8994_ (.A(net753),
    .B(\mem_wordsize[0] ),
    .Y(_4447_));
 sky130_fd_sc_hd__a21oi_1 _8995_ (.A1(_4446_),
    .A2(_4447_),
    .B1(_0857_),
    .Y(_4448_));
 sky130_fd_sc_hd__a21oi_1 _8996_ (.A1(mem_do_rinst),
    .A2(\reg_pc[1] ),
    .B1(_4448_),
    .Y(_4449_));
 sky130_fd_sc_hd__a31oi_1 _8997_ (.A1(_4444_),
    .A2(_4445_),
    .A3(_4449_),
    .B1(net823),
    .Y(_0496_));
 sky130_fd_sc_hd__o21ai_0 _8998_ (.A1(instr_rdcycle),
    .A2(_4389_),
    .B1(net777),
    .Y(_4450_));
 sky130_fd_sc_hd__nand4b_1 _8999_ (.A_N(\reg_sh[4] ),
    .B(_0117_),
    .C(_0098_),
    .D(net775),
    .Y(_4451_));
 sky130_fd_sc_hd__a21oi_1 _9000_ (.A1(_3889_),
    .A2(net704),
    .B1(_4387_),
    .Y(_4452_));
 sky130_fd_sc_hd__o2111ai_1 _9001_ (.A1(net693),
    .A2(_4393_),
    .B1(_4450_),
    .C1(_4451_),
    .D1(_4452_),
    .Y(_4453_));
 sky130_fd_sc_hd__o21ai_0 _9002_ (.A1(_0769_),
    .A2(_4453_),
    .B1(_4449_),
    .Y(_4454_));
 sky130_fd_sc_hd__nand2_1 _9003_ (.A(net825),
    .B(_4454_),
    .Y(_0497_));
 sky130_fd_sc_hd__and2_1 _9004_ (.A(_4433_),
    .B(_4449_),
    .X(_0498_));
 sky130_fd_sc_hd__nand2_1 _9005_ (.A(net825),
    .B(_4449_),
    .Y(_4455_));
 sky130_fd_sc_hd__nand3_1 _9006_ (.A(net777),
    .B(_4390_),
    .C(_4426_),
    .Y(_4456_));
 sky130_fd_sc_hd__or4_1 _9007_ (.A(is_slli_srli_srai),
    .B(_4418_),
    .C(_4455_),
    .D(_4456_),
    .X(_4457_));
 sky130_fd_sc_hd__a32oi_1 _9008_ (.A1(is_beq_bne_blt_bge_bltu_bgeu),
    .A2(net776),
    .A3(net693),
    .B1(net718),
    .B2(net777),
    .Y(_4458_));
 sky130_fd_sc_hd__o32ai_1 _9009_ (.A1(is_sb_sh_sw),
    .A2(is_sll_srl_sra),
    .A3(_4457_),
    .B1(_4458_),
    .B2(_4455_),
    .Y(_0499_));
 sky130_fd_sc_hd__inv_1 _9010_ (.A(is_sll_srl_sra),
    .Y(_4459_));
 sky130_fd_sc_hd__a22oi_1 _9011_ (.A1(net777),
    .A2(is_slli_srli_srai),
    .B1(_4424_),
    .B2(\cpu_state[4] ),
    .Y(_4460_));
 sky130_fd_sc_hd__o22ai_1 _9012_ (.A1(_4459_),
    .A2(_4457_),
    .B1(_4460_),
    .B2(_4455_),
    .Y(_0500_));
 sky130_fd_sc_hd__o21ai_0 _9013_ (.A1(mem_do_prefetch),
    .A2(net693),
    .B1(\cpu_state[5] ),
    .Y(_4461_));
 sky130_fd_sc_hd__o22ai_1 _9014_ (.A1(_3515_),
    .A2(_4457_),
    .B1(_4461_),
    .B2(_4455_),
    .Y(_0501_));
 sky130_fd_sc_hd__o21ai_0 _9015_ (.A1(mem_do_prefetch),
    .A2(net693),
    .B1(\cpu_state[6] ),
    .Y(_4462_));
 sky130_fd_sc_hd__nand2_1 _9016_ (.A(net777),
    .B(_4419_),
    .Y(_4463_));
 sky130_fd_sc_hd__a21oi_1 _9017_ (.A1(_4462_),
    .A2(_4463_),
    .B1(_4455_),
    .Y(_0502_));
 sky130_fd_sc_hd__nor2b_1 _9018_ (.A(mem_do_rinst),
    .B_N(_0491_),
    .Y(_4464_));
 sky130_fd_sc_hd__and2_1 _9019_ (.A(_0487_),
    .B(_0513_),
    .X(_0780_));
 sky130_fd_sc_hd__and3_1 _9020_ (.A(_0857_),
    .B(_4350_),
    .C(_0780_),
    .X(_4465_));
 sky130_fd_sc_hd__o21ai_0 _9021_ (.A1(_0490_),
    .A2(_0489_),
    .B1(net733),
    .Y(_4466_));
 sky130_fd_sc_hd__o41ai_1 _9022_ (.A1(_0487_),
    .A2(_0491_),
    .A3(_0490_),
    .A4(_0489_),
    .B1(_4466_),
    .Y(_4467_));
 sky130_fd_sc_hd__o41ai_1 _9023_ (.A1(net364),
    .A2(_4464_),
    .A3(_4465_),
    .A4(_4467_),
    .B1(net825),
    .Y(_0504_));
 sky130_fd_sc_hd__nor2_4 _9024_ (.A(net364),
    .B(_0982_),
    .Y(_0505_));
 sky130_fd_sc_hd__and2_1 _9025_ (.A(net825),
    .B(_0988_),
    .X(net233));
 sky130_fd_sc_hd__o21a_1 _9026_ (.A1(net266),
    .A2(net233),
    .B1(_0513_),
    .X(_0506_));
 sky130_fd_sc_hd__nor2_1 _9027_ (.A(_0488_),
    .B(net364),
    .Y(_4468_));
 sky130_fd_sc_hd__o21bai_1 _9028_ (.A1(_3356_),
    .A2(_4468_),
    .B1_N(_0491_),
    .Y(_4469_));
 sky130_fd_sc_hd__nand2_1 _9029_ (.A(net170),
    .B(net364),
    .Y(_4470_));
 sky130_fd_sc_hd__a31oi_1 _9030_ (.A1(net825),
    .A2(_4469_),
    .A3(_4470_),
    .B1(_4465_),
    .Y(_0507_));
 sky130_fd_sc_hd__inv_1 _9031_ (.A(net752),
    .Y(_0316_));
 sky130_fd_sc_hd__nor2_8 _9032_ (.A(_4404_),
    .B(net823),
    .Y(_0508_));
 sky130_fd_sc_hd__o21a_1 _9033_ (.A1(net266),
    .A2(net233),
    .B1(_0513_),
    .X(_0509_));
 sky130_fd_sc_hd__a21oi_1 _9034_ (.A1(_4386_),
    .A2(_4393_),
    .B1(net823),
    .Y(_0510_));
 sky130_fd_sc_hd__nand2_1 _9035_ (.A(_1670_),
    .B(_4406_),
    .Y(_4471_));
 sky130_fd_sc_hd__nand2_1 _9036_ (.A(net723),
    .B(_4471_),
    .Y(_4472_));
 sky130_fd_sc_hd__nand3_1 _9037_ (.A(mem_do_prefetch),
    .B(_4375_),
    .C(net721),
    .Y(_4473_));
 sky130_fd_sc_hd__o2111ai_1 _9038_ (.A1(net777),
    .A2(net719),
    .B1(_4437_),
    .C1(_4451_),
    .D1(_4473_),
    .Y(_4474_));
 sky130_fd_sc_hd__a21oi_1 _9039_ (.A1(net775),
    .A2(_4472_),
    .B1(_4474_),
    .Y(_0511_));
 sky130_fd_sc_hd__a31oi_4 _9040_ (.A1(net775),
    .A2(net720),
    .A3(_4406_),
    .B1(_4474_),
    .Y(_0512_));
 sky130_fd_sc_hd__nand2_1 _9041_ (.A(instr_beq),
    .B(net694),
    .Y(_4475_));
 sky130_fd_sc_hd__o21ai_0 _9042_ (.A1(_4344_),
    .A2(_4363_),
    .B1(_4475_),
    .Y(_0774_));
 sky130_fd_sc_hd__nor2_1 _9043_ (.A(_4444_),
    .B(net824),
    .Y(_0775_));
 sky130_fd_sc_hd__nand3_1 _9044_ (.A(\count_cycle[62] ),
    .B(_4096_),
    .C(_4134_),
    .Y(_4476_));
 sky130_fd_sc_hd__xor2_1 _9045_ (.A(\count_cycle[63] ),
    .B(_4476_),
    .X(_4477_));
 sky130_fd_sc_hd__nor2_1 _9046_ (.A(net824),
    .B(_4477_),
    .Y(_0776_));
 sky130_fd_sc_hd__nand2_1 _9047_ (.A(\mem_rdata_q[3] ),
    .B(\mem_rdata_q[2] ),
    .Y(_4478_));
 sky130_fd_sc_hd__nor2_1 _9048_ (.A(\mem_rdata_q[6] ),
    .B(\mem_rdata_q[5] ),
    .Y(_4479_));
 sky130_fd_sc_hd__nand3_1 _9049_ (.A(\mem_rdata_q[1] ),
    .B(\mem_rdata_q[0] ),
    .C(_4479_),
    .Y(_4480_));
 sky130_fd_sc_hd__nor4_1 _9050_ (.A(\mem_rdata_q[4] ),
    .B(_4344_),
    .C(_4478_),
    .D(_4480_),
    .Y(_4481_));
 sky130_fd_sc_hd__mux2i_1 _9051_ (.A0(instr_fence),
    .A1(_4481_),
    .S(net713),
    .Y(_4482_));
 sky130_fd_sc_hd__nor2_1 _9052_ (.A(net824),
    .B(_4482_),
    .Y(_0777_));
 sky130_fd_sc_hd__nor3b_1 _9053_ (.A(net733),
    .B(net163),
    .C_N(net160),
    .Y(_4483_));
 sky130_fd_sc_hd__nor3b_1 _9054_ (.A(\mem_rdata_q[3] ),
    .B(_3356_),
    .C_N(\mem_rdata_q[2] ),
    .Y(_4484_));
 sky130_fd_sc_hd__nand2_1 _9055_ (.A(\mem_rdata_q[1] ),
    .B(\mem_rdata_q[0] ),
    .Y(_4485_));
 sky130_fd_sc_hd__nand3_1 _9056_ (.A(net828),
    .B(net138),
    .C(_3356_),
    .Y(_4486_));
 sky130_fd_sc_hd__o21ai_0 _9057_ (.A1(_3356_),
    .A2(_4485_),
    .B1(_4486_),
    .Y(_4487_));
 sky130_fd_sc_hd__o21ai_0 _9058_ (.A1(_4483_),
    .A2(_4484_),
    .B1(_4487_),
    .Y(_4488_));
 sky130_fd_sc_hd__mux2i_1 _9059_ (.A0(net164),
    .A1(\mem_rdata_q[4] ),
    .S(net733),
    .Y(_4489_));
 sky130_fd_sc_hd__nand3b_1 _9060_ (.A_N(net166),
    .B(net165),
    .C(_3356_),
    .Y(_4490_));
 sky130_fd_sc_hd__nand3b_1 _9061_ (.A_N(\mem_rdata_q[6] ),
    .B(\mem_rdata_q[5] ),
    .C(net733),
    .Y(_4491_));
 sky130_fd_sc_hd__nand2_1 _9062_ (.A(_4490_),
    .B(_4491_),
    .Y(_4492_));
 sky130_fd_sc_hd__nand2b_1 _9063_ (.A_N(_4489_),
    .B(_4492_),
    .Y(_4493_));
 sky130_fd_sc_hd__nor2_1 _9064_ (.A(_4488_),
    .B(_4493_),
    .Y(_0790_));
 sky130_fd_sc_hd__nor3_1 _9065_ (.A(net166),
    .B(net165),
    .C(net733),
    .Y(_4494_));
 sky130_fd_sc_hd__a21oi_1 _9066_ (.A1(net733),
    .A2(_4479_),
    .B1(_4494_),
    .Y(_4495_));
 sky130_fd_sc_hd__nor3_1 _9067_ (.A(_4488_),
    .B(_4489_),
    .C(_4495_),
    .Y(_0791_));
 sky130_fd_sc_hd__nand2_1 _9068_ (.A(\mem_rdata_q[6] ),
    .B(\mem_rdata_q[5] ),
    .Y(_4496_));
 sky130_fd_sc_hd__nand3_1 _9069_ (.A(net166),
    .B(net165),
    .C(_3356_),
    .Y(_4497_));
 sky130_fd_sc_hd__o21ai_0 _9070_ (.A1(net706),
    .A2(_4496_),
    .B1(_4497_),
    .Y(_4498_));
 sky130_fd_sc_hd__nand2_1 _9071_ (.A(_4489_),
    .B(_4498_),
    .Y(_4499_));
 sky130_fd_sc_hd__nand3_1 _9072_ (.A(net163),
    .B(net160),
    .C(_3356_),
    .Y(_4500_));
 sky130_fd_sc_hd__o21ai_0 _9073_ (.A1(_3356_),
    .A2(_4478_),
    .B1(_4500_),
    .Y(_4501_));
 sky130_fd_sc_hd__nand2_1 _9074_ (.A(_4487_),
    .B(_4501_),
    .Y(_4502_));
 sky130_fd_sc_hd__nor2_1 _9075_ (.A(_4499_),
    .B(_4502_),
    .Y(_0792_));
 sky130_fd_sc_hd__nor3_1 _9076_ (.A(\mem_rdata_q[3] ),
    .B(\mem_rdata_q[2] ),
    .C(_3356_),
    .Y(_4503_));
 sky130_fd_sc_hd__nor3_1 _9077_ (.A(net163),
    .B(net160),
    .C(net733),
    .Y(_4504_));
 sky130_fd_sc_hd__o21ai_0 _9078_ (.A1(_4503_),
    .A2(_4504_),
    .B1(_4487_),
    .Y(_4505_));
 sky130_fd_sc_hd__inv_1 _9079_ (.A(_4505_),
    .Y(_4506_));
 sky130_fd_sc_hd__nand2_1 _9080_ (.A(_4489_),
    .B(_4506_),
    .Y(_4507_));
 sky130_fd_sc_hd__nor2_1 _9081_ (.A(_4495_),
    .B(_4507_),
    .Y(_0793_));
 sky130_fd_sc_hd__and3_1 _9082_ (.A(_4489_),
    .B(_4492_),
    .C(_4506_),
    .X(_0794_));
 sky130_fd_sc_hd__nor3_1 _9083_ (.A(_4489_),
    .B(_4495_),
    .C(_4505_),
    .Y(_0795_));
 sky130_fd_sc_hd__nor2_1 _9084_ (.A(_4493_),
    .B(_4505_),
    .Y(_0796_));
 sky130_fd_sc_hd__nor2_1 _9085_ (.A(_4405_),
    .B(_4344_),
    .Y(_0798_));
 sky130_fd_sc_hd__nor2_1 _9086_ (.A(_4405_),
    .B(_4341_),
    .Y(_0799_));
 sky130_fd_sc_hd__nor2_1 _9087_ (.A(_4405_),
    .B(_4330_),
    .Y(_0800_));
 sky130_fd_sc_hd__nor2_1 _9088_ (.A(_4405_),
    .B(_4357_),
    .Y(_0801_));
 sky130_fd_sc_hd__nor2_1 _9089_ (.A(_4405_),
    .B(_4367_),
    .Y(_0802_));
 sky130_fd_sc_hd__nor2_1 _9090_ (.A(_3515_),
    .B(_4344_),
    .Y(_0803_));
 sky130_fd_sc_hd__nor2_1 _9091_ (.A(_3515_),
    .B(_4341_),
    .Y(_0804_));
 sky130_fd_sc_hd__nor2_1 _9092_ (.A(_3515_),
    .B(_4330_),
    .Y(_0805_));
 sky130_fd_sc_hd__and2_1 _9093_ (.A(is_alu_reg_imm),
    .B(_4342_),
    .X(_0806_));
 sky130_fd_sc_hd__nor2_1 _9094_ (.A(_3355_),
    .B(_4340_),
    .Y(_4508_));
 sky130_fd_sc_hd__and3_1 _9095_ (.A(is_alu_reg_imm),
    .B(_4333_),
    .C(_4508_),
    .X(_0807_));
 sky130_fd_sc_hd__and4_1 _9096_ (.A(\mem_rdata_q[30] ),
    .B(is_alu_reg_imm),
    .C(_4346_),
    .D(_4508_),
    .X(_0808_));
 sky130_fd_sc_hd__nand3b_1 _9097_ (.A_N(\mem_rdata_q[24] ),
    .B(\mem_rdata_q[30] ),
    .C(\mem_rdata_q[31] ),
    .Y(_4509_));
 sky130_fd_sc_hd__nor4_1 _9098_ (.A(\mem_rdata_q[19] ),
    .B(\mem_rdata_q[18] ),
    .C(\mem_rdata_q[17] ),
    .D(\mem_rdata_q[15] ),
    .Y(_4510_));
 sky130_fd_sc_hd__nor4b_1 _9099_ (.A(\mem_rdata_q[23] ),
    .B(\mem_rdata_q[22] ),
    .C(\mem_rdata_q[16] ),
    .D_N(\mem_rdata_q[4] ),
    .Y(_4511_));
 sky130_fd_sc_hd__nor4_1 _9100_ (.A(\mem_rdata_q[3] ),
    .B(\mem_rdata_q[2] ),
    .C(_4485_),
    .D(_4496_),
    .Y(_4512_));
 sky130_fd_sc_hd__nand3_1 _9101_ (.A(_4510_),
    .B(_4511_),
    .C(_4512_),
    .Y(_4513_));
 sky130_fd_sc_hd__or4_1 _9102_ (.A(_4330_),
    .B(_4331_),
    .C(_4509_),
    .D(_4513_),
    .X(_4514_));
 sky130_fd_sc_hd__nor4b_1 _9103_ (.A(\mem_rdata_q[27] ),
    .B(\mem_rdata_q[20] ),
    .C(_4514_),
    .D_N(\mem_rdata_q[21] ),
    .Y(_0811_));
 sky130_fd_sc_hd__nor4bb_1 _9104_ (.A(\mem_rdata_q[20] ),
    .B(_4514_),
    .C_N(\mem_rdata_q[27] ),
    .D_N(\mem_rdata_q[21] ),
    .Y(_0812_));
 sky130_fd_sc_hd__a211oi_1 _9105_ (.A1(\mem_rdata_q[30] ),
    .A2(_3355_),
    .B1(_4332_),
    .C1(_4340_),
    .Y(_4515_));
 sky130_fd_sc_hd__and2_1 _9106_ (.A(is_alu_reg_imm),
    .B(_4515_),
    .X(_0813_));
 sky130_fd_sc_hd__and2_1 _9107_ (.A(is_alu_reg_reg),
    .B(_4515_),
    .X(_0814_));
 sky130_fd_sc_hd__nor3_1 _9108_ (.A(\mem_rdata_latched[14] ),
    .B(\mem_rdata_latched[12] ),
    .C(\mem_rdata_latched[13] ),
    .Y(_4516_));
 sky130_fd_sc_hd__nor3b_1 _9109_ (.A(_4488_),
    .B(_4499_),
    .C_N(_4516_),
    .Y(_0816_));
 sky130_fd_sc_hd__nor3_1 _9110_ (.A(\mem_rdata_q[27] ),
    .B(\mem_rdata_q[21] ),
    .C(_4514_),
    .Y(_0809_));
 sky130_fd_sc_hd__nor3b_1 _9111_ (.A(\mem_rdata_q[21] ),
    .B(_4514_),
    .C_N(\mem_rdata_q[27] ),
    .Y(_0810_));
 sky130_fd_sc_hd__a21o_1 _9112_ (.A1(is_alu_reg_imm),
    .A2(_4340_),
    .B1(instr_jalr),
    .X(_0817_));
 sky130_fd_sc_hd__nand2_1 _9113_ (.A(instr_xor),
    .B(net694),
    .Y(_4517_));
 sky130_fd_sc_hd__o21ai_0 _9114_ (.A1(_4335_),
    .A2(_4357_),
    .B1(_4517_),
    .Y(_0778_));
 sky130_fd_sc_hd__o21ai_0 _9115_ (.A1(_0061_),
    .A2(_0980_),
    .B1(_0945_),
    .Y(net270));
 sky130_fd_sc_hd__o22a_1 _9116_ (.A1(net721),
    .A2(_4395_),
    .B1(_0769_),
    .B2(net653),
    .X(_0000_));
 sky130_fd_sc_hd__a222oi_1 _9117_ (.A1(\count_cycle[63] ),
    .A2(net770),
    .B1(net769),
    .B2(\count_instr[31] ),
    .C1(\count_instr[63] ),
    .C2(net768),
    .Y(_4518_));
 sky130_fd_sc_hd__nand2_1 _9118_ (.A(\count_cycle[31] ),
    .B(net717),
    .Y(_4519_));
 sky130_fd_sc_hd__a21oi_1 _9119_ (.A1(_4518_),
    .A2(_4519_),
    .B1(_4404_),
    .Y(_4520_));
 sky130_fd_sc_hd__a211oi_1 _9120_ (.A1(net741),
    .A2(net775),
    .B1(net716),
    .C1(_4520_),
    .Y(_4521_));
 sky130_fd_sc_hd__nor2_1 _9121_ (.A(_0455_),
    .B(_0463_),
    .Y(_4522_));
 sky130_fd_sc_hd__o21a_1 _9122_ (.A1(_0456_),
    .A2(_0455_),
    .B1(_0464_),
    .X(_4523_));
 sky130_fd_sc_hd__nor2_1 _9123_ (.A(_0463_),
    .B(_4523_),
    .Y(_4524_));
 sky130_fd_sc_hd__a21oi_1 _9124_ (.A1(_3058_),
    .A2(_4522_),
    .B1(_4524_),
    .Y(_4525_));
 sky130_fd_sc_hd__xor2_1 _9125_ (.A(\reg_pc[31] ),
    .B(\decoded_imm[31] ),
    .X(_4526_));
 sky130_fd_sc_hd__xnor2_1 _9126_ (.A(_4525_),
    .B(_4526_),
    .Y(_4527_));
 sky130_fd_sc_hd__a21oi_1 _9127_ (.A1(net162),
    .A2(_3003_),
    .B1(_3018_),
    .Y(_4528_));
 sky130_fd_sc_hd__and2_1 _9128_ (.A(_3021_),
    .B(_4521_),
    .X(_4529_));
 sky130_fd_sc_hd__a211oi_1 _9129_ (.A1(_4521_),
    .A2(_4527_),
    .B1(_4528_),
    .C1(_4529_),
    .Y(_0028_));
 sky130_fd_sc_hd__nor2_1 _9130_ (.A(is_slli_srli_srai),
    .B(_2859_),
    .Y(_4530_));
 sky130_fd_sc_hd__a21oi_1 _9131_ (.A1(\decoded_imm_j[4] ),
    .A2(is_slli_srli_srai),
    .B1(_4530_),
    .Y(_4531_));
 sky130_fd_sc_hd__xnor2_1 _9132_ (.A(\reg_sh[4] ),
    .B(_0098_),
    .Y(_4532_));
 sky130_fd_sc_hd__a21oi_1 _9133_ (.A1(_0100_),
    .A2(_2923_),
    .B1(_4532_),
    .Y(_4533_));
 sky130_fd_sc_hd__nand2_1 _9134_ (.A(net775),
    .B(_4533_),
    .Y(_4534_));
 sky130_fd_sc_hd__o21ai_0 _9135_ (.A1(net775),
    .A2(_4531_),
    .B1(_4534_),
    .Y(_0040_));
 sky130_fd_sc_hd__mux4_2 _9136_ (.A0(\cpuregs[0][31] ),
    .A1(\cpuregs[1][31] ),
    .A2(\cpuregs[2][31] ),
    .A3(\cpuregs[3][31] ),
    .S0(net794),
    .S1(net790),
    .X(_4535_));
 sky130_fd_sc_hd__mux4_2 _9137_ (.A0(\cpuregs[8][31] ),
    .A1(\cpuregs[9][31] ),
    .A2(\cpuregs[10][31] ),
    .A3(\cpuregs[11][31] ),
    .S0(net796),
    .S1(net790),
    .X(_4536_));
 sky130_fd_sc_hd__mux4_2 _9138_ (.A0(\cpuregs[4][31] ),
    .A1(\cpuregs[5][31] ),
    .A2(\cpuregs[6][31] ),
    .A3(\cpuregs[7][31] ),
    .S0(net794),
    .S1(net791),
    .X(_4537_));
 sky130_fd_sc_hd__mux4_2 _9139_ (.A0(\cpuregs[12][31] ),
    .A1(\cpuregs[13][31] ),
    .A2(\cpuregs[14][31] ),
    .A3(\cpuregs[15][31] ),
    .S0(net796),
    .S1(net790),
    .X(_4538_));
 sky130_fd_sc_hd__mux4_2 _9140_ (.A0(_4535_),
    .A1(_4536_),
    .A2(_4537_),
    .A3(_4538_),
    .S0(net782),
    .S1(net784),
    .X(_4539_));
 sky130_fd_sc_hd__mux4_2 _9141_ (.A0(\cpuregs[16][31] ),
    .A1(\cpuregs[17][31] ),
    .A2(\cpuregs[18][31] ),
    .A3(\cpuregs[19][31] ),
    .S0(net794),
    .S1(net790),
    .X(_4540_));
 sky130_fd_sc_hd__mux4_2 _9142_ (.A0(\cpuregs[24][31] ),
    .A1(\cpuregs[25][31] ),
    .A2(\cpuregs[26][31] ),
    .A3(\cpuregs[27][31] ),
    .S0(net796),
    .S1(net790),
    .X(_4541_));
 sky130_fd_sc_hd__mux4_2 _9143_ (.A0(\cpuregs[20][31] ),
    .A1(\cpuregs[21][31] ),
    .A2(\cpuregs[22][31] ),
    .A3(\cpuregs[23][31] ),
    .S0(net794),
    .S1(net791),
    .X(_4542_));
 sky130_fd_sc_hd__mux4_2 _9144_ (.A0(\cpuregs[28][31] ),
    .A1(\cpuregs[29][31] ),
    .A2(\cpuregs[30][31] ),
    .A3(\cpuregs[31][31] ),
    .S0(net794),
    .S1(net790),
    .X(_4543_));
 sky130_fd_sc_hd__mux4_2 _9145_ (.A0(_4540_),
    .A1(_4541_),
    .A2(_4542_),
    .A3(_4543_),
    .S0(net782),
    .S1(net784),
    .X(_4544_));
 sky130_fd_sc_hd__mux2i_1 _9146_ (.A0(_4539_),
    .A1(_4544_),
    .S(net780),
    .Y(_4545_));
 sky130_fd_sc_hd__nand2_1 _9147_ (.A(\decoded_imm[31] ),
    .B(net718),
    .Y(_4546_));
 sky130_fd_sc_hd__o21ai_0 _9148_ (.A1(_2485_),
    .A2(_4545_),
    .B1(_4546_),
    .Y(_4641_));
 sky130_fd_sc_hd__o32ai_1 _9149_ (.A1(_0487_),
    .A2(_3496_),
    .A3(_4304_),
    .B1(net364),
    .B2(_0982_),
    .Y(_0779_));
 sky130_fd_sc_hd__nand2_1 _9150_ (.A(_0127_),
    .B(net721),
    .Y(_4547_));
 sky130_fd_sc_hd__xor2_1 _9151_ (.A(net741),
    .B(\decoded_imm[31] ),
    .X(_4548_));
 sky130_fd_sc_hd__nor2_1 _9152_ (.A(_4547_),
    .B(_4548_),
    .Y(_4549_));
 sky130_fd_sc_hd__a21o_1 _9153_ (.A1(_0133_),
    .A2(_0130_),
    .B1(_0132_),
    .X(_4550_));
 sky130_fd_sc_hd__a21o_1 _9154_ (.A1(_0129_),
    .A2(_4550_),
    .B1(_0128_),
    .X(_4551_));
 sky130_fd_sc_hd__nor4b_1 _9155_ (.A(_0126_),
    .B(net724),
    .C(_4551_),
    .D_N(_4548_),
    .Y(_4552_));
 sky130_fd_sc_hd__nand2_1 _9156_ (.A(_1663_),
    .B(_1757_),
    .Y(_4553_));
 sky130_fd_sc_hd__mux2i_1 _9157_ (.A0(_4549_),
    .A1(_4552_),
    .S(_4553_),
    .Y(_4554_));
 sky130_fd_sc_hd__mux4_2 _9158_ (.A0(\cpuregs[0][31] ),
    .A1(\cpuregs[1][31] ),
    .A2(\cpuregs[2][31] ),
    .A3(\cpuregs[3][31] ),
    .S0(net813),
    .S1(net812),
    .X(_4555_));
 sky130_fd_sc_hd__mux4_2 _9159_ (.A0(\cpuregs[4][31] ),
    .A1(\cpuregs[5][31] ),
    .A2(\cpuregs[6][31] ),
    .A3(\cpuregs[7][31] ),
    .S0(net813),
    .S1(net812),
    .X(_4556_));
 sky130_fd_sc_hd__mux4_2 _9160_ (.A0(\cpuregs[16][31] ),
    .A1(\cpuregs[17][31] ),
    .A2(\cpuregs[18][31] ),
    .A3(\cpuregs[19][31] ),
    .S0(net813),
    .S1(net812),
    .X(_4557_));
 sky130_fd_sc_hd__mux4_2 _9161_ (.A0(\cpuregs[20][31] ),
    .A1(\cpuregs[21][31] ),
    .A2(\cpuregs[22][31] ),
    .A3(\cpuregs[23][31] ),
    .S0(net813),
    .S1(net812),
    .X(_4558_));
 sky130_fd_sc_hd__mux4_2 _9162_ (.A0(_4555_),
    .A1(_4556_),
    .A2(_4557_),
    .A3(_4558_),
    .S0(net803),
    .S1(net801),
    .X(_4559_));
 sky130_fd_sc_hd__mux4_2 _9163_ (.A0(\cpuregs[8][31] ),
    .A1(\cpuregs[9][31] ),
    .A2(\cpuregs[10][31] ),
    .A3(\cpuregs[11][31] ),
    .S0(net820),
    .S1(net807),
    .X(_4560_));
 sky130_fd_sc_hd__mux4_2 _9164_ (.A0(\cpuregs[12][31] ),
    .A1(\cpuregs[13][31] ),
    .A2(\cpuregs[14][31] ),
    .A3(\cpuregs[15][31] ),
    .S0(net816),
    .S1(net807),
    .X(_4561_));
 sky130_fd_sc_hd__mux4_2 _9165_ (.A0(\cpuregs[24][31] ),
    .A1(\cpuregs[25][31] ),
    .A2(\cpuregs[26][31] ),
    .A3(\cpuregs[27][31] ),
    .S0(net816),
    .S1(net807),
    .X(_4562_));
 sky130_fd_sc_hd__mux4_2 _9166_ (.A0(\cpuregs[28][31] ),
    .A1(\cpuregs[29][31] ),
    .A2(\cpuregs[30][31] ),
    .A3(\cpuregs[31][31] ),
    .S0(net813),
    .S1(net806),
    .X(_4563_));
 sky130_fd_sc_hd__mux4_2 _9167_ (.A0(_4560_),
    .A1(_4561_),
    .A2(_4562_),
    .A3(_4563_),
    .S0(net804),
    .S1(net801),
    .X(_4564_));
 sky130_fd_sc_hd__mux2i_1 _9168_ (.A0(_4559_),
    .A1(_4564_),
    .S(net802),
    .Y(_4565_));
 sky130_fd_sc_hd__nand2_1 _9169_ (.A(\reg_pc[31] ),
    .B(net722),
    .Y(_4566_));
 sky130_fd_sc_hd__o21ai_0 _9170_ (.A1(net707),
    .A2(_4565_),
    .B1(_4566_),
    .Y(_4567_));
 sky130_fd_sc_hd__nand2_1 _9171_ (.A(_1725_),
    .B(_4567_),
    .Y(_4568_));
 sky130_fd_sc_hd__nand2_1 _9172_ (.A(net742),
    .B(net696),
    .Y(_4569_));
 sky130_fd_sc_hd__o21ai_0 _9173_ (.A1(_0272_),
    .A2(net696),
    .B1(_4569_),
    .Y(_4570_));
 sky130_fd_sc_hd__nand2b_1 _9174_ (.A_N(_0126_),
    .B(_4548_),
    .Y(_4571_));
 sky130_fd_sc_hd__a21oi_1 _9175_ (.A1(_0127_),
    .A2(_4551_),
    .B1(_0126_),
    .Y(_4572_));
 sky130_fd_sc_hd__o22ai_1 _9176_ (.A1(_0127_),
    .A2(_4571_),
    .B1(_4572_),
    .B2(_4548_),
    .Y(_4573_));
 sky130_fd_sc_hd__a32oi_1 _9177_ (.A1(net774),
    .A2(net720),
    .A3(_4570_),
    .B1(_4573_),
    .B2(net721),
    .Y(_4574_));
 sky130_fd_sc_hd__nand3_1 _9178_ (.A(_4554_),
    .B(_4568_),
    .C(_4574_),
    .Y(_4673_));
 sky130_fd_sc_hd__nand3_1 _9179_ (.A(is_beq_bne_blt_bge_bltu_bgeu),
    .B(net825),
    .C(_0861_),
    .Y(_4575_));
 sky130_fd_sc_hd__o31ai_1 _9180_ (.A1(_0861_),
    .A2(_4499_),
    .A3(_4505_),
    .B1(_4575_),
    .Y(_0781_));
 sky130_fd_sc_hd__nand3_1 _9181_ (.A(\reg_pc[30] ),
    .B(_1502_),
    .C(_1523_),
    .Y(_4576_));
 sky130_fd_sc_hd__xnor2_1 _9182_ (.A(\reg_pc[31] ),
    .B(_4576_),
    .Y(_4577_));
 sky130_fd_sc_hd__nand2_1 _9183_ (.A(_1498_),
    .B(_4577_),
    .Y(_4578_));
 sky130_fd_sc_hd__o21ai_2 _9184_ (.A1(_1498_),
    .A2(_4371_),
    .B1(_4578_),
    .Y(\cpuregs_wrdata[31] ));
 sky130_fd_sc_hd__nand2_1 _9185_ (.A(_1073_),
    .B(_1463_),
    .Y(_4579_));
 sky130_fd_sc_hd__a21oi_1 _9186_ (.A1(_1072_),
    .A2(_0276_),
    .B1(_0267_),
    .Y(_4580_));
 sky130_fd_sc_hd__o21bai_1 _9187_ (.A1(_0260_),
    .A2(_4580_),
    .B1_N(_0261_),
    .Y(_4581_));
 sky130_fd_sc_hd__a21oi_1 _9188_ (.A1(_0256_),
    .A2(_4581_),
    .B1(_0255_),
    .Y(_4582_));
 sky130_fd_sc_hd__o21ai_0 _9189_ (.A1(_1252_),
    .A2(_4579_),
    .B1(_4582_),
    .Y(_4583_));
 sky130_fd_sc_hd__xnor2_1 _9190_ (.A(_0475_),
    .B(_4583_),
    .Y(_4584_));
 sky130_fd_sc_hd__nor2_1 _9191_ (.A(_0477_),
    .B(net726),
    .Y(_4585_));
 sky130_fd_sc_hd__a221oi_1 _9192_ (.A1(_0479_),
    .A2(net728),
    .B1(net727),
    .B2(_0478_),
    .C1(_4585_),
    .Y(_4586_));
 sky130_fd_sc_hd__nand4_1 _9193_ (.A(_0453_),
    .B(_0260_),
    .C(_0266_),
    .D(_0275_),
    .Y(_4587_));
 sky130_fd_sc_hd__inv_1 _9194_ (.A(_0454_),
    .Y(_4588_));
 sky130_fd_sc_hd__o221ai_1 _9195_ (.A1(_1005_),
    .A2(_1069_),
    .B1(_1222_),
    .B2(_4587_),
    .C1(_4588_),
    .Y(_4589_));
 sky130_fd_sc_hd__xnor2_1 _9196_ (.A(_0478_),
    .B(_4589_),
    .Y(_4590_));
 sky130_fd_sc_hd__a22o_1 _9197_ (.A1(net698),
    .A2(_4586_),
    .B1(_4590_),
    .B2(_1004_),
    .X(_4591_));
 sky130_fd_sc_hd__a31oi_1 _9198_ (.A1(net767),
    .A2(_4584_),
    .A3(_4586_),
    .B1(_4591_),
    .Y(\alu_out[31] ));
 sky130_fd_sc_hd__inv_1 _9199_ (.A(net334),
    .Y(_0421_));
 sky130_fd_sc_hd__o21ai_0 _9200_ (.A1(\reg_next_pc[31] ),
    .A2(net778),
    .B1(net825),
    .Y(_4592_));
 sky130_fd_sc_hd__nor3_1 _9201_ (.A(_3791_),
    .B(_3724_),
    .C(_3808_),
    .Y(_4593_));
 sky130_fd_sc_hd__nor2_1 _9202_ (.A(_3724_),
    .B(_3842_),
    .Y(_4594_));
 sky130_fd_sc_hd__o21a_1 _9203_ (.A1(_0074_),
    .A2(_4594_),
    .B1(_0153_),
    .X(_4595_));
 sky130_fd_sc_hd__a311oi_1 _9204_ (.A1(_3837_),
    .A2(_3840_),
    .A3(_4593_),
    .B1(_4595_),
    .C1(_0152_),
    .Y(_4596_));
 sky130_fd_sc_hd__xnor2_1 _9205_ (.A(\decoded_imm_j[20] ),
    .B(_4373_),
    .Y(_4597_));
 sky130_fd_sc_hd__xnor2_1 _9206_ (.A(_4596_),
    .B(_4597_),
    .Y(_4598_));
 sky130_fd_sc_hd__and3_1 _9207_ (.A(\reg_next_pc[31] ),
    .B(net715),
    .C(net825),
    .X(_4599_));
 sky130_fd_sc_hd__nand3_2 _9208_ (.A(_0151_),
    .B(_3772_),
    .C(_3860_),
    .Y(_4600_));
 sky130_fd_sc_hd__xnor2_1 _9209_ (.A(_4373_),
    .B(_4600_),
    .Y(_4601_));
 sky130_fd_sc_hd__nor2_1 _9210_ (.A(net771),
    .B(_4601_),
    .Y(_4602_));
 sky130_fd_sc_hd__a2111oi_2 _9211_ (.A1(net771),
    .A2(_4598_),
    .B1(_4599_),
    .C1(_4602_),
    .D1(net734),
    .Y(_4603_));
 sky130_fd_sc_hd__a311oi_1 _9212_ (.A1(net778),
    .A2(net734),
    .A3(_4373_),
    .B1(_4592_),
    .C1(_4603_),
    .Y(_0782_));
 sky130_fd_sc_hd__a211oi_1 _9213_ (.A1(_3514_),
    .A2(_4413_),
    .B1(net713),
    .C1(net823),
    .Y(_0783_));
 sky130_fd_sc_hd__nand2_1 _9214_ (.A(instr_and),
    .B(net694),
    .Y(_4604_));
 sky130_fd_sc_hd__o21ai_0 _9215_ (.A1(_4335_),
    .A2(_4352_),
    .B1(_4604_),
    .Y(_0784_));
 sky130_fd_sc_hd__nand2_1 _9216_ (.A(net266),
    .B(net703),
    .Y(_4605_));
 sky130_fd_sc_hd__nand2_1 _9217_ (.A(net307),
    .B(_0982_),
    .Y(_4606_));
 sky130_fd_sc_hd__a21oi_1 _9218_ (.A1(_4605_),
    .A2(_4606_),
    .B1(_0988_),
    .Y(_4685_));
 sky130_fd_sc_hd__nand2_1 _9219_ (.A(instr_sltu),
    .B(net694),
    .Y(_4607_));
 sky130_fd_sc_hd__o21ai_0 _9220_ (.A1(_4335_),
    .A2(_4359_),
    .B1(_4607_),
    .Y(_0785_));
 sky130_fd_sc_hd__o21ai_0 _9221_ (.A1(_3500_),
    .A2(_3497_),
    .B1(\mem_rdata_q[31] ),
    .Y(_4608_));
 sky130_fd_sc_hd__nand2_1 _9222_ (.A(_3505_),
    .B(_4608_),
    .Y(_0786_));
 sky130_fd_sc_hd__nand2_1 _9223_ (.A(instr_or),
    .B(_4336_),
    .Y(_4609_));
 sky130_fd_sc_hd__o21ai_0 _9224_ (.A1(_4335_),
    .A2(_4354_),
    .B1(_4609_),
    .Y(_0787_));
 sky130_fd_sc_hd__nand2_1 _9225_ (.A(instr_sra),
    .B(_4336_),
    .Y(_4610_));
 sky130_fd_sc_hd__o21ai_0 _9226_ (.A1(_4347_),
    .A2(_4367_),
    .B1(_4610_),
    .Y(_0788_));
 sky130_fd_sc_hd__nand2_1 _9227_ (.A(instr_srl),
    .B(_4336_),
    .Y(_4611_));
 sky130_fd_sc_hd__o21ai_0 _9228_ (.A1(_4335_),
    .A2(_4367_),
    .B1(_4611_),
    .Y(_0789_));
 sky130_fd_sc_hd__a22oi_1 _9229_ (.A1(net345),
    .A2(net765),
    .B1(net263),
    .B2(net766),
    .Y(_4612_));
 sky130_fd_sc_hd__o21ai_0 _9230_ (.A1(_0473_),
    .A2(_0945_),
    .B1(_4612_),
    .Y(net258));
 sky130_fd_sc_hd__inv_1 _9231_ (.A(_4412_),
    .Y(_0001_));
 sky130_fd_sc_hd__or3_1 _9232_ (.A(instr_blt),
    .B(instr_slti),
    .C(instr_slt),
    .X(_0002_));
 sky130_fd_sc_hd__or3_1 _9233_ (.A(instr_sltu),
    .B(instr_bltu),
    .C(instr_sltiu),
    .X(_0003_));
 sky130_fd_sc_hd__nand2_1 _9234_ (.A(\reg_out[31] ),
    .B(net731),
    .Y(_4613_));
 sky130_fd_sc_hd__nor2_1 _9235_ (.A(net741),
    .B(net729),
    .Y(_4614_));
 sky130_fd_sc_hd__a31oi_1 _9236_ (.A1(net729),
    .A2(_4372_),
    .A3(_4613_),
    .B1(_4614_),
    .Y(net225));
 sky130_fd_sc_hd__nand2_1 _9237_ (.A(net162),
    .B(net706),
    .Y(_4615_));
 sky130_fd_sc_hd__nand2_1 _9238_ (.A(\mem_rdata_q[31] ),
    .B(net733),
    .Y(_4616_));
 sky130_fd_sc_hd__nand2_1 _9239_ (.A(_4615_),
    .B(_4616_),
    .Y(\mem_rdata_latched[31] ));
 sky130_fd_sc_hd__fa_1 _9240_ (.A(\decoded_imm_j[2] ),
    .B(_0051_),
    .CIN(_0052_),
    .COUT(_0053_),
    .SUM(_0054_));
 sky130_fd_sc_hd__fa_1 _9241_ (.A(\reg_pc[2] ),
    .B(\decoded_imm[2] ),
    .CIN(_0055_),
    .COUT(_0056_),
    .SUM(_0057_));
 sky130_fd_sc_hd__fa_1 _9242_ (.A(net319),
    .B(\decoded_imm[1] ),
    .CIN(_0058_),
    .COUT(_0059_),
    .SUM(_0060_));
 sky130_fd_sc_hd__fa_1 _9243_ (.A(net245),
    .B(_0061_),
    .CIN(_0062_),
    .COUT(_0063_),
    .SUM(_0064_));
 sky130_fd_sc_hd__fa_1 _9244_ (.A(net245),
    .B(net753),
    .CIN(_0066_),
    .COUT(_0067_),
    .SUM(_0068_));
 sky130_fd_sc_hd__ha_1 _9245_ (.A(\decoded_imm_j[20] ),
    .B(_0069_),
    .COUT(_0070_),
    .SUM(_0071_));
 sky130_fd_sc_hd__ha_1 _9246_ (.A(\decoded_imm_j[20] ),
    .B(_0073_),
    .COUT(_0074_),
    .SUM(_0075_));
 sky130_fd_sc_hd__ha_1 _9247_ (.A(\decoded_imm_j[11] ),
    .B(_0076_),
    .COUT(_0077_),
    .SUM(_0078_));
 sky130_fd_sc_hd__ha_1 _9248_ (.A(_0051_),
    .B(_0079_),
    .COUT(_0080_),
    .SUM(_0081_));
 sky130_fd_sc_hd__ha_1 _9249_ (.A(\reg_pc[6] ),
    .B(\decoded_imm[6] ),
    .COUT(_0082_),
    .SUM(_0083_));
 sky130_fd_sc_hd__ha_1 _9250_ (.A(\decoded_imm_j[1] ),
    .B(_0084_),
    .COUT(_0052_),
    .SUM(_0085_));
 sky130_fd_sc_hd__ha_1 _9251_ (.A(\decoded_imm_j[16] ),
    .B(_0086_),
    .COUT(_0087_),
    .SUM(_0088_));
 sky130_fd_sc_hd__ha_1 _9252_ (.A(\decoded_imm_j[12] ),
    .B(_0090_),
    .COUT(_0091_),
    .SUM(_0092_));
 sky130_fd_sc_hd__ha_1 _9253_ (.A(\decoded_imm_j[5] ),
    .B(_0093_),
    .COUT(_0094_),
    .SUM(_0095_));
 sky130_fd_sc_hd__ha_1 _9254_ (.A(_0096_),
    .B(_0097_),
    .COUT(_0098_),
    .SUM(_0099_));
 sky130_fd_sc_hd__ha_1 _9255_ (.A(_0096_),
    .B(_0097_),
    .COUT(_0100_),
    .SUM(_4686_));
 sky130_fd_sc_hd__ha_1 _9256_ (.A(\reg_sh[2] ),
    .B(_0097_),
    .COUT(_0101_),
    .SUM(_4687_));
 sky130_fd_sc_hd__ha_1 _9257_ (.A(\decoded_imm_j[15] ),
    .B(_0103_),
    .COUT(_0104_),
    .SUM(_0105_));
 sky130_fd_sc_hd__ha_1 _9258_ (.A(net735),
    .B(\decoded_imm[9] ),
    .COUT(_0106_),
    .SUM(_0107_));
 sky130_fd_sc_hd__ha_1 _9259_ (.A(\decoded_imm_j[7] ),
    .B(_0108_),
    .COUT(_0109_),
    .SUM(_0110_));
 sky130_fd_sc_hd__ha_1 _9260_ (.A(\reg_pc[10] ),
    .B(\decoded_imm[10] ),
    .COUT(_0111_),
    .SUM(_0112_));
 sky130_fd_sc_hd__ha_1 _9261_ (.A(\reg_pc[8] ),
    .B(\decoded_imm[8] ),
    .COUT(_0113_),
    .SUM(_0114_));
 sky130_fd_sc_hd__ha_1 _9262_ (.A(_0115_),
    .B(_0116_),
    .COUT(_0117_),
    .SUM(_0118_));
 sky130_fd_sc_hd__ha_1 _9263_ (.A(_0115_),
    .B(_0116_),
    .COUT(_0119_),
    .SUM(_4688_));
 sky130_fd_sc_hd__ha_1 _9264_ (.A(\reg_pc[17] ),
    .B(\decoded_imm[17] ),
    .COUT(_0120_),
    .SUM(_0121_));
 sky130_fd_sc_hd__ha_1 _9265_ (.A(\reg_pc[25] ),
    .B(\decoded_imm[25] ),
    .COUT(_0122_),
    .SUM(_0123_));
 sky130_fd_sc_hd__ha_1 _9266_ (.A(\reg_pc[12] ),
    .B(\decoded_imm[12] ),
    .COUT(_0124_),
    .SUM(_0125_));
 sky130_fd_sc_hd__ha_1 _9267_ (.A(net742),
    .B(\decoded_imm[30] ),
    .COUT(_0126_),
    .SUM(_0127_));
 sky130_fd_sc_hd__ha_1 _9268_ (.A(net743),
    .B(\decoded_imm[29] ),
    .COUT(_0128_),
    .SUM(_0129_));
 sky130_fd_sc_hd__ha_1 _9269_ (.A(net745),
    .B(\decoded_imm[27] ),
    .COUT(_0130_),
    .SUM(_0131_));
 sky130_fd_sc_hd__ha_1 _9270_ (.A(net744),
    .B(\decoded_imm[28] ),
    .COUT(_0132_),
    .SUM(_0133_));
 sky130_fd_sc_hd__ha_1 _9271_ (.A(net746),
    .B(\decoded_imm[26] ),
    .COUT(_0134_),
    .SUM(_0135_));
 sky130_fd_sc_hd__ha_1 _9272_ (.A(net747),
    .B(\decoded_imm[25] ),
    .COUT(_0136_),
    .SUM(_0137_));
 sky130_fd_sc_hd__ha_1 _9273_ (.A(net749),
    .B(\decoded_imm[23] ),
    .COUT(_0138_),
    .SUM(_0139_));
 sky130_fd_sc_hd__ha_1 _9274_ (.A(net748),
    .B(\decoded_imm[24] ),
    .COUT(_0140_),
    .SUM(_0141_));
 sky130_fd_sc_hd__ha_1 _9275_ (.A(\reg_pc[20] ),
    .B(\decoded_imm[20] ),
    .COUT(_0142_),
    .SUM(_0143_));
 sky130_fd_sc_hd__ha_1 _9276_ (.A(\reg_pc[2] ),
    .B(\reg_pc[3] ),
    .COUT(_0144_),
    .SUM(_0145_));
 sky130_fd_sc_hd__ha_1 _9277_ (.A(\reg_pc[27] ),
    .B(\decoded_imm[27] ),
    .COUT(_0146_),
    .SUM(_0147_));
 sky130_fd_sc_hd__ha_1 _9278_ (.A(\decoded_imm_j[8] ),
    .B(_0148_),
    .COUT(_0149_),
    .SUM(_0150_));
 sky130_fd_sc_hd__ha_1 _9279_ (.A(\decoded_imm_j[20] ),
    .B(_0151_),
    .COUT(_0152_),
    .SUM(_0153_));
 sky130_fd_sc_hd__ha_1 _9280_ (.A(\decoded_imm_j[20] ),
    .B(_0154_),
    .COUT(_0155_),
    .SUM(_0156_));
 sky130_fd_sc_hd__ha_1 _9281_ (.A(\reg_pc[15] ),
    .B(\decoded_imm[15] ),
    .COUT(_0157_),
    .SUM(_0158_));
 sky130_fd_sc_hd__ha_1 _9282_ (.A(net750),
    .B(\decoded_imm[22] ),
    .COUT(_0159_),
    .SUM(_0160_));
 sky130_fd_sc_hd__ha_1 _9283_ (.A(net755),
    .B(\decoded_imm[18] ),
    .COUT(_0161_),
    .SUM(_0162_));
 sky130_fd_sc_hd__ha_1 _9284_ (.A(net758),
    .B(\decoded_imm[15] ),
    .COUT(_0163_),
    .SUM(_0164_));
 sky130_fd_sc_hd__ha_1 _9285_ (.A(net754),
    .B(\decoded_imm[19] ),
    .COUT(_0165_),
    .SUM(_0166_));
 sky130_fd_sc_hd__ha_1 _9286_ (.A(net759),
    .B(\decoded_imm[14] ),
    .COUT(_0167_),
    .SUM(_0168_));
 sky130_fd_sc_hd__ha_1 _9287_ (.A(net760),
    .B(\decoded_imm[13] ),
    .COUT(_0169_),
    .SUM(_0170_));
 sky130_fd_sc_hd__ha_1 _9288_ (.A(net763),
    .B(\decoded_imm[10] ),
    .COUT(_0171_),
    .SUM(_0172_));
 sky130_fd_sc_hd__ha_1 _9289_ (.A(net762),
    .B(\decoded_imm[11] ),
    .COUT(_0173_),
    .SUM(_0174_));
 sky130_fd_sc_hd__ha_1 _9290_ (.A(net339),
    .B(\decoded_imm[9] ),
    .COUT(_0175_),
    .SUM(_0176_));
 sky130_fd_sc_hd__ha_1 _9291_ (.A(net737),
    .B(\decoded_imm[8] ),
    .COUT(_0177_),
    .SUM(_0178_));
 sky130_fd_sc_hd__ha_1 _9292_ (.A(net739),
    .B(\decoded_imm[6] ),
    .COUT(_0179_),
    .SUM(_0180_));
 sky130_fd_sc_hd__ha_1 _9293_ (.A(net738),
    .B(\decoded_imm[7] ),
    .COUT(_0181_),
    .SUM(_0182_));
 sky130_fd_sc_hd__ha_1 _9294_ (.A(net335),
    .B(\decoded_imm[5] ),
    .COUT(_0183_),
    .SUM(_0184_));
 sky130_fd_sc_hd__ha_1 _9295_ (.A(net740),
    .B(\decoded_imm[3] ),
    .COUT(_0185_),
    .SUM(_0186_));
 sky130_fd_sc_hd__ha_1 _9296_ (.A(net334),
    .B(\decoded_imm[4] ),
    .COUT(_0187_),
    .SUM(_0188_));
 sky130_fd_sc_hd__ha_1 _9297_ (.A(net330),
    .B(\decoded_imm[2] ),
    .COUT(_0189_),
    .SUM(_0190_));
 sky130_fd_sc_hd__ha_1 _9298_ (.A(net764),
    .B(\decoded_imm[0] ),
    .COUT(_0058_),
    .SUM(_0191_));
 sky130_fd_sc_hd__ha_1 _9299_ (.A(net753),
    .B(\decoded_imm[1] ),
    .COUT(_0192_),
    .SUM(_0102_));
 sky130_fd_sc_hd__ha_1 _9300_ (.A(net751),
    .B(\decoded_imm[21] ),
    .COUT(_0193_),
    .SUM(_0194_));
 sky130_fd_sc_hd__ha_1 _9301_ (.A(net752),
    .B(\decoded_imm[20] ),
    .COUT(_0195_),
    .SUM(_0196_));
 sky130_fd_sc_hd__ha_1 _9302_ (.A(net757),
    .B(\decoded_imm[16] ),
    .COUT(_0197_),
    .SUM(_0198_));
 sky130_fd_sc_hd__ha_1 _9303_ (.A(net756),
    .B(\decoded_imm[17] ),
    .COUT(_0199_),
    .SUM(_0200_));
 sky130_fd_sc_hd__ha_1 _9304_ (.A(\decoded_imm_j[20] ),
    .B(_0201_),
    .COUT(_0202_),
    .SUM(_0203_));
 sky130_fd_sc_hd__ha_1 _9305_ (.A(net761),
    .B(\decoded_imm[12] ),
    .COUT(_0204_),
    .SUM(_0205_));
 sky130_fd_sc_hd__ha_1 _9306_ (.A(\reg_pc[24] ),
    .B(\decoded_imm[24] ),
    .COUT(_0206_),
    .SUM(_0207_));
 sky130_fd_sc_hd__ha_1 _9307_ (.A(\reg_pc[11] ),
    .B(\decoded_imm[11] ),
    .COUT(_0208_),
    .SUM(_0209_));
 sky130_fd_sc_hd__ha_1 _9308_ (.A(\reg_pc[22] ),
    .B(\decoded_imm[22] ),
    .COUT(_0210_),
    .SUM(_0211_));
 sky130_fd_sc_hd__ha_1 _9309_ (.A(\reg_pc[3] ),
    .B(\decoded_imm[3] ),
    .COUT(_0212_),
    .SUM(_0213_));
 sky130_fd_sc_hd__ha_1 _9310_ (.A(\reg_pc[23] ),
    .B(\decoded_imm[23] ),
    .COUT(_0214_),
    .SUM(_0215_));
 sky130_fd_sc_hd__ha_1 _9311_ (.A(\decoded_imm_j[19] ),
    .B(_0216_),
    .COUT(_0217_),
    .SUM(_0218_));
 sky130_fd_sc_hd__ha_1 _9312_ (.A(\reg_pc[18] ),
    .B(\decoded_imm[18] ),
    .COUT(_0219_),
    .SUM(_0220_));
 sky130_fd_sc_hd__ha_1 _9313_ (.A(\decoded_imm_j[20] ),
    .B(_0221_),
    .COUT(_0222_),
    .SUM(_0223_));
 sky130_fd_sc_hd__ha_1 _9314_ (.A(\reg_pc[14] ),
    .B(\decoded_imm[14] ),
    .COUT(_0224_),
    .SUM(_0225_));
 sky130_fd_sc_hd__ha_1 _9315_ (.A(\decoded_imm_j[3] ),
    .B(_0079_),
    .COUT(_0226_),
    .SUM(_0227_));
 sky130_fd_sc_hd__ha_1 _9316_ (.A(\decoded_imm_j[20] ),
    .B(_0228_),
    .COUT(_0229_),
    .SUM(_0230_));
 sky130_fd_sc_hd__ha_1 _9317_ (.A(\decoded_imm_j[10] ),
    .B(_0231_),
    .COUT(_0232_),
    .SUM(_0233_));
 sky130_fd_sc_hd__ha_1 _9318_ (.A(\decoded_imm_j[2] ),
    .B(_0051_),
    .COUT(_0234_),
    .SUM(_0072_));
 sky130_fd_sc_hd__ha_1 _9319_ (.A(\decoded_imm_j[18] ),
    .B(_0235_),
    .COUT(_0236_),
    .SUM(_0237_));
 sky130_fd_sc_hd__ha_1 _9320_ (.A(\decoded_imm_j[4] ),
    .B(_0238_),
    .COUT(_0239_),
    .SUM(_0240_));
 sky130_fd_sc_hd__ha_1 _9321_ (.A(\count_instr[0] ),
    .B(\count_instr[1] ),
    .COUT(_0242_),
    .SUM(_0243_));
 sky130_fd_sc_hd__ha_1 _9322_ (.A(\decoded_imm_j[13] ),
    .B(_0244_),
    .COUT(_0245_),
    .SUM(_0246_));
 sky130_fd_sc_hd__ha_1 _9323_ (.A(\reg_pc[21] ),
    .B(\decoded_imm[21] ),
    .COUT(_0247_),
    .SUM(_0248_));
 sky130_fd_sc_hd__ha_1 _9324_ (.A(\reg_pc[5] ),
    .B(\decoded_imm[5] ),
    .COUT(_0249_),
    .SUM(_0250_));
 sky130_fd_sc_hd__ha_1 _9325_ (.A(\reg_pc[26] ),
    .B(\decoded_imm[26] ),
    .COUT(_0251_),
    .SUM(_0252_));
 sky130_fd_sc_hd__ha_1 _9326_ (.A(\reg_pc[2] ),
    .B(\decoded_imm[2] ),
    .COUT(_0253_),
    .SUM(_0089_));
 sky130_fd_sc_hd__ha_1 _9327_ (.A(net331),
    .B(_0254_),
    .COUT(_0255_),
    .SUM(_0256_));
 sky130_fd_sc_hd__ha_1 _9328_ (.A(_0257_),
    .B(_0258_),
    .COUT(_0259_),
    .SUM(_0260_));
 sky130_fd_sc_hd__ha_1 _9329_ (.A(net743),
    .B(_0258_),
    .COUT(_0261_),
    .SUM(_4689_));
 sky130_fd_sc_hd__ha_1 _9330_ (.A(net743),
    .B(net359),
    .COUT(_0262_),
    .SUM(_4690_));
 sky130_fd_sc_hd__ha_1 _9331_ (.A(_0263_),
    .B(_0264_),
    .COUT(_0265_),
    .SUM(_0266_));
 sky130_fd_sc_hd__ha_1 _9332_ (.A(net744),
    .B(_0264_),
    .COUT(_0267_),
    .SUM(_4691_));
 sky130_fd_sc_hd__ha_1 _9333_ (.A(net744),
    .B(net358),
    .COUT(_0268_),
    .SUM(_4692_));
 sky130_fd_sc_hd__ha_1 _9334_ (.A(\decoded_imm_j[9] ),
    .B(_0269_),
    .COUT(_0270_),
    .SUM(_0271_));
 sky130_fd_sc_hd__ha_1 _9335_ (.A(_0272_),
    .B(_0273_),
    .COUT(_0274_),
    .SUM(_0275_));
 sky130_fd_sc_hd__ha_1 _9336_ (.A(net745),
    .B(_0273_),
    .COUT(_0276_),
    .SUM(_4693_));
 sky130_fd_sc_hd__ha_1 _9337_ (.A(net745),
    .B(net357),
    .COUT(_0277_),
    .SUM(_4694_));
 sky130_fd_sc_hd__ha_1 _9338_ (.A(_0278_),
    .B(_0279_),
    .COUT(_0280_),
    .SUM(_0281_));
 sky130_fd_sc_hd__ha_1 _9339_ (.A(net746),
    .B(_0279_),
    .COUT(_0282_),
    .SUM(_4695_));
 sky130_fd_sc_hd__ha_1 _9340_ (.A(net746),
    .B(net356),
    .COUT(_0283_),
    .SUM(_4696_));
 sky130_fd_sc_hd__ha_1 _9341_ (.A(_0284_),
    .B(_0285_),
    .COUT(_0286_),
    .SUM(_0287_));
 sky130_fd_sc_hd__ha_1 _9342_ (.A(net747),
    .B(_0285_),
    .COUT(_0288_),
    .SUM(_4697_));
 sky130_fd_sc_hd__ha_1 _9343_ (.A(net747),
    .B(net355),
    .COUT(_0289_),
    .SUM(_4698_));
 sky130_fd_sc_hd__ha_1 _9344_ (.A(_0290_),
    .B(_0291_),
    .COUT(_0292_),
    .SUM(_0293_));
 sky130_fd_sc_hd__ha_1 _9345_ (.A(net748),
    .B(_0291_),
    .COUT(_0294_),
    .SUM(_4699_));
 sky130_fd_sc_hd__ha_1 _9346_ (.A(net748),
    .B(net354),
    .COUT(_0295_),
    .SUM(_4700_));
 sky130_fd_sc_hd__ha_1 _9347_ (.A(_0296_),
    .B(_0297_),
    .COUT(_0298_),
    .SUM(_0299_));
 sky130_fd_sc_hd__ha_1 _9348_ (.A(net749),
    .B(_0297_),
    .COUT(_0300_),
    .SUM(_4701_));
 sky130_fd_sc_hd__ha_1 _9349_ (.A(net749),
    .B(net353),
    .COUT(_0301_),
    .SUM(_4702_));
 sky130_fd_sc_hd__ha_1 _9350_ (.A(\reg_pc[28] ),
    .B(\decoded_imm[28] ),
    .COUT(_0302_),
    .SUM(_0303_));
 sky130_fd_sc_hd__ha_1 _9351_ (.A(_0304_),
    .B(_0305_),
    .COUT(_0306_),
    .SUM(_0307_));
 sky130_fd_sc_hd__ha_1 _9352_ (.A(net750),
    .B(_0305_),
    .COUT(_0308_),
    .SUM(_4703_));
 sky130_fd_sc_hd__ha_1 _9353_ (.A(net750),
    .B(net352),
    .COUT(_0309_),
    .SUM(_4704_));
 sky130_fd_sc_hd__ha_1 _9354_ (.A(_0310_),
    .B(_0311_),
    .COUT(_0312_),
    .SUM(_0313_));
 sky130_fd_sc_hd__ha_1 _9355_ (.A(net751),
    .B(_0311_),
    .COUT(_0314_),
    .SUM(_4705_));
 sky130_fd_sc_hd__ha_1 _9356_ (.A(net751),
    .B(net351),
    .COUT(_0315_),
    .SUM(_4706_));
 sky130_fd_sc_hd__ha_1 _9357_ (.A(_0316_),
    .B(_0317_),
    .COUT(_0318_),
    .SUM(_0319_));
 sky130_fd_sc_hd__ha_1 _9358_ (.A(net752),
    .B(_0317_),
    .COUT(_0320_),
    .SUM(_4707_));
 sky130_fd_sc_hd__ha_1 _9359_ (.A(net752),
    .B(net350),
    .COUT(_0321_),
    .SUM(_4708_));
 sky130_fd_sc_hd__ha_1 _9360_ (.A(_0322_),
    .B(_0323_),
    .COUT(_0324_),
    .SUM(_0325_));
 sky130_fd_sc_hd__ha_1 _9361_ (.A(net754),
    .B(_0323_),
    .COUT(_0326_),
    .SUM(_4709_));
 sky130_fd_sc_hd__ha_1 _9362_ (.A(net754),
    .B(net349),
    .COUT(_0327_),
    .SUM(_4710_));
 sky130_fd_sc_hd__ha_1 _9363_ (.A(_0328_),
    .B(_0329_),
    .COUT(_0330_),
    .SUM(_0331_));
 sky130_fd_sc_hd__ha_1 _9364_ (.A(net755),
    .B(_0329_),
    .COUT(_0332_),
    .SUM(_4711_));
 sky130_fd_sc_hd__ha_1 _9365_ (.A(net755),
    .B(net348),
    .COUT(_0333_),
    .SUM(_4712_));
 sky130_fd_sc_hd__ha_1 _9366_ (.A(_0334_),
    .B(_0335_),
    .COUT(_0336_),
    .SUM(_0337_));
 sky130_fd_sc_hd__ha_1 _9367_ (.A(net756),
    .B(_0335_),
    .COUT(_0338_),
    .SUM(_4713_));
 sky130_fd_sc_hd__ha_1 _9368_ (.A(net756),
    .B(net347),
    .COUT(_0339_),
    .SUM(_4714_));
 sky130_fd_sc_hd__ha_1 _9369_ (.A(_0340_),
    .B(_0341_),
    .COUT(_0342_),
    .SUM(_0343_));
 sky130_fd_sc_hd__ha_1 _9370_ (.A(net315),
    .B(_0341_),
    .COUT(_0344_),
    .SUM(_4715_));
 sky130_fd_sc_hd__ha_1 _9371_ (.A(net315),
    .B(net346),
    .COUT(_0345_),
    .SUM(_4716_));
 sky130_fd_sc_hd__ha_1 _9372_ (.A(_0346_),
    .B(_0347_),
    .COUT(_0348_),
    .SUM(_0349_));
 sky130_fd_sc_hd__ha_1 _9373_ (.A(net758),
    .B(_0347_),
    .COUT(_0350_),
    .SUM(_4717_));
 sky130_fd_sc_hd__ha_1 _9374_ (.A(net758),
    .B(net345),
    .COUT(_0351_),
    .SUM(_4718_));
 sky130_fd_sc_hd__ha_1 _9375_ (.A(_0352_),
    .B(_0353_),
    .COUT(_0354_),
    .SUM(_0355_));
 sky130_fd_sc_hd__ha_1 _9376_ (.A(net759),
    .B(_0353_),
    .COUT(_0356_),
    .SUM(_4719_));
 sky130_fd_sc_hd__ha_1 _9377_ (.A(net759),
    .B(net344),
    .COUT(_0357_),
    .SUM(_4720_));
 sky130_fd_sc_hd__ha_1 _9378_ (.A(_0358_),
    .B(_0359_),
    .COUT(_0360_),
    .SUM(_0361_));
 sky130_fd_sc_hd__ha_1 _9379_ (.A(net760),
    .B(_0359_),
    .COUT(_0362_),
    .SUM(_4721_));
 sky130_fd_sc_hd__ha_1 _9380_ (.A(net760),
    .B(net343),
    .COUT(_0363_),
    .SUM(_4722_));
 sky130_fd_sc_hd__ha_1 _9381_ (.A(_0364_),
    .B(_0365_),
    .COUT(_0366_),
    .SUM(_0367_));
 sky130_fd_sc_hd__ha_1 _9382_ (.A(net761),
    .B(_0365_),
    .COUT(_0368_),
    .SUM(_4723_));
 sky130_fd_sc_hd__ha_1 _9383_ (.A(net761),
    .B(net342),
    .COUT(_0369_),
    .SUM(_4724_));
 sky130_fd_sc_hd__ha_1 _9384_ (.A(_0370_),
    .B(_0371_),
    .COUT(_0372_),
    .SUM(_0373_));
 sky130_fd_sc_hd__ha_1 _9385_ (.A(net762),
    .B(_0371_),
    .COUT(_0374_),
    .SUM(_4725_));
 sky130_fd_sc_hd__ha_1 _9386_ (.A(net762),
    .B(net341),
    .COUT(_0375_),
    .SUM(_4726_));
 sky130_fd_sc_hd__ha_1 _9387_ (.A(_0376_),
    .B(_0377_),
    .COUT(_0378_),
    .SUM(_0379_));
 sky130_fd_sc_hd__ha_1 _9388_ (.A(net763),
    .B(_0377_),
    .COUT(_0380_),
    .SUM(_4727_));
 sky130_fd_sc_hd__ha_1 _9389_ (.A(net763),
    .B(net340),
    .COUT(_0381_),
    .SUM(_4728_));
 sky130_fd_sc_hd__ha_1 _9390_ (.A(_0382_),
    .B(_0383_),
    .COUT(_0384_),
    .SUM(_0385_));
 sky130_fd_sc_hd__ha_1 _9391_ (.A(net736),
    .B(_0383_),
    .COUT(_0386_),
    .SUM(_4729_));
 sky130_fd_sc_hd__ha_1 _9392_ (.A(net736),
    .B(net363),
    .COUT(_0387_),
    .SUM(_4730_));
 sky130_fd_sc_hd__ha_1 _9393_ (.A(_0388_),
    .B(_0389_),
    .COUT(_0390_),
    .SUM(_0391_));
 sky130_fd_sc_hd__ha_1 _9394_ (.A(net737),
    .B(_0389_),
    .COUT(_0392_),
    .SUM(_4731_));
 sky130_fd_sc_hd__ha_1 _9395_ (.A(net737),
    .B(net362),
    .COUT(_0393_),
    .SUM(_4732_));
 sky130_fd_sc_hd__ha_1 _9396_ (.A(_0394_),
    .B(_0395_),
    .COUT(_0396_),
    .SUM(_0397_));
 sky130_fd_sc_hd__ha_1 _9397_ (.A(_0394_),
    .B(net337),
    .COUT(_0398_),
    .SUM(_4733_));
 sky130_fd_sc_hd__ha_1 _9398_ (.A(net263),
    .B(net337),
    .COUT(_0399_),
    .SUM(_4734_));
 sky130_fd_sc_hd__ha_1 _9399_ (.A(_0400_),
    .B(_0401_),
    .COUT(_0402_),
    .SUM(_0403_));
 sky130_fd_sc_hd__ha_1 _9400_ (.A(_0400_),
    .B(net336),
    .COUT(_0404_),
    .SUM(_4735_));
 sky130_fd_sc_hd__ha_1 _9401_ (.A(net262),
    .B(net336),
    .COUT(_0405_),
    .SUM(_4736_));
 sky130_fd_sc_hd__ha_1 _9402_ (.A(_0406_),
    .B(_0407_),
    .COUT(_0408_),
    .SUM(_0409_));
 sky130_fd_sc_hd__ha_1 _9403_ (.A(_0406_),
    .B(net335),
    .COUT(_0410_),
    .SUM(_4737_));
 sky130_fd_sc_hd__ha_1 _9404_ (.A(net261),
    .B(net335),
    .COUT(_0411_),
    .SUM(_4738_));
 sky130_fd_sc_hd__ha_1 _9405_ (.A(\decoded_imm_j[14] ),
    .B(_0412_),
    .COUT(_0413_),
    .SUM(_0414_));
 sky130_fd_sc_hd__ha_1 _9406_ (.A(\decoded_imm_j[17] ),
    .B(_0415_),
    .COUT(_0416_),
    .SUM(_0417_));
 sky130_fd_sc_hd__ha_1 _9407_ (.A(\reg_pc[7] ),
    .B(\decoded_imm[7] ),
    .COUT(_0418_),
    .SUM(_0419_));
 sky130_fd_sc_hd__ha_1 _9408_ (.A(_0420_),
    .B(_0421_),
    .COUT(_0422_),
    .SUM(_0423_));
 sky130_fd_sc_hd__ha_1 _9409_ (.A(_0420_),
    .B(net334),
    .COUT(_0424_),
    .SUM(_4739_));
 sky130_fd_sc_hd__ha_1 _9410_ (.A(net260),
    .B(net334),
    .COUT(_0425_),
    .SUM(_4740_));
 sky130_fd_sc_hd__ha_1 _9411_ (.A(_0426_),
    .B(_0427_),
    .COUT(_0428_),
    .SUM(_0429_));
 sky130_fd_sc_hd__ha_1 _9412_ (.A(_0426_),
    .B(net740),
    .COUT(_0430_),
    .SUM(_4741_));
 sky130_fd_sc_hd__ha_1 _9413_ (.A(net259),
    .B(net740),
    .COUT(_0431_),
    .SUM(_4742_));
 sky130_fd_sc_hd__ha_1 _9414_ (.A(\decoded_imm_j[20] ),
    .B(_0432_),
    .COUT(_0433_),
    .SUM(_0434_));
 sky130_fd_sc_hd__ha_1 _9415_ (.A(_0435_),
    .B(_0436_),
    .COUT(_0437_),
    .SUM(_0438_));
 sky130_fd_sc_hd__ha_1 _9416_ (.A(_0435_),
    .B(net330),
    .COUT(_0439_),
    .SUM(_4743_));
 sky130_fd_sc_hd__ha_1 _9417_ (.A(net256),
    .B(net330),
    .COUT(_0440_),
    .SUM(_4744_));
 sky130_fd_sc_hd__ha_1 _9418_ (.A(_0065_),
    .B(_0061_),
    .COUT(_0441_),
    .SUM(_0241_));
 sky130_fd_sc_hd__ha_1 _9419_ (.A(_0065_),
    .B(net753),
    .COUT(_0442_),
    .SUM(_4745_));
 sky130_fd_sc_hd__ha_1 _9420_ (.A(net245),
    .B(net753),
    .COUT(_0443_),
    .SUM(_4746_));
 sky130_fd_sc_hd__ha_1 _9421_ (.A(_0444_),
    .B(_0445_),
    .COUT(_0446_),
    .SUM(\alu_add_sub[0] ));
 sky130_fd_sc_hd__ha_1 _9422_ (.A(net234),
    .B(_0445_),
    .COUT(_0062_),
    .SUM(_4747_));
 sky130_fd_sc_hd__ha_1 _9423_ (.A(net234),
    .B(net308),
    .COUT(_0066_),
    .SUM(_4748_));
 sky130_fd_sc_hd__ha_1 _9424_ (.A(\reg_pc[13] ),
    .B(\decoded_imm[13] ),
    .COUT(_0447_),
    .SUM(_0448_));
 sky130_fd_sc_hd__ha_1 _9425_ (.A(\reg_pc[4] ),
    .B(\decoded_imm[4] ),
    .COUT(_0449_),
    .SUM(_0450_));
 sky130_fd_sc_hd__ha_1 _9426_ (.A(_0451_),
    .B(_0254_),
    .COUT(_0452_),
    .SUM(_0453_));
 sky130_fd_sc_hd__ha_1 _9427_ (.A(net742),
    .B(net360),
    .COUT(_0454_),
    .SUM(_4749_));
 sky130_fd_sc_hd__ha_1 _9428_ (.A(\reg_pc[29] ),
    .B(\decoded_imm[29] ),
    .COUT(_0455_),
    .SUM(_0456_));
 sky130_fd_sc_hd__ha_1 _9429_ (.A(\decoded_imm_j[20] ),
    .B(_0457_),
    .COUT(_0458_),
    .SUM(_0459_));
 sky130_fd_sc_hd__ha_1 _9430_ (.A(\decoded_imm_j[6] ),
    .B(_0460_),
    .COUT(_0461_),
    .SUM(_0462_));
 sky130_fd_sc_hd__ha_1 _9431_ (.A(\reg_pc[30] ),
    .B(\decoded_imm[30] ),
    .COUT(_0463_),
    .SUM(_0464_));
 sky130_fd_sc_hd__ha_1 _9432_ (.A(\reg_pc[19] ),
    .B(\decoded_imm[19] ),
    .COUT(_0465_),
    .SUM(_0466_));
 sky130_fd_sc_hd__ha_1 _9433_ (.A(\reg_pc[1] ),
    .B(\decoded_imm[1] ),
    .COUT(_0055_),
    .SUM(_0467_));
 sky130_fd_sc_hd__ha_1 _9434_ (.A(\reg_pc[16] ),
    .B(\decoded_imm[16] ),
    .COUT(_0468_),
    .SUM(_0469_));
 sky130_fd_sc_hd__ha_1 _9435_ (.A(\decoded_imm_j[20] ),
    .B(_0470_),
    .COUT(_0471_),
    .SUM(_0472_));
 sky130_fd_sc_hd__ha_1 _9436_ (.A(net332),
    .B(_0473_),
    .COUT(_0474_),
    .SUM(_0475_));
 sky130_fd_sc_hd__ha_1 _9437_ (.A(_0476_),
    .B(_0473_),
    .COUT(_0477_),
    .SUM(_0478_));
 sky130_fd_sc_hd__ha_1 _9438_ (.A(net741),
    .B(net361),
    .COUT(_0479_),
    .SUM(_4750_));
 sky130_fd_sc_hd__ha_1 _9439_ (.A(\count_cycle[0] ),
    .B(\count_cycle[1] ),
    .COUT(_0480_),
    .SUM(_0481_));
 sky130_fd_sc_hd__ha_1 _9440_ (.A(\decoded_imm_j[20] ),
    .B(net702),
    .COUT(_0483_),
    .SUM(_0484_));
 sky130_fd_sc_hd__ha_1 _9441_ (.A(_0485_),
    .B(_0486_),
    .COUT(_0487_),
    .SUM(_0488_));
 sky130_fd_sc_hd__ha_1 _9442_ (.A(_0485_),
    .B(\mem_state[1] ),
    .COUT(_0489_),
    .SUM(_4751_));
 sky130_fd_sc_hd__ha_1 _9443_ (.A(\mem_state[0] ),
    .B(_0486_),
    .COUT(_0490_),
    .SUM(_4752_));
 sky130_fd_sc_hd__ha_1 _9444_ (.A(\mem_state[0] ),
    .B(\mem_state[1] ),
    .COUT(_0491_),
    .SUM(_4753_));
 sky130_fd_sc_hd__ha_1 _9445_ (.A(\mem_state[0] ),
    .B(\mem_state[1] ),
    .COUT(_0492_),
    .SUM(_4754_));
 sky130_fd_sc_hd__dfxtp_1 _9446_ (.D(_0514_),
    .Q(_0041_),
    .CLK(clknet_leaf_147_clk));
 sky130_fd_sc_hd__dfxtp_1 _9447_ (.D(_0515_),
    .Q(_0042_),
    .CLK(clknet_leaf_151_clk));
 sky130_fd_sc_hd__dfxtp_2 _9448_ (.D(_0516_),
    .Q(_0043_),
    .CLK(clknet_leaf_149_clk));
 sky130_fd_sc_hd__dfxtp_4 _9449_ (.D(_0517_),
    .Q(_0044_),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__dfxtp_1 _9450_ (.D(_0518_),
    .Q(_0045_),
    .CLK(clknet_leaf_149_clk));
 sky130_fd_sc_hd__dfxtp_1 _9451_ (.D(_0519_),
    .Q(_0046_),
    .CLK(clknet_leaf_147_clk));
 sky130_fd_sc_hd__dfxtp_1 _9452_ (.D(_0520_),
    .Q(_0047_),
    .CLK(clknet_leaf_147_clk));
 sky130_fd_sc_hd__dfxtp_1 _9453_ (.D(_0521_),
    .Q(_0048_),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__dfxtp_2 _9454_ (.D(_0522_),
    .Q(_0049_),
    .CLK(clknet_leaf_151_clk));
 sky130_fd_sc_hd__dfxtp_2 _9455_ (.D(_0523_),
    .Q(_0050_),
    .CLK(clknet_leaf_151_clk));
 sky130_fd_sc_hd__conb_1 _9457__1 (.LO(eoi[0]));
 sky130_fd_sc_hd__conb_1 _9458__2 (.LO(eoi[1]));
 sky130_fd_sc_hd__conb_1 _9459__3 (.LO(eoi[2]));
 sky130_fd_sc_hd__conb_1 _9460__4 (.LO(eoi[3]));
 sky130_fd_sc_hd__conb_1 _9461__5 (.LO(eoi[4]));
 sky130_fd_sc_hd__conb_1 _9462__6 (.LO(eoi[5]));
 sky130_fd_sc_hd__conb_1 _9463__7 (.LO(eoi[6]));
 sky130_fd_sc_hd__conb_1 _9464__8 (.LO(eoi[7]));
 sky130_fd_sc_hd__conb_1 _9465__9 (.LO(eoi[8]));
 sky130_fd_sc_hd__conb_1 _9466__10 (.LO(eoi[9]));
 sky130_fd_sc_hd__conb_1 _9467__11 (.LO(eoi[10]));
 sky130_fd_sc_hd__conb_1 _9468__12 (.LO(eoi[11]));
 sky130_fd_sc_hd__conb_1 _9469__13 (.LO(eoi[12]));
 sky130_fd_sc_hd__conb_1 _9470__14 (.LO(eoi[13]));
 sky130_fd_sc_hd__conb_1 _9471__15 (.LO(eoi[14]));
 sky130_fd_sc_hd__conb_1 _9472__16 (.LO(eoi[15]));
 sky130_fd_sc_hd__conb_1 _9473__17 (.LO(eoi[16]));
 sky130_fd_sc_hd__conb_1 _9474__18 (.LO(eoi[17]));
 sky130_fd_sc_hd__conb_1 _9475__19 (.LO(eoi[18]));
 sky130_fd_sc_hd__conb_1 _9476__20 (.LO(eoi[19]));
 sky130_fd_sc_hd__conb_1 _9477__21 (.LO(eoi[20]));
 sky130_fd_sc_hd__conb_1 _9478__22 (.LO(eoi[21]));
 sky130_fd_sc_hd__conb_1 _9479__23 (.LO(eoi[22]));
 sky130_fd_sc_hd__conb_1 _9480__24 (.LO(eoi[23]));
 sky130_fd_sc_hd__conb_1 _9481__25 (.LO(eoi[24]));
 sky130_fd_sc_hd__conb_1 _9482__26 (.LO(eoi[25]));
 sky130_fd_sc_hd__conb_1 _9483__27 (.LO(eoi[26]));
 sky130_fd_sc_hd__conb_1 _9484__28 (.LO(eoi[27]));
 sky130_fd_sc_hd__conb_1 _9485__29 (.LO(eoi[28]));
 sky130_fd_sc_hd__conb_1 _9486__30 (.LO(eoi[29]));
 sky130_fd_sc_hd__conb_1 _9487__31 (.LO(eoi[30]));
 sky130_fd_sc_hd__conb_1 _9488__32 (.LO(eoi[31]));
 sky130_fd_sc_hd__conb_1 _9489__33 (.LO(mem_addr[0]));
 sky130_fd_sc_hd__conb_1 _9490__34 (.LO(mem_addr[1]));
 sky130_fd_sc_hd__conb_1 _9491__35 (.LO(mem_la_addr[0]));
 sky130_fd_sc_hd__conb_1 _9492__36 (.LO(mem_la_addr[1]));
 sky130_fd_sc_hd__conb_1 _9493__37 (.LO(pcpi_insn[0]));
 sky130_fd_sc_hd__conb_1 _9494__38 (.LO(pcpi_insn[1]));
 sky130_fd_sc_hd__conb_1 _9495__39 (.LO(pcpi_insn[2]));
 sky130_fd_sc_hd__conb_1 _9496__40 (.LO(pcpi_insn[3]));
 sky130_fd_sc_hd__conb_1 _9497__41 (.LO(pcpi_insn[4]));
 sky130_fd_sc_hd__conb_1 _9498__42 (.LO(pcpi_insn[5]));
 sky130_fd_sc_hd__conb_1 _9499__43 (.LO(pcpi_insn[6]));
 sky130_fd_sc_hd__conb_1 _9500__44 (.LO(pcpi_insn[7]));
 sky130_fd_sc_hd__conb_1 _9501__45 (.LO(pcpi_insn[8]));
 sky130_fd_sc_hd__conb_1 _9502__46 (.LO(pcpi_insn[9]));
 sky130_fd_sc_hd__conb_1 _9503__47 (.LO(pcpi_insn[10]));
 sky130_fd_sc_hd__conb_1 _9504__48 (.LO(pcpi_insn[11]));
 sky130_fd_sc_hd__conb_1 _9505__49 (.LO(pcpi_insn[12]));
 sky130_fd_sc_hd__conb_1 _9506__50 (.LO(pcpi_insn[13]));
 sky130_fd_sc_hd__conb_1 _9507__51 (.LO(pcpi_insn[14]));
 sky130_fd_sc_hd__conb_1 _9508__52 (.LO(pcpi_insn[15]));
 sky130_fd_sc_hd__conb_1 _9509__53 (.LO(pcpi_insn[16]));
 sky130_fd_sc_hd__conb_1 _9510__54 (.LO(pcpi_insn[17]));
 sky130_fd_sc_hd__conb_1 _9511__55 (.LO(pcpi_insn[18]));
 sky130_fd_sc_hd__conb_1 _9512__56 (.LO(pcpi_insn[19]));
 sky130_fd_sc_hd__conb_1 _9513__57 (.LO(pcpi_insn[20]));
 sky130_fd_sc_hd__conb_1 _9514__58 (.LO(pcpi_insn[21]));
 sky130_fd_sc_hd__conb_1 _9515__59 (.LO(pcpi_insn[22]));
 sky130_fd_sc_hd__conb_1 _9516__60 (.LO(pcpi_insn[23]));
 sky130_fd_sc_hd__conb_1 _9517__61 (.LO(pcpi_insn[24]));
 sky130_fd_sc_hd__conb_1 _9518__62 (.LO(pcpi_insn[25]));
 sky130_fd_sc_hd__conb_1 _9519__63 (.LO(pcpi_insn[26]));
 sky130_fd_sc_hd__conb_1 _9520__64 (.LO(pcpi_insn[27]));
 sky130_fd_sc_hd__conb_1 _9521__65 (.LO(pcpi_insn[28]));
 sky130_fd_sc_hd__conb_1 _9522__66 (.LO(pcpi_insn[29]));
 sky130_fd_sc_hd__conb_1 _9523__67 (.LO(pcpi_insn[30]));
 sky130_fd_sc_hd__conb_1 _9524__68 (.LO(pcpi_insn[31]));
 sky130_fd_sc_hd__conb_1 _9533__69 (.LO(pcpi_valid));
 sky130_fd_sc_hd__conb_1 _9534__70 (.LO(trace_data[0]));
 sky130_fd_sc_hd__conb_1 _9535__71 (.LO(trace_data[1]));
 sky130_fd_sc_hd__conb_1 _9536__72 (.LO(trace_data[2]));
 sky130_fd_sc_hd__conb_1 _9537__73 (.LO(trace_data[3]));
 sky130_fd_sc_hd__conb_1 _9538__74 (.LO(trace_data[4]));
 sky130_fd_sc_hd__conb_1 _9539__75 (.LO(trace_data[5]));
 sky130_fd_sc_hd__conb_1 _9540__76 (.LO(trace_data[6]));
 sky130_fd_sc_hd__conb_1 _9541__77 (.LO(trace_data[7]));
 sky130_fd_sc_hd__conb_1 _9542__78 (.LO(trace_data[8]));
 sky130_fd_sc_hd__conb_1 _9543__79 (.LO(trace_data[9]));
 sky130_fd_sc_hd__conb_1 _9544__80 (.LO(trace_data[10]));
 sky130_fd_sc_hd__conb_1 _9545__81 (.LO(trace_data[11]));
 sky130_fd_sc_hd__conb_1 _9546__82 (.LO(trace_data[12]));
 sky130_fd_sc_hd__conb_1 _9547__83 (.LO(trace_data[13]));
 sky130_fd_sc_hd__conb_1 _9548__84 (.LO(trace_data[14]));
 sky130_fd_sc_hd__conb_1 _9549__85 (.LO(trace_data[15]));
 sky130_fd_sc_hd__conb_1 _9550__86 (.LO(trace_data[16]));
 sky130_fd_sc_hd__conb_1 _9551__87 (.LO(trace_data[17]));
 sky130_fd_sc_hd__conb_1 _9552__88 (.LO(trace_data[18]));
 sky130_fd_sc_hd__conb_1 _9553__89 (.LO(trace_data[19]));
 sky130_fd_sc_hd__conb_1 _9554__90 (.LO(trace_data[20]));
 sky130_fd_sc_hd__conb_1 _9555__91 (.LO(trace_data[21]));
 sky130_fd_sc_hd__conb_1 _9556__92 (.LO(trace_data[22]));
 sky130_fd_sc_hd__conb_1 _9557__93 (.LO(trace_data[23]));
 sky130_fd_sc_hd__conb_1 _9558__94 (.LO(trace_data[24]));
 sky130_fd_sc_hd__conb_1 _9559__95 (.LO(trace_data[25]));
 sky130_fd_sc_hd__conb_1 _9560__96 (.LO(trace_data[26]));
 sky130_fd_sc_hd__conb_1 _9561__97 (.LO(trace_data[27]));
 sky130_fd_sc_hd__conb_1 _9562__98 (.LO(trace_data[28]));
 sky130_fd_sc_hd__conb_1 _9563__99 (.LO(trace_data[29]));
 sky130_fd_sc_hd__conb_1 _9564__100 (.LO(trace_data[30]));
 sky130_fd_sc_hd__conb_1 _9565__101 (.LO(trace_data[31]));
 sky130_fd_sc_hd__conb_1 _9566__102 (.LO(trace_data[32]));
 sky130_fd_sc_hd__conb_1 _9567__103 (.LO(trace_data[33]));
 sky130_fd_sc_hd__conb_1 _9568__104 (.LO(trace_data[34]));
 sky130_fd_sc_hd__conb_1 _9569__105 (.LO(trace_data[35]));
 sky130_fd_sc_hd__conb_1 _9570__106 (.LO(trace_valid));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[0]$_DFF_P_  (.D(\alu_out[0] ),
    .Q(\alu_out_q[0] ),
    .CLK(clknet_leaf_105_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[10]$_DFF_P_  (.D(\alu_out[10] ),
    .Q(\alu_out_q[10] ),
    .CLK(clknet_leaf_105_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[11]$_DFF_P_  (.D(\alu_out[11] ),
    .Q(\alu_out_q[11] ),
    .CLK(clknet_leaf_106_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[12]$_DFF_P_  (.D(\alu_out[12] ),
    .Q(\alu_out_q[12] ),
    .CLK(clknet_leaf_104_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[13]$_DFF_P_  (.D(\alu_out[13] ),
    .Q(\alu_out_q[13] ),
    .CLK(clknet_leaf_106_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[14]$_DFF_P_  (.D(\alu_out[14] ),
    .Q(\alu_out_q[14] ),
    .CLK(clknet_leaf_103_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[15]$_DFF_P_  (.D(\alu_out[15] ),
    .Q(\alu_out_q[15] ),
    .CLK(clknet_leaf_103_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[16]$_DFF_P_  (.D(\alu_out[16] ),
    .Q(\alu_out_q[16] ),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[17]$_DFF_P_  (.D(\alu_out[17] ),
    .Q(\alu_out_q[17] ),
    .CLK(clknet_leaf_102_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[18]$_DFF_P_  (.D(\alu_out[18] ),
    .Q(\alu_out_q[18] ),
    .CLK(clknet_leaf_104_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[19]$_DFF_P_  (.D(\alu_out[19] ),
    .Q(\alu_out_q[19] ),
    .CLK(clknet_leaf_104_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[1]$_DFF_P_  (.D(\alu_out[1] ),
    .Q(\alu_out_q[1] ),
    .CLK(clknet_leaf_105_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[20]$_DFF_P_  (.D(\alu_out[20] ),
    .Q(\alu_out_q[20] ),
    .CLK(clknet_leaf_99_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[21]$_DFF_P_  (.D(\alu_out[21] ),
    .Q(\alu_out_q[21] ),
    .CLK(clknet_leaf_103_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[22]$_DFF_P_  (.D(\alu_out[22] ),
    .Q(\alu_out_q[22] ),
    .CLK(clknet_leaf_101_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[23]$_DFF_P_  (.D(\alu_out[23] ),
    .Q(\alu_out_q[23] ),
    .CLK(clknet_leaf_102_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[24]$_DFF_P_  (.D(\alu_out[24] ),
    .Q(\alu_out_q[24] ),
    .CLK(clknet_leaf_100_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[25]$_DFF_P_  (.D(\alu_out[25] ),
    .Q(\alu_out_q[25] ),
    .CLK(clknet_leaf_102_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[26]$_DFF_P_  (.D(\alu_out[26] ),
    .Q(\alu_out_q[26] ),
    .CLK(clknet_leaf_101_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[27]$_DFF_P_  (.D(\alu_out[27] ),
    .Q(\alu_out_q[27] ),
    .CLK(clknet_leaf_103_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[28]$_DFF_P_  (.D(\alu_out[28] ),
    .Q(\alu_out_q[28] ),
    .CLK(clknet_leaf_103_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[29]$_DFF_P_  (.D(\alu_out[29] ),
    .Q(\alu_out_q[29] ),
    .CLK(clknet_leaf_102_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[2]$_DFF_P_  (.D(\alu_out[2] ),
    .Q(\alu_out_q[2] ),
    .CLK(clknet_leaf_105_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[30]$_DFF_P_  (.D(\alu_out[30] ),
    .Q(\alu_out_q[30] ),
    .CLK(clknet_leaf_102_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[31]$_DFF_P_  (.D(\alu_out[31] ),
    .Q(\alu_out_q[31] ),
    .CLK(clknet_leaf_102_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[3]$_DFF_P_  (.D(\alu_out[3] ),
    .Q(\alu_out_q[3] ),
    .CLK(clknet_leaf_106_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[4]$_DFF_P_  (.D(\alu_out[4] ),
    .Q(\alu_out_q[4] ),
    .CLK(clknet_leaf_107_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[5]$_DFF_P_  (.D(\alu_out[5] ),
    .Q(\alu_out_q[5] ),
    .CLK(clknet_leaf_105_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[6]$_DFF_P_  (.D(\alu_out[6] ),
    .Q(\alu_out_q[6] ),
    .CLK(clknet_leaf_105_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[7]$_DFF_P_  (.D(\alu_out[7] ),
    .Q(\alu_out_q[7] ),
    .CLK(clknet_leaf_106_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[8]$_DFF_P_  (.D(\alu_out[8] ),
    .Q(\alu_out_q[8] ),
    .CLK(clknet_leaf_106_clk));
 sky130_fd_sc_hd__dfxtp_1 \alu_out_q[9]$_DFF_P_  (.D(\alu_out[9] ),
    .Q(\alu_out_q[9] ),
    .CLK(clknet_leaf_105_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_0_0_clk (.A(clknet_0_clk),
    .X(clknet_4_0_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_10_0_clk (.A(clknet_0_clk),
    .X(clknet_4_10_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_11_0_clk (.A(clknet_0_clk),
    .X(clknet_4_11_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_12_0_clk (.A(clknet_0_clk),
    .X(clknet_4_12_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_13_0_clk (.A(clknet_0_clk),
    .X(clknet_4_13_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_14_0_clk (.A(clknet_0_clk),
    .X(clknet_4_14_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_15_0_clk (.A(clknet_0_clk),
    .X(clknet_4_15_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_1_0_clk (.A(clknet_0_clk),
    .X(clknet_4_1_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_2_0_clk (.A(clknet_0_clk),
    .X(clknet_4_2_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_3_0_clk (.A(clknet_0_clk),
    .X(clknet_4_3_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_4_0_clk (.A(clknet_0_clk),
    .X(clknet_4_4_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_5_0_clk (.A(clknet_0_clk),
    .X(clknet_4_5_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_6_0_clk (.A(clknet_0_clk),
    .X(clknet_4_6_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_7_0_clk (.A(clknet_0_clk),
    .X(clknet_4_7_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_8_0_clk (.A(clknet_0_clk),
    .X(clknet_4_8_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_9_0_clk (.A(clknet_0_clk),
    .X(clknet_4_9_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_0_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_100_clk (.A(clknet_4_13_0_clk),
    .X(clknet_leaf_100_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_101_clk (.A(clknet_4_13_0_clk),
    .X(clknet_leaf_101_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_102_clk (.A(clknet_4_7_0_clk),
    .X(clknet_leaf_102_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_103_clk (.A(clknet_4_7_0_clk),
    .X(clknet_leaf_103_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_104_clk (.A(clknet_4_7_0_clk),
    .X(clknet_leaf_104_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_105_clk (.A(clknet_4_6_0_clk),
    .X(clknet_leaf_105_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_106_clk (.A(clknet_4_13_0_clk),
    .X(clknet_leaf_106_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_107_clk (.A(clknet_4_13_0_clk),
    .X(clknet_leaf_107_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_108_clk (.A(clknet_4_6_0_clk),
    .X(clknet_leaf_108_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_109_clk (.A(clknet_4_6_0_clk),
    .X(clknet_leaf_109_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_10_clk (.A(clknet_4_9_0_clk),
    .X(clknet_leaf_10_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_110_clk (.A(clknet_4_6_0_clk),
    .X(clknet_leaf_110_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_111_clk (.A(clknet_4_6_0_clk),
    .X(clknet_leaf_111_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_112_clk (.A(clknet_4_6_0_clk),
    .X(clknet_leaf_112_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_113_clk (.A(clknet_4_7_0_clk),
    .X(clknet_leaf_113_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_114_clk (.A(clknet_4_6_0_clk),
    .X(clknet_leaf_114_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_115_clk (.A(clknet_4_7_0_clk),
    .X(clknet_leaf_115_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_116_clk (.A(clknet_4_7_0_clk),
    .X(clknet_leaf_116_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_117_clk (.A(clknet_4_7_0_clk),
    .X(clknet_leaf_117_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_118_clk (.A(clknet_4_7_0_clk),
    .X(clknet_leaf_118_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_119_clk (.A(clknet_4_7_0_clk),
    .X(clknet_leaf_119_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_11_clk (.A(clknet_4_3_0_clk),
    .X(clknet_leaf_11_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_120_clk (.A(clknet_4_5_0_clk),
    .X(clknet_leaf_120_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_121_clk (.A(clknet_4_5_0_clk),
    .X(clknet_leaf_121_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_122_clk (.A(clknet_4_5_0_clk),
    .X(clknet_leaf_122_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_123_clk (.A(clknet_4_5_0_clk),
    .X(clknet_leaf_123_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_124_clk (.A(clknet_4_5_0_clk),
    .X(clknet_leaf_124_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_125_clk (.A(clknet_4_5_0_clk),
    .X(clknet_leaf_125_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_126_clk (.A(clknet_4_5_0_clk),
    .X(clknet_leaf_126_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_127_clk (.A(clknet_4_5_0_clk),
    .X(clknet_leaf_127_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_128_clk (.A(clknet_4_5_0_clk),
    .X(clknet_leaf_128_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_129_clk (.A(clknet_4_5_0_clk),
    .X(clknet_leaf_129_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_12_clk (.A(clknet_4_3_0_clk),
    .X(clknet_leaf_12_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_130_clk (.A(clknet_4_5_0_clk),
    .X(clknet_leaf_130_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_131_clk (.A(clknet_4_4_0_clk),
    .X(clknet_leaf_131_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_132_clk (.A(clknet_4_4_0_clk),
    .X(clknet_leaf_132_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_133_clk (.A(clknet_4_4_0_clk),
    .X(clknet_leaf_133_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_134_clk (.A(clknet_4_4_0_clk),
    .X(clknet_leaf_134_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_135_clk (.A(clknet_4_4_0_clk),
    .X(clknet_leaf_135_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_136_clk (.A(clknet_4_4_0_clk),
    .X(clknet_leaf_136_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_137_clk (.A(clknet_4_4_0_clk),
    .X(clknet_leaf_137_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_138_clk (.A(clknet_4_4_0_clk),
    .X(clknet_leaf_138_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_139_clk (.A(clknet_4_1_0_clk),
    .X(clknet_leaf_139_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_13_clk (.A(clknet_4_0_0_clk),
    .X(clknet_leaf_13_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_140_clk (.A(clknet_4_1_0_clk),
    .X(clknet_leaf_140_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_141_clk (.A(clknet_4_4_0_clk),
    .X(clknet_leaf_141_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_142_clk (.A(clknet_4_4_0_clk),
    .X(clknet_leaf_142_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_143_clk (.A(clknet_4_1_0_clk),
    .X(clknet_leaf_143_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_144_clk (.A(clknet_4_1_0_clk),
    .X(clknet_leaf_144_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_145_clk (.A(clknet_4_1_0_clk),
    .X(clknet_leaf_145_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_146_clk (.A(clknet_4_1_0_clk),
    .X(clknet_leaf_146_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_147_clk (.A(clknet_4_3_0_clk),
    .X(clknet_leaf_147_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_148_clk (.A(clknet_4_0_0_clk),
    .X(clknet_leaf_148_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_149_clk (.A(clknet_4_0_0_clk),
    .X(clknet_leaf_149_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_14_clk (.A(clknet_4_9_0_clk),
    .X(clknet_leaf_14_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_150_clk (.A(clknet_4_0_0_clk),
    .X(clknet_leaf_150_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_151_clk (.A(clknet_4_0_0_clk),
    .X(clknet_leaf_151_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_152_clk (.A(clknet_4_0_0_clk),
    .X(clknet_leaf_152_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_153_clk (.A(clknet_4_1_0_clk),
    .X(clknet_leaf_153_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_154_clk (.A(clknet_4_1_0_clk),
    .X(clknet_leaf_154_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_155_clk (.A(clknet_4_2_0_clk),
    .X(clknet_leaf_155_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_156_clk (.A(clknet_4_2_0_clk),
    .X(clknet_leaf_156_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_15_clk (.A(clknet_4_9_0_clk),
    .X(clknet_leaf_15_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_16_clk (.A(clknet_4_9_0_clk),
    .X(clknet_leaf_16_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_17_clk (.A(clknet_4_9_0_clk),
    .X(clknet_leaf_17_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_18_clk (.A(clknet_4_9_0_clk),
    .X(clknet_leaf_18_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_19_clk (.A(clknet_4_9_0_clk),
    .X(clknet_leaf_19_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_1_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_1_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_20_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_20_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_21_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_21_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_22_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_22_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_23_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_23_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_24_clk (.A(clknet_4_9_0_clk),
    .X(clknet_leaf_24_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_25_clk (.A(clknet_4_9_0_clk),
    .X(clknet_leaf_25_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_26_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_26_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_27_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_27_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_28_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_28_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_29_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_29_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_2_clk (.A(clknet_4_2_0_clk),
    .X(clknet_leaf_2_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_30_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_30_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_31_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_31_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_32_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_32_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_33_clk (.A(clknet_4_10_0_clk),
    .X(clknet_leaf_33_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_34_clk (.A(clknet_4_10_0_clk),
    .X(clknet_leaf_34_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_35_clk (.A(clknet_4_10_0_clk),
    .X(clknet_leaf_35_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_36_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_36_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_37_clk (.A(clknet_4_10_0_clk),
    .X(clknet_leaf_37_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_38_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_38_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_39_clk (.A(clknet_4_10_0_clk),
    .X(clknet_leaf_39_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_3_clk (.A(clknet_4_8_0_clk),
    .X(clknet_leaf_3_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_40_clk (.A(clknet_4_10_0_clk),
    .X(clknet_leaf_40_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_41_clk (.A(clknet_4_10_0_clk),
    .X(clknet_leaf_41_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_42_clk (.A(clknet_4_10_0_clk),
    .X(clknet_leaf_42_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_43_clk (.A(clknet_4_10_0_clk),
    .X(clknet_leaf_43_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_44_clk (.A(clknet_4_10_0_clk),
    .X(clknet_leaf_44_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_45_clk (.A(clknet_4_10_0_clk),
    .X(clknet_leaf_45_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_46_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_46_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_47_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_47_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_48_clk (.A(clknet_4_10_0_clk),
    .X(clknet_leaf_48_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_49_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_49_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_4_clk (.A(clknet_4_9_0_clk),
    .X(clknet_leaf_4_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_50_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_50_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_51_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_51_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_52_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_52_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_53_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_53_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_54_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_54_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_55_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_55_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_56_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_56_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_57_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_57_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_58_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_58_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_59_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_59_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_5_clk (.A(clknet_4_2_0_clk),
    .X(clknet_leaf_5_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_60_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_60_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_61_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_61_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_62_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_62_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_63_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_63_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_64_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_64_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_65_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_65_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_66_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_66_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_67_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_67_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_68_clk (.A(clknet_4_12_0_clk),
    .X(clknet_leaf_68_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_69_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_69_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_6_clk (.A(clknet_4_2_0_clk),
    .X(clknet_leaf_6_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_70_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_70_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_71_clk (.A(clknet_4_11_0_clk),
    .X(clknet_leaf_71_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_72_clk (.A(clknet_4_12_0_clk),
    .X(clknet_leaf_72_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_73_clk (.A(clknet_4_12_0_clk),
    .X(clknet_leaf_73_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_74_clk (.A(clknet_4_12_0_clk),
    .X(clknet_leaf_74_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_75_clk (.A(clknet_4_12_0_clk),
    .X(clknet_leaf_75_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_76_clk (.A(clknet_4_12_0_clk),
    .X(clknet_leaf_76_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_77_clk (.A(clknet_4_12_0_clk),
    .X(clknet_leaf_77_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_78_clk (.A(clknet_4_12_0_clk),
    .X(clknet_leaf_78_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_79_clk (.A(clknet_4_1_0_clk),
    .X(clknet_leaf_79_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_7_clk (.A(clknet_4_2_0_clk),
    .X(clknet_leaf_7_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_80_clk (.A(clknet_4_12_0_clk),
    .X(clknet_leaf_80_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_81_clk (.A(clknet_4_12_0_clk),
    .X(clknet_leaf_81_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_82_clk (.A(clknet_4_13_0_clk),
    .X(clknet_leaf_82_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_83_clk (.A(clknet_4_13_0_clk),
    .X(clknet_leaf_83_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_84_clk (.A(clknet_4_15_0_clk),
    .X(clknet_leaf_84_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_85_clk (.A(clknet_4_13_0_clk),
    .X(clknet_leaf_85_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_86_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_86_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_87_clk (.A(clknet_4_15_0_clk),
    .X(clknet_leaf_87_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_88_clk (.A(clknet_4_15_0_clk),
    .X(clknet_leaf_88_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_89_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_89_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_8_clk (.A(clknet_4_3_0_clk),
    .X(clknet_leaf_8_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_90_clk (.A(clknet_4_14_0_clk),
    .X(clknet_leaf_90_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_91_clk (.A(clknet_4_15_0_clk),
    .X(clknet_leaf_91_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_92_clk (.A(clknet_4_15_0_clk),
    .X(clknet_leaf_92_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_93_clk (.A(clknet_4_15_0_clk),
    .X(clknet_leaf_93_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_94_clk (.A(clknet_4_15_0_clk),
    .X(clknet_leaf_94_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_95_clk (.A(clknet_4_15_0_clk),
    .X(clknet_leaf_95_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_96_clk (.A(clknet_4_15_0_clk),
    .X(clknet_leaf_96_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_97_clk (.A(clknet_4_15_0_clk),
    .X(clknet_leaf_97_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_98_clk (.A(clknet_4_15_0_clk),
    .X(clknet_leaf_98_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_99_clk (.A(clknet_4_13_0_clk),
    .X(clknet_leaf_99_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_leaf_9_clk (.A(clknet_4_3_0_clk),
    .X(clknet_leaf_9_clk));
 sky130_fd_sc_hd__clkinv_16 clkload0 (.A(clknet_4_0_0_clk));
 sky130_fd_sc_hd__clkinv_16 clkload1 (.A(clknet_4_1_0_clk));
 sky130_fd_sc_hd__inv_16 clkload10 (.A(clknet_4_10_0_clk));
 sky130_fd_sc_hd__clkinv_2 clkload100 (.A(clknet_leaf_38_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload101 (.A(clknet_leaf_46_clk));
 sky130_fd_sc_hd__bufinv_16 clkload102 (.A(clknet_leaf_47_clk));
 sky130_fd_sc_hd__clkinv_1 clkload103 (.A(clknet_leaf_50_clk));
 sky130_fd_sc_hd__clkinv_1 clkload104 (.A(clknet_leaf_51_clk));
 sky130_fd_sc_hd__bufinv_16 clkload105 (.A(clknet_leaf_52_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload106 (.A(clknet_leaf_54_clk));
 sky130_fd_sc_hd__clkinv_2 clkload107 (.A(clknet_leaf_55_clk));
 sky130_fd_sc_hd__bufinv_16 clkload108 (.A(clknet_leaf_70_clk));
 sky130_fd_sc_hd__clkinvlp_4 clkload109 (.A(clknet_leaf_71_clk));
 sky130_fd_sc_hd__inv_6 clkload11 (.A(clknet_4_11_0_clk));
 sky130_fd_sc_hd__clkinvlp_4 clkload110 (.A(clknet_leaf_68_clk));
 sky130_fd_sc_hd__bufinv_16 clkload111 (.A(clknet_leaf_72_clk));
 sky130_fd_sc_hd__clkinv_1 clkload112 (.A(clknet_leaf_74_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload113 (.A(clknet_leaf_75_clk));
 sky130_fd_sc_hd__bufinv_16 clkload114 (.A(clknet_leaf_76_clk));
 sky130_fd_sc_hd__clkinv_2 clkload115 (.A(clknet_leaf_77_clk));
 sky130_fd_sc_hd__clkinv_4 clkload116 (.A(clknet_leaf_78_clk));
 sky130_fd_sc_hd__clkinv_2 clkload117 (.A(clknet_leaf_80_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload118 (.A(clknet_leaf_82_clk));
 sky130_fd_sc_hd__clkbuf_8 clkload119 (.A(clknet_leaf_83_clk));
 sky130_fd_sc_hd__clkinv_16 clkload12 (.A(clknet_4_12_0_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload120 (.A(clknet_leaf_85_clk));
 sky130_fd_sc_hd__clkinvlp_4 clkload121 (.A(clknet_leaf_99_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload122 (.A(clknet_leaf_100_clk));
 sky130_fd_sc_hd__clkinv_2 clkload123 (.A(clknet_leaf_101_clk));
 sky130_fd_sc_hd__bufinv_16 clkload124 (.A(clknet_leaf_107_clk));
 sky130_fd_sc_hd__clkinv_2 clkload125 (.A(clknet_leaf_53_clk));
 sky130_fd_sc_hd__clkinv_1 clkload126 (.A(clknet_leaf_56_clk));
 sky130_fd_sc_hd__clkinv_2 clkload127 (.A(clknet_leaf_57_clk));
 sky130_fd_sc_hd__clkinv_1 clkload128 (.A(clknet_leaf_58_clk));
 sky130_fd_sc_hd__bufinv_16 clkload129 (.A(clknet_leaf_59_clk));
 sky130_fd_sc_hd__clkinv_16 clkload13 (.A(clknet_4_13_0_clk));
 sky130_fd_sc_hd__clkinv_2 clkload130 (.A(clknet_leaf_61_clk));
 sky130_fd_sc_hd__clkinv_2 clkload131 (.A(clknet_leaf_62_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload132 (.A(clknet_leaf_63_clk));
 sky130_fd_sc_hd__clkinv_1 clkload133 (.A(clknet_leaf_64_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload134 (.A(clknet_leaf_65_clk));
 sky130_fd_sc_hd__clkinv_2 clkload135 (.A(clknet_leaf_66_clk));
 sky130_fd_sc_hd__clkinv_2 clkload136 (.A(clknet_leaf_67_clk));
 sky130_fd_sc_hd__clkinv_1 clkload137 (.A(clknet_leaf_86_clk));
 sky130_fd_sc_hd__clkinvlp_4 clkload138 (.A(clknet_leaf_89_clk));
 sky130_fd_sc_hd__clkinv_2 clkload139 (.A(clknet_leaf_90_clk));
 sky130_fd_sc_hd__clkinv_16 clkload14 (.A(clknet_4_15_0_clk));
 sky130_fd_sc_hd__clkinv_2 clkload140 (.A(clknet_leaf_84_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload141 (.A(clknet_leaf_87_clk));
 sky130_fd_sc_hd__clkinv_2 clkload142 (.A(clknet_leaf_92_clk));
 sky130_fd_sc_hd__clkinv_2 clkload143 (.A(clknet_leaf_94_clk));
 sky130_fd_sc_hd__clkinv_4 clkload144 (.A(clknet_leaf_95_clk));
 sky130_fd_sc_hd__clkinv_2 clkload145 (.A(clknet_leaf_96_clk));
 sky130_fd_sc_hd__clkinv_4 clkload146 (.A(clknet_leaf_97_clk));
 sky130_fd_sc_hd__clkinv_1 clkload147 (.A(clknet_leaf_98_clk));
 sky130_fd_sc_hd__clkbuf_8 clkload15 (.A(clknet_leaf_13_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload16 (.A(clknet_leaf_148_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload17 (.A(clknet_leaf_150_clk));
 sky130_fd_sc_hd__clkinv_2 clkload18 (.A(clknet_leaf_151_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload19 (.A(clknet_leaf_152_clk));
 sky130_fd_sc_hd__clkinv_16 clkload2 (.A(clknet_4_2_0_clk));
 sky130_fd_sc_hd__clkbuf_8 clkload20 (.A(clknet_leaf_79_clk));
 sky130_fd_sc_hd__clkinv_2 clkload21 (.A(clknet_leaf_139_clk));
 sky130_fd_sc_hd__clkinv_4 clkload22 (.A(clknet_leaf_140_clk));
 sky130_fd_sc_hd__clkinvlp_4 clkload23 (.A(clknet_leaf_143_clk));
 sky130_fd_sc_hd__bufinv_16 clkload24 (.A(clknet_leaf_144_clk));
 sky130_fd_sc_hd__inv_6 clkload25 (.A(clknet_leaf_145_clk));
 sky130_fd_sc_hd__clkinv_4 clkload26 (.A(clknet_leaf_153_clk));
 sky130_fd_sc_hd__clkinv_8 clkload27 (.A(clknet_leaf_154_clk));
 sky130_fd_sc_hd__clkinv_1 clkload28 (.A(clknet_leaf_2_clk));
 sky130_fd_sc_hd__clkinv_1 clkload29 (.A(clknet_leaf_7_clk));
 sky130_fd_sc_hd__clkinv_16 clkload3 (.A(clknet_4_3_0_clk));
 sky130_fd_sc_hd__bufinv_16 clkload30 (.A(clknet_leaf_155_clk));
 sky130_fd_sc_hd__inv_6 clkload31 (.A(clknet_leaf_156_clk));
 sky130_fd_sc_hd__clkinv_1 clkload32 (.A(clknet_leaf_8_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload33 (.A(clknet_leaf_11_clk));
 sky130_fd_sc_hd__clkinv_1 clkload34 (.A(clknet_leaf_12_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload35 (.A(clknet_leaf_147_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload36 (.A(clknet_leaf_131_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload37 (.A(clknet_leaf_133_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload38 (.A(clknet_leaf_135_clk));
 sky130_fd_sc_hd__clkbuf_8 clkload39 (.A(clknet_leaf_136_clk));
 sky130_fd_sc_hd__clkinv_16 clkload4 (.A(clknet_4_4_0_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload40 (.A(clknet_leaf_137_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload41 (.A(clknet_leaf_138_clk));
 sky130_fd_sc_hd__clkbuf_8 clkload42 (.A(clknet_leaf_141_clk));
 sky130_fd_sc_hd__clkinv_2 clkload43 (.A(clknet_leaf_142_clk));
 sky130_fd_sc_hd__clkbuf_8 clkload44 (.A(clknet_leaf_120_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload45 (.A(clknet_leaf_121_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload46 (.A(clknet_leaf_122_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload47 (.A(clknet_leaf_123_clk));
 sky130_fd_sc_hd__clkinv_2 clkload48 (.A(clknet_leaf_124_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload49 (.A(clknet_leaf_125_clk));
 sky130_fd_sc_hd__clkinv_16 clkload5 (.A(clknet_4_5_0_clk));
 sky130_fd_sc_hd__clkbuf_8 clkload50 (.A(clknet_leaf_126_clk));
 sky130_fd_sc_hd__clkbuf_8 clkload51 (.A(clknet_leaf_128_clk));
 sky130_fd_sc_hd__clkbuf_8 clkload52 (.A(clknet_leaf_129_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload53 (.A(clknet_leaf_130_clk));
 sky130_fd_sc_hd__clkbuf_16 clkload54 (.A(clknet_leaf_108_clk));
 sky130_fd_sc_hd__inv_6 clkload55 (.A(clknet_leaf_109_clk));
 sky130_fd_sc_hd__clkinv_2 clkload56 (.A(clknet_leaf_110_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload57 (.A(clknet_leaf_111_clk));
 sky130_fd_sc_hd__clkinvlp_4 clkload58 (.A(clknet_leaf_112_clk));
 sky130_fd_sc_hd__bufinv_16 clkload59 (.A(clknet_leaf_114_clk));
 sky130_fd_sc_hd__clkinv_16 clkload6 (.A(clknet_4_6_0_clk));
 sky130_fd_sc_hd__clkinv_1 clkload60 (.A(clknet_leaf_102_clk));
 sky130_fd_sc_hd__clkinv_2 clkload61 (.A(clknet_leaf_103_clk));
 sky130_fd_sc_hd__clkinv_1 clkload62 (.A(clknet_leaf_104_clk));
 sky130_fd_sc_hd__bufinv_16 clkload63 (.A(clknet_leaf_113_clk));
 sky130_fd_sc_hd__clkinv_2 clkload64 (.A(clknet_leaf_115_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload65 (.A(clknet_leaf_117_clk));
 sky130_fd_sc_hd__clkinv_1 clkload66 (.A(clknet_leaf_118_clk));
 sky130_fd_sc_hd__clkinv_4 clkload67 (.A(clknet_leaf_119_clk));
 sky130_fd_sc_hd__clkinv_2 clkload68 (.A(clknet_leaf_0_clk));
 sky130_fd_sc_hd__clkinv_1 clkload69 (.A(clknet_leaf_3_clk));
 sky130_fd_sc_hd__clkinv_16 clkload7 (.A(clknet_4_7_0_clk));
 sky130_fd_sc_hd__clkinv_1 clkload70 (.A(clknet_leaf_22_clk));
 sky130_fd_sc_hd__clkinv_2 clkload71 (.A(clknet_leaf_23_clk));
 sky130_fd_sc_hd__bufinv_16 clkload72 (.A(clknet_leaf_26_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload73 (.A(clknet_leaf_27_clk));
 sky130_fd_sc_hd__clkinv_2 clkload74 (.A(clknet_leaf_28_clk));
 sky130_fd_sc_hd__clkinv_1 clkload75 (.A(clknet_leaf_29_clk));
 sky130_fd_sc_hd__clkinv_2 clkload76 (.A(clknet_leaf_30_clk));
 sky130_fd_sc_hd__bufinv_16 clkload77 (.A(clknet_leaf_31_clk));
 sky130_fd_sc_hd__clkinv_1 clkload78 (.A(clknet_leaf_36_clk));
 sky130_fd_sc_hd__clkinv_1 clkload79 (.A(clknet_leaf_4_clk));
 sky130_fd_sc_hd__clkinv_8 clkload8 (.A(clknet_4_8_0_clk));
 sky130_fd_sc_hd__clkinv_2 clkload80 (.A(clknet_leaf_10_clk));
 sky130_fd_sc_hd__clkinv_1 clkload81 (.A(clknet_leaf_14_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload82 (.A(clknet_leaf_15_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload83 (.A(clknet_leaf_16_clk));
 sky130_fd_sc_hd__clkinv_1 clkload84 (.A(clknet_leaf_17_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload85 (.A(clknet_leaf_18_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload86 (.A(clknet_leaf_19_clk));
 sky130_fd_sc_hd__clkinv_1 clkload87 (.A(clknet_leaf_33_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload88 (.A(clknet_leaf_34_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload89 (.A(clknet_leaf_37_clk));
 sky130_fd_sc_hd__clkinv_16 clkload9 (.A(clknet_4_9_0_clk));
 sky130_fd_sc_hd__clkinv_2 clkload90 (.A(clknet_leaf_39_clk));
 sky130_fd_sc_hd__clkinv_1 clkload91 (.A(clknet_leaf_40_clk));
 sky130_fd_sc_hd__clkinv_1 clkload92 (.A(clknet_leaf_41_clk));
 sky130_fd_sc_hd__clkinv_2 clkload93 (.A(clknet_leaf_42_clk));
 sky130_fd_sc_hd__clkinv_2 clkload94 (.A(clknet_leaf_43_clk));
 sky130_fd_sc_hd__clkinvlp_4 clkload95 (.A(clknet_leaf_44_clk));
 sky130_fd_sc_hd__clkinvlp_4 clkload96 (.A(clknet_leaf_45_clk));
 sky130_fd_sc_hd__clkinv_1 clkload97 (.A(clknet_leaf_48_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload98 (.A(clknet_leaf_20_clk));
 sky130_fd_sc_hd__clkinv_2 clkload99 (.A(clknet_leaf_21_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[0]$_SDFF_PN0_  (.D(_0709_),
    .Q(\count_cycle[0] ),
    .CLK(clknet_leaf_131_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[10]$_SDFF_PN0_  (.D(_0699_),
    .Q(\count_cycle[10] ),
    .CLK(clknet_leaf_120_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[11]$_SDFF_PN0_  (.D(_0698_),
    .Q(\count_cycle[11] ),
    .CLK(clknet_leaf_121_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[12]$_SDFF_PN0_  (.D(_0697_),
    .Q(\count_cycle[12] ),
    .CLK(clknet_leaf_121_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[13]$_SDFF_PN0_  (.D(_0696_),
    .Q(\count_cycle[13] ),
    .CLK(clknet_leaf_130_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[14]$_SDFF_PN0_  (.D(_0695_),
    .Q(\count_cycle[14] ),
    .CLK(clknet_leaf_121_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[15]$_SDFF_PN0_  (.D(_0694_),
    .Q(\count_cycle[15] ),
    .CLK(clknet_leaf_130_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[16]$_SDFF_PN0_  (.D(_0693_),
    .Q(\count_cycle[16] ),
    .CLK(clknet_leaf_126_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[17]$_SDFF_PN0_  (.D(_0692_),
    .Q(\count_cycle[17] ),
    .CLK(clknet_leaf_129_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[18]$_SDFF_PN0_  (.D(_0691_),
    .Q(\count_cycle[18] ),
    .CLK(clknet_leaf_129_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[19]$_SDFF_PN0_  (.D(_0690_),
    .Q(\count_cycle[19] ),
    .CLK(clknet_leaf_129_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[1]$_SDFF_PN0_  (.D(_0708_),
    .Q(\count_cycle[1] ),
    .CLK(clknet_leaf_130_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[20]$_SDFF_PN0_  (.D(_0689_),
    .Q(\count_cycle[20] ),
    .CLK(clknet_leaf_129_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[21]$_SDFF_PN0_  (.D(_0688_),
    .Q(\count_cycle[21] ),
    .CLK(clknet_leaf_130_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[22]$_SDFF_PN0_  (.D(_0687_),
    .Q(\count_cycle[22] ),
    .CLK(clknet_leaf_130_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[23]$_SDFF_PN0_  (.D(_0686_),
    .Q(\count_cycle[23] ),
    .CLK(clknet_leaf_130_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[24]$_SDFF_PN0_  (.D(_0685_),
    .Q(\count_cycle[24] ),
    .CLK(clknet_leaf_129_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[25]$_SDFF_PN0_  (.D(_0684_),
    .Q(\count_cycle[25] ),
    .CLK(clknet_leaf_133_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[26]$_SDFF_PN0_  (.D(_0683_),
    .Q(\count_cycle[26] ),
    .CLK(clknet_leaf_133_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[27]$_SDFF_PN0_  (.D(_0682_),
    .Q(\count_cycle[27] ),
    .CLK(clknet_leaf_133_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[28]$_SDFF_PN0_  (.D(_0681_),
    .Q(\count_cycle[28] ),
    .CLK(clknet_leaf_132_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[29]$_SDFF_PN0_  (.D(_0680_),
    .Q(\count_cycle[29] ),
    .CLK(clknet_leaf_131_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[2]$_SDFF_PN0_  (.D(_0707_),
    .Q(\count_cycle[2] ),
    .CLK(clknet_leaf_131_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[30]$_SDFF_PN0_  (.D(_0679_),
    .Q(\count_cycle[30] ),
    .CLK(clknet_leaf_131_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[31]$_SDFF_PN0_  (.D(_0678_),
    .Q(\count_cycle[31] ),
    .CLK(clknet_leaf_131_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[32]$_SDFF_PN0_  (.D(_0677_),
    .Q(\count_cycle[32] ),
    .CLK(clknet_leaf_130_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[33]$_SDFF_PN0_  (.D(_0676_),
    .Q(\count_cycle[33] ),
    .CLK(clknet_leaf_131_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[34]$_SDFF_PN0_  (.D(_0675_),
    .Q(\count_cycle[34] ),
    .CLK(clknet_leaf_130_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[35]$_SDFF_PN0_  (.D(_0674_),
    .Q(\count_cycle[35] ),
    .CLK(clknet_leaf_129_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[36]$_SDFF_PN0_  (.D(_0673_),
    .Q(\count_cycle[36] ),
    .CLK(clknet_leaf_130_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[37]$_SDFF_PN0_  (.D(_0672_),
    .Q(\count_cycle[37] ),
    .CLK(clknet_leaf_129_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[38]$_SDFF_PN0_  (.D(_0671_),
    .Q(\count_cycle[38] ),
    .CLK(clknet_leaf_124_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[39]$_SDFF_PN0_  (.D(_0670_),
    .Q(\count_cycle[39] ),
    .CLK(clknet_leaf_122_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[3]$_SDFF_PN0_  (.D(_0706_),
    .Q(\count_cycle[3] ),
    .CLK(clknet_leaf_120_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[40]$_SDFF_PN0_  (.D(_0669_),
    .Q(\count_cycle[40] ),
    .CLK(clknet_leaf_122_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[41]$_SDFF_PN0_  (.D(_0668_),
    .Q(\count_cycle[41] ),
    .CLK(clknet_leaf_122_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[42]$_SDFF_PN0_  (.D(_0667_),
    .Q(\count_cycle[42] ),
    .CLK(clknet_leaf_123_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[43]$_SDFF_PN0_  (.D(_0666_),
    .Q(\count_cycle[43] ),
    .CLK(clknet_leaf_124_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[44]$_SDFF_PN0_  (.D(_0665_),
    .Q(\count_cycle[44] ),
    .CLK(clknet_leaf_123_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[45]$_SDFF_PN0_  (.D(_0664_),
    .Q(\count_cycle[45] ),
    .CLK(clknet_leaf_124_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[46]$_SDFF_PN0_  (.D(_0663_),
    .Q(\count_cycle[46] ),
    .CLK(clknet_leaf_124_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[47]$_SDFF_PN0_  (.D(_0662_),
    .Q(\count_cycle[47] ),
    .CLK(clknet_leaf_124_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[48]$_SDFF_PN0_  (.D(_0661_),
    .Q(\count_cycle[48] ),
    .CLK(clknet_leaf_124_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[49]$_SDFF_PN0_  (.D(_0660_),
    .Q(\count_cycle[49] ),
    .CLK(clknet_leaf_127_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[4]$_SDFF_PN0_  (.D(_0705_),
    .Q(\count_cycle[4] ),
    .CLK(clknet_leaf_120_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[50]$_SDFF_PN0_  (.D(_0659_),
    .Q(\count_cycle[50] ),
    .CLK(clknet_leaf_126_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[51]$_SDFF_PN0_  (.D(_0658_),
    .Q(\count_cycle[51] ),
    .CLK(clknet_leaf_127_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[52]$_SDFF_PN0_  (.D(_0657_),
    .Q(\count_cycle[52] ),
    .CLK(clknet_leaf_126_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[53]$_SDFF_PN0_  (.D(_0656_),
    .Q(\count_cycle[53] ),
    .CLK(clknet_leaf_128_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[54]$_SDFF_PN0_  (.D(_0655_),
    .Q(\count_cycle[54] ),
    .CLK(clknet_leaf_128_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[55]$_SDFF_PN0_  (.D(_0654_),
    .Q(\count_cycle[55] ),
    .CLK(clknet_leaf_128_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[56]$_SDFF_PN0_  (.D(_0653_),
    .Q(\count_cycle[56] ),
    .CLK(clknet_leaf_128_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[57]$_SDFF_PN0_  (.D(_0652_),
    .Q(\count_cycle[57] ),
    .CLK(clknet_leaf_134_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[58]$_SDFF_PN0_  (.D(_0651_),
    .Q(\count_cycle[58] ),
    .CLK(clknet_leaf_134_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[59]$_SDFF_PN0_  (.D(_0650_),
    .Q(\count_cycle[59] ),
    .CLK(clknet_leaf_134_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[5]$_SDFF_PN0_  (.D(_0704_),
    .Q(\count_cycle[5] ),
    .CLK(clknet_leaf_120_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[60]$_SDFF_PN0_  (.D(_0649_),
    .Q(\count_cycle[60] ),
    .CLK(clknet_leaf_135_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[61]$_SDFF_PN0_  (.D(_0648_),
    .Q(\count_cycle[61] ),
    .CLK(clknet_leaf_135_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[62]$_SDFF_PN0_  (.D(_0647_),
    .Q(\count_cycle[62] ),
    .CLK(clknet_leaf_135_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[63]$_SDFF_PN0_  (.D(_0776_),
    .Q(\count_cycle[63] ),
    .CLK(clknet_leaf_135_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[6]$_SDFF_PN0_  (.D(_0703_),
    .Q(\count_cycle[6] ),
    .CLK(clknet_leaf_120_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[7]$_SDFF_PN0_  (.D(_0702_),
    .Q(\count_cycle[7] ),
    .CLK(clknet_leaf_120_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[8]$_SDFF_PN0_  (.D(_0701_),
    .Q(\count_cycle[8] ),
    .CLK(clknet_leaf_130_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_cycle[9]$_SDFF_PN0_  (.D(_0700_),
    .Q(\count_cycle[9] ),
    .CLK(clknet_leaf_120_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[0]$_SDFFE_PN0P_  (.D(_0616_),
    .Q(\count_instr[0] ),
    .CLK(clknet_leaf_121_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[10]$_SDFFE_PN0P_  (.D(_0606_),
    .Q(\count_instr[10] ),
    .CLK(clknet_leaf_122_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[11]$_SDFFE_PN0P_  (.D(_0605_),
    .Q(\count_instr[11] ),
    .CLK(clknet_leaf_122_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[12]$_SDFFE_PN0P_  (.D(_0604_),
    .Q(\count_instr[12] ),
    .CLK(clknet_leaf_123_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[13]$_SDFFE_PN0P_  (.D(_0603_),
    .Q(\count_instr[13] ),
    .CLK(clknet_leaf_125_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[14]$_SDFFE_PN0P_  (.D(_0602_),
    .Q(\count_instr[14] ),
    .CLK(clknet_leaf_125_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[15]$_SDFFE_PN0P_  (.D(_0601_),
    .Q(\count_instr[15] ),
    .CLK(clknet_leaf_125_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[16]$_SDFFE_PN0P_  (.D(_0600_),
    .Q(\count_instr[16] ),
    .CLK(clknet_leaf_125_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[17]$_SDFFE_PN0P_  (.D(_0599_),
    .Q(\count_instr[17] ),
    .CLK(clknet_leaf_125_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[18]$_SDFFE_PN0P_  (.D(_0598_),
    .Q(\count_instr[18] ),
    .CLK(clknet_leaf_125_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[19]$_SDFFE_PN0P_  (.D(_0597_),
    .Q(\count_instr[19] ),
    .CLK(clknet_leaf_125_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[1]$_SDFFE_PN0P_  (.D(_0615_),
    .Q(\count_instr[1] ),
    .CLK(clknet_leaf_121_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[20]$_SDFFE_PN0P_  (.D(_0596_),
    .Q(\count_instr[20] ),
    .CLK(clknet_leaf_126_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[21]$_SDFFE_PN0P_  (.D(_0595_),
    .Q(\count_instr[21] ),
    .CLK(clknet_leaf_126_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[22]$_SDFFE_PN0P_  (.D(_0594_),
    .Q(\count_instr[22] ),
    .CLK(clknet_leaf_128_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[23]$_SDFFE_PN0P_  (.D(_0593_),
    .Q(\count_instr[23] ),
    .CLK(clknet_leaf_128_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[24]$_SDFFE_PN0P_  (.D(_0592_),
    .Q(\count_instr[24] ),
    .CLK(clknet_leaf_128_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[25]$_SDFFE_PN0P_  (.D(_0591_),
    .Q(\count_instr[25] ),
    .CLK(clknet_leaf_134_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[26]$_SDFFE_PN0P_  (.D(_0590_),
    .Q(\count_instr[26] ),
    .CLK(clknet_leaf_133_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[27]$_SDFFE_PN0P_  (.D(_0589_),
    .Q(\count_instr[27] ),
    .CLK(clknet_leaf_133_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[28]$_SDFFE_PN0P_  (.D(_0588_),
    .Q(\count_instr[28] ),
    .CLK(clknet_leaf_133_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[29]$_SDFFE_PN0P_  (.D(_0587_),
    .Q(\count_instr[29] ),
    .CLK(clknet_leaf_133_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[2]$_SDFFE_PN0P_  (.D(_0614_),
    .Q(\count_instr[2] ),
    .CLK(clknet_leaf_121_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[30]$_SDFFE_PN0P_  (.D(_0586_),
    .Q(\count_instr[30] ),
    .CLK(clknet_leaf_133_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[31]$_SDFFE_PN0P_  (.D(_0585_),
    .Q(\count_instr[31] ),
    .CLK(clknet_leaf_132_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[32]$_SDFFE_PN0P_  (.D(_0584_),
    .Q(\count_instr[32] ),
    .CLK(clknet_leaf_128_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[33]$_SDFFE_PN0P_  (.D(_0583_),
    .Q(\count_instr[33] ),
    .CLK(clknet_leaf_128_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[34]$_SDFFE_PN0P_  (.D(_0582_),
    .Q(\count_instr[34] ),
    .CLK(clknet_leaf_129_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[35]$_SDFFE_PN0P_  (.D(_0581_),
    .Q(\count_instr[35] ),
    .CLK(clknet_leaf_129_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[36]$_SDFFE_PN0P_  (.D(_0580_),
    .Q(\count_instr[36] ),
    .CLK(clknet_leaf_126_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[37]$_SDFFE_PN0P_  (.D(_0579_),
    .Q(\count_instr[37] ),
    .CLK(clknet_leaf_126_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[38]$_SDFFE_PN0P_  (.D(_0578_),
    .Q(\count_instr[38] ),
    .CLK(clknet_leaf_123_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[39]$_SDFFE_PN0P_  (.D(_0577_),
    .Q(\count_instr[39] ),
    .CLK(clknet_leaf_123_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[3]$_SDFFE_PN0P_  (.D(_0613_),
    .Q(\count_instr[3] ),
    .CLK(clknet_leaf_126_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[40]$_SDFFE_PN0P_  (.D(_0576_),
    .Q(\count_instr[40] ),
    .CLK(clknet_leaf_123_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[41]$_SDFFE_PN0P_  (.D(_0575_),
    .Q(\count_instr[41] ),
    .CLK(clknet_leaf_124_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[42]$_SDFFE_PN0P_  (.D(_0574_),
    .Q(\count_instr[42] ),
    .CLK(clknet_leaf_123_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[43]$_SDFFE_PN0P_  (.D(_0573_),
    .Q(\count_instr[43] ),
    .CLK(clknet_leaf_124_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[44]$_SDFFE_PN0P_  (.D(_0572_),
    .Q(\count_instr[44] ),
    .CLK(clknet_leaf_123_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[45]$_SDFFE_PN0P_  (.D(_0571_),
    .Q(\count_instr[45] ),
    .CLK(clknet_leaf_125_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[46]$_SDFFE_PN0P_  (.D(_0570_),
    .Q(\count_instr[46] ),
    .CLK(clknet_leaf_125_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[47]$_SDFFE_PN0P_  (.D(_0569_),
    .Q(\count_instr[47] ),
    .CLK(clknet_leaf_125_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[48]$_SDFFE_PN0P_  (.D(_0568_),
    .Q(\count_instr[48] ),
    .CLK(clknet_leaf_127_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[49]$_SDFFE_PN0P_  (.D(_0567_),
    .Q(\count_instr[49] ),
    .CLK(clknet_leaf_127_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[4]$_SDFFE_PN0P_  (.D(_0612_),
    .Q(\count_instr[4] ),
    .CLK(clknet_leaf_123_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[50]$_SDFFE_PN0P_  (.D(_0566_),
    .Q(\count_instr[50] ),
    .CLK(clknet_leaf_127_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[51]$_SDFFE_PN0P_  (.D(_0565_),
    .Q(\count_instr[51] ),
    .CLK(clknet_leaf_127_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[52]$_SDFFE_PN0P_  (.D(_0564_),
    .Q(\count_instr[52] ),
    .CLK(clknet_leaf_127_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[53]$_SDFFE_PN0P_  (.D(_0563_),
    .Q(\count_instr[53] ),
    .CLK(clknet_leaf_127_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[54]$_SDFFE_PN0P_  (.D(_0562_),
    .Q(\count_instr[54] ),
    .CLK(clknet_leaf_127_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[55]$_SDFFE_PN0P_  (.D(_0561_),
    .Q(\count_instr[55] ),
    .CLK(clknet_leaf_127_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[56]$_SDFFE_PN0P_  (.D(_0560_),
    .Q(\count_instr[56] ),
    .CLK(clknet_leaf_127_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[57]$_SDFFE_PN0P_  (.D(_0559_),
    .Q(\count_instr[57] ),
    .CLK(clknet_leaf_134_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[58]$_SDFFE_PN0P_  (.D(_0558_),
    .Q(\count_instr[58] ),
    .CLK(clknet_leaf_134_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[59]$_SDFFE_PN0P_  (.D(_0557_),
    .Q(\count_instr[59] ),
    .CLK(clknet_leaf_134_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[5]$_SDFFE_PN0P_  (.D(_0611_),
    .Q(\count_instr[5] ),
    .CLK(clknet_leaf_126_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[60]$_SDFFE_PN0P_  (.D(_0556_),
    .Q(\count_instr[60] ),
    .CLK(clknet_leaf_134_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[61]$_SDFFE_PN0P_  (.D(_0555_),
    .Q(\count_instr[61] ),
    .CLK(clknet_leaf_134_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[62]$_SDFFE_PN0P_  (.D(_0554_),
    .Q(\count_instr[62] ),
    .CLK(clknet_leaf_133_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[63]$_SDFFE_PN0P_  (.D(_0765_),
    .Q(\count_instr[63] ),
    .CLK(clknet_leaf_135_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[6]$_SDFFE_PN0P_  (.D(_0610_),
    .Q(\count_instr[6] ),
    .CLK(clknet_leaf_123_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[7]$_SDFFE_PN0P_  (.D(_0609_),
    .Q(\count_instr[7] ),
    .CLK(clknet_leaf_121_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[8]$_SDFFE_PN0P_  (.D(_0608_),
    .Q(\count_instr[8] ),
    .CLK(clknet_leaf_122_clk));
 sky130_fd_sc_hd__dfxtp_1 \count_instr[9]$_SDFFE_PN0P_  (.D(_0607_),
    .Q(\count_instr[9] ),
    .CLK(clknet_leaf_122_clk));
 sky130_fd_sc_hd__dfxtp_1 \cpu_state[0]$_DFF_P_  (.D(_0496_),
    .Q(\cpu_state[0] ),
    .CLK(clknet_leaf_140_clk));
 sky130_fd_sc_hd__dfxtp_1 \cpu_state[1]$_DFF_P_  (.D(_0497_),
    .Q(\cpu_state[1] ),
    .CLK(clknet_leaf_142_clk));
 sky130_fd_sc_hd__dfxtp_1 \cpu_state[2]$_DFF_P_  (.D(_0498_),
    .Q(\cpu_state[2] ),
    .CLK(clknet_leaf_143_clk));
 sky130_fd_sc_hd__dfxtp_1 \cpu_state[3]$_DFF_P_  (.D(_0499_),
    .Q(\cpu_state[3] ),
    .CLK(clknet_leaf_140_clk));
 sky130_fd_sc_hd__dfxtp_1 \cpu_state[4]$_DFF_P_  (.D(_0500_),
    .Q(\cpu_state[4] ),
    .CLK(clknet_leaf_140_clk));
 sky130_fd_sc_hd__dfxtp_1 \cpu_state[5]$_DFF_P_  (.D(_0501_),
    .Q(\cpu_state[5] ),
    .CLK(clknet_leaf_140_clk));
 sky130_fd_sc_hd__dfxtp_1 \cpu_state[6]$_DFF_P_  (.D(_0502_),
    .Q(\cpu_state[6] ),
    .CLK(clknet_leaf_142_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net106),
    .Q(\cpuregs[0][0] ),
    .CLK(clknet_leaf_8_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][0]$_DFFE_PP__107  (.LO(net106));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net107),
    .Q(\cpuregs[0][10] ),
    .CLK(clknet_leaf_38_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][10]$_DFFE_PP__108  (.LO(net107));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net108),
    .Q(\cpuregs[0][11] ),
    .CLK(clknet_leaf_97_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][11]$_DFFE_PP__109  (.LO(net108));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][12]$_DFFE_PP_  (.D(net685),
    .DE(net109),
    .Q(\cpuregs[0][12] ),
    .CLK(clknet_leaf_58_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][12]$_DFFE_PP__110  (.LO(net109));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net110),
    .Q(\cpuregs[0][13] ),
    .CLK(clknet_leaf_94_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][13]$_DFFE_PP__111  (.LO(net110));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net111),
    .Q(\cpuregs[0][14] ),
    .CLK(clknet_leaf_94_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][14]$_DFFE_PP__112  (.LO(net111));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net112),
    .Q(\cpuregs[0][15] ),
    .CLK(clknet_leaf_56_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][15]$_DFFE_PP__113  (.LO(net112));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net113),
    .Q(\cpuregs[0][16] ),
    .CLK(clknet_leaf_94_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][16]$_DFFE_PP__114  (.LO(net113));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][17]$_DFFE_PP_  (.D(net686),
    .DE(net114),
    .Q(\cpuregs[0][17] ),
    .CLK(clknet_leaf_22_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][17]$_DFFE_PP__115  (.LO(net114));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][18]$_DFFE_PP_  (.D(net651),
    .DE(net115),
    .Q(\cpuregs[0][18] ),
    .CLK(clknet_leaf_83_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][18]$_DFFE_PP__116  (.LO(net115));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][19]$_DFFE_PP_  (.D(net652),
    .DE(net116),
    .Q(\cpuregs[0][19] ),
    .CLK(clknet_leaf_22_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][19]$_DFFE_PP__117  (.LO(net116));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net117),
    .Q(\cpuregs[0][1] ),
    .CLK(clknet_leaf_7_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][1]$_DFFE_PP__118  (.LO(net117));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][20]$_DFFE_PP_  (.D(net647),
    .DE(net118),
    .Q(\cpuregs[0][20] ),
    .CLK(clknet_leaf_72_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][20]$_DFFE_PP__119  (.LO(net118));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][21]$_DFFE_PP_  (.D(net648),
    .DE(net119),
    .Q(\cpuregs[0][21] ),
    .CLK(clknet_leaf_65_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][21]$_DFFE_PP__120  (.LO(net119));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net120),
    .Q(\cpuregs[0][22] ),
    .CLK(clknet_leaf_4_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][22]$_DFFE_PP__121  (.LO(net120));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][23]$_DFFE_PP_  (.D(net649),
    .DE(net121),
    .Q(\cpuregs[0][23] ),
    .CLK(clknet_leaf_22_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][23]$_DFFE_PP__122  (.LO(net121));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net122),
    .Q(\cpuregs[0][24] ),
    .CLK(clknet_leaf_93_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][24]$_DFFE_PP__123  (.LO(net122));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][25]$_DFFE_PP_  (.D(net640),
    .DE(net123),
    .Q(\cpuregs[0][25] ),
    .CLK(clknet_leaf_75_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][25]$_DFFE_PP__124  (.LO(net123));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][26]$_DFFE_PP_  (.D(net643),
    .DE(net124),
    .Q(\cpuregs[0][26] ),
    .CLK(clknet_leaf_147_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][26]$_DFFE_PP__125  (.LO(net124));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][27]$_DFFE_PP_  (.D(net644),
    .DE(net125),
    .Q(\cpuregs[0][27] ),
    .CLK(clknet_leaf_8_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][27]$_DFFE_PP__126  (.LO(net125));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][28]$_DFFE_PP_  (.D(net645),
    .DE(net126),
    .Q(\cpuregs[0][28] ),
    .CLK(clknet_leaf_12_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][28]$_DFFE_PP__127  (.LO(net126));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][29]$_DFFE_PP_  (.D(net641),
    .DE(net127),
    .Q(\cpuregs[0][29] ),
    .CLK(clknet_leaf_82_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][29]$_DFFE_PP__128  (.LO(net127));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net128),
    .Q(\cpuregs[0][2] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][2]$_DFFE_PP__129  (.LO(net128));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][30]$_DFFE_PP_  (.D(net646),
    .DE(net129),
    .Q(\cpuregs[0][30] ),
    .CLK(clknet_leaf_79_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][30]$_DFFE_PP__130  (.LO(net129));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][31]$_DFFE_PP_  (.D(net639),
    .DE(net130),
    .Q(\cpuregs[0][31] ),
    .CLK(clknet_leaf_9_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][31]$_DFFE_PP__131  (.LO(net130));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net131),
    .Q(\cpuregs[0][3] ),
    .CLK(clknet_leaf_2_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][3]$_DFFE_PP__132  (.LO(net131));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net132),
    .Q(\cpuregs[0][4] ),
    .CLK(clknet_leaf_20_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][4]$_DFFE_PP__133  (.LO(net132));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net133),
    .Q(\cpuregs[0][5] ),
    .CLK(clknet_leaf_55_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][5]$_DFFE_PP__134  (.LO(net133));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net134),
    .Q(\cpuregs[0][6] ),
    .CLK(clknet_leaf_55_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][6]$_DFFE_PP__135  (.LO(net134));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][7]$_DFFE_PP_  (.D(net691),
    .DE(net135),
    .Q(\cpuregs[0][7] ),
    .CLK(clknet_leaf_48_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][7]$_DFFE_PP__136  (.LO(net135));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][8]$_DFFE_PP_  (.D(net688),
    .DE(net136),
    .Q(\cpuregs[0][8] ),
    .CLK(clknet_leaf_39_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][8]$_DFFE_PP__137  (.LO(net136));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[0][9]$_DFFE_PP_  (.D(net692),
    .DE(net137),
    .Q(\cpuregs[0][9] ),
    .CLK(clknet_leaf_48_clk));
 sky130_fd_sc_hd__conb_1 \cpuregs[0][9]$_DFFE_PP__138  (.LO(net137));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(_0818_),
    .Q(\cpuregs[10][0] ),
    .CLK(clknet_leaf_17_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net670),
    .Q(\cpuregs[10][10] ),
    .CLK(clknet_leaf_38_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net670),
    .Q(\cpuregs[10][11] ),
    .CLK(clknet_leaf_62_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][12]$_DFFE_PP_  (.D(net685),
    .DE(net670),
    .Q(\cpuregs[10][12] ),
    .CLK(clknet_leaf_66_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(_0818_),
    .Q(\cpuregs[10][13] ),
    .CLK(clknet_leaf_87_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(_0818_),
    .Q(\cpuregs[10][14] ),
    .CLK(clknet_leaf_87_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net670),
    .Q(\cpuregs[10][15] ),
    .CLK(clknet_leaf_67_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(_0818_),
    .Q(\cpuregs[10][16] ),
    .CLK(clknet_leaf_86_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][17]$_DFFE_PP_  (.D(net686),
    .DE(net670),
    .Q(\cpuregs[10][17] ),
    .CLK(clknet_leaf_23_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][18]$_DFFE_PP_  (.D(net651),
    .DE(_0818_),
    .Q(\cpuregs[10][18] ),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][19]$_DFFE_PP_  (.D(net652),
    .DE(net670),
    .Q(\cpuregs[10][19] ),
    .CLK(clknet_leaf_23_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(_0818_),
    .Q(\cpuregs[10][1] ),
    .CLK(clknet_leaf_17_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][20]$_DFFE_PP_  (.D(net647),
    .DE(net670),
    .Q(\cpuregs[10][20] ),
    .CLK(clknet_leaf_18_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][21]$_DFFE_PP_  (.D(net648),
    .DE(net670),
    .Q(\cpuregs[10][21] ),
    .CLK(clknet_leaf_70_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(_0818_),
    .Q(\cpuregs[10][22] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][23]$_DFFE_PP_  (.D(net649),
    .DE(net670),
    .Q(\cpuregs[10][23] ),
    .CLK(clknet_leaf_21_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(_0818_),
    .Q(\cpuregs[10][24] ),
    .CLK(clknet_leaf_87_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][25]$_DFFE_PP_  (.D(net640),
    .DE(_0818_),
    .Q(\cpuregs[10][25] ),
    .CLK(clknet_leaf_76_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][26]$_DFFE_PP_  (.D(net643),
    .DE(_0818_),
    .Q(\cpuregs[10][26] ),
    .CLK(clknet_leaf_14_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][27]$_DFFE_PP_  (.D(net644),
    .DE(_0818_),
    .Q(\cpuregs[10][27] ),
    .CLK(clknet_leaf_10_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][28]$_DFFE_PP_  (.D(net645),
    .DE(_0818_),
    .Q(\cpuregs[10][28] ),
    .CLK(clknet_leaf_14_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][29]$_DFFE_PP_  (.D(net641),
    .DE(_0818_),
    .Q(\cpuregs[10][29] ),
    .CLK(clknet_leaf_80_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(_0818_),
    .Q(\cpuregs[10][2] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][30]$_DFFE_PP_  (.D(net646),
    .DE(_0818_),
    .Q(\cpuregs[10][30] ),
    .CLK(clknet_leaf_80_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][31]$_DFFE_PP_  (.D(net639),
    .DE(_0818_),
    .Q(\cpuregs[10][31] ),
    .CLK(clknet_leaf_17_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(_0818_),
    .Q(\cpuregs[10][3] ),
    .CLK(clknet_leaf_3_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net670),
    .Q(\cpuregs[10][4] ),
    .CLK(clknet_leaf_21_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net670),
    .Q(\cpuregs[10][5] ),
    .CLK(clknet_leaf_52_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net670),
    .Q(\cpuregs[10][6] ),
    .CLK(clknet_leaf_52_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][7]$_DFFE_PP_  (.D(net691),
    .DE(net670),
    .Q(\cpuregs[10][7] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][8]$_DFFE_PP_  (.D(net688),
    .DE(net670),
    .Q(\cpuregs[10][8] ),
    .CLK(clknet_leaf_38_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[10][9]$_DFFE_PP_  (.D(net692),
    .DE(net670),
    .Q(\cpuregs[10][9] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(_0819_),
    .Q(\cpuregs[11][0] ),
    .CLK(clknet_leaf_17_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net671),
    .Q(\cpuregs[11][10] ),
    .CLK(clknet_leaf_38_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net671),
    .Q(\cpuregs[11][11] ),
    .CLK(clknet_leaf_87_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][12]$_DFFE_PP_  (.D(net685),
    .DE(net671),
    .Q(\cpuregs[11][12] ),
    .CLK(clknet_leaf_62_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net671),
    .Q(\cpuregs[11][13] ),
    .CLK(clknet_leaf_88_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net671),
    .Q(\cpuregs[11][14] ),
    .CLK(clknet_leaf_88_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net671),
    .Q(\cpuregs[11][15] ),
    .CLK(clknet_leaf_67_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net671),
    .Q(\cpuregs[11][16] ),
    .CLK(clknet_leaf_86_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][17]$_DFFE_PP_  (.D(net686),
    .DE(net671),
    .Q(\cpuregs[11][17] ),
    .CLK(clknet_leaf_19_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][18]$_DFFE_PP_  (.D(net651),
    .DE(net671),
    .Q(\cpuregs[11][18] ),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][19]$_DFFE_PP_  (.D(net652),
    .DE(net671),
    .Q(\cpuregs[11][19] ),
    .CLK(clknet_leaf_23_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(_0819_),
    .Q(\cpuregs[11][1] ),
    .CLK(clknet_leaf_18_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][20]$_DFFE_PP_  (.D(net647),
    .DE(net671),
    .Q(\cpuregs[11][20] ),
    .CLK(clknet_leaf_19_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][21]$_DFFE_PP_  (.D(net648),
    .DE(net671),
    .Q(\cpuregs[11][21] ),
    .CLK(clknet_leaf_68_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net671),
    .Q(\cpuregs[11][22] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][23]$_DFFE_PP_  (.D(net649),
    .DE(net671),
    .Q(\cpuregs[11][23] ),
    .CLK(clknet_leaf_21_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net671),
    .Q(\cpuregs[11][24] ),
    .CLK(clknet_leaf_87_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][25]$_DFFE_PP_  (.D(net640),
    .DE(_0819_),
    .Q(\cpuregs[11][25] ),
    .CLK(clknet_leaf_76_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][26]$_DFFE_PP_  (.D(net643),
    .DE(_0819_),
    .Q(\cpuregs[11][26] ),
    .CLK(clknet_leaf_14_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][27]$_DFFE_PP_  (.D(net644),
    .DE(_0819_),
    .Q(\cpuregs[11][27] ),
    .CLK(clknet_leaf_16_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][28]$_DFFE_PP_  (.D(net645),
    .DE(_0819_),
    .Q(\cpuregs[11][28] ),
    .CLK(clknet_leaf_14_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][29]$_DFFE_PP_  (.D(net641),
    .DE(net671),
    .Q(\cpuregs[11][29] ),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net671),
    .Q(\cpuregs[11][2] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][30]$_DFFE_PP_  (.D(net646),
    .DE(net671),
    .Q(\cpuregs[11][30] ),
    .CLK(clknet_leaf_80_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][31]$_DFFE_PP_  (.D(net639),
    .DE(_0819_),
    .Q(\cpuregs[11][31] ),
    .CLK(clknet_leaf_18_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net671),
    .Q(\cpuregs[11][3] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net671),
    .Q(\cpuregs[11][4] ),
    .CLK(clknet_leaf_21_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net671),
    .Q(\cpuregs[11][5] ),
    .CLK(clknet_leaf_52_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net671),
    .Q(\cpuregs[11][6] ),
    .CLK(clknet_leaf_51_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][7]$_DFFE_PP_  (.D(net691),
    .DE(net671),
    .Q(\cpuregs[11][7] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][8]$_DFFE_PP_  (.D(net688),
    .DE(net671),
    .Q(\cpuregs[11][8] ),
    .CLK(clknet_leaf_38_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[11][9]$_DFFE_PP_  (.D(net692),
    .DE(net671),
    .Q(\cpuregs[11][9] ),
    .CLK(clknet_leaf_47_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(_0820_),
    .Q(\cpuregs[12][0] ),
    .CLK(clknet_leaf_19_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net672),
    .Q(\cpuregs[12][10] ),
    .CLK(clknet_leaf_37_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net672),
    .Q(\cpuregs[12][11] ),
    .CLK(clknet_leaf_88_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][12]$_DFFE_PP_  (.D(net685),
    .DE(net672),
    .Q(\cpuregs[12][12] ),
    .CLK(clknet_leaf_61_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net672),
    .Q(\cpuregs[12][13] ),
    .CLK(clknet_leaf_92_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net672),
    .Q(\cpuregs[12][14] ),
    .CLK(clknet_leaf_84_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net672),
    .Q(\cpuregs[12][15] ),
    .CLK(clknet_leaf_53_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net672),
    .Q(\cpuregs[12][16] ),
    .CLK(clknet_leaf_85_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][17]$_DFFE_PP_  (.D(net686),
    .DE(net672),
    .Q(\cpuregs[12][17] ),
    .CLK(clknet_leaf_22_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][18]$_DFFE_PP_  (.D(net651),
    .DE(net672),
    .Q(\cpuregs[12][18] ),
    .CLK(clknet_leaf_83_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][19]$_DFFE_PP_  (.D(net652),
    .DE(_0820_),
    .Q(\cpuregs[12][19] ),
    .CLK(clknet_leaf_23_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(_0820_),
    .Q(\cpuregs[12][1] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][20]$_DFFE_PP_  (.D(net647),
    .DE(net672),
    .Q(\cpuregs[12][20] ),
    .CLK(clknet_leaf_70_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][21]$_DFFE_PP_  (.D(net648),
    .DE(net672),
    .Q(\cpuregs[12][21] ),
    .CLK(clknet_leaf_70_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(_0820_),
    .Q(\cpuregs[12][22] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][23]$_DFFE_PP_  (.D(net649),
    .DE(net672),
    .Q(\cpuregs[12][23] ),
    .CLK(clknet_leaf_20_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net672),
    .Q(\cpuregs[12][24] ),
    .CLK(clknet_leaf_84_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][25]$_DFFE_PP_  (.D(net640),
    .DE(net672),
    .Q(\cpuregs[12][25] ),
    .CLK(clknet_leaf_76_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][26]$_DFFE_PP_  (.D(net643),
    .DE(_0820_),
    .Q(\cpuregs[12][26] ),
    .CLK(clknet_leaf_14_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][27]$_DFFE_PP_  (.D(net644),
    .DE(_0820_),
    .Q(\cpuregs[12][27] ),
    .CLK(clknet_leaf_15_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][28]$_DFFE_PP_  (.D(net645),
    .DE(_0820_),
    .Q(\cpuregs[12][28] ),
    .CLK(clknet_leaf_15_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][29]$_DFFE_PP_  (.D(net641),
    .DE(net672),
    .Q(\cpuregs[12][29] ),
    .CLK(clknet_leaf_79_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(_0820_),
    .Q(\cpuregs[12][2] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][30]$_DFFE_PP_  (.D(net646),
    .DE(net672),
    .Q(\cpuregs[12][30] ),
    .CLK(clknet_leaf_80_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][31]$_DFFE_PP_  (.D(net639),
    .DE(_0820_),
    .Q(\cpuregs[12][31] ),
    .CLK(clknet_leaf_18_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(_0820_),
    .Q(\cpuregs[12][3] ),
    .CLK(clknet_leaf_26_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net672),
    .Q(\cpuregs[12][4] ),
    .CLK(clknet_leaf_21_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net672),
    .Q(\cpuregs[12][5] ),
    .CLK(clknet_leaf_54_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net672),
    .Q(\cpuregs[12][6] ),
    .CLK(clknet_leaf_53_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][7]$_DFFE_PP_  (.D(net691),
    .DE(net672),
    .Q(\cpuregs[12][7] ),
    .CLK(clknet_leaf_48_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][8]$_DFFE_PP_  (.D(net688),
    .DE(net672),
    .Q(\cpuregs[12][8] ),
    .CLK(clknet_leaf_39_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[12][9]$_DFFE_PP_  (.D(net692),
    .DE(net672),
    .Q(\cpuregs[12][9] ),
    .CLK(clknet_leaf_47_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(_0821_),
    .Q(\cpuregs[13][0] ),
    .CLK(clknet_leaf_18_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net673),
    .Q(\cpuregs[13][10] ),
    .CLK(clknet_leaf_37_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net673),
    .Q(\cpuregs[13][11] ),
    .CLK(clknet_leaf_88_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][12]$_DFFE_PP_  (.D(net685),
    .DE(net673),
    .Q(\cpuregs[13][12] ),
    .CLK(clknet_leaf_57_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net673),
    .Q(\cpuregs[13][13] ),
    .CLK(clknet_leaf_88_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net673),
    .Q(\cpuregs[13][14] ),
    .CLK(clknet_leaf_88_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net673),
    .Q(\cpuregs[13][15] ),
    .CLK(clknet_leaf_53_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net673),
    .Q(\cpuregs[13][16] ),
    .CLK(clknet_leaf_84_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][17]$_DFFE_PP_  (.D(net686),
    .DE(net673),
    .Q(\cpuregs[13][17] ),
    .CLK(clknet_leaf_22_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][18]$_DFFE_PP_  (.D(net651),
    .DE(net673),
    .Q(\cpuregs[13][18] ),
    .CLK(clknet_leaf_82_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][19]$_DFFE_PP_  (.D(net652),
    .DE(net673),
    .Q(\cpuregs[13][19] ),
    .CLK(clknet_leaf_26_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(_0821_),
    .Q(\cpuregs[13][1] ),
    .CLK(clknet_leaf_19_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][20]$_DFFE_PP_  (.D(net647),
    .DE(net673),
    .Q(\cpuregs[13][20] ),
    .CLK(clknet_leaf_20_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][21]$_DFFE_PP_  (.D(net648),
    .DE(net673),
    .Q(\cpuregs[13][21] ),
    .CLK(clknet_leaf_70_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net673),
    .Q(\cpuregs[13][22] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][23]$_DFFE_PP_  (.D(net649),
    .DE(net673),
    .Q(\cpuregs[13][23] ),
    .CLK(clknet_leaf_21_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net673),
    .Q(\cpuregs[13][24] ),
    .CLK(clknet_leaf_84_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][25]$_DFFE_PP_  (.D(net640),
    .DE(net673),
    .Q(\cpuregs[13][25] ),
    .CLK(clknet_leaf_76_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][26]$_DFFE_PP_  (.D(net643),
    .DE(_0821_),
    .Q(\cpuregs[13][26] ),
    .CLK(clknet_leaf_15_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][27]$_DFFE_PP_  (.D(net644),
    .DE(_0821_),
    .Q(\cpuregs[13][27] ),
    .CLK(clknet_leaf_15_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][28]$_DFFE_PP_  (.D(net645),
    .DE(_0821_),
    .Q(\cpuregs[13][28] ),
    .CLK(clknet_leaf_15_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][29]$_DFFE_PP_  (.D(net641),
    .DE(net673),
    .Q(\cpuregs[13][29] ),
    .CLK(clknet_leaf_79_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net673),
    .Q(\cpuregs[13][2] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][30]$_DFFE_PP_  (.D(net646),
    .DE(net673),
    .Q(\cpuregs[13][30] ),
    .CLK(clknet_leaf_80_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][31]$_DFFE_PP_  (.D(net639),
    .DE(_0821_),
    .Q(\cpuregs[13][31] ),
    .CLK(clknet_leaf_18_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net673),
    .Q(\cpuregs[13][3] ),
    .CLK(clknet_leaf_27_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net673),
    .Q(\cpuregs[13][4] ),
    .CLK(clknet_leaf_38_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net673),
    .Q(\cpuregs[13][5] ),
    .CLK(clknet_leaf_47_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net673),
    .Q(\cpuregs[13][6] ),
    .CLK(clknet_leaf_54_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][7]$_DFFE_PP_  (.D(net691),
    .DE(net673),
    .Q(\cpuregs[13][7] ),
    .CLK(clknet_leaf_44_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][8]$_DFFE_PP_  (.D(net688),
    .DE(net673),
    .Q(\cpuregs[13][8] ),
    .CLK(clknet_leaf_39_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[13][9]$_DFFE_PP_  (.D(net692),
    .DE(net673),
    .Q(\cpuregs[13][9] ),
    .CLK(clknet_leaf_48_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net675),
    .Q(\cpuregs[14][0] ),
    .CLK(clknet_leaf_18_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net675),
    .Q(\cpuregs[14][10] ),
    .CLK(clknet_leaf_37_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(_0822_),
    .Q(\cpuregs[14][11] ),
    .CLK(clknet_leaf_88_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][12]$_DFFE_PP_  (.D(net685),
    .DE(net675),
    .Q(\cpuregs[14][12] ),
    .CLK(clknet_leaf_62_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(_0822_),
    .Q(\cpuregs[14][13] ),
    .CLK(clknet_leaf_88_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(_0822_),
    .Q(\cpuregs[14][14] ),
    .CLK(clknet_leaf_88_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net675),
    .Q(\cpuregs[14][15] ),
    .CLK(clknet_leaf_53_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(_0822_),
    .Q(\cpuregs[14][16] ),
    .CLK(clknet_leaf_85_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][17]$_DFFE_PP_  (.D(net686),
    .DE(net675),
    .Q(\cpuregs[14][17] ),
    .CLK(clknet_leaf_22_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][18]$_DFFE_PP_  (.D(net651),
    .DE(_0822_),
    .Q(\cpuregs[14][18] ),
    .CLK(clknet_leaf_82_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][19]$_DFFE_PP_  (.D(net652),
    .DE(net675),
    .Q(\cpuregs[14][19] ),
    .CLK(clknet_leaf_26_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net675),
    .Q(\cpuregs[14][1] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][20]$_DFFE_PP_  (.D(net647),
    .DE(net675),
    .Q(\cpuregs[14][20] ),
    .CLK(clknet_leaf_20_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][21]$_DFFE_PP_  (.D(net648),
    .DE(net675),
    .Q(\cpuregs[14][21] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net675),
    .Q(\cpuregs[14][22] ),
    .CLK(clknet_leaf_23_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][23]$_DFFE_PP_  (.D(net649),
    .DE(net675),
    .Q(\cpuregs[14][23] ),
    .CLK(clknet_leaf_21_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(_0822_),
    .Q(\cpuregs[14][24] ),
    .CLK(clknet_leaf_84_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][25]$_DFFE_PP_  (.D(net640),
    .DE(net675),
    .Q(\cpuregs[14][25] ),
    .CLK(clknet_leaf_75_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][26]$_DFFE_PP_  (.D(net643),
    .DE(net675),
    .Q(\cpuregs[14][26] ),
    .CLK(clknet_leaf_14_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][27]$_DFFE_PP_  (.D(net644),
    .DE(net675),
    .Q(\cpuregs[14][27] ),
    .CLK(clknet_leaf_16_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][28]$_DFFE_PP_  (.D(net645),
    .DE(net675),
    .Q(\cpuregs[14][28] ),
    .CLK(clknet_leaf_15_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][29]$_DFFE_PP_  (.D(net641),
    .DE(_0822_),
    .Q(\cpuregs[14][29] ),
    .CLK(clknet_leaf_79_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net675),
    .Q(\cpuregs[14][2] ),
    .CLK(clknet_leaf_26_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][30]$_DFFE_PP_  (.D(net646),
    .DE(_0822_),
    .Q(\cpuregs[14][30] ),
    .CLK(clknet_leaf_80_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][31]$_DFFE_PP_  (.D(net639),
    .DE(net675),
    .Q(\cpuregs[14][31] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net675),
    .Q(\cpuregs[14][3] ),
    .CLK(clknet_leaf_27_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net675),
    .Q(\cpuregs[14][4] ),
    .CLK(clknet_leaf_36_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net675),
    .Q(\cpuregs[14][5] ),
    .CLK(clknet_leaf_47_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net675),
    .Q(\cpuregs[14][6] ),
    .CLK(clknet_leaf_54_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][7]$_DFFE_PP_  (.D(net691),
    .DE(net675),
    .Q(\cpuregs[14][7] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][8]$_DFFE_PP_  (.D(net688),
    .DE(net675),
    .Q(\cpuregs[14][8] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[14][9]$_DFFE_PP_  (.D(net692),
    .DE(net675),
    .Q(\cpuregs[14][9] ),
    .CLK(clknet_leaf_48_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(_0823_),
    .Q(\cpuregs[15][0] ),
    .CLK(clknet_leaf_18_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net676),
    .Q(\cpuregs[15][10] ),
    .CLK(clknet_leaf_37_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net676),
    .Q(\cpuregs[15][11] ),
    .CLK(clknet_leaf_57_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][12]$_DFFE_PP_  (.D(net685),
    .DE(net676),
    .Q(\cpuregs[15][12] ),
    .CLK(clknet_leaf_57_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(_0823_),
    .Q(\cpuregs[15][13] ),
    .CLK(clknet_leaf_88_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(_0823_),
    .Q(\cpuregs[15][14] ),
    .CLK(clknet_leaf_84_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net676),
    .Q(\cpuregs[15][15] ),
    .CLK(clknet_leaf_53_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(_0823_),
    .Q(\cpuregs[15][16] ),
    .CLK(clknet_leaf_85_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][17]$_DFFE_PP_  (.D(net686),
    .DE(net676),
    .Q(\cpuregs[15][17] ),
    .CLK(clknet_leaf_22_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][18]$_DFFE_PP_  (.D(net651),
    .DE(_0823_),
    .Q(\cpuregs[15][18] ),
    .CLK(clknet_leaf_82_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][19]$_DFFE_PP_  (.D(net652),
    .DE(net676),
    .Q(\cpuregs[15][19] ),
    .CLK(clknet_leaf_26_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(_0823_),
    .Q(\cpuregs[15][1] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][20]$_DFFE_PP_  (.D(net647),
    .DE(net676),
    .Q(\cpuregs[15][20] ),
    .CLK(clknet_leaf_70_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][21]$_DFFE_PP_  (.D(net648),
    .DE(net676),
    .Q(\cpuregs[15][21] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net676),
    .Q(\cpuregs[15][22] ),
    .CLK(clknet_leaf_23_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][23]$_DFFE_PP_  (.D(net649),
    .DE(net676),
    .Q(\cpuregs[15][23] ),
    .CLK(clknet_leaf_21_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(_0823_),
    .Q(\cpuregs[15][24] ),
    .CLK(clknet_leaf_84_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][25]$_DFFE_PP_  (.D(net640),
    .DE(_0823_),
    .Q(\cpuregs[15][25] ),
    .CLK(clknet_leaf_75_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][26]$_DFFE_PP_  (.D(net643),
    .DE(_0823_),
    .Q(\cpuregs[15][26] ),
    .CLK(clknet_leaf_77_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][27]$_DFFE_PP_  (.D(net644),
    .DE(_0823_),
    .Q(\cpuregs[15][27] ),
    .CLK(clknet_leaf_16_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][28]$_DFFE_PP_  (.D(net645),
    .DE(_0823_),
    .Q(\cpuregs[15][28] ),
    .CLK(clknet_leaf_15_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][29]$_DFFE_PP_  (.D(net641),
    .DE(_0823_),
    .Q(\cpuregs[15][29] ),
    .CLK(clknet_leaf_79_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net676),
    .Q(\cpuregs[15][2] ),
    .CLK(clknet_leaf_26_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][30]$_DFFE_PP_  (.D(net646),
    .DE(_0823_),
    .Q(\cpuregs[15][30] ),
    .CLK(clknet_leaf_80_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][31]$_DFFE_PP_  (.D(net639),
    .DE(_0823_),
    .Q(\cpuregs[15][31] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net676),
    .Q(\cpuregs[15][3] ),
    .CLK(clknet_leaf_26_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net676),
    .Q(\cpuregs[15][4] ),
    .CLK(clknet_leaf_38_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net676),
    .Q(\cpuregs[15][5] ),
    .CLK(clknet_leaf_47_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net676),
    .Q(\cpuregs[15][6] ),
    .CLK(clknet_leaf_54_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][7]$_DFFE_PP_  (.D(net691),
    .DE(net676),
    .Q(\cpuregs[15][7] ),
    .CLK(clknet_leaf_44_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][8]$_DFFE_PP_  (.D(net688),
    .DE(net676),
    .Q(\cpuregs[15][8] ),
    .CLK(clknet_leaf_40_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[15][9]$_DFFE_PP_  (.D(net692),
    .DE(net676),
    .Q(\cpuregs[15][9] ),
    .CLK(clknet_leaf_48_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net678),
    .Q(\cpuregs[16][0] ),
    .CLK(clknet_leaf_3_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net678),
    .Q(\cpuregs[16][10] ),
    .CLK(clknet_leaf_41_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net678),
    .Q(\cpuregs[16][11] ),
    .CLK(clknet_leaf_90_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][12]$_DFFE_PP_  (.D(net685),
    .DE(net678),
    .Q(\cpuregs[16][12] ),
    .CLK(clknet_leaf_59_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net678),
    .Q(\cpuregs[16][13] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net678),
    .Q(\cpuregs[16][14] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net678),
    .Q(\cpuregs[16][15] ),
    .CLK(clknet_leaf_58_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net678),
    .Q(\cpuregs[16][16] ),
    .CLK(clknet_leaf_90_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][17]$_DFFE_PP_  (.D(net686),
    .DE(net678),
    .Q(\cpuregs[16][17] ),
    .CLK(clknet_leaf_30_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][18]$_DFFE_PP_  (.D(net651),
    .DE(net678),
    .Q(\cpuregs[16][18] ),
    .CLK(clknet_leaf_64_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][19]$_DFFE_PP_  (.D(net652),
    .DE(net678),
    .Q(\cpuregs[16][19] ),
    .CLK(clknet_leaf_31_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net678),
    .Q(\cpuregs[16][1] ),
    .CLK(clknet_leaf_3_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][20]$_DFFE_PP_  (.D(net647),
    .DE(net678),
    .Q(\cpuregs[16][20] ),
    .CLK(clknet_leaf_75_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][21]$_DFFE_PP_  (.D(net648),
    .DE(net678),
    .Q(\cpuregs[16][21] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net678),
    .Q(\cpuregs[16][22] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][23]$_DFFE_PP_  (.D(net649),
    .DE(net678),
    .Q(\cpuregs[16][23] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net678),
    .Q(\cpuregs[16][24] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][25]$_DFFE_PP_  (.D(net640),
    .DE(net678),
    .Q(\cpuregs[16][25] ),
    .CLK(clknet_leaf_78_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][26]$_DFFE_PP_  (.D(net643),
    .DE(net678),
    .Q(\cpuregs[16][26] ),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][27]$_DFFE_PP_  (.D(net644),
    .DE(net678),
    .Q(\cpuregs[16][27] ),
    .CLK(clknet_leaf_9_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][28]$_DFFE_PP_  (.D(net645),
    .DE(net678),
    .Q(\cpuregs[16][28] ),
    .CLK(clknet_leaf_13_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][29]$_DFFE_PP_  (.D(net641),
    .DE(net678),
    .Q(\cpuregs[16][29] ),
    .CLK(clknet_leaf_74_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net678),
    .Q(\cpuregs[16][2] ),
    .CLK(clknet_leaf_2_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][30]$_DFFE_PP_  (.D(net646),
    .DE(net678),
    .Q(\cpuregs[16][30] ),
    .CLK(clknet_leaf_77_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][31]$_DFFE_PP_  (.D(net639),
    .DE(net678),
    .Q(\cpuregs[16][31] ),
    .CLK(clknet_leaf_9_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net678),
    .Q(\cpuregs[16][3] ),
    .CLK(clknet_leaf_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net678),
    .Q(\cpuregs[16][4] ),
    .CLK(clknet_leaf_34_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net678),
    .Q(\cpuregs[16][5] ),
    .CLK(clknet_leaf_46_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net678),
    .Q(\cpuregs[16][6] ),
    .CLK(clknet_leaf_54_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][7]$_DFFE_PP_  (.D(net691),
    .DE(net678),
    .Q(\cpuregs[16][7] ),
    .CLK(clknet_leaf_44_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][8]$_DFFE_PP_  (.D(net688),
    .DE(net678),
    .Q(\cpuregs[16][8] ),
    .CLK(clknet_leaf_43_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[16][9]$_DFFE_PP_  (.D(net692),
    .DE(net678),
    .Q(\cpuregs[16][9] ),
    .CLK(clknet_leaf_45_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net680),
    .Q(\cpuregs[17][0] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(_0825_),
    .Q(\cpuregs[17][10] ),
    .CLK(clknet_leaf_41_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net680),
    .Q(\cpuregs[17][11] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][12]$_DFFE_PP_  (.D(net685),
    .DE(net680),
    .Q(\cpuregs[17][12] ),
    .CLK(clknet_leaf_59_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net680),
    .Q(\cpuregs[17][13] ),
    .CLK(clknet_leaf_59_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net680),
    .Q(\cpuregs[17][14] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net680),
    .Q(\cpuregs[17][15] ),
    .CLK(clknet_leaf_58_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net680),
    .Q(\cpuregs[17][16] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][17]$_DFFE_PP_  (.D(net686),
    .DE(_0825_),
    .Q(\cpuregs[17][17] ),
    .CLK(clknet_leaf_30_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][18]$_DFFE_PP_  (.D(net651),
    .DE(net680),
    .Q(\cpuregs[17][18] ),
    .CLK(clknet_leaf_64_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][19]$_DFFE_PP_  (.D(net652),
    .DE(_0825_),
    .Q(\cpuregs[17][19] ),
    .CLK(clknet_leaf_31_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net680),
    .Q(\cpuregs[17][1] ),
    .CLK(clknet_leaf_3_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][20]$_DFFE_PP_  (.D(net647),
    .DE(net680),
    .Q(\cpuregs[17][20] ),
    .CLK(clknet_leaf_75_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][21]$_DFFE_PP_  (.D(net648),
    .DE(_0825_),
    .Q(\cpuregs[17][21] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net680),
    .Q(\cpuregs[17][22] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][23]$_DFFE_PP_  (.D(net649),
    .DE(_0825_),
    .Q(\cpuregs[17][23] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net680),
    .Q(\cpuregs[17][24] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][25]$_DFFE_PP_  (.D(net640),
    .DE(net680),
    .Q(\cpuregs[17][25] ),
    .CLK(clknet_leaf_78_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][26]$_DFFE_PP_  (.D(net643),
    .DE(net680),
    .Q(\cpuregs[17][26] ),
    .CLK(clknet_leaf_13_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][27]$_DFFE_PP_  (.D(net644),
    .DE(net680),
    .Q(\cpuregs[17][27] ),
    .CLK(clknet_leaf_10_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][28]$_DFFE_PP_  (.D(net645),
    .DE(net680),
    .Q(\cpuregs[17][28] ),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][29]$_DFFE_PP_  (.D(net641),
    .DE(net680),
    .Q(\cpuregs[17][29] ),
    .CLK(clknet_leaf_75_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net680),
    .Q(\cpuregs[17][2] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][30]$_DFFE_PP_  (.D(net646),
    .DE(net680),
    .Q(\cpuregs[17][30] ),
    .CLK(clknet_leaf_77_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][31]$_DFFE_PP_  (.D(net639),
    .DE(net680),
    .Q(\cpuregs[17][31] ),
    .CLK(clknet_leaf_4_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net680),
    .Q(\cpuregs[17][3] ),
    .CLK(clknet_leaf_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(_0825_),
    .Q(\cpuregs[17][4] ),
    .CLK(clknet_leaf_34_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(_0825_),
    .Q(\cpuregs[17][5] ),
    .CLK(clknet_leaf_46_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(_0825_),
    .Q(\cpuregs[17][6] ),
    .CLK(clknet_leaf_54_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][7]$_DFFE_PP_  (.D(net691),
    .DE(_0825_),
    .Q(\cpuregs[17][7] ),
    .CLK(clknet_leaf_44_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][8]$_DFFE_PP_  (.D(net688),
    .DE(_0825_),
    .Q(\cpuregs[17][8] ),
    .CLK(clknet_leaf_43_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[17][9]$_DFFE_PP_  (.D(net692),
    .DE(_0825_),
    .Q(\cpuregs[17][9] ),
    .CLK(clknet_leaf_45_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net681),
    .Q(\cpuregs[18][0] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net681),
    .Q(\cpuregs[18][10] ),
    .CLK(clknet_leaf_41_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net681),
    .Q(\cpuregs[18][11] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][12]$_DFFE_PP_  (.D(net685),
    .DE(net681),
    .Q(\cpuregs[18][12] ),
    .CLK(clknet_leaf_59_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net681),
    .Q(\cpuregs[18][13] ),
    .CLK(clknet_leaf_59_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net681),
    .Q(\cpuregs[18][14] ),
    .CLK(clknet_leaf_61_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net681),
    .Q(\cpuregs[18][15] ),
    .CLK(clknet_leaf_56_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net681),
    .Q(\cpuregs[18][16] ),
    .CLK(clknet_leaf_59_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][17]$_DFFE_PP_  (.D(net686),
    .DE(net681),
    .Q(\cpuregs[18][17] ),
    .CLK(clknet_leaf_30_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][18]$_DFFE_PP_  (.D(net651),
    .DE(net681),
    .Q(\cpuregs[18][18] ),
    .CLK(clknet_leaf_64_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][19]$_DFFE_PP_  (.D(net652),
    .DE(net681),
    .Q(\cpuregs[18][19] ),
    .CLK(clknet_leaf_30_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net681),
    .Q(\cpuregs[18][1] ),
    .CLK(clknet_leaf_3_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][20]$_DFFE_PP_  (.D(net647),
    .DE(net681),
    .Q(\cpuregs[18][20] ),
    .CLK(clknet_leaf_72_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][21]$_DFFE_PP_  (.D(net648),
    .DE(net681),
    .Q(\cpuregs[18][21] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net681),
    .Q(\cpuregs[18][22] ),
    .CLK(clknet_leaf_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][23]$_DFFE_PP_  (.D(net649),
    .DE(net681),
    .Q(\cpuregs[18][23] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net681),
    .Q(\cpuregs[18][24] ),
    .CLK(clknet_leaf_59_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][25]$_DFFE_PP_  (.D(net640),
    .DE(net681),
    .Q(\cpuregs[18][25] ),
    .CLK(clknet_leaf_78_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][26]$_DFFE_PP_  (.D(net643),
    .DE(net681),
    .Q(\cpuregs[18][26] ),
    .CLK(clknet_leaf_13_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][27]$_DFFE_PP_  (.D(net644),
    .DE(net681),
    .Q(\cpuregs[18][27] ),
    .CLK(clknet_leaf_9_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][28]$_DFFE_PP_  (.D(net645),
    .DE(net681),
    .Q(\cpuregs[18][28] ),
    .CLK(clknet_leaf_13_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][29]$_DFFE_PP_  (.D(net641),
    .DE(net681),
    .Q(\cpuregs[18][29] ),
    .CLK(clknet_leaf_75_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net681),
    .Q(\cpuregs[18][2] ),
    .CLK(clknet_leaf_2_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][30]$_DFFE_PP_  (.D(net646),
    .DE(net681),
    .Q(\cpuregs[18][30] ),
    .CLK(clknet_leaf_77_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][31]$_DFFE_PP_  (.D(net639),
    .DE(net681),
    .Q(\cpuregs[18][31] ),
    .CLK(clknet_leaf_4_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net681),
    .Q(\cpuregs[18][3] ),
    .CLK(clknet_leaf_2_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net681),
    .Q(\cpuregs[18][4] ),
    .CLK(clknet_leaf_34_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net681),
    .Q(\cpuregs[18][5] ),
    .CLK(clknet_leaf_46_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net681),
    .Q(\cpuregs[18][6] ),
    .CLK(clknet_leaf_54_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][7]$_DFFE_PP_  (.D(net691),
    .DE(net681),
    .Q(\cpuregs[18][7] ),
    .CLK(clknet_leaf_44_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][8]$_DFFE_PP_  (.D(net688),
    .DE(net681),
    .Q(\cpuregs[18][8] ),
    .CLK(clknet_leaf_43_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[18][9]$_DFFE_PP_  (.D(net692),
    .DE(net681),
    .Q(\cpuregs[18][9] ),
    .CLK(clknet_leaf_45_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net682),
    .Q(\cpuregs[19][0] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net682),
    .Q(\cpuregs[19][10] ),
    .CLK(clknet_leaf_41_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net682),
    .Q(\cpuregs[19][11] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][12]$_DFFE_PP_  (.D(net685),
    .DE(net682),
    .Q(\cpuregs[19][12] ),
    .CLK(clknet_leaf_58_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net682),
    .Q(\cpuregs[19][13] ),
    .CLK(clknet_leaf_57_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net682),
    .Q(\cpuregs[19][14] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net682),
    .Q(\cpuregs[19][15] ),
    .CLK(clknet_leaf_56_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net682),
    .Q(\cpuregs[19][16] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][17]$_DFFE_PP_  (.D(net686),
    .DE(net682),
    .Q(\cpuregs[19][17] ),
    .CLK(clknet_leaf_30_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][18]$_DFFE_PP_  (.D(net651),
    .DE(net682),
    .Q(\cpuregs[19][18] ),
    .CLK(clknet_leaf_64_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][19]$_DFFE_PP_  (.D(net652),
    .DE(net682),
    .Q(\cpuregs[19][19] ),
    .CLK(clknet_leaf_31_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net682),
    .Q(\cpuregs[19][1] ),
    .CLK(clknet_leaf_3_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][20]$_DFFE_PP_  (.D(net647),
    .DE(net682),
    .Q(\cpuregs[19][20] ),
    .CLK(clknet_leaf_76_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][21]$_DFFE_PP_  (.D(net648),
    .DE(net682),
    .Q(\cpuregs[19][21] ),
    .CLK(clknet_leaf_51_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net682),
    .Q(\cpuregs[19][22] ),
    .CLK(clknet_leaf_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][23]$_DFFE_PP_  (.D(net649),
    .DE(net682),
    .Q(\cpuregs[19][23] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net682),
    .Q(\cpuregs[19][24] ),
    .CLK(clknet_leaf_59_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][25]$_DFFE_PP_  (.D(net640),
    .DE(net682),
    .Q(\cpuregs[19][25] ),
    .CLK(clknet_leaf_77_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][26]$_DFFE_PP_  (.D(net643),
    .DE(net682),
    .Q(\cpuregs[19][26] ),
    .CLK(clknet_leaf_13_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][27]$_DFFE_PP_  (.D(net644),
    .DE(net682),
    .Q(\cpuregs[19][27] ),
    .CLK(clknet_leaf_9_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][28]$_DFFE_PP_  (.D(net645),
    .DE(net682),
    .Q(\cpuregs[19][28] ),
    .CLK(clknet_leaf_13_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][29]$_DFFE_PP_  (.D(net641),
    .DE(net682),
    .Q(\cpuregs[19][29] ),
    .CLK(clknet_leaf_75_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net682),
    .Q(\cpuregs[19][2] ),
    .CLK(clknet_leaf_2_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][30]$_DFFE_PP_  (.D(net646),
    .DE(net682),
    .Q(\cpuregs[19][30] ),
    .CLK(clknet_leaf_77_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][31]$_DFFE_PP_  (.D(net639),
    .DE(net682),
    .Q(\cpuregs[19][31] ),
    .CLK(clknet_leaf_4_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net682),
    .Q(\cpuregs[19][3] ),
    .CLK(clknet_leaf_156_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net682),
    .Q(\cpuregs[19][4] ),
    .CLK(clknet_leaf_34_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net682),
    .Q(\cpuregs[19][5] ),
    .CLK(clknet_leaf_46_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net682),
    .Q(\cpuregs[19][6] ),
    .CLK(clknet_leaf_54_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][7]$_DFFE_PP_  (.D(net691),
    .DE(net682),
    .Q(\cpuregs[19][7] ),
    .CLK(clknet_leaf_43_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][8]$_DFFE_PP_  (.D(net688),
    .DE(net682),
    .Q(\cpuregs[19][8] ),
    .CLK(clknet_leaf_41_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[19][9]$_DFFE_PP_  (.D(net692),
    .DE(net682),
    .Q(\cpuregs[19][9] ),
    .CLK(clknet_leaf_45_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net655),
    .Q(\cpuregs[1][0] ),
    .CLK(clknet_leaf_10_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(_0828_),
    .Q(\cpuregs[1][10] ),
    .CLK(clknet_leaf_39_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net655),
    .Q(\cpuregs[1][11] ),
    .CLK(clknet_leaf_94_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][12]$_DFFE_PP_  (.D(net685),
    .DE(_0828_),
    .Q(\cpuregs[1][12] ),
    .CLK(clknet_leaf_57_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net655),
    .Q(\cpuregs[1][13] ),
    .CLK(clknet_leaf_94_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net655),
    .Q(\cpuregs[1][14] ),
    .CLK(clknet_leaf_95_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(_0828_),
    .Q(\cpuregs[1][15] ),
    .CLK(clknet_leaf_57_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net655),
    .Q(\cpuregs[1][16] ),
    .CLK(clknet_leaf_94_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][17]$_DFFE_PP_  (.D(net686),
    .DE(_0828_),
    .Q(\cpuregs[1][17] ),
    .CLK(clknet_leaf_22_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][18]$_DFFE_PP_  (.D(net651),
    .DE(net655),
    .Q(\cpuregs[1][18] ),
    .CLK(clknet_leaf_83_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][19]$_DFFE_PP_  (.D(net652),
    .DE(_0828_),
    .Q(\cpuregs[1][19] ),
    .CLK(clknet_leaf_23_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net655),
    .Q(\cpuregs[1][1] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][20]$_DFFE_PP_  (.D(net647),
    .DE(_0828_),
    .Q(\cpuregs[1][20] ),
    .CLK(clknet_leaf_72_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][21]$_DFFE_PP_  (.D(net648),
    .DE(_0828_),
    .Q(\cpuregs[1][21] ),
    .CLK(clknet_leaf_68_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net655),
    .Q(\cpuregs[1][22] ),
    .CLK(clknet_leaf_4_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][23]$_DFFE_PP_  (.D(net649),
    .DE(_0828_),
    .Q(\cpuregs[1][23] ),
    .CLK(clknet_leaf_36_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net655),
    .Q(\cpuregs[1][24] ),
    .CLK(clknet_leaf_94_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][25]$_DFFE_PP_  (.D(net640),
    .DE(net655),
    .Q(\cpuregs[1][25] ),
    .CLK(clknet_leaf_75_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][26]$_DFFE_PP_  (.D(net643),
    .DE(net655),
    .Q(\cpuregs[1][26] ),
    .CLK(clknet_leaf_12_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][27]$_DFFE_PP_  (.D(net644),
    .DE(net655),
    .Q(\cpuregs[1][27] ),
    .CLK(clknet_leaf_11_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][28]$_DFFE_PP_  (.D(net645),
    .DE(net655),
    .Q(\cpuregs[1][28] ),
    .CLK(clknet_leaf_11_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][29]$_DFFE_PP_  (.D(net641),
    .DE(net655),
    .Q(\cpuregs[1][29] ),
    .CLK(clknet_leaf_82_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net655),
    .Q(\cpuregs[1][2] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][30]$_DFFE_PP_  (.D(net646),
    .DE(net655),
    .Q(\cpuregs[1][30] ),
    .CLK(clknet_leaf_79_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][31]$_DFFE_PP_  (.D(net639),
    .DE(net655),
    .Q(\cpuregs[1][31] ),
    .CLK(clknet_leaf_9_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net655),
    .Q(\cpuregs[1][3] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(_0828_),
    .Q(\cpuregs[1][4] ),
    .CLK(clknet_leaf_37_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(_0828_),
    .Q(\cpuregs[1][5] ),
    .CLK(clknet_leaf_54_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(_0828_),
    .Q(\cpuregs[1][6] ),
    .CLK(clknet_leaf_53_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][7]$_DFFE_PP_  (.D(net691),
    .DE(_0828_),
    .Q(\cpuregs[1][7] ),
    .CLK(clknet_leaf_48_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][8]$_DFFE_PP_  (.D(net688),
    .DE(_0828_),
    .Q(\cpuregs[1][8] ),
    .CLK(clknet_leaf_38_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[1][9]$_DFFE_PP_  (.D(net692),
    .DE(_0828_),
    .Q(\cpuregs[1][9] ),
    .CLK(clknet_leaf_47_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net684),
    .Q(\cpuregs[20][0] ),
    .CLK(clknet_leaf_155_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net684),
    .Q(\cpuregs[20][10] ),
    .CLK(clknet_leaf_42_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net684),
    .Q(\cpuregs[20][11] ),
    .CLK(clknet_leaf_90_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][12]$_DFFE_PP_  (.D(net685),
    .DE(net684),
    .Q(\cpuregs[20][12] ),
    .CLK(clknet_leaf_58_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net684),
    .Q(\cpuregs[20][13] ),
    .CLK(clknet_leaf_92_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net684),
    .Q(\cpuregs[20][14] ),
    .CLK(clknet_leaf_61_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net684),
    .Q(\cpuregs[20][15] ),
    .CLK(clknet_leaf_56_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net684),
    .Q(\cpuregs[20][16] ),
    .CLK(clknet_leaf_91_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][17]$_DFFE_PP_  (.D(net686),
    .DE(net684),
    .Q(\cpuregs[20][17] ),
    .CLK(clknet_leaf_30_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][18]$_DFFE_PP_  (.D(net651),
    .DE(net684),
    .Q(\cpuregs[20][18] ),
    .CLK(clknet_leaf_86_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][19]$_DFFE_PP_  (.D(net652),
    .DE(net684),
    .Q(\cpuregs[20][19] ),
    .CLK(clknet_leaf_29_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net684),
    .Q(\cpuregs[20][1] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][20]$_DFFE_PP_  (.D(net647),
    .DE(net684),
    .Q(\cpuregs[20][20] ),
    .CLK(clknet_leaf_72_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][21]$_DFFE_PP_  (.D(net648),
    .DE(net684),
    .Q(\cpuregs[20][21] ),
    .CLK(clknet_leaf_51_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net684),
    .Q(\cpuregs[20][22] ),
    .CLK(clknet_leaf_156_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][23]$_DFFE_PP_  (.D(net649),
    .DE(net684),
    .Q(\cpuregs[20][23] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net684),
    .Q(\cpuregs[20][24] ),
    .CLK(clknet_leaf_90_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][25]$_DFFE_PP_  (.D(net640),
    .DE(net684),
    .Q(\cpuregs[20][25] ),
    .CLK(clknet_leaf_77_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][26]$_DFFE_PP_  (.D(net643),
    .DE(net684),
    .Q(\cpuregs[20][26] ),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][27]$_DFFE_PP_  (.D(net644),
    .DE(net684),
    .Q(\cpuregs[20][27] ),
    .CLK(clknet_leaf_7_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][28]$_DFFE_PP_  (.D(net645),
    .DE(net684),
    .Q(\cpuregs[20][28] ),
    .CLK(clknet_leaf_147_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][29]$_DFFE_PP_  (.D(net641),
    .DE(net684),
    .Q(\cpuregs[20][29] ),
    .CLK(clknet_leaf_79_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net684),
    .Q(\cpuregs[20][2] ),
    .CLK(clknet_leaf_2_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][30]$_DFFE_PP_  (.D(net646),
    .DE(net684),
    .Q(\cpuregs[20][30] ),
    .CLK(clknet_leaf_79_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][31]$_DFFE_PP_  (.D(net639),
    .DE(net684),
    .Q(\cpuregs[20][31] ),
    .CLK(clknet_leaf_7_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net684),
    .Q(\cpuregs[20][3] ),
    .CLK(clknet_leaf_155_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net684),
    .Q(\cpuregs[20][4] ),
    .CLK(clknet_leaf_34_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net684),
    .Q(\cpuregs[20][5] ),
    .CLK(clknet_leaf_46_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net684),
    .Q(\cpuregs[20][6] ),
    .CLK(clknet_leaf_55_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][7]$_DFFE_PP_  (.D(net691),
    .DE(net684),
    .Q(\cpuregs[20][7] ),
    .CLK(clknet_leaf_43_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][8]$_DFFE_PP_  (.D(net688),
    .DE(net684),
    .Q(\cpuregs[20][8] ),
    .CLK(clknet_leaf_42_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[20][9]$_DFFE_PP_  (.D(net692),
    .DE(net684),
    .Q(\cpuregs[20][9] ),
    .CLK(clknet_leaf_45_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net658),
    .Q(\cpuregs[21][0] ),
    .CLK(clknet_leaf_155_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net658),
    .Q(\cpuregs[21][10] ),
    .CLK(clknet_leaf_41_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net658),
    .Q(\cpuregs[21][11] ),
    .CLK(clknet_leaf_89_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][12]$_DFFE_PP_  (.D(net685),
    .DE(net658),
    .Q(\cpuregs[21][12] ),
    .CLK(clknet_leaf_58_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net658),
    .Q(\cpuregs[21][13] ),
    .CLK(clknet_leaf_89_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net658),
    .Q(\cpuregs[21][14] ),
    .CLK(clknet_leaf_89_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net658),
    .Q(\cpuregs[21][15] ),
    .CLK(clknet_leaf_56_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net658),
    .Q(\cpuregs[21][16] ),
    .CLK(clknet_leaf_90_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][17]$_DFFE_PP_  (.D(net686),
    .DE(net658),
    .Q(\cpuregs[21][17] ),
    .CLK(clknet_leaf_30_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][18]$_DFFE_PP_  (.D(net651),
    .DE(net658),
    .Q(\cpuregs[21][18] ),
    .CLK(clknet_leaf_86_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][19]$_DFFE_PP_  (.D(net652),
    .DE(net658),
    .Q(\cpuregs[21][19] ),
    .CLK(clknet_leaf_29_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net658),
    .Q(\cpuregs[21][1] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][20]$_DFFE_PP_  (.D(net647),
    .DE(net658),
    .Q(\cpuregs[21][20] ),
    .CLK(clknet_leaf_71_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][21]$_DFFE_PP_  (.D(net648),
    .DE(net658),
    .Q(\cpuregs[21][21] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net658),
    .Q(\cpuregs[21][22] ),
    .CLK(clknet_leaf_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][23]$_DFFE_PP_  (.D(net649),
    .DE(net658),
    .Q(\cpuregs[21][23] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net658),
    .Q(\cpuregs[21][24] ),
    .CLK(clknet_leaf_90_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][25]$_DFFE_PP_  (.D(net640),
    .DE(net658),
    .Q(\cpuregs[21][25] ),
    .CLK(clknet_leaf_77_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][26]$_DFFE_PP_  (.D(net643),
    .DE(net658),
    .Q(\cpuregs[21][26] ),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][27]$_DFFE_PP_  (.D(net644),
    .DE(net658),
    .Q(\cpuregs[21][27] ),
    .CLK(clknet_leaf_7_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][28]$_DFFE_PP_  (.D(net645),
    .DE(net658),
    .Q(\cpuregs[21][28] ),
    .CLK(clknet_leaf_12_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][29]$_DFFE_PP_  (.D(net641),
    .DE(net658),
    .Q(\cpuregs[21][29] ),
    .CLK(clknet_leaf_79_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net658),
    .Q(\cpuregs[21][2] ),
    .CLK(clknet_leaf_155_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][30]$_DFFE_PP_  (.D(net646),
    .DE(net658),
    .Q(\cpuregs[21][30] ),
    .CLK(clknet_leaf_77_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][31]$_DFFE_PP_  (.D(net639),
    .DE(net658),
    .Q(\cpuregs[21][31] ),
    .CLK(clknet_leaf_7_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net658),
    .Q(\cpuregs[21][3] ),
    .CLK(clknet_leaf_156_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net658),
    .Q(\cpuregs[21][4] ),
    .CLK(clknet_leaf_33_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net658),
    .Q(\cpuregs[21][5] ),
    .CLK(clknet_leaf_46_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net658),
    .Q(\cpuregs[21][6] ),
    .CLK(clknet_leaf_55_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][7]$_DFFE_PP_  (.D(net691),
    .DE(net658),
    .Q(\cpuregs[21][7] ),
    .CLK(clknet_leaf_43_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][8]$_DFFE_PP_  (.D(net688),
    .DE(net658),
    .Q(\cpuregs[21][8] ),
    .CLK(clknet_leaf_42_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[21][9]$_DFFE_PP_  (.D(net692),
    .DE(net658),
    .Q(\cpuregs[21][9] ),
    .CLK(clknet_leaf_45_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net663),
    .Q(\cpuregs[22][0] ),
    .CLK(clknet_leaf_155_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net663),
    .Q(\cpuregs[22][10] ),
    .CLK(clknet_leaf_42_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net663),
    .Q(\cpuregs[22][11] ),
    .CLK(clknet_leaf_89_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][12]$_DFFE_PP_  (.D(net685),
    .DE(net663),
    .Q(\cpuregs[22][12] ),
    .CLK(clknet_leaf_58_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net663),
    .Q(\cpuregs[22][13] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net663),
    .Q(\cpuregs[22][14] ),
    .CLK(clknet_leaf_60_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net663),
    .Q(\cpuregs[22][15] ),
    .CLK(clknet_leaf_56_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net663),
    .Q(\cpuregs[22][16] ),
    .CLK(clknet_leaf_90_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][17]$_DFFE_PP_  (.D(net686),
    .DE(net663),
    .Q(\cpuregs[22][17] ),
    .CLK(clknet_leaf_30_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][18]$_DFFE_PP_  (.D(net651),
    .DE(net663),
    .Q(\cpuregs[22][18] ),
    .CLK(clknet_leaf_86_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][19]$_DFFE_PP_  (.D(net652),
    .DE(net663),
    .Q(\cpuregs[22][19] ),
    .CLK(clknet_leaf_30_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net663),
    .Q(\cpuregs[22][1] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][20]$_DFFE_PP_  (.D(net647),
    .DE(net663),
    .Q(\cpuregs[22][20] ),
    .CLK(clknet_leaf_71_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][21]$_DFFE_PP_  (.D(net648),
    .DE(net663),
    .Q(\cpuregs[22][21] ),
    .CLK(clknet_leaf_51_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net663),
    .Q(\cpuregs[22][22] ),
    .CLK(clknet_leaf_156_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][23]$_DFFE_PP_  (.D(net649),
    .DE(net663),
    .Q(\cpuregs[22][23] ),
    .CLK(clknet_leaf_33_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net663),
    .Q(\cpuregs[22][24] ),
    .CLK(clknet_leaf_90_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][25]$_DFFE_PP_  (.D(net640),
    .DE(net663),
    .Q(\cpuregs[22][25] ),
    .CLK(clknet_leaf_76_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][26]$_DFFE_PP_  (.D(net643),
    .DE(net663),
    .Q(\cpuregs[22][26] ),
    .CLK(clknet_leaf_147_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][27]$_DFFE_PP_  (.D(net644),
    .DE(net663),
    .Q(\cpuregs[22][27] ),
    .CLK(clknet_leaf_7_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][28]$_DFFE_PP_  (.D(net645),
    .DE(net663),
    .Q(\cpuregs[22][28] ),
    .CLK(clknet_leaf_12_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][29]$_DFFE_PP_  (.D(net641),
    .DE(net663),
    .Q(\cpuregs[22][29] ),
    .CLK(clknet_leaf_78_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net663),
    .Q(\cpuregs[22][2] ),
    .CLK(clknet_leaf_155_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][30]$_DFFE_PP_  (.D(net646),
    .DE(net663),
    .Q(\cpuregs[22][30] ),
    .CLK(clknet_leaf_77_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][31]$_DFFE_PP_  (.D(net639),
    .DE(net663),
    .Q(\cpuregs[22][31] ),
    .CLK(clknet_leaf_7_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net663),
    .Q(\cpuregs[22][3] ),
    .CLK(clknet_leaf_156_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net663),
    .Q(\cpuregs[22][4] ),
    .CLK(clknet_leaf_33_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net663),
    .Q(\cpuregs[22][5] ),
    .CLK(clknet_leaf_46_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net663),
    .Q(\cpuregs[22][6] ),
    .CLK(clknet_leaf_55_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][7]$_DFFE_PP_  (.D(net691),
    .DE(net663),
    .Q(\cpuregs[22][7] ),
    .CLK(clknet_leaf_43_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][8]$_DFFE_PP_  (.D(net688),
    .DE(net663),
    .Q(\cpuregs[22][8] ),
    .CLK(clknet_leaf_42_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[22][9]$_DFFE_PP_  (.D(net692),
    .DE(net663),
    .Q(\cpuregs[22][9] ),
    .CLK(clknet_leaf_45_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net668),
    .Q(\cpuregs[23][0] ),
    .CLK(clknet_leaf_155_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net668),
    .Q(\cpuregs[23][10] ),
    .CLK(clknet_leaf_42_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net668),
    .Q(\cpuregs[23][11] ),
    .CLK(clknet_leaf_89_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][12]$_DFFE_PP_  (.D(net685),
    .DE(net668),
    .Q(\cpuregs[23][12] ),
    .CLK(clknet_leaf_58_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net668),
    .Q(\cpuregs[23][13] ),
    .CLK(clknet_leaf_89_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net668),
    .Q(\cpuregs[23][14] ),
    .CLK(clknet_leaf_61_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net668),
    .Q(\cpuregs[23][15] ),
    .CLK(clknet_leaf_56_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net668),
    .Q(\cpuregs[23][16] ),
    .CLK(clknet_leaf_90_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][17]$_DFFE_PP_  (.D(net686),
    .DE(net668),
    .Q(\cpuregs[23][17] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][18]$_DFFE_PP_  (.D(net651),
    .DE(net668),
    .Q(\cpuregs[23][18] ),
    .CLK(clknet_leaf_86_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][19]$_DFFE_PP_  (.D(net652),
    .DE(net668),
    .Q(\cpuregs[23][19] ),
    .CLK(clknet_leaf_30_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net668),
    .Q(\cpuregs[23][1] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][20]$_DFFE_PP_  (.D(net647),
    .DE(net668),
    .Q(\cpuregs[23][20] ),
    .CLK(clknet_leaf_71_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][21]$_DFFE_PP_  (.D(net648),
    .DE(net668),
    .Q(\cpuregs[23][21] ),
    .CLK(clknet_leaf_51_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net668),
    .Q(\cpuregs[23][22] ),
    .CLK(clknet_leaf_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][23]$_DFFE_PP_  (.D(net649),
    .DE(net668),
    .Q(\cpuregs[23][23] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net668),
    .Q(\cpuregs[23][24] ),
    .CLK(clknet_leaf_90_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][25]$_DFFE_PP_  (.D(net640),
    .DE(net668),
    .Q(\cpuregs[23][25] ),
    .CLK(clknet_leaf_76_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][26]$_DFFE_PP_  (.D(net643),
    .DE(net668),
    .Q(\cpuregs[23][26] ),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][27]$_DFFE_PP_  (.D(net644),
    .DE(net668),
    .Q(\cpuregs[23][27] ),
    .CLK(clknet_leaf_7_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][28]$_DFFE_PP_  (.D(net645),
    .DE(net668),
    .Q(\cpuregs[23][28] ),
    .CLK(clknet_leaf_12_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][29]$_DFFE_PP_  (.D(net641),
    .DE(net668),
    .Q(\cpuregs[23][29] ),
    .CLK(clknet_leaf_78_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net668),
    .Q(\cpuregs[23][2] ),
    .CLK(clknet_leaf_155_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][30]$_DFFE_PP_  (.D(net646),
    .DE(net668),
    .Q(\cpuregs[23][30] ),
    .CLK(clknet_leaf_78_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][31]$_DFFE_PP_  (.D(net639),
    .DE(net668),
    .Q(\cpuregs[23][31] ),
    .CLK(clknet_leaf_7_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net668),
    .Q(\cpuregs[23][3] ),
    .CLK(clknet_leaf_156_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net668),
    .Q(\cpuregs[23][4] ),
    .CLK(clknet_leaf_33_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net668),
    .Q(\cpuregs[23][5] ),
    .CLK(clknet_leaf_46_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net668),
    .Q(\cpuregs[23][6] ),
    .CLK(clknet_leaf_55_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][7]$_DFFE_PP_  (.D(net691),
    .DE(net668),
    .Q(\cpuregs[23][7] ),
    .CLK(clknet_leaf_43_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][8]$_DFFE_PP_  (.D(net688),
    .DE(net668),
    .Q(\cpuregs[23][8] ),
    .CLK(clknet_leaf_42_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[23][9]$_DFFE_PP_  (.D(net692),
    .DE(net668),
    .Q(\cpuregs[23][9] ),
    .CLK(clknet_leaf_45_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net674),
    .Q(\cpuregs[24][0] ),
    .CLK(clknet_leaf_28_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(_0833_),
    .Q(\cpuregs[24][10] ),
    .CLK(clknet_leaf_41_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(_0833_),
    .Q(\cpuregs[24][11] ),
    .CLK(clknet_leaf_66_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][12]$_DFFE_PP_  (.D(net685),
    .DE(_0833_),
    .Q(\cpuregs[24][12] ),
    .CLK(clknet_leaf_65_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(_0833_),
    .Q(\cpuregs[24][13] ),
    .CLK(clknet_leaf_63_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(_0833_),
    .Q(\cpuregs[24][14] ),
    .CLK(clknet_leaf_65_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(_0833_),
    .Q(\cpuregs[24][15] ),
    .CLK(clknet_leaf_67_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(_0833_),
    .Q(\cpuregs[24][16] ),
    .CLK(clknet_leaf_64_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][17]$_DFFE_PP_  (.D(net686),
    .DE(net674),
    .Q(\cpuregs[24][17] ),
    .CLK(clknet_leaf_31_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][18]$_DFFE_PP_  (.D(net651),
    .DE(_0833_),
    .Q(\cpuregs[24][18] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][19]$_DFFE_PP_  (.D(net652),
    .DE(net674),
    .Q(\cpuregs[24][19] ),
    .CLK(clknet_leaf_27_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net674),
    .Q(\cpuregs[24][1] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][20]$_DFFE_PP_  (.D(net647),
    .DE(net674),
    .Q(\cpuregs[24][20] ),
    .CLK(clknet_leaf_19_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][21]$_DFFE_PP_  (.D(net648),
    .DE(net674),
    .Q(\cpuregs[24][21] ),
    .CLK(clknet_leaf_20_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net674),
    .Q(\cpuregs[24][22] ),
    .CLK(clknet_leaf_27_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][23]$_DFFE_PP_  (.D(net649),
    .DE(_0833_),
    .Q(\cpuregs[24][23] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(_0833_),
    .Q(\cpuregs[24][24] ),
    .CLK(clknet_leaf_64_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][25]$_DFFE_PP_  (.D(net640),
    .DE(net674),
    .Q(\cpuregs[24][25] ),
    .CLK(clknet_leaf_15_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][26]$_DFFE_PP_  (.D(net643),
    .DE(net674),
    .Q(\cpuregs[24][26] ),
    .CLK(clknet_leaf_14_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][27]$_DFFE_PP_  (.D(net644),
    .DE(net674),
    .Q(\cpuregs[24][27] ),
    .CLK(clknet_leaf_17_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][28]$_DFFE_PP_  (.D(net645),
    .DE(net674),
    .Q(\cpuregs[24][28] ),
    .CLK(clknet_leaf_16_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][29]$_DFFE_PP_  (.D(net641),
    .DE(_0833_),
    .Q(\cpuregs[24][29] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net674),
    .Q(\cpuregs[24][2] ),
    .CLK(clknet_leaf_26_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][30]$_DFFE_PP_  (.D(net646),
    .DE(_0833_),
    .Q(\cpuregs[24][30] ),
    .CLK(clknet_leaf_74_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][31]$_DFFE_PP_  (.D(net639),
    .DE(net674),
    .Q(\cpuregs[24][31] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net674),
    .Q(\cpuregs[24][3] ),
    .CLK(clknet_leaf_28_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(_0833_),
    .Q(\cpuregs[24][4] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(_0833_),
    .Q(\cpuregs[24][5] ),
    .CLK(clknet_leaf_51_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(_0833_),
    .Q(\cpuregs[24][6] ),
    .CLK(clknet_leaf_51_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][7]$_DFFE_PP_  (.D(net691),
    .DE(_0833_),
    .Q(\cpuregs[24][7] ),
    .CLK(clknet_leaf_40_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][8]$_DFFE_PP_  (.D(net688),
    .DE(_0833_),
    .Q(\cpuregs[24][8] ),
    .CLK(clknet_leaf_40_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[24][9]$_DFFE_PP_  (.D(net692),
    .DE(_0833_),
    .Q(\cpuregs[24][9] ),
    .CLK(clknet_leaf_50_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(_0834_),
    .Q(\cpuregs[25][0] ),
    .CLK(clknet_leaf_28_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net679),
    .Q(\cpuregs[25][10] ),
    .CLK(clknet_leaf_34_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net679),
    .Q(\cpuregs[25][11] ),
    .CLK(clknet_leaf_66_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][12]$_DFFE_PP_  (.D(net685),
    .DE(net679),
    .Q(\cpuregs[25][12] ),
    .CLK(clknet_leaf_66_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net679),
    .Q(\cpuregs[25][13] ),
    .CLK(clknet_leaf_64_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net679),
    .Q(\cpuregs[25][14] ),
    .CLK(clknet_leaf_65_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net679),
    .Q(\cpuregs[25][15] ),
    .CLK(clknet_leaf_67_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net679),
    .Q(\cpuregs[25][16] ),
    .CLK(clknet_leaf_64_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][17]$_DFFE_PP_  (.D(net686),
    .DE(net679),
    .Q(\cpuregs[25][17] ),
    .CLK(clknet_leaf_31_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][18]$_DFFE_PP_  (.D(net651),
    .DE(net679),
    .Q(\cpuregs[25][18] ),
    .CLK(clknet_leaf_65_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][19]$_DFFE_PP_  (.D(net652),
    .DE(_0834_),
    .Q(\cpuregs[25][19] ),
    .CLK(clknet_leaf_27_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(_0834_),
    .Q(\cpuregs[25][1] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][20]$_DFFE_PP_  (.D(net647),
    .DE(_0834_),
    .Q(\cpuregs[25][20] ),
    .CLK(clknet_leaf_19_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][21]$_DFFE_PP_  (.D(net648),
    .DE(_0834_),
    .Q(\cpuregs[25][21] ),
    .CLK(clknet_leaf_20_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(_0834_),
    .Q(\cpuregs[25][22] ),
    .CLK(clknet_leaf_27_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][23]$_DFFE_PP_  (.D(net649),
    .DE(net679),
    .Q(\cpuregs[25][23] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net679),
    .Q(\cpuregs[25][24] ),
    .CLK(clknet_leaf_64_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][25]$_DFFE_PP_  (.D(net640),
    .DE(_0834_),
    .Q(\cpuregs[25][25] ),
    .CLK(clknet_leaf_15_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][26]$_DFFE_PP_  (.D(net643),
    .DE(_0834_),
    .Q(\cpuregs[25][26] ),
    .CLK(clknet_leaf_16_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][27]$_DFFE_PP_  (.D(net644),
    .DE(_0834_),
    .Q(\cpuregs[25][27] ),
    .CLK(clknet_leaf_17_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][28]$_DFFE_PP_  (.D(net645),
    .DE(_0834_),
    .Q(\cpuregs[25][28] ),
    .CLK(clknet_leaf_16_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][29]$_DFFE_PP_  (.D(net641),
    .DE(net679),
    .Q(\cpuregs[25][29] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(_0834_),
    .Q(\cpuregs[25][2] ),
    .CLK(clknet_leaf_27_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][30]$_DFFE_PP_  (.D(net646),
    .DE(net679),
    .Q(\cpuregs[25][30] ),
    .CLK(clknet_leaf_74_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][31]$_DFFE_PP_  (.D(net639),
    .DE(_0834_),
    .Q(\cpuregs[25][31] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(_0834_),
    .Q(\cpuregs[25][3] ),
    .CLK(clknet_leaf_28_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net679),
    .Q(\cpuregs[25][4] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net679),
    .Q(\cpuregs[25][5] ),
    .CLK(clknet_leaf_50_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net679),
    .Q(\cpuregs[25][6] ),
    .CLK(clknet_leaf_68_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][7]$_DFFE_PP_  (.D(net691),
    .DE(net679),
    .Q(\cpuregs[25][7] ),
    .CLK(clknet_leaf_40_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][8]$_DFFE_PP_  (.D(net688),
    .DE(net679),
    .Q(\cpuregs[25][8] ),
    .CLK(clknet_leaf_40_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[25][9]$_DFFE_PP_  (.D(net692),
    .DE(net679),
    .Q(\cpuregs[25][9] ),
    .CLK(clknet_leaf_50_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net683),
    .Q(\cpuregs[26][0] ),
    .CLK(clknet_leaf_28_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(_0835_),
    .Q(\cpuregs[26][10] ),
    .CLK(clknet_leaf_34_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(_0835_),
    .Q(\cpuregs[26][11] ),
    .CLK(clknet_leaf_66_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][12]$_DFFE_PP_  (.D(net685),
    .DE(_0835_),
    .Q(\cpuregs[26][12] ),
    .CLK(clknet_leaf_66_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(_0835_),
    .Q(\cpuregs[26][13] ),
    .CLK(clknet_leaf_62_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(_0835_),
    .Q(\cpuregs[26][14] ),
    .CLK(clknet_leaf_65_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(_0835_),
    .Q(\cpuregs[26][15] ),
    .CLK(clknet_leaf_67_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(_0835_),
    .Q(\cpuregs[26][16] ),
    .CLK(clknet_leaf_65_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][17]$_DFFE_PP_  (.D(net686),
    .DE(net683),
    .Q(\cpuregs[26][17] ),
    .CLK(clknet_leaf_31_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][18]$_DFFE_PP_  (.D(net651),
    .DE(_0835_),
    .Q(\cpuregs[26][18] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][19]$_DFFE_PP_  (.D(net652),
    .DE(net683),
    .Q(\cpuregs[26][19] ),
    .CLK(clknet_leaf_27_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net683),
    .Q(\cpuregs[26][1] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][20]$_DFFE_PP_  (.D(net647),
    .DE(net683),
    .Q(\cpuregs[26][20] ),
    .CLK(clknet_leaf_20_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][21]$_DFFE_PP_  (.D(net648),
    .DE(net683),
    .Q(\cpuregs[26][21] ),
    .CLK(clknet_leaf_70_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net683),
    .Q(\cpuregs[26][22] ),
    .CLK(clknet_leaf_28_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][23]$_DFFE_PP_  (.D(net649),
    .DE(net683),
    .Q(\cpuregs[26][23] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(_0835_),
    .Q(\cpuregs[26][24] ),
    .CLK(clknet_leaf_63_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][25]$_DFFE_PP_  (.D(net640),
    .DE(net683),
    .Q(\cpuregs[26][25] ),
    .CLK(clknet_leaf_15_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][26]$_DFFE_PP_  (.D(net643),
    .DE(net683),
    .Q(\cpuregs[26][26] ),
    .CLK(clknet_leaf_16_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][27]$_DFFE_PP_  (.D(net644),
    .DE(net683),
    .Q(\cpuregs[26][27] ),
    .CLK(clknet_leaf_17_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][28]$_DFFE_PP_  (.D(net645),
    .DE(net683),
    .Q(\cpuregs[26][28] ),
    .CLK(clknet_leaf_16_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][29]$_DFFE_PP_  (.D(net641),
    .DE(_0835_),
    .Q(\cpuregs[26][29] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net683),
    .Q(\cpuregs[26][2] ),
    .CLK(clknet_leaf_27_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][30]$_DFFE_PP_  (.D(net646),
    .DE(_0835_),
    .Q(\cpuregs[26][30] ),
    .CLK(clknet_leaf_72_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][31]$_DFFE_PP_  (.D(net639),
    .DE(net683),
    .Q(\cpuregs[26][31] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net683),
    .Q(\cpuregs[26][3] ),
    .CLK(clknet_leaf_28_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net683),
    .Q(\cpuregs[26][4] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(_0835_),
    .Q(\cpuregs[26][5] ),
    .CLK(clknet_leaf_50_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(_0835_),
    .Q(\cpuregs[26][6] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][7]$_DFFE_PP_  (.D(net691),
    .DE(_0835_),
    .Q(\cpuregs[26][7] ),
    .CLK(clknet_leaf_40_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][8]$_DFFE_PP_  (.D(net688),
    .DE(_0835_),
    .Q(\cpuregs[26][8] ),
    .CLK(clknet_leaf_41_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[26][9]$_DFFE_PP_  (.D(net692),
    .DE(_0835_),
    .Q(\cpuregs[26][9] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net665),
    .Q(\cpuregs[27][0] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net665),
    .Q(\cpuregs[27][10] ),
    .CLK(clknet_leaf_34_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(_0836_),
    .Q(\cpuregs[27][11] ),
    .CLK(clknet_leaf_62_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][12]$_DFFE_PP_  (.D(net685),
    .DE(_0836_),
    .Q(\cpuregs[27][12] ),
    .CLK(clknet_leaf_66_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(_0836_),
    .Q(\cpuregs[27][13] ),
    .CLK(clknet_leaf_63_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(_0836_),
    .Q(\cpuregs[27][14] ),
    .CLK(clknet_leaf_65_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(_0836_),
    .Q(\cpuregs[27][15] ),
    .CLK(clknet_leaf_67_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(_0836_),
    .Q(\cpuregs[27][16] ),
    .CLK(clknet_leaf_65_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][17]$_DFFE_PP_  (.D(net686),
    .DE(net665),
    .Q(\cpuregs[27][17] ),
    .CLK(clknet_leaf_31_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][18]$_DFFE_PP_  (.D(net651),
    .DE(_0836_),
    .Q(\cpuregs[27][18] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][19]$_DFFE_PP_  (.D(net652),
    .DE(net665),
    .Q(\cpuregs[27][19] ),
    .CLK(clknet_leaf_27_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net665),
    .Q(\cpuregs[27][1] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][20]$_DFFE_PP_  (.D(net647),
    .DE(net665),
    .Q(\cpuregs[27][20] ),
    .CLK(clknet_leaf_20_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][21]$_DFFE_PP_  (.D(net648),
    .DE(net665),
    .Q(\cpuregs[27][21] ),
    .CLK(clknet_leaf_20_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net665),
    .Q(\cpuregs[27][22] ),
    .CLK(clknet_leaf_28_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][23]$_DFFE_PP_  (.D(net649),
    .DE(net665),
    .Q(\cpuregs[27][23] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(_0836_),
    .Q(\cpuregs[27][24] ),
    .CLK(clknet_leaf_63_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][25]$_DFFE_PP_  (.D(net640),
    .DE(net665),
    .Q(\cpuregs[27][25] ),
    .CLK(clknet_leaf_15_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][26]$_DFFE_PP_  (.D(net643),
    .DE(net665),
    .Q(\cpuregs[27][26] ),
    .CLK(clknet_leaf_16_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][27]$_DFFE_PP_  (.D(net644),
    .DE(net665),
    .Q(\cpuregs[27][27] ),
    .CLK(clknet_leaf_17_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][28]$_DFFE_PP_  (.D(net645),
    .DE(net665),
    .Q(\cpuregs[27][28] ),
    .CLK(clknet_leaf_16_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][29]$_DFFE_PP_  (.D(net641),
    .DE(_0836_),
    .Q(\cpuregs[27][29] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net665),
    .Q(\cpuregs[27][2] ),
    .CLK(clknet_leaf_27_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][30]$_DFFE_PP_  (.D(net646),
    .DE(_0836_),
    .Q(\cpuregs[27][30] ),
    .CLK(clknet_leaf_75_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][31]$_DFFE_PP_  (.D(net639),
    .DE(net665),
    .Q(\cpuregs[27][31] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net665),
    .Q(\cpuregs[27][3] ),
    .CLK(clknet_leaf_28_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net665),
    .Q(\cpuregs[27][4] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net665),
    .Q(\cpuregs[27][5] ),
    .CLK(clknet_leaf_50_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net665),
    .Q(\cpuregs[27][6] ),
    .CLK(clknet_leaf_51_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][7]$_DFFE_PP_  (.D(net691),
    .DE(net665),
    .Q(\cpuregs[27][7] ),
    .CLK(clknet_leaf_50_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][8]$_DFFE_PP_  (.D(net688),
    .DE(net665),
    .Q(\cpuregs[27][8] ),
    .CLK(clknet_leaf_41_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[27][9]$_DFFE_PP_  (.D(net692),
    .DE(net665),
    .Q(\cpuregs[27][9] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(_0837_),
    .Q(\cpuregs[28][0] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net654),
    .Q(\cpuregs[28][10] ),
    .CLK(clknet_leaf_34_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net654),
    .Q(\cpuregs[28][11] ),
    .CLK(clknet_leaf_87_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][12]$_DFFE_PP_  (.D(net685),
    .DE(net654),
    .Q(\cpuregs[28][12] ),
    .CLK(clknet_leaf_62_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net654),
    .Q(\cpuregs[28][13] ),
    .CLK(clknet_leaf_63_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net654),
    .Q(\cpuregs[28][14] ),
    .CLK(clknet_leaf_89_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net654),
    .Q(\cpuregs[28][15] ),
    .CLK(clknet_leaf_67_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net654),
    .Q(\cpuregs[28][16] ),
    .CLK(clknet_leaf_86_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][17]$_DFFE_PP_  (.D(net686),
    .DE(net654),
    .Q(\cpuregs[28][17] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][18]$_DFFE_PP_  (.D(net651),
    .DE(net654),
    .Q(\cpuregs[28][18] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][19]$_DFFE_PP_  (.D(net652),
    .DE(_0837_),
    .Q(\cpuregs[28][19] ),
    .CLK(clknet_leaf_29_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(_0837_),
    .Q(\cpuregs[28][1] ),
    .CLK(clknet_leaf_3_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][20]$_DFFE_PP_  (.D(net647),
    .DE(_0837_),
    .Q(\cpuregs[28][20] ),
    .CLK(clknet_leaf_70_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][21]$_DFFE_PP_  (.D(net648),
    .DE(_0837_),
    .Q(\cpuregs[28][21] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(_0837_),
    .Q(\cpuregs[28][22] ),
    .CLK(clknet_leaf_29_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][23]$_DFFE_PP_  (.D(net649),
    .DE(net654),
    .Q(\cpuregs[28][23] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net654),
    .Q(\cpuregs[28][24] ),
    .CLK(clknet_leaf_86_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][25]$_DFFE_PP_  (.D(net640),
    .DE(_0837_),
    .Q(\cpuregs[28][25] ),
    .CLK(clknet_leaf_19_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][26]$_DFFE_PP_  (.D(net643),
    .DE(_0837_),
    .Q(\cpuregs[28][26] ),
    .CLK(clknet_leaf_14_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][27]$_DFFE_PP_  (.D(net644),
    .DE(_0837_),
    .Q(\cpuregs[28][27] ),
    .CLK(clknet_leaf_10_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][28]$_DFFE_PP_  (.D(net645),
    .DE(_0837_),
    .Q(\cpuregs[28][28] ),
    .CLK(clknet_leaf_13_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][29]$_DFFE_PP_  (.D(net641),
    .DE(net654),
    .Q(\cpuregs[28][29] ),
    .CLK(clknet_leaf_74_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(_0837_),
    .Q(\cpuregs[28][2] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][30]$_DFFE_PP_  (.D(net646),
    .DE(net654),
    .Q(\cpuregs[28][30] ),
    .CLK(clknet_leaf_80_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][31]$_DFFE_PP_  (.D(net639),
    .DE(_0837_),
    .Q(\cpuregs[28][31] ),
    .CLK(clknet_leaf_4_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(_0837_),
    .Q(\cpuregs[28][3] ),
    .CLK(clknet_leaf_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net654),
    .Q(\cpuregs[28][4] ),
    .CLK(clknet_leaf_34_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net654),
    .Q(\cpuregs[28][5] ),
    .CLK(clknet_leaf_54_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net654),
    .Q(\cpuregs[28][6] ),
    .CLK(clknet_leaf_52_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][7]$_DFFE_PP_  (.D(net691),
    .DE(net654),
    .Q(\cpuregs[28][7] ),
    .CLK(clknet_leaf_44_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][8]$_DFFE_PP_  (.D(net688),
    .DE(net654),
    .Q(\cpuregs[28][8] ),
    .CLK(clknet_leaf_41_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[28][9]$_DFFE_PP_  (.D(net692),
    .DE(net654),
    .Q(\cpuregs[28][9] ),
    .CLK(clknet_leaf_48_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net660),
    .Q(\cpuregs[29][0] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net660),
    .Q(\cpuregs[29][10] ),
    .CLK(clknet_leaf_34_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net660),
    .Q(\cpuregs[29][11] ),
    .CLK(clknet_leaf_87_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][12]$_DFFE_PP_  (.D(net685),
    .DE(net660),
    .Q(\cpuregs[29][12] ),
    .CLK(clknet_leaf_62_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net660),
    .Q(\cpuregs[29][13] ),
    .CLK(clknet_leaf_61_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net660),
    .Q(\cpuregs[29][14] ),
    .CLK(clknet_leaf_61_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net660),
    .Q(\cpuregs[29][15] ),
    .CLK(clknet_leaf_53_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net660),
    .Q(\cpuregs[29][16] ),
    .CLK(clknet_leaf_86_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][17]$_DFFE_PP_  (.D(net686),
    .DE(net660),
    .Q(\cpuregs[29][17] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][18]$_DFFE_PP_  (.D(net651),
    .DE(net660),
    .Q(\cpuregs[29][18] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][19]$_DFFE_PP_  (.D(net652),
    .DE(net660),
    .Q(\cpuregs[29][19] ),
    .CLK(clknet_leaf_29_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net660),
    .Q(\cpuregs[29][1] ),
    .CLK(clknet_leaf_3_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][20]$_DFFE_PP_  (.D(net647),
    .DE(net660),
    .Q(\cpuregs[29][20] ),
    .CLK(clknet_leaf_70_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][21]$_DFFE_PP_  (.D(net648),
    .DE(net660),
    .Q(\cpuregs[29][21] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net660),
    .Q(\cpuregs[29][22] ),
    .CLK(clknet_leaf_29_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][23]$_DFFE_PP_  (.D(net649),
    .DE(net660),
    .Q(\cpuregs[29][23] ),
    .CLK(clknet_leaf_33_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net660),
    .Q(\cpuregs[29][24] ),
    .CLK(clknet_leaf_86_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][25]$_DFFE_PP_  (.D(net640),
    .DE(net660),
    .Q(\cpuregs[29][25] ),
    .CLK(clknet_leaf_19_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][26]$_DFFE_PP_  (.D(net643),
    .DE(net660),
    .Q(\cpuregs[29][26] ),
    .CLK(clknet_leaf_14_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][27]$_DFFE_PP_  (.D(net644),
    .DE(net660),
    .Q(\cpuregs[29][27] ),
    .CLK(clknet_leaf_10_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][28]$_DFFE_PP_  (.D(net645),
    .DE(net660),
    .Q(\cpuregs[29][28] ),
    .CLK(clknet_leaf_13_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][29]$_DFFE_PP_  (.D(net641),
    .DE(net660),
    .Q(\cpuregs[29][29] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net660),
    .Q(\cpuregs[29][2] ),
    .CLK(clknet_leaf_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][30]$_DFFE_PP_  (.D(net646),
    .DE(net660),
    .Q(\cpuregs[29][30] ),
    .CLK(clknet_leaf_80_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][31]$_DFFE_PP_  (.D(net639),
    .DE(net660),
    .Q(\cpuregs[29][31] ),
    .CLK(clknet_leaf_4_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net660),
    .Q(\cpuregs[29][3] ),
    .CLK(clknet_leaf_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net660),
    .Q(\cpuregs[29][4] ),
    .CLK(clknet_leaf_33_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net660),
    .Q(\cpuregs[29][5] ),
    .CLK(clknet_leaf_47_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net660),
    .Q(\cpuregs[29][6] ),
    .CLK(clknet_leaf_52_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][7]$_DFFE_PP_  (.D(net691),
    .DE(net660),
    .Q(\cpuregs[29][7] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][8]$_DFFE_PP_  (.D(net688),
    .DE(net660),
    .Q(\cpuregs[29][8] ),
    .CLK(clknet_leaf_42_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[29][9]$_DFFE_PP_  (.D(net692),
    .DE(net660),
    .Q(\cpuregs[29][9] ),
    .CLK(clknet_leaf_47_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net657),
    .Q(\cpuregs[2][0] ),
    .CLK(clknet_leaf_10_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net657),
    .Q(\cpuregs[2][10] ),
    .CLK(clknet_leaf_39_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(_0839_),
    .Q(\cpuregs[2][11] ),
    .CLK(clknet_leaf_93_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][12]$_DFFE_PP_  (.D(net685),
    .DE(net657),
    .Q(\cpuregs[2][12] ),
    .CLK(clknet_leaf_57_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(_0839_),
    .Q(\cpuregs[2][13] ),
    .CLK(clknet_leaf_92_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(_0839_),
    .Q(\cpuregs[2][14] ),
    .CLK(clknet_leaf_92_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net657),
    .Q(\cpuregs[2][15] ),
    .CLK(clknet_leaf_57_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(_0839_),
    .Q(\cpuregs[2][16] ),
    .CLK(clknet_leaf_93_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][17]$_DFFE_PP_  (.D(net686),
    .DE(net657),
    .Q(\cpuregs[2][17] ),
    .CLK(clknet_leaf_22_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][18]$_DFFE_PP_  (.D(net651),
    .DE(_0839_),
    .Q(\cpuregs[2][18] ),
    .CLK(clknet_leaf_85_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][19]$_DFFE_PP_  (.D(net652),
    .DE(net657),
    .Q(\cpuregs[2][19] ),
    .CLK(clknet_leaf_23_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net657),
    .Q(\cpuregs[2][1] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][20]$_DFFE_PP_  (.D(net647),
    .DE(net657),
    .Q(\cpuregs[2][20] ),
    .CLK(clknet_leaf_72_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][21]$_DFFE_PP_  (.D(net648),
    .DE(net657),
    .Q(\cpuregs[2][21] ),
    .CLK(clknet_leaf_68_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net657),
    .Q(\cpuregs[2][22] ),
    .CLK(clknet_leaf_3_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][23]$_DFFE_PP_  (.D(net649),
    .DE(net657),
    .Q(\cpuregs[2][23] ),
    .CLK(clknet_leaf_36_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(_0839_),
    .Q(\cpuregs[2][24] ),
    .CLK(clknet_leaf_93_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][25]$_DFFE_PP_  (.D(net640),
    .DE(_0839_),
    .Q(\cpuregs[2][25] ),
    .CLK(clknet_leaf_75_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][26]$_DFFE_PP_  (.D(net643),
    .DE(net657),
    .Q(\cpuregs[2][26] ),
    .CLK(clknet_leaf_12_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][27]$_DFFE_PP_  (.D(net644),
    .DE(net657),
    .Q(\cpuregs[2][27] ),
    .CLK(clknet_leaf_11_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][28]$_DFFE_PP_  (.D(net645),
    .DE(net657),
    .Q(\cpuregs[2][28] ),
    .CLK(clknet_leaf_11_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][29]$_DFFE_PP_  (.D(net641),
    .DE(_0839_),
    .Q(\cpuregs[2][29] ),
    .CLK(clknet_leaf_82_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net657),
    .Q(\cpuregs[2][2] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][30]$_DFFE_PP_  (.D(net646),
    .DE(_0839_),
    .Q(\cpuregs[2][30] ),
    .CLK(clknet_leaf_79_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][31]$_DFFE_PP_  (.D(net639),
    .DE(net657),
    .Q(\cpuregs[2][31] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net657),
    .Q(\cpuregs[2][3] ),
    .CLK(clknet_leaf_2_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net657),
    .Q(\cpuregs[2][4] ),
    .CLK(clknet_leaf_37_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net657),
    .Q(\cpuregs[2][5] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net657),
    .Q(\cpuregs[2][6] ),
    .CLK(clknet_leaf_53_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][7]$_DFFE_PP_  (.D(net691),
    .DE(net657),
    .Q(\cpuregs[2][7] ),
    .CLK(clknet_leaf_44_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][8]$_DFFE_PP_  (.D(net688),
    .DE(net657),
    .Q(\cpuregs[2][8] ),
    .CLK(clknet_leaf_39_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[2][9]$_DFFE_PP_  (.D(net692),
    .DE(net657),
    .Q(\cpuregs[2][9] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net656),
    .Q(\cpuregs[30][0] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net656),
    .Q(\cpuregs[30][10] ),
    .CLK(clknet_leaf_33_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(_0840_),
    .Q(\cpuregs[30][11] ),
    .CLK(clknet_leaf_63_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][12]$_DFFE_PP_  (.D(net685),
    .DE(_0840_),
    .Q(\cpuregs[30][12] ),
    .CLK(clknet_leaf_62_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(_0840_),
    .Q(\cpuregs[30][13] ),
    .CLK(clknet_leaf_63_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(_0840_),
    .Q(\cpuregs[30][14] ),
    .CLK(clknet_leaf_63_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(_0840_),
    .Q(\cpuregs[30][15] ),
    .CLK(clknet_leaf_53_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(_0840_),
    .Q(\cpuregs[30][16] ),
    .CLK(clknet_leaf_64_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][17]$_DFFE_PP_  (.D(net686),
    .DE(net656),
    .Q(\cpuregs[30][17] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][18]$_DFFE_PP_  (.D(net651),
    .DE(_0840_),
    .Q(\cpuregs[30][18] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][19]$_DFFE_PP_  (.D(net652),
    .DE(net656),
    .Q(\cpuregs[30][19] ),
    .CLK(clknet_leaf_29_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net656),
    .Q(\cpuregs[30][1] ),
    .CLK(clknet_leaf_3_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][20]$_DFFE_PP_  (.D(net647),
    .DE(net656),
    .Q(\cpuregs[30][20] ),
    .CLK(clknet_leaf_20_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][21]$_DFFE_PP_  (.D(net648),
    .DE(net656),
    .Q(\cpuregs[30][21] ),
    .CLK(clknet_leaf_21_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net656),
    .Q(\cpuregs[30][22] ),
    .CLK(clknet_leaf_29_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][23]$_DFFE_PP_  (.D(net649),
    .DE(net656),
    .Q(\cpuregs[30][23] ),
    .CLK(clknet_leaf_33_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(_0840_),
    .Q(\cpuregs[30][24] ),
    .CLK(clknet_leaf_63_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][25]$_DFFE_PP_  (.D(net640),
    .DE(net656),
    .Q(\cpuregs[30][25] ),
    .CLK(clknet_leaf_18_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][26]$_DFFE_PP_  (.D(net643),
    .DE(_0840_),
    .Q(\cpuregs[30][26] ),
    .CLK(clknet_leaf_15_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][27]$_DFFE_PP_  (.D(net644),
    .DE(net656),
    .Q(\cpuregs[30][27] ),
    .CLK(clknet_leaf_10_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][28]$_DFFE_PP_  (.D(net645),
    .DE(net656),
    .Q(\cpuregs[30][28] ),
    .CLK(clknet_leaf_11_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][29]$_DFFE_PP_  (.D(net641),
    .DE(_0840_),
    .Q(\cpuregs[30][29] ),
    .CLK(clknet_leaf_74_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net656),
    .Q(\cpuregs[30][2] ),
    .CLK(clknet_leaf_28_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][30]$_DFFE_PP_  (.D(net646),
    .DE(_0840_),
    .Q(\cpuregs[30][30] ),
    .CLK(clknet_leaf_74_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][31]$_DFFE_PP_  (.D(net639),
    .DE(net656),
    .Q(\cpuregs[30][31] ),
    .CLK(clknet_leaf_4_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net656),
    .Q(\cpuregs[30][3] ),
    .CLK(clknet_leaf_29_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net656),
    .Q(\cpuregs[30][4] ),
    .CLK(clknet_leaf_33_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net656),
    .Q(\cpuregs[30][5] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net656),
    .Q(\cpuregs[30][6] ),
    .CLK(clknet_leaf_52_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][7]$_DFFE_PP_  (.D(net691),
    .DE(net656),
    .Q(\cpuregs[30][7] ),
    .CLK(clknet_leaf_43_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][8]$_DFFE_PP_  (.D(net688),
    .DE(net656),
    .Q(\cpuregs[30][8] ),
    .CLK(clknet_leaf_42_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[30][9]$_DFFE_PP_  (.D(net692),
    .DE(net656),
    .Q(\cpuregs[30][9] ),
    .CLK(clknet_leaf_48_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net677),
    .Q(\cpuregs[31][0] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net677),
    .Q(\cpuregs[31][10] ),
    .CLK(clknet_leaf_34_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(_0841_),
    .Q(\cpuregs[31][11] ),
    .CLK(clknet_leaf_63_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][12]$_DFFE_PP_  (.D(net685),
    .DE(_0841_),
    .Q(\cpuregs[31][12] ),
    .CLK(clknet_leaf_61_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(_0841_),
    .Q(\cpuregs[31][13] ),
    .CLK(clknet_leaf_61_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(_0841_),
    .Q(\cpuregs[31][14] ),
    .CLK(clknet_leaf_61_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(_0841_),
    .Q(\cpuregs[31][15] ),
    .CLK(clknet_leaf_53_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(_0841_),
    .Q(\cpuregs[31][16] ),
    .CLK(clknet_leaf_64_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][17]$_DFFE_PP_  (.D(net686),
    .DE(net677),
    .Q(\cpuregs[31][17] ),
    .CLK(clknet_leaf_32_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][18]$_DFFE_PP_  (.D(net651),
    .DE(_0841_),
    .Q(\cpuregs[31][18] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][19]$_DFFE_PP_  (.D(net652),
    .DE(net677),
    .Q(\cpuregs[31][19] ),
    .CLK(clknet_leaf_29_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net677),
    .Q(\cpuregs[31][1] ),
    .CLK(clknet_leaf_3_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][20]$_DFFE_PP_  (.D(net647),
    .DE(net677),
    .Q(\cpuregs[31][20] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][21]$_DFFE_PP_  (.D(net648),
    .DE(net677),
    .Q(\cpuregs[31][21] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net677),
    .Q(\cpuregs[31][22] ),
    .CLK(clknet_leaf_29_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][23]$_DFFE_PP_  (.D(net649),
    .DE(net677),
    .Q(\cpuregs[31][23] ),
    .CLK(clknet_leaf_33_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(_0841_),
    .Q(\cpuregs[31][24] ),
    .CLK(clknet_leaf_63_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][25]$_DFFE_PP_  (.D(net640),
    .DE(net677),
    .Q(\cpuregs[31][25] ),
    .CLK(clknet_leaf_19_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][26]$_DFFE_PP_  (.D(net643),
    .DE(net677),
    .Q(\cpuregs[31][26] ),
    .CLK(clknet_leaf_16_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][27]$_DFFE_PP_  (.D(net644),
    .DE(net677),
    .Q(\cpuregs[31][27] ),
    .CLK(clknet_leaf_10_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][28]$_DFFE_PP_  (.D(net645),
    .DE(net677),
    .Q(\cpuregs[31][28] ),
    .CLK(clknet_leaf_11_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][29]$_DFFE_PP_  (.D(net641),
    .DE(_0841_),
    .Q(\cpuregs[31][29] ),
    .CLK(clknet_leaf_74_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net677),
    .Q(\cpuregs[31][2] ),
    .CLK(clknet_leaf_1_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][30]$_DFFE_PP_  (.D(net646),
    .DE(_0841_),
    .Q(\cpuregs[31][30] ),
    .CLK(clknet_leaf_74_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][31]$_DFFE_PP_  (.D(net639),
    .DE(net677),
    .Q(\cpuregs[31][31] ),
    .CLK(clknet_leaf_4_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net677),
    .Q(\cpuregs[31][3] ),
    .CLK(clknet_leaf_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net677),
    .Q(\cpuregs[31][4] ),
    .CLK(clknet_leaf_33_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net677),
    .Q(\cpuregs[31][5] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net677),
    .Q(\cpuregs[31][6] ),
    .CLK(clknet_leaf_52_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][7]$_DFFE_PP_  (.D(net691),
    .DE(net677),
    .Q(\cpuregs[31][7] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][8]$_DFFE_PP_  (.D(net688),
    .DE(net677),
    .Q(\cpuregs[31][8] ),
    .CLK(clknet_leaf_42_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[31][9]$_DFFE_PP_  (.D(net692),
    .DE(net677),
    .Q(\cpuregs[31][9] ),
    .CLK(clknet_leaf_48_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net659),
    .Q(\cpuregs[3][0] ),
    .CLK(clknet_leaf_10_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net659),
    .Q(\cpuregs[3][10] ),
    .CLK(clknet_leaf_39_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net659),
    .Q(\cpuregs[3][11] ),
    .CLK(clknet_leaf_93_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][12]$_DFFE_PP_  (.D(net685),
    .DE(net659),
    .Q(\cpuregs[3][12] ),
    .CLK(clknet_leaf_57_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net659),
    .Q(\cpuregs[3][13] ),
    .CLK(clknet_leaf_93_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net659),
    .Q(\cpuregs[3][14] ),
    .CLK(clknet_leaf_95_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net659),
    .Q(\cpuregs[3][15] ),
    .CLK(clknet_leaf_57_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net659),
    .Q(\cpuregs[3][16] ),
    .CLK(clknet_leaf_93_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][17]$_DFFE_PP_  (.D(net686),
    .DE(net659),
    .Q(\cpuregs[3][17] ),
    .CLK(clknet_leaf_22_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][18]$_DFFE_PP_  (.D(net651),
    .DE(net659),
    .Q(\cpuregs[3][18] ),
    .CLK(clknet_leaf_85_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][19]$_DFFE_PP_  (.D(net652),
    .DE(net659),
    .Q(\cpuregs[3][19] ),
    .CLK(clknet_leaf_23_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net659),
    .Q(\cpuregs[3][1] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][20]$_DFFE_PP_  (.D(net647),
    .DE(net659),
    .Q(\cpuregs[3][20] ),
    .CLK(clknet_leaf_72_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][21]$_DFFE_PP_  (.D(net648),
    .DE(net659),
    .Q(\cpuregs[3][21] ),
    .CLK(clknet_leaf_68_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net659),
    .Q(\cpuregs[3][22] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][23]$_DFFE_PP_  (.D(net649),
    .DE(net659),
    .Q(\cpuregs[3][23] ),
    .CLK(clknet_leaf_36_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net659),
    .Q(\cpuregs[3][24] ),
    .CLK(clknet_leaf_93_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][25]$_DFFE_PP_  (.D(net640),
    .DE(net659),
    .Q(\cpuregs[3][25] ),
    .CLK(clknet_leaf_75_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][26]$_DFFE_PP_  (.D(net643),
    .DE(net659),
    .Q(\cpuregs[3][26] ),
    .CLK(clknet_leaf_12_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][27]$_DFFE_PP_  (.D(net644),
    .DE(net659),
    .Q(\cpuregs[3][27] ),
    .CLK(clknet_leaf_11_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][28]$_DFFE_PP_  (.D(net645),
    .DE(net659),
    .Q(\cpuregs[3][28] ),
    .CLK(clknet_leaf_11_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][29]$_DFFE_PP_  (.D(net641),
    .DE(net659),
    .Q(\cpuregs[3][29] ),
    .CLK(clknet_leaf_82_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net659),
    .Q(\cpuregs[3][2] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][30]$_DFFE_PP_  (.D(net646),
    .DE(net659),
    .Q(\cpuregs[3][30] ),
    .CLK(clknet_leaf_79_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][31]$_DFFE_PP_  (.D(net639),
    .DE(net659),
    .Q(\cpuregs[3][31] ),
    .CLK(clknet_leaf_9_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net659),
    .Q(\cpuregs[3][3] ),
    .CLK(clknet_leaf_2_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net659),
    .Q(\cpuregs[3][4] ),
    .CLK(clknet_leaf_37_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net659),
    .Q(\cpuregs[3][5] ),
    .CLK(clknet_leaf_50_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net659),
    .Q(\cpuregs[3][6] ),
    .CLK(clknet_leaf_54_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][7]$_DFFE_PP_  (.D(net691),
    .DE(net659),
    .Q(\cpuregs[3][7] ),
    .CLK(clknet_leaf_48_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][8]$_DFFE_PP_  (.D(net688),
    .DE(net659),
    .Q(\cpuregs[3][8] ),
    .CLK(clknet_leaf_39_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[3][9]$_DFFE_PP_  (.D(net692),
    .DE(net659),
    .Q(\cpuregs[3][9] ),
    .CLK(clknet_leaf_39_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(_0843_),
    .Q(\cpuregs[4][0] ),
    .CLK(clknet_leaf_9_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net661),
    .Q(\cpuregs[4][10] ),
    .CLK(clknet_leaf_39_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net661),
    .Q(\cpuregs[4][11] ),
    .CLK(clknet_leaf_93_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][12]$_DFFE_PP_  (.D(net685),
    .DE(net661),
    .Q(\cpuregs[4][12] ),
    .CLK(clknet_leaf_59_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net661),
    .Q(\cpuregs[4][13] ),
    .CLK(clknet_leaf_93_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net661),
    .Q(\cpuregs[4][14] ),
    .CLK(clknet_leaf_92_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net661),
    .Q(\cpuregs[4][15] ),
    .CLK(clknet_leaf_56_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net661),
    .Q(\cpuregs[4][16] ),
    .CLK(clknet_leaf_93_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][17]$_DFFE_PP_  (.D(net686),
    .DE(net661),
    .Q(\cpuregs[4][17] ),
    .CLK(clknet_leaf_36_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][18]$_DFFE_PP_  (.D(net651),
    .DE(net661),
    .Q(\cpuregs[4][18] ),
    .CLK(clknet_leaf_85_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][19]$_DFFE_PP_  (.D(net652),
    .DE(net661),
    .Q(\cpuregs[4][19] ),
    .CLK(clknet_leaf_26_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(_0843_),
    .Q(\cpuregs[4][1] ),
    .CLK(clknet_leaf_7_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][20]$_DFFE_PP_  (.D(net647),
    .DE(net661),
    .Q(\cpuregs[4][20] ),
    .CLK(clknet_leaf_71_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][21]$_DFFE_PP_  (.D(net648),
    .DE(net661),
    .Q(\cpuregs[4][21] ),
    .CLK(clknet_leaf_67_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(_0843_),
    .Q(\cpuregs[4][22] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][23]$_DFFE_PP_  (.D(net649),
    .DE(net661),
    .Q(\cpuregs[4][23] ),
    .CLK(clknet_leaf_36_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net661),
    .Q(\cpuregs[4][24] ),
    .CLK(clknet_leaf_93_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][25]$_DFFE_PP_  (.D(net640),
    .DE(net661),
    .Q(\cpuregs[4][25] ),
    .CLK(clknet_leaf_73_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][26]$_DFFE_PP_  (.D(net643),
    .DE(_0843_),
    .Q(\cpuregs[4][26] ),
    .CLK(clknet_leaf_11_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][27]$_DFFE_PP_  (.D(net644),
    .DE(_0843_),
    .Q(\cpuregs[4][27] ),
    .CLK(clknet_leaf_8_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][28]$_DFFE_PP_  (.D(net645),
    .DE(_0843_),
    .Q(\cpuregs[4][28] ),
    .CLK(clknet_leaf_8_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][29]$_DFFE_PP_  (.D(net641),
    .DE(net661),
    .Q(\cpuregs[4][29] ),
    .CLK(clknet_leaf_82_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(_0843_),
    .Q(\cpuregs[4][2] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][30]$_DFFE_PP_  (.D(net646),
    .DE(net661),
    .Q(\cpuregs[4][30] ),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][31]$_DFFE_PP_  (.D(net639),
    .DE(_0843_),
    .Q(\cpuregs[4][31] ),
    .CLK(clknet_leaf_9_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(_0843_),
    .Q(\cpuregs[4][3] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net661),
    .Q(\cpuregs[4][4] ),
    .CLK(clknet_leaf_37_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net661),
    .Q(\cpuregs[4][5] ),
    .CLK(clknet_leaf_46_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net661),
    .Q(\cpuregs[4][6] ),
    .CLK(clknet_leaf_55_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][7]$_DFFE_PP_  (.D(net691),
    .DE(net661),
    .Q(\cpuregs[4][7] ),
    .CLK(clknet_leaf_44_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][8]$_DFFE_PP_  (.D(net688),
    .DE(net661),
    .Q(\cpuregs[4][8] ),
    .CLK(clknet_leaf_40_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[4][9]$_DFFE_PP_  (.D(net692),
    .DE(net661),
    .Q(\cpuregs[4][9] ),
    .CLK(clknet_leaf_46_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(_0844_),
    .Q(\cpuregs[5][0] ),
    .CLK(clknet_leaf_8_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net662),
    .Q(\cpuregs[5][10] ),
    .CLK(clknet_leaf_37_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net662),
    .Q(\cpuregs[5][11] ),
    .CLK(clknet_leaf_91_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][12]$_DFFE_PP_  (.D(net685),
    .DE(net662),
    .Q(\cpuregs[5][12] ),
    .CLK(clknet_leaf_58_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net662),
    .Q(\cpuregs[5][13] ),
    .CLK(clknet_leaf_91_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net662),
    .Q(\cpuregs[5][14] ),
    .CLK(clknet_leaf_92_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net662),
    .Q(\cpuregs[5][15] ),
    .CLK(clknet_leaf_56_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net662),
    .Q(\cpuregs[5][16] ),
    .CLK(clknet_leaf_91_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][17]$_DFFE_PP_  (.D(net686),
    .DE(net662),
    .Q(\cpuregs[5][17] ),
    .CLK(clknet_leaf_36_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][18]$_DFFE_PP_  (.D(net651),
    .DE(net662),
    .Q(\cpuregs[5][18] ),
    .CLK(clknet_leaf_85_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][19]$_DFFE_PP_  (.D(net652),
    .DE(net662),
    .Q(\cpuregs[5][19] ),
    .CLK(clknet_leaf_31_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(_0844_),
    .Q(\cpuregs[5][1] ),
    .CLK(clknet_leaf_7_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][20]$_DFFE_PP_  (.D(net647),
    .DE(net662),
    .Q(\cpuregs[5][20] ),
    .CLK(clknet_leaf_71_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][21]$_DFFE_PP_  (.D(net648),
    .DE(net662),
    .Q(\cpuregs[5][21] ),
    .CLK(clknet_leaf_68_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(_0844_),
    .Q(\cpuregs[5][22] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][23]$_DFFE_PP_  (.D(net649),
    .DE(net662),
    .Q(\cpuregs[5][23] ),
    .CLK(clknet_leaf_36_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net662),
    .Q(\cpuregs[5][24] ),
    .CLK(clknet_leaf_91_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][25]$_DFFE_PP_  (.D(net640),
    .DE(net662),
    .Q(\cpuregs[5][25] ),
    .CLK(clknet_leaf_65_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][26]$_DFFE_PP_  (.D(net643),
    .DE(_0844_),
    .Q(\cpuregs[5][26] ),
    .CLK(clknet_leaf_12_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][27]$_DFFE_PP_  (.D(net644),
    .DE(_0844_),
    .Q(\cpuregs[5][27] ),
    .CLK(clknet_leaf_8_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][28]$_DFFE_PP_  (.D(net645),
    .DE(_0844_),
    .Q(\cpuregs[5][28] ),
    .CLK(clknet_leaf_8_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][29]$_DFFE_PP_  (.D(net641),
    .DE(net662),
    .Q(\cpuregs[5][29] ),
    .CLK(clknet_leaf_82_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(_0844_),
    .Q(\cpuregs[5][2] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][30]$_DFFE_PP_  (.D(net646),
    .DE(net662),
    .Q(\cpuregs[5][30] ),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][31]$_DFFE_PP_  (.D(net639),
    .DE(_0844_),
    .Q(\cpuregs[5][31] ),
    .CLK(clknet_leaf_9_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(_0844_),
    .Q(\cpuregs[5][3] ),
    .CLK(clknet_leaf_2_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net662),
    .Q(\cpuregs[5][4] ),
    .CLK(clknet_leaf_37_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net662),
    .Q(\cpuregs[5][5] ),
    .CLK(clknet_leaf_50_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net662),
    .Q(\cpuregs[5][6] ),
    .CLK(clknet_leaf_55_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][7]$_DFFE_PP_  (.D(net691),
    .DE(net662),
    .Q(\cpuregs[5][7] ),
    .CLK(clknet_leaf_43_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][8]$_DFFE_PP_  (.D(net688),
    .DE(net662),
    .Q(\cpuregs[5][8] ),
    .CLK(clknet_leaf_40_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[5][9]$_DFFE_PP_  (.D(net692),
    .DE(net662),
    .Q(\cpuregs[5][9] ),
    .CLK(clknet_leaf_38_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net664),
    .Q(\cpuregs[6][0] ),
    .CLK(clknet_leaf_9_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net664),
    .Q(\cpuregs[6][10] ),
    .CLK(clknet_leaf_40_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net664),
    .Q(\cpuregs[6][11] ),
    .CLK(clknet_leaf_91_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][12]$_DFFE_PP_  (.D(net685),
    .DE(net664),
    .Q(\cpuregs[6][12] ),
    .CLK(clknet_leaf_58_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net664),
    .Q(\cpuregs[6][13] ),
    .CLK(clknet_leaf_92_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net664),
    .Q(\cpuregs[6][14] ),
    .CLK(clknet_leaf_92_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net664),
    .Q(\cpuregs[6][15] ),
    .CLK(clknet_leaf_56_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net664),
    .Q(\cpuregs[6][16] ),
    .CLK(clknet_leaf_91_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][17]$_DFFE_PP_  (.D(net686),
    .DE(net664),
    .Q(\cpuregs[6][17] ),
    .CLK(clknet_leaf_36_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][18]$_DFFE_PP_  (.D(net651),
    .DE(net664),
    .Q(\cpuregs[6][18] ),
    .CLK(clknet_leaf_85_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][19]$_DFFE_PP_  (.D(net652),
    .DE(net664),
    .Q(\cpuregs[6][19] ),
    .CLK(clknet_leaf_31_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net664),
    .Q(\cpuregs[6][1] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][20]$_DFFE_PP_  (.D(net647),
    .DE(net664),
    .Q(\cpuregs[6][20] ),
    .CLK(clknet_leaf_71_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][21]$_DFFE_PP_  (.D(net648),
    .DE(net664),
    .Q(\cpuregs[6][21] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net664),
    .Q(\cpuregs[6][22] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][23]$_DFFE_PP_  (.D(net649),
    .DE(net664),
    .Q(\cpuregs[6][23] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net664),
    .Q(\cpuregs[6][24] ),
    .CLK(clknet_leaf_91_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][25]$_DFFE_PP_  (.D(net640),
    .DE(net664),
    .Q(\cpuregs[6][25] ),
    .CLK(clknet_leaf_72_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][26]$_DFFE_PP_  (.D(net643),
    .DE(net664),
    .Q(\cpuregs[6][26] ),
    .CLK(clknet_leaf_12_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][27]$_DFFE_PP_  (.D(net644),
    .DE(net664),
    .Q(\cpuregs[6][27] ),
    .CLK(clknet_leaf_8_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][28]$_DFFE_PP_  (.D(net645),
    .DE(net664),
    .Q(\cpuregs[6][28] ),
    .CLK(clknet_leaf_8_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][29]$_DFFE_PP_  (.D(net641),
    .DE(net664),
    .Q(\cpuregs[6][29] ),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net664),
    .Q(\cpuregs[6][2] ),
    .CLK(clknet_leaf_155_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][30]$_DFFE_PP_  (.D(net646),
    .DE(net664),
    .Q(\cpuregs[6][30] ),
    .CLK(clknet_leaf_74_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][31]$_DFFE_PP_  (.D(net639),
    .DE(net664),
    .Q(\cpuregs[6][31] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net664),
    .Q(\cpuregs[6][3] ),
    .CLK(clknet_leaf_2_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net664),
    .Q(\cpuregs[6][4] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net664),
    .Q(\cpuregs[6][5] ),
    .CLK(clknet_leaf_46_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net664),
    .Q(\cpuregs[6][6] ),
    .CLK(clknet_leaf_55_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][7]$_DFFE_PP_  (.D(net691),
    .DE(net664),
    .Q(\cpuregs[6][7] ),
    .CLK(clknet_leaf_40_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][8]$_DFFE_PP_  (.D(net688),
    .DE(net664),
    .Q(\cpuregs[6][8] ),
    .CLK(clknet_leaf_41_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[6][9]$_DFFE_PP_  (.D(net692),
    .DE(net664),
    .Q(\cpuregs[6][9] ),
    .CLK(clknet_leaf_47_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net666),
    .Q(\cpuregs[7][0] ),
    .CLK(clknet_leaf_9_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net666),
    .Q(\cpuregs[7][10] ),
    .CLK(clknet_leaf_40_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net666),
    .Q(\cpuregs[7][11] ),
    .CLK(clknet_leaf_91_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][12]$_DFFE_PP_  (.D(net685),
    .DE(net666),
    .Q(\cpuregs[7][12] ),
    .CLK(clknet_leaf_58_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net666),
    .Q(\cpuregs[7][13] ),
    .CLK(clknet_leaf_91_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net666),
    .Q(\cpuregs[7][14] ),
    .CLK(clknet_leaf_92_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net666),
    .Q(\cpuregs[7][15] ),
    .CLK(clknet_leaf_56_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net666),
    .Q(\cpuregs[7][16] ),
    .CLK(clknet_leaf_91_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][17]$_DFFE_PP_  (.D(net686),
    .DE(net666),
    .Q(\cpuregs[7][17] ),
    .CLK(clknet_leaf_36_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][18]$_DFFE_PP_  (.D(net651),
    .DE(net666),
    .Q(\cpuregs[7][18] ),
    .CLK(clknet_leaf_85_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][19]$_DFFE_PP_  (.D(net652),
    .DE(net666),
    .Q(\cpuregs[7][19] ),
    .CLK(clknet_leaf_27_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net666),
    .Q(\cpuregs[7][1] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][20]$_DFFE_PP_  (.D(net647),
    .DE(net666),
    .Q(\cpuregs[7][20] ),
    .CLK(clknet_leaf_71_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][21]$_DFFE_PP_  (.D(net648),
    .DE(net666),
    .Q(\cpuregs[7][21] ),
    .CLK(clknet_leaf_68_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net666),
    .Q(\cpuregs[7][22] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][23]$_DFFE_PP_  (.D(net649),
    .DE(net666),
    .Q(\cpuregs[7][23] ),
    .CLK(clknet_leaf_36_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net666),
    .Q(\cpuregs[7][24] ),
    .CLK(clknet_leaf_91_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][25]$_DFFE_PP_  (.D(net640),
    .DE(net666),
    .Q(\cpuregs[7][25] ),
    .CLK(clknet_leaf_72_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][26]$_DFFE_PP_  (.D(net643),
    .DE(net666),
    .Q(\cpuregs[7][26] ),
    .CLK(clknet_leaf_11_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][27]$_DFFE_PP_  (.D(net644),
    .DE(net666),
    .Q(\cpuregs[7][27] ),
    .CLK(clknet_leaf_8_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][28]$_DFFE_PP_  (.D(net645),
    .DE(net666),
    .Q(\cpuregs[7][28] ),
    .CLK(clknet_leaf_12_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][29]$_DFFE_PP_  (.D(net641),
    .DE(net666),
    .Q(\cpuregs[7][29] ),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net666),
    .Q(\cpuregs[7][2] ),
    .CLK(clknet_leaf_6_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][30]$_DFFE_PP_  (.D(net646),
    .DE(net666),
    .Q(\cpuregs[7][30] ),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][31]$_DFFE_PP_  (.D(net639),
    .DE(net666),
    .Q(\cpuregs[7][31] ),
    .CLK(clknet_leaf_5_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net666),
    .Q(\cpuregs[7][3] ),
    .CLK(clknet_leaf_2_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net666),
    .Q(\cpuregs[7][4] ),
    .CLK(clknet_leaf_37_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net666),
    .Q(\cpuregs[7][5] ),
    .CLK(clknet_leaf_46_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net666),
    .Q(\cpuregs[7][6] ),
    .CLK(clknet_leaf_55_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][7]$_DFFE_PP_  (.D(net691),
    .DE(net666),
    .Q(\cpuregs[7][7] ),
    .CLK(clknet_leaf_35_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][8]$_DFFE_PP_  (.D(net688),
    .DE(net666),
    .Q(\cpuregs[7][8] ),
    .CLK(clknet_leaf_37_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[7][9]$_DFFE_PP_  (.D(net692),
    .DE(net666),
    .Q(\cpuregs[7][9] ),
    .CLK(clknet_leaf_54_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(net667),
    .Q(\cpuregs[8][0] ),
    .CLK(clknet_leaf_17_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(_0847_),
    .Q(\cpuregs[8][10] ),
    .CLK(clknet_leaf_69_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(net667),
    .Q(\cpuregs[8][11] ),
    .CLK(clknet_leaf_87_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][12]$_DFFE_PP_  (.D(net685),
    .DE(_0847_),
    .Q(\cpuregs[8][12] ),
    .CLK(clknet_leaf_66_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(net667),
    .Q(\cpuregs[8][13] ),
    .CLK(clknet_leaf_88_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(net667),
    .Q(\cpuregs[8][14] ),
    .CLK(clknet_leaf_88_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(_0847_),
    .Q(\cpuregs[8][15] ),
    .CLK(clknet_leaf_67_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(net667),
    .Q(\cpuregs[8][16] ),
    .CLK(clknet_leaf_85_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][17]$_DFFE_PP_  (.D(net686),
    .DE(_0847_),
    .Q(\cpuregs[8][17] ),
    .CLK(clknet_leaf_22_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][18]$_DFFE_PP_  (.D(net651),
    .DE(net667),
    .Q(\cpuregs[8][18] ),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][19]$_DFFE_PP_  (.D(net652),
    .DE(_0847_),
    .Q(\cpuregs[8][19] ),
    .CLK(clknet_leaf_18_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net667),
    .Q(\cpuregs[8][1] ),
    .CLK(clknet_leaf_18_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][20]$_DFFE_PP_  (.D(net647),
    .DE(_0847_),
    .Q(\cpuregs[8][20] ),
    .CLK(clknet_leaf_19_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][21]$_DFFE_PP_  (.D(net648),
    .DE(_0847_),
    .Q(\cpuregs[8][21] ),
    .CLK(clknet_leaf_68_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net667),
    .Q(\cpuregs[8][22] ),
    .CLK(clknet_leaf_4_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][23]$_DFFE_PP_  (.D(net649),
    .DE(_0847_),
    .Q(\cpuregs[8][23] ),
    .CLK(clknet_leaf_21_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(net667),
    .Q(\cpuregs[8][24] ),
    .CLK(clknet_leaf_84_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][25]$_DFFE_PP_  (.D(net640),
    .DE(net667),
    .Q(\cpuregs[8][25] ),
    .CLK(clknet_leaf_76_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][26]$_DFFE_PP_  (.D(net643),
    .DE(net667),
    .Q(\cpuregs[8][26] ),
    .CLK(clknet_leaf_13_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][27]$_DFFE_PP_  (.D(net644),
    .DE(net667),
    .Q(\cpuregs[8][27] ),
    .CLK(clknet_leaf_11_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][28]$_DFFE_PP_  (.D(net645),
    .DE(net667),
    .Q(\cpuregs[8][28] ),
    .CLK(clknet_leaf_13_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][29]$_DFFE_PP_  (.D(net641),
    .DE(net667),
    .Q(\cpuregs[8][29] ),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net667),
    .Q(\cpuregs[8][2] ),
    .CLK(clknet_leaf_24_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][30]$_DFFE_PP_  (.D(net646),
    .DE(net667),
    .Q(\cpuregs[8][30] ),
    .CLK(clknet_leaf_78_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][31]$_DFFE_PP_  (.D(net639),
    .DE(net667),
    .Q(\cpuregs[8][31] ),
    .CLK(clknet_leaf_17_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net667),
    .Q(\cpuregs[8][3] ),
    .CLK(clknet_leaf_4_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(_0847_),
    .Q(\cpuregs[8][4] ),
    .CLK(clknet_leaf_20_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(_0847_),
    .Q(\cpuregs[8][5] ),
    .CLK(clknet_leaf_51_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(_0847_),
    .Q(\cpuregs[8][6] ),
    .CLK(clknet_leaf_52_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][7]$_DFFE_PP_  (.D(net691),
    .DE(_0847_),
    .Q(\cpuregs[8][7] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][8]$_DFFE_PP_  (.D(net688),
    .DE(_0847_),
    .Q(\cpuregs[8][8] ),
    .CLK(clknet_leaf_51_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[8][9]$_DFFE_PP_  (.D(net692),
    .DE(_0847_),
    .Q(\cpuregs[8][9] ),
    .CLK(clknet_leaf_49_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][0]$_DFFE_PP_  (.D(\cpuregs_wrdata[0] ),
    .DE(_0848_),
    .Q(\cpuregs[9][0] ),
    .CLK(clknet_leaf_16_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][10]$_DFFE_PP_  (.D(\cpuregs_wrdata[10] ),
    .DE(net669),
    .Q(\cpuregs[9][10] ),
    .CLK(clknet_leaf_38_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][11]$_DFFE_PP_  (.D(\cpuregs_wrdata[11] ),
    .DE(_0848_),
    .Q(\cpuregs[9][11] ),
    .CLK(clknet_leaf_89_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][12]$_DFFE_PP_  (.D(net685),
    .DE(net669),
    .Q(\cpuregs[9][12] ),
    .CLK(clknet_leaf_66_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][13]$_DFFE_PP_  (.D(\cpuregs_wrdata[13] ),
    .DE(_0848_),
    .Q(\cpuregs[9][13] ),
    .CLK(clknet_leaf_87_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][14]$_DFFE_PP_  (.D(\cpuregs_wrdata[14] ),
    .DE(_0848_),
    .Q(\cpuregs[9][14] ),
    .CLK(clknet_leaf_87_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][15]$_DFFE_PP_  (.D(\cpuregs_wrdata[15] ),
    .DE(net669),
    .Q(\cpuregs[9][15] ),
    .CLK(clknet_leaf_67_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][16]$_DFFE_PP_  (.D(\cpuregs_wrdata[16] ),
    .DE(_0848_),
    .Q(\cpuregs[9][16] ),
    .CLK(clknet_leaf_86_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][17]$_DFFE_PP_  (.D(net686),
    .DE(net669),
    .Q(\cpuregs[9][17] ),
    .CLK(clknet_leaf_19_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][18]$_DFFE_PP_  (.D(net651),
    .DE(_0848_),
    .Q(\cpuregs[9][18] ),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][19]$_DFFE_PP_  (.D(net652),
    .DE(net669),
    .Q(\cpuregs[9][19] ),
    .CLK(clknet_leaf_23_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][1]$_DFFE_PP_  (.D(\cpuregs_wrdata[1] ),
    .DE(net669),
    .Q(\cpuregs[9][1] ),
    .CLK(clknet_leaf_18_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][20]$_DFFE_PP_  (.D(net647),
    .DE(net669),
    .Q(\cpuregs[9][20] ),
    .CLK(clknet_leaf_19_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][21]$_DFFE_PP_  (.D(net648),
    .DE(net669),
    .Q(\cpuregs[9][21] ),
    .CLK(clknet_leaf_71_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][22]$_DFFE_PP_  (.D(\cpuregs_wrdata[22] ),
    .DE(net669),
    .Q(\cpuregs[9][22] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][23]$_DFFE_PP_  (.D(net649),
    .DE(net669),
    .Q(\cpuregs[9][23] ),
    .CLK(clknet_leaf_20_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][24]$_DFFE_PP_  (.D(\cpuregs_wrdata[24] ),
    .DE(_0848_),
    .Q(\cpuregs[9][24] ),
    .CLK(clknet_leaf_87_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][25]$_DFFE_PP_  (.D(net640),
    .DE(_0848_),
    .Q(\cpuregs[9][25] ),
    .CLK(clknet_leaf_76_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][26]$_DFFE_PP_  (.D(net643),
    .DE(_0848_),
    .Q(\cpuregs[9][26] ),
    .CLK(clknet_leaf_14_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][27]$_DFFE_PP_  (.D(net644),
    .DE(_0848_),
    .Q(\cpuregs[9][27] ),
    .CLK(clknet_leaf_10_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][28]$_DFFE_PP_  (.D(net645),
    .DE(_0848_),
    .Q(\cpuregs[9][28] ),
    .CLK(clknet_leaf_14_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][29]$_DFFE_PP_  (.D(net641),
    .DE(_0848_),
    .Q(\cpuregs[9][29] ),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][2]$_DFFE_PP_  (.D(\cpuregs_wrdata[2] ),
    .DE(net669),
    .Q(\cpuregs[9][2] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][30]$_DFFE_PP_  (.D(net646),
    .DE(_0848_),
    .Q(\cpuregs[9][30] ),
    .CLK(clknet_leaf_80_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][31]$_DFFE_PP_  (.D(net639),
    .DE(net669),
    .Q(\cpuregs[9][31] ),
    .CLK(clknet_leaf_17_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][3]$_DFFE_PP_  (.D(\cpuregs_wrdata[3] ),
    .DE(net669),
    .Q(\cpuregs[9][3] ),
    .CLK(clknet_leaf_25_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][4]$_DFFE_PP_  (.D(\cpuregs_wrdata[4] ),
    .DE(net669),
    .Q(\cpuregs[9][4] ),
    .CLK(clknet_leaf_70_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][5]$_DFFE_PP_  (.D(\cpuregs_wrdata[5] ),
    .DE(net669),
    .Q(\cpuregs[9][5] ),
    .CLK(clknet_leaf_51_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][6]$_DFFE_PP_  (.D(\cpuregs_wrdata[6] ),
    .DE(net669),
    .Q(\cpuregs[9][6] ),
    .CLK(clknet_leaf_52_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][7]$_DFFE_PP_  (.D(net691),
    .DE(net669),
    .Q(\cpuregs[9][7] ),
    .CLK(clknet_leaf_50_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][8]$_DFFE_PP_  (.D(net688),
    .DE(net669),
    .Q(\cpuregs[9][8] ),
    .CLK(clknet_leaf_50_clk));
 sky130_fd_sc_hd__edfxtp_1 \cpuregs[9][9]$_DFFE_PP_  (.D(net692),
    .DE(net669),
    .Q(\cpuregs[9][9] ),
    .CLK(clknet_leaf_50_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[0]$_DFFE_PP_  (.D(_4681_),
    .DE(net712),
    .Q(\decoded_imm[0] ),
    .CLK(clknet_leaf_143_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[10]$_SDFFCE_PN0P_  (.D(_0544_),
    .DE(net712),
    .Q(\decoded_imm[10] ),
    .CLK(clknet_leaf_144_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[11]$_SDFFCE_PN0P_  (.D(_0543_),
    .DE(net712),
    .Q(\decoded_imm[11] ),
    .CLK(clknet_leaf_143_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[12]$_SDFFCE_PN0P_  (.D(_0542_),
    .DE(net712),
    .Q(\decoded_imm[12] ),
    .CLK(clknet_leaf_143_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[13]$_SDFFCE_PN0P_  (.D(_0541_),
    .DE(net712),
    .Q(\decoded_imm[13] ),
    .CLK(clknet_leaf_145_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[14]$_SDFFCE_PN0P_  (.D(_0540_),
    .DE(net712),
    .Q(\decoded_imm[14] ),
    .CLK(clknet_leaf_143_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[15]$_SDFFCE_PN0P_  (.D(_0539_),
    .DE(net712),
    .Q(\decoded_imm[15] ),
    .CLK(clknet_leaf_149_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[16]$_SDFFCE_PN0P_  (.D(_0538_),
    .DE(net712),
    .Q(\decoded_imm[16] ),
    .CLK(clknet_leaf_149_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[17]$_SDFFCE_PN0P_  (.D(_0537_),
    .DE(net712),
    .Q(\decoded_imm[17] ),
    .CLK(clknet_leaf_144_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[18]$_SDFFCE_PN0P_  (.D(_0536_),
    .DE(net712),
    .Q(\decoded_imm[18] ),
    .CLK(clknet_leaf_140_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[19]$_SDFFCE_PN0P_  (.D(_0535_),
    .DE(net712),
    .Q(\decoded_imm[19] ),
    .CLK(clknet_leaf_144_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[1]$_SDFFCE_PN0P_  (.D(_0553_),
    .DE(net712),
    .Q(\decoded_imm[1] ),
    .CLK(clknet_leaf_144_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[20]$_SDFFCE_PN0P_  (.D(_0534_),
    .DE(net712),
    .Q(\decoded_imm[20] ),
    .CLK(clknet_leaf_145_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[21]$_SDFFCE_PN0P_  (.D(_0533_),
    .DE(net712),
    .Q(\decoded_imm[21] ),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[22]$_SDFFCE_PN0P_  (.D(_0532_),
    .DE(net712),
    .Q(\decoded_imm[22] ),
    .CLK(clknet_leaf_148_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[23]$_SDFFCE_PN0P_  (.D(_0531_),
    .DE(net712),
    .Q(\decoded_imm[23] ),
    .CLK(clknet_leaf_148_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[24]$_SDFFCE_PN0P_  (.D(_0530_),
    .DE(net712),
    .Q(\decoded_imm[24] ),
    .CLK(clknet_leaf_145_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[25]$_SDFFCE_PN0P_  (.D(_0529_),
    .DE(net712),
    .Q(\decoded_imm[25] ),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[26]$_SDFFCE_PN0P_  (.D(_0528_),
    .DE(net712),
    .Q(\decoded_imm[26] ),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[27]$_SDFFCE_PN0P_  (.D(_0527_),
    .DE(net712),
    .Q(\decoded_imm[27] ),
    .CLK(clknet_leaf_145_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[28]$_SDFFCE_PN0P_  (.D(_0526_),
    .DE(net712),
    .Q(\decoded_imm[28] ),
    .CLK(clknet_leaf_148_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[29]$_SDFFCE_PN0P_  (.D(_0525_),
    .DE(net712),
    .Q(\decoded_imm[29] ),
    .CLK(clknet_leaf_145_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[2]$_SDFFCE_PN0P_  (.D(_0552_),
    .DE(net712),
    .Q(\decoded_imm[2] ),
    .CLK(clknet_leaf_148_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[30]$_SDFFCE_PN0P_  (.D(_0524_),
    .DE(net712),
    .Q(\decoded_imm[30] ),
    .CLK(clknet_leaf_145_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[31]$_SDFFCE_PN0P_  (.D(_0786_),
    .DE(net712),
    .Q(\decoded_imm[31] ),
    .CLK(clknet_leaf_143_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[3]$_SDFFCE_PN0P_  (.D(_0551_),
    .DE(net712),
    .Q(\decoded_imm[3] ),
    .CLK(clknet_leaf_149_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[4]$_SDFFCE_PN0P_  (.D(_0550_),
    .DE(net712),
    .Q(\decoded_imm[4] ),
    .CLK(clknet_leaf_148_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[5]$_SDFFCE_PN0P_  (.D(_0549_),
    .DE(net712),
    .Q(\decoded_imm[5] ),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[6]$_SDFFCE_PN0P_  (.D(_0548_),
    .DE(net712),
    .Q(\decoded_imm[6] ),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[7]$_SDFFCE_PN0P_  (.D(_0547_),
    .DE(net712),
    .Q(\decoded_imm[7] ),
    .CLK(clknet_leaf_145_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[8]$_SDFFCE_PN0P_  (.D(_0546_),
    .DE(net712),
    .Q(\decoded_imm[8] ),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm[9]$_SDFFCE_PN0P_  (.D(_0545_),
    .DE(net712),
    .Q(\decoded_imm[9] ),
    .CLK(clknet_leaf_146_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm_j[10]$_DFFE_PP_  (.D(\mem_rdata_latched[30] ),
    .DE(net653),
    .Q(\decoded_imm_j[10] ),
    .CLK(clknet_leaf_144_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm_j[12]$_DFFE_PP_  (.D(\mem_rdata_latched[12] ),
    .DE(net653),
    .Q(\decoded_imm_j[12] ),
    .CLK(clknet_leaf_144_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm_j[13]$_DFFE_PP_  (.D(\mem_rdata_latched[13] ),
    .DE(net653),
    .Q(\decoded_imm_j[13] ),
    .CLK(clknet_leaf_144_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm_j[14]$_DFFE_PP_  (.D(\mem_rdata_latched[14] ),
    .DE(net653),
    .Q(\decoded_imm_j[14] ),
    .CLK(clknet_leaf_140_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm_j[19]$_DFFE_PP_  (.D(\mem_rdata_latched[19] ),
    .DE(net653),
    .Q(\decoded_imm_j[19] ),
    .CLK(clknet_leaf_149_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm_j[20]$_DFFE_PP_  (.D(\mem_rdata_latched[31] ),
    .DE(net653),
    .Q(\decoded_imm_j[20] ),
    .CLK(clknet_leaf_152_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm_j[4]$_DFFE_PP_  (.D(\mem_rdata_latched[24] ),
    .DE(net653),
    .Q(\decoded_imm_j[4] ),
    .CLK(clknet_leaf_150_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm_j[5]$_DFFE_PP_  (.D(\mem_rdata_latched[25] ),
    .DE(net653),
    .Q(\decoded_imm_j[5] ),
    .CLK(clknet_leaf_148_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm_j[6]$_DFFE_PP_  (.D(\mem_rdata_latched[26] ),
    .DE(net653),
    .Q(\decoded_imm_j[6] ),
    .CLK(clknet_leaf_148_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm_j[7]$_DFFE_PP_  (.D(\mem_rdata_latched[27] ),
    .DE(net653),
    .Q(\decoded_imm_j[7] ),
    .CLK(clknet_leaf_144_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm_j[8]$_DFFE_PP_  (.D(\mem_rdata_latched[28] ),
    .DE(net653),
    .Q(\decoded_imm_j[8] ),
    .CLK(clknet_leaf_148_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_imm_j[9]$_DFFE_PP_  (.D(\mem_rdata_latched[29] ),
    .DE(net653),
    .Q(\decoded_imm_j[9] ),
    .CLK(clknet_leaf_144_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rd[0]$_DFFE_PP_  (.D(\mem_rdata_latched[7] ),
    .DE(net653),
    .Q(\decoded_rd[0] ),
    .CLK(clknet_leaf_150_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rd[1]$_DFFE_PP_  (.D(\mem_rdata_latched[8] ),
    .DE(net653),
    .Q(\decoded_rd[1] ),
    .CLK(clknet_leaf_149_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rd[2]$_DFFE_PP_  (.D(\mem_rdata_latched[9] ),
    .DE(net653),
    .Q(\decoded_rd[2] ),
    .CLK(clknet_leaf_151_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rd[3]$_DFFE_PP_  (.D(\mem_rdata_latched[10] ),
    .DE(net653),
    .Q(\decoded_rd[3] ),
    .CLK(clknet_leaf_150_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rd[4]$_DFFE_PP_  (.D(\mem_rdata_latched[11] ),
    .DE(net653),
    .Q(\decoded_rd[4] ),
    .CLK(clknet_leaf_150_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rs1[0]$_DFFE_PP_  (.D(\mem_rdata_latched[15] ),
    .DE(net653),
    .Q(\decoded_imm_j[15] ),
    .CLK(clknet_leaf_151_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rs1[1]$_DFFE_PP_  (.D(\mem_rdata_latched[16] ),
    .DE(net653),
    .Q(\decoded_imm_j[16] ),
    .CLK(clknet_leaf_151_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rs1[2]$_DFFE_PP_  (.D(\mem_rdata_latched[17] ),
    .DE(net653),
    .Q(\decoded_imm_j[17] ),
    .CLK(clknet_leaf_149_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rs1[3]$_DFFE_PP_  (.D(\mem_rdata_latched[18] ),
    .DE(net653),
    .Q(\decoded_imm_j[18] ),
    .CLK(clknet_leaf_152_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rs2[0]$_DFFE_PP_  (.D(\mem_rdata_latched[20] ),
    .DE(net653),
    .Q(\decoded_imm_j[11] ),
    .CLK(clknet_leaf_149_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rs2[1]$_DFFE_PP_  (.D(\mem_rdata_latched[21] ),
    .DE(net653),
    .Q(\decoded_imm_j[1] ),
    .CLK(clknet_leaf_148_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rs2[2]$_DFFE_PP_  (.D(\mem_rdata_latched[22] ),
    .DE(net653),
    .Q(\decoded_imm_j[2] ),
    .CLK(clknet_leaf_147_clk));
 sky130_fd_sc_hd__edfxtp_1 \decoded_rs2[3]$_DFFE_PP_  (.D(\mem_rdata_latched[23] ),
    .DE(net653),
    .Q(\decoded_imm_j[3] ),
    .CLK(clknet_leaf_150_clk));
 sky130_fd_sc_hd__dfxtp_1 \decoder_pseudo_trigger$_SDFF_PN0_  (.D(_0769_),
    .Q(decoder_pseudo_trigger),
    .CLK(clknet_leaf_141_clk));
 sky130_fd_sc_hd__dfxtp_1 \decoder_trigger$_DFF_P_  (.D(_0000_),
    .Q(decoder_trigger),
    .CLK(clknet_leaf_142_clk));
 sky130_fd_sc_hd__dlygate4sd3_1 hold838 (.A(mem_rdata[12]),
    .X(net829));
 sky130_fd_sc_hd__dlygate4sd3_1 hold839 (.A(mem_rdata[13]),
    .X(net830));
 sky130_fd_sc_hd__dlygate4sd3_1 hold840 (.A(mem_rdata[30]),
    .X(net831));
 sky130_fd_sc_hd__dlygate4sd3_1 hold841 (.A(mem_rdata[1]),
    .X(net832));
 sky130_fd_sc_hd__dlygate4sd3_1 hold842 (.A(mem_ready),
    .X(net833));
 sky130_fd_sc_hd__dlygate4sd3_1 hold843 (.A(_0507_),
    .X(net834));
 sky130_fd_sc_hd__dlygate4sd3_1 hold844 (.A(mem_rdata[2]),
    .X(net835));
 sky130_fd_sc_hd__dlygate4sd3_1 hold845 (.A(mem_rdata[3]),
    .X(net836));
 sky130_fd_sc_hd__dlygate4sd3_1 hold846 (.A(mem_rdata[8]),
    .X(net837));
 sky130_fd_sc_hd__dlygate4sd3_1 hold847 (.A(mem_rdata[10]),
    .X(net838));
 sky130_fd_sc_hd__dlygate4sd3_1 hold848 (.A(mem_rdata[5]),
    .X(net839));
 sky130_fd_sc_hd__dlygate4sd3_1 hold849 (.A(mem_rdata[6]),
    .X(net840));
 sky130_fd_sc_hd__dlygate4sd3_1 hold850 (.A(mem_rdata[15]),
    .X(net841));
 sky130_fd_sc_hd__dlygate4sd3_1 hold851 (.A(mem_rdata[14]),
    .X(net842));
 sky130_fd_sc_hd__dlygate4sd3_1 hold852 (.A(mem_rdata[25]),
    .X(net843));
 sky130_fd_sc_hd__dlygate4sd3_1 hold853 (.A(mem_rdata[7]),
    .X(net844));
 sky130_fd_sc_hd__dlygate4sd3_1 hold854 (.A(mem_rdata[17]),
    .X(net845));
 sky130_fd_sc_hd__dlygate4sd3_1 hold855 (.A(resetn),
    .X(net846));
 sky130_fd_sc_hd__dlygate4sd3_1 hold856 (.A(mem_rdata[4]),
    .X(net847));
 sky130_fd_sc_hd__dlygate4sd3_1 hold857 (.A(mem_rdata[21]),
    .X(net848));
 sky130_fd_sc_hd__dlygate4sd3_1 hold858 (.A(mem_rdata[19]),
    .X(net849));
 sky130_fd_sc_hd__dlygate4sd3_1 hold859 (.A(mem_rdata[0]),
    .X(net850));
 sky130_fd_sc_hd__dlygate4sd3_1 hold860 (.A(mem_rdata[18]),
    .X(net851));
 sky130_fd_sc_hd__dlygate4sd3_1 hold861 (.A(mem_rdata[27]),
    .X(net852));
 sky130_fd_sc_hd__dlygate4sd3_1 hold862 (.A(mem_rdata[23]),
    .X(net853));
 sky130_fd_sc_hd__dlygate4sd3_1 hold863 (.A(mem_rdata[11]),
    .X(net854));
 sky130_fd_sc_hd__dlygate4sd3_1 hold864 (.A(mem_rdata[16]),
    .X(net855));
 sky130_fd_sc_hd__dlygate4sd3_1 hold865 (.A(mem_rdata[24]),
    .X(net856));
 sky130_fd_sc_hd__dlygate4sd3_1 hold866 (.A(mem_rdata[20]),
    .X(net857));
 sky130_fd_sc_hd__dlygate4sd3_1 hold867 (.A(mem_rdata[26]),
    .X(net858));
 sky130_fd_sc_hd__dlygate4sd3_1 hold868 (.A(mem_rdata[9]),
    .X(net859));
 sky130_fd_sc_hd__dlygate4sd3_1 hold869 (.A(mem_rdata[29]),
    .X(net860));
 sky130_fd_sc_hd__dlygate4sd3_1 hold870 (.A(mem_rdata[28]),
    .X(net861));
 sky130_fd_sc_hd__dlygate4sd3_1 hold871 (.A(mem_rdata[31]),
    .X(net862));
 sky130_fd_sc_hd__dlygate4sd3_1 hold872 (.A(mem_rdata[22]),
    .X(net863));
 sky130_fd_sc_hd__buf_1 input139 (.A(net850),
    .X(net138));
 sky130_fd_sc_hd__buf_1 input140 (.A(net838),
    .X(net139));
 sky130_fd_sc_hd__buf_1 input141 (.A(net854),
    .X(net140));
 sky130_fd_sc_hd__buf_1 input142 (.A(net829),
    .X(net141));
 sky130_fd_sc_hd__buf_1 input143 (.A(net830),
    .X(net142));
 sky130_fd_sc_hd__buf_1 input144 (.A(net842),
    .X(net143));
 sky130_fd_sc_hd__buf_1 input145 (.A(net841),
    .X(net144));
 sky130_fd_sc_hd__buf_1 input146 (.A(net855),
    .X(net145));
 sky130_fd_sc_hd__buf_1 input147 (.A(net845),
    .X(net146));
 sky130_fd_sc_hd__buf_1 input148 (.A(net851),
    .X(net147));
 sky130_fd_sc_hd__buf_1 input149 (.A(net849),
    .X(net148));
 sky130_fd_sc_hd__buf_1 input150 (.A(net832),
    .X(net149));
 sky130_fd_sc_hd__buf_1 input151 (.A(net857),
    .X(net150));
 sky130_fd_sc_hd__buf_1 input152 (.A(net848),
    .X(net151));
 sky130_fd_sc_hd__buf_1 input153 (.A(net863),
    .X(net152));
 sky130_fd_sc_hd__buf_1 input154 (.A(net853),
    .X(net153));
 sky130_fd_sc_hd__buf_1 input155 (.A(net856),
    .X(net154));
 sky130_fd_sc_hd__buf_1 input156 (.A(net843),
    .X(net155));
 sky130_fd_sc_hd__buf_1 input157 (.A(net858),
    .X(net156));
 sky130_fd_sc_hd__buf_1 input158 (.A(net852),
    .X(net157));
 sky130_fd_sc_hd__buf_1 input159 (.A(net861),
    .X(net158));
 sky130_fd_sc_hd__buf_1 input160 (.A(net860),
    .X(net159));
 sky130_fd_sc_hd__buf_1 input161 (.A(net835),
    .X(net160));
 sky130_fd_sc_hd__buf_1 input162 (.A(net831),
    .X(net161));
 sky130_fd_sc_hd__buf_1 input163 (.A(net862),
    .X(net162));
 sky130_fd_sc_hd__buf_1 input164 (.A(net836),
    .X(net163));
 sky130_fd_sc_hd__buf_1 input165 (.A(net847),
    .X(net164));
 sky130_fd_sc_hd__buf_1 input166 (.A(net839),
    .X(net165));
 sky130_fd_sc_hd__buf_1 input167 (.A(net840),
    .X(net166));
 sky130_fd_sc_hd__buf_1 input168 (.A(net844),
    .X(net167));
 sky130_fd_sc_hd__buf_1 input169 (.A(net837),
    .X(net168));
 sky130_fd_sc_hd__buf_1 input170 (.A(net859),
    .X(net169));
 sky130_fd_sc_hd__buf_1 input171 (.A(net833),
    .X(net170));
 sky130_fd_sc_hd__clkbuf_2 input172 (.A(net846),
    .X(net171));
 sky130_fd_sc_hd__dfxtp_1 \instr_add$_SDFFE_PN0P_  (.D(_0748_),
    .Q(instr_add),
    .CLK(clknet_leaf_137_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_addi$_SDFFE_PN0P_  (.D(_0755_),
    .Q(instr_addi),
    .CLK(clknet_leaf_137_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_and$_SDFFE_PN0P_  (.D(_0784_),
    .Q(instr_and),
    .CLK(clknet_leaf_132_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_andi$_SDFFE_PN0P_  (.D(_0750_),
    .Q(instr_andi),
    .CLK(clknet_leaf_132_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_auipc$_DFFE_PP_  (.D(_0791_),
    .DE(net653),
    .Q(instr_auipc),
    .CLK(clknet_leaf_139_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_beq$_SDFFE_PN0P_  (.D(_0774_),
    .Q(instr_beq),
    .CLK(clknet_leaf_137_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_bge$_SDFFE_PN0P_  (.D(_0758_),
    .Q(instr_bge),
    .CLK(clknet_leaf_141_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_bgeu$_SDFFE_PN0P_  (.D(_0756_),
    .Q(instr_bgeu),
    .CLK(clknet_leaf_136_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_blt$_SDFFE_PN0P_  (.D(_0759_),
    .Q(instr_blt),
    .CLK(clknet_leaf_136_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_bltu$_SDFFE_PN0P_  (.D(_0757_),
    .Q(instr_bltu),
    .CLK(clknet_leaf_137_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_bne$_SDFFE_PN0P_  (.D(_0760_),
    .Q(instr_bne),
    .CLK(clknet_leaf_141_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_fence$_SDFFE_PN0P_  (.D(_0777_),
    .Q(instr_fence),
    .CLK(clknet_leaf_138_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_jal$_DFFE_PP_  (.D(_0792_),
    .DE(_0815_),
    .Q(instr_jal),
    .CLK(clknet_leaf_139_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_jalr$_DFFE_PP_  (.D(_0816_),
    .DE(_0815_),
    .Q(instr_jalr),
    .CLK(clknet_leaf_138_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_lb$_DFFE_PP_  (.D(_0798_),
    .DE(net713),
    .Q(instr_lb),
    .CLK(clknet_leaf_138_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_lbu$_DFFE_PP_  (.D(_0801_),
    .DE(net713),
    .Q(instr_lbu),
    .CLK(clknet_leaf_132_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_lh$_DFFE_PP_  (.D(_0799_),
    .DE(net713),
    .Q(instr_lh),
    .CLK(clknet_leaf_141_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_lhu$_DFFE_PP_  (.D(_0802_),
    .DE(net713),
    .Q(instr_lhu),
    .CLK(clknet_leaf_132_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_lui$_DFFE_PP_  (.D(_0790_),
    .DE(net653),
    .Q(instr_lui),
    .CLK(clknet_leaf_139_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_lw$_DFFE_PP_  (.D(_0800_),
    .DE(net713),
    .Q(instr_lw),
    .CLK(clknet_leaf_141_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_or$_SDFFE_PN0P_  (.D(_0787_),
    .Q(instr_or),
    .CLK(clknet_leaf_132_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_ori$_SDFFE_PN0P_  (.D(_0751_),
    .Q(instr_ori),
    .CLK(clknet_leaf_132_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_rdcycle$_DFFE_PP_  (.D(_0809_),
    .DE(net712),
    .Q(instr_rdcycle),
    .CLK(clknet_leaf_153_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_rdcycleh$_DFFE_PP_  (.D(_0810_),
    .DE(net712),
    .Q(instr_rdcycleh),
    .CLK(clknet_leaf_153_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_rdinstr$_DFFE_PP_  (.D(_0811_),
    .DE(net712),
    .Q(instr_rdinstr),
    .CLK(clknet_leaf_153_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_rdinstrh$_DFFE_PP_  (.D(_0812_),
    .DE(net712),
    .Q(instr_rdinstrh),
    .CLK(clknet_leaf_153_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_sb$_DFFE_PP_  (.D(_0803_),
    .DE(net713),
    .Q(instr_sb),
    .CLK(clknet_leaf_141_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_sh$_DFFE_PP_  (.D(_0804_),
    .DE(net713),
    .Q(instr_sh),
    .CLK(clknet_leaf_141_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_sll$_SDFFE_PN0P_  (.D(_0746_),
    .Q(instr_sll),
    .CLK(clknet_leaf_141_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_slli$_DFFE_PP_  (.D(_0806_),
    .DE(net712),
    .Q(instr_slli),
    .CLK(clknet_leaf_138_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_slt$_SDFFE_PN0P_  (.D(_0745_),
    .Q(instr_slt),
    .CLK(clknet_leaf_137_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_slti$_SDFFE_PN0P_  (.D(_0754_),
    .Q(instr_slti),
    .CLK(clknet_leaf_136_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_sltiu$_SDFFE_PN0P_  (.D(_0753_),
    .Q(instr_sltiu),
    .CLK(clknet_leaf_137_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_sltu$_SDFFE_PN0P_  (.D(_0785_),
    .Q(instr_sltu),
    .CLK(clknet_leaf_137_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_sra$_SDFFE_PN0P_  (.D(_0788_),
    .Q(instr_sra),
    .CLK(clknet_leaf_138_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_srai$_DFFE_PP_  (.D(_0808_),
    .DE(net712),
    .Q(instr_srai),
    .CLK(clknet_leaf_138_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_srl$_SDFFE_PN0P_  (.D(_0789_),
    .Q(instr_srl),
    .CLK(clknet_leaf_138_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_srli$_DFFE_PP_  (.D(_0807_),
    .DE(net712),
    .Q(instr_srli),
    .CLK(clknet_leaf_138_clk));
 sky130_fd_sc_hd__dfxtp_2 \instr_sub$_SDFFE_PN0P_  (.D(_0747_),
    .Q(instr_sub),
    .CLK(clknet_leaf_138_clk));
 sky130_fd_sc_hd__edfxtp_1 \instr_sw$_DFFE_PP_  (.D(_0805_),
    .DE(net713),
    .Q(instr_sw),
    .CLK(clknet_leaf_141_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_xor$_SDFFE_PN0P_  (.D(_0778_),
    .Q(instr_xor),
    .CLK(clknet_leaf_136_clk));
 sky130_fd_sc_hd__dfxtp_1 \instr_xori$_SDFFE_PN0P_  (.D(_0752_),
    .Q(instr_xori),
    .CLK(clknet_leaf_136_clk));
 sky130_fd_sc_hd__edfxtp_1 \is_alu_reg_imm$_DFFE_PP_  (.D(_0795_),
    .DE(_0815_),
    .Q(is_alu_reg_imm),
    .CLK(clknet_leaf_153_clk));
 sky130_fd_sc_hd__edfxtp_1 \is_alu_reg_reg$_DFFE_PP_  (.D(_0796_),
    .DE(net653),
    .Q(is_alu_reg_reg),
    .CLK(clknet_leaf_139_clk));
 sky130_fd_sc_hd__dfxtp_1 \is_beq_bne_blt_bge_bltu_bgeu$_SDFFE_PN0P_  (.D(_0781_),
    .Q(is_beq_bne_blt_bge_bltu_bgeu),
    .CLK(clknet_leaf_138_clk));
 sky130_fd_sc_hd__dfxtp_1 \is_compare$_SDFF_PP0_  (.D(_0783_),
    .Q(is_compare),
    .CLK(clknet_leaf_131_clk));
 sky130_fd_sc_hd__edfxtp_1 \is_jalr_addi_slti_sltiu_xori_ori_andi$_DFFE_PP_  (.D(_0817_),
    .DE(net712),
    .Q(is_jalr_addi_slti_sltiu_xori_ori_andi),
    .CLK(clknet_leaf_139_clk));
 sky130_fd_sc_hd__edfxtp_1 \is_lb_lh_lw_lbu_lhu$_DFFE_PP_  (.D(_0793_),
    .DE(net653),
    .Q(is_lb_lh_lw_lbu_lhu),
    .CLK(clknet_leaf_139_clk));
 sky130_fd_sc_hd__dfxtp_1 \is_lui_auipc_jal$_DFF_P_  (.D(_0001_),
    .Q(is_lui_auipc_jal),
    .CLK(clknet_leaf_139_clk));
 sky130_fd_sc_hd__edfxtp_1 \is_sb_sh_sw$_DFFE_PP_  (.D(_0794_),
    .DE(_0815_),
    .Q(is_sb_sh_sw),
    .CLK(clknet_leaf_153_clk));
 sky130_fd_sc_hd__edfxtp_1 \is_sll_srl_sra$_DFFE_PP_  (.D(_0814_),
    .DE(net712),
    .Q(is_sll_srl_sra),
    .CLK(clknet_leaf_139_clk));
 sky130_fd_sc_hd__edfxtp_1 \is_slli_srli_srai$_DFFE_PP_  (.D(_0813_),
    .DE(net712),
    .Q(is_slli_srli_srai),
    .CLK(clknet_leaf_139_clk));
 sky130_fd_sc_hd__dfxtp_1 \is_slti_blt_slt$_DFF_P_  (.D(_0002_),
    .Q(is_slti_blt_slt),
    .CLK(clknet_leaf_133_clk));
 sky130_fd_sc_hd__dfxtp_1 \is_sltiu_bltu_sltu$_DFF_P_  (.D(_0003_),
    .Q(is_sltiu_bltu_sltu),
    .CLK(clknet_leaf_131_clk));
 sky130_fd_sc_hd__dfxtp_1 \latched_branch$_SDFFE_PN0P_  (.D(_0766_),
    .Q(latched_branch),
    .CLK(clknet_leaf_111_clk));
 sky130_fd_sc_hd__dfxtp_1 \latched_is_lb$_SDFFE_PN0P_  (.D(_0763_),
    .Q(latched_is_lb),
    .CLK(clknet_leaf_131_clk));
 sky130_fd_sc_hd__dfxtp_1 \latched_is_lh$_SDFFE_PN0P_  (.D(_0764_),
    .Q(latched_is_lh),
    .CLK(clknet_leaf_131_clk));
 sky130_fd_sc_hd__edfxtp_1 \latched_rd[0]$_SDFFCE_PN0P_  (.D(_0744_),
    .DE(_0510_),
    .Q(\latched_rd[0] ),
    .CLK(clknet_leaf_150_clk));
 sky130_fd_sc_hd__edfxtp_1 \latched_rd[1]$_SDFFCE_PN0P_  (.D(_0743_),
    .DE(_0510_),
    .Q(\latched_rd[1] ),
    .CLK(clknet_leaf_150_clk));
 sky130_fd_sc_hd__edfxtp_1 \latched_rd[2]$_SDFFCE_PN0P_  (.D(_0742_),
    .DE(_0510_),
    .Q(\latched_rd[2] ),
    .CLK(clknet_leaf_150_clk));
 sky130_fd_sc_hd__edfxtp_1 \latched_rd[3]$_SDFFCE_PN0P_  (.D(_0741_),
    .DE(_0510_),
    .Q(\latched_rd[3] ),
    .CLK(clknet_leaf_150_clk));
 sky130_fd_sc_hd__edfxtp_1 \latched_rd[4]$_SDFFCE_PN0P_  (.D(_0762_),
    .DE(_0510_),
    .Q(\latched_rd[4] ),
    .CLK(clknet_leaf_150_clk));
 sky130_fd_sc_hd__dfxtp_2 \latched_stalu$_SDFFE_PN0P_  (.D(_0767_),
    .Q(latched_stalu),
    .CLK(clknet_leaf_111_clk));
 sky130_fd_sc_hd__dfxtp_1 \latched_store$_SDFFE_PN0P_  (.D(_0768_),
    .Q(latched_store),
    .CLK(clknet_leaf_111_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[10]$_DFFE_PP_  (.D(net203),
    .DE(net687),
    .Q(net172),
    .CLK(clknet_leaf_102_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[11]$_DFFE_PP_  (.D(net204),
    .DE(net687),
    .Q(net173),
    .CLK(clknet_leaf_102_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[12]$_DFFE_PP_  (.D(net205),
    .DE(net687),
    .Q(net174),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[13]$_DFFE_PP_  (.D(net206),
    .DE(net687),
    .Q(net175),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[14]$_DFFE_PP_  (.D(net207),
    .DE(net687),
    .Q(net176),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[15]$_DFFE_PP_  (.D(net208),
    .DE(net687),
    .Q(net177),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[16]$_DFFE_PP_  (.D(net209),
    .DE(net687),
    .Q(net178),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[17]$_DFFE_PP_  (.D(net210),
    .DE(net687),
    .Q(net179),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[18]$_DFFE_PP_  (.D(net211),
    .DE(net687),
    .Q(net180),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[19]$_DFFE_PP_  (.D(net212),
    .DE(net687),
    .Q(net181),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[20]$_DFFE_PP_  (.D(net213),
    .DE(net687),
    .Q(net182),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[21]$_DFFE_PP_  (.D(net214),
    .DE(net687),
    .Q(net183),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[22]$_DFFE_PP_  (.D(net215),
    .DE(net687),
    .Q(net184),
    .CLK(clknet_leaf_118_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[23]$_DFFE_PP_  (.D(net216),
    .DE(net687),
    .Q(net185),
    .CLK(clknet_leaf_119_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[24]$_DFFE_PP_  (.D(net217),
    .DE(net687),
    .Q(net186),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[25]$_DFFE_PP_  (.D(net218),
    .DE(net687),
    .Q(net187),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[26]$_DFFE_PP_  (.D(net219),
    .DE(net687),
    .Q(net188),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[27]$_DFFE_PP_  (.D(net220),
    .DE(net687),
    .Q(net189),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[28]$_DFFE_PP_  (.D(net221),
    .DE(net687),
    .Q(net190),
    .CLK(clknet_leaf_118_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[29]$_DFFE_PP_  (.D(net222),
    .DE(net687),
    .Q(net191),
    .CLK(clknet_leaf_118_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[2]$_DFFE_PP_  (.D(net223),
    .DE(net687),
    .Q(net192),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[30]$_DFFE_PP_  (.D(net224),
    .DE(net687),
    .Q(net193),
    .CLK(clknet_leaf_118_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[31]$_DFFE_PP_  (.D(net225),
    .DE(net687),
    .Q(net194),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[3]$_DFFE_PP_  (.D(net226),
    .DE(net687),
    .Q(net195),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[4]$_DFFE_PP_  (.D(net227),
    .DE(net687),
    .Q(net196),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[5]$_DFFE_PP_  (.D(net228),
    .DE(net687),
    .Q(net197),
    .CLK(clknet_leaf_117_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[6]$_DFFE_PP_  (.D(net229),
    .DE(net687),
    .Q(net198),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[7]$_DFFE_PP_  (.D(net230),
    .DE(net687),
    .Q(net199),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[8]$_DFFE_PP_  (.D(net231),
    .DE(net687),
    .Q(net200),
    .CLK(clknet_leaf_102_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_addr[9]$_DFFE_PP_  (.D(net232),
    .DE(net687),
    .Q(net201),
    .CLK(clknet_leaf_102_clk));
 sky130_fd_sc_hd__dfxtp_1 \mem_do_prefetch$_SDFFE_PP0P_  (.D(_0773_),
    .Q(mem_do_prefetch),
    .CLK(clknet_leaf_136_clk));
 sky130_fd_sc_hd__dfxtp_1 \mem_do_rdata$_SDFFE_PP1P_  (.D(_0771_),
    .Q(mem_do_rdata),
    .CLK(clknet_leaf_135_clk));
 sky130_fd_sc_hd__dfxtp_1 \mem_do_rinst$_SDFFE_PP1P_  (.D(_0772_),
    .Q(mem_do_rinst),
    .CLK(clknet_leaf_142_clk));
 sky130_fd_sc_hd__dfxtp_1 \mem_do_wdata$_SDFFE_PP1P_  (.D(_0770_),
    .Q(mem_do_wdata),
    .CLK(clknet_leaf_132_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_instr$_SDFFCE_PP0P_  (.D(_0749_),
    .DE(_0509_),
    .Q(net202),
    .CLK(clknet_leaf_135_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[0]$_DFFE_PP_  (.D(net138),
    .DE(_3356_),
    .Q(\mem_rdata_q[0] ),
    .CLK(clknet_leaf_137_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[10]$_DFFE_PP_  (.D(net139),
    .DE(net706),
    .Q(\mem_rdata_q[10] ),
    .CLK(clknet_leaf_150_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[11]$_DFFE_PP_  (.D(net140),
    .DE(net706),
    .Q(\mem_rdata_q[11] ),
    .CLK(clknet_leaf_150_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[12]$_DFFE_PP_  (.D(net141),
    .DE(net706),
    .Q(\mem_rdata_q[12] ),
    .CLK(clknet_leaf_139_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[13]$_DFFE_PP_  (.D(net142),
    .DE(net706),
    .Q(\mem_rdata_q[13] ),
    .CLK(clknet_leaf_140_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[14]$_DFFE_PP_  (.D(net143),
    .DE(_3356_),
    .Q(\mem_rdata_q[14] ),
    .CLK(clknet_leaf_140_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[15]$_DFFE_PP_  (.D(net144),
    .DE(net706),
    .Q(\mem_rdata_q[15] ),
    .CLK(clknet_leaf_151_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[16]$_DFFE_PP_  (.D(net145),
    .DE(net706),
    .Q(\mem_rdata_q[16] ),
    .CLK(clknet_leaf_152_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[17]$_DFFE_PP_  (.D(net146),
    .DE(net706),
    .Q(\mem_rdata_q[17] ),
    .CLK(clknet_leaf_152_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[18]$_DFFE_PP_  (.D(net147),
    .DE(net706),
    .Q(\mem_rdata_q[18] ),
    .CLK(clknet_leaf_152_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[19]$_DFFE_PP_  (.D(net148),
    .DE(net706),
    .Q(\mem_rdata_q[19] ),
    .CLK(clknet_leaf_152_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[1]$_DFFE_PP_  (.D(net828),
    .DE(_3356_),
    .Q(\mem_rdata_q[1] ),
    .CLK(clknet_leaf_137_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[20]$_DFFE_PP_  (.D(net150),
    .DE(net706),
    .Q(\mem_rdata_q[20] ),
    .CLK(clknet_leaf_151_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[21]$_DFFE_PP_  (.D(net151),
    .DE(net706),
    .Q(\mem_rdata_q[21] ),
    .CLK(clknet_leaf_152_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[22]$_DFFE_PP_  (.D(net152),
    .DE(net706),
    .Q(\mem_rdata_q[22] ),
    .CLK(clknet_leaf_152_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[23]$_DFFE_PP_  (.D(net153),
    .DE(net706),
    .Q(\mem_rdata_q[23] ),
    .CLK(clknet_leaf_152_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[24]$_DFFE_PP_  (.D(net154),
    .DE(net706),
    .Q(\mem_rdata_q[24] ),
    .CLK(clknet_leaf_152_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[25]$_DFFE_PP_  (.D(net827),
    .DE(net706),
    .Q(\mem_rdata_q[25] ),
    .CLK(clknet_leaf_149_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[26]$_DFFE_PP_  (.D(net156),
    .DE(net706),
    .Q(\mem_rdata_q[26] ),
    .CLK(clknet_leaf_149_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[27]$_DFFE_PP_  (.D(net157),
    .DE(net706),
    .Q(\mem_rdata_q[27] ),
    .CLK(clknet_leaf_153_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[28]$_DFFE_PP_  (.D(net158),
    .DE(net706),
    .Q(\mem_rdata_q[28] ),
    .CLK(clknet_leaf_148_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[29]$_DFFE_PP_  (.D(net159),
    .DE(net706),
    .Q(\mem_rdata_q[29] ),
    .CLK(clknet_leaf_148_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[2]$_DFFE_PP_  (.D(net160),
    .DE(_3356_),
    .Q(\mem_rdata_q[2] ),
    .CLK(clknet_leaf_137_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[30]$_DFFE_PP_  (.D(net826),
    .DE(net706),
    .Q(\mem_rdata_q[30] ),
    .CLK(clknet_leaf_153_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[31]$_DFFE_PP_  (.D(net162),
    .DE(net706),
    .Q(\mem_rdata_q[31] ),
    .CLK(clknet_leaf_152_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[3]$_DFFE_PP_  (.D(net163),
    .DE(_3356_),
    .Q(\mem_rdata_q[3] ),
    .CLK(clknet_leaf_137_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[4]$_DFFE_PP_  (.D(net164),
    .DE(net706),
    .Q(\mem_rdata_q[4] ),
    .CLK(clknet_leaf_139_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[5]$_DFFE_PP_  (.D(net165),
    .DE(_3356_),
    .Q(\mem_rdata_q[5] ),
    .CLK(clknet_leaf_154_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[6]$_DFFE_PP_  (.D(net166),
    .DE(_3356_),
    .Q(\mem_rdata_q[6] ),
    .CLK(clknet_leaf_154_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[7]$_DFFE_PP_  (.D(net167),
    .DE(net706),
    .Q(\mem_rdata_q[7] ),
    .CLK(clknet_leaf_144_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[8]$_DFFE_PP_  (.D(net168),
    .DE(net706),
    .Q(\mem_rdata_q[8] ),
    .CLK(clknet_leaf_149_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_rdata_q[9]$_DFFE_PP_  (.D(net169),
    .DE(net706),
    .Q(\mem_rdata_q[9] ),
    .CLK(clknet_leaf_151_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_state[0]$_SDFFCE_PP0P_  (.D(_0740_),
    .DE(_0504_),
    .Q(\mem_state[0] ),
    .CLK(clknet_leaf_136_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_state[1]$_SDFFCE_PP0P_  (.D(_0779_),
    .DE(_0504_),
    .Q(\mem_state[1] ),
    .CLK(clknet_leaf_136_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_valid$_SDFFCE_PP0P_  (.D(_0780_),
    .DE(net834),
    .Q(net271),
    .CLK(clknet_leaf_135_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[0]$_DFFE_PP_  (.D(net234),
    .DE(net690),
    .Q(net272),
    .CLK(clknet_leaf_98_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[10]$_DFFE_PP_  (.D(net235),
    .DE(net690),
    .Q(net273),
    .CLK(clknet_leaf_100_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[11]$_DFFE_PP_  (.D(net236),
    .DE(net690),
    .Q(net274),
    .CLK(clknet_leaf_97_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[12]$_DFFE_PP_  (.D(net237),
    .DE(net690),
    .Q(net275),
    .CLK(clknet_leaf_98_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[13]$_DFFE_PP_  (.D(net238),
    .DE(net690),
    .Q(net276),
    .CLK(clknet_leaf_98_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[14]$_DFFE_PP_  (.D(net239),
    .DE(net690),
    .Q(net277),
    .CLK(clknet_leaf_99_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[15]$_DFFE_PP_  (.D(net240),
    .DE(net690),
    .Q(net278),
    .CLK(clknet_leaf_99_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[16]$_DFFE_PP_  (.D(net241),
    .DE(net690),
    .Q(net279),
    .CLK(clknet_leaf_100_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[17]$_DFFE_PP_  (.D(net242),
    .DE(net690),
    .Q(net280),
    .CLK(clknet_leaf_100_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[18]$_DFFE_PP_  (.D(net243),
    .DE(net690),
    .Q(net281),
    .CLK(clknet_leaf_101_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[19]$_DFFE_PP_  (.D(net244),
    .DE(net690),
    .Q(net282),
    .CLK(clknet_leaf_101_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[1]$_DFFE_PP_  (.D(net245),
    .DE(net690),
    .Q(net283),
    .CLK(clknet_leaf_98_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[20]$_DFFE_PP_  (.D(net246),
    .DE(net690),
    .Q(net284),
    .CLK(clknet_leaf_101_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[21]$_DFFE_PP_  (.D(net247),
    .DE(net690),
    .Q(net285),
    .CLK(clknet_leaf_101_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[22]$_DFFE_PP_  (.D(net248),
    .DE(net690),
    .Q(net286),
    .CLK(clknet_leaf_100_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[23]$_DFFE_PP_  (.D(net249),
    .DE(net690),
    .Q(net287),
    .CLK(clknet_leaf_100_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[24]$_DFFE_PP_  (.D(net250),
    .DE(net690),
    .Q(net288),
    .CLK(clknet_leaf_98_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[25]$_DFFE_PP_  (.D(net251),
    .DE(net690),
    .Q(net289),
    .CLK(clknet_leaf_97_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[26]$_DFFE_PP_  (.D(net252),
    .DE(net690),
    .Q(net290),
    .CLK(clknet_leaf_101_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[27]$_DFFE_PP_  (.D(net253),
    .DE(net690),
    .Q(net291),
    .CLK(clknet_leaf_98_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[28]$_DFFE_PP_  (.D(net254),
    .DE(net690),
    .Q(net292),
    .CLK(clknet_leaf_97_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[29]$_DFFE_PP_  (.D(net255),
    .DE(net690),
    .Q(net293),
    .CLK(clknet_leaf_97_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[2]$_DFFE_PP_  (.D(net256),
    .DE(net690),
    .Q(net294),
    .CLK(clknet_leaf_100_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[30]$_DFFE_PP_  (.D(net257),
    .DE(net690),
    .Q(net295),
    .CLK(clknet_leaf_99_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[31]$_DFFE_PP_  (.D(net258),
    .DE(net690),
    .Q(net296),
    .CLK(clknet_leaf_102_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[3]$_DFFE_PP_  (.D(net259),
    .DE(net690),
    .Q(net297),
    .CLK(clknet_leaf_98_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[4]$_DFFE_PP_  (.D(net260),
    .DE(net690),
    .Q(net298),
    .CLK(clknet_leaf_99_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[5]$_DFFE_PP_  (.D(net261),
    .DE(net690),
    .Q(net299),
    .CLK(clknet_leaf_98_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[6]$_DFFE_PP_  (.D(net262),
    .DE(net690),
    .Q(net300),
    .CLK(clknet_leaf_100_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[7]$_DFFE_PP_  (.D(net263),
    .DE(net690),
    .Q(net301),
    .CLK(clknet_leaf_100_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[8]$_DFFE_PP_  (.D(net264),
    .DE(net690),
    .Q(net302),
    .CLK(clknet_leaf_98_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wdata[9]$_DFFE_PP_  (.D(net265),
    .DE(net690),
    .Q(net303),
    .CLK(clknet_leaf_98_clk));
 sky130_fd_sc_hd__dfxtp_1 \mem_wordsize[0]$_DFF_P_  (.D(_0493_),
    .Q(\mem_wordsize[0] ),
    .CLK(clknet_leaf_142_clk));
 sky130_fd_sc_hd__dfxtp_1 \mem_wordsize[1]$_DFF_P_  (.D(_0494_),
    .Q(\mem_wordsize[1] ),
    .CLK(clknet_leaf_132_clk));
 sky130_fd_sc_hd__dfxtp_1 \mem_wordsize[2]$_DFF_P_  (.D(_0495_),
    .Q(\mem_wordsize[2] ),
    .CLK(clknet_leaf_132_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wstrb[0]$_DFFE_PN_  (.D(_4682_),
    .DE(_0513_),
    .Q(net304),
    .CLK(clknet_leaf_135_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wstrb[1]$_DFFE_PN_  (.D(_4683_),
    .DE(_0513_),
    .Q(net305),
    .CLK(clknet_leaf_135_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wstrb[2]$_DFFE_PN_  (.D(_4684_),
    .DE(_0513_),
    .Q(net306),
    .CLK(clknet_leaf_134_clk));
 sky130_fd_sc_hd__edfxtp_1 \mem_wstrb[3]$_DFFE_PN_  (.D(_4685_),
    .DE(_0513_),
    .Q(net307),
    .CLK(clknet_leaf_134_clk));
 sky130_fd_sc_hd__buf_1 output173 (.A(net172),
    .X(mem_addr[10]));
 sky130_fd_sc_hd__buf_1 output174 (.A(net173),
    .X(mem_addr[11]));
 sky130_fd_sc_hd__buf_1 output175 (.A(net174),
    .X(mem_addr[12]));
 sky130_fd_sc_hd__buf_1 output176 (.A(net175),
    .X(mem_addr[13]));
 sky130_fd_sc_hd__buf_1 output177 (.A(net176),
    .X(mem_addr[14]));
 sky130_fd_sc_hd__buf_1 output178 (.A(net177),
    .X(mem_addr[15]));
 sky130_fd_sc_hd__buf_1 output179 (.A(net178),
    .X(mem_addr[16]));
 sky130_fd_sc_hd__buf_1 output180 (.A(net179),
    .X(mem_addr[17]));
 sky130_fd_sc_hd__buf_1 output181 (.A(net180),
    .X(mem_addr[18]));
 sky130_fd_sc_hd__buf_1 output182 (.A(net181),
    .X(mem_addr[19]));
 sky130_fd_sc_hd__buf_1 output183 (.A(net182),
    .X(mem_addr[20]));
 sky130_fd_sc_hd__buf_1 output184 (.A(net183),
    .X(mem_addr[21]));
 sky130_fd_sc_hd__buf_1 output185 (.A(net184),
    .X(mem_addr[22]));
 sky130_fd_sc_hd__buf_1 output186 (.A(net185),
    .X(mem_addr[23]));
 sky130_fd_sc_hd__buf_1 output187 (.A(net186),
    .X(mem_addr[24]));
 sky130_fd_sc_hd__buf_1 output188 (.A(net187),
    .X(mem_addr[25]));
 sky130_fd_sc_hd__buf_1 output189 (.A(net188),
    .X(mem_addr[26]));
 sky130_fd_sc_hd__buf_1 output190 (.A(net189),
    .X(mem_addr[27]));
 sky130_fd_sc_hd__buf_1 output191 (.A(net190),
    .X(mem_addr[28]));
 sky130_fd_sc_hd__buf_1 output192 (.A(net191),
    .X(mem_addr[29]));
 sky130_fd_sc_hd__buf_1 output193 (.A(net192),
    .X(mem_addr[2]));
 sky130_fd_sc_hd__buf_1 output194 (.A(net193),
    .X(mem_addr[30]));
 sky130_fd_sc_hd__buf_1 output195 (.A(net194),
    .X(mem_addr[31]));
 sky130_fd_sc_hd__buf_1 output196 (.A(net195),
    .X(mem_addr[3]));
 sky130_fd_sc_hd__buf_1 output197 (.A(net196),
    .X(mem_addr[4]));
 sky130_fd_sc_hd__buf_1 output198 (.A(net197),
    .X(mem_addr[5]));
 sky130_fd_sc_hd__buf_1 output199 (.A(net198),
    .X(mem_addr[6]));
 sky130_fd_sc_hd__buf_1 output200 (.A(net199),
    .X(mem_addr[7]));
 sky130_fd_sc_hd__buf_1 output201 (.A(net200),
    .X(mem_addr[8]));
 sky130_fd_sc_hd__buf_1 output202 (.A(net201),
    .X(mem_addr[9]));
 sky130_fd_sc_hd__buf_1 output203 (.A(net202),
    .X(mem_instr));
 sky130_fd_sc_hd__buf_1 output204 (.A(net203),
    .X(mem_la_addr[10]));
 sky130_fd_sc_hd__buf_1 output205 (.A(net204),
    .X(mem_la_addr[11]));
 sky130_fd_sc_hd__buf_1 output206 (.A(net205),
    .X(mem_la_addr[12]));
 sky130_fd_sc_hd__buf_1 output207 (.A(net206),
    .X(mem_la_addr[13]));
 sky130_fd_sc_hd__buf_1 output208 (.A(net207),
    .X(mem_la_addr[14]));
 sky130_fd_sc_hd__buf_1 output209 (.A(net208),
    .X(mem_la_addr[15]));
 sky130_fd_sc_hd__buf_1 output210 (.A(net209),
    .X(mem_la_addr[16]));
 sky130_fd_sc_hd__buf_1 output211 (.A(net210),
    .X(mem_la_addr[17]));
 sky130_fd_sc_hd__buf_1 output212 (.A(net211),
    .X(mem_la_addr[18]));
 sky130_fd_sc_hd__buf_1 output213 (.A(net212),
    .X(mem_la_addr[19]));
 sky130_fd_sc_hd__buf_1 output214 (.A(net213),
    .X(mem_la_addr[20]));
 sky130_fd_sc_hd__buf_1 output215 (.A(net214),
    .X(mem_la_addr[21]));
 sky130_fd_sc_hd__buf_1 output216 (.A(net215),
    .X(mem_la_addr[22]));
 sky130_fd_sc_hd__buf_1 output217 (.A(net216),
    .X(mem_la_addr[23]));
 sky130_fd_sc_hd__buf_1 output218 (.A(net217),
    .X(mem_la_addr[24]));
 sky130_fd_sc_hd__buf_1 output219 (.A(net218),
    .X(mem_la_addr[25]));
 sky130_fd_sc_hd__buf_1 output220 (.A(net219),
    .X(mem_la_addr[26]));
 sky130_fd_sc_hd__buf_1 output221 (.A(net220),
    .X(mem_la_addr[27]));
 sky130_fd_sc_hd__buf_1 output222 (.A(net221),
    .X(mem_la_addr[28]));
 sky130_fd_sc_hd__buf_1 output223 (.A(net222),
    .X(mem_la_addr[29]));
 sky130_fd_sc_hd__buf_1 output224 (.A(net223),
    .X(mem_la_addr[2]));
 sky130_fd_sc_hd__buf_1 output225 (.A(net224),
    .X(mem_la_addr[30]));
 sky130_fd_sc_hd__buf_1 output226 (.A(net225),
    .X(mem_la_addr[31]));
 sky130_fd_sc_hd__buf_1 output227 (.A(net226),
    .X(mem_la_addr[3]));
 sky130_fd_sc_hd__buf_1 output228 (.A(net227),
    .X(mem_la_addr[4]));
 sky130_fd_sc_hd__buf_1 output229 (.A(net228),
    .X(mem_la_addr[5]));
 sky130_fd_sc_hd__buf_1 output230 (.A(net229),
    .X(mem_la_addr[6]));
 sky130_fd_sc_hd__buf_1 output231 (.A(net230),
    .X(mem_la_addr[7]));
 sky130_fd_sc_hd__buf_1 output232 (.A(net231),
    .X(mem_la_addr[8]));
 sky130_fd_sc_hd__buf_1 output233 (.A(net232),
    .X(mem_la_addr[9]));
 sky130_fd_sc_hd__buf_1 output234 (.A(net233),
    .X(mem_la_read));
 sky130_fd_sc_hd__buf_1 output235 (.A(net234),
    .X(mem_la_wdata[0]));
 sky130_fd_sc_hd__buf_1 output236 (.A(net235),
    .X(mem_la_wdata[10]));
 sky130_fd_sc_hd__buf_1 output237 (.A(net236),
    .X(mem_la_wdata[11]));
 sky130_fd_sc_hd__buf_1 output238 (.A(net237),
    .X(mem_la_wdata[12]));
 sky130_fd_sc_hd__buf_1 output239 (.A(net238),
    .X(mem_la_wdata[13]));
 sky130_fd_sc_hd__buf_1 output240 (.A(net239),
    .X(mem_la_wdata[14]));
 sky130_fd_sc_hd__buf_1 output241 (.A(net240),
    .X(mem_la_wdata[15]));
 sky130_fd_sc_hd__buf_1 output242 (.A(net241),
    .X(mem_la_wdata[16]));
 sky130_fd_sc_hd__buf_1 output243 (.A(net242),
    .X(mem_la_wdata[17]));
 sky130_fd_sc_hd__buf_1 output244 (.A(net243),
    .X(mem_la_wdata[18]));
 sky130_fd_sc_hd__buf_1 output245 (.A(net244),
    .X(mem_la_wdata[19]));
 sky130_fd_sc_hd__buf_1 output246 (.A(net245),
    .X(mem_la_wdata[1]));
 sky130_fd_sc_hd__buf_1 output247 (.A(net246),
    .X(mem_la_wdata[20]));
 sky130_fd_sc_hd__buf_1 output248 (.A(net247),
    .X(mem_la_wdata[21]));
 sky130_fd_sc_hd__buf_1 output249 (.A(net248),
    .X(mem_la_wdata[22]));
 sky130_fd_sc_hd__buf_1 output250 (.A(net249),
    .X(mem_la_wdata[23]));
 sky130_fd_sc_hd__buf_1 output251 (.A(net250),
    .X(mem_la_wdata[24]));
 sky130_fd_sc_hd__buf_1 output252 (.A(net251),
    .X(mem_la_wdata[25]));
 sky130_fd_sc_hd__buf_1 output253 (.A(net252),
    .X(mem_la_wdata[26]));
 sky130_fd_sc_hd__buf_1 output254 (.A(net253),
    .X(mem_la_wdata[27]));
 sky130_fd_sc_hd__buf_1 output255 (.A(net254),
    .X(mem_la_wdata[28]));
 sky130_fd_sc_hd__buf_1 output256 (.A(net255),
    .X(mem_la_wdata[29]));
 sky130_fd_sc_hd__buf_1 output257 (.A(net256),
    .X(mem_la_wdata[2]));
 sky130_fd_sc_hd__buf_1 output258 (.A(net257),
    .X(mem_la_wdata[30]));
 sky130_fd_sc_hd__buf_1 output259 (.A(net258),
    .X(mem_la_wdata[31]));
 sky130_fd_sc_hd__buf_1 output260 (.A(net259),
    .X(mem_la_wdata[3]));
 sky130_fd_sc_hd__buf_1 output261 (.A(net260),
    .X(mem_la_wdata[4]));
 sky130_fd_sc_hd__buf_1 output262 (.A(net261),
    .X(mem_la_wdata[5]));
 sky130_fd_sc_hd__buf_1 output263 (.A(net262),
    .X(mem_la_wdata[6]));
 sky130_fd_sc_hd__buf_1 output264 (.A(net263),
    .X(mem_la_wdata[7]));
 sky130_fd_sc_hd__buf_1 output265 (.A(net264),
    .X(mem_la_wdata[8]));
 sky130_fd_sc_hd__buf_1 output266 (.A(net265),
    .X(mem_la_wdata[9]));
 sky130_fd_sc_hd__buf_1 output267 (.A(net266),
    .X(mem_la_write));
 sky130_fd_sc_hd__buf_1 output268 (.A(net699),
    .X(mem_la_wstrb[0]));
 sky130_fd_sc_hd__buf_1 output269 (.A(net710),
    .X(mem_la_wstrb[1]));
 sky130_fd_sc_hd__buf_1 output270 (.A(net700),
    .X(mem_la_wstrb[2]));
 sky130_fd_sc_hd__buf_1 output271 (.A(net703),
    .X(mem_la_wstrb[3]));
 sky130_fd_sc_hd__buf_1 output272 (.A(net271),
    .X(mem_valid));
 sky130_fd_sc_hd__buf_1 output273 (.A(net272),
    .X(mem_wdata[0]));
 sky130_fd_sc_hd__buf_1 output274 (.A(net273),
    .X(mem_wdata[10]));
 sky130_fd_sc_hd__buf_1 output275 (.A(net274),
    .X(mem_wdata[11]));
 sky130_fd_sc_hd__buf_1 output276 (.A(net275),
    .X(mem_wdata[12]));
 sky130_fd_sc_hd__buf_1 output277 (.A(net276),
    .X(mem_wdata[13]));
 sky130_fd_sc_hd__buf_1 output278 (.A(net277),
    .X(mem_wdata[14]));
 sky130_fd_sc_hd__buf_1 output279 (.A(net278),
    .X(mem_wdata[15]));
 sky130_fd_sc_hd__buf_1 output280 (.A(net279),
    .X(mem_wdata[16]));
 sky130_fd_sc_hd__buf_1 output281 (.A(net280),
    .X(mem_wdata[17]));
 sky130_fd_sc_hd__buf_1 output282 (.A(net281),
    .X(mem_wdata[18]));
 sky130_fd_sc_hd__buf_1 output283 (.A(net282),
    .X(mem_wdata[19]));
 sky130_fd_sc_hd__buf_1 output284 (.A(net283),
    .X(mem_wdata[1]));
 sky130_fd_sc_hd__buf_1 output285 (.A(net284),
    .X(mem_wdata[20]));
 sky130_fd_sc_hd__buf_1 output286 (.A(net285),
    .X(mem_wdata[21]));
 sky130_fd_sc_hd__buf_1 output287 (.A(net286),
    .X(mem_wdata[22]));
 sky130_fd_sc_hd__buf_1 output288 (.A(net287),
    .X(mem_wdata[23]));
 sky130_fd_sc_hd__buf_1 output289 (.A(net288),
    .X(mem_wdata[24]));
 sky130_fd_sc_hd__buf_1 output290 (.A(net289),
    .X(mem_wdata[25]));
 sky130_fd_sc_hd__buf_1 output291 (.A(net290),
    .X(mem_wdata[26]));
 sky130_fd_sc_hd__buf_1 output292 (.A(net291),
    .X(mem_wdata[27]));
 sky130_fd_sc_hd__buf_1 output293 (.A(net292),
    .X(mem_wdata[28]));
 sky130_fd_sc_hd__buf_1 output294 (.A(net293),
    .X(mem_wdata[29]));
 sky130_fd_sc_hd__buf_1 output295 (.A(net294),
    .X(mem_wdata[2]));
 sky130_fd_sc_hd__buf_1 output296 (.A(net295),
    .X(mem_wdata[30]));
 sky130_fd_sc_hd__buf_1 output297 (.A(net296),
    .X(mem_wdata[31]));
 sky130_fd_sc_hd__buf_1 output298 (.A(net297),
    .X(mem_wdata[3]));
 sky130_fd_sc_hd__buf_1 output299 (.A(net298),
    .X(mem_wdata[4]));
 sky130_fd_sc_hd__buf_1 output300 (.A(net299),
    .X(mem_wdata[5]));
 sky130_fd_sc_hd__buf_1 output301 (.A(net300),
    .X(mem_wdata[6]));
 sky130_fd_sc_hd__buf_1 output302 (.A(net301),
    .X(mem_wdata[7]));
 sky130_fd_sc_hd__buf_1 output303 (.A(net302),
    .X(mem_wdata[8]));
 sky130_fd_sc_hd__buf_1 output304 (.A(net303),
    .X(mem_wdata[9]));
 sky130_fd_sc_hd__buf_1 output305 (.A(net304),
    .X(mem_wstrb[0]));
 sky130_fd_sc_hd__buf_1 output306 (.A(net305),
    .X(mem_wstrb[1]));
 sky130_fd_sc_hd__buf_1 output307 (.A(net306),
    .X(mem_wstrb[2]));
 sky130_fd_sc_hd__buf_1 output308 (.A(net307),
    .X(mem_wstrb[3]));
 sky130_fd_sc_hd__buf_1 output309 (.A(net764),
    .X(pcpi_rs1[0]));
 sky130_fd_sc_hd__buf_1 output310 (.A(net763),
    .X(pcpi_rs1[10]));
 sky130_fd_sc_hd__buf_1 output311 (.A(net762),
    .X(pcpi_rs1[11]));
 sky130_fd_sc_hd__buf_1 output312 (.A(net761),
    .X(pcpi_rs1[12]));
 sky130_fd_sc_hd__buf_1 output313 (.A(net760),
    .X(pcpi_rs1[13]));
 sky130_fd_sc_hd__buf_1 output314 (.A(net759),
    .X(pcpi_rs1[14]));
 sky130_fd_sc_hd__buf_1 output315 (.A(net758),
    .X(pcpi_rs1[15]));
 sky130_fd_sc_hd__buf_1 output316 (.A(net757),
    .X(pcpi_rs1[16]));
 sky130_fd_sc_hd__buf_1 output317 (.A(net756),
    .X(pcpi_rs1[17]));
 sky130_fd_sc_hd__buf_1 output318 (.A(net755),
    .X(pcpi_rs1[18]));
 sky130_fd_sc_hd__buf_1 output319 (.A(net754),
    .X(pcpi_rs1[19]));
 sky130_fd_sc_hd__buf_1 output320 (.A(net753),
    .X(pcpi_rs1[1]));
 sky130_fd_sc_hd__buf_1 output321 (.A(net752),
    .X(pcpi_rs1[20]));
 sky130_fd_sc_hd__buf_1 output322 (.A(net751),
    .X(pcpi_rs1[21]));
 sky130_fd_sc_hd__buf_1 output323 (.A(net750),
    .X(pcpi_rs1[22]));
 sky130_fd_sc_hd__buf_1 output324 (.A(net749),
    .X(pcpi_rs1[23]));
 sky130_fd_sc_hd__buf_1 output325 (.A(net748),
    .X(pcpi_rs1[24]));
 sky130_fd_sc_hd__buf_1 output326 (.A(net747),
    .X(pcpi_rs1[25]));
 sky130_fd_sc_hd__buf_1 output327 (.A(net746),
    .X(pcpi_rs1[26]));
 sky130_fd_sc_hd__buf_1 output328 (.A(net745),
    .X(pcpi_rs1[27]));
 sky130_fd_sc_hd__buf_1 output329 (.A(net744),
    .X(pcpi_rs1[28]));
 sky130_fd_sc_hd__buf_1 output330 (.A(net743),
    .X(pcpi_rs1[29]));
 sky130_fd_sc_hd__buf_1 output331 (.A(net330),
    .X(pcpi_rs1[2]));
 sky130_fd_sc_hd__buf_1 output332 (.A(net742),
    .X(pcpi_rs1[30]));
 sky130_fd_sc_hd__buf_1 output333 (.A(net741),
    .X(pcpi_rs1[31]));
 sky130_fd_sc_hd__buf_1 output334 (.A(net740),
    .X(pcpi_rs1[3]));
 sky130_fd_sc_hd__buf_1 output335 (.A(net334),
    .X(pcpi_rs1[4]));
 sky130_fd_sc_hd__buf_1 output336 (.A(net335),
    .X(pcpi_rs1[5]));
 sky130_fd_sc_hd__buf_1 output337 (.A(net739),
    .X(pcpi_rs1[6]));
 sky130_fd_sc_hd__buf_1 output338 (.A(net738),
    .X(pcpi_rs1[7]));
 sky130_fd_sc_hd__buf_1 output339 (.A(net737),
    .X(pcpi_rs1[8]));
 sky130_fd_sc_hd__buf_1 output340 (.A(net339),
    .X(pcpi_rs1[9]));
 sky130_fd_sc_hd__buf_1 output341 (.A(net234),
    .X(pcpi_rs2[0]));
 sky130_fd_sc_hd__buf_1 output342 (.A(net340),
    .X(pcpi_rs2[10]));
 sky130_fd_sc_hd__buf_1 output343 (.A(net341),
    .X(pcpi_rs2[11]));
 sky130_fd_sc_hd__buf_1 output344 (.A(net342),
    .X(pcpi_rs2[12]));
 sky130_fd_sc_hd__buf_1 output345 (.A(net343),
    .X(pcpi_rs2[13]));
 sky130_fd_sc_hd__buf_1 output346 (.A(net344),
    .X(pcpi_rs2[14]));
 sky130_fd_sc_hd__buf_1 output347 (.A(net345),
    .X(pcpi_rs2[15]));
 sky130_fd_sc_hd__buf_1 output348 (.A(net346),
    .X(pcpi_rs2[16]));
 sky130_fd_sc_hd__buf_1 output349 (.A(net347),
    .X(pcpi_rs2[17]));
 sky130_fd_sc_hd__buf_1 output350 (.A(net348),
    .X(pcpi_rs2[18]));
 sky130_fd_sc_hd__buf_1 output351 (.A(net349),
    .X(pcpi_rs2[19]));
 sky130_fd_sc_hd__buf_1 output352 (.A(net245),
    .X(pcpi_rs2[1]));
 sky130_fd_sc_hd__buf_1 output353 (.A(net350),
    .X(pcpi_rs2[20]));
 sky130_fd_sc_hd__buf_1 output354 (.A(net351),
    .X(pcpi_rs2[21]));
 sky130_fd_sc_hd__buf_1 output355 (.A(net352),
    .X(pcpi_rs2[22]));
 sky130_fd_sc_hd__buf_1 output356 (.A(net353),
    .X(pcpi_rs2[23]));
 sky130_fd_sc_hd__buf_1 output357 (.A(net354),
    .X(pcpi_rs2[24]));
 sky130_fd_sc_hd__buf_1 output358 (.A(net355),
    .X(pcpi_rs2[25]));
 sky130_fd_sc_hd__buf_1 output359 (.A(net356),
    .X(pcpi_rs2[26]));
 sky130_fd_sc_hd__buf_1 output360 (.A(net357),
    .X(pcpi_rs2[27]));
 sky130_fd_sc_hd__buf_1 output361 (.A(net358),
    .X(pcpi_rs2[28]));
 sky130_fd_sc_hd__buf_1 output362 (.A(net359),
    .X(pcpi_rs2[29]));
 sky130_fd_sc_hd__buf_1 output363 (.A(net256),
    .X(pcpi_rs2[2]));
 sky130_fd_sc_hd__buf_1 output364 (.A(net360),
    .X(pcpi_rs2[30]));
 sky130_fd_sc_hd__buf_1 output365 (.A(net361),
    .X(pcpi_rs2[31]));
 sky130_fd_sc_hd__buf_1 output366 (.A(net259),
    .X(pcpi_rs2[3]));
 sky130_fd_sc_hd__buf_1 output367 (.A(net260),
    .X(pcpi_rs2[4]));
 sky130_fd_sc_hd__buf_1 output368 (.A(net261),
    .X(pcpi_rs2[5]));
 sky130_fd_sc_hd__buf_1 output369 (.A(net262),
    .X(pcpi_rs2[6]));
 sky130_fd_sc_hd__buf_1 output370 (.A(net263),
    .X(pcpi_rs2[7]));
 sky130_fd_sc_hd__buf_1 output371 (.A(net362),
    .X(pcpi_rs2[8]));
 sky130_fd_sc_hd__buf_1 output372 (.A(net363),
    .X(pcpi_rs2[9]));
 sky130_fd_sc_hd__buf_1 output373 (.A(net364),
    .X(trap));
 sky130_fd_sc_hd__buf_4 place648 (.A(\cpuregs_wrdata[31] ),
    .X(net639));
 sky130_fd_sc_hd__buf_4 place649 (.A(\cpuregs_wrdata[25] ),
    .X(net640));
 sky130_fd_sc_hd__buf_4 place650 (.A(\cpuregs_wrdata[29] ),
    .X(net641));
 sky130_fd_sc_hd__buf_4 place651 (.A(_0512_),
    .X(net642));
 sky130_fd_sc_hd__buf_4 place652 (.A(\cpuregs_wrdata[26] ),
    .X(net643));
 sky130_fd_sc_hd__buf_4 place653 (.A(\cpuregs_wrdata[27] ),
    .X(net644));
 sky130_fd_sc_hd__buf_4 place654 (.A(\cpuregs_wrdata[28] ),
    .X(net645));
 sky130_fd_sc_hd__buf_4 place655 (.A(\cpuregs_wrdata[30] ),
    .X(net646));
 sky130_fd_sc_hd__buf_4 place656 (.A(\cpuregs_wrdata[20] ),
    .X(net647));
 sky130_fd_sc_hd__buf_4 place657 (.A(\cpuregs_wrdata[21] ),
    .X(net648));
 sky130_fd_sc_hd__buf_4 place658 (.A(\cpuregs_wrdata[23] ),
    .X(net649));
 sky130_fd_sc_hd__buf_4 place659 (.A(_1469_),
    .X(net650));
 sky130_fd_sc_hd__buf_4 place660 (.A(\cpuregs_wrdata[18] ),
    .X(net651));
 sky130_fd_sc_hd__buf_4 place661 (.A(\cpuregs_wrdata[19] ),
    .X(net652));
 sky130_fd_sc_hd__buf_4 place662 (.A(_0815_),
    .X(net653));
 sky130_fd_sc_hd__buf_4 place663 (.A(_0837_),
    .X(net654));
 sky130_fd_sc_hd__buf_4 place664 (.A(_0828_),
    .X(net655));
 sky130_fd_sc_hd__buf_4 place665 (.A(_0840_),
    .X(net656));
 sky130_fd_sc_hd__buf_4 place666 (.A(_0839_),
    .X(net657));
 sky130_fd_sc_hd__buf_4 place667 (.A(_0830_),
    .X(net658));
 sky130_fd_sc_hd__buf_4 place668 (.A(_0842_),
    .X(net659));
 sky130_fd_sc_hd__buf_4 place669 (.A(_0838_),
    .X(net660));
 sky130_fd_sc_hd__buf_4 place670 (.A(_0843_),
    .X(net661));
 sky130_fd_sc_hd__buf_4 place671 (.A(_0844_),
    .X(net662));
 sky130_fd_sc_hd__buf_4 place672 (.A(_0831_),
    .X(net663));
 sky130_fd_sc_hd__buf_4 place673 (.A(_0845_),
    .X(net664));
 sky130_fd_sc_hd__buf_4 place674 (.A(_0836_),
    .X(net665));
 sky130_fd_sc_hd__buf_4 place675 (.A(_0846_),
    .X(net666));
 sky130_fd_sc_hd__buf_4 place676 (.A(_0847_),
    .X(net667));
 sky130_fd_sc_hd__buf_4 place677 (.A(_0832_),
    .X(net668));
 sky130_fd_sc_hd__buf_4 place678 (.A(_0848_),
    .X(net669));
 sky130_fd_sc_hd__buf_4 place679 (.A(_0818_),
    .X(net670));
 sky130_fd_sc_hd__buf_4 place680 (.A(_0819_),
    .X(net671));
 sky130_fd_sc_hd__buf_4 place681 (.A(_0820_),
    .X(net672));
 sky130_fd_sc_hd__buf_4 place682 (.A(_0821_),
    .X(net673));
 sky130_fd_sc_hd__buf_4 place683 (.A(_0833_),
    .X(net674));
 sky130_fd_sc_hd__buf_4 place684 (.A(_0822_),
    .X(net675));
 sky130_fd_sc_hd__buf_4 place685 (.A(_0823_),
    .X(net676));
 sky130_fd_sc_hd__buf_4 place686 (.A(_0841_),
    .X(net677));
 sky130_fd_sc_hd__buf_4 place687 (.A(_0824_),
    .X(net678));
 sky130_fd_sc_hd__buf_4 place688 (.A(_0834_),
    .X(net679));
 sky130_fd_sc_hd__buf_4 place689 (.A(_0825_),
    .X(net680));
 sky130_fd_sc_hd__buf_4 place690 (.A(_0826_),
    .X(net681));
 sky130_fd_sc_hd__buf_4 place691 (.A(_0827_),
    .X(net682));
 sky130_fd_sc_hd__buf_4 place692 (.A(_0835_),
    .X(net683));
 sky130_fd_sc_hd__buf_4 place693 (.A(_0829_),
    .X(net684));
 sky130_fd_sc_hd__buf_4 place694 (.A(\cpuregs_wrdata[12] ),
    .X(net685));
 sky130_fd_sc_hd__buf_4 place695 (.A(\cpuregs_wrdata[17] ),
    .X(net686));
 sky130_fd_sc_hd__buf_4 place696 (.A(_0506_),
    .X(net687));
 sky130_fd_sc_hd__buf_4 place697 (.A(\cpuregs_wrdata[8] ),
    .X(net688));
 sky130_fd_sc_hd__buf_4 place698 (.A(_1236_),
    .X(net689));
 sky130_fd_sc_hd__buf_4 place699 (.A(_0505_),
    .X(net690));
 sky130_fd_sc_hd__buf_4 place700 (.A(\cpuregs_wrdata[7] ),
    .X(net691));
 sky130_fd_sc_hd__buf_4 place701 (.A(\cpuregs_wrdata[9] ),
    .X(net692));
 sky130_fd_sc_hd__buf_4 place702 (.A(_0859_),
    .X(net693));
 sky130_fd_sc_hd__buf_4 place703 (.A(_4336_),
    .X(net694));
 sky130_fd_sc_hd__buf_4 place704 (.A(_4309_),
    .X(net695));
 sky130_fd_sc_hd__buf_4 place705 (.A(_1766_),
    .X(net696));
 sky130_fd_sc_hd__buf_4 place706 (.A(_1673_),
    .X(net697));
 sky130_fd_sc_hd__buf_4 place707 (.A(_1003_),
    .X(net698));
 sky130_fd_sc_hd__buf_4 place708 (.A(net267),
    .X(net699));
 sky130_fd_sc_hd__buf_4 place709 (.A(net269),
    .X(net700));
 sky130_fd_sc_hd__buf_4 place710 (.A(_0924_),
    .X(net701));
 sky130_fd_sc_hd__buf_4 place711 (.A(_0482_),
    .X(net702));
 sky130_fd_sc_hd__buf_4 place712 (.A(net270),
    .X(net703));
 sky130_fd_sc_hd__buf_4 place713 (.A(_3805_),
    .X(net704));
 sky130_fd_sc_hd__buf_4 place714 (.A(_3721_),
    .X(net705));
 sky130_fd_sc_hd__buf_4 place715 (.A(_3356_),
    .X(net706));
 sky130_fd_sc_hd__buf_4 place716 (.A(_1681_),
    .X(net707));
 sky130_fd_sc_hd__buf_4 place717 (.A(_1671_),
    .X(net708));
 sky130_fd_sc_hd__buf_4 place718 (.A(_1245_),
    .X(net709));
 sky130_fd_sc_hd__buf_4 place719 (.A(net268),
    .X(net710));
 sky130_fd_sc_hd__buf_4 place720 (.A(_0897_),
    .X(net711));
 sky130_fd_sc_hd__buf_4 place721 (.A(net713),
    .X(net712));
 sky130_fd_sc_hd__buf_4 place722 (.A(_0797_),
    .X(net713));
 sky130_fd_sc_hd__buf_4 place723 (.A(_3856_),
    .X(net714));
 sky130_fd_sc_hd__buf_4 place724 (.A(_3704_),
    .X(net715));
 sky130_fd_sc_hd__buf_4 place725 (.A(_2947_),
    .X(net716));
 sky130_fd_sc_hd__buf_4 place726 (.A(_2943_),
    .X(net717));
 sky130_fd_sc_hd__buf_4 place727 (.A(_2487_),
    .X(net718));
 sky130_fd_sc_hd__buf_4 place728 (.A(_1901_),
    .X(net719));
 sky130_fd_sc_hd__buf_4 place729 (.A(_1763_),
    .X(net720));
 sky130_fd_sc_hd__buf_4 place730 (.A(_1724_),
    .X(net721));
 sky130_fd_sc_hd__buf_4 place731 (.A(_1720_),
    .X(net722));
 sky130_fd_sc_hd__buf_4 place732 (.A(_1669_),
    .X(net723));
 sky130_fd_sc_hd__buf_4 place733 (.A(_1613_),
    .X(net724));
 sky130_fd_sc_hd__buf_4 place734 (.A(_1541_),
    .X(net725));
 sky130_fd_sc_hd__buf_4 place735 (.A(_1136_),
    .X(net726));
 sky130_fd_sc_hd__buf_4 place736 (.A(_1000_),
    .X(net727));
 sky130_fd_sc_hd__buf_4 place737 (.A(_0997_),
    .X(net728));
 sky130_fd_sc_hd__buf_4 place738 (.A(_0986_),
    .X(net729));
 sky130_fd_sc_hd__buf_4 place739 (.A(_0961_),
    .X(net730));
 sky130_fd_sc_hd__buf_4 place740 (.A(_0874_),
    .X(net731));
 sky130_fd_sc_hd__buf_4 place741 (.A(_0863_),
    .X(net732));
 sky130_fd_sc_hd__buf_4 place742 (.A(_0854_),
    .X(net733));
 sky130_fd_sc_hd__buf_4 place743 (.A(_0850_),
    .X(net734));
 sky130_fd_sc_hd__buf_4 place744 (.A(\reg_pc[9] ),
    .X(net735));
 sky130_fd_sc_hd__buf_4 place745 (.A(net339),
    .X(net736));
 sky130_fd_sc_hd__buf_4 place746 (.A(net338),
    .X(net737));
 sky130_fd_sc_hd__buf_4 place747 (.A(net337),
    .X(net738));
 sky130_fd_sc_hd__buf_4 place748 (.A(net336),
    .X(net739));
 sky130_fd_sc_hd__buf_4 place749 (.A(net333),
    .X(net740));
 sky130_fd_sc_hd__buf_4 place750 (.A(net332),
    .X(net741));
 sky130_fd_sc_hd__buf_4 place751 (.A(net331),
    .X(net742));
 sky130_fd_sc_hd__buf_4 place752 (.A(net329),
    .X(net743));
 sky130_fd_sc_hd__buf_4 place753 (.A(net328),
    .X(net744));
 sky130_fd_sc_hd__buf_4 place754 (.A(net327),
    .X(net745));
 sky130_fd_sc_hd__buf_4 place755 (.A(net326),
    .X(net746));
 sky130_fd_sc_hd__buf_4 place756 (.A(net325),
    .X(net747));
 sky130_fd_sc_hd__buf_4 place757 (.A(net324),
    .X(net748));
 sky130_fd_sc_hd__buf_4 place758 (.A(net323),
    .X(net749));
 sky130_fd_sc_hd__buf_4 place759 (.A(net322),
    .X(net750));
 sky130_fd_sc_hd__buf_4 place760 (.A(net321),
    .X(net751));
 sky130_fd_sc_hd__buf_4 place761 (.A(net320),
    .X(net752));
 sky130_fd_sc_hd__buf_4 place762 (.A(net319),
    .X(net753));
 sky130_fd_sc_hd__buf_4 place763 (.A(net318),
    .X(net754));
 sky130_fd_sc_hd__buf_4 place764 (.A(net317),
    .X(net755));
 sky130_fd_sc_hd__buf_4 place765 (.A(net316),
    .X(net756));
 sky130_fd_sc_hd__buf_4 place766 (.A(net315),
    .X(net757));
 sky130_fd_sc_hd__buf_4 place767 (.A(net314),
    .X(net758));
 sky130_fd_sc_hd__buf_4 place768 (.A(net313),
    .X(net759));
 sky130_fd_sc_hd__buf_4 place769 (.A(net312),
    .X(net760));
 sky130_fd_sc_hd__buf_4 place770 (.A(net311),
    .X(net761));
 sky130_fd_sc_hd__buf_4 place771 (.A(net310),
    .X(net762));
 sky130_fd_sc_hd__buf_4 place772 (.A(net309),
    .X(net763));
 sky130_fd_sc_hd__buf_4 place773 (.A(net308),
    .X(net764));
 sky130_fd_sc_hd__buf_4 place774 (.A(\mem_wordsize[2] ),
    .X(net765));
 sky130_fd_sc_hd__buf_4 place775 (.A(\mem_wordsize[1] ),
    .X(net766));
 sky130_fd_sc_hd__buf_4 place776 (.A(instr_sub),
    .X(net767));
 sky130_fd_sc_hd__buf_4 place777 (.A(instr_rdinstrh),
    .X(net768));
 sky130_fd_sc_hd__buf_4 place778 (.A(instr_rdinstr),
    .X(net769));
 sky130_fd_sc_hd__buf_4 place779 (.A(instr_rdcycleh),
    .X(net770));
 sky130_fd_sc_hd__buf_4 place780 (.A(net772),
    .X(net771));
 sky130_fd_sc_hd__buf_4 place781 (.A(instr_jal),
    .X(net772));
 sky130_fd_sc_hd__buf_4 place782 (.A(decoder_trigger),
    .X(net773));
 sky130_fd_sc_hd__buf_4 place783 (.A(net775),
    .X(net774));
 sky130_fd_sc_hd__buf_4 place784 (.A(\cpu_state[4] ),
    .X(net775));
 sky130_fd_sc_hd__buf_4 place785 (.A(\cpu_state[3] ),
    .X(net776));
 sky130_fd_sc_hd__buf_4 place786 (.A(\cpu_state[2] ),
    .X(net777));
 sky130_fd_sc_hd__buf_4 place787 (.A(net779),
    .X(net778));
 sky130_fd_sc_hd__buf_4 place788 (.A(\cpu_state[1] ),
    .X(net779));
 sky130_fd_sc_hd__buf_4 place789 (.A(_0050_),
    .X(net780));
 sky130_fd_sc_hd__buf_4 place790 (.A(net782),
    .X(net781));
 sky130_fd_sc_hd__buf_4 place791 (.A(_0049_),
    .X(net782));
 sky130_fd_sc_hd__buf_4 place792 (.A(net784),
    .X(net783));
 sky130_fd_sc_hd__buf_4 place793 (.A(_0048_),
    .X(net784));
 sky130_fd_sc_hd__buf_4 place794 (.A(net788),
    .X(net785));
 sky130_fd_sc_hd__buf_4 place795 (.A(net788),
    .X(net786));
 sky130_fd_sc_hd__buf_4 place796 (.A(net788),
    .X(net787));
 sky130_fd_sc_hd__buf_4 place797 (.A(net791),
    .X(net788));
 sky130_fd_sc_hd__buf_4 place798 (.A(net790),
    .X(net789));
 sky130_fd_sc_hd__buf_4 place799 (.A(net791),
    .X(net790));
 sky130_fd_sc_hd__buf_4 place800 (.A(_0047_),
    .X(net791));
 sky130_fd_sc_hd__buf_4 place801 (.A(net793),
    .X(net792));
 sky130_fd_sc_hd__buf_4 place802 (.A(_0046_),
    .X(net793));
 sky130_fd_sc_hd__buf_4 place803 (.A(_0046_),
    .X(net794));
 sky130_fd_sc_hd__buf_4 place804 (.A(net796),
    .X(net795));
 sky130_fd_sc_hd__buf_4 place805 (.A(_0046_),
    .X(net796));
 sky130_fd_sc_hd__buf_4 place806 (.A(net799),
    .X(net797));
 sky130_fd_sc_hd__buf_4 place807 (.A(net799),
    .X(net798));
 sky130_fd_sc_hd__buf_4 place808 (.A(_0046_),
    .X(net799));
 sky130_fd_sc_hd__buf_4 place809 (.A(net801),
    .X(net800));
 sky130_fd_sc_hd__buf_4 place810 (.A(_0045_),
    .X(net801));
 sky130_fd_sc_hd__buf_4 place811 (.A(_0044_),
    .X(net802));
 sky130_fd_sc_hd__buf_4 place812 (.A(net805),
    .X(net803));
 sky130_fd_sc_hd__buf_4 place813 (.A(net805),
    .X(net804));
 sky130_fd_sc_hd__buf_4 place814 (.A(_0043_),
    .X(net805));
 sky130_fd_sc_hd__buf_4 place815 (.A(net812),
    .X(net806));
 sky130_fd_sc_hd__buf_4 place816 (.A(net811),
    .X(net807));
 sky130_fd_sc_hd__buf_4 place817 (.A(net809),
    .X(net808));
 sky130_fd_sc_hd__buf_4 place818 (.A(net811),
    .X(net809));
 sky130_fd_sc_hd__buf_4 place819 (.A(net811),
    .X(net810));
 sky130_fd_sc_hd__buf_4 place820 (.A(net812),
    .X(net811));
 sky130_fd_sc_hd__buf_4 place821 (.A(_0042_),
    .X(net812));
 sky130_fd_sc_hd__buf_4 place822 (.A(_0041_),
    .X(net813));
 sky130_fd_sc_hd__buf_4 place823 (.A(net820),
    .X(net814));
 sky130_fd_sc_hd__buf_4 place824 (.A(net816),
    .X(net815));
 sky130_fd_sc_hd__buf_4 place825 (.A(net820),
    .X(net816));
 sky130_fd_sc_hd__buf_4 place826 (.A(net820),
    .X(net817));
 sky130_fd_sc_hd__buf_4 place827 (.A(net819),
    .X(net818));
 sky130_fd_sc_hd__buf_4 place828 (.A(net820),
    .X(net819));
 sky130_fd_sc_hd__buf_4 place829 (.A(_0041_),
    .X(net820));
 sky130_fd_sc_hd__buf_4 place830 (.A(net822),
    .X(net821));
 sky130_fd_sc_hd__buf_4 place831 (.A(net824),
    .X(net822));
 sky130_fd_sc_hd__buf_4 place832 (.A(net824),
    .X(net823));
 sky130_fd_sc_hd__buf_4 place833 (.A(_3521_),
    .X(net824));
 sky130_fd_sc_hd__buf_4 place834 (.A(net171),
    .X(net825));
 sky130_fd_sc_hd__buf_4 place835 (.A(net161),
    .X(net826));
 sky130_fd_sc_hd__buf_4 place836 (.A(net155),
    .X(net827));
 sky130_fd_sc_hd__buf_4 place837 (.A(net149),
    .X(net828));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[10]$_SDFFE_PN0P_  (.D(_0637_),
    .Q(\reg_next_pc[10] ),
    .CLK(clknet_leaf_115_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[11]$_SDFFE_PN0P_  (.D(_0636_),
    .Q(\reg_next_pc[11] ),
    .CLK(clknet_leaf_113_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[12]$_SDFFE_PN0P_  (.D(_0635_),
    .Q(\reg_next_pc[12] ),
    .CLK(clknet_leaf_113_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[13]$_SDFFE_PN0P_  (.D(_0634_),
    .Q(\reg_next_pc[13] ),
    .CLK(clknet_leaf_120_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[14]$_SDFFE_PN0P_  (.D(_0633_),
    .Q(\reg_next_pc[14] ),
    .CLK(clknet_leaf_115_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[15]$_SDFFE_PN0P_  (.D(_0632_),
    .Q(\reg_next_pc[15] ),
    .CLK(clknet_leaf_120_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[16]$_SDFFE_PN0P_  (.D(_0631_),
    .Q(\reg_next_pc[16] ),
    .CLK(clknet_leaf_121_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[17]$_SDFFE_PN0P_  (.D(_0630_),
    .Q(\reg_next_pc[17] ),
    .CLK(clknet_leaf_113_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[18]$_SDFFE_PN0P_  (.D(_0629_),
    .Q(\reg_next_pc[18] ),
    .CLK(clknet_leaf_121_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[19]$_SDFFE_PN0P_  (.D(_0628_),
    .Q(\reg_next_pc[19] ),
    .CLK(clknet_leaf_118_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[1]$_SDFFE_PN0P_  (.D(_0646_),
    .Q(\reg_next_pc[1] ),
    .CLK(clknet_leaf_111_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[20]$_SDFFE_PN0P_  (.D(_0627_),
    .Q(\reg_next_pc[20] ),
    .CLK(clknet_leaf_118_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[21]$_SDFFE_PN0P_  (.D(_0626_),
    .Q(\reg_next_pc[21] ),
    .CLK(clknet_leaf_119_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[22]$_SDFFE_PN0P_  (.D(_0625_),
    .Q(\reg_next_pc[22] ),
    .CLK(clknet_leaf_119_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[23]$_SDFFE_PN0P_  (.D(_0624_),
    .Q(\reg_next_pc[23] ),
    .CLK(clknet_leaf_122_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[24]$_SDFFE_PN0P_  (.D(_0623_),
    .Q(\reg_next_pc[24] ),
    .CLK(clknet_leaf_121_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[25]$_SDFFE_PN0P_  (.D(_0622_),
    .Q(\reg_next_pc[25] ),
    .CLK(clknet_leaf_122_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[26]$_SDFFE_PN0P_  (.D(_0621_),
    .Q(\reg_next_pc[26] ),
    .CLK(clknet_leaf_122_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[27]$_SDFFE_PN0P_  (.D(_0620_),
    .Q(\reg_next_pc[27] ),
    .CLK(clknet_leaf_119_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[28]$_SDFFE_PN0P_  (.D(_0619_),
    .Q(\reg_next_pc[28] ),
    .CLK(clknet_leaf_119_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[29]$_SDFFE_PN0P_  (.D(_0618_),
    .Q(\reg_next_pc[29] ),
    .CLK(clknet_leaf_119_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[2]$_SDFFE_PN0P_  (.D(_0645_),
    .Q(\reg_next_pc[2] ),
    .CLK(clknet_leaf_112_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[30]$_SDFFE_PN0P_  (.D(_0617_),
    .Q(\reg_next_pc[30] ),
    .CLK(clknet_leaf_119_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[31]$_SDFFE_PN0P_  (.D(_0782_),
    .Q(\reg_next_pc[31] ),
    .CLK(clknet_leaf_118_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[3]$_SDFFE_PN0P_  (.D(_0644_),
    .Q(\reg_next_pc[3] ),
    .CLK(clknet_leaf_112_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[4]$_SDFFE_PN0P_  (.D(_0643_),
    .Q(\reg_next_pc[4] ),
    .CLK(clknet_leaf_114_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[5]$_SDFFE_PN0P_  (.D(_0642_),
    .Q(\reg_next_pc[5] ),
    .CLK(clknet_leaf_112_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[6]$_SDFFE_PN0P_  (.D(_0641_),
    .Q(\reg_next_pc[6] ),
    .CLK(clknet_leaf_113_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[7]$_SDFFE_PN0P_  (.D(_0640_),
    .Q(\reg_next_pc[7] ),
    .CLK(clknet_leaf_113_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[8]$_SDFFE_PN0P_  (.D(_0639_),
    .Q(\reg_next_pc[8] ),
    .CLK(clknet_leaf_113_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_next_pc[9]$_SDFFE_PN0P_  (.D(_0638_),
    .Q(\reg_next_pc[9] ),
    .CLK(clknet_leaf_113_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[0]$_DFFE_PP_  (.D(_4649_),
    .DE(net642),
    .Q(net308),
    .CLK(clknet_leaf_108_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[10]$_DFFE_PP_  (.D(_4650_),
    .DE(net642),
    .Q(net309),
    .CLK(clknet_leaf_95_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[11]$_DFFE_PP_  (.D(_4651_),
    .DE(net642),
    .Q(net310),
    .CLK(clknet_leaf_96_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[12]$_DFFE_PP_  (.D(_4652_),
    .DE(net642),
    .Q(net311),
    .CLK(clknet_leaf_96_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[13]$_DFFE_PP_  (.D(_4653_),
    .DE(net642),
    .Q(net312),
    .CLK(clknet_leaf_96_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[14]$_DFFE_PP_  (.D(_4654_),
    .DE(net642),
    .Q(net313),
    .CLK(clknet_leaf_96_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[15]$_DFFE_PP_  (.D(_4655_),
    .DE(net642),
    .Q(net314),
    .CLK(clknet_leaf_94_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[16]$_DFFE_PP_  (.D(_4656_),
    .DE(net642),
    .Q(net315),
    .CLK(clknet_leaf_95_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[17]$_DFFE_PP_  (.D(_4657_),
    .DE(net642),
    .Q(net316),
    .CLK(clknet_leaf_83_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[18]$_DFFE_PP_  (.D(_4658_),
    .DE(net642),
    .Q(net317),
    .CLK(clknet_leaf_96_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[19]$_DFFE_PP_  (.D(_4659_),
    .DE(net642),
    .Q(net318),
    .CLK(clknet_leaf_108_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[1]$_DFFE_PP_  (.D(_4660_),
    .DE(net642),
    .Q(net319),
    .CLK(clknet_leaf_109_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[20]$_DFFE_PP_  (.D(_4661_),
    .DE(net642),
    .Q(net320),
    .CLK(clknet_leaf_96_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[21]$_DFFE_PP_  (.D(_4662_),
    .DE(net642),
    .Q(net321),
    .CLK(clknet_leaf_107_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[22]$_DFFE_PP_  (.D(_4663_),
    .DE(net642),
    .Q(net322),
    .CLK(clknet_leaf_107_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[23]$_DFFE_PP_  (.D(_4664_),
    .DE(net642),
    .Q(net323),
    .CLK(clknet_leaf_107_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[24]$_DFFE_PP_  (.D(_4665_),
    .DE(net642),
    .Q(net324),
    .CLK(clknet_leaf_107_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[25]$_DFFE_PP_  (.D(_4666_),
    .DE(net642),
    .Q(net325),
    .CLK(clknet_leaf_108_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[26]$_DFFE_PP_  (.D(_4667_),
    .DE(net642),
    .Q(net326),
    .CLK(clknet_leaf_108_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[27]$_DFFE_PP_  (.D(_4668_),
    .DE(net642),
    .Q(net327),
    .CLK(clknet_leaf_108_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[28]$_DFFE_PP_  (.D(_4669_),
    .DE(net642),
    .Q(net328),
    .CLK(clknet_leaf_83_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[29]$_DFFE_PP_  (.D(_4670_),
    .DE(net642),
    .Q(net329),
    .CLK(clknet_leaf_109_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[2]$_DFFE_PP_  (.D(_4671_),
    .DE(net642),
    .Q(net330),
    .CLK(clknet_leaf_109_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[30]$_DFFE_PP_  (.D(_4672_),
    .DE(net642),
    .Q(net331),
    .CLK(clknet_leaf_108_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[31]$_DFFE_PP_  (.D(_4673_),
    .DE(_0511_),
    .Q(net332),
    .CLK(clknet_leaf_109_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[3]$_DFFE_PP_  (.D(_4674_),
    .DE(net642),
    .Q(net333),
    .CLK(clknet_leaf_107_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[4]$_DFFE_PP_  (.D(_4675_),
    .DE(net642),
    .Q(net334),
    .CLK(clknet_leaf_83_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[5]$_DFFE_PP_  (.D(_4676_),
    .DE(net642),
    .Q(net335),
    .CLK(clknet_leaf_83_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[6]$_DFFE_PP_  (.D(_4677_),
    .DE(net642),
    .Q(net336),
    .CLK(clknet_leaf_82_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[7]$_DFFE_PP_  (.D(_4678_),
    .DE(net642),
    .Q(net337),
    .CLK(clknet_leaf_83_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[8]$_DFFE_PP_  (.D(_4679_),
    .DE(net642),
    .Q(net338),
    .CLK(clknet_leaf_84_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op1[9]$_DFFE_PP_  (.D(_4680_),
    .DE(net642),
    .Q(net339),
    .CLK(clknet_leaf_95_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[0]$_DFFE_PP_  (.D(_4617_),
    .DE(_0508_),
    .Q(net234),
    .CLK(clknet_leaf_108_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[10]$_DFFE_PP_  (.D(_4618_),
    .DE(_0508_),
    .Q(net340),
    .CLK(clknet_leaf_65_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[11]$_DFFE_PP_  (.D(_4619_),
    .DE(_0508_),
    .Q(net341),
    .CLK(clknet_leaf_97_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[12]$_DFFE_PP_  (.D(_4620_),
    .DE(_0508_),
    .Q(net342),
    .CLK(clknet_leaf_94_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[13]$_DFFE_PP_  (.D(_4621_),
    .DE(_0508_),
    .Q(net343),
    .CLK(clknet_leaf_96_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[14]$_DFFE_PP_  (.D(_4622_),
    .DE(_0508_),
    .Q(net344),
    .CLK(clknet_leaf_96_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[15]$_DFFE_PP_  (.D(_4623_),
    .DE(_0508_),
    .Q(net345),
    .CLK(clknet_leaf_61_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[16]$_DFFE_PP_  (.D(_4624_),
    .DE(_0508_),
    .Q(net346),
    .CLK(clknet_leaf_95_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[17]$_DFFE_PP_  (.D(_4625_),
    .DE(_0508_),
    .Q(net347),
    .CLK(clknet_leaf_106_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[18]$_DFFE_PP_  (.D(_4626_),
    .DE(_0508_),
    .Q(net348),
    .CLK(clknet_leaf_96_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[19]$_DFFE_PP_  (.D(_4627_),
    .DE(_0508_),
    .Q(net349),
    .CLK(clknet_leaf_105_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[1]$_DFFE_PP_  (.D(_4628_),
    .DE(_0508_),
    .Q(net245),
    .CLK(clknet_leaf_79_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[20]$_DFFE_PP_  (.D(_4629_),
    .DE(_0508_),
    .Q(net350),
    .CLK(clknet_leaf_100_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[21]$_DFFE_PP_  (.D(_4630_),
    .DE(_0508_),
    .Q(net351),
    .CLK(clknet_leaf_81_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[22]$_DFFE_PP_  (.D(_4631_),
    .DE(_0508_),
    .Q(net352),
    .CLK(clknet_leaf_106_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[23]$_DFFE_PP_  (.D(_4632_),
    .DE(_0508_),
    .Q(net353),
    .CLK(clknet_leaf_74_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[24]$_DFFE_PP_  (.D(_4633_),
    .DE(_0508_),
    .Q(net354),
    .CLK(clknet_leaf_106_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[25]$_DFFE_PP_  (.D(_4634_),
    .DE(_0508_),
    .Q(net355),
    .CLK(clknet_leaf_106_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[26]$_DFFE_PP_  (.D(_4635_),
    .DE(_0508_),
    .Q(net356),
    .CLK(clknet_leaf_104_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[27]$_DFFE_PP_  (.D(_4636_),
    .DE(_0508_),
    .Q(net357),
    .CLK(clknet_leaf_104_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[28]$_DFFE_PP_  (.D(_4637_),
    .DE(_0508_),
    .Q(net358),
    .CLK(clknet_leaf_106_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[29]$_DFFE_PP_  (.D(_4638_),
    .DE(_0508_),
    .Q(net359),
    .CLK(clknet_leaf_103_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[2]$_DFFE_PP_  (.D(_4639_),
    .DE(_0508_),
    .Q(net256),
    .CLK(clknet_leaf_108_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[30]$_DFFE_PP_  (.D(_4640_),
    .DE(_0508_),
    .Q(net360),
    .CLK(clknet_leaf_103_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[31]$_DFFE_PP_  (.D(_4641_),
    .DE(_0508_),
    .Q(net361),
    .CLK(clknet_leaf_103_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[3]$_DFFE_PP_  (.D(_4642_),
    .DE(_0508_),
    .Q(net259),
    .CLK(clknet_leaf_105_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[4]$_DFFE_PP_  (.D(_4643_),
    .DE(_0508_),
    .Q(net260),
    .CLK(clknet_leaf_74_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[5]$_DFFE_PP_  (.D(_4644_),
    .DE(_0508_),
    .Q(net261),
    .CLK(clknet_leaf_62_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[6]$_DFFE_PP_  (.D(_4645_),
    .DE(_0508_),
    .Q(net262),
    .CLK(clknet_leaf_63_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[7]$_DFFE_PP_  (.D(_4646_),
    .DE(_0508_),
    .Q(net263),
    .CLK(clknet_leaf_65_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[8]$_DFFE_PP_  (.D(_4647_),
    .DE(_0508_),
    .Q(net362),
    .CLK(clknet_leaf_66_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_op2[9]$_DFFE_PP_  (.D(_4648_),
    .DE(_0508_),
    .Q(net363),
    .CLK(clknet_leaf_62_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[0]$_DFF_P_  (.D(_0004_),
    .Q(\reg_out[0] ),
    .CLK(clknet_leaf_143_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[10]$_DFF_P_  (.D(_0005_),
    .Q(\reg_out[10] ),
    .CLK(clknet_leaf_114_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[11]$_DFF_P_  (.D(_0006_),
    .Q(\reg_out[11] ),
    .CLK(clknet_leaf_105_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[12]$_DFF_P_  (.D(_0007_),
    .Q(\reg_out[12] ),
    .CLK(clknet_leaf_115_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[13]$_DFF_P_  (.D(_0008_),
    .Q(\reg_out[13] ),
    .CLK(clknet_leaf_114_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[14]$_DFF_P_  (.D(_0009_),
    .Q(\reg_out[14] ),
    .CLK(clknet_leaf_104_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[15]$_DFF_P_  (.D(_0010_),
    .Q(\reg_out[15] ),
    .CLK(clknet_leaf_114_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[16]$_DFF_P_  (.D(_0011_),
    .Q(\reg_out[16] ),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[17]$_DFF_P_  (.D(_0012_),
    .Q(\reg_out[17] ),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[18]$_DFF_P_  (.D(_0013_),
    .Q(\reg_out[18] ),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[19]$_DFF_P_  (.D(_0014_),
    .Q(\reg_out[19] ),
    .CLK(clknet_leaf_110_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[1]$_DFF_P_  (.D(_0015_),
    .Q(\reg_out[1] ),
    .CLK(clknet_leaf_142_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[20]$_DFF_P_  (.D(_0016_),
    .Q(\reg_out[20] ),
    .CLK(clknet_leaf_110_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[21]$_DFF_P_  (.D(_0017_),
    .Q(\reg_out[21] ),
    .CLK(clknet_leaf_115_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[22]$_DFF_P_  (.D(_0018_),
    .Q(\reg_out[22] ),
    .CLK(clknet_leaf_118_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[23]$_DFF_P_  (.D(_0019_),
    .Q(\reg_out[23] ),
    .CLK(clknet_leaf_115_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[24]$_DFF_P_  (.D(_0020_),
    .Q(\reg_out[24] ),
    .CLK(clknet_leaf_116_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[25]$_DFF_P_  (.D(_0021_),
    .Q(\reg_out[25] ),
    .CLK(clknet_leaf_112_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[26]$_DFF_P_  (.D(_0022_),
    .Q(\reg_out[26] ),
    .CLK(clknet_leaf_115_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[27]$_DFF_P_  (.D(_0023_),
    .Q(\reg_out[27] ),
    .CLK(clknet_leaf_115_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[28]$_DFF_P_  (.D(_0024_),
    .Q(\reg_out[28] ),
    .CLK(clknet_leaf_115_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[29]$_DFF_P_  (.D(_0025_),
    .Q(\reg_out[29] ),
    .CLK(clknet_leaf_118_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[2]$_DFF_P_  (.D(_0026_),
    .Q(\reg_out[2] ),
    .CLK(clknet_leaf_143_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[30]$_DFF_P_  (.D(_0027_),
    .Q(\reg_out[30] ),
    .CLK(clknet_leaf_118_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[31]$_DFF_P_  (.D(_0028_),
    .Q(\reg_out[31] ),
    .CLK(clknet_leaf_111_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[3]$_DFF_P_  (.D(_0029_),
    .Q(\reg_out[3] ),
    .CLK(clknet_leaf_142_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[4]$_DFF_P_  (.D(_0030_),
    .Q(\reg_out[4] ),
    .CLK(clknet_leaf_110_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[5]$_DFF_P_  (.D(_0031_),
    .Q(\reg_out[5] ),
    .CLK(clknet_leaf_143_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[6]$_DFF_P_  (.D(_0032_),
    .Q(\reg_out[6] ),
    .CLK(clknet_leaf_114_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[7]$_DFF_P_  (.D(_0033_),
    .Q(\reg_out[7] ),
    .CLK(clknet_leaf_110_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[8]$_DFF_P_  (.D(_0034_),
    .Q(\reg_out[8] ),
    .CLK(clknet_leaf_114_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_out[9]$_DFF_P_  (.D(_0035_),
    .Q(\reg_out[9] ),
    .CLK(clknet_leaf_109_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[10]$_SDFFE_PN0P_  (.D(_0730_),
    .Q(\reg_pc[10] ),
    .CLK(clknet_leaf_104_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[11]$_SDFFE_PN0P_  (.D(_0729_),
    .Q(\reg_pc[11] ),
    .CLK(clknet_leaf_104_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[12]$_SDFFE_PN0P_  (.D(_0728_),
    .Q(\reg_pc[12] ),
    .CLK(clknet_leaf_104_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[13]$_SDFFE_PN0P_  (.D(_0727_),
    .Q(\reg_pc[13] ),
    .CLK(clknet_leaf_114_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[14]$_SDFFE_PN0P_  (.D(_0726_),
    .Q(\reg_pc[14] ),
    .CLK(clknet_leaf_104_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[15]$_SDFFE_PN0P_  (.D(_0725_),
    .Q(\reg_pc[15] ),
    .CLK(clknet_leaf_103_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[16]$_SDFFE_PN0P_  (.D(_0724_),
    .Q(\reg_pc[16] ),
    .CLK(clknet_leaf_103_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[17]$_SDFFE_PN0P_  (.D(_0723_),
    .Q(\reg_pc[17] ),
    .CLK(clknet_leaf_105_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[18]$_SDFFE_PN0P_  (.D(_0722_),
    .Q(\reg_pc[18] ),
    .CLK(clknet_leaf_115_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[19]$_SDFFE_PN0P_  (.D(_0721_),
    .Q(\reg_pc[19] ),
    .CLK(clknet_leaf_110_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[1]$_SDFFE_PN0P_  (.D(_0739_),
    .Q(\reg_pc[1] ),
    .CLK(clknet_leaf_112_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[20]$_SDFFE_PN0P_  (.D(_0720_),
    .Q(\reg_pc[20] ),
    .CLK(clknet_leaf_110_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[21]$_SDFFE_PN0P_  (.D(_0719_),
    .Q(\reg_pc[21] ),
    .CLK(clknet_leaf_110_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[22]$_SDFFE_PN0P_  (.D(_0718_),
    .Q(\reg_pc[22] ),
    .CLK(clknet_leaf_111_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[23]$_SDFFE_PN0P_  (.D(_0717_),
    .Q(\reg_pc[23] ),
    .CLK(clknet_leaf_110_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[24]$_SDFFE_PN0P_  (.D(_0716_),
    .Q(\reg_pc[24] ),
    .CLK(clknet_leaf_104_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[25]$_SDFFE_PN0P_  (.D(_0715_),
    .Q(\reg_pc[25] ),
    .CLK(clknet_leaf_111_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[26]$_SDFFE_PN0P_  (.D(_0714_),
    .Q(\reg_pc[26] ),
    .CLK(clknet_leaf_111_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[27]$_SDFFE_PN0P_  (.D(_0713_),
    .Q(\reg_pc[27] ),
    .CLK(clknet_leaf_111_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[28]$_SDFFE_PN0P_  (.D(_0712_),
    .Q(\reg_pc[28] ),
    .CLK(clknet_leaf_142_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[29]$_SDFFE_PN0P_  (.D(_0711_),
    .Q(\reg_pc[29] ),
    .CLK(clknet_leaf_115_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[2]$_SDFFE_PN0P_  (.D(_0738_),
    .Q(\reg_pc[2] ),
    .CLK(clknet_leaf_111_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[30]$_SDFFE_PN0P_  (.D(_0710_),
    .Q(\reg_pc[30] ),
    .CLK(clknet_leaf_118_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[31]$_SDFFE_PN0P_  (.D(_0761_),
    .Q(\reg_pc[31] ),
    .CLK(clknet_leaf_111_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[3]$_SDFFE_PN0P_  (.D(_0737_),
    .Q(\reg_pc[3] ),
    .CLK(clknet_leaf_112_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[4]$_SDFFE_PN0P_  (.D(_0736_),
    .Q(\reg_pc[4] ),
    .CLK(clknet_leaf_110_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[5]$_SDFFE_PN0P_  (.D(_0735_),
    .Q(\reg_pc[5] ),
    .CLK(clknet_leaf_114_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[6]$_SDFFE_PN0P_  (.D(_0734_),
    .Q(\reg_pc[6] ),
    .CLK(clknet_leaf_113_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[7]$_SDFFE_PN0P_  (.D(_0733_),
    .Q(\reg_pc[7] ),
    .CLK(clknet_leaf_112_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[8]$_SDFFE_PN0P_  (.D(_0732_),
    .Q(\reg_pc[8] ),
    .CLK(clknet_leaf_105_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_pc[9]$_SDFFE_PN0P_  (.D(_0731_),
    .Q(\reg_pc[9] ),
    .CLK(clknet_leaf_113_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_sh[0]$_DFFE_PP_  (.D(_0036_),
    .DE(_0503_),
    .Q(\reg_sh[0] ),
    .CLK(clknet_leaf_147_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_sh[1]$_DFFE_PP_  (.D(_0037_),
    .DE(_0503_),
    .Q(\reg_sh[1] ),
    .CLK(clknet_leaf_147_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_sh[2]$_DFF_P_  (.D(_0038_),
    .Q(\reg_sh[2] ),
    .CLK(clknet_leaf_147_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_sh[3]$_DFF_P_  (.D(_0039_),
    .Q(\reg_sh[3] ),
    .CLK(clknet_leaf_147_clk));
 sky130_fd_sc_hd__dfxtp_1 \reg_sh[4]$_DFF_P_  (.D(_0040_),
    .Q(\reg_sh[4] ),
    .CLK(clknet_leaf_148_clk));
 sky130_fd_sc_hd__dfxtp_1 \trap$_SDFF_PN0_  (.D(_0775_),
    .Q(net364),
    .CLK(clknet_leaf_136_clk));
endmodule
