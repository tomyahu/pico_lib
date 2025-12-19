local doom_gs = {}


doom_gs.player = {
	x=64,
	y=64,
	a=0.25,
	dir={x=0, y=-1},
	view_length=160,
	fov=0.125,
	raycasts={}
}

doom_gs.horizon=80
doom_gs.simulation = false
doom_gs.sens = 0.008

function doom_gs.init(self)
end

function doom_gs.player_rot( self, a )
	local p = self.player
	p.a += a
	p.dir.x = cos(p.a)
	p.dir.y = sin(p.a)
end


function doom_gs.is_block(self, x, y)
	return fget(mget(x, y), 0)
end


function doom_gs.update_player_raycasts(self)
	local p = self.player

	p.raycasts = {}
	local x, y, dist
	local dir_x, dir_y
	for i=1,128 do
		dir_x, dir_y = cos(p.a + p.fov - i/64*p.fov)/2, sin(p.a + p.fov - i/64*p.fov)/2
		-- local ox, oy = p.x+dir_x* 32/sin(i/64*p.fov + 0.75 - p.fov), p.y+dir_y* 32/sin(i/64*p.fov + 0.75 - p.fov)
		local ox, oy = p.x, p.y
		x, y = ox, oy
		
		local j = 0
		while j < p.view_length do
			j += 4
			x += dir_x*4
			y += dir_y*4

			dist = j/8

			if( self:is_block(x\8, y\8) ) then
				while( self:is_block(x\8, y\8) ) do
					j -= 1
					x -= dir_x
					y -= dir_y
				end
				dist = j/8
				break
			end
		end

		local spos = (x*2)%16
		if flr(y+1)%8 > 1 then
			spos=(y*2)%16
		end
		add( p.raycasts, {x=x, y=y, ox=ox, oy=oy, norm=vec_norm({x-p.x, y-p.y}), dist=dist, sprite_pos=spos} )
	end
end


function doom_gs.update_player(self)
	local p = self.player

	if( just_pressed(4) ) then self.simulation = not self.simulation end


	if( btn(0, 1) ) then
		self:player_rot( self.sens )
	end
	if( btn(1, 1) ) then
		self:player_rot( -self.sens )
	end

	if( btn(0) ) then
		p.x += p.dir.y
		p.y -= p.dir.x
	end
	if( btn(1) ) then
		p.x -= p.dir.y
		p.y += p.dir.x
	end

	if( btn(2) ) then
		p.x += p.dir.x
		p.y += p.dir.y
	end
	if( btn(3) ) then
		p.x -= p.dir.x
		p.y -= p.dir.y
	end

	self:update_player_raycasts()
end


function doom_gs.update(self)
	self:update_player()
end


function doom_gs.draw_background(self)
	rectfill(0,self.horizon,128,128,6)
end


function doom_gs.draw_scene(self)
	local i = 0
	local last_r = nil
	local last_size = 0
	local p = self.player
	for _, r in pairs(p.raycasts) do
		local size = 0
		if( r.dist < p.view_length/8 - 1) then
			size = 64/r.dist
			sspr(r.sprite_pos, 32, 1, 16, i, self.horizon-size, 1, 2*size )
		end
		i+=1
	end
end


function doom_gs.draw_simulation(self)
	cls()
	map(0,0,0,0,16,16)

	local p = self.player
	local dir_x, dir_y
	for _, r in pairs(p.raycasts) do
		line(r.ox, r.oy, r.x, r.y, 6)
	end

	pset(p.x, p.y, 7)
end


function doom_gs.draw_3d(self)
	cls()
	self:draw_background()
	self:draw_scene()
end


function doom_gs.draw(self)
	if self.simulation then
		self:draw_simulation()
	
	else
		self:draw_3d()
	end

end

gs = doom_gs