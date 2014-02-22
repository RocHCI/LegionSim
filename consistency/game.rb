#!/bin/ruby

# LIBS
require_relative 'agents.rb'
require_relative 'metrics.rb'

# VARS
actionSet = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']
@NumRounds = 500
@NumSteps = 1000
@Tenure = 10
@Incr = 10

puts("Tenure_Length,Random-Agent,Fixed-Agent,Crowd-Agent")
while( @Tenure <= 1000 )

	##  MAIN  ##
	randAgent = RandomAgent.new(actionSet)
	fixedAgent = FixedAgent.new(actionSet)
	crowdAgent = CrowdAgent.new(actionSet)


	# Logging arrays
	rResultSet = Array.new
	fResultSet = Array.new
	cResultSet = Array.new

	# Test loop
	idx = 0
	while( idx < @NumRounds )


# NOTE: Turnover position OPTION #2
=begin
		if( idx % @Tenure == 0 )
			randAgent.rotateWorker()
			crowdAgent.rotateWorker()
		end
=end

		stepIdx = 0
		rActions = Array.new
		fActions = Array.new
		cActions = Array.new
		while( stepIdx < @NumSteps )


			# NOTE: Turnover position OPTION #1
			if( stepIdx % @Tenure == 0 )
				randAgent.rotateWorker()
				fixedAgent.rotateWorker()
				crowdAgent.rotateWorker()
			end

			rAct = randAgent.getMove()
			fAct = fixedAgent.getMove()
			cAct = crowdAgent.getMove()
			rActions << rAct
			fActions << fAct
			cActions << cAct

=begin
			puts("\nAgent R: #{randAgent.getMove()}")
			puts("Agent F: #{fixedAgent.getMove()}")
			puts("Agent C: #{crowdAgent.getMove()}")
=end

			# Move to the next step
			stepIdx += 1
		end


		# Move to the next round
		idx += 1

		# Calculate the entropy for each agent
		rEnt = findEntropy(rActions)
		fEnt = findEntropy(fActions)
		cEnt = findEntropy(cActions)

		# Output
		#puts("Entropy-Crowd: #{cEnt}, Entropy-Rand: #{rEnt}")

		# Record the result
		rResultSet << rEnt
		fResultSet << fEnt
		cResultSet << cEnt
	end

	# Final answers
	#puts("Average Entropy - Random: #{rResultSet.mean}")
	#puts("Average Entropy - Fixed: #{fResultSet.mean}")
	#puts("Average Entropy - Crowd: #{cResultSet.mean}")

	# Print in CSV format
	puts("#{@Tenure},#{rResultSet.mean},#{fResultSet.mean},#{cResultSet.mean}")

	@Tenure += @Incr
end
