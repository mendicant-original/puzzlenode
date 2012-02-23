class Puzzles::RatingsController < Puzzles::Base
  def create
    options = params[:rating]
    rating = Rating.find_or_initialize_by_user_id_and_puzzle_id(options[:user_id], options[:puzzle_id])
    if rating.update_attributes(options)
      head :ok
    else
      render :json => {:errors => rating.errors.full_messages}, :status => 422
    end
  end
end
