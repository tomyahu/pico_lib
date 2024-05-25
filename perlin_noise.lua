function vec_dot(p1, p2)
	local res = 0
	for i=1,#p1 do
		res += p1[i] * p2[i]
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

function vec_norm2(p1)
	return vec_dot(p1, p1)
end

function vec_norm(p1)
	return sqrt(vec_norm2(p1))
end

function vec_normalize(p1)
	local norm = vec_norm(p1)
	local res = {}
	for i=1,#p1 do
		add(res, p1[i] / norm)
	end
	return res
end


function new_perlin_noise_gen(width, height)
	local grid = {}
	for i=1,width do
		grid[i] = {}
		for j=1,height do
			local aux = rnd()
			grid[i][j] = {cos(aux), sin(aux)}
		end
	end
	
	return function(x, y)
		local vecs = {}
		add(vecs, grid[x\1][y\1])
		add(vecs, grid[x\1 + 1][y\1])
		add(vecs, grid[x\1][y\1 + 1])
		add(vecs, grid[x\1 + 1][y\1 + 1])

		local res = 0
		local vec_o = {x,y}
		
		local c1 = vec_dot( vecs[1], vec_normalize( vec_sub(vec_o, vecs[1]) ) )
		local c2 = vec_dot( vecs[2], vec_normalize( vec_sub(vec_o, vecs[2]) ) )
		local c3 = vec_dot( vecs[3], vec_normalize( vec_sub(vec_o, vecs[3]) ) )
		local c4 = vec_dot( vecs[4], vec_normalize( vec_sub(vec_o, vecs[4]) ) )

		local dx = x % 1
		local dy = y % 1

		local cx1 = c1 * (1-dx) + c2 * dx
		local cx2 = c3 * (1-dx) + c4 * dx

		local c = cx1 * (1-dy) + cx2 * dy
		return c
	end
end