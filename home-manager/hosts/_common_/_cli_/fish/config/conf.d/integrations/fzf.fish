if functions -q fzf_key_bindings
	fzf_key_bindings
	set -g FZF_CTRL_T_COMMAND 'fd -t f --search-path $dir'
end
