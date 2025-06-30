function new_particle_emiter()
	return {
		particles= {},
		current_time= 0,
		next_time= 0,
		emission_rate= 1,
		update= function(self)
			local aux = {}
			for _, particle in pairs(self.particles) do
				if particle.life > 0 then
					add( aux, particle )
				end
			end
			self.particles = aux

			for _, particle in pairs(self.particles) do
				self.update_particle(particle)
				particle.life -= 1
			end

			self.next_time += 1
			while self.current_time < self.next_time do
				self.current_time += 1/self.emission_rate
				add(self.particles, self:create_particle() )
			end
		end,
		
		draw= function(self, x, y)
			for _, particle in pairs(self.particles) do
				circfill( particle.x + x, particle.y + y, particle.r, particle.c)
			end
		end,

		create_particle= function(self)
			return {
				x=0,
				y=0,
				r=0,
				c=7,
				life=30,
			}
		end,

		update_particle= function(particle)
			particle.x += 1
		end
	}
end