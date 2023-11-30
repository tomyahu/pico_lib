function btoi(b)
	return b and 1 or 0
end


function print_center(txt, x, y, c)
	txt = tostr(txt);
	x -= (#txt)*2
	y -= 3
	print(txt, x, y, c)
end


function soft_copy( orig )
	local orig_type = type(orig)
	if orig_type != 'table' then return orig end

	local copy = {}
	for orig_key, orig_value in pairs(orig) do
		copy[orig_key] = orig_value
	end

	return copy
end


function deep_copy( orig )
	local orig_type = type(orig)
	if orig_type != 'table' then return orig end

	local copy = {}
	for orig_key, orig_value in pairs(orig) do
		copy[orig_key] = deep_copy( orig_value )
	end

	return copy
end


function draw_menu(self, x, y, width, menu)
	for i, option in pairs( self.menu.options ) do
		if i == self.menu.selected+1 then
			print( '★', x+2, y - 6 + i*8, 1)
		end
		print( option.name, x+10, y - 6 + i*8, 1)
	end
end