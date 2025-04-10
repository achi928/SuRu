class ApplicationController < ActionController::Base
  # rescue_from StandardError, with: :render500
  # rescue_from ActiveRecord::RecordNotFound, with: :render_404

  private
  # def render_404
  #   render file: "#{Rails.root}/public/404.html", status: :not_found
  # end

  # def render500
  #   render file: "#{Rails.root}/public/500.html", status: :internal_server_error
  # end
end
