extends Node2D

var spots = [[0, 0, 0, 0, 0, 0, 0, 0, 0], #each row is a 3 x 3 'field' comprised of 9 'spots'
			 [0, 0, 0, 0, 0, 0, 0, 0, 0], #X is 1, O is -1
			 [0, 0, 0, 0, 0, 0, 0, 0, 0],
			 [0, 0, 0, 0, 0, 0, 0, 0, 0],
			 [0, 0, 0, 0, 0, 0, 0, 0, 0],
			 [0, 0, 0, 0, 0, 0, 0, 0, 0],
			 [0, 0, 0, 0, 0, 0, 0, 0, 0],
			 [0, 0, 0, 0, 0, 0, 0, 0, 0],
			 [0, 0, 0, 0, 0, 0, 0, 0, 0]]

var fields = [0, 0, 0,
			 0, 0, 0,
			 0, 0, 0] #1 if X won a spot, -1 if O won a spot
		

#[0, 1, 2, 
# 3, 4, 5, 
# 6, 7, 8] easy visualization of board indecies
# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

#checks a normal 3x3 board. -1 if O wins, 1 if X, 0 if none
func check_win(board):
	for i in [-1, 1]:
		if (board[0] + board[1] + board[2] == i * 3 or
			board[3] + board[4] + board[5] == i * 3 or
			board[6] + board[7] + board[8] == i * 3 or
			board[0] + board[3] + board[6] == i * 3 or
			board[1] + board[4] + board[7] == i * 3 or
			board[2] + board[5] + board[8] == i * 3 or
			board[0] + board[4] + board[8] == i * 3 or
			board[2] + board[4] + board[6] == i * 3): return i
	return 0

#checks a UTTT board for a win.
func check_win_big(field):
	var tmpField = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	for i in range(len(tmpField)):
		tmpField[i] = check_win(field[i])
	return check_win(tmpField)

#checks if no moves can be made on a field
func check_full(board):
	for i in board:
		if i == 0: 
			return false
	return true

func evaluate_small(field):
	'''
	evaluate a single, small field

	position - the TTT board to evaluate

	RETURN VALUE - A float. Pos (+) favors X, neg (-) favors O
	'''
	
	var eval = 0
	var points = [0.2, 0.17, 0.2, 0.17, 0.22, 0.17, 0.2, 0.17, 0.2]

	for spot in range(len(field)):
		eval += field[spot] * points[spot]
	
	var a = 2
	if(field[0] + field[1] + field[2] == a or field[3] + field[4] + field[5] == a or field[6] + field[7] + field[8] == a):
		eval += 6
	
	if(field[0] + field[3] + field[6] == a or field[1] + field[4] + field[7] == a or field[2] + field[5] + field[8] == a):
		eval += 6
	
	if(field[0] + field[4] + field[8] == a or field[2] + field[4] + field[6] == a):
		eval += 7

	a = -1
	if((field[0] + field[1] == 2*a and field[2] == -a) or (field[1] + field[2] == 2*a and field[0] == -a) or (field[0] + field[2] == 2*a and field[1] == -a)
		or (field[3] + field[4] == 2*a and field[5] == -a) or (field[3] + field[5] == 2*a and field[4] == -a) or (field[5] + field[4] == 2*a and field[3] == -a)
		or (field[6] + field[7] == 2*a and field[8] == -a) or (field[6] + field[8] == 2*a and field[7] == -a) or (field[7] + field[8] == 2*a and field[6] == -a)
		or (field[0] + field[3] == 2*a and field[6] == -a) or (field[0] + field[6] == 2*a and field[3] == -a) or (field[3] + field[6] == 2*a and field[0] == -a)
		or (field[1] + field[4] == 2*a and field[7] == -a) or (field[1] + field[7] == 2*a and field[4] == -a) or (field[4] + field[7] == 2*a and field[1] == -a)
		or (field[2] + field[5] == 2*a and field[8] == -a) or (field[2] + field[8] == 2*a and field[5] == -a) or (field[5] + field[8] == 2*a and field[2] == -a)
		or (field[0] + field[4] == 2*a and field[8] == -a) or (field[0] + field[8] == 2*a and field[4] == -a) or (field[4] + field[8] == 2*a and field[0] == -a)
		or (field[2] + field[4] == 2*a and field[6] == -a) or (field[2] + field[6] == 2*a and field[4] == -a) or (field[4] + field[6] == 2*a and field[2] == -a)):
		eval+=9
	

	a = -2
	if(field[0] + field[1] + field[2] == a or field[3] + field[4] + field[5] == a or field[6] + field[7] + field[8] == a):
		eval -= 6
	
	if(field[0] + field[3] + field[6] == a or field[1] + field[4] + field[7] == a or field[2] + field[5] + field[8] == a):
		eval -= 6
	
	if(field[0] + field[4] + field[8] == a or field[2] + field[4] + field[6] == a):
		eval -= 7
	

	a = 1
	if((field[0] + field[1] == 2*a and field[2] == -a) or (field[1] + field[2] == 2*a and field[0] == -a) or (field[0] + field[2] == 2*a and field[1] == -a)
		or (field[3] + field[4] == 2*a and field[5] == -a) or (field[3] + field[5] == 2*a and field[4] == -a) or (field[5] + field[4] == 2*a and field[3] == -a)
		or (field[6] + field[7] == 2*a and field[8] == -a) or (field[6] + field[8] == 2*a and field[7] == -a) or (field[7] + field[8] == 2*a and field[6] == -a)
		or (field[0] + field[3] == 2*a and field[6] == -a) or (field[0] + field[6] == 2*a and field[3] == -a) or (field[3] + field[6] == 2*a and field[0] == -a)
		or (field[1] + field[4] == 2*a and field[7] == -a) or (field[1] + field[7] == 2*a and field[4] == -a) or (field[4] + field[7] == 2*a and field[1] == -a)
		or (field[2] + field[5] == 2*a and field[8] == -a) or (field[2] + field[8] == 2*a and field[5] == -a) or (field[5] + field[8] == 2*a and field[2] == -a)
		or (field[0] + field[4] == 2*a and field[8] == -a) or (field[0] + field[8] == 2*a and field[4] == -a) or (field[4] + field[8] == 2*a and field[0] == -a)
		or (field[2] + field[4] == 2*a and field[6] == -a) or (field[2] + field[6] == 2*a and field[4] == -a) or (field[4] + field[6] == 2*a and field[2] == -a)):
		eval-=9
	

	eval += check_win(field)*12

	return eval
	


func evaluate_big(position, fieldIndex):
	'''
	evaluate all fields in the UTTT game 

	position - all the fields

	fieldIndex - the board currently active/being played on

	RETURN VALUE - A float. Pos (+) favors X, neg (-) favors O
	'''
	var eval = 0
	var mainBd = []
	var evaluatorMul = [1.4, 1, 1.4, 1, 1.75, 1, 1.4, 1, 1.4]
	for eh in range(9):
		eval += evaluate_small(position[eh])*1.5*evaluatorMul[eh]
		if(eh == fieldIndex):
			eval += evaluate_small(position[eh])*evaluatorMul[eh]
		var tmpEv = check_win(position[eh])
		eval -= tmpEv*evaluatorMul[eh]
		mainBd.append(tmpEv)
	eval += check_win(mainBd)*5000
	eval += evaluate_small(mainBd)*150
	return eval


func mini_max(position, depth, fieldIndex, alpha, beta, maximizingX):

	#this should be changed by the time we return
	#if -1 is returned, the game should already be over
	var moveToPlay = [fieldIndex, -1]

	var curEval = evaluate_big(position, fieldIndex)

	if (depth <= 0 or check_win_big(position)): 
		return {"eval": curEval, "move": moveToPlay, "position": position, "ab": Vector2(alpha, beta)}

	#if no moves can be made at the target field, allow any field to move
	if (fieldIndex != -1 and check_win(position[fieldIndex]) != 0):
		fieldIndex = -1
	
	if (check_full(position[fieldIndex])):
		fieldIndex = -1

	if (maximizingX):
		var maxEval = -INF
		var maxEval_position = position
		#iterate through all spots on the field
		for spot in range(9):
			var eval = -INF
			var eval_position = position
			#if we can play anywhere, we must check every field
			if fieldIndex == -1:
				for field in range(9):
					#skip fields that are won
					if check_win(position[field]) == 0:
						#skip spots that are filled
						if position[field][spot] == 0:
							position[field][spot] = 1 #modifiy the board for the next eval step
							eval_position = position
							eval = mini_max(position, depth - 1, spot, alpha, beta, false)["eval"]
							position[field][spot] = 0 #reverse our modification
						if eval > maxEval:
							maxEval = eval
							moveToPlay = [field, spot]
							maxEval_position = eval_position
						alpha = max(alpha, eval)
				if (beta <= alpha):
					break


			else: #we have a field to play in
				if position[fieldIndex][spot] == 0:
					position[fieldIndex][spot] = 1
					eval_position = position
					eval = mini_max(position, depth - 1, spot, alpha, beta, false)["eval"]
					position[fieldIndex][spot] = 0
				if (eval > maxEval):
					maxEval = eval
					moveToPlay = [fieldIndex, spot]
					maxEval_position = eval_position
				alpha = max(alpha, eval)
				if (beta <= alpha):
					break

		return {"eval": maxEval, "move": moveToPlay, "position": maxEval_position, "ab": Vector2(alpha, beta)}
	else:
		var minEval = INF
		var minEval_position = position
		#iterate through all spots on the field
		for spot in range(9):
			var eval = INF
			var eval_position = position
			#if we can play anywhere, we must check every field
			if fieldIndex == -1:
				for field in range(9):
					#skip fields that are won
					if check_win(position[spot]) == 0:
						if position[spot][field] == 0:
							position[spot][field] = -1 #modifiy the board for the next eval step
							eval_position = position
							eval = mini_max(position, depth - 1, spot, alpha, beta, true)["eval"]
							position[spot][field] = 0 #reverse our modification
						if eval < minEval:
							minEval = eval
							moveToPlay = [field, spot]
							minEval_position = eval_position
						beta = min(beta, eval)
				if (beta <= alpha):
					break


			else: #we have a field to play in
				if position[fieldIndex][spot] == 0:
					position[fieldIndex][spot] = -1
					eval_position = position
					eval = mini_max(position, depth - 1, spot, alpha, beta, true)["eval"]
					position[fieldIndex][spot] = 0
				if (eval < minEval):
					minEval = eval
					moveToPlay = [fieldIndex, spot]
					minEval_position = eval_position
				beta = min(beta, eval)
				if (beta <= alpha):
					break


		return {"eval": minEval, "move": moveToPlay, "position": minEval_position, "ab": Vector2(alpha, beta)}

func mini_mini_max(position, depth, maximizingX):
	var tmpMove = -1
	if depth == 0 or check_full(position) or check_win(position) != 0:
		return {"eval": evaluate_small(position), "move":tmpMove}
	
	if maximizingX:
		var maxEval = -INF
		for spot in range(len(position)):
			if (position[spot] == 0):
				position[spot] = 1
				var eval = mini_mini_max(position, depth - 1, false)
				position[spot] = 0
				if (eval["eval"] > maxEval):
					maxEval = eval["eval"]
					tmpMove = spot
		return {"eval":maxEval, "move":tmpMove}
	else:
		var minEval = INF
		for spot in range(len(position)):
			if (position[spot] == 0):
				position[spot] = -1
				var eval = mini_mini_max(position, depth - 1, true)
				position[spot] = 0
				if (eval["eval"] < minEval):
					minEval = eval["eval"]
					tmpMove = spot
		return {"eval": minEval, "move": tmpMove}


var board = [[0, 0, 0, 0, 0, 0, 0, 0, 0], #0
		 [0, 0, 0, 0, 0, 0, 0, 0, 0], #1
		 [0, 0, 0, 0, 0, 0, 0, 0, 0], #2
		 [0, 0, 0, 0, 0, 0, 0, 0, 0], #3
		 [0, 0, 0, 0, 0, 0, 0, 0, 0], #4
		 [0, 0, 0, 0, 0, 0, 0, 0, 0], #5 
		 [0, 0, 0, 0, 0, 0, 0, 0, 0], #6
		 [0, 0, 0, 0, 0, 0, 0, 0, 0], #7
		 [0, 0, 0, 0, 0, 0, 0, 0, 0]] #8

var small_test = [-1, -1, -1,
				  -1, 1, 0,
				  1, 0, 1]

@onready var tile_map = $TileMap

func edit_board(x, y, val):
	board[x][y] = val
	x = 0
	y = 0
	for field in range(len(board)):
		var tempX = 0
		var tempY = 0
		for spot in range(len(board[field])):
			val = board[field][spot]
			if val == -1:
				val = 2
			tile_map.set_cell(0, Vector2i(tempX + x, tempY + y), 3, Vector2i(0, val))
			tempX += 1
			if tempX % 3 == 0:
				tempX = 0
				tempY += 1
		x += 4
		if x % 12 == 0:
			x = 0
			y += 4
		

var xTurn = true
var move = 1
var fieldIndex = -1

func run_ai():
	var result = mini_max(board, 5, fieldIndex, -INF, INF, xTurn)

	if xTurn:
		print("X turn")
		#board[result["move"][0]][result["move"][1]] = 1
		edit_board(result["move"][0], result["move"][1], 1)
	else:
		print("O turn")
		#board[result["move"][0]][result["move"][1]] = -1
		edit_board(result["move"][0], result["move"][1], -1)
	print("Move " + str(move))
	print(result)
	xTurn = not xTurn
	fieldIndex = result["move"][1]
	move += 1
	return result

func run_ai_vs_random():
	if xTurn:
		var result = mini_max(board, 5, fieldIndex, -INF, INF, xTurn)
		print("X turn")
		#board[result["move"][0]][result["move"][1]] = 1
		edit_board(result["move"][0], result["move"][1], 1)
		fieldIndex = result["move"][1]
	else:
		print("O turn")
		var move_to_make = randi_range(0, 8)
		while check_full(board[fieldIndex]) or check_win(board[fieldIndex]) != 0:
			fieldIndex = randi_range(0, 8)
		while board[fieldIndex][move_to_make] != 0:
			move_to_make = randi_range(0, 8)
		edit_board(fieldIndex, move_to_make, -1)
		fieldIndex = move_to_make
	xTurn = not xTurn

func _ready():
	edit_board(0, 0, 0)
	#run_ai()
	#print(evaluate_big(board, 4))

func _process(delta):
	#run_ai_vs_random()
	#await get_tree().create_timer(2).timeout
	pass


func _on_button_pressed():
	run_ai_vs_random()
	pass
