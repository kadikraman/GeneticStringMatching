require_relative 'population'
require_relative 'organism'

target_string = '11000011111'
population_size = 10
max_generations = 100

population = Population.new(target_string, population_size, max_generations)
population.evolve

if population.match_found
  puts 'Target string: ' + target_string
  puts 'Match found after ' + population.current_generation.to_s + ' generations'
  puts 'Last population: ' + population.current_population.map(&:to_s).to_s
else
  puts 'No match after 100 generations :('
end