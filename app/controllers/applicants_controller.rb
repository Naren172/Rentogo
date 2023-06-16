class ApplicantsController < ApplicationController
    before_action :authenticate_account!
    before_action :is_renter? , except: [:accept,:reject,:view]
     def new
        @applicant=Applicant.new
        @applicant.status="Applied"
        @account=current_account
        @renter=Renter.find(current_account.accountable_id)
        @applicant.renter_id=@renter.id
        @product=Product.find(params[:id])
        @product.applicants<<@applicant
        @applicant.save
        @product.save
        redirect_to renter_path 
    end


    def show
        @product=Product.find(params[:id])
    end


    def index
        renter=Renter.find(current_account.accountable_id)
        @applicants=Applicant.where(renter_id:renter.id)
    end


    def view       
        @products=Product.find(params[:id])
        @applicants=@products.applicants
        @renter=[]
        @applicants.each do |applicant|
            if(applicant.status!="Rejected")
                @renter<<Renter.find(applicant.renter_id)
            end
        # @applicants=Applicant.where(product_id:product.id)
        end
    end


    def accept
        id=params[:id]
        @applicant=Applicant.find_by(renter_id:params[:id])
        @applicants=Applicant.where(product_id:@applicant.product_id)
        @applicants.each do |app|
            app.status="Rejected"
            app.save
        end
        @applicant.status="Accepted" 
        @applicant.save
        @product=Product.find(@applicant.product_id)
        @product.status="Unavailable"
        redirect_to add_path(productid:@product,renterid:id)

    end


    def reject 
        puts("hii")
        @applicant=Applicant.find_by(renter_id:params[:id])
        @applicant.status="Rejected" 
        @applicant.save
        @product=Product.find(@applicant.product_id)
        redirect_to view_path(@product)
    end

    
    def destroy
        @applicant=Applicant.find(params[:id])
        @applicant.destroy
        redirect_to applications_path

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

end