extends MeshInstance

const FIRE_RECOVER = 0.001
const FIRE_DAMAGE = 0.005

const TOWER_STATE := {
	'normal' : 0,
	'heating' : 1,
	'burning' : 2
}

export var flammable = true

onready var _state = TOWER_STATE.normal

onready var fire_shield = 100
onready var hp = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	self.stop_fire()

func set_fire():
	
	if (self._state == TOWER_STATE.normal):
		if (self.fire_shield > 0):
			self.fire_shield -= FIRE_DAMAGE

	elif (self._state == TOWER_STATE.heating):
		
		if (self.fire_shield > 0):
			self.fire_shield -= FIRE_DAMAGE
		else:
			self.fire_shield = 0
			self._state = TOWER_STATE.burning
			
	elif (self._state == TOWER_STATE.burning):
		pass
		
	
func stop_fire():
	self._state = TOWER_STATE.normal
	$Burning/Flames.emitting = false
	$Burning/Smoke.emitting = false
	
func _set_fire_level(flamesLevel, smokeLevel):
	if (flamesLevel > 0):		
		$Burning/Flames.emitting = true
	else:
		$Burning/Flames.emitting = false
		
	if (smokeLevel > 0):		
		$Burning/Smoke.emitting = true
	else:
		$Burning/Smoke.emitting = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print('State - Shield - HP ', self._state, self.fire_shield, self.hp)
	
	if (self._state == TOWER_STATE.normal):
		if (self.fire_shield < 100):
			self._state = TOWER_STATE.heating
			self.fire_shield += FIRE_RECOVER
		else:
			self.fire_shield = 100
			
	elif (self._state == TOWER_STATE.heating):
		if (self.fire_shield >= 100):
			self._state = TOWER_STATE.normal
			self.fire_shield = 100
			self._set_fire_level(0, 0)
		elif (self.fire_shield <= 0):
			self._state = TOWER_STATE.burning
			self.fire_shield = 0
			self._set_fire_level(1, 1)
		else:
			self.fire_shield += FIRE_RECOVER
			self._set_fire_level(1, 0)			
			
	elif (self._state == TOWER_STATE.burning):
		self.hp -= FIRE_DAMAGE
		pass
