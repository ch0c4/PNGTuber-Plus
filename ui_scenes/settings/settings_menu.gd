extends Node2D

var awaitingCostumeInput = -1

var hasMouse = false

func setvalues():
	
	$Background/ColorPickerButton.color = Global.backgroundColor
	if Global.backgroundColor == Color(0.0,0.0,0.0,0.0):
		$Background/ColorPickerButton.color = Color(1.0,1.0,1.0,1.0)
	
	
	$MaxFPS/fpslabel.text = str(Engine.max_fps)
	$MaxFPS/fpsDrag.value = Engine.max_fps
	if Engine.max_fps == 0:
		$MaxFPS/fpslabel.text = "Unlimited"
		$MaxFPS/fpsDrag.value = 241
	
	$BounceForce/bounce.text = str(Saving.settings["bounce"])
	$BounceForce/bounceForce.value = Saving.settings["bounce"]
	$BounceGravity/bounce.text = str(Saving.settings["gravity"])
	$BounceGravity/bounceGravity.value = Saving.settings["gravity"]
	
	_on_check_box_toggled(Global.filtering)
	
	$BlinkSpeed/blinkSpeed.value = int(1.0/Global.blinkSpeed)
	$BlinkSpeed/Label.text = "blink speed: " + str(int(1.0/Global.blinkSpeed))
	
	$BlinkChance/blinkChance.value = Global.blinkChance
	$BlinkChance/Label.text = "blink chance: 1 in " + str(Global.blinkChance) 
	
	$bounceOnCostume/costumeCheck.button_pressed = Global.main.bounceOnCostumeChange
	
	var costumeLabels = [
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButton1/Label,
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButton2/Label,
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButton3/Label,
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButton4/Label,
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButton5/Label,
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButton6/Label,
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButton7/Label,
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButton8/Label,
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButton9/Label,
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButton10/Label
	]
	
	var tag = 1
	var costumeKeys: Array = Global.main.costumeKeys
	for label in costumeLabels:
		label.text = "costume " + str(tag) + " key: \"" + costumeKeys[tag-1] + "\""
		tag += 1
	
	var twitchCostumeKeys: Dictionary = Global.main.twitchCostumeKeys
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/Label.text = "costume Follow: Costume " + twitchCostumeKeys["follow"]["costumeNumber"] + " for " + str(twitchCostumeKeys["follow"]["time"]) + "s"
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/HBoxContainer/LineEdit.text = twitchCostumeKeys["follow"]["costumeNumber"]
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/HBoxContainer/LineEdit2.text = str(twitchCostumeKeys["follow"]["time"])
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/Label.text = "costume Raid: Costume " + twitchCostumeKeys["raid"]["costumeNumber"] + " for " + str(twitchCostumeKeys["raid"]["time"]) + "s"
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/HBoxContainer/LineEdit.text = twitchCostumeKeys["raid"]["costumeNumber"]
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/HBoxContainer/LineEdit2.text = str(twitchCostumeKeys["raid"]["time"])
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/Label.text = "costume Sub: Costume " + twitchCostumeKeys["sub"]["costumeNumber"] + " for " + str(twitchCostumeKeys["sub"]["time"]) + "s"
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/HBoxContainer/LineEdit.text = twitchCostumeKeys["sub"]["costumeNumber"]
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/HBoxContainer/LineEdit2.text = str(twitchCostumeKeys["sub"]["time"])
	
	$TwitchInput/rect/LineEdit.text = Global.channel_name


func _on_color_picker_button_color_changed(color):
	get_viewport().transparent_bg = false
	RenderingServer.set_default_clear_color(color)
	Global.backgroundColor = color
	Saving.settings["backgroundColor"] = var_to_str(color)
	
	Global.pushUpdate("Background color set to CUSTOM COLOR.")


func _on_button_pressed():
	get_viewport().transparent_bg = true
	Global.backgroundColor = Color(0.0,0.0,0.0,0.0)
	Saving.settings["backgroundColor"] = var_to_str(Color(0.0,0.0,0.0,0.0))
	
	Global.pushUpdate("Background color set to TRANSPARENT.")


func _on_color_picker_button_picker_created():
	get_viewport().transparent_bg = false
	RenderingServer.set_default_clear_color($Background/ColorPickerButton.color)
	

func _on_fps_drag_value_changed(value):
	if $MaxFPS/fpsDrag.value == 241:
		$MaxFPS/fpslabel.text = "Unlimited"
		return
	$MaxFPS/fpslabel.text = str(value)


func _on_confirm_pressed():
	if $MaxFPS/fpsDrag.value == 241:
		Engine.max_fps = 0
		Saving.settings["maxFPS"] = 0
		Global.pushUpdate("Max fps set to unlimited.")
		return
	Engine.max_fps = $MaxFPS/fpsDrag.value
	Saving.settings["maxFPS"] = $MaxFPS/fpsDrag.value
	
	Global.pushUpdate("Max fps set to " + str(Engine.max_fps) + ".")


func _on_green_button_pressed():
	get_viewport().transparent_bg = false
	Global.backgroundColor = Color(0.0,1.0,0.0,1.0)
	Saving.settings["backgroundColor"] = var_to_str(Color(0.0,1.0,0.0,1.0))
	RenderingServer.set_default_clear_color(Color(0.0,1.0,0.0,1.0))
	
	Global.pushUpdate("Background color set to GREEN.")


func _on_blue_button_pressed():
	get_viewport().transparent_bg = false
	Global.backgroundColor = Color(0.0,0.0,1.0,1.0)
	Saving.settings["backgroundColor"] = var_to_str(Color(0.0,0.0,1.0,1.0))
	RenderingServer.set_default_clear_color(Color(0.0,0.0,1.0,1.0))
	
	Global.pushUpdate("Background color set to BLUE.")


func _on_magenta_button_pressed():
	get_viewport().transparent_bg = false
	Global.backgroundColor = Color(1.0,0.0,1.0,1.0)
	Saving.settings["backgroundColor"] = var_to_str(Color(1.0,0.0,1.0,1.0))
	RenderingServer.set_default_clear_color(Color(1.0,0.0,1.0,1.0))
	
	Global.pushUpdate("Background color set to MAGENTA.")


func _on_check_box_toggled(button_pressed):
	var new = 0
	if button_pressed:
		new = 2
	var nodes = get_tree().get_nodes_in_group("saved")
	for sprite in nodes:
		sprite.sprite.texture_filter = new
	Global.filtering = button_pressed
	Saving.settings["filtering"] = button_pressed
	$AntiAliasing/CheckBox.button_pressed = button_pressed
	
	Global.pushUpdate("Texture filtering set to: " + str(button_pressed))


func _on_bounce_force_value_changed(value):
	$BounceForce/bounce.text = str(value)
	Global.main.bounceSlider = value
	Saving.settings["bounce"] = value
	
	Global.pushUpdate("Bounce force value changed.")


func _on_bounce_gravity_value_changed(value):
	$BounceGravity/bounce.text = str(value)
	Global.main.bounceGravity = value
	Saving.settings["gravity"] = value
	
	Global.pushUpdate("Bounce gravity value changed.")


func costumeButtonsPressed(label, id):
	label.text = "AWAITING INPUT"

	awaitingCostumeInput = id - 1
	
	await Global.main.pressedKey
	label.text = "costume " + str(id) + " key: \"" + Global.main.costumeKeys[id - 1] + "\""
	await Global.main.emptiedCapture
	awaitingCostumeInput = -1


func costumeCustomPressed(label: Label, container: HBoxContainer, lineEdit: LineEdit) -> void:
	label.hide()
	lineEdit.text = ""
	container.show()
	lineEdit.grab_focus()

func _on_costume_button_1_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton1/Label
	costumeButtonsPressed(label, 1)


func _on_costume_button_2_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton2/Label
	costumeButtonsPressed(label,2)


func _on_costume_button_3_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton3/Label
	costumeButtonsPressed(label,3)


func _on_costume_button_4_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton4/Label
	costumeButtonsPressed(label,4)


func _on_costume_button_5_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton5/Label
	costumeButtonsPressed(label,5)


func _on_costume_button_6_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton6/Label
	costumeButtonsPressed(label,6)


func _on_costume_button_7_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton7/Label
	costumeButtonsPressed(label,7)


func _on_costume_button_8_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton8/Label
	costumeButtonsPressed(label,8)


func _on_costume_button_9_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton9/Label
	costumeButtonsPressed(label,9)


func _on_costume_button_10_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton10/Label
	costumeButtonsPressed(label, 10)


func _on_costume_button_follow_pressed() -> void:
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/Label
	var lineEdit = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/HBoxContainer/LineEdit
	var container = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/HBoxContainer
	costumeCustomPressed(label, container, lineEdit)


func _on_costume_button_raid_pressed() -> void:
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/Label
	var lineEdit = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/HBoxContainer/LineEdit
	var container = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/HBoxContainer
	costumeCustomPressed(label, container, lineEdit)


func _on_costume_button_sub_pressed() -> void:
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/Label
	var lineEdit = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/HBoxContainer/LineEdit
	var container = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/HBoxContainer
	costumeCustomPressed(label, container, lineEdit)


func _on_blink_speed_value_changed(value):
	if value == 0:
		Global.blinkSpeed = 0.0
		Saving.settings["blinkSpeed"] = 0.0
		$BlinkSpeed/Label.text = "blink speed: 0"
		return
	Global.blinkSpeed = 1.0/float(value)
	Saving.settings["blinkSpeed"] = 1.0/float(value)
	$BlinkSpeed/Label.text = "blink speed: " + str(value)


func _on_blink_chance_value_changed(value):
	Global.blinkChance = value
	Saving.settings["blinkChance"] = value
	$BlinkChance/Label.text = "blink chance: 1 in " + str(value)


func _on_costume_check_toggled(button_pressed):
	Global.main.bounceOnCostumeChange = button_pressed
	Saving.settings["bounceOnCostumeChange"] = button_pressed


func _process(delta):
	var g = to_local(get_global_mouse_position())
	if g.x < 0 or g.y < 0 or g.x > $NinePatchRect.size.x or g.y > $NinePatchRect.size.y:
		hasMouse = false
	else:
		hasMouse = true


func deleteKey(label, id):
	Global.main.costumeKeys[id-1] = "null"
	label.text = "costume " + str(id) + " key: \"" + Global.main.costumeKeys[id-1] + "\""
	Global.pushUpdate("Deleted costume hotkey " + str(id) + ".")


func _on_delete_1_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton1/Label
	deleteKey(label,1)


func _on_delete_2_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton2/Label
	deleteKey(label,2)


func _on_delete_3_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton3/Label
	deleteKey(label,3)


func _on_delete_4_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton4/Label
	deleteKey(label,4)


func _on_delete_5_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton5/Label
	deleteKey(label,5)


func _on_delete_6_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton6/Label
	deleteKey(label,6)


func _on_delete_7_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton7/Label
	deleteKey(label,7)


func _on_delete_8_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton8/Label
	deleteKey(label,8)


func _on_delete_9_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton9/Label
	deleteKey(label,9)


func _on_delete_10_pressed():
	var label = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButton10/Label
	deleteKey(label,10)


func _on_line_edit_text_submitted(new_text: String) -> void:
	$TwitchInput/rect/LineEdit.text = new_text
	Global.channel_name = new_text


func _on_follow_line_edit_text_submitted(new_text: String) -> void:
	print("follow costume submit ", new_text)
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/Label.show()
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/HBoxContainer.hide()
	if not check_update_costume_number(int(new_text)):
		Global.pushUpdate("Erreur le costume est invalide -> " + new_text)
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/HBoxContainer/LineEdit.text = Global.main.twitchCostumeKeys["follow"]["costumeNumber"]
		return
	
	Global.main.twitchCostumeKeys["follow"]["costumeNumber"] = new_text
	Saving.settings.twitchCostumeKeys["follow"]["costumeNumber"] = new_text
	Global.pushUpdate("Update follow costume to " + new_text)
	var twitchCostumeKeys = Global.main.twitchCostumeKeys
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/Label.text = "costume Follow: Costume " + twitchCostumeKeys["follow"]["costumeNumber"] + " for " + str(twitchCostumeKeys["follow"]["time"]) + "s"
	


func _on_follow_line_edit_2_text_submitted(new_text: String) -> void:
	print("follow time submit ", new_text)
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/Label.show()
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/HBoxContainer.hide()
	
	var costumeNumberUpdated = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/HBoxContainer/LineEdit.text
	if check_update_costume_number(int(costumeNumberUpdated)):
		Global.main.twitchCostumeKeys["follow"]["costumeNumber"] = costumeNumberUpdated
		Saving.settings.twitchCostumeKeys["follow"]["costumeNumber"] = costumeNumberUpdated
		Global.pushUpdate("Update follow costume to " + costumeNumberUpdated)
	
	Global.main.twitchCostumeKeys["follow"]["time"] = int(new_text)
	Saving.settings.twitchCostumeKeys["follow"]["time"] = int(new_text)
	Global.pushUpdate("Update follow time to " + new_text + "s")
	var twitchCostumeKeys = Global.main.twitchCostumeKeys
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonFollow/Label.text = "costume Follow: Costume " + twitchCostumeKeys["follow"]["costumeNumber"] + " for " + str(twitchCostumeKeys["follow"]["time"]) + "s"



func _on_line_raid_edit_text_submitted(new_text: String) -> void:
	print("raid costume submit ", new_text)
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/Label.show()
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/HBoxContainer.hide()
	if not check_update_costume_number(int(new_text)):
		Global.pushUpdate("Erreur le costume est invalide -> " + new_text)
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/HBoxContainer/LineEdit.text = Global.main.twitchCostumeKeys["raid"]["costumeNumber"]
		return
	
	Global.main.twitchCostumeKeys["raid"]["costumeNumber"] = new_text
	Saving.settings.twitchCostumeKeys["raid"]["costumeNumber"] = new_text
	Global.pushUpdate("Update raid costume to " + new_text)
	var twitchCostumeKeys = Global.main.twitchCostumeKeys
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/Label.text = "costume Raid: Costume " + twitchCostumeKeys["raid"]["costumeNumber"] + " for " + str(twitchCostumeKeys["raid"]["time"]) + "s"


func _on_line_raid_edit_2_text_submitted(new_text: String) -> void:
	print("raid time submit ", new_text)
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/Label.show()
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/HBoxContainer.hide()
	
	var costumeNumberUpdated = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/HBoxContainer/LineEdit.text
	if check_update_costume_number(int(costumeNumberUpdated)):
		Global.main.twitchCostumeKeys["raid"]["costumeNumber"] = costumeNumberUpdated
		Saving.settings.twitchCostumeKeys["raid"]["costumeNumber"] = costumeNumberUpdated
		Global.pushUpdate("Update raid costume to " + costumeNumberUpdated)
	
	Global.main.twitchCostumeKeys["raid"]["time"] = int(new_text)
	Saving.settings.twitchCostumeKeys["raid"]["time"] = int(new_text)
	Global.pushUpdate("Update raid time to " + new_text + "s")
	var twitchCostumeKeys = Global.main.twitchCostumeKeys
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonRaid/Label.text = "costume Raid: Costume " + twitchCostumeKeys["raid"]["costumeNumber"] + " for " + str(twitchCostumeKeys["raid"]["time"]) + "s"


func _on_sub_line_edit_text_submitted(new_text: String) -> void:
	print("sub costume submit ", new_text)
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/Label.show()
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/HBoxContainer.hide()
	if not check_update_costume_number(int(new_text)):
		Global.pushUpdate("Erreur le costume est invalide -> " + new_text)
		$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/HBoxContainer/LineEdit.text = Global.main.twitchCostumeKeys["sub"]["costumeNumber"]
		return
	
	Global.main.twitchCostumeKeys["sub"]["costumeNumber"] = new_text
	Saving.settings.twitchCostumeKeys["sub"]["costumeNumber"] = new_text
	Global.pushUpdate("Update sub costume to " + new_text)
	var twitchCostumeKeys = Global.main.twitchCostumeKeys
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/Label.text = "costume Sub: Costume " + twitchCostumeKeys["sub"]["costumeNumber"] + " for " + str(twitchCostumeKeys["sub"]["time"]) + "s"


func _on_line_sub_edit_2_text_submitted(new_text: String) -> void:
	print("sub time submit ", new_text)
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/Label.show()
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/HBoxContainer.hide()
	
	var costumeNumberUpdated = $CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/HBoxContainer/LineEdit.text
	if check_update_costume_number(int(costumeNumberUpdated)):
		Global.main.twitchCostumeKeys["sub"]["costumeNumber"] = costumeNumberUpdated
		Saving.settings.twitchCostumeKeys["sub"]["costumeNumber"] = costumeNumberUpdated
		Global.pushUpdate("Update sub costume to " + costumeNumberUpdated)
	
	Global.main.twitchCostumeKeys["sub"]["time"] = int(new_text)
	Saving.settings.twitchCostumeKeys["sub"]["time"] = int(new_text)
	Global.pushUpdate("Update sub time to " + new_text + "s")
	var twitchCostumeKeys = Global.main.twitchCostumeKeys
	$CostumeInputs/ScrollContainer/VBoxContainer/costumeButtonSub/Label.text = "costume Sub: Costume " + twitchCostumeKeys["sub"]["costumeNumber"] + " for " + str(twitchCostumeKeys["sub"]["time"]) + "s"


func check_update_costume_number(value: int) -> bool:
	if value < 1 or value > 10:
		return false
	return true
