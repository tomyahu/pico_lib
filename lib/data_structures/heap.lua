
-- takes a "less than" operation
function maxheap( lt_op )
	if lt_op == nil then
		lt_op = function(a, b)
			return a < b
		end
	end

	function lt( a, b )
		-- b may be null, we return false so b is "lower than any number"
		if b == nil then
			return false
		end

		return lt_op( a, b )
	end

	return {
		elements = {},

		size = function(self)
			return # self.elements
		end,

		push = function(self, new_element)
			add( self.elements, new_element )

			local current_index = self:size()
			while current_index > 1 do
				local parent_index = flr( current_index / 2 )
				if( lt( self.elements[ current_index ], self.elements[ parent_index ] ) ) then
					return
				end

				local aux = self.elements[ parent_index ]
				self.elements[ parent_index ] = self.elements[ current_index ]
				self.elements[ current_index ] = aux

				current_index = parent_index
			end
		end,

		top = function(self)
			return self.elements[1]
		end,

		pop = function(self)
			if self:size() == 0 then
				return nil
			end

			local res = self:top()
			self.elements[1] = self.elements[self:size()]
			deli( self.elements, self:size() )

			local current_index = 1
			local left_index = 2
			local right_index = 3

			while lt( self.elements[current_index], self.elements[left_index] ) or lt(self.elements[current_index], self.elements[right_index] ) do
				
				local next_index
				if( lt( self.elements[left_index], self.elements[right_index] ) ) then
					next_index = right_index

				else
					next_index = left_index

				end

				local aux = self.elements[next_index]
				self.elements[next_index] = self.elements[current_index]
				self.elements[current_index] = aux

				current_index = next_index
				left_index = current_index * 2
				right_index = left_index + 1
			end

			return res
		end
	}
end