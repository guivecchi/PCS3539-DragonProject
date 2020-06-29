extends KinematicBody

### ANIMATIONS ###

# constants
const TRANSITION_SPEED = 2
const FLY_TRANSITION_SPEED := {
	'normal' : 0,
	'fast' : 1
}

# instances
onready var animator = $AnimationTree
var last_speed
var transition_state := 0.0

### LOCOMOTION ###
const SPEED = 6
const ACC = 0.1
var velocity = Vector3(0, 0, 0)

### NECK ROTATION ###
# contants
const MOUSE_SENS = 0.0010

const HEAD_SENS = 0.3
const NECK_SENS = [0.2, 0.15, 0.2, 0.1]
const BODY_SENS = 0.1

const MAX_Z_ROTATION = 5
const MAX_X_ROTATION = 3
const MAX_ROTATION_HEAD = 1.1
const MAX_ROTATION_NECK = [0.4, 0.4, 0.4, 0.5]

# instances
var skel
var head
var neck1
var neck2
var neck3
var neck4

func _ready():
	skel = get_node("a/Skeleton")
	head = skel.find_bone("head")
	print("head id", head)
	neck1 = skel.find_bone("act_neck_1")
	neck2 = skel.find_bone("act_neck_2")
	neck3 = skel.find_bone("act_neck_3")
	neck4 = skel.find_bone("act_neck_4")

# Main function, called at every 60 sec
func _process(delta):
	
	# Handling movement
	if Input.is_action_pressed("move_forward"):
		var cur_dir = getFacingDirection()
		velocity = lerp(velocity, cur_dir, ACC)
	elif Input.is_action_pressed("move_backward"):
		var cur_dir = -getFacingDirection()
		velocity = lerp(velocity, cur_dir, ACC/2)
	else:
		velocity = lerp(velocity, Vector3(0, 0, 0), ACC/2)
		
	
	move_and_slide(velocity * SPEED)
	
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
		$a/Skeleton/Fire/Flames.emitting = true
	else :
		animator['parameters/Fire/active'] = false
		$a/Skeleton/Fire/Flames.emitting = false

func _input(event):
#	var headPose = skel.get_bone_pose(head)
#	var neckPose1 = skel.get_bone_pose(neck1)
#	var neckPose2 = skel.get_bone_pose(neck2)
#	var neckPose3 = skel.get_bone_pose(neck3)
#	var neckPose4 = skel.get_bone_pose(neck4)

	
	if event is InputEventMouseMotion:
		var change_x = -event.relative.x * MOUSE_SENS
		var change_y = -event.relative.y * MOUSE_SENS
		print("changes  ", Vector3(change_x, change_y, 0).normalized())
		
#		self.global_rotate(Vector3(change_x, 0, change_y), HEAD_SENS)
		self.global_rotate(Vector3(0, 1, 0).normalized(), HEAD_SENS * change_x)
		self.global_rotate(Vector3(1, 0, 0).normalized(), HEAD_SENS * change_y)
#		self.global_transform.basis.z = getFacingDirection().rotated(Vector3(0, 1, 0), change_x * HEAD_SENS)
		
#		var distanceToMaxRotation = MAX_ROTATION.basis - headPose.basis - change_x * Basis(1,1,1)
#		var distanceToMinRotation = MIN_ROTATION - headPose - change_x
		
#		if abs(headPose.rotated(Vector3(0, 0, -1), change_x * HEAD_SENS).basis.get_euler().z) < MAX_ROTATION_HEAD:
#			headPose = headPose.rotated(Vector3(0, 0, -1), change_x * HEAD_SENS)
#
#		if abs(neckPose1.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[0]).basis.get_euler().y) < MAX_ROTATION_NECK[0]:
#			neckPose1 = neckPose1.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[0])
#
#		if abs(neckPose2.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[1]).basis.get_euler().y) < MAX_ROTATION_NECK[1]:
#			neckPose2 = neckPose2.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[1])
#
#		if abs(neckPose3.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[2]).basis.get_euler().y) < MAX_ROTATION_NECK[2]:
#			neckPose3 = neckPose3.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[2])
#
#		if abs(neckPose4.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[3]).basis.get_euler().y) < MAX_ROTATION_NECK[3]:
#			neckPose4 = neckPose4.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[3])
#
#		if change_y + current_rotation_x < MAX_X_ROTATION and change_y + current_rotation_x > -MAX_X_ROTATION:
#			headPose = headPose.rotated(Vector3(1, 0, 0), change_y * HEAD_SENS)
		
#		skel.set_bone_pose(head, headPose)
#		skel.set_bone_pose(neck1, neckPose1)
#		skel.set_bone_pose(neck2, neckPose2)
#		skel.set_bone_pose(neck3, neckPose3)
#		skel.set_bone_pose(neck4, neckPose4)

func getFacingDirection():
	return self.global_transform.basis.z.normalized()

func move(var x, var z, delta):
	var moveDirection = Vector3(x, 0, z) * SPEED; 
	self.global_translate(Vector3().linear_interpolate(moveDirection, delta));
