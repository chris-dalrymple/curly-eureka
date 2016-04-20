#!/usr/bin/ruby

class Algorithms

  def prime_factors(target_number)
    array = Array.new
    get_prime(2, target_number, array)
    return array
  end

  private

  def get_prime(start_number, target_number, prime_array)
    range = (start_number..target_number)
    range.each do |value|
      if (target_number % value == 0)
        if (stack_check(prime_array, value))
          prime_array.push value
          new_target = target_number / value
          get_prime((value + 1), new_target, prime_array)
          return prime_array
        end
      end
    end
  end

  def stack_check(array, value)
    if array.size <= 0
      return true
    end

    array.each do |prime|
      if (value % prime == 0)
        return false
      end
    end

    return true
  end
end
