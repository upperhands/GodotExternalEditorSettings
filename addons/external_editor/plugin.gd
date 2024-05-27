@tool
extends EditorPlugin

# A class member to hold the dock during the plugin life cycle.
var dock: Control
var toggle_external_editor_button: Button

func _enter_tree():
	# Load the dock scene and instantiate it.
	dock = preload("res://addons/external_editor/external_editor_settings.tscn").instantiate()
	toggle_external_editor_button = dock.get_node("./Button")
	toggle_external_editor_button.pressed.connect(toggle_external_editor_button_handler)
	# Add the loaded scene to the docks.
	# add_control_to_dock(DOCK_SLOT_LEFT_UL, dock)
	add_control_to_dock(DOCK_SLOT_LEFT_UR, dock)
	# Note that LEFT_UL means the left of the editor, upper-left dock.

func _exit_tree():
	# Clean-up of the plugin goes here.
	# Remove the dock.
	remove_control_from_docks(dock)
	# Erase the control from the memory.
	dock.free()

func toggle_external_editor_button_handler():
	var settings = EditorInterface.get_editor_settings()
	var using_external: bool = settings.get_setting("text_editor/external/use_external_editor")
	if using_external:
		settings.set("text_editor/external/use_external_editor", false)
		print("disabled external editor")
	else:
		settings.set("text_editor/external/use_external_editor", true)
		print("enabled external editor")
