extends Control

func _process(delta):
	print($TextureRect.texture.fill_from)
	$TextureRect.texture.set_fill_from(Vector2(0,delta % 10))
	$TextureRect.texture.set_fill_to(Vector2(1,0))
