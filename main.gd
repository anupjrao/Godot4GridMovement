extends Node2D

@onready var scene = preload("res://Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_enemy()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		handle_click()

func handle_click()  -> void:
	var mousePos: Vector2 = get_global_mouse_position()
	print($TileMap.local_to_map(mousePos))

func spawn_enemy() -> void:
	var x = randi_range(1,2)
	var y = randi_range(1,2)
	var enemy = scene.instantiate()
	enemy.global_position = $TileMap.map_to_local(Vector2i(x,y))
	add_child(enemy)
