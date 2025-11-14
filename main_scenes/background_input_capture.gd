extends Node


signal bg_key_pressed(node, keys_pressed)


func _unhandled_key_input(event):
    if event.pressed:
        var key = event.get_physical_keycode()
        emit_signal("bg_key_pressed", self, { key: true })
    else:
        emit_signal("bg_key_pressed", self, {})

