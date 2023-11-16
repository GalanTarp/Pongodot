extends Node

const speed = 50
const friction = speed/4
const xP1 = 20
const xP2 = 1130
var reset := false



func _physics_process(delta):
	var velocityP1 = $Player.velocity.y
	var velocityP2 = $Player2.velocity.y
	var moveP1 = false
	var moveP2 = false
	if Input.is_action_pressed("upP1"):
		if(velocityP1 > -speed*10):
			$Player.velocity.y -= speed
			moveP1 = true
	if Input.is_action_pressed("downP1"):
		if(velocityP1 < speed*10):
			$Player.velocity.y += speed
			moveP1 = true
	if Input.is_action_pressed("upP2"):
		if(velocityP2 > -speed*10):
			$Player2.velocity.y -= speed
			moveP2 = true
	if Input.is_action_pressed("downP2"):
		if(velocityP2 < speed*10):
			$Player2.velocity.y += speed
			moveP2 = true
	
	#Reset velocity in x
	$Player.velocity.x = 0
	$Player2.velocity.x = 0
	
	var pP1 = $Player.position.y
	var pP2 = $Player2.position.y
	$Player.transform = Transform2D(0, Vector2(xP1, pP1))
	$Player2.transform = Transform2D(0, Vector2(xP2, pP2))
	
	#Create friction when its not pressed
	if(velocityP1 != 0):
		$Player.velocity.y += friction if velocityP1 < 0 else -friction
	if(velocityP2 != 0):
		$Player2.velocity.y += friction if velocityP2 < 0 else -friction
	
	$Player.move_and_slide()
	$Player2.move_and_slide()


func _on_ball_body_entered(body):
	print(body.position.x)
	if body.is_in_group("player"):
		$Ball.direction *= -1
		print(body.position.x)


func _on_goal_p_2_body_entered(body):
	print(Global.ScoreP2)
#	$Ball.set_global_pos(_initial_pos)
	$Ball.reset = true
	Global.ScoreP2 += 1
	$ScoreP2.text = str(Global.ScoreP2)


func _on_goal_p_1_body_entered(body):
	print("gooal")
#	$Ball.set_global_pos(_initial_pos)
#	$Ball.position = _initial_pos
	$Ball.reset = true
	Global.ScoreP1 += 1
	$ScoreP1.text = str(Global.ScoreP1)


func _on_timer_speed_ball_timeout():
	$Ball._speed += $Ball.speedBallIncrease
