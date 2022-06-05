extends Node2D

export var throjan_path: NodePath

var throjan


func _ready():
	var err = playerStats.connect("player_died", self, "on_player_death")
	assert(err == OK)
	
	err = playerStats.connect("victory", self, "on_player_victory")
	assert(err == OK)

	throjan = get_node(throjan_path)


func on_player_death():
	var deathScreen = load("res://scenes/DeathScreen.tscn").instance()
	add_child(deathScreen)


func on_player_victory():
	var victoryScreen = load("res://scenes/VictoryScreen.tscn").instance()
	add_child(victoryScreen)
