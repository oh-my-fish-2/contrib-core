# Add this plugin's functions directory to Fish's function path
set -l funcdir (path resolve (status dirname))/functions
if not contains $funcdir $fish_function_path
    set fish_function_path $fish_function_path $funcdir
end
