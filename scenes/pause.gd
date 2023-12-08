extends Control

signal onPlay

func _ready():
	$ProgressBar.value = 0

func _on_play_button_pressed():
	emit_signal("onPlay")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_volume_up_button_pressed():
	MusicController.turn_up_volume()
	$ProgressBar.value = MusicController.volume


func _on_volume_down_button_pressed():
	MusicController.turn_down_volume()
	$ProgressBar.value = MusicController.volume
