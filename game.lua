test_gs = {
	p1={flr(rnd()*128), flr(rnd()*128)},
	p2={flr(rnd()*128), flr(rnd()*128)},
	p3={flr(rnd()*128), flr(rnd()*128)},
}


function test_gs.init(self)
end

function test_gs.update(self)
	self.p1={flr(rnd()*128), flr(rnd()*128)}
	self.p2={flr(rnd()*128), flr(rnd()*128)}
	self.p3={flr(rnd()*128), flr(rnd()*128)}
end

function test_gs.draw(self)
	cls()
	print(
		self.p1[1] ..
		" " .. self.p1[2] ..
		" " .. self.p2[1] ..
		" " .. self.p2[2] ..
		" " .. self.p3[1] ..
		" " .. self.p3[2]
	)
	trifill(
		self.p1[1], self.p1[2],
		self.p2[1], self.p2[2],
		self.p3[1], self.p3[2],
		7
	)
end

gs = test_gs