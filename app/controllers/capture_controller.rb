# Description:
# 
class CaptureController < ApplicationController

	def start
		capture_format params[:format]
		
    		respond_to do |format|
		      format.html # index.html.erb
#		      format.json { render json: @projects }
		end

	end

	def stop

	end


	def status

	end

end
