"
A MatchplayEventPrinterForHistoryPaneTest is a test class for testing the behavior of MatchplayEventPrinterForHistoryPane
"
Class {
	#name : #MatchplayEventPrinterForHistoryPaneTest,
	#superclass : #FMRTestCase,
	#category : #'FMR-Tests'
}

{ #category : #setup }
MatchplayEventPrinterForHistoryPaneTest >> expectedResult [
^'[1] @version[0.9]							
[2] @tournament[2021 Tornado Worlds]							
[3] @event[Open Doubles]							
[4] @match[WB Final]							
[5] @table[Tornado,black,yellow]							
[6] @teams[Robertson & Moore,Spredeman & Mehring]							
[7] @matchDate[31 August 2021]							
[8] @url[https://watch.insidefoos.com/videos/robertson-moore-vs-spredeman-mehring-open-doubles-wb-final]							
[9] @recorder[Dave Ziemann]							
[10] @lastSaveDate[16 November 2021]							
[11] 5			(0-0)		The ball is on Robertson & Moore''s 5-rod		
[12] .			(0-0)		The team with possession changed to Spredeman & Mehring		
[13] 5			(0-0)		The ball is on Spredeman & Mehring''s 5-rod		
[14] 3			(0-0)		The ball is on Spredeman & Mehring''s 3-rod		
[15] #			(0-1)		Spredeman & Mehring scored a goal		
[16] .			(0-1)		The team with possession changed to Robertson & Moore		
[17] 5			(0-1)		The ball is on Robertson & Moore''s 5-rod		
[18] .			(0-1)		The team with possession changed to Spredeman & Mehring		
[19] 2			(0-1)		The ball is on Spredeman & Mehring''s 2-rod		
[20] .			(0-1)		The team with possession changed to Robertson & Moore		
[21] 5			(0-1)		The ball is on Robertson & Moore''s 5-rod		
[22] .			(0-1)		The team with possession changed to Spredeman & Mehring		
[23] 2			(0-1)		The ball is on Spredeman & Mehring''s 2-rod		
[24] .			(0-1)		The team with possession changed to Robertson & Moore		
[25] 5			(0-1)		The ball is on Robertson & Moore''s 5-rod		
[26] 3			(0-1)		The ball is on Robertson & Moore''s 3-rod		
[27] .			(0-1)		The team with possession changed to Spredeman & Mehring		
[28] 2			(0-1)		The ball is on Spredeman & Mehring''s 2-rod		
[29] 3			(0-1)		The ball is on Spredeman & Mehring''s 3-rod		
[30] .			(0-1)		The team with possession changed to Robertson & Moore		
[31] 2			(0-1)		The ball is on Robertson & Moore''s 2-rod		
[32] .			(0-1)		The team with possession changed to Spredeman & Mehring		
[33] 2			(0-1)		The ball is on Spredeman & Mehring''s 2-rod		
[34] .			(0-1)		The team with possession changed to Robertson & Moore		
[35] 3			(0-1)		The ball is on Robertson & Moore''s 3-rod		
[36] #			(1-1)		Robertson & Moore scored a goal		
[37] >t			(1-1)		Spredeman & Mehring called a Time-out		
[38] .			(1-1)		The team with possession changed to Spredeman & Mehring		
[39] 5			(1-1)		The ball is on Spredeman & Mehring''s 5-rod		
[40] 3			(1-1)		The ball is on Spredeman & Mehring''s 3-rod		
[41] #			(1-2)		Spredeman & Mehring scored a goal		
[42] .			(1-2)		The team with possession changed to Robertson & Moore		
[43] 5			(1-2)		The ball is on Robertson & Moore''s 5-rod		
[44] .			(1-2)		The team with possession changed to Spredeman & Mehring		
[45] 5			(1-2)		The ball is on Spredeman & Mehring''s 5-rod		
[46] .			(1-2)		The team with possession changed to Robertson & Moore		
[47] 5			(1-2)		The ball is on Robertson & Moore''s 5-rod		
[48] 3			(1-2)		The ball is on Robertson & Moore''s 3-rod		
[49] #			(2-2)		Robertson & Moore scored a goal		
[50] .			(2-2)		The team with possession changed to Spredeman & Mehring		
[51] 5			(2-2)		The ball is on Spredeman & Mehring''s 5-rod		
[52] .			(2-2)		The team with possession changed to Robertson & Moore		
[53] 5			(2-2)		The ball is on Robertson & Moore''s 5-rod		
[54] .			(2-2)		The team with possession changed to Spredeman & Mehring		
[55] 5			(2-2)		The ball is on Spredeman & Mehring''s 5-rod		
[56] .			(2-2)		The team with possession changed to Robertson & Moore		
[57] 5			(2-2)		The ball is on Robertson & Moore''s 5-rod		
[58] .			(2-2)		The team with possession changed to Spredeman & Mehring		
[59] 5			(2-2)		The ball is on Spredeman & Mehring''s 5-rod		
[60] .			(2-2)		The team with possession changed to Robertson & Moore		
[61] 5			(2-2)		The ball is on Robertson & Moore''s 5-rod		
[62] .			(2-2)		The team with possession changed to Spredeman & Mehring		
[63] 5			(2-2)		The ball is on Spredeman & Mehring''s 5-rod		
[64] 3			(2-2)		The ball is on Spredeman & Mehring''s 3-rod		
[65] .			(2-2)		The team with possession changed to Robertson & Moore		
[66] 2			(2-2)		The ball is on Robertson & Moore''s 2-rod		
[67] .			(2-2)		The team with possession changed to Spredeman & Mehring		
[68] 2			(2-2)		The ball is on Spredeman & Mehring''s 2-rod		
[69] .			(2-2)		The team with possession changed to Robertson & Moore		
[70] 3			(2-2)		The ball is on Robertson & Moore''s 3-rod		
[71] #			(3-2)		Robertson & Moore scored a goal		
[72] .			(3-2)		The team with possession changed to Spredeman & Mehring		
[73] 5			(3-2)		The ball is on Spredeman & Mehring''s 5-rod		
[74] 3			(3-2)		The ball is on Spredeman & Mehring''s 3-rod		
[75] .			(3-2)		The team with possession changed to Robertson & Moore		
[76] 3			(3-2)		The ball is on Robertson & Moore''s 3-rod		
[77] .			(3-2)		The team with possession changed to Spredeman & Mehring		
[78] 5			(3-2)		The ball is on Spredeman & Mehring''s 5-rod		
[79] .			(3-2)		The team with possession changed to Robertson & Moore		
[80] 5			(3-2)		The ball is on Robertson & Moore''s 5-rod		
[81] t			(3-2)		Robertson & Moore called a Time-out		
[82] 5			(3-2)		The ball is on Robertson & Moore''s 5-rod		
[83] 3			(3-2)		The ball is on Robertson & Moore''s 3-rod		
[84] #			(4-2)		Robertson & Moore scored a goal		
[85] .			(4-2)		The team with possession changed to Spredeman & Mehring		
[86] 5			(4-2)		The ball is on Spredeman & Mehring''s 5-rod		
[87] 3			(4-2)		The ball is on Spredeman & Mehring''s 3-rod		
[88] .			(4-2)		The team with possession changed to Robertson & Moore		
[89] 2			(4-2)		The ball is on Robertson & Moore''s 2-rod		
[90] ^			(4-2)		Robertson & Moore shot the ball off the table from their 2-rod		
[91] 2			(4-2)		The ball is on Robertson & Moore''s 2-rod		
[92] .			(4-2)		The team with possession changed to Spredeman & Mehring		
[93] 3			(4-2)		The ball is on Spredeman & Mehring''s 3-rod		
[94] 5			(4-2)		The ball is on Spredeman & Mehring''s 5-rod		
[95] .			(4-2)		The team with possession changed to Robertson & Moore		
[96] 5			(4-2)		The ball is on Robertson & Moore''s 5-rod		
[97] 3			(4-2)		The ball is on Robertson & Moore''s 3-rod		
[98] #			(5-2)		Robertson & Moore scored a goal		
[99] /			[5-2]		The end of game 1		
[100] .			[5-2],(0-0)		The team with possession changed to Spredeman & Mehring		
[101] 5			[5-2],(0-0)		The ball is on Spredeman & Mehring''s 5-rod		
[102] 3			[5-2],(0-0)		The ball is on Spredeman & Mehring''s 3-rod		
[103] .			[5-2],(0-0)		The team with possession changed to Robertson & Moore		
[104] 2			[5-2],(0-0)		The ball is on Robertson & Moore''s 2-rod		
[105] .			[5-2],(0-0)		The team with possession changed to Spredeman & Mehring		
[106] 2			[5-2],(0-0)		The ball is on Spredeman & Mehring''s 2-rod		
[107] .			[5-2],(0-0)		The team with possession changed to Robertson & Moore		
[108] 5			[5-2],(0-0)		The ball is on Robertson & Moore''s 5-rod		
[109] .			[5-2],(0-0)		The team with possession changed to Spredeman & Mehring		
[110] 5			[5-2],(0-0)		The ball is on Spredeman & Mehring''s 5-rod		
[111] 3			[5-2],(0-0)		The ball is on Spredeman & Mehring''s 3-rod		
[112] #			[5-2],(0-1)		Spredeman & Mehring scored a goal		
[113] .			[5-2],(0-1)		The team with possession changed to Robertson & Moore		
[114] 5			[5-2],(0-1)		The ball is on Robertson & Moore''s 5-rod		
[115] 3			[5-2],(0-1)		The ball is on Robertson & Moore''s 3-rod		
[116] .			[5-2],(0-1)		The team with possession changed to Spredeman & Mehring		
[117] 2			[5-2],(0-1)		The ball is on Spredeman & Mehring''s 2-rod		
[118] .			[5-2],(0-1)		The team with possession changed to Robertson & Moore		
[119] 3			[5-2],(0-1)		The ball is on Robertson & Moore''s 3-rod		
[120] .			[5-2],(0-1)		The team with possession changed to Spredeman & Mehring		
[121] 2			[5-2],(0-1)		The ball is on Spredeman & Mehring''s 2-rod		
[122] .			[5-2],(0-1)		The team with possession changed to Robertson & Moore		
[123] 3			[5-2],(0-1)		The ball is on Robertson & Moore''s 3-rod		
[124] .			[5-2],(0-1)		The team with possession changed to Spredeman & Mehring		
[125] 2			[5-2],(0-1)		The ball is on Spredeman & Mehring''s 2-rod		
[126] 3			[5-2],(0-1)		The ball is on Spredeman & Mehring''s 3-rod		
[127] #			[5-2],(0-2)		Spredeman & Mehring scored a goal		
[128] .			[5-2],(0-2)		The team with possession changed to Robertson & Moore		
[129] 5			[5-2],(0-2)		The ball is on Robertson & Moore''s 5-rod		
[130] 3			[5-2],(0-2)		The ball is on Robertson & Moore''s 3-rod		
[131] #			[5-2],(1-2)		Robertson & Moore scored a goal		
[132] .			[5-2],(1-2)		The team with possession changed to Spredeman & Mehring		
[133] 5			[5-2],(1-2)		The ball is on Spredeman & Mehring''s 5-rod		
[134] 3			[5-2],(1-2)		The ball is on Spredeman & Mehring''s 3-rod		
[135] #			[5-2],(1-3)		Spredeman & Mehring scored a goal		
[136] .			[5-2],(1-3)		The team with possession changed to Robertson & Moore		
[137] 5			[5-2],(1-3)		The ball is on Robertson & Moore''s 5-rod		
[138] 3			[5-2],(1-3)		The ball is on Robertson & Moore''s 3-rod		
[139] .			[5-2],(1-3)		The team with possession changed to Spredeman & Mehring		
[140] 2			[5-2],(1-3)		The ball is on Spredeman & Mehring''s 2-rod		
[141] 3			[5-2],(1-3)		The ball is on Spredeman & Mehring''s 3-rod		
[142] t			[5-2],(1-3)		Spredeman & Mehring called a Time-out		
[143] 3			[5-2],(1-3)		The ball is on Spredeman & Mehring''s 3-rod		
[144] .			[5-2],(1-3)		The team with possession changed to Robertson & Moore		
[145] 2			[5-2],(1-3)		The ball is on Robertson & Moore''s 2-rod		
[146] .			[5-2],(1-3)		The team with possession changed to Spredeman & Mehring		
[147] 5			[5-2],(1-3)		The ball is on Spredeman & Mehring''s 5-rod		
[148] .			[5-2],(1-3)		The team with possession changed to Robertson & Moore		
[149] 2			[5-2],(1-3)		The ball is on Robertson & Moore''s 2-rod		
[150] .			[5-2],(1-3)		The team with possession changed to Spredeman & Mehring		
[151] 5			[5-2],(1-3)		The ball is on Spredeman & Mehring''s 5-rod		
[152] .			[5-2],(1-3)		The team with possession changed to Robertson & Moore		
[153] 5			[5-2],(1-3)		The ball is on Robertson & Moore''s 5-rod		
[154] .			[5-2],(1-3)		The team with possession changed to Spredeman & Mehring		
[155] 5			[5-2],(1-3)		The ball is on Spredeman & Mehring''s 5-rod		
[156] #			[5-2],(1-4)		Spredeman & Mehring scored a goal		
[157] .			[5-2],(1-4)		The team with possession changed to Robertson & Moore		
[158] 5			[5-2],(1-4)		The ball is on Robertson & Moore''s 5-rod		
[159] 3			[5-2],(1-4)		The ball is on Robertson & Moore''s 3-rod		
[160] #			[5-2],(2-4)		Robertson & Moore scored a goal		
[161] .			[5-2],(2-4)		The team with possession changed to Spredeman & Mehring		
[162] 5			[5-2],(2-4)		The ball is on Spredeman & Mehring''s 5-rod		
[163] .			[5-2],(2-4)		The team with possession changed to Robertson & Moore		
[164] 5			[5-2],(2-4)		The ball is on Robertson & Moore''s 5-rod		
[165] 3			[5-2],(2-4)		The ball is on Robertson & Moore''s 3-rod		
[166] #			[5-2],(3-4)		Robertson & Moore scored a goal		
[167] .			[5-2],(3-4)		The team with possession changed to Spredeman & Mehring		
[168] 5			[5-2],(3-4)		The ball is on Spredeman & Mehring''s 5-rod		
[169] 3			[5-2],(3-4)		The ball is on Spredeman & Mehring''s 3-rod		
[170] .			[5-2],(3-4)		The team with possession changed to Robertson & Moore		
[171] 2			[5-2],(3-4)		The ball is on Robertson & Moore''s 2-rod		
[172] .			[5-2],(3-4)		The team with possession changed to Spredeman & Mehring		
[173] 5			[5-2],(3-4)		The ball is on Spredeman & Mehring''s 5-rod		
[174] .			[5-2],(3-4)		The team with possession changed to Robertson & Moore		
[175] 2			[5-2],(3-4)		The ball is on Robertson & Moore''s 2-rod		
[176] .			[5-2],(3-4)		The team with possession changed to Spredeman & Mehring		
[177] 2			[5-2],(3-4)		The ball is on Spredeman & Mehring''s 2-rod		
[178] .			[5-2],(3-4)		The team with possession changed to Robertson & Moore		
[179] 5			[5-2],(3-4)		The ball is on Robertson & Moore''s 5-rod		
[180] 3			[5-2],(3-4)		The ball is on Robertson & Moore''s 3-rod		
[181] .			[5-2],(3-4)		The team with possession changed to Spredeman & Mehring		
[182] 2			[5-2],(3-4)		The ball is on Spredeman & Mehring''s 2-rod		
[183] .			[5-2],(3-4)		The team with possession changed to Robertson & Moore		
[184] #			[5-2],(4-4)		Robertson & Moore scored a goal		
[185] .			[5-2],(4-4)		The team with possession changed to Spredeman & Mehring		
[186] 5			[5-2],(4-4)		The ball is on Spredeman & Mehring''s 5-rod		
[187] .			[5-2],(4-4)		The team with possession changed to Robertson & Moore		
[188] 5			[5-2],(4-4)		The ball is on Robertson & Moore''s 5-rod		
[189] 3			[5-2],(4-4)		The ball is on Robertson & Moore''s 3-rod		
[190] #			[5-2],(5-4)		Robertson & Moore scored a goal		
[191] /			[5-2],[5-4]		The end of game 2		
[192] .			[5-2],[5-4],(0-0)		The team with possession changed to Spredeman & Mehring		
[193] 5			[5-2],[5-4],(0-0)		The ball is on Spredeman & Mehring''s 5-rod		
[194] .			[5-2],[5-4],(0-0)		The team with possession changed to Robertson & Moore		
[195] 5			[5-2],[5-4],(0-0)		The ball is on Robertson & Moore''s 5-rod		
[196] .			[5-2],[5-4],(0-0)		The team with possession changed to Spredeman & Mehring		
[197] 5			[5-2],[5-4],(0-0)		The ball is on Spredeman & Mehring''s 5-rod		
[198] 3			[5-2],[5-4],(0-0)		The ball is on Spredeman & Mehring''s 3-rod		
[199] #			[5-2],[5-4],(0-1)		Spredeman & Mehring scored a goal		
[200] .			[5-2],[5-4],(0-1)		The team with possession changed to Robertson & Moore		
[201] 5			[5-2],[5-4],(0-1)		The ball is on Robertson & Moore''s 5-rod		
[202] 3			[5-2],[5-4],(0-1)		The ball is on Robertson & Moore''s 3-rod		
[203] #			[5-2],[5-4],(1-1)		Robertson & Moore scored a goal		
[204] .			[5-2],[5-4],(1-1)		The team with possession changed to Spredeman & Mehring		
[205] 5			[5-2],[5-4],(1-1)		The ball is on Spredeman & Mehring''s 5-rod		
[206] .			[5-2],[5-4],(1-1)		The team with possession changed to Robertson & Moore		
[207] 2			[5-2],[5-4],(1-1)		The ball is on Robertson & Moore''s 2-rod		
[208] .			[5-2],[5-4],(1-1)		The team with possession changed to Spredeman & Mehring		
[209] 5			[5-2],[5-4],(1-1)		The ball is on Spredeman & Mehring''s 5-rod		
[210] .			[5-2],[5-4],(1-1)		The team with possession changed to Robertson & Moore		
[211] 5			[5-2],[5-4],(1-1)		The ball is on Robertson & Moore''s 5-rod		
[212] .			[5-2],[5-4],(1-1)		The team with possession changed to Spredeman & Mehring		
[213] 5			[5-2],[5-4],(1-1)		The ball is on Spredeman & Mehring''s 5-rod		
[214] 3			[5-2],[5-4],(1-1)		The ball is on Spredeman & Mehring''s 3-rod		
[215] .			[5-2],[5-4],(1-1)		The team with possession changed to Robertson & Moore		
[216] 5			[5-2],[5-4],(1-1)		The ball is on Robertson & Moore''s 5-rod		
[217] 3			[5-2],[5-4],(1-1)		The ball is on Robertson & Moore''s 3-rod		
[218] .			[5-2],[5-4],(1-1)		The team with possession changed to Spredeman & Mehring		
[219] 2			[5-2],[5-4],(1-1)		The ball is on Spredeman & Mehring''s 2-rod		
[220] 3			[5-2],[5-4],(1-1)		The ball is on Spredeman & Mehring''s 3-rod		
[221] .			[5-2],[5-4],(1-1)		The team with possession changed to Robertson & Moore		
[222] 2			[5-2],[5-4],(1-1)		The ball is on Robertson & Moore''s 2-rod		
[223] 3			[5-2],[5-4],(1-1)		The ball is on Robertson & Moore''s 3-rod		
[224] #			[5-2],[5-4],(2-1)		Robertson & Moore scored a goal		
[225] .			[5-2],[5-4],(2-1)		The team with possession changed to Spredeman & Mehring		
[226] 5			[5-2],[5-4],(2-1)		The ball is on Spredeman & Mehring''s 5-rod		
[227] 3			[5-2],[5-4],(2-1)		The ball is on Spredeman & Mehring''s 3-rod		
[228] #			[5-2],[5-4],(2-2)		Spredeman & Mehring scored a goal		
[229] .			[5-2],[5-4],(2-2)		The team with possession changed to Robertson & Moore		
[230] 5			[5-2],[5-4],(2-2)		The ball is on Robertson & Moore''s 5-rod		
[231] .			[5-2],[5-4],(2-2)		The team with possession changed to Spredeman & Mehring		
[232] 5			[5-2],[5-4],(2-2)		The ball is on Spredeman & Mehring''s 5-rod		
[233] 3			[5-2],[5-4],(2-2)		The ball is on Spredeman & Mehring''s 3-rod		
[234] #			[5-2],[5-4],(2-3)		Spredeman & Mehring scored a goal		
[235] .			[5-2],[5-4],(2-3)		The team with possession changed to Robertson & Moore		
[236] 5			[5-2],[5-4],(2-3)		The ball is on Robertson & Moore''s 5-rod		
[237] .			[5-2],[5-4],(2-3)		The team with possession changed to Spredeman & Mehring		
[238] 5			[5-2],[5-4],(2-3)		The ball is on Spredeman & Mehring''s 5-rod		
[239] .			[5-2],[5-4],(2-3)		The team with possession changed to Robertson & Moore		
[240] 5			[5-2],[5-4],(2-3)		The ball is on Robertson & Moore''s 5-rod		
[241] 3			[5-2],[5-4],(2-3)		The ball is on Robertson & Moore''s 3-rod		
[242] .			[5-2],[5-4],(2-3)		The team with possession changed to Spredeman & Mehring		
[243] 2			[5-2],[5-4],(2-3)		The ball is on Spredeman & Mehring''s 2-rod		
[244] 3			[5-2],[5-4],(2-3)		The ball is on Spredeman & Mehring''s 3-rod		
[245] #			[5-2],[5-4],(2-4)		Spredeman & Mehring scored a goal		
[246] >t			[5-2],[5-4],(2-4)		Spredeman & Mehring called a Time-out		
[247] .			[5-2],[5-4],(2-4)		The team with possession changed to Robertson & Moore		
[248] 5			[5-2],[5-4],(2-4)		The ball is on Robertson & Moore''s 5-rod		
[249] 2			[5-2],[5-4],(2-4)		The ball is on Robertson & Moore''s 2-rod		
[250] .			[5-2],[5-4],(2-4)		The team with possession changed to Spredeman & Mehring		
[251] 2			[5-2],[5-4],(2-4)		The ball is on Spredeman & Mehring''s 2-rod		
[252] 3			[5-2],[5-4],(2-4)		The ball is on Spredeman & Mehring''s 3-rod		
[253] .			[5-2],[5-4],(2-4)		The team with possession changed to Robertson & Moore		
[254] 2			[5-2],[5-4],(2-4)		The ball is on Robertson & Moore''s 2-rod		
[255] .			[5-2],[5-4],(2-4)		The team with possession changed to Spredeman & Mehring		
[256] 5			[5-2],[5-4],(2-4)		The ball is on Spredeman & Mehring''s 5-rod		
[257] 3			[5-2],[5-4],(2-4)		The ball is on Spredeman & Mehring''s 3-rod		
[258] #			[5-2],[5-4],(2-5)		Spredeman & Mehring scored a goal		
[259] /			[5-2],[5-4],[2-5]		The end of game 3		
[260] .			[5-2],[5-4],[2-5],(0-0)		The team with possession changed to Robertson & Moore		
[261] 5			[5-2],[5-4],[2-5],(0-0)		The ball is on Robertson & Moore''s 5-rod		
[262] .			[5-2],[5-4],[2-5],(0-0)		The team with possession changed to Spredeman & Mehring		
[263] 5			[5-2],[5-4],[2-5],(0-0)		The ball is on Spredeman & Mehring''s 5-rod		
[264] .			[5-2],[5-4],[2-5],(0-0)		The team with possession changed to Robertson & Moore		
[265] 5			[5-2],[5-4],[2-5],(0-0)		The ball is on Robertson & Moore''s 5-rod		
[266] 3			[5-2],[5-4],[2-5],(0-0)		The ball is on Robertson & Moore''s 3-rod		
[267] #			[5-2],[5-4],[2-5],(1-0)		Robertson & Moore scored a goal		
[268] .			[5-2],[5-4],[2-5],(1-0)		The team with possession changed to Spredeman & Mehring		
[269] 5			[5-2],[5-4],[2-5],(1-0)		The ball is on Spredeman & Mehring''s 5-rod		
[270] 3			[5-2],[5-4],[2-5],(1-0)		The ball is on Spredeman & Mehring''s 3-rod		
[271] .			[5-2],[5-4],[2-5],(1-0)		The team with possession changed to Robertson & Moore		
[272] 2			[5-2],[5-4],[2-5],(1-0)		The ball is on Robertson & Moore''s 2-rod		
[273] .			[5-2],[5-4],[2-5],(1-0)		The team with possession changed to Spredeman & Mehring		
[274] 5			[5-2],[5-4],[2-5],(1-0)		The ball is on Spredeman & Mehring''s 5-rod		
[275] 3			[5-2],[5-4],[2-5],(1-0)		The ball is on Spredeman & Mehring''s 3-rod		
[276] #			[5-2],[5-4],[2-5],(1-1)		Spredeman & Mehring scored a goal		
[277] .			[5-2],[5-4],[2-5],(1-1)		The team with possession changed to Robertson & Moore		
[278] 5			[5-2],[5-4],[2-5],(1-1)		The ball is on Robertson & Moore''s 5-rod		
[279] .			[5-2],[5-4],[2-5],(1-1)		The team with possession changed to Spredeman & Mehring		
[280] 5			[5-2],[5-4],[2-5],(1-1)		The ball is on Spredeman & Mehring''s 5-rod		
[281] .			[5-2],[5-4],[2-5],(1-1)		The team with possession changed to Robertson & Moore		
[282] 5			[5-2],[5-4],[2-5],(1-1)		The ball is on Robertson & Moore''s 5-rod		
[283] 3			[5-2],[5-4],[2-5],(1-1)		The ball is on Robertson & Moore''s 3-rod		
[284] .			[5-2],[5-4],[2-5],(1-1)		The team with possession changed to Spredeman & Mehring		
[285] 2			[5-2],[5-4],[2-5],(1-1)		The ball is on Spredeman & Mehring''s 2-rod		
[286] .			[5-2],[5-4],[2-5],(1-1)		The team with possession changed to Robertson & Moore		
[287] 3			[5-2],[5-4],[2-5],(1-1)		The ball is on Robertson & Moore''s 3-rod		
[288] .			[5-2],[5-4],[2-5],(1-1)		The team with possession changed to Spredeman & Mehring		
[289] 2			[5-2],[5-4],[2-5],(1-1)		The ball is on Spredeman & Mehring''s 2-rod		
[290] .			[5-2],[5-4],[2-5],(1-1)		The team with possession changed to Robertson & Moore		
[291] 3			[5-2],[5-4],[2-5],(1-1)		The ball is on Robertson & Moore''s 3-rod		
[292] .			[5-2],[5-4],[2-5],(1-1)		The team with possession changed to Spredeman & Mehring		
[293] 2			[5-2],[5-4],[2-5],(1-1)		The ball is on Spredeman & Mehring''s 2-rod		
[294] ^			[5-2],[5-4],[2-5],(1-1)		Spredeman & Mehring shot the ball off the table from their 2-rod		
[295] 2			[5-2],[5-4],[2-5],(1-1)		The ball is on Spredeman & Mehring''s 2-rod		
[296] .			[5-2],[5-4],[2-5],(1-1)		The team with possession changed to Robertson & Moore		
[297] 3			[5-2],[5-4],[2-5],(1-1)		The ball is on Robertson & Moore''s 3-rod		
[298] #			[5-2],[5-4],[2-5],(2-1)		Robertson & Moore scored a goal		
[299] .			[5-2],[5-4],[2-5],(2-1)		The team with possession changed to Spredeman & Mehring		
[300] 5			[5-2],[5-4],[2-5],(2-1)		The ball is on Spredeman & Mehring''s 5-rod		
[301] 3			[5-2],[5-4],[2-5],(2-1)		The ball is on Spredeman & Mehring''s 3-rod		
[302] .			[5-2],[5-4],[2-5],(2-1)		The team with possession changed to Robertson & Moore		
[303] 2			[5-2],[5-4],[2-5],(2-1)		The ball is on Robertson & Moore''s 2-rod		
[304] .			[5-2],[5-4],[2-5],(2-1)		The team with possession changed to Spredeman & Mehring		
[305] 3			[5-2],[5-4],[2-5],(2-1)		The ball is on Spredeman & Mehring''s 3-rod		
[306] #			[5-2],[5-4],[2-5],(2-2)		Spredeman & Mehring scored a goal		
[307] .			[5-2],[5-4],[2-5],(2-2)		The team with possession changed to Robertson & Moore		
[308] 5			[5-2],[5-4],[2-5],(2-2)		The ball is on Robertson & Moore''s 5-rod		
[309] .			[5-2],[5-4],[2-5],(2-2)		The team with possession changed to Spredeman & Mehring		
[310] 2			[5-2],[5-4],[2-5],(2-2)		The ball is on Spredeman & Mehring''s 2-rod		
[311] .			[5-2],[5-4],[2-5],(2-2)		The team with possession changed to Robertson & Moore		
[312] 3			[5-2],[5-4],[2-5],(2-2)		The ball is on Robertson & Moore''s 3-rod		
[313] .			[5-2],[5-4],[2-5],(2-2)		The team with possession changed to Spredeman & Mehring		
[314] 5			[5-2],[5-4],[2-5],(2-2)		The ball is on Spredeman & Mehring''s 5-rod		
[315] 3			[5-2],[5-4],[2-5],(2-2)		The ball is on Spredeman & Mehring''s 3-rod		
[316] #			[5-2],[5-4],[2-5],(2-3)		Spredeman & Mehring scored a goal		
[317] .			[5-2],[5-4],[2-5],(2-3)		The team with possession changed to Robertson & Moore		
[318] 5			[5-2],[5-4],[2-5],(2-3)		The ball is on Robertson & Moore''s 5-rod		
[319] 3			[5-2],[5-4],[2-5],(2-3)		The ball is on Robertson & Moore''s 3-rod		
[320] t			[5-2],[5-4],[2-5],(2-3)		Robertson & Moore called a Time-out		
[321] >:[Tony goes back]			[5-2],[5-4],[2-5],(2-3)		Spredeman & Mehring swapped positions (Mehring is now forward)		
[322] <t			[5-2],[5-4],[2-5],(2-3)		Robertson & Moore called a Time-out		
[323] 3			[5-2],[5-4],[2-5],(2-3)		The ball is on Robertson & Moore''s 3-rod		
[324] #			[5-2],[5-4],[2-5],(3-3)		Robertson & Moore scored a goal		
[325] >:[Tony back to forward]			[5-2],[5-4],[2-5],(3-3)		Spredeman & Mehring swapped positions (Spredeman is now forward)		
[326] .			[5-2],[5-4],[2-5],(3-3)		The team with possession changed to Spredeman & Mehring		
[327] 5			[5-2],[5-4],[2-5],(3-3)		The ball is on Spredeman & Mehring''s 5-rod		
[328] .			[5-2],[5-4],[2-5],(3-3)		The team with possession changed to Robertson & Moore		
[329] 5			[5-2],[5-4],[2-5],(3-3)		The ball is on Robertson & Moore''s 5-rod		
[330] 3			[5-2],[5-4],[2-5],(3-3)		The ball is on Robertson & Moore''s 3-rod		
[331] .			[5-2],[5-4],[2-5],(3-3)		The team with possession changed to Spredeman & Mehring		
[332] 2			[5-2],[5-4],[2-5],(3-3)		The ball is on Spredeman & Mehring''s 2-rod		
[333] .			[5-2],[5-4],[2-5],(3-3)		The team with possession changed to Robertson & Moore		
[334] 3			[5-2],[5-4],[2-5],(3-3)		The ball is on Robertson & Moore''s 3-rod		
[335] 2			[5-2],[5-4],[2-5],(3-3)		The ball is on Robertson & Moore''s 2-rod		
[336] .			[5-2],[5-4],[2-5],(3-3)		The team with possession changed to Spredeman & Mehring		
[337] #			[5-2],[5-4],[2-5],(3-4)		Spredeman & Mehring scored a goal		
[338] .			[5-2],[5-4],[2-5],(3-4)		The team with possession changed to Robertson & Moore		
[339] 5			[5-2],[5-4],[2-5],(3-4)		The ball is on Robertson & Moore''s 5-rod		
[340] .			[5-2],[5-4],[2-5],(3-4)		The team with possession changed to Spredeman & Mehring		
[341] 5			[5-2],[5-4],[2-5],(3-4)		The ball is on Spredeman & Mehring''s 5-rod		
[342] 3			[5-2],[5-4],[2-5],(3-4)		The ball is on Spredeman & Mehring''s 3-rod		
[343] #			[5-2],[5-4],[2-5],(3-5)		Spredeman & Mehring scored a goal		
[344] /			[5-2],[5-4],[2-5],[3-5]		The end of game 4		
[345] .			[5-2],[5-4],[2-5],[3-5],(0-0)		The team with possession changed to Robertson & Moore		
[346] 5			[5-2],[5-4],[2-5],[3-5],(0-0)		The ball is on Robertson & Moore''s 5-rod		
[347] 3			[5-2],[5-4],[2-5],[3-5],(0-0)		The ball is on Robertson & Moore''s 3-rod		
[348] #			[5-2],[5-4],[2-5],[3-5],(1-0)		Robertson & Moore scored a goal		
[349] .			[5-2],[5-4],[2-5],[3-5],(1-0)		The team with possession changed to Spredeman & Mehring		
[350] 5			[5-2],[5-4],[2-5],[3-5],(1-0)		The ball is on Spredeman & Mehring''s 5-rod		
[351] 3			[5-2],[5-4],[2-5],[3-5],(1-0)		The ball is on Spredeman & Mehring''s 3-rod		
[352] #			[5-2],[5-4],[2-5],[3-5],(1-1)		Spredeman & Mehring scored a goal		
[353] .			[5-2],[5-4],[2-5],[3-5],(1-1)		The team with possession changed to Robertson & Moore		
[354] 5			[5-2],[5-4],[2-5],[3-5],(1-1)		The ball is on Robertson & Moore''s 5-rod		
[355] 3			[5-2],[5-4],[2-5],[3-5],(1-1)		The ball is on Robertson & Moore''s 3-rod		
[356] .			[5-2],[5-4],[2-5],[3-5],(1-1)		The team with possession changed to Spredeman & Mehring		
[357] 2			[5-2],[5-4],[2-5],[3-5],(1-1)		The ball is on Spredeman & Mehring''s 2-rod		
[358] .			[5-2],[5-4],[2-5],[3-5],(1-1)		The team with possession changed to Robertson & Moore		
[359] 3			[5-2],[5-4],[2-5],[3-5],(1-1)		The ball is on Robertson & Moore''s 3-rod		
[360] #			[5-2],[5-4],[2-5],[3-5],(2-1)		Robertson & Moore scored a goal		
[361] .			[5-2],[5-4],[2-5],[3-5],(2-1)		The team with possession changed to Spredeman & Mehring		
[362] 5			[5-2],[5-4],[2-5],[3-5],(2-1)		The ball is on Spredeman & Mehring''s 5-rod		
[363] 3			[5-2],[5-4],[2-5],[3-5],(2-1)		The ball is on Spredeman & Mehring''s 3-rod		
[364] .			[5-2],[5-4],[2-5],[3-5],(2-1)		The team with possession changed to Robertson & Moore		
[365] 2			[5-2],[5-4],[2-5],[3-5],(2-1)		The ball is on Robertson & Moore''s 2-rod		
[366] 3			[5-2],[5-4],[2-5],[3-5],(2-1)		The ball is on Robertson & Moore''s 3-rod		
[367] #			[5-2],[5-4],[2-5],[3-5],(3-1)		Robertson & Moore scored a goal		
[368] .			[5-2],[5-4],[2-5],[3-5],(3-1)		The team with possession changed to Spredeman & Mehring		
[369] 5			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Spredeman & Mehring''s 5-rod		
[370] .			[5-2],[5-4],[2-5],[3-5],(3-1)		The team with possession changed to Robertson & Moore		
[371] 2			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Robertson & Moore''s 2-rod		
[372] .			[5-2],[5-4],[2-5],[3-5],(3-1)		The team with possession changed to Spredeman & Mehring		
[373] 3			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Spredeman & Mehring''s 3-rod		
[374] .			[5-2],[5-4],[2-5],[3-5],(3-1)		The team with possession changed to Robertson & Moore		
[375] 2			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Robertson & Moore''s 2-rod		
[376] s[Discussing a possible jar]			[5-2],[5-4],[2-5],[3-5],(3-1)		There was a stoppage of play		
[377] <![Jar called]			[5-2],[5-4],[2-5],[3-5],(3-1)		There was a rule infraction by Robertson & Moore		
[378] .			[5-2],[5-4],[2-5],[3-5],(3-1)		The team with possession changed to Spredeman & Mehring		
[379] 5			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Spredeman & Mehring''s 5-rod		
[380] .			[5-2],[5-4],[2-5],[3-5],(3-1)		The team with possession changed to Robertson & Moore		
[381] 5			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Robertson & Moore''s 5-rod		
[382] .			[5-2],[5-4],[2-5],[3-5],(3-1)		The team with possession changed to Spredeman & Mehring		
[383] 5			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Spredeman & Mehring''s 5-rod		
[384] 3			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Spredeman & Mehring''s 3-rod		
[385] t			[5-2],[5-4],[2-5],[3-5],(3-1)		Spredeman & Mehring called a Time-out		
[386] 3			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Spredeman & Mehring''s 3-rod		
[387] .			[5-2],[5-4],[2-5],[3-5],(3-1)		The team with possession changed to Robertson & Moore		
[388] 2			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Robertson & Moore''s 2-rod		
[389] .			[5-2],[5-4],[2-5],[3-5],(3-1)		The team with possession changed to Spredeman & Mehring		
[390] 5			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Spredeman & Mehring''s 5-rod		
[391] .			[5-2],[5-4],[2-5],[3-5],(3-1)		The team with possession changed to Robertson & Moore		
[392] 5			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Robertson & Moore''s 5-rod		
[393] 3			[5-2],[5-4],[2-5],[3-5],(3-1)		The ball is on Robertson & Moore''s 3-rod		
[394] #			[5-2],[5-4],[2-5],[3-5],(4-1)		Robertson & Moore scored a goal		
[395] .			[5-2],[5-4],[2-5],[3-5],(4-1)		The team with possession changed to Spredeman & Mehring		
[396] 5			[5-2],[5-4],[2-5],[3-5],(4-1)		The ball is on Spredeman & Mehring''s 5-rod		
[397] .			[5-2],[5-4],[2-5],[3-5],(4-1)		The team with possession changed to Robertson & Moore		
[398] 5			[5-2],[5-4],[2-5],[3-5],(4-1)		The ball is on Robertson & Moore''s 5-rod		
[399] .			[5-2],[5-4],[2-5],[3-5],(4-1)		The team with possession changed to Spredeman & Mehring		
[400] 2			[5-2],[5-4],[2-5],[3-5],(4-1)		The ball is on Spredeman & Mehring''s 2-rod		
[401] 5			[5-2],[5-4],[2-5],[3-5],(4-1)		The ball is on Spredeman & Mehring''s 5-rod		
[402] 3			[5-2],[5-4],[2-5],[3-5],(4-1)		The ball is on Spredeman & Mehring''s 3-rod		
[403] .			[5-2],[5-4],[2-5],[3-5],(4-1)		The team with possession changed to Robertson & Moore		
[404] 2			[5-2],[5-4],[2-5],[3-5],(4-1)		The ball is on Robertson & Moore''s 2-rod		
[405] ^			[5-2],[5-4],[2-5],[3-5],(4-1)		Robertson & Moore shot the ball off the table from their 2-rod		
[406] 2			[5-2],[5-4],[2-5],[3-5],(4-1)		The ball is on Robertson & Moore''s 2-rod		
[407] .			[5-2],[5-4],[2-5],[3-5],(4-1)		The team with possession changed to Spredeman & Mehring		
[408] 5			[5-2],[5-4],[2-5],[3-5],(4-1)		The ball is on Spredeman & Mehring''s 5-rod		
[409] .			[5-2],[5-4],[2-5],[3-5],(4-1)		The team with possession changed to Robertson & Moore		
[410] 2			[5-2],[5-4],[2-5],[3-5],(4-1)		The ball is on Robertson & Moore''s 2-rod		
[411] 3			[5-2],[5-4],[2-5],[3-5],(4-1)		The ball is on Robertson & Moore''s 3-rod		
[412] #			[5-2],[5-4],[2-5],[3-5],(5-1)		Robertson & Moore scored a goal		
[413] /			[5-2],[5-4],[2-5],[3-5],[5-1]		The end of game 5		
[414] //			[5-2],[5-4],[2-5],[3-5],[5-1]		The end of the match		
'
]

{ #category : #tests }
MatchplayEventPrinterForHistoryPaneTest >> testPrintingLines [
| ms p |

ms := self matchState.
p := (MatchplayEventPrinter forHistoryPane matchState: ms)
	isFormatCompact: false;
	isFormatLines: true;
	isTimeNone: true;
	isTimeDurationS: false;
	isTimeDurationMS: false;
	isTimeElapsed: false;
	yourself.
p printMatchplayEvents: ms matchplayEvents.
self assert: p text asString equals: self expectedResult


]
