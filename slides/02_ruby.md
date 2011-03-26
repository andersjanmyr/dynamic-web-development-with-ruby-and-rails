!SLIDE bullets transition=fade
# Why Ruby?

* Happiness
* Flexibility
* Lightness
* Glue

!SLIDE code execute small
# Parallel Assignment

    @@@ruby
    # Swap a and b, without a temporary variable
    a, b = 42, 28
    a, b = b, a
    result = a, b

!SLIDE code
# Multiple Return Values

    @@@ruby
    def div(a, b)
      [a/b, a%b]
    end

    a, b = div(5, 2)

    result = a, b



!SLIDE code
# String Interpolation

    @@@ruby
    kid = 'Kid'

    result = "Hello #{kid} ##{1+3}"

!SLIDE code small
# Here Documents

    @@@ruby
    result = <<-SQL
    SELECT allocations.project_id as project_id, year, week, allocations.id as allocation_id
      FROM weeks
      LEFT OUTER JOIN allocations ON allocations.start_date < weeks.end_date
        AND allocations.end_date > weeks.start_date
        AND allocations.project_id = ?
      WHERE weeks.start_date >= ? AND weeks.end_date <= ?
    SQL


!SLIDE code small
# Higher Order Functions

    @@@ruby
    result =[]
    # Map converts an array of values to a new array of values
    result << ["a", "b", "c"].map { |item| item.upcase }
    
    # Zip zips arrays together
    result << [1, 2, 3].zip([10, 20, 30])

    result


!SLIDE code small
# Simple Commandline Access

    @@@ruby
    # Backticks invokes the command and returns the result as a string
    `ls`
    # => "Scripts\nStylesheets\nbin\nlib\nnibs\n"
    `ls`.split
    # => ["Scripts", "Stylesheets", "bin",  "lib", "nibs"]

    # System invokes the command, prints the result to stdout, and return a boolean
    system('ls -l')
    total 64
    drwxr-xr-x  3 andersjanmyr  admin    102 Aug 29  2009 Scripts
    drwxr-xr-x  3 andersjanmyr  admin    102 Aug 29  2009 Stylesheets
    drwxr-xr-x  5 andersjanmyr  admin    170 Aug 29  2009 bin
    drwxr-xr-x  3 andersjanmyr  admin    102 Aug 29  2009 lib
    drwxr-xr-x  3 andersjanmyr  admin    102 Aug 29  2009 nibs
    # => true

    system('ls tapir')
    ls: tapir: No such file or directory
    # => false


!SLIDE code small
# Open Classes

    @@@ruby
    class String
      def vowels
        self.scan(/[aeiouy]/i)
      end
    end

    result = "A tapir is beautiful".vowels


!SLIDE code small
# Class Inheritance

    @@@ruby
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

!SLIDE code small
# Class Inheritance, cont.

    @@@ruby
    class Tapir < Mammal
    end

    # Add some mammals and a tapir
    Mammal.mammals << Mammal.new << Mammal.new << Tapir.new

    result = []
    result << Tapir.all
    result << Mammal.all

    result


!SLIDE code small
# Meta Programming

    @@@ruby
    class Tapir

      [:sniff, :eat].each do |method_name|
        send :define_method, method_name do |thing|
          "I'm #{method_name}ing #{thing}!"
        end
      end

    end


!SLIDE code
# Meta Programming, cont.

    @@@ruby
    t = Tapir.new
    result = []
    result << t.eat('bananas')

    result << t.sniff('glue')
    result


!SLIDE code small
# Method Missing

    @@@ruby
    # Simple implementation of a Javascript-like structure without inheritance
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

!SLIDE code
# Method Missing, cont.

    @@@ruby
    result = []
    
    prot = Prototype.new
    result << prot.age
    
    prot.age 14
    result << prot.age
    
    prot.age= 16
    result << prot.age

    result


