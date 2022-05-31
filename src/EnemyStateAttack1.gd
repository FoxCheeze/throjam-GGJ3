extends EnemyState


func _ready():
	# Conecta os sinais as suas funções
	yield(owner, "ready")
# warning-ignore:return_value_discarded
	enemy.collisionBoxes.get_node("AttackRangeDetector").connect("body_entered", self, "_on_AttackRangeDetector_body_entered")
	enemy.animationPlayer.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")


func _on_AttackRangeDetector_body_entered(_body):
	state_machine.transition_to("Attack")
	enemy.collisionBoxes.disable_box(["AttackRangeDetector"]) # Desabilita para pode re-atacar caso o player não saia da area


func enter(_msg := {}):
	enemy.animationPlayer.play("Attack")


func physics_update(delta):
	enemy.velocity.x = move_toward(enemy.velocity.x, 0, enemy.friction * delta) # Evita o inimigo deslizar enquanto ataca
	
	enemy.velocity.y += enemy.gravity * delta
	enemy.velocity = enemy.move_and_slide(enemy.velocity, Vector2.UP)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name != "Attack":
		return
	
	state_machine.transition_to("Chase")
	enemy.collisionBoxes.enable_box(["AttackRangeDetector"]) # Ativa para poder detectar o player novamente


func exit():
	enemy.collisionBoxes.enable_box(["AttackRangeDetector"]) # Evita sair com caixa desativada （念の為）
