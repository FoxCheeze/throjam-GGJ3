class_name Entity
extends KinematicBody2D

export var acceleration: float = 500
export var friction: float = 500
export var health: int = 50 setget set_health
export var max_health: int = 50
export var damage: int = 10
export var knockback_force: float = 300
export var max_speed: float = 100

onready var animationPlayer: AnimationPlayer = $AnimationPlayer as AnimationPlayer
onready var collisionBoxes: CollisionBoxes = $PositionPivot/CollisionBoxes as CollisionBoxes
onready var positionPivot: Position2D = $PositionPivot as Position2D

var velocity: Vector2 = Vector2.ZERO
var looking_direction: Vector2 = Vector2.DOWN setget set_looking_direction


func _ready():
	randomize()
	assert(animationPlayer != null, "failed to create reference of AnimationPlayer.")
	assert(positionPivot != null, "failed to create reference of PositionPivot.")
	assert(collisionBoxes != null, "failed to create reference of CollisionBoxes.")


func set_looking_direction(new_direction: Vector2):
	if new_direction == Vector2.ZERO:
		return
	
	looking_direction = new_direction


func set_health(new_health):
	if new_health == health:
		return
	
	if new_health < 0:
		health = 0
	else:
		health = new_health

	if health <= 0:
		collisionBoxes.disable_box(["All"])
		get_node("StateMachine").transition_state("Die")


func recieve_damage(damage_value: int):
	set_health(health - damage_value)


func recieve_knockback(knockback_value: float, direction: Vector2):
	velocity = direction * knockback_value 
