extends Node2D

@onready var player = $Me
@onready var ia = $IA
@onready var deck = $Deck
@onready var deal_cards_button = $DealCardsButton
@onready var game_text = $GameText

var api_key = 'sk-proj-3ALWUwPuGH9MVIalvJuKT3BlbkFJt1SIp8PRhGRbHTjhfDhU'
var url = 'https://api.openai.com/v1/chat/completions'
var temperature := 0.5
var max_tokens := 1024
var headers = ['Content-type: application/json', 'Authorization: Bearer ' + api_key]
var model := 'gpt-3.5-turbo'

var http_protocol: HTTPRequest
var messages := []

var is_pLayer_turn := false

func _ready():
	http_protocol = HTTPRequest.new()
	add_child(http_protocol)
	http_protocol.request_completed.connect(_on_resquest_completed)
	
	#api_request('como me tornar um bom programador')
	
func next_turn():
	is_pLayer_turn = !is_pLayer_turn
	if is_pLayer_turn:
		print('turno do Player')
		player.action_buttons_container.visible = true
	else:
		player.action_buttons_container.visible = false
		var response = ia_action()
		
	
func ia_action() -> String:
	var ia_message: String = '1 - Você está jogando poker de 5 cartas\n'
	ia_message += '2 - voce tem na mão atual as cartas: ' + ia.get_cards_as_string()  + '\n'
	ia_message += '3 - "C" significa paus, "S" significa espadas, "H" copas, "D" significa ouro \n'
	ia_message += '4 - você tem de dinheiro a seguinte quantia: ' + str(ia.chips) + '\n'
	ia_message += '5 - o seu oponente está apostando no momento: ' + str(player.current_bet) + '\n'
	ia_message += '6 - a carta é lida primeiro pelo nipe e depois o numero, como por exemplo: 10D é o mesmo que 10 de ouro\n'
	ia_message += '7 - qual ação voce tomaria em um jogo de poker no seu turno, responda apenas com: BET dinheiro ou FOLD'

	api_request(ia_message)
	
	return ia_message

func _on_resquest_completed(result, code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	
	print(response.choices[0].message.content)
	
	# usar retorno para definir ação da IA
	
	
func api_request(message):
	messages.append({'role': 'user', 'content': message})
	
	var body = JSON.stringify({
		"messages": messages,
		"temperature": temperature,
		"max_tokens": max_tokens,
		"model": model
	})
	
	var error = http_protocol.request(url, headers, HTTPClient.METHOD_POST, body)
	
	if error != OK:
		push_error('something happens')


func deal_cards():
	deck.shuffle_deck()
	deck.deal_cards()
	
	ia_action()
