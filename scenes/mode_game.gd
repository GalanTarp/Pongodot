extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	Global.move_background(delta, $TextureRect)


func _on_button_pressed():
	MusicController.clicksound.play()
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_button_2_pressed():
	MusicController.clicksound.play()
	Global.Cooperative = true
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_button_mouse_entered():
	MusicController.hoversound.play()


func _on_button_2_mouse_entered():
	MusicController.hoversound.play()


func _on_h_slider_value_changed(value):
	$Lives.text = "MAX GOALS: " + str(value)
	Global.max_goals = value
