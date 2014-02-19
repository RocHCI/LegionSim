#!/bin/ruby

class Worker
	@answers = nil
	def initialize()
		@answers = Array.new
	end

	def getResp()
		puts("NO getResp() FUNCTION FOUND IN WORKER!!")
	end

	def getAnswers()
		return @answers
	end
end

class OptimalWorker < Worker
	def initialize(ansSet, ansIdx)
		# 
		super()
		@answers << ansSet[ansIdx]
	end

	def initialize(ansSet)
		# 
		super()
		@answers << ansSet.sample
	end


	# Be able to get a response
	def getResp()
		return @answer
	end
end

class RandomWorker < Worker
	def initialize(ansSet)
		# 
		super()
		@answers = ansSet.clone
	end

	def getResp()
		return @answers.sample
	end
end

