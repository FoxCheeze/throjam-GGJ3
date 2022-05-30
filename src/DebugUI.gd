extends Control

export var entity_path: NodePath 

var entity: Entity = null

onready var previousState = get_node("PState") as Label
onready var currentState = get_node("HBoxContainer/CState") as Label
onready var level = get_node("HBoxContainer/Level")

onready var velocity_y = get_node("GridContainer/VelocityY") as Label
onready var velocity_x = get_node("GridContainer/VelocityX") as Label

onready var currentAnimation = get_node("GridContainer/CAnimation") as Label
onready var experience = get_node("GridContainer/Exp") as Label


func _ready():
	entity = get_node(entity_path) as Entity


func _process(_delta):
	previousState.text = "History:\n" + str(entity.get_node("StateMachine").history)
	currentState.text = str(entity.get_node("StateMachine").state)
	level.text = str(playerStats.level)

	velocity_x.text = "Velocity.x = " + str(entity.velocity.x)
	velocity_y.text = "Velocity.y = " + str(entity.velocity.y)

	currentAnimation.text = str(entity.animationPlayer.current_animation)
	experience.text = "Exp = " + str(playerStats.experience) + "\t Required = " + str(playerStats.experience_required)
