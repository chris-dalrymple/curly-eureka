#!/usr/bin/ruby

class Algorithm

  def sieve_init(target_number)
    prime_array = Array.new
    range = (2..target_number)
    range.each do |count|
      prime_array.push count
    end
    return prime_array
  end

  def sieve_of_eratosthenes(target_number)
    init_array = sieve_init(target_number)
    init_array.each_with_index do |v,i|

      if (v != 0)
        ((i+1)..(target_number - 2)).each do |count|
          if (init_array[count] % v == 0)
            init_array[count] = 0
          end
        end
      end
    end

    return init_array
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

  def stack_of_damm(target_number)
    prime_array = Array.new
    range = (2..(target_number - 1))

    range.each do |value|
      if (target_number % value == 0)
        if (stack_check(prime_array, value))
          prime_array.push value
        end
      end
    end

    return prime_array
  end

  def get_prime(start_number, target_number, prime_array)
    range = (start_number..target_number)
    range.each do |value|
      if (target_number % value == 0)
        if (stack_check(prime_array, value))
          print "value = #{value}\n"
          prime_array.push value
          new_target = target_number / value
          print "new_target = #{new_target}\n"
          get_prime((value + 1), (target_number / value), prime_array)
          return prime_array
        end
      end
    end
  end

  def primes(target_number)
    array = Array.new
    get_prime(2, target_number, array)
    return array
  end

  def prime_factors(target_number)
    factor_array = Array.new
    prime_array = sieve_of_eratosthenes(target_number)
    prime_array.each do |value|
      if (value != 0)
        if (target_number % value == 0)
          factor_array.push value
        end
      end
    end

    return factor_array
  end
end

alg = Algorithm.new
#init_array = alg.prime_factors(10)
#init_array = alg.prime_factors(13195)
#init_array = alg.prime_factors(600851475143)
#init_array = alg.stack_of_damm(13195)
#init_array = alg.stack_of_damm(600851475143)
#init_array = alg.primes(13195)
init_array = alg.primes(600851475143)
init_array.each do |value|
  p value
end
#init_array = alg.sieve_of_eratosthenes(13195)
#init_array = alg.sieve_init(600851475143)
