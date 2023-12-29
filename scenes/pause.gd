extends Control

signal onPlay

func _ready():
	$ProgressBar.value = MusicController.volume
	$VSlider.value = MusicController.volume

func _on_play_button_pressed():
	emit_signal("onPlay")


func _on_back_button_pressed():
	MusicController.clicksound.play()
	Global.velocity = Global.VELOCITY_BASE
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_volume_up_button_pressed():
	MusicController.clicksound.play()
	MusicController.turn_up_volume()
	$ProgressBar.value = MusicController.volume
	$VSlider.value = MusicController.volume


func _on_volume_down_button_pressed():
	MusicController.clicksound.play()
	MusicController.turn_down_volume()
	$ProgressBar.value = MusicController.volume
	$VSlider.value = MusicController.volume


func _on_v_slider_value_changed(value):
	$ProgressBar.value = value
	MusicController.change_volume(value)

