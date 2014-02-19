#!/bin/ruby

require_relative 'workers.rb'

# Basic agents (abstract class)
class Agent
	@@workers = Array.new

	# Constructor
	def initialize(actSet)
		# Initialize all workers (abstract function)
		initWorkers(actSet)
	end

	def initWorkers(actSet)
		puts("NO initWorkers() FUNCTION FOUND IN Agent")
	end


	# Basic aggregation function call
	def getMove()
		# Null warning
		puts("NO getMove() FUNCTION FOUND!!")
		return false
	end
end

# Crowd agent
class CrowdAgent < Agent
	def initWorkers(actSet)
		# Add N workers
		for i in 0...5
			@@workers << OptimalWorker.new(actSet)
		end
	end

	# "Correct answer 
	def getMove()
		# TODO: Implement this mediator
		
	end
	
end

# Random agent
class RandomAgent < Agent
	# TODO: Use a random worker
	def initWorkers(actSet)
		# Add N workers
		for i in 0...5
			@@workers << RandomWorker.new(actSet)
		end
	end


	# Random value
	def getMove()
		return actSet.sample
	end
end


