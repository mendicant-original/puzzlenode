class AnnouncementsController < ApplicationController
  respond_to :html

  def index
    @announcements = Announcement.order("created_at DESC")

    respond_with(@announcements) do |format|
      format.html do
        @announcements = @announcements.paginate(:page => params[:page], :per_page => 10)
      end
      format.rss { render :layout => false }
    end
  end

  def show
    @announcement = Announcement.find(params[:id])

    respond_with(@announcement)
  end
end
