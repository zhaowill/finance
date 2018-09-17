*! 把日期时间变量转换成毫秒记的时间戳
*! 程振兴 2018年7月13日
*! clear
*! set obs 10
*! gen date = 10000 + _n
*! format date %tdCY-N-D
*! numdate2timestamp date, gen(timestamp)
cap prog drop numdate2timestamp
prog define numdate2timestamp
	version 14.0
	syntax anything(name = date) [, GENerate(string)]
	gen date_czx = string(`date', "%td")
	gen time_czx = tc(`=date_czx[1]' 08:00:00)-tc(1 jan 1970 08:00:00)
	format time_czx %13.0f
	forval i = 1/`=_N'{
		replace time_czx = tc(`=date_czx[`i']' 08:00:00)-tc(1 jan 1970 08:00:00) in `i'
	}
	drop date_czx
	if "`generate'" != ""{
		ren time_czx `generate'
	}
end
