extends Node

export (PackedScene) var Mob #PackedScene allow to use Mob scene as instance
var score

func _ready():
	randomize()



func _on_Player_hit():
	pass # Replace with function body.


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs","queue_free")
	$Music.stop()
	$DeathSound.play()
	
func new_game():
	score=0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()

func _on_MobTimer_timeout():
	#Choose a random location oon path2d
	$MobPath/MobSpawnLocation.offset=randi()
	#Create a Mob instatnce and add it to the scene
	var mob = Mob.instance()
	add_child(mob)
	
	#Set the mob's direction perpendicular to path direction
	var direction=$MobPath/MobSpawnLocation.rotation + PI/2
	
	#Set the mob's position to random location
	mob.position=$MobPath/MobSpawnLocation.position
	
	#Add some randomness to direction
	direction+=rand_range(-PI/4,PI/4)
	mob.rotation=direction
	
	#Set the velocity
	mob.linear_velocity=Vector2(rand_range(mob.min_speed,mob.max_speed),0)
	mob.linear_velocity=mob.linear_velocity.rotated(direction)
	


func _on_ScoreTimer_timeout():
	score+=1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

