function new_discrete_gene( max_value )
	return {
		value= flr( rnd() * max_value ),
		max_value= max_value,
		mutate= function( self )
			self.value = flr( rnd() * max_value ),
		end,
		crossover= function( self, other_gene )
			local new_gene = new_discrete_gene( max_value )
			new_gene.value = self.value
			if( rnd() < 0.5 ) then new_gene.value = other_gene.value end
			
			return new_gene
		end
	}
end


function new_individual( gene_types )
	local genes = {}

	for gene_type in all(gene_types) do
		add( genes, new_discrete_gene( gene_type ) )
	end

	return {
		genes = genes,
		mutate = function(self)
			local random_gene = self.genes[
				flr(
					rnd() * ( #self.genes )
				) + 1
			]
			random_gene:mutate()
		end,
		crossover = function( self, other_individual )
			local offspring = new_individual()
			for i =1,#self.genes do
				if( rnd() < 0.5 ) then
					add( offspring.genes, self.genes[i] )
				else
					add( offspring.genes, other_individual.genes[i] )
				end
			end
		end
	}
end


function new_population( individual_num, gene_types, fitness )
	if( individual_num == nil ) then individual_num = 100 end

	local individuals = {}
	for i=1,individual_num do
		add( individuals, new_indivirual( gene_types ) )
	end
	
	return {
		individuals = individuals,
		selection_pool_size = 8,
		mutation_chance = 0.1,
		selection = function(self)
			local selection_pool = {}
			for i=1,self.selection_pool_size do
				add(
					selection_pool,
					individuals[
						flr( rnd() * #individuals ) + 1
					]
				)
			end
			
			local selected_individual = selection_pool[1]
			for i=2,#selection_pool do
				if( fitness( selected_individual.genes ) < fitness( individuals[i].genes ) ) then
					selected_individual = individuals[i]
				end
			end

			return selected_individual
		end,
		get_best = function( self )
			local selected_individual = individuals[1]
			for individual in all(self.individuals) do
				if( fitness( selected_individual ) < fitness( individual ) ) then
					selected_individual = individual
				end
			end

			return selected_individual
		end,
		next_generation = function( self )
			local next_individuals = {}
			for i=1,individual_num do
				local individual1 = self:selection()
				local individual2 = self:selection()
				
				local next_individual= individual1:crossover( individual2 )
				if( rnd() < self.mutation_chance ) then
					next_individual:mutate()
				end

				add( next_individuals, next_individual )

				self.individuals = next_individuals
			end
		end
	}
end
