extends EnemyState


func enter(_msg := {}):
	enemy.collisionBoxes.disable_box(["All"])
	enemy.collision_layer = 0
	enemy.animationPlayer.play("Die")
	yield(enemy.animationPlayer, "animation_finished")
	enemy.queue_free()
