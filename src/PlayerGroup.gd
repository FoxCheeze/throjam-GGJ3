extends Node2D


func _ready():
	playerStats.connect("leveled_up", self, "on_player_level_up")


func on_player_level_up(previous_level):
	var player = get_node("PlayerLevel%d" % previous_level)
	var current_position = player.global_position

	var new_player = load("res://scenes/PlayerLevel%d.tscn" % playerStats.level).instance()
	
	player.queue_free()
	call_deferred("add_child", new_player)
	new_player.global_position = current_position
	
