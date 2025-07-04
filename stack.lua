function stack()
	return {
		elements = {},

		size = function(self)
			return # self.elements
		end,

		push = function(self, new_element)
			add( self.elements, new_element )
		end,

		top = function(self)
			return self.elements[self:size()]
		end,

		pop = function(self)
			if self:size() == 0 then
				return nil
			end

			local res = self:top()
			deli( self.elements, self:size() )
			return res
		end
	}
end