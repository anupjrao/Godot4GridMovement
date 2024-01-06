extends Node2D

@onready var tileMap: TileMap = $"../TileMap"
@onready var rayCast: RayCast2D = $RayCast2D

var isMoving = false
# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = tileMap.map_to_local(Vector2i(0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_pressed("up")):
		move(Vector2i.UP)
	if(Input.is_action_pressed("down")):
		move(Vector2i.DOWN)
	if(Input.is_action_pressed("left")):
		move(Vector2i.LEFT)
	if(Input.is_action_pressed("right")):
		move(Vector2i.RIGHT)

func move(dir: Vector2i) -> void:
	if isMoving:
		return
	var currentTile: Vector2i = tileMap.local_to_map(global_position)
	var targetTile: Vector2i = currentTile + dir;
	var targetCell: TileData = tileMap.get_cell_tile_data(0,targetTile)
	if targetCell != null && targetCell.get_custom_data("walkable") == false:
		return
	rayCast.target_position = dir * 16
	rayCast.force_raycast_update()
	if rayCast.is_colliding():
		var collidingObject: Node = rayCast.get_collider()
		return
	isMoving = true
	var tween = create_tween()
	tween.tween_property(self,"global_position",tileMap.map_to_local(targetTile),0.2).set_trans(Tween.TRANS_SINE)
	await tween.finished
	isMoving = false
