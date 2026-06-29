#!/usr/bin/env tclsh9
# Copyright © 2026 Mark Summerfield. All rights reserved.

if {![catch {file readlink [info script]} name]} {
    const APPPATH [file dirname $name]
} else {
    const APPPATH [file normalize [file dirname [info script]]]
}
tcl::tm::path add $APPPATH

package require clop 2
package require lambda 1

set ::clop::OnExit [lambda {{code 0}} {
    puts "—————— exit $code ——————"
    error OnExit 
}]

proc test1 {} {
    puts "—————— test1 ——————"
    set parser [clop::Parser new comparepdf.tcl 1.0.0 2 \
        "Compare two PDFs texts’." \
        "The unit used throughout is the point (1/72\"). For colors\
        use HTML-style hex numbers."]
    $parser new_debug
    $parser new_opt r report "" "Report name (.pdf or .csv) \[default\
        is based on input PDFs’ names\]"
    $parser new_bool s show "Show report in default PDF viewer (only if\
        report is a .pdf) \[default: don’t show\]"
    $parser new_opt T margin-top 0 "Set the top margin above which text\
        is ignored \[default 0; 0-144\]"
    $parser new_opt B margin-bottom 0 "Set the bottom margin below which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt L margin-left 0 "Set the left margin left of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt R margin-right 0 "Set the right margin right of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt "" pdftotext "" "Set the pdftotext executable’s path\
        \[default use system version\]"
    $parser new_opt "" algorithm fast "Set the algorithm \[default fast;\
        valid: fast normal special\]"
    $parser new_opt "" line-tolerance 10 "Set line-tolerance \[default\
        10; 2-22\]"
    $parser new_bool "" ignore-hyphens "Treat every hyphen as a space;\
        \[default recognize hyphens\]"
    $parser new_bool "" distinct-hyphens "Distinguish different types of\
        hyphen \[default normalize them\]"
    $parser new_bool "" distinct-ligatures "Distinguish ligatures\
        \[default normalize them, e.g., treat ﬁ as fi, ﬂ as fl, and so on\]"
    $parser new_opt "" change-bar-color #0000FF "Change bar color; set\
        to #FFFFFF (white) for no change bar \[default #0000FF\]"
    $parser new_opt "" transparency 80 "Transparency percentage \[default\
        80; 60-90\]"
    $parser new_opt "" margin-color #00FF00 "Margin color \[default\
        #00FF00\]"
    $parser new_opt "" delete-color #FF0000 "Delete color \[default\
        #FF0000\]"
    $parser new_opt "" insert-color #00FFFF "Insert color \[default\
        #00FFFF\]"
    $parser new_opt "" replace-color #FF00FF "Replace color \[default\
        #FF00FF\]"
    $parser new_bool v verbose "Show progress \[default don’t show\
        progress\]"
    $parser new_version V
    $parser new_help
    set argv [list -V]
    puts "argv: $argv"
    try {
        set opts [$parser parse $argv]
    } on error err {
        if {$err ne "OnExit"} {
            puts "ERROR $err"
        }
    }
    #clop::dump $opts
}

proc test2 {} {
    puts "—————— test2 ——————"
    set parser [clop::Parser new comparepdf.tcl 1.0.0 2 \
        "Compare two PDFs texts’." \
        "The unit used throughout is the point (1/72\"). For colors\
        use HTML-style hex numbers."]
    $parser new_debug
    $parser new_opt r report "" "Report name (.pdf or .csv) \[default\
        is based on input PDFs’ names\]"
    $parser new_bool s show "Show report in default PDF viewer (only if\
        report is a .pdf) \[default: don’t show\]"
    $parser new_opt T margin-top 0 "Set the top margin above which text\
        is ignored \[default 0; 0-144\]"
    $parser new_opt B margin-bottom 0 "Set the bottom margin below which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt L margin-left 0 "Set the left margin left of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt R margin-right 0 "Set the right margin right of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt "" pdftotext "" "Set the pdftotext executable’s path\
        \[default use system version\]"
    $parser new_opt "" algorithm fast "Set the algorithm \[default fast;\
        valid: fast normal special\]"
    $parser new_opt "" line-tolerance 10 "Set line-tolerance \[default\
        10; 2-22\]"
    $parser new_bool "" ignore-hyphens "Treat every hyphen as a space;\
        \[default recognize hyphens\]"
    $parser new_bool "" distinct-hyphens "Distinguish different types of\
        hyphen \[default normalize them\]"
    $parser new_bool "" distinct-ligatures "Distinguish ligatures\
        \[default normalize them, e.g., treat ﬁ as fi, ﬂ as fl, and so on\]"
    $parser new_opt "" change-bar-color #0000FF "Change bar color; set\
        to #FFFFFF (white) for no change bar \[default #0000FF\]"
    $parser new_opt "" transparency 80 "Transparency percentage \[default\
        80; 60-90\]"
    $parser new_opt "" margin-color #00FF00 "Margin color \[default\
        #00FF00\]"
    $parser new_opt "" delete-color #FF0000 "Delete color \[default\
        #FF0000\]"
    $parser new_opt "" insert-color #00FFFF "Insert color \[default\
        #00FFFF\]"
    $parser new_opt "" replace-color #FF00FF "Replace color \[default\
        #FF00FF\]"
    $parser new_bool v verbose "Show progress \[default don’t show\
        progress\]"
    $parser new_version V
    $parser new_help
    set argv [list --version]
    puts "argv: $argv"
    try {
        set opts [$parser parse $argv]
    } on error err {
        if {$err ne "OnExit"} {
            puts "ERROR $err"
        }
    }
    #clop::dump $opts
}

proc test3 {} {
    puts "—————— test3 ——————"
    set parser [clop::Parser new comparepdf.tcl 1.0.0 2 \
        "Compare two PDFs texts’." \
        "The unit used throughout is the point (1/72\"). For colors\
        use HTML-style hex numbers."]
    $parser new_debug
    $parser new_opt r report "" "Report name (.pdf or .csv) \[default\
        is based on input PDFs’ names\]"
    $parser new_bool s show "Show report in default PDF viewer (only if\
        report is a .pdf) \[default: don’t show\]"
    $parser new_opt T margin-top 0 "Set the top margin above which text\
        is ignored \[default 0; 0-144\]"
    $parser new_opt B margin-bottom 0 "Set the bottom margin below which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt L margin-left 0 "Set the left margin left of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt R margin-right 0 "Set the right margin right of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt "" pdftotext "" "Set the pdftotext executable’s path\
        \[default use system version\]"
    $parser new_opt "" algorithm fast "Set the algorithm \[default fast;\
        valid: fast normal special\]"
    $parser new_opt "" line-tolerance 10 "Set line-tolerance \[default\
        10; 2-22\]"
    $parser new_bool "" ignore-hyphens "Treat every hyphen as a space;\
        \[default recognize hyphens\]"
    $parser new_bool "" distinct-hyphens "Distinguish different types of\
        hyphen \[default normalize them\]"
    $parser new_bool "" distinct-ligatures "Distinguish ligatures\
        \[default normalize them, e.g., treat ﬁ as fi, ﬂ as fl, and so on\]"
    $parser new_opt "" change-bar-color #0000FF "Change bar color; set\
        to #FFFFFF (white) for no change bar \[default #0000FF\]"
    $parser new_opt "" transparency 80 "Transparency percentage \[default\
        80; 60-90\]"
    $parser new_opt "" margin-color #00FF00 "Margin color \[default\
        #00FF00\]"
    $parser new_opt "" delete-color #FF0000 "Delete color \[default\
        #FF0000\]"
    $parser new_opt "" insert-color #00FFFF "Insert color \[default\
        #00FFFF\]"
    $parser new_opt "" replace-color #FF00FF "Replace color \[default\
        #FF00FF\]"
    $parser new_bool v verbose "Show progress \[default don’t show\
        progress\]"
    $parser new_version V
    $parser new_help
    #puts [$parser to_string]
    set argv [list -h]
    puts "argv: $argv"
    try {
        set opts [$parser parse $argv]
    } on error err {
        if {$err ne "OnExit"} {
            puts "ERROR $err"
        }
    }
}

proc test4 {} {
    puts "—————— test4 ——————"
    set parser [clop::Parser new comparepdf.tcl 1.0.0 2 \
        "Compare two PDFs texts’." \
        "The unit used throughout is the point (1/72\"). For colors\
        use HTML-style hex numbers."]
    $parser new_debug
    $parser new_opt r report "" "Report name (.pdf or .csv) \[default\
        is based on input PDFs’ names\]"
    $parser new_bool s show "Show report in default PDF viewer (only if\
        report is a .pdf) \[default: don’t show\]"
    $parser new_opt T margin-top 0 "Set the top margin above which text\
        is ignored \[default 0; 0-144\]"
    $parser new_opt B margin-bottom 0 "Set the bottom margin below which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt L margin-left 0 "Set the left margin left of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt R margin-right 0 "Set the right margin right of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt "" pdftotext "" "Set the pdftotext executable’s path\
        \[default use system version\]"
    $parser new_opt "" algorithm fast "Set the algorithm \[default fast;\
        valid: fast normal special\]"
    $parser new_opt "" line-tolerance 10 "Set line-tolerance \[default\
        10; 2-22\]"
    $parser new_bool "" ignore-hyphens "Treat every hyphen as a space;\
        \[default recognize hyphens\]"
    $parser new_bool "" distinct-hyphens "Distinguish different types of\
        hyphen \[default normalize them\]"
    $parser new_bool "" distinct-ligatures "Distinguish ligatures\
        \[default normalize them, e.g., treat ﬁ as fi, ﬂ as fl, and so on\]"
    $parser new_opt "" change-bar-color #0000FF "Change bar color; set\
        to #FFFFFF (white) for no change bar \[default #0000FF\]"
    $parser new_opt "" transparency 80 "Transparency percentage \[default\
        80; 60-90\]"
    $parser new_opt "" margin-color #00FF00 "Margin color \[default\
        #00FF00\]"
    $parser new_opt "" delete-color #FF0000 "Delete color \[default\
        #FF0000\]"
    $parser new_opt "" insert-color #00FFFF "Insert color \[default\
        #00FFFF\]"
    $parser new_opt "" replace-color #FF00FF "Replace color \[default\
        #FF00FF\]"
    $parser new_bool v verbose "Show progress \[default don’t show\
        progress\]"
    $parser new_version V
    $parser new_help
    set argv [list --help]
    puts "argv: $argv"
    try {
        set opts [$parser parse $argv]
    } on error err {
        if {$err ne "OnExit"} {
            puts "ERROR $err"
        }
    }
    #clop::dump $opts
}

proc test5 {} {
    puts "—————— test5 ——————"
    set parser [clop::Parser new comparepdf.tcl 1.0.0 2 \
        "Compare two PDFs texts’." \
        "The unit used throughout is the point (1/72\"). For colors\
        use HTML-style hex numbers."]
    $parser new_debug
    $parser new_opt r report "" "Report name (.pdf or .csv) \[default\
        is based on input PDFs’ names\]"
    $parser new_bool s show "Show report in default PDF viewer (only if\
        report is a .pdf) \[default: don’t show\]"
    $parser new_opt T margin-top 0 "Set the top margin above which text\
        is ignored \[default 0; 0-144\]"
    $parser new_opt B margin-bottom 0 "Set the bottom margin below which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt L margin-left 0 "Set the left margin left of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt R margin-right 0 "Set the right margin right of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt "" pdftotext "" "Set the pdftotext executable’s path\
        \[default use system version\]"
    $parser new_opt "" algorithm fast "Set the algorithm \[default fast;\
        valid: fast normal special\]"
    $parser new_opt "" line-tolerance 10 "Set line-tolerance \[default\
        10; 2-22\]"
    $parser new_bool "" ignore-hyphens "Treat every hyphen as a space;\
        \[default recognize hyphens\]"
    $parser new_bool "" distinct-hyphens "Distinguish different types of\
        hyphen \[default normalize them\]"
    $parser new_bool "" distinct-ligatures "Distinguish ligatures\
        \[default normalize them, e.g., treat ﬁ as fi, ﬂ as fl, and so on\]"
    $parser new_opt "" change-bar-color #0000FF "Change bar color; set\
        to #FFFFFF (white) for no change bar \[default #0000FF\]"
    $parser new_opt "" transparency 80 "Transparency percentage \[default\
        80; 60-90\]"
    $parser new_opt "" margin-color #00FF00 "Margin color \[default\
        #00FF00\]"
    $parser new_opt "" delete-color #FF0000 "Delete color \[default\
        #FF0000\]"
    $parser new_opt "" insert-color #00FFFF "Insert color \[default\
        #00FFFF\]"
    $parser new_opt "" replace-color #FF00FF "Replace color \[default\
        #FF00FF\]"
    $parser new_bool v verbose "Show progress \[default don’t show\
        progress\]"
    $parser new_version V
    $parser new_help
    set argv [list -DsT72 -v -h --algorithm normal --transparency 90 \
        --margin-color=#A1B2C3 --delete-color #D4E5F6 \
        ~/commercial/pdfs/boson1.pdf ~/commercial/pdfs/boson1.pdf]
    puts "argv: $argv"
    try {
        set opts [$parser parse $argv]
    } on error err {
        if {$err ne "OnExit"} {
            puts "ERROR $err"
        }
    }
    #clop::dump $opts
}

proc test6 {} {
    puts "—————— test6 ——————"
    set parser [clop::Parser new comparepdf.tcl 1.0.0 2 \
        "Compare two PDFs texts’." \
        "The unit used throughout is the point (1/72\"). For colors\
        use HTML-style hex numbers."]
    $parser new_debug
    $parser new_opt r report "" "Report name (.pdf or .csv) \[default\
        is based on input PDFs’ names\]"
    $parser new_bool s show "Show report in default PDF viewer (only if\
        report is a .pdf) \[default: don’t show\]"
    $parser new_opt T margin-top 0 "Set the top margin above which text\
        is ignored \[default 0; 0-144\]"
    $parser new_opt B margin-bottom 0 "Set the bottom margin below which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt L margin-left 0 "Set the left margin left of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt R margin-right 0 "Set the right margin right of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt "" pdftotext "" "Set the pdftotext executable’s path\
        \[default use system version\]"
    $parser new_opt "" algorithm fast "Set the algorithm \[default fast;\
        valid: fast normal special\]"
    $parser new_opt "" line-tolerance 10 "Set line-tolerance \[default\
        10; 2-22\]"
    $parser new_bool "" ignore-hyphens "Treat every hyphen as a space;\
        \[default recognize hyphens\]"
    $parser new_bool "" distinct-hyphens "Distinguish different types of\
        hyphen \[default normalize them\]"
    $parser new_bool "" distinct-ligatures "Distinguish ligatures\
        \[default normalize them, e.g., treat ﬁ as fi, ﬂ as fl, and so on\]"
    $parser new_opt "" change-bar-color #0000FF "Change bar color; set\
        to #FFFFFF (white) for no change bar \[default #0000FF\]"
    $parser new_opt "" transparency 80 "Transparency percentage \[default\
        80; 60-90\]"
    $parser new_opt "" margin-color #00FF00 "Margin color \[default\
        #00FF00\]"
    $parser new_opt "" delete-color #FF0000 "Delete color \[default\
        #FF0000\]"
    $parser new_opt "" insert-color #00FFFF "Insert color \[default\
        #00FFFF\]"
    $parser new_opt "" replace-color #FF00FF "Replace color \[default\
        #FF00FF\]"
    $parser new_bool v verbose "Show progress \[default don’t show\
        progress\]"
    $parser new_version V
    $parser new_help
    set argv [list -D -s -T72 -v -V --algorithm normal --transparency 90 \
        --margin-color=#A1B2C3 --delete-color #D4E5F6 \
        ~/commercial/pdfs/boson1.pdf ~/commercial/pdfs/boson1.pdf]
    puts "argv: $argv"
    try {
        set opts [$parser parse $argv]
    } on error err {
        if {$err ne "OnExit"} {
            puts "ERROR $err"
        }
    }
    #clop::dump $opts
}

proc test7 {} {
    puts "—————— test7 ——————"
    set parser [clop::Parser new comparepdf.tcl 1.0.0 2 \
        "Compare two PDFs texts’." \
        "The unit used throughout is the point (1/72\"). For colors\
        use HTML-style hex numbers."]
    $parser new_debug
    $parser new_opt r report "" "Report name (.pdf or .csv) \[default\
        is based on input PDFs’ names\]"
    $parser new_bool s show "Show report in default PDF viewer (only if\
        report is a .pdf) \[default: don’t show\]"
    $parser new_opt T margin-top 0 "Set the top margin above which text\
        is ignored \[default 0; 0-144\]"
    $parser new_opt B margin-bottom 0 "Set the bottom margin below which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt L margin-left 0 "Set the left margin left of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt R margin-right 0 "Set the right margin right of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt "" pdftotext "" "Set the pdftotext executable’s path\
        \[default use system version\]"
    $parser new_opt "" algorithm fast "Set the algorithm \[default fast;\
        valid: fast normal special\]"
    $parser new_opt "" line-tolerance 10 "Set line-tolerance \[default\
        10; 2-22\]"
    $parser new_bool "" ignore-hyphens "Treat every hyphen as a space;\
        \[default recognize hyphens\]"
    $parser new_bool "" distinct-hyphens "Distinguish different types of\
        hyphen \[default normalize them\]"
    $parser new_bool "" distinct-ligatures "Distinguish ligatures\
        \[default normalize them, e.g., treat ﬁ as fi, ﬂ as fl, and so on\]"
    $parser new_opt "" change-bar-color #0000FF "Change bar color; set\
        to #FFFFFF (white) for no change bar \[default #0000FF\]"
    $parser new_opt "" transparency 80 "Transparency percentage \[default\
        80; 60-90\]"
    $parser new_opt "" margin-color #00FF00 "Margin color \[default\
        #00FF00\]"
    $parser new_opt "" delete-color #FF0000 "Delete color \[default\
        #FF0000\]"
    $parser new_opt "" insert-color #00FFFF "Insert color \[default\
        #00FFFF\]"
    $parser new_opt "" replace-color #FF00FF "Replace color \[default\
        #FF00FF\]"
    $parser new_bool v verbose "Show progress \[default don’t show\
        progress\]"
    $parser new_version V
    $parser new_help
    set argv [list -D -s -T72 -v --algorithm normal --transparency 90 \
        --margin-color=#A1B2C3 --delete-color #D4E5F6 \
        ~/commercial/pdfs/boson1.pdf ~/commercial/pdfs/boson1.pdf]
    puts "argv: $argv"
    try {
        set opts [$parser parse $argv]
        clop::dump $opts
    } on error err {
        if {$err ne "OnExit"} {
            puts "ERROR $err"
        }
    }
}

proc test8 {} {
    puts "—————— test8 ——————"
    set parser [clop::Parser new comparepdf.tcl 1.0.0 2 \
        "Compare two PDFs texts’." \
        "The unit used throughout is the point (1/72\"). For colors\
        use HTML-style hex numbers."]
    $parser new_debug
    $parser new_opt r report "" "Report name (.pdf or .csv) \[default\
        is based on input PDFs’ names\]"
    $parser new_bool s show "Show report in default PDF viewer (only if\
        report is a .pdf) \[default: don’t show\]"
    $parser new_opt T margin-top 0 "Set the top margin above which text\
        is ignored \[default 0; 0-144\]"
    $parser new_opt B margin-bottom 0 "Set the bottom margin below which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt L margin-left 0 "Set the left margin left of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt R margin-right 0 "Set the right margin right of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt "" pdftotext "" "Set the pdftotext executable’s path\
        \[default use system version\]"
    $parser new_opt "" algorithm fast "Set the algorithm \[default fast;\
        valid: fast normal special\]"
    $parser new_opt "" line-tolerance 10 "Set line-tolerance \[default\
        10; 2-22\]"
    $parser new_bool "" ignore-hyphens "Treat every hyphen as a space;\
        \[default recognize hyphens\]"
    $parser new_bool "" distinct-hyphens "Distinguish different types of\
        hyphen \[default normalize them\]"
    $parser new_bool "" distinct-ligatures "Distinguish ligatures\
        \[default normalize them, e.g., treat ﬁ as fi, ﬂ as fl, and so on\]"
    $parser new_opt "" change-bar-color #0000FF "Change bar color; set\
        to #FFFFFF (white) for no change bar \[default #0000FF\]"
    $parser new_opt "" transparency 80 "Transparency percentage \[default\
        80; 60-90\]"
    $parser new_opt "" margin-color #00FF00 "Margin color \[default\
        #00FF00\]"
    $parser new_opt "" delete-color #FF0000 "Delete color \[default\
        #FF0000\]"
    $parser new_opt "" insert-color #00FFFF "Insert color \[default\
        #00FFFF\]"
    $parser new_opt "" replace-color #FF00FF "Replace color \[default\
        #FF00FF\]"
    $parser new_bool v verbose "Show progress \[default don’t show\
        progress\]"
    $parser new_version V
    $parser new_help
    set argv [list -v --algorithm normal --transparency 90 \
        --margin-color=#A1B2C3 --delete-color #D4E5F6 -DsT72 \
        ~/commercial/pdfs/boson1.pdf ~/commercial/pdfs/boson1.pdf]
    puts "argv: $argv"
    try {
        set opts [$parser parse $argv]
        clop::dump $opts
    } on error err {
        if {$err ne "OnExit"} {
            puts "ERROR $err"
        }
    }
}

proc test9 {} {
    puts "—————— test9 ——————"
    set parser [clop::Parser new comparepdf.tcl 1.0.0 2 \
        "Compare two PDFs texts’." \
        "The unit used throughout is the point (1/72\"). For colors\
        use HTML-style hex numbers."]
    $parser new_debug
    $parser new_opt r report "" "Report name (.pdf or .csv) \[default\
        is based on input PDFs’ names\]"
    $parser new_bool s show "Show report in default PDF viewer (only if\
        report is a .pdf) \[default: don’t show\]"
    $parser new_opt T margin-top 0 "Set the top margin above which text\
        is ignored \[default 0; 0-144\]"
    $parser new_opt B margin-bottom 0 "Set the bottom margin below which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt L margin-left 0 "Set the left margin left of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt R margin-right 0 "Set the right margin right of which\
        text is ignored \[default 0; 0-144\]"
    $parser new_opt "" pdftotext "" "Set the pdftotext executable’s path\
        \[default use system version\]"
    $parser new_opt "" algorithm fast "Set the algorithm \[default fast;\
        valid: fast normal special\]"
    $parser new_opt "" line-tolerance 10 "Set line-tolerance \[default\
        10; 2-22\]"
    $parser new_bool "" ignore-hyphens "Treat every hyphen as a space;\
        \[default recognize hyphens\]"
    $parser new_bool "" distinct-hyphens "Distinguish different types of\
        hyphen \[default normalize them\]"
    $parser new_bool "" distinct-ligatures "Distinguish ligatures\
        \[default normalize them, e.g., treat ﬁ as fi, ﬂ as fl, and so on\]"
    $parser new_opt "" change-bar-color #0000FF "Change bar color; set\
        to #FFFFFF (white) for no change bar \[default #0000FF\]"
    $parser new_opt "" transparency 80 "Transparency percentage \[default\
        80; 60-90\]"
    $parser new_opt "" margin-color #00FF00 "Margin color \[default\
        #00FF00\]"
    $parser new_opt "" delete-color #FF0000 "Delete color \[default\
        #FF0000\]"
    $parser new_opt "" insert-color #00FFFF "Insert color \[default\
        #00FFFF\]"
    $parser new_opt "" replace-color #FF00FF "Replace color \[default\
        #FF00FF\]"
    $parser new_bool v verbose "Show progress \[default don’t show\
        progress\]"
    $parser new_version V
    $parser new_help
    set argv [list -DsT72 -v --algorithm normal --transparency 90 \
        --margin-color=#A1B2C3 --delete-color #D4E5F6 \
        ~/commercial/pdfs/boson1.pdf ~/commercial/pdfs/boson1.pdf]
    puts "argv: $argv"
    try {
        set opts [$parser parse $argv]
        clop::dump $opts
    } on error err {
        if {$err ne "OnExit"} {
            puts "ERROR $err"
        }
    }
}

proc test10 {} {
    puts "—————— test10 ——————"
    set parser [clop::Parser new efind 1.0.0 0-255 \
        "Searches for files that match WHAT in . or in any specified\
        folders, including recursively into subfolders. WHAT is either\
        .ext or text or integer, e.g., .tcl or .py; or readme. For .tcl\
        searches *.{tcl,tm,tk}; for .py *.{py,pyw}; for .c *.{c,h}; for\
        .cpp or .c++ *.{h,hxx,hpp,h++,C, cc,cp,cxx,cpp,CPP,c++}; for\
        integer means files modified since that many days ago, 0 being\
        today, 1 yesterday, etc; others as is."]
    $parser new_debug
    $parser new_bool c casesensitive "Respect case \[default ignore case\]"
    $parser new_bool i ignore "Ignore what’s listed in ~/.config/efind.lst"
    $parser new_opt x exclude "" "Exclude the given file/folder; this\
        option may be repeated" 1
    $parser new_bool H hidden "Search hidden files and folders \[default\
        not to\]"
    $parser new_bool v verbose "Show progress \[default don’t show\
        progress\]"
    $parser new_version V
    $parser new_help
    set argv [list -cDi -x README -x README.md -x README.txt -H]
    puts "argv: $argv"
    try {
        set opts [$parser parse $argv]
        clop::dump $opts
    } on error err {
        if {$err ne "OnExit"} {
            puts "ERROR $err"
        }
    }
}

proc test11 {} {
    puts "—————— test11 ——————"
    set parser [clop::Parser new pos-0 1.0.0 0 "The help text"]
    $parser new_debug
    $parser new_bool v verbose "Show progress \[default don’t show\]"
    $parser new_version V
    $parser new_help
    try {
        set opts [$parser parse -h]
        clop::dump $opts
    } on error err {
        if {$err ne "OnExit"} {
            puts "ERROR $err"
        }
    }
}

test1
test2
test3
test4
test5
test6
test7
test8
test9
test10
test11
# TODO test for validation
# TODO test for error handling
