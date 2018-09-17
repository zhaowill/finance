* 获取和讯网汇率数据
* 程振兴 2018年8月6日
* 可以从这个网站上找到可获得的数据代码：http://quote.hexun.com/forex/default.aspx 
cap prog drop exrate2
prog def exrate2
	version 14.0
	syntax anything[, Date(string)]
	qui{
		if "`date'" == ""{
			local date: disp %dCYND date("`c(current_date)'","DMY")
		}
		copy "http://webforex.hermes.hexun.com/forex/kline?code=FOREX`anything'&start=`date'080000&number=-1000&type=5" temp.txt, replace
		clear all
		set obs 1
		gen v = fileread("temp.txt")
		split v, parse(`"],"Data":[[["' "],[" "]],")
		sxpose, clear
		drop in 1/2
		drop in -1
		ren _var1 v
		split v, parse(,)
		drop v
		replace v1 = substr(v1, 1, 8)
		gen date = date(v1, "YMD")
		format date %tdCY-N-D
		order date
		keep date v3 v4 v5 v6
		destring, replace
		replace v3 = v3 / 10000
		replace v4 = v4 / 10000
		replace v5 = v5 / 10000
		replace v6 = v6 / 10000
		ren v3 open
		ren v4 close
		ren v5 high
		ren v6 low
		erase temp.txt
	}
end
