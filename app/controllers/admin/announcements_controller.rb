module Admin
  class AnnouncementsController < ApplicationController
    before_filter :authenticate_admin_user!
    before_filter :find_announcement, :only => [:edit, :update, :destroy]

    def index
      @announcements = Announcement.order("created_at").
        paginate(:page => params[:page])
    end

    def new
      @announcement = Announcement.new
    end

    def create
      @announcement = Announcement.new(params[:announcement])

      if @announcement.save
        flash[:notice] = "Announcement sucessfully created"
        redirect_to announcement_path(@announcement)
      else
        render :new
      end
    end

    def edit

    end

    def update
      if @announcement.update_attributes(params[:announcement])
        flash[:notice] = "Announcement sucessfully updated"
        redirect_to announcement_path(@announcement)
      else
        render :edit
      end
    end

    def destroy
      @announcement.destroy

      flash[:notice] = "Announcement sucessfully destroyed"
      redirect_to admin_announcements_path
    end

    private

    def find_announcement
      @announcement = Announcement.find(params[:id])
    end
  end
end
