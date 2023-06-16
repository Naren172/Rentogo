class IndexController < ApplicationController
    before_action :authenticate_account!
    before_action :is_renter? , except: [:owner]
    before_action :is_owner? , except: [:renter]
    def renter

    end
    def owner

    end
    def user

    end
    private
    def is_renter?
        unless account_signed_in? && current_account.renter?
            flash[:alert] = "Unauthorized action"
            if account_signed_in?
                redirect_to owner_path
            else
                redirect_to new_account_session_path
            end
        end
    end
    private
    def is_owner?
        unless account_signed_in? && current_account.user?
            flash[:alert] = "Unauthorized action"
            if account_signed_in?
                redirect_to renterindex_path
            else
                redirect_to new_account_session_path
            end
        end
    end
end
