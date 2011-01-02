# wordladders_spec.rb
require 'wordladders'

describe Wordladder, "#ladder" do
  it "returns a list of words that are one letter different" do
    wordladder = Wordladder.new
    wordladder.build("hello")
    wordladder.ladder.should == "hello"
  end
end

