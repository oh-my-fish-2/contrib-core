# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/magic-enter

function magic-enter-command \
    --description "Prints the command to run when no command was given"

    if command git rev-parse --is-inside-work-tree &>/dev/null
        if set -q MAGIC_ENTER_GIT_COMMAND
            echo $MAGIC_ENTER_GIT_COMMAND
        else
            echo "git status -u ."
        end
    else
        if set -q MAGIC_ENTER_OTHER_COMMAND
            echo $MAGIC_ENTER_OTHER_COMMAND
        else
            echo "ls -lh ."
        end
    end
end

function magic-enter \
    --description "Function bound to 'enter' that makes it magical"

    set --local cmd (commandline)
    if test -z "$cmd"
        commandline -r (magic-enter-command)
        commandline -f suppress-autosuggestion
    end
    commandline -f execute
end
bind --user \r magic-enter
