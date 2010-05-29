

require 'treetop'

require File.join(File.dirname(__FILE__), 'randall/charclass')
Treetop.load File.join(File.dirname(__FILE__), 'regexp')

class Randall
  attr_reader :value
  
  @@reparser = RandallRegExpParser.new

  def initialize(type = Integer, opts = {})
    @type = type
    @options = opts
    
    Kernel.srand Integer(Time.now)
    parse_regexp
    
    @worker = Fiber.new do
      loop do
        if String == @type
          @value = g_str
        elsif Integer == @type
          @value = g_int
        elsif Float == @type
          @value = g_float
        elsif Array == @type
          @value = g_array
        elsif Hash == @type
          @value = g_hash
        elsif Class === @type
          @value = g_any
        else
          @value = nil
        end 

        Fiber.yield @value
      end
    end
  end

  # Same as self.value.
  def v
    self.value
  end

  # Generate value for given type and options.
  def rand(type, opts = {})
    @type = type
    @options = opts
    
    parse_regexp
    @worker.resume
  end
  alias :r :rand

  # Generate another value for current type and options.
  def next
    @worker.resume
  end
  alias :n :next

  private

  def g_str
    @str_gen.rand
  end

  def g_int
    @options.delete :close_to
    Integer(g_float)
  end

  def g_float
    if @options[:close_to]
      epsilon = @options[:epsilon] || 1e-3
      @options[:close_to] - epsilon + Kernel.rand * (2 * epsilon)
    elsif @options[:range]
      min = @options[:range].min
      max = @options[:range].max

      min + Kernel.rand * (max - min)
    elsif @options[:greater_than]
      # TODO: :gt and :lt should be able to coexist.
      @options[:greater_than] + Kernel.rand * (10 ** 12)
    elsif @options[:less_than]
      @options[:less_than] - Kernel.rand * (10 ** 12)
    else
      Kernel.rand * (10 ** 12)
    end
  end

  def g_array
    sz = @options[:size] || rand_size
    item_gen = @options[:item] || self.class.new(@options[:type] || rand_type)

    v = []
    sz.times do
      v << item_gen.next
    end
    v
  end

  def g_hash
    sz = @options[:size] || rand_size
    key_gen = @options[:key] || self.class.new(@options[:key_type] || rand_type)
    value_gen = @options[:value] || self.class.new(@options[:value_type] || rand_type)

    v = {}
    sz.times do
      v[key_gen.next] = value_gen.next
    end
    v
  end

  # Generate an Object.
  def g_any
    begin
      args = @options[:args] || []
      args = [] unless args.is_a? Array

      @type.new *args
    rescue Exception  # catch all exceptions
      nil
    end
  end
  
  def rand_size(max = 100)
    Kernel.rand max
  end
  
  def rand_type
    [Integer, Float, String][Kernel.rand 3]
  end

  def parse_regexp
    return self unless @type.is_a? String
    
    re = @options[:like].nil? ? /.*/ : @options[:like]
    
    @str_gen = @@reparser.parse re.source
    self
  end
end
