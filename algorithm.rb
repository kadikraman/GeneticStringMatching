require_relative 'population'
require_relative 'organism'

target_string = '11111111111'
population_size = 10
max_generations = 100

organism = Organism.new(target_string.length)
population = Population.new(target_string, population_size, max_generations, organism)
population.evolve

if population.match_found
  puts 'Target string: ' + target_string
  puts 'Match found after ' + population.current_generation.to_s + ' generations'
  puts 'Last population: ' + population.current_population.to_s
else
  puts 'No match after 100 generations :('
end