extends Node2D

var playerSpawnCell = false
var endMazeCell = false

var startCell = false
var endCell = false

func _ready():
	playerSpawnCell = $Map.get_used_cells_by_id(2)[0]
	endMazeCell = $Map.get_used_cells_by_id(0)[0]
	
	$Map.set_cellv(playerSpawnCell, 1)
	
	$Player/KinematicBody2D.global_position = $Map.map_to_world(playerSpawnCell) + Vector2(16, 16)
	$Player.visible = true
	
	startCell = $Map.get_used_cells()[0]
	endCell = $Map.get_used_cells()[$Map.get_used_cells().size()-1]
	
	#print(startCell, ', ', endCell)
	
	#print(isValidCellByIndex(255))
	
	#print(isValidMovement('down'))
	#print(getCellIndex(Vector2(1, 1)))

func isValidCellByIndex(index):
	if index > 0 || index < $Map.get_used_cells().size():
		return true
	
	return false

func getCellIndex(cell):
	var usedCells = $Map.get_used_cells()
	
	return usedCells.find(cell)

func getCurrentPlayerPosIndex():
	var playerPos = $Map.world_to_map($Player/KinematicBody2D.position)
	
	return getCellIndex(playerPos)

func isValidMovement(direction):
	var posToCheck = $Map.world_to_map($Player/KinematicBody2D.position)
	
	if direction == "up":
		posToCheck += Vector2(0, -1)
	elif direction == "down":
		posToCheck += Vector2(0, 1)
	elif direction == "left":
		posToCheck += Vector2(-1, 0)
	elif direction == "right":
		posToCheck += Vector2(1, 0)
	
	if $Map.get_cellv(posToCheck) == -1 or $Map.get_cellv(posToCheck) == 3:
		return false
	
	return true

func isInWinCell():
	var posToCheck = $Map.world_to_map($Player/KinematicBody2D.position)
	
	if posToCheck == endMazeCell:
		return true
	
	return false

func movePlayer(direction):
	var playerCell = $Map.world_to_map($Player/KinematicBody2D.position)
	
	$WalkedCells.set_cellv(playerCell, 0)
	
	$Player.movePlayerBody(direction)

func newMazeGame():
	$Player/KinematicBody2D.global_position = $Map.map_to_world(playerSpawnCell) + Vector2(16, 16)
	
	for cell in $WalkedCells.get_used_cells():
		$WalkedCells.set_cellv(cell, -1)
