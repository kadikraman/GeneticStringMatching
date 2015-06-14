$string_to_match = '101023946'
$population_size = 10
$max_gen = 100

# generates a random string of 0s and 1s
def generate_random_string(length)
  Array.new(length){[*'0'..'9'].sample}.join
end

# grades the input based on how well it matches the target string
def grade(input)
  input.each_char.zip($string_to_match.each_char).select { |a,b| a == b }.size
end

# mates two strings at a random point
def mate_two_strings(a, b)
  cut_index = rand(a.length)
  [a[0, cut_index]+b[cut_index..-1], b[0, cut_index]+a[cut_index..-1]]
end

# generates new population from old
def generate_new_population(old_population)
  # creates a hash of {child_string => grade, ...} on the population
  graded_population = old_population.map { |child| {child => grade(child)} }.reduce({}, :merge)
  # gets the children with highest match grade
  top_6 =  Hash[graded_population.sort_by { |k,v| -v }[0..5]]

  # mates the 6 top strings with each other
  new_population = []
  new_population.concat(mate_two_strings(top_6.keys[0], top_6.keys[1]))
  new_population.concat(mate_two_strings(top_6.keys[2], top_6.keys[3]))
  new_population.concat(mate_two_strings(top_6.keys[4], top_6.keys[5]))

  # creates the last 4 randomly
  new_population << generate_random_string($string_to_match.length)
  new_population << generate_random_string($string_to_match.length)
  new_population << generate_random_string($string_to_match.length)
  new_population << generate_random_string($string_to_match.length)
end

# returns true if the given population includes the string we were looking for
def population_has_match?(population)
  population.include? $string_to_match
end

puts 'Looking for a match for ' + $string_to_match

generation_count = 0
match = false
population = []
until $max_gen == generation_count or match
  # if first generation, create the whole population randomly
  if generation_count == 0
    population = $population_size.times.map{ generate_random_string($string_to_match.length) }
  else
    population = generate_new_population(population)
  end

  if population_has_match?(population)
    match = true
    puts 'Found match in generation ' + generation_count.to_s
    puts 'Final population: '
    puts population
  end

  generation_count = generation_count + 1
end

unless match
  puts 'No match found after ' + $max_gen.to_s + ' generations :('
end
