#!/usr/bin/ruby

LIMIT = 4000000
$total = 0

def fibonacci(number)
  if (number < 0)
    exit 1
  elsif (number < 2)
    return number
  else
    return fibonacci(number - 1) + fibonacci(number - 2)
  end
end

def is_multiple_of_2(number)
  if ((number % 2) == 0)
    return true
  else
    return false
  end
end

$seed = 1
$value = 0
fibonacci_array = Array.new

while $value <= LIMIT
  $value = fibonacci($seed)
  print "Value = #{$value}\n"
  if (is_multiple_of_2($value) && $value <= LIMIT)
    fibonacci_array.push $value
  end
  $seed = $seed + 1
end

fibonacci_array.each do |number|
  puts number
  $total = $total + number
end

puts $total
