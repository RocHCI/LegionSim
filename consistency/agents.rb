#!/bin/ruby

require_relative 'workers.rb'

# Basic agents (abstract class)
class Agent
	## STATIC VARS
	@@Alpha = 0.8
	@@N = 10

	 # Obj datastructs
	@workers = nil
	@actions = nil
	@weights = nil


	# Constructor
	def initialize(actSet, inAlpha)
		@workers = Array.new
		@weights = Array.new
		@@Alpha = inAlpha

		# Initialize all workers (abstract function)
		initWorkers(actSet)

		@actions = actSet.clone
	end

	#
	def initWorkers(actSet)
		#puts("N = #{@@N} | a = #{@@Alpha}")

		# Add N workers
		for i in 0...(@@N*@@Alpha).to_i
			@workers << OptimalWorker.new(actSet)
			@weights << 1.0
		end
		# Add K random workers
		for i in 0...(@@N*(1.0-@@Alpha)).to_i
			@workers << RandomWorker.new(actSet)
			@weights << 1.0
		end

		return true
	end


	# Basic aggregation function call
	def getMove()
		# Null warning
		puts("NO getMove() FUNCTION FOUND!!")
		return nil
	end

	# Worker trade function - get a new worker when the old one "leaves". (TEMP?)
	def rotateWorker()
		# Pick a worker at random and remove them
		removeIdx = (rand() * @workers.length).to_i
		@workers.delete_at(removeIdx)
		@weights.delete_at(removeIdx)
		#puts("Removing #{removeIdx}")

		# Create a new random worker with the given prob of being noise
		r = rand()
		if( r < @@Alpha )
			#puts("Adding OPTIMAL.")
			@workers << OptimalWorker.new(@actions)
		else
			#puts("Adding RANDOM.")
			@workers << RandomWorker.new(@actions)
		end

		@weights << 1.0
	end
end

# Fixed-action agent
class FixedAgent < Agent
	def initialize(actSet, inAlpha)
		super(actSet, inAlpha)
	end


	# "Correct answer
	def getMove()
		# Always take the same answer
		#return @workers[0].getActions()[0]
		return @workers[0].getResp()
	end

end

# Random agent
class RandomAgent < Agent
	def initialize(actSet, inAlpha)
		super(actSet, inAlpha)
	end


	# Random value
	def getMove()
		# Random move by random worker
		#return (@workers.sample).getActions().sample
		# Fixed move by random worker
		#return (@workers.sample).getActions()[0]
		return (@workers.sample).getResp()
	end
end


# Crowd agent
class CrowdAgent < Agent
	@gamma = nil

	def initialize(actSet, inAlpha)
		super(actSet, inAlpha)

		@gamma = 0.9
		@leader
	end


	# "Correct answer
	def getMove()
		# TODO: Implement this mediator

		# Find the aggregate answer
		aggrAns = Hash.new
		wAns = Hash.new
		aggrCount = 0
		wCount = Hash.new
		@workers.each{ |w|
			#curAns = w.getActions()[0]
			curAns = w.getResp()
			if( aggrAns[curAns] == nil )
				aggrAns[curAns] = 0
			end
			aggrAns[curAns] += 1

			if( wAns[w] == nil )
				wAns[w] = Hash.new
				wCount[w] = 0
			end
			if( wAns[w][curAns] == nil )
				wAns[w][curAns] = 0
			end
			wAns[w][curAns] += 1


			aggrCount += 1
			wCount[w] += 1
		}

		# Normalize the answer vectors
		aggrAns.each_key{ |act|
			aggrAns[act] = aggrAns[act]/aggrCount
		}
		@workers.each{ |wid|
			wAns[wid].each_key{ |act|
				wAns[wid][act] = wAns[wid][act]/wCount[wid]
			}
		}


		#@workers.each{ |w|
			# Find the new agreement rate
			wScores = Hash.new
			aggrAns.each_key{ |act|
				@workers.each{ |w|
					if( wScores[w] == nil )
						wScores[w] = 0.0
					end

#puts("WANS: #{wAns[w][act]} from #{wAns[w]}")
#puts("AGGR ANS: #{aggrAns[act]}")
					curScore = wAns[w][act]
					if( wAns[w][act] == nil )
						curScore = 0.0
					end
					wScores[w] += curScore*aggrAns[act]
				}
			}

			# Update the worker's weight
			maxWt = 0.0
			@workers.each_index{ |widx|
#puts("UPDATE: (#{(wScores[@workers[widx]])}*#{@gamma} = #{(wScores[@workers[widx]]*@gamma)}) + (#{(@weights[widx]*(1-@gamma))}")
				@weights[widx] = (wScores[@workers[widx]]*@gamma) + (@weights[widx]*(1-@gamma))
				if( @weights[widx] > maxWt )
					@leader = widx
					maxWt = @weights[widx]
				end
			}
		#}


		# Now find the leader to listen to!

#puts(@weights)
#puts("LEADER: #{@leader}  ==>  #{wAns[@workers[@leader]]}")
		# NOTE: We should be returning the whole hash here, but since we will only ever have 1 answer for the individual, we just pull that key out (ignoring the vote count fixed to 1) and return it
		wAns[@workers[@leader]].each_key{ |ans|
			return ans
		}
		#return @workers[0].getActions()[0]
	end
end


# Majority vote agent
class VoteAgent < Agent

	def initialize(actSet, inAlpha)
		super(actSet, inAlpha)

	end


	# "Correct answer
	def getMove()
		# TODO: Implement this mediator

		# Find the aggregate answer
		aggrAns = Hash.new
		aggrCount = 0
		#puts("Worker input::")
		@workers.each{ |w|
			#curAns = w.getActions()[0]
			curAns = w.getResp()
			#puts(curAns)
			if( aggrAns[curAns] == nil )
				aggrAns[curAns] = 0
			end
			aggrAns[curAns] += 1

			aggrCount += 1
		}

#puts("Array: #{aggrCount}")

		# Now find the majority answer!
		maxCount = 0
		maxCountKey = -1;
		aggrAns.each_key{ |k|
			if( aggrAns[k] > maxCount )
				maxCount = aggrAns[k]
				maxCountKey = k
			end
		}

#puts("Selecting: #{maxCountKey}")
		return maxCountKey
	end
end
