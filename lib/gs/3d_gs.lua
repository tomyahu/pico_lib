threed_gs = {}
threed_gs.speed = 0.5
threed_gs.camera = {
	pos={0,0,0},
	dir={1,0,0},
	dp1={0,1,0},
	dp2={0,0,1},
	fov=1
}


function threed_gs.init(self)
end

function threed_gs.update(self)
	if btn(0) then
		self.camera.pos = vec_add(self.camera.pos, vec_scale( self.camera.dp1, - self.speed ) )
	end
	if btn(1) then
		self.camera.pos = vec_add(self.camera.pos, vec_scale( self.camera.dp1, self.speed ) )
	end
	if btn(2) then
		self.camera.pos = vec_add(self.camera.pos, vec_scale( self.camera.dir, self.speed ) )
	end
	if btn(3) then
		self.camera.pos = vec_add(self.camera.pos, vec_scale( self.camera.dir, - self.speed ) )
	end
	if btn(4) then
		self.camera.pos = vec_add(self.camera.pos, vec_scale( self.camera.dp2, self.speed ) )
	end
	if btn(5) then
		self.camera.pos = vec_add(self.camera.pos, vec_scale( self.camera.dp2, - self.speed ) )
	end
end

-- point_to_viewport: vec3 -> vec2
-- gets the x and y projections on the plane of a point in the viewport
function threed_gs.point_to_viewport(self, p)
	local o_p = vec_add( self.camera.pos, vec_scale( self.camera.dir, 64 ) )
	local o_l = self.camera.pos
	local d_l = vec_sub(p, o_l)

	local t = vec_dot( vec_sub( o_p, o_l ), self.camera.dir ) / vec_dot( d_l, self.camera.dir )
	local vp = vec_sub( vec_add( o_l, vec_scale( d_l, t ) ), o_p )

	return { vec_dot( self.camera.dp1, vp )+64, vec_dot( self.camera.dp2, vp )+64 }
end

-- point_to_viewport_iso: vec3 -> vec2
-- gets the x and y projections on the plane of a point in the viewport isometrically
function threed_gs.point_to_viewport_iso(self, p)
	local p_cam = vec_sub(p, self.camera.pos) 
	local vp = vec_sub(
		p_cam,
		vec_proj( p_cam, self.camera.dir )
	)

	return { vec_dot( self.camera.dp1, vp )+64, vec_dot( self.camera.dp2, vp )-64 }
end

-- draw_triangle_wf: vec2, vec2, vec2
-- draws a triangle wireframe
function threed_gs.draw_triangle_wf(self, p1, p2, p3)
	return self:draw_lines(
		{p1, p2, p3}, 7
	)
end

-- draw_triangle: vec2, vec2, vec2
-- draws a triangle
function threed_gs.draw_triangle(self, p1, p2, p3, c)
	local x0 = min( min(p1[1], p2[1]), p3[1])
	local x1 = max( max(p1[1], p2[1]), p3[1])
	local y0 = min( min(p1[2], p2[2]), p3[2])
	local y1 = max( max(p1[2], p2[2]), p3[2])
	local points = {p1, p2, p3}

	for i=x0,x1 do
		for j=y0,y1 do
			if self:is_point_in_polygon({i, j}, points) then
				pset(i, j, c)
			end
		end
	end
end


-- draw_lines: list(vec2), int
-- draws a connected set of lines with a color
function threed_gs.draw_lines(self, points, c)
	for i=1,#points do
		local j = (i % (#points)) + 1
		line(points[i][1], points[i][2], points[j][1], points[j][2], c)
	end
end

-- is_point_in_polygon; vec2, list(vec2)
function threed_gs.is_point_in_polygon(self, p, points)
	local acc = true
	for i=1,#points do
		local p1 = points[i]
		local p2 = points[(i % (#points)) + 1]

		local d1 = vec_sub(p2, p1)
		local d2 = vec_sub(p, p1)

		acc = acc and (vec2_cross(d2, d1) <= 0)
	end

	return acc
end

-- cartesian2barocentric: vec2, list(vec2) -> vec3
-- returns the barocentric coords of a point given a triangle and the point itself
function threed_gs.cartesian2barocentric(self, p, points)
	local p1, p2, p3 = points[1], points[2], points[3]
	local a1 = vec2_cross( vec_sub(p, p3), vec_sub(p2, p3) ) / vec2_cross( vec_sub(p1, p3), vec_sub(p2, p3) )
	local a2 = vec2_cross( vec_sub(p, p3), vec_sub(p3, p1) ) / vec2_cross( vec_sub(p1, p3), vec_sub(p2, p3) )
	local a3 = 1 - a1 - a2

	return {a1, a2, a3}
end

-- barocentric2cartesian: vec3, list(vec2) -> vec2
-- returns the cartesian coords of a point given a triangle and its barocentric choords
function threed_gs.barocentric2cartesian(self, alphas, points)
	local res = {0, 0}
	res = vec_add( res, vec_scale(points[1], alphas[1]) )
	res = vec_add( res, vec_scale(points[2], alphas[2]) )
	res = vec_add( res, vec_scale(points[3], alphas[3]) )

	return res
end

-- draw_tex: int, list4(vec2)
-- draws a deformed texture on the screen
function threed_gs.draw_tex(self, points, t_id, width, height)
	if width == nil then width = 8 end
	if height == nil then height = 8 end

	local t1 = {points[1], points[2], points[3]}
	local t2 = {points[3], points[4], points[1]}

	local sx = (t_id % 16) * 8
	local sy = flr(t_id / 16) * 8
	local sp1 = {sx, sy}
	local sp2 = {sx+width, sy}
	local sp3 = {sx+width, sy+height}
	local sp4 = {sx, sy+height}

	local st1 = {sp1, sp2, sp3}
	local st2 = {sp3, sp4, sp1}

	local p1 = points[1]
	local p2 = points[2]
	local p3 = points[3]
	local x0 = mid(0, min( min(p1[1], p2[1]), p3[1]), 128)
	local x1 = mid(0, max( max(p1[1], p2[1]), p3[1]), 128)
	local y0 = mid(0, min( min(p1[2], p2[2]), p3[2]), 128)
	local y1 = mid(0, max( max(p1[2], p2[2]), p3[2]), 128)
	for x=x0,x1 do
		for y=y0,y1 do
			local spos
			if self:is_point_in_polygon({x, y}, t1) then
				local a_vp = self:cartesian2barocentric({x, y}, t1)
				spos = self:barocentric2cartesian(a_vp, st1)
			end
			if self:is_point_in_polygon({x, y}, t2) then
				local a_vp = self:cartesian2barocentric({x, y}, t2)
				spos = self:barocentric2cartesian(a_vp, st2)

			end

			if spos != nil then
				local c = sget(spos[1], spos[2])
				pset(x, y, c)
			end
		end
	end
end

-- draw_face: list(vec3), int
-- draws a rectangular face in the 3d space to the screen
function threed_gs.draw_face(self, points, t_id)
	self:draw_tex(
		{
			self:point_to_viewport(points[1]),
			self:point_to_viewport(points[2]),
			self:point_to_viewport(points[3]),
			self:point_to_viewport(points[4])
		},
		t_id,
		16, 16
	)
end

function threed_gs.draw(self)
	cls()
	local p1 = self:point_to_viewport({64, 0, 0})
	local p2 = self:point_to_viewport({64, 16, 0})
	local p3 = self:point_to_viewport({64, 16, 16})
	local p4 = self:point_to_viewport({64, 0, 16})
	print(p1[1] .. " " .. p1[2], 7)
	print(p2[1] .. " " .. p2[2], 7)
	print(p3[1] .. " " .. p3[2], 7)
	print(p4[1] .. " " .. p4[2], 7)
	self:draw_face(
		{
			{64, -16, -16},
			{64, 16, 0},
			{64, 16, 16},
			{64, 0, 16}
		}, 128
	)

	-- print( self.camera.pos[1] .. " " .. self.camera.pos[2] .. " " .. self.camera.pos[3], 0, 0, 7 )
end

gs = threed_gs