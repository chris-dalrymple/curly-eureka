#!/usr/bin/ruby

require_relative '../../algorithms/algorithms'

describe Algorithms do
  before :all do
    @algorithms = Algorithms.new
  end

  describe "#new" do
    it "returns an Algorithms object" do
      expect(@algorithms).to be_an_instance_of(Algorithms)
    end
  end

  describe "#prime_factors" do
    it "returns an array" do
      expect(@algorithms.prime_factors(9)).to be_an_instance_of(Array)
    end

    it "returns an array of prime factors" do
      expect(@algorithms.prime_factors(13195)).to match_array([5,7,13,29])
    end

    it "returns an empty array for target_number of 1 or less" do
      expect(@algorithms.prime_factors(1)).to match_array([])
    end
  end
end
