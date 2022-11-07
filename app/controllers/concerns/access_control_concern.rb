module AccessControlConcern
    extend ActiveSupport::Concern
  
    included do
        before_action :require_login
    end
  
    private

    def require_login
      unless logged_in?
        redirect_to root_url
      end
    end
  end