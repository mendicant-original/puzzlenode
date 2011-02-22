class Puzzles::CommentsController < Puzzles::Base
  before_filter :answered_correct_only
  before_filter :find_comment, :only => [:edit, :update, :destroy, :show]
  
  def index
    @comments = @puzzle.comments.paginate(:page => params[:page])
  end
  
  def new
    @comment = @puzzle.comments.new
  end
  
  def create
    params[:comment][:user_id] = current_user.id
    @comment = @puzzle.comments.new(params[:comment])
    
    if @comment.save
      flash[:notice] = "Comment sucessfully created."
      redirect_to puzzle_comments_path(@puzzle)
    else
      render :action => :new
    end
  end
  
  def update
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Comment sucessfully updated."
      redirect_to puzzle_comments_path(@puzzle)
    else
      render :action => :edit
    end
  end
  
  def destroy
    @comment.destroy
    
    flash[:notice] = "Comment sucessfully destroyed."
  end

  private
  
  def answered_correct_only
    unless @puzzle.answered_correctly?(current_user)
      flash[:error] = "You must answer this puzzle correctly before you can access comments"
      redirect_to puzzle_path(@puzzle)
    end
  end
  
  def find_comment
    @comment = Comment.find(params[:comment])
  end
end
