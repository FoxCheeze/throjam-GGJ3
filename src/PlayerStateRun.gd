extends State

var input_direction: Vector2 = Vector2.ZERO setget set_input_direction


func on_enter(_msg: Dictionary = {}):
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
		entity.max_speed * input_direction,
		entity.acceleration * delta
	)

	entity.velocity = entity.move_and_slide(entity.velocity)

	# Transitions
	if input_direction == Vector2.ZERO:
		state_machine.transition_state("Idle")
	
	if Input.is_action_pressed("Sprint"):
		state_machine.transition_state("Sprint")

	if Input.is_action_just_pressed("Attack") and playerStats.can_attack:
		state_machine.transition_state("Attack")
	
	if Input.is_action_pressed("Defend"):
		state_machine.transition_state("Defend")


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
