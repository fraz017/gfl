class WelcomeController < ApplicationController
	before_action :authenticate_user!
	layout "reports"
  def index
  end
end
