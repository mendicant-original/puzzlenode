module Admin
  class UsersController < ApplicationController
    before_filter :authenticate_admin_user!
  end
end
