# Command Line Option Parser (clop)

The clop module supports command line option parsing.

The module is developed and tested on Linux and should work on any
non-proprietary Unix.

### Overview

The clop module can handle short and long Boolean options, e.g., `-a` and
`--best`, and short and long value-accepting options, e.g., `-m72`, `-m=72`,
`-m 72`, `--margin=72`, `--margin 72`.

It can also handle bundled short Boolean options with the last option either
a Boolean or value-accepting, e.g., `-adg`, `-adgm72, `-adgm=72, `-adgm 72`.

Using `--` separates options from positionals (but isn’t normally needed).

The positional count is specified as an exact count (which may be `0`), or a
range of counts, e.g., `1-3`. For “unlimited”, use an upper bound of `255`,
e.g, `1-255` if at least one is required or `0-255` if all are optional.

The module can also handle subcommands, each of which may have its own
command line options.

The clop module does not provide any typing or validation beyond matching
option names and for Boolean or value-accepting.

Pre- and post- help text, and option and positional help text, all support
the following escapes:

- `%B` bold on
- `%I` italic on
- `%r` red on (used by on\_warn and on\_error)
- `%g` green on (used to signify optional)
- `%b` blue on (used to signify required)
- `%c` cyan on (recommended for showing acceptable values)
- `%m` magenta on (used for default values)
- `%y` yellow on
- `%!` everything off
- `%%` literal `%`

In addition, option help texts also support:

- `%D` the option’s default value

Options that take a value use their longname (or shortname if no longname is
specified) as their argument name; this can be overridden by passing an
`argname`.

If at least one positional argument is required and you want help to be
shown if no positionals are present, put this line immediately before the
call to `parse`, e.g.,:

```tcl
    if {!$::argc} { $parser on_help }
    set opts [$parser parse $::argv]
```

For multi-valued options, either set `repeatable` to `1` (true) so the user
can repeat the option (recommended), or designate a separator (e.g., `:`)
and pass multiple values as a single string using the separator.

The parser returns a `dict` mapping option names (as keys) to their values.
Every option is returned with its long name as key (or short name for
options that don’t have a long name), and with a default value if not set
during parsing. The returned `dict` always contains two special keys, `%`
whose value is a (possibly empty) list of positional arguments, and `*`
whose value is the name of the subcommand that was used (or `""` if no
subcommand was used). 

## API

### Create a Parser

#### `clop::Parser new appname appversion positional_count prehelp posthelp positional_help`

Create a new parser; `appname` and `appversion` are required.

### Create a Subcommand Parser (a Subparser)

#### `clop::subparser name parser positional_count shorthelp longhelp positional_help`

Create a subparser; the first two arguments are required. The name is the
subcommand’s name and the parser should be the main parser (created with
`clop::Parser new`).

### Configure a Parser or Subparser

#### `$parser set_positional_names positional_name1 positional_name_n`

Replace the positional argument names `FILE` (for the first positional) and
`FILE` (which becomes `FILE1`, `FILE2`, … `FILEn`) to alternative names.

For example, the `efind.tcl` tool uses the names `WHAT` and `DIR`.

#### `$parser set_positional_line line`

In some situations changing the positional argument names isn’t sufficient
for customizing the positional arguments. In these cases the positional
arguments can be represented by setting the line to output.

For example, the `str` tool’s `diff` subcommand uses the positional line:  
`"%b<@GID1>%! %I%g\[@GID2\]%! %b<FILE>%!"`

### Add Options to a Parser or Subparser

#### `$parser new_help shortname longname help`

Add a new help option; all arguments are optional and default to `h` (for
`-h`), `help` (for `--help`), and `Show this help and quit.`

#### `$parser new_version shortname longname help`

Add a new version option; all arguments are optional and default to `v` (for
`-v`), `version` (for `--version`), and `Show version and quit.`

#### `$parser new_debug shortname longname`

Add a new (hidden) debug option; both arguments are optional and default to
`D` (for `-D`) and `debug` (for `--debug`).

#### `$parser new_bool shortname longname help`

Add a new Boolean option; all arguments are required.

#### `$parser new_opt shortname longname defvalue help repeatable argname`

Add a new option; the first four arguments are required. Repeatable defaults
to `0` (no repeats allowed) and `argname` to `""` so the argument’s name is
the same as the `longname` (if nonempty) otherwise the `shortname`.

#### `$parser new_hidden shortname longname defvalue help repeatable argname`

Add a new hidden option; the first four arguments are required. Repeatable
defaults to `0` (no repeats allowed) and `argname` to `""` so the argument’s
name is the same as the `longname` (if nonempty) otherwise the `shortname`.

#### `$parser new_subcommand shortname longname subparser help`

Add a new subcommand; the first three arguments are required and the fourth
is recommended. The subparser should be one created by `clop::subparser`.

#### `$parser new_help_subcommand shortname longname subparser help`

Add a new help subcommand; the first three arguments are required; shortname
is normally `h`, longname `help`, and the subparser should be one created by
`clop::subparser`. The `help` argument defaults to `Show full help.`.

#### `$parser parse argv`

Parse the given list of arguments (typically `$::argv`) and return a `dict`
mapping option names (as keys) to their values. Every option is returned
with its long name as key (or short name for options that don’t have a long
name), and with a default value if not set during parsing. The returned
`dict` always contains two special keys, `%` whose value is a (possibly
empty) list of positional arguments, and `*` whose value is the name of the
subcommand that was used (or `""` if no subcommand was used). 

### Error Handling

Although the parser and its methods do some basic validation and error
handling, for options that take a value and for positionals, they know
nothing about any constraints that may apply. For example, an option might
take an integer within a certain range. For this reason, after parsing it is
common practice to validate the items in the returned `dict`.

The `clop` package provides two commands that it uses for its own warnings
and error messages that are also available to users.

#### `clop::on_warn msg`

Prints the given message prefixed with “`warning: `” in red on the console.

#### `clop::on_error msg ecode`

Prints the given message prefixed with “`error: `” in red on the console and
then exits with error code `1` or with `ecode` if given.

## Examples

See `eg[12].tcl` for basic examples of use, and `eg3.tcl` for an example
that shows how to handle subcommands. The following examples have been
redirected to files so color has been removed and they are wrapped at 72
columns rather than the terminal width.

### Example: `efind.tcl -h` _or_ `efind.tcl --help`

```
usage: efind [OPTIONS] <WHAT> [DIR1 … [DIRn]]

Searches for files that match WHAT in . or in any specified folders,
including recursively into subfolders. WHAT is either .ext or text
or integer, e.g., .tcl or .py; or readme. For .tcl searches
*.{tcl,tm,tk}; for .py *.{py,pyw}; for .c *.{c,h}; for .cpp or .c++
*.{h,hxx,hpp,h++,C,cc,cp,cxx,cpp,CPP,c++}; for integer means files
modified since that many days ago, 0 being today, 1 yesterday, etc;
others as is.

POSITIONALS:
  WHAT is what to search for; DIR1 DIR2 … are the folders to
  search [default .].

OPTIONS:
  -c or --casesensitive  Respect case [default ignore case].
  -i or --ignore         Ignore what’s listed in ~/.config/efind.lst.
  -x or --exclude EXCL   Exclude the given file/folder; this option
                         may be repeated.
  -H or --hidden         Search hidden files and folders [default
                         ignore hiddens].
  -v or --verbose        Show progress [default don’t show progress].
  -V or --version        Show version and quit.
  -h or --help           Show this help and quit.
```

The `eg2.tcl` example is very similar.

### Example: Store command line tool

#### `str -h` _or_ `str --help`

```
usage: str SUBCOMMAND [OPTIONS] …

Stores generational copies of specified files (excluding those
explicitly ignored) in .dirname.str. (For a GUI run
store.)

SUBCOMMANDS:
s or status       Report the store’s status.
u or update       Create a new generation with an optional tag.
a or add          Add the addable or the given files and folders.
e or extract      Extract the specified files.
p or print        Print the given file.
c or copy         Copy a generation to the given folder.
d or diff         Diff the given file.
f or filenames    Print the list of tracked files.
g or generations  Print the generations.
G or gui          Start the gui.
H or history      Print the given files’ list of generations.
i or ignore       Add the given files/folders/globs to the ignore list.
I or ignores      Print the list of files to ignore.
U or unignore     Remove the given files/folders/globs from the ignore
                  list.
t or tag          Set or replace the tag for the current or given
                  generation.
untag             Untag the current or given generation.
T or untracked    Print any untracked files.
restore           Restore the specified files overwriting those on
                  disk!
C or clean        Clean the store by deleting empty generations.
purge             Purge the given file from the store.
h or help         Show full help.

OPTIONS:
  -v or --version  Show version and quit.
  -h or --help     Show this help and quit. Use h or help for
                   full help.

@GID — @-prefixed generation number or tag name, (e.g., @28,
@alpha1); if unspecified, the current generation is assumed.
GLOB — when using globs for ignore or unignore use quotes to avoid
shell expansion of glob characters (e.g., '*.o'). Subcommands that
print output to stdour unless redirected by the shell. For help on a
specific subcommand follow the subcommand with -h or --help or
just use h or help for full help.
```

#### `str d -h` _or_ `str diff --help`

```
usage: str diff [OPTIONS] <@GID1> [@GID2] <FILE>

Diff the filename at @GID1 against the one in the current folder, or
against the one stored at @GID2 if given; shows the entire file,
unless quiet is specified when only differences and context lines are
shown.

POSITIONALS: 
  @GID1 is the first generation; @GID2 is the second
  generation [default current]; FILE is the file to diff at these
  generations.

OPTIONS:
  -q or --quiet  Show the differences and some context only [default
                 show the whole file].
  -h or --help   Show diff help and quit.
```

The `eg3.tcl` example is similar.

## Dependencies

Tcl/Tk >= 9.0.2; Tcllib >= 2.0.

All the code is in the module file `clop-2.tm`.

## License

GPL-3
