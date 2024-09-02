function man --wraps man --description 'Format and display manual pages'
    set -q LESS_TERMCAP_md || set -lx LESS_TERMCAP_md (set_color --bold blue)
    set -q LESS_TERMCAP_mb || set -lx LESS_TERMCAP_mb (set_color --bold blue)
    set -q LESS_TERMCAP_so || set -lx LESS_TERMCAP_so (set_color --reverse brwhite)
    set -q LESS_TERMCAP_us || set -lx LESS_TERMCAP_us (set_color --underline magenta)
    set -q LESS_TERMCAP_se || set -lx LESS_TERMCAP_se (set_color normal)
    set -q LESS_TERMCAP_ue || set -lx LESS_TERMCAP_ue (set_color normal)
    set -q LESS_TERMCAP_me || set -lx LESS_TERMCAP_me (set_color normal)
    set -q LESS || set -lx LESS '-R -s'

    set -lx GROFF_NO_SGR yes # fedora

    set -lx MANPATH (string join : $MANPATH)
    if test -z "$MANPATH"
        type -q manpath && set MANPATH (command manpath)
    end

    set -l fish_manpath (dirname $__fish_data_dir)/fish/man
    if test -d "$fish_manpath" -a -n "$MANPATH"
        set MANPATH "$fish_manpath":$MANPATH
        command man $argv
        return
    end
    command man $argv
end
