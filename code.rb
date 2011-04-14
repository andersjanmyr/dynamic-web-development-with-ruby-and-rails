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

  def to_s
    self.class.name
  end

end

class Tapir < Mammal
  [:sniff, :eat].each do |method_name|
    send :define_method, method_name do |thing|
      "I'm #{method_name}ing #{thing}!"
    end
  end
end

class Prototype

  def props
    @props ||= {}
  end

  def method_missing(method, *args)
    m = method.to_s.sub('=', '') # Strip the trailing '=' to allow setters
    if args.empty?
      props[m]
    else
      props[m] = args[0]
    end
  end
end

