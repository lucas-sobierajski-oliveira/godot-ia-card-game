extends Node2D

@onready var stats_text = $Label
@onready var action_buttons_container: HBoxContainer = $ActionButtons

var chips := 10
var current_bet := 0

@onready var cards = [
	$Card1,
	$Card2,
	$Card3,
	$Card4,
	$Card5
]

var player_cards := []

func increase_bet():
	if chips > 0:
		chips -= 1
		current_bet += 1
		
		update_ui()

func decrease_bet():
	if current_bet > 0:
		chips += 1
		current_bet -= 1
		
		update_ui()
	
func fold():
	pass
	
func complete_bet():
	pass
	
func set_bet():
	pass
	
func get_cards_as_string():
	for card in player_cards:
		cards += card + ' '
	return cards
	
func update_ui():
	stats_text.text = 'bet: ' + str(current_bet) + '\nchips: ' + str(chips)
	
func receive_cards(deck_cards):
	player_cards = deck_cards
	update_card_sprites(player_cards)
	update_ui()

func update_card_sprites(_player_cards):
	for index in len(cards):
		cards[index].texture = load('res://assets/cards/' + player_cards[index] + '.png')
		
