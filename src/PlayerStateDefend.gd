extends State

export var speed_decrease: float = 2
export var defend_recover_time: float = 5

var input_direction: Vector2 = Vector2.ZERO setget set_input_direction


func _ready():
	yield(owner, "ready")

	var err = entity.connect("received_attack", self, "_on_Attacked")
	assert(err == OK)


func on_enter(_msg: Dictionary = {}):
	entity.get_node("Sprite").self_modulate = Color("#96ff00")
	AnimationHandler.four_direction_animation(
		entity.animationPlayer,
		entity.looking_direction,
		entity.positionPivot,
		self.name
	)


func physics_update(delta: float):
	set_input_direction(
		Vector2(
			Input.get_axis("Left", "Right"),
			Input.get_axis("Up", "Down")
		).normalized()
	)

	entity.velocity = entity.velocity.move_toward(
		(entity.max_speed / speed_decrease) * input_direction,
		entity.acceleration * delta
	)

	entity.velocity = entity.move_and_slide(entity.velocity)

	# Transitions
	if Input.is_action_just_pressed("Attack") and playerStats.can_attack:
		state_machine.transition_state("Attack")

	if Input.is_action_just_released("Defend"):
		state_machine.transition_state("Idle")


func set_input_direction(new_input_direction: Vector2):
	if new_input_direction == input_direction:
		return
		
	input_direction = new_input_direction
	entity.looking_direction = input_direction
	AnimationHandler.four_direction_animation(
		entity.animationPlayer,
		entity.looking_direction,
		entity.positionPivot,
		self.name
	)

func _on_Attacked():
	playerStats.can_defend = false
	playerStats.defendRecoverTimer.start(defend_recover_time)
	state_machine.transition_state("Idle")


func on_exit():
	entity.get_node("Sprite").self_modulate = Color("#ffffff")
