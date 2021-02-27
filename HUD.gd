extends CanvasLayer

signal start_game #tells main node that the botton has pressed

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	
	#wait until MessageTimer has counted down
	yield($MessageTimer,"timeout")#shows gameover for 2sec and returns to first title screen
	
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	
	#Make a one-shot timer and wait for it to finish
	yield(get_tree().create_timer(1),"timeout")
	$StartButton.show()

func update_score(score): #called by main whenevr score changes
	$ScoreLabel.text = str(score)
	

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$Message.hide()
