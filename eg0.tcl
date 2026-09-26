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
    set parser [clop::Parser new efind 1.0.0 1-255 \
	"Searches for files that match %bWHAT%!." "" \
	"%bWHAT%! is what to search for; %g%IDIR1 DIR2%! … are the\
	folders to search \[default %B.%!\]."]
    $parser set_positional_names WHAT DIR
    $parser new_debug
    $parser new_bool c casesensitive "Respect case \[default %mignore\
	    case%!\]."
    $parser new_opt x exclude "" "Exclude the given file/folder; %Ithis\
	option may be repeated%!." 1 EXCL
    $parser new_bool v verbose "Show progress \[default %mdon’t\
	    showprogress%!\]."
    $parser new_version V
    $parser new_help
    if {![llength $::argv]} { $parser on_help }
    set opts [$parser parse $::argv]
    clop::dump $opts
}

main
