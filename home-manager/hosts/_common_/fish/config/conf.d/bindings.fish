function vi_bindings --description 'vi keybindings with autosuggestion acceptance'
	fish_vi_key_bindings
	for mode in default insert visual
		bind -M $mode -k nul forward-char
		bind -M $mode \cf forward-word
	end
end

set -g fish_key_bindings vi_bindings
