

module RandallRegExp
  module CharClass
    
    def print
    end
    
    
    def decimal_number
      (0..9).to_a
    end
    
    def lower_letter
      26.times.map do |i|
        ('a'.ord + i).chr
      end
    end
    
    def upper_letter
      self.lower_letter.map(&:upcase)
    end
    
    def letter
      self.lower_letter + self.upper_letter
    end
    
    def xchar
      c = ['a', 'b', 'c', 'd', 'e']
      c += c.map(&:upcase)
    end
    
    def xdigit
      self.digit + self.xchar
    end
  end
  
  class PosixCharClass < Treetop::Runtime::SyntaxNode
    include CharClass
    
		def rand
			chars = case posix_char_class.text_value
			when 'alnum'
			when 'alpha'
			when 'ascii'
			when 'blank'
			when 'cntrl'
			when 'digit'
			when 'graph'
			when 'lower'
			when 'print'
			when 'punct'
			when 'space'
			when 'upper'
			when 'xdigit'
			when 'word'
			else
				''
			end
			
			chars[Kernel.rand(chars.size)]
		end
	end
		
	class PerlCharClass < Treetop::Runtime::SyntaxNode
	  include CharClass
	  
	  def rand
			chars = case self.text_value
			when 's'
			  self.space
			when 'S'
			  self.all_char - self.space
			when 'd'
			  self.decimal_letter
			when 'D'
			  self.all_char - self.decimal_letter
			when 'h'
			  self.xdigit
			when 'H'
			  self.all_char - self.xdigit
			when 'w'
			when 'W'
			else
				''
			end

			chars[Kernel.rand(chars.size)]
    end
  end
  
  class FullCharClass < Treetop::Runtime::SyntaxNode
    include CharClass
    
    def rand
      
    end
  end

end
