overworld_gs = {}
overworld_gs.party = {}

overworld_gs.menu= {}
overworld_gs.menu.options = {}
add( overworld_gs.menu.options, {
	name='attack',
	fun=function() end
})
add( overworld_gs.menu.options, {
	name='item',
	fun=function() end
})
overworld_gs.menu.selected = 0


-- model ------------------------
function overworld_gs.addPartyMember(self, name, portrait, hp, energy)
	local member = {
		name=name,
		portrait=portrait,
		max_hp=hp,
		hp=hp,
		max_energy=energy,
		energy=energy
	}

	add(overworld_gs.party, member)
end


function overworld_gs.init(self)
	pal({1,131,3,139,11,138},1)

	self:addPartyMember( "pooch", 32, 10, 12 )
	--self:addPartyMember( "skittle", 32, 20, 12 )
end

-- ctrl -------------------------
function overworld_gs.update(self)
	if just_pressed(3) then
		self.menu.selected = ( self.menu.selected + 1 ) % ( # self.menu.options )
	end

	if just_pressed(2) then
		self.menu.selected = ( self.menu.selected + ( # self.menu.options ) - 1 ) % ( # self.menu.options )
	end
end

-- view -------------------------

function overworld_gs.drawMenu(self, x, y, width, menu)
	local height = ( # self.menu.options ) * 8 + 1
	rect(x, y, x+width, y+height, 1)
	rectfill(x, y, x+width-1, y+height-1, 6)

	for i, option in pairs( self.menu.options ) do
		if i == self.menu.selected+1 then
			print( '★', x+2, y - 6 + i*8, 1)
		end
		print( option.name, x+10, y - 6 + i*8, 1)
	end
end

--drawPartyMemberCard
-- cards are 40x32
function overworld_gs.drawPartyMemberCard(self, x, member)
	rect(x, 96, x + 39, 127, 1)
	rectfill(x, 96, x + 38, 126, 6)

	local x2 = x + 2
	print_center(member.name, x+20, 102, 1)
	print("hp  " .. member.hp .. "/" .. member.max_hp, x2, 110, 1)
	print("pp  " .. member.energy .. "/" .. member.max_energy, x2, 118, 1)
end


function overworld_gs.drawPartyMembers(self)
	local n_member = count(self.party)
	local x = 0
	for i, member in pairs( self.party ) do
		self:drawPartyMemberCard( x + (i-1)*40, member )
	end
end


function overworld_gs.drawBoss(self)
	local y = 16 - (flr(t()) % 2)
	spr(128, 32, y, 8, 8)
end


function overworld_gs.drawPortrait(self)
	rect(40, 96, 79, 127, 1)
	rectfill(40, 97, 78, 126, 3)
	spr(6, 44, 97, 4, 4)
	line(40, 127, 79, 127, 1)
end


function overworld_gs.draw(self)
	cls()
	self:drawBoss()
	self:drawPartyMembers()
	self:drawMenu(80, 96, 47, self.menu)
	self:drawPortrait()
	
	
end

gs = overworld_gs