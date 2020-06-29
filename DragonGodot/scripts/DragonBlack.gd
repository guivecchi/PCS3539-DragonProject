extends Spatial

### CONSTANTS CONFIG ###
const MOUSE_SENS = 0.025

const HEAD_SENS = 0.3
const NECK_SENS = [0.2, 0.15, 0.2, 0.1]
const BODY_SENS = 0.1

const MAX_Z_ROTATION = 5
const MAX_X_ROTATION = 3
const MAX_ROTATION_HEAD = 1.1
const MAX_ROTATION_NECK = [0.4, 0.4, 0.4, 0.5]


### GLOBAL VARIABLES ###
var current_rotation_y = 0
var current_rotation_x = 0

var current_fire_scale = 0
var skel
var head
var neck1
var neck2
var neck3
var neck4

func _ready():
	skel = get_node("Armature/Skeleton")
	head = skel.find_bone("head")
	print("head id", head)
	neck1 = skel.find_bone("act_neck_1")
	neck2 = skel.find_bone("act_neck_2")
	neck3 = skel.find_bone("act_neck_3")
	neck4 = skel.find_bone("act_neck_4")
	
func _process(delta):
	pass
#	var headPose = skel.get_bone_pose(head)
#	headPose = headPose.rotated(Vector3(0, 1, 0), 0.1 * delta)
#	skel.set_bone_pose(head, headPose)

func _input(event):
	var headPose = skel.get_bone_pose(head)
	var neckPose1 = skel.get_bone_pose(neck1)
	var neckPose2 = skel.get_bone_pose(neck2)
	var neckPose3 = skel.get_bone_pose(neck3)
	var neckPose4 = skel.get_bone_pose(neck4)

	print("head  bone transform: ", neckPose4.basis.get_euler())
	
	if event is InputEventMouseMotion:
		var change_x = -event.relative.x * MOUSE_SENS
		var change_y = -event.relative.y * MOUSE_SENS
		
#		var distanceToMaxRotation = MAX_ROTATION.basis - headPose.basis - change_x * Basis(1,1,1)
#		var distanceToMinRotation = MIN_ROTATION - headPose - change_x
		
		if abs(headPose.rotated(Vector3(0, 0, -1), change_x * HEAD_SENS).basis.get_euler().z) < MAX_ROTATION_HEAD:
			headPose = headPose.rotated(Vector3(0, 0, -1), change_x * HEAD_SENS)
		
		if abs(neckPose1.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[0]).basis.get_euler().y) < MAX_ROTATION_NECK[0]:
			neckPose1 = neckPose1.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[0])
		
		if abs(neckPose2.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[1]).basis.get_euler().y) < MAX_ROTATION_NECK[1]:
			neckPose2 = neckPose2.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[1])
			
		if abs(neckPose3.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[2]).basis.get_euler().y) < MAX_ROTATION_NECK[2]:
			neckPose3 = neckPose3.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[2])
		
		if abs(neckPose4.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[3]).basis.get_euler().y) < MAX_ROTATION_NECK[3]:
			neckPose4 = neckPose4.rotated(Vector3(0, 1, 0), change_x * NECK_SENS[3])
		
#		if change_y + current_rotation_x < MAX_X_ROTATION and change_y + current_rotation_x > -MAX_X_ROTATION:
#			headPose = headPose.rotated(Vector3(1, 0, 0), change_y * HEAD_SENS)
		
		skel.set_bone_pose(head, headPose)
		skel.set_bone_pose(neck1, neckPose1)
		skel.set_bone_pose(neck2, neckPose2)
		skel.set_bone_pose(neck3, neckPose3)
		skel.set_bone_pose(neck4, neckPose4)
