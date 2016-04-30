class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    send_file "erd.pdf",
      type: "application/pdf",
      file_name: "erd.pdf",
      disposition: "inline"
  end
end
