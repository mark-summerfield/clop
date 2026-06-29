#!/usr/bin/env tclsh9
# Copyright © 2026 Mark Summerfield. All rights reserved.

if {![catch {file readlink [info script]} name]} {
    const APPPATH [file dirname $name]
} else {
    const APPPATH [file normalize [file dirname [info script]]]
}
tcl::tm::path add $APPPATH

package require clop 2

proc main {} {
    lassign [get_opts] subcmd opts
    puts "subcmd«$subcmd»"
    clop::dump $opts
}

proc get_opts {} {
    if {![llength $::argv]} {
        return [list status [dict create % {} verbose 0]]
    }
    set parser [clop::Parser new str 1.0.0 255 \
        "Stores generational copies of specified files (excluding those
        explicitly ignored) in %y%I.dirname%!%y.str%!. (For a GUI run
        %B%bstore%!.)" \
        "%I%b@GID%! — @-prefixed generation number or tag name, (e.g.,\
        %y@28%!, %y@alpha1%!); if unspecified, the current generation is\
        assumed. %I%bGLOB%! — when using globs for ignore or unignore\
        use quotes to avoid shell expansion of glob characters (e.g.,\
        %y'*.o'%!). Subcommands that print output to %ystdour%! unless\
        redirected by the shell. For help on a specific subcommand follow\
        the subcommand with %g-h%! or %g--help%! or just use %gh%! or\
        %ghelp%! for full help."]
    $parser new_debug

    set status_parser [clop::subparser status $parser 0 \
        "Show the store’s status." \
        "Status reports any unstored unignored nonempty files and\
        whether updates or cleaning are needed. \[Default action for\
        %B%bstr%! with no arguments.\]"]
    $status_parser new_bool v verbose \
        "Show the name of every new/changed file \[default %mjust show\
        counts%!\]."
    $status_parser new_help h help "Show status help and quit."
    $parser new_subcommand s status $status_parser \
        "Show the store’s status."

    set update_parser [clop::subparser update $parser 0-1 \
        "Create a new generation with an optional tag." \
        "Updates all the files in the store by creating a new generation\
        and storing all those that have changed." \
        "For the %bTAG%! use quotes if multiple words."]
    $update_parser set_positional_names TAG
    $update_parser new_bool v verbose \
        "Show the name of every updated file \[default %mjust show\
        counts%!\]."
    $update_parser new_help h help "Show update help and quit."
    $parser new_subcommand u update $update_parser

    set add_parser [clop::subparser add $parser 0-255 \
        "Add the addable or the given files and folders." \
        "Add the given files and the files in the given folders to the\
        store. If none given then adds the files in the current folder and\
        its immediate subfolders, except for those ignored or empty,\
        creating the store if necessary." \
        "The given files and folders to add."]
    $add_parser new_bool v verbose \
        "Show the name of every added file \[default %mjust show\
        counts%!\]."
    $add_parser new_help h help "Show add help and quit."
    $parser new_subcommand a add $add_parser

    set extract_parser [clop::subparser extract $parser 1-255 \
        "Extract the specified files." \
        "Extract the given filenames at the generation, e.g.,\
        %yfilename.ext%! will be extracted as %yfilename@gid.ext%!, etc." \
        "%I%g@GID%! is the generation to extract \[default current\];\
        %bFILE1 … FILEn%! are the files to extract."]
    $extract_parser set_positional_line \
        "%I%g\[@GID\]%! %b<FILE1> … <FILEn>%!"
    $extract_parser new_bool v verbose \
        "Show the name of every extractd file \[default %mjust show\
        counts%!\]."
    $extract_parser new_help h help "Show extract help and quit."
    $parser new_subcommand e extract $extract_parser

    set print_parser [clop::subparser print $parser 1-2 \
        "Print the given file." \
        "Print the given file from the store at the given (or current
        if not specified) generation. (Should only be used for %Iplain
        text files%!!)." \
        "%I%g@GID%! is the generation to print from \[default current\];\
        %bFILE%! is the file to print."]
    $print_parser set_positional_line "%I%g\[@GID\]%! %b<FILE>%!"
    $print_parser new_help h help "Show print help and quit."
    $parser new_subcommand p print $print_parser

    set copy_parser [clop::subparser copy $parser 1-2 \
        "Copy a generation to the given folder." \
        "Copy all the files at the given or current generation into
        the given folder (which must not exist)." \
        "%I%g@GID%! is the generation to copy from \[default current\];\
        %bFOLDER%! is the folder to create and copy into."]
    $copy_parser set_positional_names @GID FOLDER
    $copy_parser set_positional_line "%g\[@GID\]%! %b<FOLDER>%!"
    $copy_parser new_bool v verbose "Show the name of every copied file."
    $copy_parser new_help h help "Show copy help and quit."
    $parser new_subcommand c copy $copy_parser

    set diff_parser [clop::subparser diff $parser 2-3 \
        "Diff the given file." \
        "Diff the filename at %b@GID1%! against the one in the current\
        folder, or against the one stored at %I%g@GID2%! if given; shows\
        the entire file, unless quiet is specified when only differences\
        and context lines are shown."\
        "%b@GID1%! is the first generation; %I%g@GID2%! is the second\
        generation \[default current\]; %bFILE%! is the file to diff at\
        these generations."]
    $diff_parser set_positional_line \
        "%b<@GID1>%! %I%g\[@GID2\]%! %b<FILE>%!"
    $diff_parser new_bool q quiet "Show the differences and some context\
        only \[default show the whole file\]."
    $diff_parser new_help h help "Show diff help and quit."
    $parser new_subcommand d diff $diff_parser

    set filenames_parser [clop::subparser filenames $parser 0-1 \
        "List the tracked files." "" \
        "%I%g@GID%! is the generation to list \[default current\]."]
    $filenames_parser set_positional_names @GID
    $filenames_parser new_help h help "Show filenames help and quit."
    $parser new_subcommand f filenames $filenames_parser

    set generations_parser [clop::subparser generations $parser 0 \
        "Print the generations." \
        "Print the generations (and all their filenames if %I%g--full%!)."]
    $generations_parser new_bool f full "Show filenames."
    $generations_parser new_help h help "Show generations help and quit."
    $parser new_subcommand g generations $generations_parser

    set gui_parser [clop::subparser gui $parser 0 "Start the gui."]
    $gui_parser new_help h help "Show gui help and quit."
    $parser new_subcommand G gui $gui_parser

    set history_parser [clop::subparser history $parser 1 \
        "Print the given file’s history." "" \
        "The file to print the history of."]
    $history_parser new_help h help "Show history help and quit."
    $parser new_subcommand H history $history_parser

    set ignore_parser [clop::subparser ignore $parser 1-255 \
        "Add the given files/folders/globs to the ignore list." \
        "Add the given filenames, folders, and globs to the ignore list." \
        "Each %bITEM%! is a file or a folder or a glob pattern."]
    $ignore_parser set_positional_names ITEM ITEM
    $ignore_parser new_help h help "Show ignore help and quit."
    $parser new_subcommand i ignore $ignore_parser

    set ignores_parser [clop::subparser ignores $parser 0 \
        "Print the ignore list."]
    $ignores_parser new_help h help "Show ignores help and quit."
    $parser new_subcommand I ignores $ignores_parser

    set unignore_parser [clop::subparser unignore $parser 1-255 \
        "Remove the given files/folders/globs from the ignore list." \
        "Remove the given filenames, folders, and globs from the ignore\
        list." \
        "Each %bITEM%! is a file or a folder or a glob pattern."]
    $unignore_parser set_positional_names ITEM ITEM
    $unignore_parser new_help h help "Show unignore help and quit."
    $parser new_subcommand U unignore $unignore_parser

    set tag_parser [clop::subparser tag $parser 1-2 \
        "Set the tag for the current or given generation to the given\
        tag." "" \
        "%I%g@GID%! is the generation to tag \[default current\]. For the\
        %bTAG%! use quotes if multiple words."]
    $tag_parser set_positional_line "%g<@GID>%! %b<TAG>%!"
    $tag_parser new_help h help "Show tag help and quit."
    $parser new_subcommand t tag $tag_parser

    set untag_parser [clop::subparser untag $parser 0-1 \
        "Untag the current or given generation." "" \
        "%I%g@GID%! is the generation to untag \[default current\]."]
    $untag_parser set_positional_names GID
    $untag_parser new_help h help "Show untag help and quit."
    $parser new_subcommand "" untag $untag_parser

    set untracked_parser [clop::subparser untracked $parser 0 \
        "Print any untracked files."]
    $untracked_parser new_help h help "Show untracked help and quit."
    $parser new_subcommand T untracked $untracked_parser

    set restore_parser [clop::subparser restore $parser 1-255 \
        "Restore the specified files %I%moverwriting those on disk!%!" \
        "Restore the specified files by %I%moverwriting those on disk%!\
        with those from the store." "The files to restore."]
    $restore_parser new_help h help "Show restore help and quit."
    $parser new_subcommand "" restore $restore_parser

    set clean_parser [clop::subparser clean $parser 0 \
        "Cleans the store by deleting empty generations." \
        "Cleans the store by deleting empty generations, i.e., those\
        without any changes."]
    $clean_parser new_help h help "Show clean help and quit."
    $parser new_subcommand C clean $clean_parser

    set purge_parser [clop::subparser purge $parser 1 \
        "Purge the given file from the store." \
        "Purge the given file from the store by deleting every copy of\
        it at every generation." "The file to purge from the store."]
    $purge_parser new_help h help "Show purge help and quit."
    $parser new_subcommand "" purge $purge_parser

    set help_parser [clop::subparser add $parser 0 "Full help."]
    $parser new_help_subcommand h help $help_parser

    $parser new_version
    $parser new_help h help "Show this help and quit. Use %gh%! or\
        %ghelp%! for full help."
    set opts [$parser parse $::argv]
    list [dict get $opts *] $opts 
}

main
