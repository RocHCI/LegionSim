#!/bin/ruby

class Worker
	@actions = nil
	def initialize()
		@actions = Array.new
	end

	def getResp()
		puts("NO getResp() FUNCTION FOUND IN WORKER!!")
	end

	def getActions()
		return @actions
	end
end

class OptimalWorker < Worker
	def initialize(ansSet, ansIdx)
		#
		super()
		@actions << ansSet[ansIdx]
	end

	def initialize(ansSet)
		#
		super()
		newAns = ansSet.sample
		#puts("Random fixed-worker answer: #{newAns}")
		@actions << newAns

	end


	# Be able to get a response
	def getResp()
		#puts("Random fixed-worker RESPONSE: #{@actions[0]}")
		return @actions[0]
	end
end

class RandomWorker < Worker
	def initialize(ansSet)
		#
		super()
		@actions = ansSet.clone
	end

	def getResp()
		newAns = @actions.sample
		#puts("Random-random worker answer: #{newAns}")
		return newAns
	end
end
