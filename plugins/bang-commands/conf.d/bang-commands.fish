# BSD 3-Clause License

# Copyright (c) 2023, Finn Brewer

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.

# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.

# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

function last_history_item
    echo $history[1]
end

function nth_history_item
    # Times by negative one because in fish $history[1] is the last used command
    # while running !1 in bash returns the first command in your history ($history[-1] in fish)
    set index (math (echo $argv[1] | cut -c 2- ) x -1)
    echo $history[$index]
end

function _nth_history_arg
    commandline -f backward-delete-char
    echo $history[1] | read -t --list args
    for _i in (seq 1 (math (count $args) - $argv[1]))
        commandline -f history-token-search-backward
    end
end

function last_history_arg
    commandline -f backward-delete-char
    commandline -f history-token-search-backward
end

function first_history_arg
    _nth_history_arg 1
end

function history_args
    echo (string split --max 1 " " $history[1])[2]
end

function nth_history_arg
    _nth_history_arg (echo $argv[1] | cut -c 3-)
end

function history_prefix_search
    set cmd (echo $argv[1] | cut -c 2- )
    history -p $cmd | head -n 1
end

function history_search
    set cmd (echo $argv[1] | cut -c 3- )
    history $cmd | head -n 1
end


# Commmands
abbr -a bang_history_prefix_search --position anywhere --regex '!([a-zA-Z0-9_.-]*)' --function history_prefix_search # !dnf returns the last command that started with dnf
abbr -a bang_history_search --position anywhere --regex '!\?([a-zA-Z0-9_.-]*)' --function history_search # !?abc returns the last command that included abc

abbr -a bang_negative_nth_history_item --position anywhere --regex '!-?([0-9]*)' --function nth_history_item # !3 returns the 3rd command used. !-3 returns the 3rd most recent command used.
abbr -a !! --position anywhere --function last_history_item # !! returns the last command. Taken from the fish documentation

# Arguments
abbr -a !^ --position anywhere --function first_history_arg # !^ returns the first argument of the last command
abbr -a !\$ --position anywhere --function last_history_arg # !$ returns the last argument of the last command
abbr -a !\* --position anywhere --function history_args # !* returns all arguments of the last command
abbr -a bang_nth_arg --position anywhere --regex '!:([0-9]*)' --function nth_history_arg # !$ returns the last argument of the last command
