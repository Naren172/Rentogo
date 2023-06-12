class SessionController < ApplicationController
    def new

    end
    def create
        owner=User.find_by(email:params[:email])
        if owner.present? && owner.authenticate(params[:password])
            session[:owner_id]=owner.id
            redirect_to owner_path, notice: "Logged in successfully"
        else
            flash[:alert] ="Invalid email or password"
            render :new
        end
    end
end
