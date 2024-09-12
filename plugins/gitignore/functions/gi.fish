function gi --description "Generate a git ignore file"
    set --local usage "usage: gi [-h|--help] [-l|--list] <TEMPLATES...>"

    argparse --name=gi h/help l/list -- $argv
    or begin
        echo $usage
        return 1
    end

    if test -n "$_flag_list"
        set --local thisdir (path resolve (status dirname))
        if test (find $thisdir -type f -name ".gi_templates" -mmin +1200 | count) -eq 0
            curl -sfL https://www.toptal.com/developers/gitignore/api/list | tr "," "\n" >$thisdir/.gi_templates
        end
        cat $thisdir/.gi_templates
        return
    end

    if test (count $argv) -eq 0 || test -n "$_flag_help"
        echo $usage
        return
    end

    set --local templates (string join , $argv)
    curl -fLw '\n' https://www.toptal.com/developers/gitignore/api/$templates
end
