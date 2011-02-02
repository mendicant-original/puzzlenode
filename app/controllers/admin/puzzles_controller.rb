class Admin::PuzzlesController < Admin::Base
  before_filter :find_puzzle, :only => [:edit, :update, :destroy]
  
  def index
    @puzzles = Puzzle.all
  end
  
  def new
    @puzzle = Puzzle.new
  end
  
  def create
    @puzzle = Puzzle.new(params[:puzzle])
    
    if @puzzle.save
      flash[:notice] = "Puzzle sucessfully created"
      redirect_to admin_puzzles_path
    else
      render :action => :new
    end
  end
  
  def edit
    
  end
  
  def update
    if @puzzle.update_attributes(params[:puzzle])
      flash[:notice] = "Puzzle sucessfully updated"
      redirect_to admin_puzzles_path
    else
      render :action => :edit
    end
  end
  
  def destroy
    @puzzle.destroy
    
    flash[:notice] = "Puzzle sucessfully destroyed"
    redirect_to admin_puzzles_path
  end
  
  private
  
  def find_puzzle
    @puzzle = Puzzle.find(params[:id])
  end
  
end
