module Admin
  class UsersController < ApplicationController
    before_filter :authenticate_admin_user!
    before_filter :find_user, :only => [:edit, :update, :destroy]

    def index
      @users = User.order("created_at DESC")

      unless params[:search].blank?
        @users = @users.where(%{name ILIKE :criteria OR nickname ILIKE :criteria
          OR email ILIKE :criteria}, :criteria => "%#{params[:search]}%")
      end

      @users = @users.paginate(:page => params[:page])
    end

    def edit

    end

    def update
      @user.admin = params[:user].delete("admin")
      @user.draft_access = params[:user].delete("draft_access")

      if @user.update_attributes(params[:user])
        flash[:notice] = "User sucessfully updated"
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      @user.destroy

      flash[:notice] = "User sucessfully destroyed"
      redirect_to admin_users_path
    end

    private

    def find_user
      @user = User.find(params[:id])
    end
  end
end
