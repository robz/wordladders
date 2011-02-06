# wordladders_spec.rb
require 'wordladders'

describe Node, "set_neighbors" do 
  it "creates a hash of word=>different_letter  pairs" do
    Node.new("hey","bay",["hey","dey","day","bay"]).set_neighbors
