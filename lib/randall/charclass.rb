# encoding: utf-8
#
# charclass.rb -- Character classes parsing for treetop parser.
#
# copyright (c) 2010, Diego Che (chekenan@gmail.com)
#

module RandallRegExp
  module CharSets
    
    def strseq(from, to)
      (from..to).map(&:chr)
    end
    
    def all_chars
      @@ascii ||= strseq(0, 0x7f)
    end
    alias :ascii :all_chars
    
    def graph
      @@graph ||= strseq(0x21, 0x7e)
    end
    
    def control
      @@control ||= strseq(0, 0x1f) << 0x7f
    end
        
    def decimal_number
      @@decimal_number ||= (0..9).to_a.map(&:to_s)
    end
    alias :digit :decimal_number
    
    def lower_letter
      @@lower_letter ||= 26.times.map do |i|
        ('a'.ord + i).chr
      end
    end
    
    def upper_letter
      @@upper_letter ||= self.lower_letter.map(&:upcase)
    end
    
    def letter
      @@letter ||= self.lower_letter + self.upper_letter
    end
    
    def space
      @@space ||= ["\s", "\t", "\r", "\n", "\v", "\f"]
    end
    
    def punctuation
      # CHECK: which chars belong to this set?
      @@punct ||= ['!', "\"", '#', #'$', 
                   '%', '&', "'", '(', ')',
                   '*', #'+', 
                   '-', '.', '/', ':', ';', '<', #'=', '>',
                   '?', '@', '[', '\\', ']', #'^', 
                   '_', #'`',
                   '{', #'|', 
                   '}', #'~'
                   ]
    end
    
    def xchar
      c = ['a', 'b', 'c', 'd', 'e']
      c += c.map(&:upcase)
    end
    
    def xdigit
      @@xdigit ||= self.digit + self.xchar
    end
    
    def word
      @@word ||= self.letter + self.digit << '_'
    end
  end
  
  class CharClass < Treetop::Runtime::SyntaxNode
    include CharSets
    
    # '[' neg:'^'? comp:(cc_comp / char_class)+ amps:('&&' char_class)? ']'
    def chars
			return @chars if @chars
			
			# build charset
			@chars = comp.elements.map(&:chars).reduce([], :+).uniq
			@chars &= amps.elements[1].chars unless amps.empty?
			@chars = self.all_chars - @chars unless neg.empty?
			
			@chars
    end
    
		def rand
		  self.chars
			@chars.empty? ? '' : @chars[Kernel.rand(@chars.size)]
		end
  end
  
  class PosixCharClass < CharClass
    
    def chars
      return @chars if @chars
      
      @chars = case pcc_name.text_value
			when 'alnum'
			  self.letter + self.digit
			when 'alpha'
			  self.letter
			when 'ascii'
			  self.ascii
			when 'blank'
			  ["\s", "\t"]
			when 'cntrl'
			  self.control
			when 'digit'
			  self.digit
			when 'graph'
			  self.graph
			when 'lower'
			  self.lower
			when 'print'
			  self.graph << "\s"
			when 'punct'
			  self.punctuation
			when 'space'
			  self.space
			when 'upper'
			  self.upper
			when 'xdigit'
			  self.xdigit
			when 'word'
			  self.word
			else
				[]
			end

			@chars = self.all_chars - @chars unless neg.empty?
			@chars
    end
	end
		
	class PerlCharClass < CharClass
	  def chars
	    @chars ||= case self.text_value
			when '\s'
			  self.space
			when '\S'
			  self.all_chars - self.space
			when '\d'
			  self.digit
			when '\D'
			  self.all_chars - self.digit
			when '\h'
			  self.xdigit
			when '\H'
			  self.all_chars - self.xdigit
			when '\w'
			  self.word
			when '\W'
			  self.all_chars - self.word
			else
				[]
			end
    end
  end
  
  class SpanCharClass < CharClass
    
    def chars
      @chars ||= case self.text_value
      when /([0-9a-zA-Z])\-([0-9a-zA-Z])/
        $1 <= $2 ? self.strseq($1, $2) : ''
      else
        self.text_value.split('').uniq
      end
    end
    
    def strseq(from, to)
      (to.ord - from.ord).times.map do |i|
        (from.ord + i).chr
      end
    end
  end

end
