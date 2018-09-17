*! 打开指定文件、网址、文件夹
*! 程振兴 2018年7月13日
cap prog drop copen
prog define copen
version 7.0
syntax [anything] [using/] [,cd]
if "`c(os)'"=="Windows" | "$S_MACH"=="PC" {
        if "`using'"~="" {
                winexec cmd /c start ""  "`using'"
        }
        else {
                if "`cd'"~="cd" {
                        cap winexec `anything'
                        if _rc==193 {
                                winexec cmd /c start ""  "`anything'"
                        }
                        if _rc==601 {
                                noi di in yel "找不到`anything'."
                        }
                }
                else {
                        winexec cmd /c cd `c(pwd)'\ &  `anything'
                }
        }
}
else {
      !open "`anything'"
}
end
