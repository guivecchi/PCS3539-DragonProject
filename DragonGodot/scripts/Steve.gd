extends KinematicBody

const SPEED = 6
const ACC = 0.1

const RADIUS = sqrt(2)

var velocity = Vector3(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Moving the ball in x axis
	if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
		velocity.z = 0
	elif Input.is_action_pressed("move_left"):
		velocity.z = -1
		$MeshInstance.rotate_x(-60 * SPEED/RADIUS)
	elif Input.is_action_pressed("move_right"):
		velocity.z = 1
		$MeshInstance.rotate_x(60 * SPEED/RADIUS)
	else:
		velocity.z = lerp(velocity.z, 0, ACC)
		
	if Input.is_action_pressed("move_forward") and Input.is_action_pressed("move_backward"):
		velocity.x = 0
	elif Input.is_action_pressed("move_forward"):
		velocity.x = 1
		$MeshInstance.rotate_z(-60 * SPEED/RADIUS)
	elif Input.is_action_pressed("move_backward"):
		velocity.x = -1
		$MeshInstance.rotate_z(60 * SPEED/RADIUS)
	else:
		velocity.x = lerp(velocity.x, 0, ACC)

	move_and_slide(velocity * SPEED)
