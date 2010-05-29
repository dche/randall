


require File.join(File.dirname(__FILE__), 'spec_helper')

require 'treetop'

require File.join(File.dirname(__FILE__), '../lib/randall/charclass')
Treetop.load File.join(File.dirname(__FILE__), '../lib/regexp')

parser = RandallRegExpParser.new

describe RandallRegExpParser do
  it 'should parse valid regular expressions.' do
    puts
    REGEXPS.each do |re|
      puts re.source
      parser.parse(re.source).should.not.be.nil
    end
  end
end
