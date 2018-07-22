extends Node

var iniciado

signal restart

func _hideButtons(): #Esconde botones menos Start
	$SadRestartButton.hide()
	$HappyRestartButton.hide()
	$BotonDeAndroid.hide()
	$BotonDeAndroid_col.hide()

func _hideCharacters(): #Esconde a los personajes
	$Cowboy.hide()
	$Cowboy.activo = 0
	$HappyCowboy.hide()
	$SadCowboy.hide()

func _hideLables(): #Esconde texto
	$Listo.hide()
	$Preparado.hide()
	$Apurado.hide()
	$Go.hide()
	$Perdi.hide()
	$Instrucciones.hide()
	$ParaDisparar.hide()
	$Conteo.hide()

func _hideAll(): #Esconde Todo
	_hideButtons()
	_hideCharacters()
	_hideLables()

func _ready(): #Al abrir el juego, sólo está la HUD inicial
	_hideAll()
	emit_signal("restart")
	$StartButton.show()
	$TimerJugando.stop()
	$TimerPerder.stop()
	$Instrucciones.show()

func _CowboyAct():
	$Cowboy.activo += 1

func _CowboyDeact():
	$Cowboy.activo = 0

func _inGame(): #Pone al jugador y esconde las HUD inicial y de reseteo
	$Cowboy.show()
	$Cowboy.mirada = 0
	_CowboyAct()
	$StartButton.hide()
	_hideButtons()
	$Preparado.show()
	$BotonDeAndroid.show()
	$BotonDeAndroid_col.show()
	$ParaDisparar.show()
	$Instrucciones.hide()

func _on_HappyRestartButton_pressed():
	_ready()

func _on_StartButton_pressed():
	_inGame()

func _on_SadRestartButton_pressed():
	_ready()

func _on_TimerJugando_timeout(): #Revisar conteo
	$Conteo.tiempo -= 0.01

func _on_TimerPerder_timeout():
	$Conteo.pierde -= 0.01

func _on_Cowboy_preparado(): #Cuando el jugador aprieta la tecla para prepararse
	$TimerJugando.start()
	$Preparado.hide()
	$Listo.show()
	$Cowboy.mirada += 2

func _on_Conteo_go():
	$TimerJugando.stop()
	$Listo.hide()
	$Go.show()
	$TimerPerder.start()

func _sad():
	$Apurado.show()
	$SadRestartButton.show()
	$SadCowboy.show()
	$Go.hide()
	$TimerJugando.stop()

func _happy():
	$HappyRestartButton.show()
	$HappyCowboy.show()
	$Go.hide()

func _perdi():
	$Perdi.show()
	$SadRestartButton.show()
	$SadCowboy.show()
	$Go.hide()

func _on_Conteo_lose():
	$Cowboy.hide()
	$Listo.hide()
	$TimerPerder.stop()
	_CowboyDeact()
	_perdi()

func _on_Cowboy_disparo():
	$Cowboy.hide()
	$Listo.hide()
	$TimerPerder.stop()
	_CowboyDeact()
	if $Conteo.tiempo <= 0:
		_happy()
	if $Conteo.tiempo > 0:
		_sad()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_ready()