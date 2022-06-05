class_name PlayerStats
extends Node

signal leveled_up(previous_level)
signal player_died()
signal victory()

var debug: bool = false

var level: int = 1
var attackRecoverTimer: Timer = null
var defendRecoverTimer: Timer = null

var can_attack: bool = true
var can_defend: bool = true
var experience: int = 0 
var experience_required: int = get_experience_required()
var player = null
var playerManager


func get_experience_required() -> int:
	return int(round(pow(level + 1, 2) * 8 + 10))


func _ready():
	attackRecoverTimer = Timer.new()
	attackRecoverTimer.one_shot = true
	call_deferred("add_child", attackRecoverTimer)

	defendRecoverTimer = Timer.new()
	defendRecoverTimer.one_shot = true
	call_deferred("add_child", defendRecoverTimer)

	var err = attackRecoverTimer.connect("timeout", self, "on_AttackRecoverTimer_timeout")
	assert(err == OK)

	err = defendRecoverTimer.connect("timeout", self, "on_DefendRecoverTimer_timeout")
	assert(err == OK)


func gain_experience(experience_value: int):
	if level >= 5:
		return

	experience += experience_value

	while experience >= experience_required:
		experience -= experience_required
		level_up()


func level_up():
	level += 1
	player.health = player.max_health
	emit_signal("leveled_up", level - 1)

	experience_required = get_experience_required()


func heal(heal_value: int):
	if player.health >= player.max_health:
		player.health = player.max_health
		return

	player.health += heal_value


func on_AttackRecoverTimer_timeout():
	can_attack = true


func on_DefendRecoverTimer_timeout():
	can_defend = true


func _process(_delta):
	if Input.is_action_just_pressed("ui_page_down"):
		if debug:
			debug = false
		else:
			debug = true

func on_player_victory():
	emit_signal("victory")


func restart():
	level = 1
	experience = 0
	experience_required = get_experience_required()
