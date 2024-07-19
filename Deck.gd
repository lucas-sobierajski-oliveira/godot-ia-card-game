extends Node

@onready var player = $"../Me"
@onready var ia = $"../IA"

var full_deck = [
	"C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C10", "CJ", "CQ", "CK", "CA",
	"S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "S10", "SJ", "SQ", "SK", "SA",
	"H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "H10", "HJ", "HQ", "HK", "HA",
	"D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D10", "DJ", "DQ", "DK", "DA"
]

var current_deck: Array
var player_cards := []
var ia_cards := []

func shuffle_deck():
	current_deck = full_deck.duplicate()
	current_deck.shuffle()

func _ready():
	shuffle_deck()
	
func new_card():
	return current_deck.pop_front()
	
func prepare_cards_to_deal():
	var cards := []
	for i in 5:
		cards.push_front(new_card())
	return cards

func deal_cards():
	player_cards = prepare_cards_to_deal()
	ia_cards = prepare_cards_to_deal()
	
	player.receive_cards(player_cards)
	ia.receive_cards(ia_cards)
