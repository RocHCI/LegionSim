#!/bin/ruby

class Worker
	answers = Array.new
	answerIdx = 0

	def initialize()
		puts("NO WORKER CONSTRUTOR DEFINED!!")
	end

	def getResp()
		puts("NO getResp() FUNCTION FOUND IN WORKER!!")
	end
end

class OptimalWorker < Worker
	def initialize(ansSet, ansIdx)
		# 
		self.super
		answers << ansSet[ansIdx]
	end

	def initialize(ansSet)
		# 
		self.super
		answers << ansSet.sample
	end

	def initialize()
		# 
	end

	# Be able to get a response
	def getResp()
		return answer
	end
end

class RandomWorker < Worker
	def initialize(ansSet)
		# 
		self.super
		answers = ansSet.clone
	end

	def getResp()
		return answers.sample
	end
end

