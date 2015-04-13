class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_navbar_comics
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :avatar
    devise_parameter_sanitizer.for(:sign_up) << :first
    devise_parameter_sanitizer.for(:sign_up) << :last
    devise_parameter_sanitizer.for(:account_update) << :avatar
    devise_parameter_sanitizer.for(:account_update) << :first
    devise_parameter_sanitizer.for(:account_update) << :last
  end
  
  def get_navbar_comics
    @navbarComics = Comic.rank(:row_order).all.select { |t| t.navbar }
  end  
  
  def correct_counts
    # grab each chapter
    # count number of pages assigned to that chapter
    # update num_pages
    
    # likewise for comics and num_chapters
    
    # do as before filter for all crud
  end
  
  def check_assign
  
  end
  
  
end
