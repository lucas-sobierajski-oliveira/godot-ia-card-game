extends Node2D

@onready var deck = $"../Deck"
@onready var label = $Label

@onready var cards = [
	$Card1,
	$Card2,
	$Card3,
	$Card4,
	$Card5
]

var chips := 10
var current_bet := 0

var ia_cards := []

func _ready():
	update_card_sprites()

func get_cards_as_string():
	var ia_cards_as_string: String
	for card in ia_cards:
		ia_cards_as_string += card + ','
		
	return ia_cards_as_string

func receive_cards(deck_cards):
	ia_cards = deck_cards

func update_card_sprites():
	for index in len(cards):
		cards[index].texture = load('res://assets/cards/CardBack.png')
		
