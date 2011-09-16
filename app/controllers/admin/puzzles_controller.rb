module Admin
  class PuzzlesController < ApplicationController
    before_filter :authenticate_admin_user!
  end
end
