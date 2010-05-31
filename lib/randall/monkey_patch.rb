# encoding: utf-8
#
# 

module RandallMonkey
  module PickableArray
    def pick
      self[Kernel.rand(self.size)]
    end
  end

  module RandableRegexp
    def rand
      @randall ||= Randall.new(String, :like => self)
      @randall.next
    end
  end
  
  def self.patch
    Array.class_eval do
      include PickableArray
    end
    
    Regexp.class_eval do
      include RandableRegexp
    end
  end
  
end
