#!/usr/bin/env ruby

require_relative '../lib/minesweeper/game'
require_relative '../lib/minesweeper/board'
require_relative '../lib/minesweeper/square'
require_relative 'simple_printer'
require_relative 'pretty_printer'

width, height, mines = 5, 5, 5
game = Minesweeper::Game.new(width, height, mines)

printer = (rand > 0.5) ? SimplePrinter.new : PrettyPrinter.new

puts "O jogo começou. Seu board é de #{width} x #{height}:"
printer.print(game.board_state)
puts ""

sleep 1

turn = 1

while game.still_playing?
  x, y = rand(1..width), rand(1..height)

  puts "Jogada #{turn}: linha #{x} e coluna #{y}"
  valid_move = game.play(x: x, y: y)
  valid_flag = game.flag(x: x, y: y)

  if valid_move || valid_flag
    printer.print(game.board_state)
  else
    puts "Posição já desvendada."
  end

  turn += 1
  puts ""
  sleep 1
end

puts "Fim do jogo!"
puts ""

if game.victory?
  puts "Você venceu!"
else
  puts "Você perdeu! As minas eram:"
  printer.print(game.board_state(show_mines: true))
end
