class String
  def vowels
    self.scan(/[aeiouy]/i)
  end
end


class Mammal
  # This is a class method, that returns all mammals of this kind
  def self.all
    mammals.select do |m|
      m.kind_of? self
    end
  end

  # Another class method that gives access to the class variable
  def self.mammals
    # @@ is a class variable prefix
    @@all_mammals ||= []
  end

end

class Tapir < Mammal
end

