extends Label

var tiempo = 1
var pierde = 1
var cuento = 1

signal go
signal lose

func _process(delta):
	text = str(tiempo, "\n", pierde)

	if tiempo <= 0 and cuento == 1:
		pierde = rand_range(0.009, 1)
		cuento = 0
		emit_signal("go")

	if pierde < 0:
		emit_signal("lose")

func _on_Main_restart():
	tiempo = rand_range(0.1, 5)
	pierde = 1
	cuento = 1