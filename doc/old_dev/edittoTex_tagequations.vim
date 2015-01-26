"Clean up section numbering
"%s/\n\d\+\.*\d*\n/&JOINLINE/g
"%s/\nJOINLINE/ /g

"Function starts
   %s/\u(.*)/$$TeXfunc & TeXfunc$$/g
   %s/\l(.*)/$$TeXfunc & TeXfunc$$/g

"Uppercase variable subscripts
   %s/\<\([BCDEFGHJKLMNPQRSTUVWXYZ][jklmnt]*\)\>/$$TeXss & TeXss$$/g
   %s/\<\(\u\+\d\+\)\>/$$TeXss & TeXss$$/g

"lowecase Variable subscripts
   %s/\<\(\l[jklmnt]\)\>/$$TeXss & TeXss$$/g
   %s/\<\(\l\+\d\+\)\>/$$TeXss & TeXss$$/g
   %s/\$\$TeXss [aoi][mnt] TeXss\$\$/RMVFRWD&RMVBACK/g
   %s/RMVFRWD\$\$TeXss//g
   %s/TeXss\$\$RMVBACK//g


"Single Terms 
   %s/[∅&¯±µ·×ˆΘ=βδεθξρστφ’“”•Ω→⇐⇒∀∃∆∈−∗√∞∩∴∵∼≡≤≥⊂⊆⊥ﬀﬁﬃ{}∞αβχδεηγικλµνωφπψρστθυξζ∆ΓΛΩΦΠΨΣΘΥΞκϕ∪∧∨†‡⊃⊇]/$$TeXterm & TeXterm$$/g

"Handle ellipses
%s/\.\.\./$$TeXell & TeXell$$/g

"terms
%s/\<\(o o\|Var\|var\|lim inf\|lim sup\|arccos\|cos\|csc\|exp\|ker\|min\|sinh\|arcsin\|cosh\|deg\|lg\|ln\|Pr\|sup\|arctan\|cot\|det\|hom\|lim\|log\|sec\|tan\|arg\|coth\|dim\|inf\|max\|sin\|tanh\)\>/$$TeXexp & TeXexp$$/g

"Matrices
%s/[⎡⎦⎢⎣⎤⎥]/$$TeXmat & TeXmat$$/g

"Paranthesis and Brackets
%s/(/$$TeXmat & TeXmat$$/g
%s/)/$$TeXmat & TeXmat$$/g

%s/TeX\l*\$\$\s*/&RMVBACKSPACE/g
%s/\s*RMVBACKSPACE//g

%s/\s*\$\$TeX/RMVFRWDSPACE&/g
%s/RMVFRWDSPACE\s*//g
%s/TeX\l*\$\$\$\$TeX\l*/ /g
%s/TeX\l*\$\$[,;|(){}]\$\$TeX\l*/rmv&rmv/g
%s/rmvTeX\l*\$\$//g
%s/\$\$TeX\l*rmv//g
%s/\$\$TeX\l*/\r&/g
%s/TeX\l*\$\$/&\r/g
"
"%s/^\s*//g
"%s/\s*$//g

