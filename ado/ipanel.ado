*! 程振兴 2018年7月13日：国际面板数据爬取
*! 数据源：Tradeconomics
*!===================参数数据===================!*
*! 默认是爬所有国家的
*! 地区可以选择
*! 欧洲：europe
*! 美洲：america
*! 亚洲：asia
*! 非洲：africa
*! 澳洲：australia
*! G20国家：g20
*!===================支持的数据===================!*
*! 利率：interest-rate
*! 通货膨胀率：inflation-rate
*! 失业率：unemployment-rate
*! 政府债务占国内生产总值比重：government-debt-to-gdp
*! 就业率：employment-rate
*! 劳动力参与率：labor-force-participation-rate
*! 长期失业率：long-term-unemployment-rate
*! 青少年失业率：youth-unemployment-rate
*! 核心通胀率：core-inflation-rate
*! 食品通胀：food-inflation
*! 通货膨胀率：inflation-rate
*! 生产者价格指数变化率：producer-prices-change
*! 存款准备金率：cash-reserve-ratio
*! 存款利率：deposit-interest-rate
*! 银行间同业拆借利率：interbank-rate
*! 利率：interest-rate
*! 贷款利率：lending-rate
*! 贷款增长率：loan-growth
*! GDP年增长率：gdp-annual-growth-rate
*! GDP增长率：gdp-growth-rate
*! 政府支出占国内生产总值：government-spending-to-gdp
*! 政府债务占国内生产总值比重：government-debt-to-gdp
*! 政府预算：government-budget
*! 自置居所比率：home-ownership-rate
*! 员工社会保障覆盖率：social-security-rate-for-employees
*! 企业所得税税率：corporate-tax-rate
*! 个人所得税税率：personal-income-tax-rate
*! 销售税率：sales-tax-rate
*! 社会保障覆盖率：social-security-rate
*! 企业社会保障覆盖率：social-security-rate-for-companies
*! 零售销售（月率环比)：retail-sales-mom
*! 零售销售（年率同比)：retail-sales-yoy
*! 个人消费：personal-spending
*! 银行贷款利率：bank-lending-rate
*! 工业生产：industrial-production
*! 工业生产（月）：industrial-production-mom
*! 矿业生产：mining-production
*!==============================================!*
cap prog drop ipanel
prog define ipanel
	version 14.0
	syntax anything(name = var), [Continent(string)]
	clear all
	di "正在下载......"
	qui set more off, permanently
	if "`var'" == "" local var "gdp"
	if "`continent'" == "" | !inlist("`continent'", "europe", "america", "asia", "africa", "australia", "g20"){
		local url = "https://zh.tradingeconomics.com/country-list/`var'"
	}
	else{
		local url = "https://zh.tradingeconomics.com/country-list/`var'?continent=`continent'"
	}
	qui{
		copy `"`url'"' temp.txt, replace
		local times = 0
		while _rc ~= 0 {
			local times = `times' + 1
			sleep 1000
			qui cap copy `"`url'"' temp.txt, replace
			if `times' > 10 {
				disp as error "错误！：因为你的网络速度贼慢，无法获得数据"
				exit 601
			}
		}
		cap utrans temp.txt
		infix strL v 1-20000 using temp.txt, clear
		keep if index(v,`"<table class="table table-hover" data-sortable>"') | index(v, `"</th>"') | index(v, `"<a href='/"') | index(v[_n-1], `"<a href='/"') | index(v, `"data-value="') | index(v, `"<td class="hidden-xs">"') | index(v, `"</small> </td>"') | index(v, `"<span class="small">"') | index(v, `"text-align: center"')
		drop if index(v, `"<th data-sortable="false" class="hidden-sm hidden-xs"></th>"')
		drop if index(v, `"<td class="hidden-xs"><small>"')
		drop if v == `"style=' vertical-align: bottom; text-align: right; width : 300px; height: 250px; text-align: center; background-image: url("/images/donate/child-net.jpg")'>"'
		drop in 1/10
		cap post close unemployment_rate
		postfile unemployment_rate str50 enname str50 cnname str50 近期数据 str100 数据更新日期 str100 前次数据 str100 最高 str100 最低 str100 单位 str50 频率 using temp.dta, replace
		forvalues i = 1(9)`=_N'{
			post unemployment_rate (v[`i']) (v[`i'+1]) (v[`i'+2]) (v[`i'+3]) (v[`i'+4]) (v[`i'+5]) (v[`i'+6]) (v[`i'+7]) (v[`i'+8])
		}
		postclose unemployment_rate
		use temp.dta, clear
		split enname, parse(/)
		drop enname enname1 enname3
		order enname2
		rename enname2 enname
		replace cnname = ustrregexs(0) if ustrregexm(cnname,"[\u4e00-\u9fa5]+")
		replace 近期数据 = subinstr(近期数据, `"<td style="text-align: center;" data-value=""', "", .)
		replace 近期数据 = subinstr(近期数据, `"""', "", .)
		replace 近期数据 = subinstr(近期数据, ">", "", .)
		replace 数据更新日期 = ustrregexs(0) if ustrregexm(数据更新日期, "\d\d\d\d-\d\d")
		replace 前次数据 = subinstr(前次数据, `"<span style='color: darkred;'>"', "", .)
		replace 前次数据 = ustrregexs(0) if ustrregexm(前次数据, ">(.*?)<")
		replace 前次数据 = subinstr(前次数据, ">", "", .)
		replace 前次数据 = subinstr(前次数据, "<", "", .)
		replace 最高 = ustrregexs(0) if ustrregexm(最高, ">(.*?)<")
		replace 最高 = subinstr(最高, ">", "", .)
		replace 最高 = subinstr(最高, "<", "", .)
		replace 最低 = subinstr(最低, `"<span style='color: darkred;'>"', "", .)
		replace 最低 = ustrregexs(0) if ustrregexm(最低, ">(.*?)<")
		replace 最低 = subinstr(最低, ">", "", .)
		replace 最低 = subinstr(最低, "<", "", .)
		replace 单位 = ustrregexs(0) if ustrregexm(单位, ">(.*?)<")
		replace 单位 = subinstr(单位, ">", "", .)
		replace 单位 = subinstr(单位, "<", "", .)
		replace 频率 = subinstr(频率, "</small> </td>", "", .)
		destring 近期数据, replace
		destring 前次数据, replace
		destring 最高, replace
		destring 最低, replace
		gen tempdate = date(数据更新日期, "YM")
		format tempdate %dCY-N
		drop 数据更新日期
		rename tempdate 数据更新日期
		order enname cnname 近期数据 数据更新日期
		replace enname = proper(enname)
		compress
	}
	local date = c(current_date)
	local date = "`date'"
	local date = subinstr("`date'", " ", "_", .)
	cap erase temp.txt
	cap erase temp.dta
	qui save "`var'", replace
	noi di in yellow "`var'.dta已保存！"
	noi di in yellow "数据来源：Tradeconomics"
end
