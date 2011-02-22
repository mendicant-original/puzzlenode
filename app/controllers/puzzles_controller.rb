class PuzzlesController < ApplicationController

  def index
    @puzzles = Puzzle.order("created_at").all
  end
  
  def show
    @puzzle = Puzzle.find(params[:id])
  end
end
