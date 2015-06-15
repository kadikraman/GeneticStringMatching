class Organism
  def initialize(length)
    @length = length
  end

  def random
    Array.new(@length){[*'0'..'1'].sample}.join
  end

  def mate(a, b)
    cut_index = rand(a.length)
    [a[0, cut_index]+b[cut_index..-1], b[0, cut_index]+a[cut_index..-1]]
  end

  def fitness(gene, target)
    gene.each_char.zip(target.each_char).select { |a,b| a == b }.size
  end
end