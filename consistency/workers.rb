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
		@actions << ansSet.sample
	end


	# Be able to get a response
	def getResp()
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
		return @actions.sample
	end
end

