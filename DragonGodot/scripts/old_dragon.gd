extends KinematicBody

const MOUSE_SENS = 0.2

const HEAD_SENS = 1
const NECK_SENS = 0.4
const BODY_SENS = 0.1

const MAX_Y_ROTATION = 60
const MAX_X_ROTATION = 3

var current_rotation_y = 0
var current_rotation_x = 0

var current_fire_scale = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("fire"):
		$body/head_spine/head/Fire/Flames.emitting = true
		if current_fire_scale < 150:
			current_fire_scale += 50
	else:
		$body/head_spine/head/Fire/Flames.emitting = false
		current_fire_scale = 0
			
	$body/head_spine/head/Fire/Flames.process_material.set('scale', current_fire_scale)
		
		

func _input(event):
	if event is InputEventMouseMotion:
		var change_x = -event.relative.x * MOUSE_SENS
		var change_y = -event.relative.y * MOUSE_SENS
		
		if change_x + current_rotation_y < MAX_Y_ROTATION and change_x + current_rotation_y > -MAX_Y_ROTATION:
			$body/head_spine/head.rotate_y(deg2rad(change_x * HEAD_SENS))
			$body/head_spine.rotate_y(deg2rad(change_x * NECK_SENS))
			$body.rotate_y(deg2rad(change_x * BODY_SENS))
			current_rotation_y += change_x
		
		if change_y + current_rotation_x < MAX_X_ROTATION and change_y + current_rotation_x > -MAX_X_ROTATION:
#			$body/head_spine/head.rotate_x(-deg2rad(change_y * HEAD_SENS))
			$body/head_spine.rotate_x(-deg2rad(change_y * NECK_SENS))
			$body.rotate_x(-deg2rad(change_y * BODY_SENS))
			current_rotation_x += change_y
