extends RigidBody2D

const DEFAULT_SPEED = 350
const speedBallIncrease = 50

var _speed = DEFAULT_SPEED
var direction = 1
var reset := false
@onready var _initial_pos = Vector2(570, 342)

func _ready():
	_initial_pos = position
#	linear_velocity = Vector2(_speed, _speed).rotated(randf_range(-PI, PI))
	linear_velocity.x  = _speed * direction
	linear_velocity.y  = _speed * randf_range(0, 0.2)

func _physics_process(delta):
	linear_velocity.x  = _speed * direction


func _integrate_forces(state):
	if reset:
		_speed = DEFAULT_SPEED
		state.transform = Transform2D(0, _initial_pos)
		state.linear_velocity.y = _speed * randf_range(0, 0.2)
		reset = false
