require 'will_paginate/array'
require 'haml'
require 'tilt'

class ApplicationController < ActionController::Base
  protect_from_forgery

  # Handle token authentication for JSON queries
  before_filter :authenticate_via_token
  before_filter :authenticate_admin!

  PER_PAGE = 20

  # Description::
  # Simple token based authentication
  def authenticate_via_token
    if params[:auth_token].present?
      admin = Admin.find_by_authentication_token(params[:auth_token])
      sign_in admin, store: false if admin
    end
  end

  # Description:: 
  # DRY up basic responses
  def _simple_response r_obj, opts = {}
    respond_to do |format|
      format.html
      format.json { 
                    r_obj << { pagination: {
                       current_page: r_obj.current_page,
                       per_page: r_obj.per_page,
                       total_entries: r_obj.total_entries
                    }} if r_obj.respond_to?(:total_entries)

                    render json: r_obj.to_json(opts)
      }
    end
  end

  # Description:: 
  # DRY up destroy responses
  def _destroy_response p_url_array
    respond_to do |format|
      format.html { redirect_to polymorphic_url(p_url_array) }
      format.json { head :no_content }
    end
  end
end
