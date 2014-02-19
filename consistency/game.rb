#!/bin/ruby

# LIBS
require_relative 'agents.rb'

# VARS
actionSet = ['act1', 'act2', 'act3']
@NumRounds = 1
@NumSteps = 10

##  MAIN  ##
crowdAgent = CrowdAgent.new(actionSet)
randAgent = RandomAgent.new(actionSet)


# Test loop
idx = 0
while( idx < @NumRounds )
	while( stepIdx < @NumSteps )
		puts(randAgent.getMove())

		# Move to the next step
		stepIdx += 1
	end


	# Move to the next round
	idx += 1
end
