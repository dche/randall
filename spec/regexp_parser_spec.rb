


require File.join(File.dirname(__FILE__), 'spec_helper')

require 'treetop'

Treetop.load File.join(File.dirname(__FILE__), '../lib/regexp')

parser = RegExpParser.new

describe RegExpParser do
  it 'should parse valid regular expressions.' do
    REGEXPS.each do |re|
      puts re.source
      parser.parse(re.source).should.not.be.nil
    end
  end
end
