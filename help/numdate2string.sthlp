{smcl}
{* 2018年8月4日}
{hline}
{cmd:help numdate2string}{right: }
{hline}

{title:标题}

{phang}
{bf:numdate2string} {hline 2} 将数值型日期转变成字符串型日期。{p_end}

{title:语法}

{p 8 18 2}
{cmdab:numdate2string} [, {bf:split(}{it:string}{bf:)}]

{title:示例}

{phang}
{stata `"clear"'}
{p_end}
{phang}
{stata `"set obs 10"'}
{p_end}
{phang}
{stata `"gen date = 10000 + _n"'}
{p_end}
{phang}
{stata `"format date %tdCY-N-D"'}
{p_end}
{phang}
{stata `"numdate2string date, split(/)"'}
{p_end}

{title:作者}

{pstd}程振兴{p_end}
{pstd}暨南大学·经济学院·金融学{p_end}
{pstd}中国·广州{p_end}
{pstd}{browse "http://www.czxa.top":个人网站}{p_end}
{pstd}Email {browse "mailto:czxjnu@163.com":czxjnu@163.com}{p_end}
