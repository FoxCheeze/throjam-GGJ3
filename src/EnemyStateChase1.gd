extends EnemyState

var _player: Player = null
var _chaseDetector: Area2D


func _ready():
	yield(owner, "ready")
	_chaseDetector = enemy.collisionBoxes.get_node("ChaseDetector")
# warning-ignore:return_value_discarded
	_chaseDetector.connect("body_entered", self, "_on_ChaseDetector_body_entered")
# warning-ignore:return_value_discarded
	_chaseDetector.connect("body_exited", self, "_on_ChaseDetector_body_exited")


func _on_ChaseDetector_body_entered(body):
	_player = body
	if state_machine.state.name != "Attack" and state_machine.state.name != "Die": # Evita cancelar esses states
		state_machine.transition_to("Chase")


func enter(_msg := {}):
	_chaseDetector.scale = Vector2(1.5, 1.5) # Aumenta o range do Chase para perseguir numa area mais extensa
	enemy.animationPlayer.play("Chase")


func physics_update(delta):
	if _player == null: # Muda de state se o player não existir (este aproach evita cancelar outros states)
		state_machine.transition_to("Roam")
	else:
		var _player_position = (_player.global_position - enemy.global_position).normalized().round()
		enemy.velocity.x = move_toward(enemy.velocity.x, (enemy.max_speed + 10) * _player_position.x, enemy.acceleration * delta)
		enemy.looking_direction = _player_position.x # Flipa o inimigo com base na posição do player
	
	enemy.velocity.y += enemy.gravity * delta
	enemy.velocity = enemy.move_and_slide(enemy.velocity, Vector2.UP)


func _on_ChaseDetector_body_exited(_body): # Torna o player inexistente para a AI
	_player = null # OBS: Como sinais são assincronos usar somente eles pode causar cancelamentos de state

func exit():
	_chaseDetector.scale = Vector2(1, 1) # Volta o Chase Range ao normal
