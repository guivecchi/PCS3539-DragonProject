extends RayCast


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.enabled and is_colliding():
		print('AIMED TO NAME ', get_collider().name, get_collider_shape())
		print('AIMED TO SHAPE ', get_collider_shape())
		print('AIMED TO PARENT NAME ', get_collider().get_parent().name)
		
		if (get_collider().get_parent().has_method('set_fire')):
			print('IS FLAMMABLE: ', get_collider().get_parent().name)
			get_collider().get_parent().set_fire()
		print('\n')
		print('\n')
		print('\n')
		
