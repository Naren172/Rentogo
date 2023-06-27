class IndexController < ApplicationController
    before_action :authenticate_account!
    before_action :is_renter? , only: [:renter]
    before_action :is_owner? , only: [:owner]
    def renter
    end

    def owner
    end

    def user
    end

    private
    def is_renter?
        unless account_signed_in? && current_account.renter?
            if account_signed_in?
                redirect_to owner_path
            else
                redirect_to new_account_session_path
            end
        end
    end

    def is_owner?
        unless account_signed_in? && current_account.user?
            if account_signed_in?
                redirect_to renterindex_path
            else
                redirect_to new_account_session_path
            end
        end
    end
end
