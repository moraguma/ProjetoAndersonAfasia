extends Control


@onready var texto = $RichTextLabel
@onready var timer = $Timer


func mostrar(venceu):
	texto.show()
	if venceu:
		texto.text = "[center]VENCEU :)"
	else:
		texto.text = "[center]PERDEU :("
	timer.start(3)
	await timer.timeout
	texto.hide()
