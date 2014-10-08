class StatusController < ApplicationController
	def index
		today = DateTime.now.strftime '%Y-%m-%d'
		@projects = Project.where("session_date = ?", today).all
	end
end
