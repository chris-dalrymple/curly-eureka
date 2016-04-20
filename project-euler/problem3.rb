#!/usr/bin/ruby

require_relative './algorithms/algorithms'

@algorithms = Algorithms.new
target_value = 600851475143

largest_prime = (@algorithms.prime_factors(target_value)).max

print "Largest prime of #{target_value} = #{largest_prime}\n"
