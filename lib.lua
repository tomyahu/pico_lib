function btoi(b)
	return b and 1 or 0
end

function print_center(txt, x, y, c)
	txt = tostr(txt);
	x -= (#txt)*2
	y -= 3
	print(txt, x, y, c)
end

function s_copy( orig )
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in pairs(orig) do
			copy[orig_key] = orig_value
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end