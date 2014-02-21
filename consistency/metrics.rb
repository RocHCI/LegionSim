#!/bin/ruby

def findEntropy(inSet)

	# Create/fill the answer bins
	ansBin = Hash.new
	totalAns = 0
	inSet.each{ |ans|
		#  
		if( ansBin[ans] == nil )
			ansBin[ans] = 1
		else
			ansBin[ans] += 1
		end

		#
		totalAns += 1
	}

	# Calc entropy
	# TODO: Calc REAL entropy
	ent = 0.0
	ansBin.each_key{ |key|
		prob = ansBin[key].to_f / totalAns.to_f
		#puts("P(#{key}) = #{prob}")
		ent += prob*Math.log(prob)

	}

	# Apply the negative sign
	ent *= -1

	#puts("ENTROPY: #{ent}")

	return ent
end


class Array

	def mean
		total = 0.0
		self.each{ |val|
			total += val
		}

		return total/self.length
	end
end
