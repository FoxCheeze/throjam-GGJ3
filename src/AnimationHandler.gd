class_name AnimationHandler
extends Object

# Set simple logic for handling four direction animations.
# NOTE: the animations names MUST end with one of these:
# Back, Front, Left, Right
static func four_direction_animation(
		animationPlayer: AnimationPlayer,
		direction: Vector2,
		_positionPivot: Position2D,
		animation_name: String
	) -> void:

	assert(
		animationPlayer.has_animation("%s Back" % animation_name) and
		animationPlayer.has_animation("%s Front" % animation_name) and
		animationPlayer.has_animation("%s Left" % animation_name) and
		animationPlayer.has_animation("%s Right" % animation_name),
		"failed to play `%s` animations" % animation_name
	)
	
	if direction.y < 0 and to_positive(direction.y) < to_positive(direction.x): # Up
		animationPlayer.play("%s Back" % animation_name)
	
	elif direction.y > 0 and to_positive(direction.y) > to_positive(direction.x): # Down
		animationPlayer.play("%s Front" % animation_name)

	if direction.x < 0 and to_positive(direction.y) >= to_positive(direction.x): # Left
		animationPlayer.play("%s Left" % animation_name)

	elif direction.x > 0 and to_positive(direction.y) <= to_positive(direction.x): # Right
		animationPlayer.play("%s Right" % animation_name)


static func to_positive(value):
	return value * 2 / 2
