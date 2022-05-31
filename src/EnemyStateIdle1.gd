extends State

export var idle_duration: float = 2

onready var idleDurationTimer: Timer


func _ready():
	yield(owner, "ready")

	idleDurationTimer = get_node("IdleDurationTimer")
	var err = idleDurationTimer.connect("timeout", self, "_on_IdleDurationTimer_timeout")
	assert(err == OK)


func on_enter(_msg := {}):
	idleDurationTimer.start(idle_duration)

	AnimationHandler.four_direction_animation(
		entity.animationPlayer,
		entity.looking_direction,
		entity.positionPivot,
		self.name
	)


func physics_update(delta):
	entity.velocity = entity.velocity.move_toward(Vector2.ZERO, entity.friction * delta)

	entity.velocity = entity.move_and_slide(entity.velocity)


func _on_IdleDurationTimer_timeout():
	state_machine.transition_state("Roam")


func on_exit():
	idleDurationTimer.stop()
