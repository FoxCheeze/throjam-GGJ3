class_name State
extends Node

var entity: Entity = null
var state_machine = null


func _ready():
	yield(owner, "ready")
	entity = owner as Entity


func handle_input(_event: InputEvent):
	pass


func update(_delta: float):
	pass


func physics_update(_delta: float):
	pass


func on_enter(_msg: Dictionary = {}):
	pass


func on_exit():
	pass
