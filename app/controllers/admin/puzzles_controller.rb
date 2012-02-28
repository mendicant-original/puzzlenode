module Admin
  class PuzzlesController < ApplicationController
    before_filter :authenticate_admin_user!
    before_filter :find_puzzle, :only => [:edit, :update, :destroy]

    def index
      @puzzles = Puzzle.order("created_at").
        paginate(:page => params[:page])
    end

    def new
      @puzzle = Puzzle.new
    end

    def create
      @puzzle = Puzzle.new(params[:puzzle])

      if @puzzle.save
        flash[:notice] = "Puzzle sucessfully created"
        redirect_to puzzle_path(@puzzle)
      else
        render :new
      end
    end

    def edit
      @ratings = @puzzle.ratings.count(:group => :difficulty)
    end

    def update
      if @puzzle.update_attributes(params[:puzzle])
        flash[:notice] = "Puzzle sucessfully updated"
        redirect_to puzzle_path(@puzzle)
      else
        render :edit
      end
    end

    def destroy
      @puzzle.destroy

      flash[:notice] = "Puzzle sucessfully destroyed"
      redirect_to admin_puzzles_path
    end

    private

    def find_puzzle
      @puzzle = Puzzle.find_by_slug!(params[:id])
    end
  end
end
