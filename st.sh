#!/bin/bash
nagelfar.sh \
    | grep -v Unknown.command \
    | grep -v Unknown.variable \
    | grep -v No.info.on.package.*found \
    | grep -v Variable.*is.never.read \
    | grep -v Unknown.subcommand..home..to..file \
    | grep -v N.Suspicious...char..Possibly.a.bad.comment. \
    | grep -v Found.constant.*which.is.also.a.variable
du -sh .git
ls -sh .*.str
clc -s -l tcl

TOTAL=0
OK=0
diff_files() {
    ((TOTAL++))
    if diff -q "$1" "$2" ; then
	((OK++))
    fi
}

./tclop.tcl > /tmp/tclop.txt
diff_files exp/tclop.txt /tmp/tclop.txt
./tclop-pos.tcl > /tmp/tclop-pos.txt
diff_files exp/tclop-pos.txt /tmp/tclop-pos.txt
./eg1.tcl -h > /tmp/eg1-help.txt
diff_files exp/eg1-help.txt /tmp/eg1-help.txt
./eg2.tcl -h > /tmp/eg2-help.txt
diff_files exp/eg2-help.txt /tmp/eg2-help.txt
./eg3.tcl -h > /tmp/eg3--h.txt
diff_files exp/eg3--h.txt /tmp/eg3--h.txt
./eg3.tcl h > /tmp/eg3-h.txt
diff_files exp/eg3-h.txt /tmp/eg3-h.txt
./eg3.tcl s -h > /tmp/eg3-s-h.txt
diff_files exp/eg3-s-h.txt /tmp/eg3-s-h.txt
./eg3.tcl u -h > /tmp/eg3-u-h.txt
diff_files exp/eg3-u-h.txt /tmp/eg3-u-h.txt
./eg3.tcl a -h > /tmp/eg3-a-h.txt
diff_files exp/eg3-a-h.txt /tmp/eg3-a-h.txt
./eg3.tcl e -h > /tmp/eg3-e-h.txt
diff_files exp/eg3-e-h.txt /tmp/eg3-e-h.txt
./eg3.tcl p -h > /tmp/eg3-p-h.txt
diff_files exp/eg3-p-h.txt /tmp/eg3-p-h.txt
./eg3.tcl c -h > /tmp/eg3-c-h.txt
diff_files exp/eg3-c-h.txt /tmp/eg3-c-h.txt
./eg3.tcl d -h > /tmp/eg3-d-h.txt
diff_files exp/eg3-d-h.txt /tmp/eg3-d-h.txt
./eg3.tcl f -h > /tmp/eg3-f-h.txt
diff_files exp/eg3-f-h.txt /tmp/eg3-f-h.txt
./eg3.tcl g -h > /tmp/eg3-g-h.txt
diff_files exp/eg3-g-h.txt /tmp/eg3-g-h.txt
./eg3.tcl G -h > /tmp/eg3-G-h.txt
diff_files exp/eg3-G-h.txt /tmp/eg3-G-h.txt
./eg3.tcl H -h > /tmp/eg3-H-h.txt
diff_files exp/eg3-H-h.txt /tmp/eg3-H-h.txt
./eg3.tcl i -h > /tmp/eg3-i-h.txt
diff_files exp/eg3-i-h.txt /tmp/eg3-i-h.txt
./eg3.tcl I -h > /tmp/eg3-I-h.txt
diff_files exp/eg3-I-h.txt /tmp/eg3-I-h.txt
./eg3.tcl U -h > /tmp/eg3-U-h.txt
diff_files exp/eg3-U-h.txt /tmp/eg3-U-h.txt
./eg3.tcl t -h > /tmp/eg3-t-h.txt
diff_files exp/eg3-t-h.txt /tmp/eg3-t-h.txt
./eg3.tcl untag -h > /tmp/eg3-untag-h.txt
diff_files exp/eg3-untag-h.txt /tmp/eg3-untag-h.txt
./eg3.tcl T -h > /tmp/eg3-T-h.txt
diff_files exp/eg3-T-h.txt /tmp/eg3-T-h.txt
./eg3.tcl restore -h > /tmp/eg3-restore-h.txt
diff_files exp/eg3-restore-h.txt /tmp/eg3-restore-h.txt
./eg3.tcl C -h > /tmp/eg3-C-h.txt
diff_files exp/eg3-C-h.txt /tmp/eg3-C-h.txt
./eg3.tcl purge -h > /tmp/eg3-purge-h.txt
diff_files exp/eg3-purge-h.txt /tmp/eg3-purge-h.txt

if [[ $OK -eq $TOTAL ]]; then
    echo -e "\x1B[32mAll $TOTAL regression tests OK\x1B[;0m"
else
    echo -e "\x1B[31mFAIL $OK/$TOTAL regression tests\x1B[;0m"
fi
str s
git st
