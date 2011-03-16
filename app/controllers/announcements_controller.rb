class AnnouncementsController < ApplicationController
  def index
    @announcements = Announcement.order("created_at DESC")
    
    respond_to do |format|
      format.html do
        @announcements = @announcements.paginate(:page => params[:page], :per_page => 10)
      end
      format.rss { render :layout => false }
    end
  end
  
  def show
    @announcement = Announcement.find(params[:id])
  end
end
