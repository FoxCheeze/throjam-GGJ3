extends State


func _ready():
	yield(owner, "ready")

	var err = entity.collisionBoxes.get_node("AttackRangeDetector").connect("body_entered", self, "_on_AttackRangeDetector_body_entered")
	assert(err == OK)

	err = entity.animationPlayer.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	assert(err == OK)


func _on_AttackRangeDetector_body_entered(_body):
	state_machine.transition_state("Attack")
	entity.collisionBoxes.disable_box(["AttackRangeDetector"]) # Desabilita para pode re-atacar caso o player não saia da area


func on_enter(_msg := {}):
	entity.sfx.get_node("Hit").play()
	entity.get_node("Slash").visible = true
	AnimationHandler.four_direction_animation(
		entity.animationPlayer,
		entity.looking_direction,
		entity.positionPivot,
		self.name
	)


func physics_update(delta):
	entity.velocity = entity.velocity.move_toward(Vector2.ZERO, entity.friction * delta)
	
	entity.velocity = entity.move_and_slide(entity.velocity)


func _on_AnimationPlayer_animation_finished(anim_name):
	if not anim_name.begins_with("Attack"):
		return
	
	state_machine.transition_state("Chase")
	entity.collisionBoxes.enable_box(["AttackRangeDetector"]) # Ativa para poder detectar o player novamente


func on_exit():
	entity.get_node("Slash").visible = false
	entity.collisionBoxes.disable_box(["HitBox"])
	entity.collisionBoxes.enable_box(["AttackRangeDetector"]) # Evita sair com caixa desativada （念の為）
