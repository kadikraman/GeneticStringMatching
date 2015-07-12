class Population
  def initialize(target_string, population_size, max_generations)
    @target_string = target_string
    @population_size = population_size
    @max_generations = max_generations
    @current_generation = 1
    @match_found = false
    @current_population = []
  end

  def evolve
    until @max_generations == @current_generation or @match_found
      if @current_generation == 1
        @current_population = @population_size.times.map{ Organism.random(@target_string.length) }
      else
        @current_population = generate_new_population
      end

      if @current_population.any? { |o| o.genetic_string == @target_string }
        @match_found = true
      end

      @current_generation = @current_generation + 1
    end
  end

  def generate_new_population
    graded_population = @current_population.sort_by { |child| -child.fitness(@target_string) }
    half_but_even = (graded_population.length / 4).floor * 2

    new_population = graded_population.take(half_but_even).each_slice(2).map { |pair| Organism.mate(*pair) }.flatten
    random_elements = graded_population.length - half_but_even
    random_elements.times { new_population << Organism.random(@target_string.length) }

    new_population
  end

  attr_accessor :current_population, :match_found, :current_generation

end