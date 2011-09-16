module Admin
  class AnnouncementsController < ApplicationController
    before_filter :authenticate_admin_user!
  end
end
