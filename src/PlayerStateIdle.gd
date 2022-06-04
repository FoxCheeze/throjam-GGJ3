extends State

var input_direction: Vector2 = Vector2.ZERO


func on_enter(_msg: Dictionary = {}):
	AnimationHandler.four_direction_animation(
		entity.animationPlayer,
		entity.looking_direction,
		entity.positionPivot,
		self.name
	)


func physics_update(delta: float):
	entity.velocity = entity.velocity.move_toward(Vector2.ZERO, entity.friction * delta)

	input_direction = (
		Vector2(
			Input.get_axis("Left", "Right"),
			Input.get_axis("Up", "Down")
		).normalized()
	)

	entity.velocity = entity.move_and_slide(entity.velocity)

	# Transitions
	if input_direction != Vector2.ZERO:
		state_machine.transition_state("Run")
	
	if Input.is_action_just_pressed("Attack") and playerStats.can_attack:
		state_machine.transition_state("Attack")

	if Input.is_action_pressed("Defend") and playerStats.can_defend:
		state_machine.transition_state("Defend")
