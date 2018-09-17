*! 从第一黄金网获取财经时间序列数据
*! 程振兴 2018年8月6日
cap prog drop exrate
prog def exrate
	version 14.0
	syntax anything
	qui{
		copy "http://hq.dyhjw.com/nhq/candle.php?v=163ecd5d9b93e6b869fee99bcb1e1c42e879274e&code=`anything'&interval=1d" temp.txt, replace
		clear all
		set obs 1
		gen v = fileread("temp.txt")
		split v, parse("var data = [{" "},{" "}];")
		sxpose, clear
		drop in 1
		drop if !index(_var1, "TS")
		ren _var1 v
		split v, parse(,)
		drop v
		foreach i of varlist _all{
			replace `i' = subinstr(`i', `"""', "", .)
			replace `i' = subinstr(`i', `":"', "", .)
		}
		replace v1 = subinstr(v1, "TS", "", .)
		replace v1 = substr(v1, 1, 10)
		replace v2 = subinstr(v2, "P", "", .)
		replace v3 = subinstr(v3, "O", "", .)
		replace v4 = subinstr(v4, "H", "", .)
		replace v5 = subinstr(v5, "L", "", .)
		destring, replace
		compress
		gen date = date(v1, "YMD")
		format date %tdCY-N-D
		drop v1
		order date
		ren v2 close
		ren v3 open
		ren v4 high
		ren v5 low
		drop v6 - v10
		label var date "日期"
		label var close "收盘价"
		label var open "开盘价"
		label var high "最高价"
		label var low "最低价"
		erase temp.txt
	}
end
