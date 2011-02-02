class PuzzlesController < ApplicationController

  def index
    @puzzles = Puzzle.all
  end
end
