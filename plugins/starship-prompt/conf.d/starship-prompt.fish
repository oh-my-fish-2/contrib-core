# Disable new user greeting.
set fish_greeting

# Ensure starship.
if not type -q starship
    echo >&2 "Starship prompt not found. Either it's not installed, or not in your \$PATH"
    echo >&2 "See https://starship.rs"
end

# Set default STARSHIP_CONFIG.
if not set -qU STARSHIP_CONFIG
    set -Ux STARSHIP_CONFIG (path resolve (status dirname)/../../../themes/omf2.toml)
end

# Remove any inherited one.
set -eg STARSHIP_CONFIG

# Initialize starship.
starship init fish | source

# Handle truncating prior prompts after each command (aka: transience)
if test "$starship_enable_transience" = 1
    enable_transience
end

# Provide an exported vi_mode_symbol variable for Starship to use
function on_fish_bind_mode --on-variable fish_bind_mode
    set --global --export vi_mode_symbol ""
    set --local color
    set --local char
    if test "$fish_key_bindings" = fish_vi_key_bindings
        switch $fish_bind_mode
            case default
                set color red
                set symbol N
            case insert
                set color green
                set symbol I
            case replace replace_one
                set color green
                set symbol R
            case visual
                set color brmagenta
                set symbol V
            case '*'
                set color cyan
                set symbol "?"
        end
        set vi_mode_symbol (set_color --bold $color)"[$symbol]"(set_color normal)
    end
end
