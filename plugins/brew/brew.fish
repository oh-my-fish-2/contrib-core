# Find the brew command
set brewcmds (
    path filter \
        $HOME/.homebrew/bin/brew \
        $HOME/.linuxbrew/bin/brew \
        /opt/homebrew/bin/brew \
        /usr/local/bin/brew
    )
if test (count $brewcmds) -eq 0
    echo >&2 "brew command not found. Install from https://brew.sh"
    return 1
end
$brewcmds[1] shellenv | source

function brewdesc -d 'Show descriptions of brew installs'
    brew leaves |
        xargs brew desc --eval-all |
        string replace -r '^(.*:)(\s+[^\[].*)$' '$1'(set_color blue)'$2'(set_color normal)
end

function brews -d "Show brewed formulae"
    set -l formulae (brew leaves | xargs brew deps --installed --for-each)
    set -l casks (brew list --cask 2>/dev/null)

    echo (set_color blue)"==>"(set_color --bold normal)" Formulae"(set_color normal)
    string replace -r '^(.*):(.*)$' '$1'(set_color blue)'$2'(set_color normal) $formulae
    echo
    echo (set_color blue)"==>"(set_color --bold normal)" Casks"(set_color normal)
    printf '%s\n' $casks
end

function brewup -d 'Update homebrew, upgrade installed packages, and cleanup'
    brew update && brew upgrade && brew cleanup
end

# If the brew path is owned by another user, wrap it so brew commands
# are executed as the brew owner.
set -gx HOMEBREW_OWNER (stat -f "%Su" $HOMEBREW_PREFIX)
if test $HOMEBREW_OWNER != (whoami)
    function brew --description 'Wrap brew with sudo for multi-user systems'
        sudo -Hu $HOMEBREW_OWNER brew $argv
    end
end

# Ensure manpath is set to something so we can add to it.
set -q MANPATH || set -gx MANPATH ''

# Add keg-only apps
set -q HOMEBREW_KEG_ONLY_APPS || set -U HOMEBREW_KEG_ONLY_APPS ruby curl sqlite
for app in $HOMEBREW_KEG_ONLY_APPS
    if test -d "$HOMEBREW_PREFIX/opt/$app/bin"
        fish_add_path "$HOMEBREW_PREFIX/opt/$app/bin"
        set MANPATH "$HOMEBREW_PREFIX/opt/$app/share/man" $MANPATH
    end
end

# Add fish completions
if test -e "$HOMEBREW_PREFIX/share/fish/completions"
    set --append fish_complete_path "$HOMEBREW_PREFIX/share/fish/completions"
end

# Other homebrew vars.
set -q HOMEBREW_NO_ANALYTICS || set -gx HOMEBREW_NO_ANALYTICS 1
