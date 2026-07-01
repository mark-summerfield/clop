#!/usr/bin/env tclsh9
# Copyright © 2026 Mark Summerfield. All rights reserved.

if {![catch {file readlink [info script]} name]} {
    const APPPATH [file dirname $name]
} else {
    const APPPATH [file normalize [file dirname [info script]]]
}
tcl::tm::path add $APPPATH

package require clop 3

proc main {} {
    set parser [clop::Parser new comparepdf.tcl 1.0.0 2 \
        "Compare two PDF files’ texts’." \
        "The unit used throughout is the point (1/72\"). For colors\
        use HTML-style hex numbers." \
        "%bPDF1%! and %bPDF2%! are the two PDF files to compare."]
    $parser set_positional_names PDF PDF
    $parser new_debug
    $parser new_opt r report "" "Report name (.pdf or .csv) \[default\
        %mbased on input PDFs’ names%!\]."
    $parser new_bool s show "Show report in default PDF viewer (only if\
        report is a .pdf) \[default: %mdon’t show%!\]."
    $parser new_opt T margin-top 0 "Set the top margin above which text\
        is ignored \[default %D; %c0-144%!\]." 0 MARGIN \
        [lambda margin { if {$margin < 0 || $margin > 144} { \
            return "top margin $margin is out of range"} }]
    $parser new_opt B margin-bottom 0 "Set the bottom margin below which\
        text is ignored \[default %D; %c0-144%!\]." 0 MARGIN \
        [lambda margin { if {$margin < 0 || $margin > 144} { \
            return "bottom margin $margin is out of range" } }]
    $parser new_opt L margin-left 0 "Set the left margin left of which\
        text is ignored \[default %D; %c0-144%!\]." 0 MARGIN \
        [lambda margin { if {$margin < 0 || $margin > 144} { \
            return "left margin $margin is out of range" } }]
    $parser new_opt R margin-right 0 "Set the right margin right of which\
        text is ignored \[default %D; %c0-144%!\]." 0 MARGIN \
        [lambda margin { if {$margin < 0 || $margin > 144} { \
            return "right margin $margin is out of range" } }]
    $parser new_opt "" pdftotext "" "Set the pdftotext executable’s path\
        \[default %msystem version%!\]." 0 EXE
    $parser new_opt "" algorithm fast "Set the algorithm \[default %D;\
        valid: %cfast normal special%!\]." 0 ALGORITHM \
        [lambda algorithm { if {$algorithm ni {fast normal special}} { \
            return "unrecognized algorithm $algorithm" } }]
    $parser new_opt "" line-tolerance 10 "Set line-tolerance \[default\
        %D; %c2-22%!\]." 0 POINTS \
        [lambda points { if {$points < 2 || $points > 22} { \
            return "line-tolerance $points is out of range" } }]
    $parser new_bool "" ignore-hyphens "Treat every hyphen as a space;\
        \[default %mrecognize hyphens%!\]."
    $parser new_bool "" distinct-hyphens "Distinguish different types of\
        hyphen \[default %mnormalize hyphens%!\]."
    $parser new_bool "" distinct-ligatures "Distinguish ligatures\
        \[default %mnormalize ligatures%!, e.g., treat ﬁ as fi, ﬂ as fl,\
        and so on\]."
    $parser new_opt "" change-bar-color #0000FF "Change bar color; set\
        to %y#FFFFFF%! (white) for no change bar \[default %D\]." 0 COLOR
    $parser new_opt "" transparency 80 "Transparency percentage \[default\
        %D; %c60-90%!\]." 0 PERCENT
    $parser new_opt "" margin-color #00FF00 "Margin color \[default %D\]." \
        0 COLOR
    $parser new_opt "" delete-color #FF0000 "Delete color \[default %D\]." \
        0 COLOR
    $parser new_opt "" insert-color #00FFFF "Insert color \[default %D\]." \
        0 COLOR
    $parser new_opt "" replace-color #FF00FF "Replace color \[default\
        %D\]." 0 COLOR
    $parser new_bool v verbose "Show progress \[default %mdon’t show\
        progress%!\]."
    $parser new_version V
    $parser new_help
    if {![llength $::argv]} { $parser on_help }
    set opts [$parser parse $::argv]
    clop::dump $opts
}

main
