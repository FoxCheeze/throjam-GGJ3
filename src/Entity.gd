class_name Entity
extends KinematicBody2D

export var acceleration: float = 500
export var friction: float = 500
export var max_speed: float = 100

onready var animationPlayer: AnimationPlayer = $AnimationPlayer as AnimationPlayer
onready var collisionBoxes: CollisionBoxes = $PositionPivot/CollisionBoxes as CollisionBoxes
onready var positionPivot: Position2D = $PositionPivot as Position2D

var velocity: Vector2 = Vector2.ZERO
var looking_direction: Vector2 = Vector2.DOWN setget set_looking_direction


func _ready():
	assert(animationPlayer != null, "failed to create reference of AnimationPlayer.")
	assert(positionPivot != null, "failed to create reference of PositionPivot.")
	assert(collisionBoxes != null, "failed to create reference of CollisionBoxes.")


func set_looking_direction(new_direction: Vector2):
	if new_direction == Vector2.ZERO:
		return
	
	looking_direction = new_direction

