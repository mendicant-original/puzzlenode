class PuzzlesController < ApplicationController

  def index
    @puzzles = Puzzle.all
  end
  
  def show
    @puzzle = Puzzle.find(params[:id])
  end
end
