# The MIT License (MIT)
# Copyright (c) 2016 Diego Zamboni
# Home: https://github.com/zzamboni/plugin-cdb

# Usage:
# some-command /path/to/some/file
# cdb <ALT+up>
function cdb -d "cd to base directory of argument"
	cd (dirname $argv[1])
end
