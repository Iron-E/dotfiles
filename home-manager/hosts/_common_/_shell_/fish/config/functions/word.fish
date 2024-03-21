function word --description 'get a password'
	argparse (fish_opt -s y -l cp) -- $argv

	set -f file "/mnt/vaults/words/$argv"

	function __word_cmd
		functions -e __word_cmd
		if command -qs bat
			bat $argv[1]
		else
			cat $argv[1] | less -R
		end
	end

	if [ -n "$_flag_cp" ]
		__word_cmd $file | xclip -i -selection clipboard
	else
		__word_cmd $file
	end
end
