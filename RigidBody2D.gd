extends RigidBody2D

export var min_speed=150
export var max_speed=250

func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names() #get list of animation names ,returns array of ["walk","swim","fly"]
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()] #randi() selects random index form array and randi()%3 selects random integer between 0 to 2

func _on_VisibilityNotifier2D_screen_exited(): #from node
	queue_free() #dleted mobs after they leave the screen
	
