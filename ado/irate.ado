*! 自动绘制利率的期限结构
*! 程振兴 2018年8月4日
*! irate
cap prog drop irate
prog def irate
version 14.0
	qui{
		!curl 'http://yield.chinabond.com.cn/cbweb-mn/yc/inityc?xyzSelect=txy&&workTime=&&dxbj=0&&qxll=0&&yqqxN=N&&yqqxK=K&&wrjxCBFlag=0' -X POST -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36' -H 'Referer: http://yield.chinabond.com.cn/cbweb-mn/yhj_chart' -H 'X-Requested-With: XMLHttpRequest' -H 'Content-Length: 0' --compressed -o temp.txt
		infix strL v 1-20000 using temp.txt, clear
		erase temp.txt
		split v, parse("],[" "[[" "]]")
		sxpose, clear
		gen date = ustrregexs(1) if ustrregexm(_var1, `""worktime":"(.*)","')
		local date = date[1]
		drop date
		drop in 1/2
		drop in -2/-1
		ren _var1 v
		split v, parse(,)
		drop v
		ren v1 term
		ren v2 rate
		label var term "期限"
		label var rate "中债国债到期收益率"
		replace term = "" if term == "null"
		replace rate = "" if rate == "null"
		destring, replace
		line rate term, xti(期限(年)) yti(中债国债到期收益率) ti(图：中债国债收益率曲线, size(medlarge)) note(日期：`date')
	}
end 
