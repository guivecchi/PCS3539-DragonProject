extends Spatial

const TRANSITION_SPEED = 2
const FLY_TRANSITION_SPEED := {
	'normal' : 0,
	'fast' : 1
}

onready var animator = $AnimationTree

var last_speed
var transition_state := 0.0

# Main function, called at every 60 sec
func _process(delta):
	
	# The new speed to move the dragon
	var target_speed = null

	# If the GO FAST button is pressed, set the speed target to fast
	if Input.is_action_pressed("go_fast"):
		target_speed = FLY_TRANSITION_SPEED.fast
	else :
		target_speed = FLY_TRANSITION_SPEED.normal
		
	# Increases the linear counter
	transition_state += delta * TRANSITION_SPEED
	
	# Limits the linear counter to 1 (maximum of the blend)
	if transition_state > 1:
		transition_state = 1
		
	# Goes back to the previous animation
	if last_speed != target_speed:
		transition_state = 0
		
	# Set the new animaation state, interpolating the blend
	animator['parameters/SpeedUp/blend_amount'] = lerp(animator.get('parameters/SpeedUp/blend_amount'), target_speed, transition_state)
	
	# Updates the last speed
	last_speed = target_speed
	
	
	# Shot the fire animation
	if Input.is_action_pressed("spit_fire"):
		animator['parameters/Fire/active'] = true
	else :
		animator['parameters/Fire/active'] = false		
