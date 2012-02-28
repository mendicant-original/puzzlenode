class Puzzles::SubmissionsController < Puzzles::Base
  def new
    @submission = @puzzle.submissions.new
  end

  def create
    @submission = @puzzle.submissions.new(params[:submission])

    @submission.user = current_user

    if @submission.save
      redirect_to user_submission_path(current_user, @submission)
    else
      flash.now[:error] = @submission.errors.map { |field, message|
        "#{field.to_s.humanize unless field == :base} #{message}"
      }.join("<br/>").html_safe
      render :action => :new
    end
  end

  def rating
    submission = current_user.submissions.find(params[:id])
    @difficulty = submission.difficulty 
    if @difficulty.update_attributes(:rating => params[:difficulty][:rating])
      flash.now[:notice] = "Thanks for your rating."
    else
      render :json => {:errors => @difficulty.errors.full_messages}, :status => 422
    end
  end
end
