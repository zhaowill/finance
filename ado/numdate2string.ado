*! 将数值型日期转变成字符串型日期
*! 程振兴 2018年7月13日
*! clear
*! set obs 10
*! gen date = 10000 + _n
*! format date %tdCY-N-D
*! numdate2string date
cap prog drop numdate2string
prog define numdate2string
	version 14.0
	syntax anything(name = date) [, SPLIT(string)]
	if "`split'" == ""{
		local split = "-"
	}
	gen year = year(`date')
	gen month = month(`date')
	gen day = day(`date')
	drop `date'
	tostring year month day, replace
	gen date = year + "`split'" + month + "`split'" + day
	drop year month day
	order date
end
