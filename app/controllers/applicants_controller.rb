class ApplicantsController < ApplicationController
    before_action :authenticate_account!
    before_action :is_renter? , except: [:accept,:reject,:view]
    before_action :is_owner? , only: [:accept,:reject,:view]
     def new
        applicant=Applicant.new
        applicant.status="Applied"
        account=current_account
        renter=Renter.find_by(id:current_account.accountable_id)
        applicant.renter_id=renter.id
        product=Product.find_by(id:params[:id])
        if product
            product.applicants<<applicant
            applicant.save
            product.save
            redirect_to renter_path 
        else
            redirect_to renterindex_path
        end
    end

    def show
        @product=Product.find_by(id:params[:id])
        if @product
        else
            redirect_to renterindex_path
        end
    end

    def index
        renter=Renter.find_by(id:current_account.accountable_id)
        @applicants=Applicant.where(renter_id:renter.id)
    end

    def view       
        @product=Product.find_by(id:params[:id])
        if @product
            applicants=@product.applicants
            @renter=[]
            applicants.each do |applicant|
                if(applicant.status!="Rejected"&&applicant.status!="Accepted")
                    @renter<<Renter.find_by(id:applicant.renter_id)
                end
            # @applicants=Applicant.where(product_id:product.id)
            end
        else
            redirect_to owner_path
        end
    end

    def accept
        applicant=Applicant.find_by(renter_id:params[:renterid],product_id:params[:productid])
        if applicant
            product=Product.find_by(id:applicant.product_id)
            unless product.user_id==current_account.accountable_id
                redirect_to owner_path
                return
            end
            applicants=Applicant.where(product_id:applicant.product_id)
            applicants.each do |app|
                app.status="Rejected"
                app.save
            end
            applicant.status="Accepted" 
            applicant.save
            product=Product.find_by(id:applicant.product_id)
            product.status="Unavailable"
            redirect_to add_path(productid:product.id,renterid:params[:renterid])
        else
            redirect_to owner_path
        end
    end

    def reject 
        applicant=Applicant.find_by(renter_id:params[:renterid],product_id:params[:productid])
        if applicant
            product=Product.find_by(id:applicant.product_id)
            unless product.user_id==current_account.accountable_id
                redirect_to owner_path
                return
            end
            applicant.status="Rejected" 
            applicant.save
            redirect_to view_path(product)
        else
            redirect_to owner_path
        end
    end

    def destroy
        applicant=Applicant.find_by(id:params[:id])
        if applicant 
            product=Product.find_by(id:applicant.product_id)
            unless applicant.renter_id==current_account.accountable_id
                redirect_to renterindex_path
                return
            end
            applicant.destroy
            redirect_to applications_path
        else
            redirect_to renterindex_path
        end

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