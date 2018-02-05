## Compilation
After cloning the project, `cd` to the folder and run:

```
bundle install
```

Minesweeper is now installed on your system.

## Starting the game
Run the game by typing `ruby examples/game_example.rb`.


By default the project has this configuration:

width:  3
height: 3
mines:  3

### Minesweeper::Game

Your client will interact with the game through this class. First, you need to create the game following the instructions:

```ruby
game = Minesweeper::Game.new(3, 3, 3)
```

After game creates, you can manipulate the actions. All the coordinates are
using the perspective from the user. For example, the first square from the board use
the coordinate `1x1`. You can use the following commands:

* Play: give the square position that you want to reveal.

```ruby
game.play(x: 1, y: 1)
```

* Flag: give the square position that you want to flag/unflag a possible square with a mine. You can't flag a square revealed.

```ruby
game.flag(x: 1, y: 1)
```

* Board state: get the board state with revealed and unrevealed squares, mines
  that you exploded and flagged squares.

```ruby
game.board_state
```

When the game finishes, you can see all the mines positions using the following
command:

```ruby
game.board_state(show_mines: true)
```

* Still playing?: you can check during the game if it's running.

```ruby
game.still_playing?
```

* Victory?: you can check during the game if you win the game.

```ruby
game.victory?


