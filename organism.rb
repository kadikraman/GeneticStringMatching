# class Organism
#   def initialize(length)
#     @length = length
#   end
#
#   def random
#     Array.new(@length){[*'0'..'1'].sample}.join
#   end
#
#   def mate(a, b)
#     cut_index = rand(a.length)
#     [a[0, cut_index]+b[cut_index..-1], b[0, cut_index]+a[cut_index..-1]]
#   end
#
#   def fitness(gene, target)
#     gene.each_char.zip(target.each_char).select { |a,b| a == b }.size
#   end
# end

class Organism

  attr_reader :genetic_string

  def initialize(genetic_string = random)
    @genetic_string = genetic_string
  end

  # To create a new random Organism.
  # Use Organism.random(5)
  def self.random(length)
    new(Array.new(length){[*'0'..'1'].sample}.join)
  end

  def fitness(target)
    @genetic_string.each_char.zip(target.each_char).select { |a,b| a == b }.size
  end

  # Organism.mate(o1, o2)
  def self.mate(a, b)
    a, b = a.genetic_string, b.genetic_string

    cut_index = rand(a.length)

    new_org_str_1, new_org_str_2 = a[0, cut_index]+b[cut_index..-1], b[0, cut_index]+a[cut_index..-1]

    [new(new_org_str_1), new(new_org_str_2)]
  end

  def to_s
    genetic_string
  end

end