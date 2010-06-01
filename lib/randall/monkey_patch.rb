# encoding: utf-8
#
# copyright (c) 2010, Diego Che
#

module RandallMonkey
  
  module PickableArray
    # Randomly pick an element from the receiver.
    def pick
      self[Kernel.rand(self.size)]
    end
  end

  module RandableRegexp
    # Generate a String that matches the receiver.
    def rand
      @randall ||= Randall.new(String, :like => self)
      @randall.next
    end
  end
  
  # Enable the monkey patch.
  # After this message, you have +Array#pick+ and +Regexp#rand+.
  def self.patch
    Array.class_eval do
      include PickableArray
    end
    
    Regexp.class_eval do
      include RandableRegexp
    end
  end
  
end
