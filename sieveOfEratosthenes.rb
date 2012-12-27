#!/usr/bin/env ruby
#
# Playing with the Sieve of Eratosthenes algorithm in Ruby
# @author Dawson Blackhouse

class Array
	def getFirstElement
		self.each { |e|
			if e != nil
				return e
			end
		}
	end

	def getLastElement
		last = self.reverse
		return last.getFirstElement
	end
end

def secret(number)
	return number
end

def primeToLimit(limit)
	primes = Array[1]

	if limit == 1
		return primes
	end

	numbers = Array.new(limit+1){|index| index}
	numbers[0] = nil
	numbers[1] = nil

	begin
		start = numbers.index(numbers.getFirstElement)
		last  = numbers.index(numbers.getLastElement)
		numbers[start] = nil
		primes.push(start)
		inc = start
		start = start * start

		i = start
		while i <= last
			numbers[i] = nil
			i = i + inc
		end
	end while start < limit
	
	return primes + numbers.compact
end

def isItSecretIsItSafe(primes)
	checked = Array.new()

	primes.each{|x|
		primes.each{|y|
			if !checked.index(y)
				secretXPlusY = secret(x + y)
				secretXPlusSecretY = secret(x) + secret(y)

				if secretXPlusY != secretXPlusSecretY
					return false
				end
			end
		}
		checked.push(x)
	}
	return true
end

limit = ARGV[0].to_i

if limit < 1
	puts 'Input (%s) not an integer or less than 1' % limit
	exit
end

puts 'Limit is %s' % limit
puts 'Primes:'
puts primeToLimit(limit)

if isItSecretIsItSafe(primeToLimit(limit))
	puts 'secret is an additive function'
else
	puts 'secret is not an additive function'
end