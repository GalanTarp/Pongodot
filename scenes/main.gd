extends Node

const SPEED = 50
const FRICTION = SPEED/4
const xP1 = 20
const xP2 = 1130
const MAX_GOALS = 3
var reset := false
var pause:= false

func _process(delta):
	Global.move_background(delta, $TextureRect)


func _physics_process(delta):
	if(pause):
		return
	var velocityP1 = $Player.velocity.y
	var velocityP2 = $Player2.velocity.y
	var moveP1 = false
	var moveP2 = false
	if Input.is_action_pressed("upP1"):
		if(velocityP1 > -SPEED*10):
			$Player.velocity.y -= SPEED
			moveP1 = true
	if Input.is_action_pressed("downP1"):
		if(velocityP1 < SPEED*10):
			$Player.velocity.y += SPEED
			moveP1 = true
	if Input.is_action_pressed("upP2"):
		if(velocityP2 > -SPEED*10):
			$Player2.velocity.y -= SPEED
			moveP2 = true
	if Input.is_action_pressed("downP2"):
		if(velocityP2 < SPEED*10):
			$Player2.velocity.y += SPEED
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
		$Player.velocity.y += FRICTION if velocityP1 < 0 else -FRICTION
	if(velocityP2 != 0):
		$Player2.velocity.y += FRICTION if velocityP2 < 0 else -FRICTION
	
	$Player.move_and_slide()
	$Player2.move_and_slide()


func _on_ball_body_entered(body):
	if body.is_in_group("player"):
		$Ball.direction *= -1
		$PunchAudio.play()
	if body.is_in_group("muro"):
		$PunchAudio.play()


func _on_goal_p_2_body_entered(body):
	Global.ScoreP2 += 1
	$ScoreP2.text = str(Global.ScoreP2)

	$GOAL.visible = true
	await get_tree().create_timer(2.0).timeout

	if(Global.ScoreP2 < MAX_GOALS):
		$Ball.reset = true
		Global.velocity = Global.VELOCITY_BASE
		$GOAL.visible = false
	else:
		$GOAL.text = "PLAYER 2 WIN"
		$NewGameButton.visible = true


func _on_goal_p_1_body_entered(body):
	Global.ScoreP1 += 1
	$ScoreP1.text = str(Global.ScoreP1)

	$GOAL.visible = true
	await get_tree().create_timer(2.0).timeout

	if(Global.ScoreP1 < MAX_GOALS):
		$Ball.reset = true
		Global.velocity = Global.VELOCITY_BASE
		$GOAL.visible = false
	else:
		$GOAL.text = "PLAYER 1 WIN"
		$NewGameButton.visible = true


func _on_timer_speed_ball_timeout():
	$Ball._speed += $Ball.speedBallIncrease
	Global.velocity += 1


func _on_new_game_button_pressed():
	get_tree().reload_current_scene()


func _on_pause_button_pressed():
	pause = true
	$Ball.pause = true
	print("pausa ", $Ball.pause)
	$Pause.visible = true


func _on_pause_on_play():
	pause = false
	$Ball.pause = false
	$Pause.visible = false
