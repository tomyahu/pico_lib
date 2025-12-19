music = {}

-- toggle_chanel
-- takes a chanel (0-3) and toggles that chanel
function music.toggle_chanel(self, chanel)

	-- For each pattern (all 63 of them)
	for i=0,63 do

		-- xor 7th bit
		local mem = 0x3100 + i*4 + chanel
		poke( mem, peek( mem ) ^^ 64 )
	end
	
end


-- chanel_on
-- takes a chanel (0-3) and turns the chanel on
function game_gs.chanel_on(self, chanel)

	-- For each pattern (all 63 of them)
	for i=0,63 do

		-- or 7th bit
		local mem = 0x3100 + i*4 + chanel
		poke( mem, peek( mem ) | 64 )
	end

end


-- chanel_off
-- takes a chanel (0-3) and turns the chanel off
function game_gs.chanel_off(self, chanel)

	-- For each pattern (all 63 of them)
	for i=0,63 do

		-- and every bit minus the 7th
		local mem = 0x3100 + i*4 + chanel
		poke( mem, peek( mem ) & -64 )
	end

end


-- pattern_operation
-- takes a pattern (0-63) a chanel (0-3) and a function to perform an operation with that specific chanel
-- this will be useful for when I have to import multiple functions
function game_gs.chanel_operation(self, chanel, pattern, operation)
	local mem = 0x3100 + pattern*4 + chanel
	poke( mem, operation( peek( mem ) ) )
end
