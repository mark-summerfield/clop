#!/usr/bin/env tclsh9
# Copyright © 2026 Mark Summerfield. All rights reserved.

if {![catch {file readlink [info script]} name]} {
    const APPPATH [file dirname $name]
} else {
    const APPPATH [file normalize [file dirname [info script]]]
}
tcl::tm::path add $APPPATH

package require clop 3
package require lambda 1

proc main {} {
    set parser [clop::Parser new comparepdf.tcl 1.0.0 2 \
        "Compare two PDF files’ texts’." \
        "The unit used throughout is the point (1/72\"). For colors\
        use HTML-style hex numbers. (For colors either specify with =\
        e.g., --insert-color=#00FFFF, or use quotes, e.g.,\
        --insert-color '#00FFFF', since the # can confuse some shells.)" \
        "%bPDF1%! and %bPDF2%! are the two PDF files to compare."]
    $parser set_positional_names PDF PDF
    $parser new_debug
    $parser new_opt r report "" "Report name (.pdf or .csv) \[default\
        %mbased on input PDFs’ names%!\]."
    $parser new_bool s show "Show report in default PDF viewer (only if\
        report is a .pdf) \[default: %mdon’t show%!\]."
    $parser new_number T margin-top 0 "Set the top margin above which text\
        is ignored \[default %D; %c0-144%!\]." 0 MARGIN 0 144
    $parser new_number B margin-bottom 0 "Set the bottom margin below which\
        text is ignored \[default %D; %c0-144%!\]." 0 MARGIN 0 144
    $parser new_number L margin-left 0 "Set the left margin left of which\
        text is ignored \[default %D; %c0-144%!\]." 0 MARGIN 0 144
    $parser new_number R margin-right 0 "Set the right margin right of\
        which text is ignored \[default %D; %c0-144%!\]." 0 MARGIN 0 144
    $parser new_opt "" pdftotext "" "Set the pdftotext executable’s path\
        \[default %msystem version%!\]." 0 EXE
    $parser new_choice "" algorithm fast "Set the algorithm \[default %D;\
        valid: %cfast normal special%!\]." 0 ALGORITHM {fast normal special}
    $parser new_number "" line-tolerance 10 "Set line-tolerance \[default\
        %D; %c2-22%!\]." 0 POINTS 2 22
    $parser new_bool "" ignore-hyphens "Treat every hyphen as a space;\
        \[default %mrecognize hyphens%!\]."
    $parser new_bool "" distinct-hyphens "Distinguish different types of\
        hyphen \[default %mnormalize hyphens%!\]."
    $parser new_bool "" distinct-ligatures "Distinguish ligatures\
        \[default %mnormalize ligatures%!, e.g., treat ﬁ as fi, ﬂ as fl,\
        and so on\]."
    $parser new_opt "" change-bar-color #0000FF "Change bar color; set\
        to %y#FFFFFF%! (white) for no change bar \[default %D\]." 0 COLOR \
        [make_color_validator change-bar-color]
    $parser new_number "" transparency 80 "Transparency percentage\
        \[default %D; %c60-90%!\]." 0 PERCENT 60 90
    $parser new_opt "" margin-color #00FF00 "Margin color \[default %D\]." \
        0 COLOR [make_color_validator margin-color]
    $parser new_opt "" delete-color #FF0000 "Delete color \[default %D\]." \
        0 COLOR [make_color_validator delete-color]
    $parser new_opt "" insert-color #00FFFF "Insert color \[default %D\]." \
        0 COLOR [make_color_validator insert-color]
    $parser new_opt "" replace-color #FF00FF "Replace color \[default\
        %D\]." 0 COLOR [make_color_validator replace-color]
    $parser new_bool v verbose "Show progress \[default %mdon’t show\
        progress%!\]."
    $parser new_version V
    $parser new_help
    if {![llength $::argv]} { $parser on_help }
    set opts [$parser parse $::argv]
    clop::dump $opts
}

proc make_color_validator name {
    lambda {name value} {
        if {![regexp -nocase {^#[0-9A-F]{6}$} $value]} {
            return "expected an HTML-style color #HHHHHH for $name;\
                got $value."
        }
    } $name
}

main
