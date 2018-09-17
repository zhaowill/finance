{smcl}
{* 2018年7月19日}
{hline}
{cmd:help ipanel}{right: }
{hline}

{title:标题}

{phang}
{bf:ipanel} {hline 2} Tradeconomics数据接口，提供30+种各国数据的下载。{p_end}

{title:语法}

{p 8 18 2}
{cmd:ipanel} {bf: arg} {bf: [, {opt c:ontinent}(}{it:string}{bf:)]}

{pstd}{cmd: 描述:}{p_end}

{pstd}{space 3}该命令将会自动爬取指定的数据变量。{p_end}
{pstd}{space 3}arg: 指定下载的数据变量。{p_end}

{marker options}{...}
{title:选项}

{phang} {bf: {opt c:ontinent}(}{it:string}{bf:)}: 指定下载哪个大洲的国家，如果不指定则为全世界。
可选洲为：europe/america/asia/africa/australia/g20(G20国家){p_end}

{title:示例}

{phang}
{stata `"ipanel interest-rate"'}
{p_end}
{phang}
{stata `"ipanel interest-rate, c(g20)"'}
{p_end}

{title:可选变量}
{pstd} {hi:利率} interest-rate  {p_end}
{pstd} {hi:通货膨胀率} inflation-rate  {p_end}
{pstd} {hi:失业率} unemployment-rate  {p_end}
{pstd} {hi:政府债务占国内生产总值比重} government-debt-to-gdp  {p_end}
{pstd} {hi:就业率} employment-rate  {p_end}
{pstd} {hi:劳动力参与率} labor-force-participation-rate  {p_end}
{pstd} {hi:长期失业率} long-term-unemployment-rate  {p_end}
{pstd} {hi:青少年失业率} youth-unemployment-rate  {p_end}
{pstd} {hi:核心通胀率} core-inflation-rate  {p_end}
{pstd} {hi:食品通胀} food-inflation  {p_end}
{pstd} {hi:通货膨胀率} inflation-rate  {p_end}
{pstd} {hi:生产者价格指数变化率} producer-prices-change  {p_end}
{pstd} {hi:存款准备金率} cash-reserve-ratio  {p_end}
{pstd} {hi:存款利率} deposit-interest-rate  {p_end}
{pstd} {hi:银行间同业拆借利率} interbank-rate  {p_end}
{pstd} {hi:利率} interest-rate  {p_end}
{pstd} {hi:贷款利率} lending-rate  {p_end}
{pstd} {hi:贷款增长率} loan-growth  {p_end}
{pstd} {hi:GDP年增长率} gdp-annual-growth-rate  {p_end}
{pstd} {hi:GDP增长率} gdp-growth-rate  {p_end}
{pstd} {hi:政府支出占国内生产总值} government-spending-to-gdp  {p_end}
{pstd} {hi:政府债务占国内生产总值比重} government-debt-to-gdp  {p_end}
{pstd} {hi:政府预算} government-budget  {p_end}
{pstd} {hi:自置居所比率} home-ownership-rate  {p_end}
{pstd} {hi:员工社会保障覆盖率} social-security-rate-for-employees  {p_end}
{pstd} {hi:企业所得税税率} corporate-tax-rate  {p_end}
{pstd} {hi:个人所得税税率} personal-income-tax-rate  {p_end}
{pstd} {hi:销售税率} sales-tax-rate  {p_end}
{pstd} {hi:社会保障覆盖率} social-security-rate  {p_end}
{pstd} {hi:企业社会保障覆盖率} social-security-rate-for-companies  {p_end}
{pstd} {hi:零售销售（月率环比)} retail-sales-mom  {p_end}
{pstd} {hi:零售销售（年率同比)} retail-sales-yoy  {p_end}
{pstd} {hi:个人消费} personal-spending  {p_end}
{pstd} {hi:银行贷款利率} bank-lending-rate  {p_end}
{pstd} {hi:工业生产} industrial-production  {p_end}
{pstd} {hi:工业生产（月）} industrial-production-mom  {p_end}
{pstd} {hi:矿业生产} mining-production  {p_end}

{title:作者}

{pstd}程振兴{p_end}
{pstd}暨南大学·经济学院·金融学{p_end}
{pstd}中国·广州{p_end}
{pstd}{browse "http://www.czxa.top":个人网站}{p_end}
{pstd}Email {browse "mailto:czxjnu@163.com":czxjnu@163.com}{p_end}
