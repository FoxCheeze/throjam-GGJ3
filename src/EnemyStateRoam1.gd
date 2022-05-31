extends State

export var roam_limit: float = 100

var direction: Vector2 = Vector2.ZERO
var new_position: Vector2
var spawnpoint: Vector2
var timer: Timer = Timer.new()


func _ready():
	yield(owner, "ready")
	
	spawnpoint = entity.global_position


func on_enter(_msg := {}):
	new_position = Vector2(
		rand_range(spawnpoint.x - roam_limit, spawnpoint.x + roam_limit),
		rand_range(spawnpoint.y - roam_limit, spawnpoint.y + roam_limit)
	)

	direction = (new_position - entity.global_position).normalized()
	entity.looking_direction = direction
	AnimationHandler.four_direction_animation(
		entity.animationPlayer,
		entity.looking_direction,
		entity.positionPivot,
		self.name
	)


func physics_update(delta): 
	set_direction((new_position - entity.global_position).normalized())
	entity.velocity = entity.velocity.move_toward(entity.max_speed * direction, entity.acceleration * delta)
	
	entity.velocity = entity.move_and_slide(entity.velocity)


func set_direction(new_direction):
	if new_direction.round() == direction.round():
		return
	
	state_machine.transition_state("Idle")

