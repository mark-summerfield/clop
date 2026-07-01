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

set ::clop::OnExit [lambda {{code 0}} { puts "—————— exit $code ——————" }]

proc test0 {} {
    set parser [clop::Parser new test-positionals=0 1.0.0 0 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test1 {} {
    set parser [clop::Parser new test-positionals=1 1.0.0 1 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test2 {} {
    set parser [clop::Parser new test-positionals=2 1.0.0 2 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test3 {} {
    set parser [clop::Parser new test-positionals=3 1.0.0 3 \
                "positionals test"]
    $parser set_positional_names WHAT DIR
    $parser new_help
    set opts [$parser parse -h]
}

proc testn {} {
    set parser [clop::Parser new test-positionals=255 1.0.0 255 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test0-1 {} {
    set parser [clop::Parser new test-positionals=0-1 1.0.0 0-1 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test0-2 {} {
    set parser [clop::Parser new test-positionals=0-2 1.0.0 0-2 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test0-3 {} {
    set parser [clop::Parser new test-positionals=0-3 1.0.0 0-3 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test0-255 {} {
    set parser [clop::Parser new test-positionals=0-255 1.0.0 0-255 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test1-2 {} {
    set parser [clop::Parser new test-positionals=1-2 1.0.0 1-2 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test1-3 {} {
    set parser [clop::Parser new test-positionals=1-3 1.0.0 1-3 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test1-255 {} {
    set parser [clop::Parser new test-positionals=1-255 1.0.0 1-255 \
                "positionals test"]
    $parser set_positional_names WHAT DIR
    $parser new_help
    set opts [$parser parse -h]
}

proc test2-3 {} {
    set parser [clop::Parser new test-positionals=2-3 1.0.0 2-3 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test2-255 {} {
    set parser [clop::Parser new test-positionals=2-255 1.0.0 2-255 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test3-255 {} {
    set parser [clop::Parser new test-positionals=3-255 1.0.0 3-255 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test4-255 {} {
    set parser [clop::Parser new test-positionals=4-255 1.0.0 4-255 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

proc test5-255 {} {
    set parser [clop::Parser new test-positionals=5-255 1.0.0 5-255 \
                "positionals test"]
    $parser new_help
    set opts [$parser parse -h]
}

test0
test1
test2
test3
testn
test0-1
test0-2
test0-3
test0-255
test1-2
test1-3
test1-255
test2-3
test2-255
test3-255
test4-255
test5-255
