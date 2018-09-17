*! 中国重要利率查询和表格输出
*! 程振兴 2018年7月14日
*! pzrate
cap prog drop pzrate
prog pzrate, rclass
	version 14.0
	cap restore
	preserve
	clear all
	qui copy "http://data.eastmoney.com/cjsj/globalRate.html" temp.txt, replace
	cap unicode encoding set gb18030
	cap unicode translate temp.txt
	cap unicode erasebackups, badidea
	qui{
		infix strL v 1-20000 using temp.txt, clear
		keep in 420/589
		drop if v == ""
		drop if v == "</th>"
		drop if v == "</tr>"
		drop if v == "<tr>"
		drop if v == "</thead>"
		drop if v == "<tbody>"
		drop if v == "<tr>"
		drop if v == "</tbody>"
		drop if v == "</table>"
		drop if v == `"<table cellpadding="0" cellspacing="0" class="tab1" style="width: 200px; float: left; margin-left: 32px;">"'
		drop if v == `"<thead class="h101">"'
		drop if v == `"<td>-</td>"'
		drop if v == `"<td></td>"'
		drop if v == `"<th colspan="2">"'
		drop if v == `"<table cellpadding="0" cellspacing="0" class="tab1" style="width: 200px; float: right;">"'
		replace v = subinstr(v, "><", "", .)
		replace v = ustrregexs(1) if ustrregexm(v, ">(.*)<")
		replace v = "0.00↑" if v == "0.00 " 
		replace v = "+" + v if ((index(v, "↓") | index(v, "↑ "))&index(v, "-") == 0) | v == "0.00↑"
		drop if v == ""
		while length(v[7]) < 10{
			replace v = v + " " in 7
		}
		while length(v[10]) < 10{
			replace v = v + " " in 10
		}
		while length(v[13]) < 10{
			replace v = v + " " in 13
		}
		while length(v[16]) < 10{
			replace v = v + " " in 16
		}
		while length(v[19]) < 10{
			replace v = v + " " in 19
		}
		while length(v[22]) < 10{
			replace v = v + " " in 22
		}
		while length(v[25]) < 10{
			replace v = v + " " in 25
		}
		while length(v[28]) < 10{
			replace v = v + " " in 28
		}
	}
	di ""
	di in smcl "    {c TLC}{hline 45}{c TRC}"
	di in smcl "    {c |} {res}上海银行间拆借利率(Shior) 数据日期：`=v[1]'{txt}{c |}"
	di in smcl "    {c LT}{hline 14}{c TT}{hline 13}{c TT}{hline 16}{c RT}"
	di in smcl "    {c |} {res}  利率期限   {c |}  当前值(%)  {c |}  升降基点(BP)  {txt}{c |}"
	di in smcl "    {c LT}{hline 14}{c +}{hline 13}{c +}{hline 16}{c RT}"
	di in smcl "    {c |} {res}  `=v[5]'  {c |}    `=v[6]'   {c |}     `=v[7]'   {txt}{c |}"
	di in smcl "    {c |} {res}     `=v[8]'     {c |}    `=v[9]'   {c |}     `=v[10]'   {txt}{c |}"
	di in smcl "    {c |} {res}     `=v[11]'     {c |}    `=v[12]'   {c |}     `=v[13]'   {txt}{c |}"

	di in smcl "    {c |} {res}    `=v[14]'    {c |}    `=v[15]'   {c |}     `=v[16]'   {txt}{c |}"
	di in smcl "    {c |} {res}    `=v[17]'    {c |}    `=v[18]'   {c |}     `=v[19]'   {txt}{c |}"

	di in smcl "    {c |} {res}    `=v[20]'    {c |}    `=v[21]'   {c |}     `=v[22]'   {txt}{c |}"
	di in smcl "    {c |} {res}    `=v[23]'    {c |}    `=v[24]'   {c |}     `=v[25]'   {txt}{c |}"
	di in smcl "    {c |} {res}     `=v[26]'     {c |}    `=v[27]'   {c |}     `=v[28]'   {txt}{c |}"
	di in smcl "    {c BLC}{hline 14}{c BT}{hline 13}{c BT}{hline 16}{c BRC}"

	di ""
	di in smcl "    {c TLC}{hline 28}{c TT}{hline 29}{c TRC}"
	di in smcl "    {c |}{res}      银行存款基准利率      {c |}       银行贷款基准利率      {txt}{c |}"
	di in smcl "    {c LT}{hline 13}{c TT}{hline 14}{c +}{hline 14}{c TT}{hline 14}{c RT}"
	di in smcl "    {c |}{res}   `=v[30]'  {c | }  `=v[31]' {c |}    `=v[47]'  {c | }  `=v[48]' {txt}{c |}"
	di in smcl "    {c LT}{hline 13}{c +}{hline 14}{c +}{hline 14}{c +}{hline 14}{c RT}"

	di in smcl "    {c |}{res}   `=v[32]'  {c | }     `=v[33]'     {c |}`=v[49]' {c | }     `=v[50]'     {txt}{c |}"
	di in smcl "    {c |}{res}     `=v[34]'   {c | }     `=v[35]'     {c |}`=v[51]'{c | }     `=v[52]'     {txt}{c |}"
	di in smcl "    {c |}{res}     `=v[36]'   {c | }     `=v[37]'     {c |}  `=v[53]'  {c | }     `=v[54]'     {txt}{c |}"
	di in smcl "    {c |}{res}`=v[38]'{c | }     `=v[39]'     {c |}  `=v[55]'  {c | }     `=v[56]'     {txt}{c |}"
	di in smcl "    {c |}{res}`=v[40]'{c | }     `=v[41]'     {c |}    `=v[57]'   {c | }     `=v[58]'     {txt}{c |}"  
	di in smcl "    {c |}{res}`=v[42]'{c | }     `=v[43]'     {c |}              {c | }              {txt}{c |}"
	di in smcl "    {c |}{res}`=v[44]'{c | }     `=v[45]'     {c |}              {c | }              {txt}{c |}"
	di in smcl "    {c BLC}{hline 13}{c BT}{hline 14}{c BT}{hline 14}{c BT}{hline 14}{c BRC}"
	qui{
		drop if ustrregexm(v, "[\u4e00-\u9fa5]+")
		replace v = subinstr(v, "↓", "", .)
		replace v = subinstr(v, "↑", "", .)
		destring, replace
	}
	ret scalar Shibor_ON = `=v[1]'
	ret scalar Shibor_1W = `=v[3]'
	ret scalar Shibor_2W = `=v[5]'
	ret scalar Shibor_1M = `=v[7]'
	ret scalar Shibor_3M = `=v[9]'
	ret scalar Shibor_6M = `=v[11]'
	ret scalar Shibor_9M = `=v[13]'
	ret scalar Shibor_1Y = `=v[15]'
	ret scalar Shibor_ON_BP= `=v[2]'
	ret scalar Shibor_1W_BP= `=v[4]'
	ret scalar Shibor_2W_BP= `=v[6]'
	ret scalar Shibor_1M_BP= `=v[8]'
	ret scalar Shibor_3M_BP= `=v[10]'
	ret scalar Shibor_6M_BP= `=v[12]'
	ret scalar Shibor_9M_BP= `=v[14]'
	ret scalar Shibor_1M_BP= `=v[16]'
	ret scalar 存款基准利率_活期存款 = `=v[17]'
	ret scalar 存款基准利率_3M = `=v[18]'
	ret scalar 存款基准利率_6M = `=v[19]'
	ret scalar 存款基准利率_1Y_整存整取 = `=v[20]'
	ret scalar 存款基准利率_2Y_整存整取 = `=v[21]'
	ret scalar 存款基准利率_3Y_整存整取 = `=v[22]'
	ret scalar 存款基准利率_5Y_整存整取 = `=v[23]'
	ret scalar 贷款基准利率_6M以内_含 = `=v[24]'
	ret scalar 贷款基准利率_6个月至1年_含 = `=v[25]'
	ret scalar 贷款基准利率_1_3Y_含 = `=v[26]'
	ret scalar 贷款基准利率_3_5Y_含 = `=v[27]'
	ret scalar 贷款基准利率_5Y以上 = `=v[28]'
	di as text "    {stata return list:查看返回值}"
	cap erase temp.txt
	di "数据来源：东方财富网"
end


