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


function draw_menu(menu, selected, x, y, width)
	local height = ( # menu ) * 8 + 1
	rectfill(x, y, x+width, y+height, 1)
	rect(x, y, x+width, y+height, 7)

	for i, option in pairs( menu ) do
		if i == selected then
			print( '★', x+2, y - 6 + i*8, 7)
		end
		print( option.name, x+10, y - 6 + i*8, 7)
	end
end

function vec_add(p1, p2)
	local res = {}
	for i=1,#p1 do
		add(res, p1[i] + p2[i])
	end
	return res
end

function vec_scale(p1, s)
	local res = {}
	for i=1,#p1 do
		add(res, p1[i] * s)
	end
	return res
end

function vec_mult(p1, p2)
	local res = {}
	for i=1,#p1 do
		add(res, p1[i] * p2[i])
	end
	return res
end

function vec_sub(p1, p2)
	local res = {}
	for i=1,#p1 do
		add(res, p1[i] - p2[i])
	end
	return res
end

function vec_dot(p1, p2)
	local res = 0
	for i=1,#p1 do
		res += p1[i] * p2[i]
	end
	return res
end

function vec_norm2(p1)
	return vec_dot(p1, p1)
end

function vec_norm(p1)
	return sqrt(vec_norm2(p1))
end

function vec_proj(p1, p2)
	return vec_mult( p2, vec_dot(p1, p2) / vec_norm2(p2) )
end

function vec2_cross(p1, p2)
	return p1[1]*p2[2] - p1[2]*p2[1]
end

function vec3_cross(p1, p2)
	return {
		p1[2]*p2[3] - p1[3]*p2[2],
		p1[3]*p2[1] - p1[1]*p2[3],
		p1[1]*p2[2] - p1[2]*p2[1]
	}
end

function mat_det(M)
	local n, m = #M, #M[1]
	assert(n == m, "matrix is not square " .. n .. "x" .. m )

	if n==2 then
		return vec2_cross(M[1], M[2])
	else
		local acc = 0
		local sign = 1
		for i=1,n do
			local new_M = {}
			for j = 1,n do
				local aux = {}
				if j != i then
					for k = 2, m do
						add(aux, M[j][k])
					end
					add(new_M, aux)
				end
			end

			acc = sign * M[1][i] * mat_det(new_M)
			sign *= -1
		end
		return acc
	end
end