function word --description 'get a password'
	argparse (fish_opt -s y -l cp) -- $argv

	set -l file "/mnt/vaults/words/$argv"

	if command -qs bat
		set -f cmd bat $file
	else
		set -f cat $file '|' less -R
	end

	if [ -n "$_flag_cp" ]
		$cmd | xclip -i -selection clipboard
	else
		$cmd
	end
end
