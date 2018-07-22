extends KinematicBody2D

export (int) var coolness
var mirada = 0
var activo
signal disparo
signal preparado

func _process(delta):
	if mirada > 1:
		$AnimatedSprite.animation = "looking"
	else:
		$AnimatedSprite.animation = "idle"
	if activo > 0:
		if Input.is_action_just_pressed("ui_accept"):
			emit_signal("preparado")
		elif Input.is_action_just_released("ui_accept"):
			emit_signal("disparo")

func _on_TextureButton_button_down():
	if activo > 0:
		emit_signal("preparado")

func _on_TextureButton_button_up():
	if activo > 0:
		emit_signal("disparo")