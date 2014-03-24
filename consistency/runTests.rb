#!/bin/ruby

puts("Starting...")

for i in 1..10
	alpha = i/10.0
puts("ALPHA: #{alpha}")
	result = `ruby game.rb #{alpha} > results-auto_#{i}.csv`
puts(result)
end

puts("Done.")
