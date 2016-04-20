#!/usr/bin/ruby

LIMIT = 100
@total = 0

def is_multiple_of_3_or_5 (number)
  if ((number % 3) == 0)
    return true
  elsif ((number % 5) == 0)
    return true
  else
    return false
  end
end

LIMIT.times do | count |
  if (is_multiple_of_3_or_5(count))
    @total = @total + count
  end
end

puts @total
