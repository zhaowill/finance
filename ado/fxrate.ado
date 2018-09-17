*! 人民币汇率查询和表格输出
cap prog drop fxrate
prog fxrate, rclass
	version 14.0
	cap restore
	preserve
	clear all
	qui copy "http://price.btcfans.com/" temp.txt, replace
	cap{
		unicode encoding set gb18030
		unicode translate temp.txt
		unicode erasebackups, badidea
	}
	qui{
		infix strL v 1-20000 using temp.txt, clear
		keep if index(v, "1:")
		replace v = subinstr(v, "<td>1:", "", .)
		replace v = ustrregexs(1) if ustrregexm(v, ">(.*)</span></td>")
		forval i = 1/`=_N'{
			while length(v[`i']) < 6{
				replace v = v + "0" in `i'
			}
		}
	}
	di ""
	di "    1单位外币对人民币："
	di in smcl "    {c TLC}{hline 9}{c TT}{hline 9}{c TT}{hline 9}{c TT}{hline 9}{c TT}{hline 10}{c TT}{hline 10}{c TRC}"
	di in smcl "    {c |} {res}  美元  {c |}   欧元  {c |}   英镑  {c |}   澳元  {c |} 加拿大元 {c |} 瑞士法郎 {txt}{c |}"
	di in smcl "    {c LT}{hline 9}{c +}{hline 9}{c +}{hline 9}{c +}{hline 9}{c +}{hline 10}{c +}{hline 10}{c RT}"
	di in smcl "    {c |} {res} `=v[1]' {c |}  `=v[2]' {c |}  `=v[3]' {c |}  `=v[4]' {c |}  `=v[5]'  {c |}  `=v[6]'  {txt}{c |}"
	di in smcl "    {c LT}{hline 9}{c +}{hline 9}{c +}{hline 9}{c +}{hline 9}{c +}{hline 10}{c +}{hline 10}{c RT}"
	di in smcl "    {c |} {res}新西兰元{c |}   日元  {c |}   韩元  {c |}   港币  {c |} 新加坡元 {c |}  泰国铢  {txt}{c |}"
	di in smcl "    {c LT}{hline 9}{c +}{hline 9}{c +}{hline 9}{c +}{hline 9}{c +}{hline 10}{c +}{hline 10}{c RT}"
	di in smcl "    {c |} {res} `=v[7]' {c |}  `=v[8]' {c |}  `=v[9]' {c |}  `=v[10]' {c |}  `=v[11]'  {c |}  `=v[12]'  {txt}{c |}"
	di in smcl "    {c BLC}{hline 9}{c BT}{hline 9}{c BT}{hline 9}{c BT}{hline 9}{c BT}{hline 10}{c BT}{hline 10}{c BRC}"
	qui destring, replace
	ret scalar 泰国铢 = v[12]
	ret scalar 新加坡元 = v[11]
	ret scalar 港币 = v[10]
	ret scalar 韩元 = v[9]
	ret scalar 日元 = v[8]
	ret scalar 新西兰元 = v[7]
	ret scalar 瑞士法郎 = v[6]
	ret scalar 加拿大元 = v[5]
	ret scalar 澳元 = v[4]
	ret scalar 英镑 = v[3]
	ret scalar 欧元 = v[2]
	ret scalar 美元 = v[1]
	di as text "    {stata return list:return list}"
	di "数据来源：http://price.btcfans.com/"
	cap erase temp.txt
end
