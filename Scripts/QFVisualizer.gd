extends Control

# Base class to solve problems with Q-Learning
class_name QFVisualizer

# Executed when a new episode starts
signal newEpisode()

# Executed when a new step is requested to be executed
# Requires to update the array passed as a reference like [newState, reward, done]
signal executeStep(action, arrayToUpdate)

# Q-Table Configuration

# Number of actions
var actionsN : int = 4 # Actions: up, down, left and right
# Number of states
var statesN : int = 16 * 16 # Maze of 16 x 16

# Hyperpamater intialization

# Seed to be used on the random number generation, if set to false the seed will be randomized
var seedToUse : int = 2
# Number of episodes to generate
var totalEpisodes : int = 100
# Learning rate
var learningRate : float = 0.8
# Max steps per episode
var maxSteps : int = (16 * 16) * 5
# Discounting rate
var gamma : float =  0.95

# Exploration parameters

# Exploration rate
var epsilon : float = 1.0
# Exploration probability at the start
var maxEpsilon : float = 1.0
# Minimum exploration probability 
var minEpsilon : float = 0.01
# The exponential decay rate for exploration pro
var decayRate : float = 0.001

# Accumulated rewards
var rewards : Array = []

# The generated q-table (statesN x actionsN)
var qTable : Array = []

# Variables for performing the algorithm

# Stores the number of the current episode
var currentEpisode : int = 0
# Stores the current state
var currentState : int = 0
# Store if the algorithm has started
var canRunEpisodes : bool = false

# Init a Q-Table
func initQTable(startValue : int) -> void:
	qTable = []
	
	for state in range(statesN):
		qTable.append([])
		for action in range(actionsN):
			qTable[state].append(startValue)
	
	print("[Q-Learning] Started Q-Table.")

# Init Q-Learning algorithm
func initQLearning() -> void:
	initQTable(0)
	
	rewards = []
	currentState = 0
	currentEpisode = 0
	canRunEpisodes = true
	
	print("[Q-Learning] Started Q-Learning, ready to start generating new episodes.")

# Get the value of the new Q(s, a)
func qFunctionValue(state, action, newState, reward) -> int:
	var newQFValue = qTable[state][action]
	var maxNewStateValue = qTable[newState].max()
	var currentStateValue = qTable[state][action]
	
	newQFValue += learningRate * (reward + (gamma * maxNewStateValue - currentStateValue))
	
	return newQFValue

# Run the next episode
func nextEpisode() -> void:
	if (currentEpisode + 1) > totalEpisodes:
		print("[Q-Learning] All episodes have alredy been generated!")
		print("[Q-Learning] Rewards: ", rewards)
		
		canRunEpisodes = false
	else:
		# Total of rewards gained in current episode
		var totalRewards = 0
		
		# Update the episode counter
		currentEpisode += 1
		
		print("[Q-Learning] Gerating episode #", currentEpisode)
		
		$".".emit_signal("newEpisode")
		
		for step in range(maxSteps):
			# Generate a random value between 0 and 1
			# The value will be used to check if the action is going to be a exploration or explotation
			var exploration_value = randf()
			
			var action
			
			if exploration_value > epsilon:
				# Find the best action on the current state
				var currentMaxValue = qTable[currentState][0]
				var currentMaxIndex = 0
				
				for index in range(qTable[currentState].size()):
					if qTable[currentState][index] > currentMaxValue:
						currentMaxValue = qTable[currentState][index]
						currentMaxIndex = index
				
				action = currentMaxIndex
			else:
				# Generate a random action to perfom exploration
				action = randi() % actionsN
			
			# Execute the current step
			var stepArray = []
			$".".emit_signal("executeStep", action, stepArray)
			
			var newState = stepArray[0]
			var reward = stepArray[1]
			var done = stepArray[2]
			
			# Update the Q-Learning function
			qTable[currentState][action] = qFunctionValue(currentState, action, newState, reward)
			
			#print(currentState, ', ', action, ':', qTable[currentState][action])
			
			totalRewards += reward
			
			currentState = newState
			
			if done:
				break
			
		epsilon = minEpsilon + (maxEpsilon - minEpsilon) * exp(-decayRate * currentEpisode)
		
		rewards.append(totalRewards)

# Run all episodes
func runAllEpisodes() -> void:
	for episode in range(totalEpisodes):
		nextEpisode()
	
	print("[Q-Learning] All episoded generateds!")

# [Hide]
func _ready():	
	# Set the random number generation seed
	if seedToUse:
		seed(seedToUse)
	else:
		randomize()
	
	initQLearning()


# [Hide]
func _on_QFVisualizer_executeStep(action, arrayToUpdate):
	var directionsList = ["up", "down", "left", "right"]
	
	var reward = 0
	var newState = currentState
	
	var validMovement = $Game.isValidMovement(directionsList[action])
	
	if validMovement:
		$Game.movePlayer(directionsList[action])
		newState = $Game.getCurrentPlayerPosIndex()
	
	var done = $Game.isInWinCell()
	
	if done:
		reward = 1

	else:
		reward = -0.1 / statesN
	
	arrayToUpdate.append(newState)
	arrayToUpdate.append(reward)
	arrayToUpdate.append(done)


# [Hide]
func _on_Timer_timeout():
	if canRunEpisodes:
		nextEpisode()


# [Hide]
func _on_QFVisualizer_newEpisode():
	$Game.newMazeGame()
