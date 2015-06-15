class Population
  def initialize(target_string, population_size, max_generations, organism)
    @target_string = target_string
    @population_size = population_size
    @max_generations = max_generations
    @organism = organism
    @current_generation = 1
    @match_found = false
    @current_population = []
  end

  def evolve
    until @max_generations == @current_generation or @match_found
      if @current_generation == 1
        @current_population = @population_size.times.map{ @organism.random }
      else
        @current_population = generate_new_population
      end

      if @current_population.include? @target_string
        @match_found = true
      end

      @current_generation = @current_generation + 1
    end
  end

  def generate_new_population
    graded_population = @current_population.map { |child| {child => @organism.fitness(child, @target_string)} }.reduce({}, :merge)
    top_6 =  Hash[graded_population.sort_by { |k,v| -v }[0..5]]
    new_population = []
    new_population.concat(@organism.mate(top_6.keys[0], top_6.keys[1]))
    new_population.concat(@organism.mate(top_6.keys[2], top_6.keys[3]))
    new_population.concat(@organism.mate(top_6.keys[4], top_6.keys[5]))

    # creates the last 4 randomly
    new_population << @organism.random
    new_population << @organism.random
    new_population << @organism.random
    new_population << @organism.random
  end

  attr_accessor :current_population, :match_found, :current_generation

end