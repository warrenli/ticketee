class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  private

  # Sets the locale for the current request.
  def set_locale
    locale = params[:locale] || session[:locale] ||
             # (current_user.site_language if user_signed_in?) ||
             I18n.default_locale
    locale = AVAILABLE_LOCALES.keys.include?(locale) ? locale : I18n.default_locale
    session[:locale] = I18n.locale = locale
  end

  def authorize_admin!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = t("authenticate.must_admin_msg")
      redirect_to root_path
    end
  end
end
