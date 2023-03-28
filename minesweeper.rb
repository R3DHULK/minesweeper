# Define Minesweeper game board
board_size = 9
num_mines = 10
board = Array.new(board_size) { Array.new(board_size, 0) }

# Place mines randomly on the board
num_mines.times do
  x, y = rand(board_size), rand(board_size)
  board[x][y] = "X"
end

# Calculate the number of mines adjacent to each cell
board.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    next if cell == "X"
    num_adjacent_mines = 0
    (i-1..i+1).each do |x|
      (j-1..j+1).each do |y|
        if x >= 0 && x < board_size && y >= 0 && y < board_size && board[x][y] == "X"
          num_adjacent_mines += 1
        end
      end
    end
    board[i][j] = num_adjacent_mines if num_adjacent_mines > 0
  end
end

# Define game loop
game_over = false
until game_over
  # Print game board
  puts "Minesweeper Board:"
  board.each do |row|
    puts row.map { |cell| cell == 0 ? "_" : cell }.join(" ")
  end

  # Prompt user to select a cell
  print "Select a cell (row, column): "
  input = gets.chomp.split(",").map(&:to_i)
  x, y = input[0], input[1]

  # Check if cell contains a mine
  if board[x][y] == "X"
    puts "BOOM! Game over."
    game_over = true
  else
    # Reveal the selected cell and adjacent cells
    board[x][y] = " "
    (x-1..x+1).each do |i|
      (y-1..y+1).each do |j|
        if i >= 0 && i < board_size && j >= 0 && j < board_size && board[i][j] != "X" && board[i][j] != " "
          board[i][j] = " "
        end
      end
    end

    # Check if all non-mine cells have been revealed
    if board.flatten.count(" ") == board_size * board_size - num_mines
      puts "Congratulations! You won the game!"
      game_over = true
    end
  end
end
