class ApplicationController < ActionController::Base
    def not_found
        raise ActionController::RoutingError.new('Not Found! Are you sure you entered a valid path?')
    end
end
