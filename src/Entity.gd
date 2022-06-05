class_name Entity
extends KinematicBody2D

signal received_attack

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
onready var fsm = get_node("StateMachine")

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
		playerStats.emit_signal("player_died")
		collisionBoxes.disable_box(["All"])
		fsm.transition_state("Die")


func recieve_damage(damage_value: int):
	if fsm.state.name == "Defend":
		damage_value = 0
		
	set_health(health - damage_value)
	
	
func recieve_knockback(knockback_value: float, direction: Vector2):
	if fsm.state.name == "Defend":
		knockback_value /= 4
			
	velocity = direction * knockback_value 
	if fsm.state.name == "Defend":
		emit_signal("received_attack")
