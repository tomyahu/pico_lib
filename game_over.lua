-- requires lib.lua and main.lua
game_over_gs = {}
game_over_gs.next_gs = gs

function game_over_gs.init(self)
	rectfill(15, 50, 111, 66, 0)
	rect(15, 50, 111, 66, 7)
	print_center("game over", 64, 56, 7)
	print_center("apreta z para reiniciar", 64, 62, 7)
end

function game_over_gs.update(self)
	if btn(4) then gs_change(self.next_gs) end
end

function game_over_gs.draw(self)
end