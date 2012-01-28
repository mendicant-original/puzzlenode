class Puzzles::Base < ApplicationController
  before_filter :find_puzzle
  before_filter :user_required

  private

  def find_puzzle
    @puzzle   = Puzzle.find_by_slug(params[:puzzle_id])
    # TODO Remove legacy Puzzle#id based routes
    @puzzle ||= Puzzle.find(params[:puzzle_id])
  end
end
