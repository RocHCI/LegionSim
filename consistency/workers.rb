#!/bin/ruby

class Worker
	answers = Array.new
	answerIdx = 0

	def new()
		puts("NO WORKER CONSTRUTOR DEFINED!!")
	end

	def getResp()
		puts("NO getResp() FUNCTION FOUND IN WORKER!!")
	end
end

class OptimalWorker < Worker
	def new(ansSet, ansIdx)
		# 
		self.new()
		answers << ansSet[ansIdx]
	end

	def new(ansSet)
		# 
		self.new()
		answers << ansSet.sample
	end

	def new()
		# 
	end

	# Be able to get a response
	def getResp()
		return answer
	end
end

class RandomWorker < Worker
	def new(ansSet)
		# 
		self.new
		answers = ansSet.clone
	end

	def getResp()
		return answers.sample
	end
end

