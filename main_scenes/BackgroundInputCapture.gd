extends Node


signal bg_key_pressed(node, keys_pressed: Dictionary)

var pressed_keys = {}
var last_emitted := {}

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key = event.get_physical_keycode()

		if event.pressed and not event.echo:
			pressed_keys[key] = true
		elif not event.pressed:
			_emit_current()
			pressed_keys.clear()


func _emit_current():
	var copy := pressed_keys.duplicate()
	last_emitted = copy
	emit_signal("bg_key_pressed", null, copy)
