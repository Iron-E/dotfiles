for file in (status filename | path change-extension '')/*.fish
	if command -qs (path basename $file | path change-extension '')
		source $file
	end
end
